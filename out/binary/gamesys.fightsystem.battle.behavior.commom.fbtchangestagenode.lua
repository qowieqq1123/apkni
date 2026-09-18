


registry_pool_class(fBTNodeTypo.ChangeStage,'fBTChangeStageNode',fBTBaseNode)

function fBTChangeStageNode:__init(guid)
self.typo=fBTNodeTypo.ChangeStage
end

function fBTChangeStageNode:parser(rawData)
self.stageID=rawData[1]
self.stateID=rawData[2]
self.fadeInTime=rawData[3]
self.fadeOutTime=rawData[4]
self.wait=rawData[5]
end



function fBTChangeStageNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

end


function fBTChangeStageNode:start()


local stageCfg=fightModel:getStage(self.stageID)
if stageCfg~=nil then
local onFinish=function(abName)
self.state=fBTNodeState.success

end
fightManager.loadStage(stageCfg.assetbundle,onFinish,nil,self.fadeInTime,self.fadeOutTime)
fightManager.initCameraEffect(stageCfg)
fightManager.playSceneEffect(stageCfg)
end

fightManager.setState(self.stateID)
if self.wait then
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end

function fBTChangeStageNode:update(delta)

return self.state
end


function fBTChangeStageNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

