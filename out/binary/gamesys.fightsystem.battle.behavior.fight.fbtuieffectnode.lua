


registry_pool_class(fBTNodeTypo.UIEffect,'fBTUIEffectNode',fBTBaseNode)

function fBTUIEffectNode:__init(guid)
self.typo=fBTNodeTypo.UIEffect
end

function fBTUIEffectNode:parser(rawData)
self.effectID=rawData[1]
self.offset=fBTHelper.vector3(rawData,2)
self.scale=fBTHelper.vector3(rawData,5)
self.delayTime=rawData[8]
self.removeOnComplete=rawData[9]
end



local stopEffect=CS.GameInterface.StopEffect
function fBTUIEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTUIEffectNode:start()

self.state=fBTNodeState.running
end


function fBTUIEffectNode:update(delta)

self.delayTime=self.delayTime-delta
if self.delayTime<=0 then
self:play()
end
return self.state
end

function fBTUIEffectNode:play()




local effectLife=cfgHelper.get(cfg_effectconfig_get,self.effectID,"lifetime")


if self.entity~=nil and self.entity.battle~=nil then
self.battle=self.entity.battle
if self.battle.isShowWindow then
self.handle=fightManager.playCameraEffect(self.effectID,self.offset,self.entity:getFlipX(),self.scale)
self.battle.effectHandleList[self.handle]=self.handle
end
else
self.handle=fightManager.playCameraEffect(self.effectID,self.offset,self.entity:getFlipX(),self.scale)
end
local resumeFunc=function()
if self.battle then

end
end
fightManager.disableScreenEffect()
if effectLife then
local life=effectLife/1000
timeEventController.delayDo(life,resumeFunc)
else
timeEventController.delayDo(5,resumeFunc)
end
self.state=fBTNodeState.success
end


function fBTUIEffectNode:onDespawn()
if self.removeOnComplete and self.handle then

stopEffect(self.handle)
if self.battle~=nil then
self.battle.effectHandleList[self.handle]=nil
fightManager.initCameraEffect(self.battle.stageCfg)
end
end
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

