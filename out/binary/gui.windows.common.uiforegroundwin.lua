







def_class("UIForeGroundWin",UIWindowBase)









function UIForeGroundWin:bindComponents()

self.foureground=UIObject.get(self,0)
self.AI=UIObject.get(self,1)
self.bird1=UIObject.get(self,2)
self.bird2=UIObject.get(self,3)



end


function UIForeGroundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.foureground);
self.foureground=nil;
_UIObject_release(self.AI);
self.AI=nil;
_UIObject_release(self.bird1);
self.bird1=nil;
_UIObject_release(self.bird2);
self.bird2=nil;
end



















function UIForeGroundWin:onLoaded(...)
self:bindComponents()
self.AI:setActive(false)
self:initAI()
end


function UIForeGroundWin:__delete()
self:removeAllBehaviorTree()

self:unbindComponents()
end




function UIForeGroundWin:onShow(argtable,afterOnloaded)
if not self.isPlay then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.foureground:getID(),'',0,2)
end
self.isPlay=true
self.skinType=argtable
self:resetAIState(false)
self:resetAIData(self.skinType)
end


function UIForeGroundWin:onHide()
self.isPlay=false
self:resetAIState(true)
end




function UIForeGroundWin:initAI()
self.bird1:setChildUIModelShowTarget(2004,1,nil,eAnimationID.fly)
local data1={
UIstateId=0,
nestPos={-620,430},
}
local bt=self:createBehaviour('bt_ui_bird',self.bird1:getID(),data1)
self.bird1.bt=bt

self.bird2:setChildUIModelShowTarget(2004,1,nil,eAnimationID.fly)
local data2={
UIstateId=0,
nestPos={620,430},
}
local bt=self:createBehaviour('bt_ui_bird',self.bird2:getID(),data2)
self.bird2.bt=bt

local data={
UIstateId=0,
}
local bt=self:createBehaviour('bt_ui_siren',self.AI:getID(),data)
self.AI.bt=bt
end

function UIForeGroundWin:createBehaviour(fName,compIndex,data)
local initData={
widget=self.winlua,
compIndex=compIndex,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fName,nil,true,initData)
return bt
end

function UIForeGroundWin:removeAllBehaviorTree()
behaviorManager:removeBehaviorTree(self.bird1.bt)
behaviorManager:removeBehaviorTree(self.bird2.bt)
behaviorManager:removeBehaviorTree(self.AI.bt)
end

function UIForeGroundWin:resetAIState(sleep)
if sleep then
local trans1=self.bird1:getTransform()
trans1.localPosition=Vector3(-620,430,0)
local trans2=self.bird2:getTransform()
trans2.localPosition=Vector3(620,430,0)
end
local bird1Bt=self.bird1.bt
local bird2Bt=self.bird2.bt
bird1Bt:setSharedVar(behaviorConfig.uiStateIdKey,0)
bird1Bt:reset()
bird1Bt:tick(0.5)
bird2Bt:setSharedVar(behaviorConfig.uiStateIdKey,0)
bird2Bt:reset()
bird2Bt:tick(0.5)

self.AI.bt:setSharedVar(behaviorConfig.uiStateIdKey,sleep and 0 or 5)
end

function UIForeGroundWin:resetAIData(skinType)

local targetPos1={-30,-325}
local targetPos2={30,-335}
local siRenAIPos=Vector3(0,-305,0)

if skinType==fullScreenSkinType.eSkin1 then
targetPos1={80,-330}
targetPos2={140,-340}
siRenAIPos=Vector3(110,-305,0)
elseif skinType==fullScreenSkinType.eSkin4 then
targetPos1={320,215}
targetPos2={390,208}
siRenAIPos=Vector3(350,220,0)
end
local bird1Bt=self.bird1.bt
local bird2Bt=self.bird2.bt
bird1Bt:setSharedVar('targetPos',targetPos1)
bird1Bt:reset()
bird1Bt:tick(0.5)
bird2Bt:setSharedVar('targetPos',targetPos2)
bird2Bt:reset()
bird2Bt:tick(0.5)

local trans=self.AI:getTransform()
trans.localPosition=siRenAIPos
end

function UIForeGroundWin:onClickSiren()
local uistate=self.bird1.bt:getSharedVar(behaviorConfig.uiStateIdKey)
if uistate==3 then
self.AI.bt:setSharedVar(behaviorConfig.uiStateIdKey,3)
self.AI.bt:reset()
self.AI.bt:tick(0.5)
end
end

function UIForeGroundWin:setBirdShareVal()

self.AI:setActive(false)
local bird1Bt=self.bird1.bt
local bird2Bt=self.bird2.bt
bird1Bt:setSharedVar('UIstateId',4)
bird1Bt:reset()
bird1Bt:tick(0.5)
bird2Bt:setSharedVar('UIstateId',4)
bird2Bt:reset()
bird2Bt:tick(0.5)
end

function UIForeGroundWin:setBirdShareVal0()

local bird1Bt=self.bird1.bt
local bird2Bt=self.bird2.bt
bird1Bt:setSharedVar('UIstateId',1)
bird1Bt:reset()
bird1Bt:tick(0.5)
bird2Bt:setSharedVar('UIstateId',1)
bird2Bt:reset()
bird2Bt:tick(0.5)
self.AI:setActive(true)
end
