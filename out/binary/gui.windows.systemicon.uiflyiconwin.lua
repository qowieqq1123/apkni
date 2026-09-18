







def_class("UIFlyIconWin",UIWindowBase)









function UIFlyIconWin:bindComponents()

self.UIFlyIconWin=UIWindowLua.new(self,0)
self.bg=UIObject.get(self,1)
self.spine=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.target=UIObject.get(self,4)
self.raycast=UIObject.get(self,5)
self.flyPos=UIObject.get(self,6)
self.name=UIText.get(self,7)
self.icon=UIImage.get(self,8)
self.iconNoCanvas=UIImage.get(self,9)



end


function UIFlyIconWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIFlyIconWin:deleteSelf();self.UIFlyIconWin=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.target);self.target=nil;
_UIObject_release(self.raycast);self.raycast=nil;
_UIObject_release(self.flyPos);self.flyPos=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.iconNoCanvas);self.iconNoCanvas=nil;
end


















function UIFlyIconWin:onLoaded(...)
self:bindComponents()
local pos=self:getChildCanvas(-1)
self.defaultSortLayer=pos[1]
self.defaultSortOrder=pos[2]
end

function UIFlyIconWin:__delete()
self:unbindComponents()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
end
self.bt=nil
systemIconFlyControl:beforeDestory(self.guid,self.args)
systemIconFlyControl:finishBehavior(self.guid,self.args)
if self.disableMoneyTips then
self.disableMoneyTips=nil
UIManager.enableMoneyTips(true)
end
end

function UIFlyIconWin:onShow(argtable,afterOnloaded)
if UIManager.isEnableMoneyTips()then
self.disableMoneyTips=true
UIManager.enableMoneyTips(false)
end
systemIconFlyControl:onOpenWin()
local args=argtable.args
local pos=argtable.pos
local icon=args[2]
local name=args[4]or''
local guid=argtable.guid
self.waitDestory=argtable.waitDestory or 0

if argtable.render then
self:setChildCanvas(-1,argtable.render[1],argtable.render[2])
self.render=true
self.icon:setActive(false)
self.iconNoCanvas:setActive(true)
self.iconNoCanvas:setImageIcon(iconHelper.getUnlockIcon(icon),true)
else
self:setChildRemoveCanvas(-1)
self.icon:setActive(true)
self.iconNoCanvas:setActive(false)
self.icon:setImageIcon(iconHelper.getUnlockIcon(icon),true)
end
self.finishCall=argtable.finishCall

self.winlua:SetChildImageRaycast(self.raycast:getID(),true)

if self.bgVisTimer then
self:stopTimerByID(self.bgVisTimer)
end
self.bg:setActive(true)

self.name:setText(name)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),1)
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),1)
self.winlua:SetChildUIModelShowTarget(self.spine:getID(),3046,1,{},2051,false,false,0.5,function()
if not self and self.isClose then return end
self.winlua:SetChildImageRaycast(self.raycast:getID(),false)
end)

if self.targetTimer then
self:stopTimerByID(self.targetTimer)
end

if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
self.delayTimer=nil
self.winlua:SetChildCanvasGroupAlpha(self.target:getID(),0)
if self.tween1 then
self.tween1:Kill()
end
self.targetTimer=self:delayDo(0.5,function()
self.tween1=self.winlua:SetChildCanvasGroupDOFade(self.target:getID(),1,0.5)
end)

if self.raycastTimer then
self:stopTimerByID(self.raycastTimer)
end
self.raycastTimer=self:delayDo(1,function()
self.winlua:SetChildImageRaycast(self.raycast:getID(),false)
end)
local func=function()
self:startFly(args,pos,guid)
end
self.fly=func
end

function UIFlyIconWin:onHide()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
end
self.bt=nil

if self.tween then
self.tween:Rewind()
self.tween:Kill()
end
self.tween=nil
if self.tween1 then
self.tween1:Rewind()
self.tween1:Kill()
end
self.tween1=nil
if self.closetimer then
self:stopTimerByID(self.closetimer)
end
self.closetimer=nil
if self.raycastTimer then
self:stopTimerByID(self.raycastTimer)
end
self.raycastTimer=nil

if self.bgVisTimer then
self:stopTimerByID(self.bgVisTimer)
end
self.bgVisTimer=nil

if self.targetTimer then
self:stopTimerByID(self.targetTimer)
end
self.targetTimer=nil
systemIconFlyControl:beforeDestory(self.guid,self.args)
systemIconFlyControl:finishBehavior(self.guid,self.args)

if self.render then
self:setChildCanvas(-1,self.defaultSortLayer,self.defaultSortOrder)
self:setChildRemoveCanvas(-1)
end
if self.disableMoneyTips then
self.disableMoneyTips=nil
UIManager.enableMoneyTips(true)
end
end




function UIFlyIconWin:onClick()
if self.fly then
self.fly()


if self.bgVisTimer then
self:stopTimerByID(self.bgVisTimer)
end

self.bgVisTimer=self:delayDo(4,function()
self.bg:setActive(false)
end)
end
self.fly=nil
end

function UIFlyIconWin:startFly(args,pos,guid)
if self.tween then
self.tween:Rewind()
self.tween:Kill()
end
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
self.delayTimer=nil

self.winlua:SetChildCanvasGroupAlpha(self.target:getID(),0)
self.args=args
self.guid=guid
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),0)
if pos==nil then
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.closetimer=self:delayDo(0.5,function()
UIManager:hideWindow('UIFlyIconWin')
end)
return
end
self.tween=self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.3)
self.winlua:SetChildCanvasGroupAlpha(self.target:getID(),1)
self.delayTimer=self:delayDo(0.2,function()
self.winlua:SetChildCanvasGroupAlpha(self.target:getID(),0)
end)
local cloneTarget=self.target:getID()
local cloneParent=self.UIFlyIconWin:getID()
local iconType=args[3]
local argsTable={guid,args}
local isMove=iconType~=nil
local stateId=0
local waitDestory=self.waitDestory
local initData=
{
widget=self.winlua,
cloneParent=cloneParent,
cloneTarget=cloneTarget,

endPos=pos,
oSlider=Vector2.New(0,0),
eSlider=Vector2.New(0,0),
rate=0.001,
stateId=stateId,
control='systemIconFlyControl',
beforeDestory='beforeDestory',
finishBehavior='finishBehavior',
args=argsTable,
waitDestory=waitDestory,
effect1=1,
effect2=2,
}

self.bt=behaviorManager:addBehaviorTree('bt_ui_fly_icon',nil,true,initData)
self.bt:setUpdateInterval(0.01)
end

function UIFlyIconWin:finishBehavior(guid,args)

if guid~=self.guid then return end
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
end
self.bt=nil
self.args=nil

end
