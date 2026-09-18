




local stopEffect=CS.GameInterface.StopEffect

def_class('fightShield',fightEntity)


function fightShield:init(_battle,posType,id,baseInfo,outEffectOpen)
fightEntity.init(self,_battle,posType,id,baseInfo,outEffectOpen)

if self.baseInfo.enterBt then
self:setEnterBehavior(self.baseInfo.enterBt)
end

if self.baseInfo.breakBt then
self:setBreakBehavior(self.baseInfo.breakBt)
end
self.shieldObj=nil
self.isShieldExist=self:getAttribute(entityAttr.hp)>0
end

function fightShield:getSheildID()
return self.baseInfo.sheildID or 1
end

function fightShield:getSheildLv()
return self.baseInfo.sheildLv or 1
end

function fightShield:setBreakBehavior(bt)
self.breakBt=bt
end



function fightShield:onShow()
if self.enterBt~=nil then
self:runBehavior(self.enterBt,{},function()
if not self.shieldObj and self.baseInfo.entModel then
self.shieldObj=fightManager.add3DEntity(self.baseInfo.entModel,self.posInfo.pos,Vector3.zero,Vector3.one)
end



end)
self.fBTree:update(0.01)

self.enterBt=nil
else
if not self.shieldObj and self.baseInfo.entModel then

self.shieldObj=fightManager.add3DEntity(self.baseInfo.entModel,self.posInfo.pos,Vector3.zero,Vector3.one)
end



end
end


function fightShield:runBehavior(btName,targets,_onBahaviroEvent)

self:stopBehavior()
self.isRunBehavior=true

local onEventListen=function(eventTypo,args)
self:onBehaviorEvent(eventTypo,args)
end

self.onBahaviroEvent=_onBahaviroEvent

if self.skipMode then
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
else
if self.battle and self.battle.isShowWindow then
self.fBTree:setSharedValue('targets',targets)
self.fBTree:setSharedValue('battle',self.battle)
self.fBTree:start(self,btName,onEventListen)
else
self:createSimBehavior()
end
end
end

function fightShield:onHide()

if self.sheildEffect then
stopEffect(self.sheildEffect)

end

if self.shieldObj then
self.shieldObj:RunAnimator(2,2,nil)
timeEventController.delayDo(0.8,function()
if self.shieldObj then
fightManager.removeEntity(self.shieldObj.GUID)
self.shieldObj=nil
end
end)
end
end

function fightShield:getPosition()
return fightModel:transToBattleWorld(self.position or Vector3.zero)
end

function fightShield:onRecvDamage(value,serverHP)
self:setAttribute(entityAttr.hp,serverHP)
local max=self:getAttribute(entityAttr.max_hp)



self.hud:setHP(serverHP,max,0,0)

if serverHP<=0 then
self:onDead()

return true
end


end

function fightShield:onDead()
self.fBTree:stop()
if self.breakBt then



if self.shieldObj then
fightManager.removeEntity(self.shieldObj.GUID)
self.shieldObj=nil
end
self:runBehavior(self.breakBt,{},function()
self:remove()
end)

else
self:remove()
end
self.isShieldExist=nil
end
