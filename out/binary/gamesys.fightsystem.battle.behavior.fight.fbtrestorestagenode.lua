


registry_pool_class(fBTNodeTypo.RestoreStage,'fBTRestoreStageNode',fBTBaseNode)

function fBTRestoreStageNode:__init(guid)
self.typo=fBTNodeTypo.RestoreStage
end

function fBTRestoreStageNode:parser(rawData)
self.stateID=rawData[1]
self.fadeInTime=rawData[2]
self.fadeOutTime=rawData[3]
self.wait=rawData[4]
end



function fBTRestoreStageNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTRestoreStageNode:start()

local battle=self.entity:getBattle()
local stageCfg=battle:getStageCfg()
if stageCfg~=nil then
local onFinish=function(abName)
self.state=fBTNodeState.success
end
fightManager.loadStage(stageCfg.assetbundle,onFinish,nil,self.fadeInTime,self.fadeOutTime)
fightManager.initCameraEffect(stageCfg)
fightManager.playSceneEffect(stageCfg)
end

fightManager.setState(self.stateID)
self.isExe=true
if self.wait then
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end


function fBTRestoreStageNode:update(delta)

return self.state
end

function fBTRestoreStageNode:onComplete()
if not self.isExe then
local battle=self.entity:getBattle()
local stageCfg=battle:getStageCfg()
fightManager.loadStage(stageCfg.assetbundle,nil,nil,self.fadeInTime,self.fadeOutTime)
fightManager.setState(self.stateID)
self.state=fBTNodeState.success
end
end


function fBTRestoreStageNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

