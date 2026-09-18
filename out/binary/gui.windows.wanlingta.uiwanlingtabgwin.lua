







def_class("UIWanLingTaBgWin",UIWindowBase)









function UIWanLingTaBgWin:bindComponents()

self.bgFogSpine=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.collectRewardBtn=UIButton.get(self,3)
self.collectRewardReddot=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.showcase_1=UIObject.get(self,6)
self.showcase_2=UIObject.get(self,7)
self.showcase_3=UIObject.get(self,8)
self.showcase_4=UIObject.get(self,9)
self.showcase_5=UIObject.get(self,10)
self.taLing=UIObject.get(self,11)
self.taLingBtn=UIButton.get(self,12)
self.uiRoot=UIObject.get(self,13)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.collectRewardBtn:setButtonClick(function()self:onCollectRewardBtn()end)

self.taLingBtn:setButtonClick(function()self:onTaLingBtn()end)
self.showcase={
self.showcase_1,
self.showcase_2,
self.showcase_3,
self.showcase_4,
self.showcase_5,
}



end


function UIWanLingTaBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgFogSpine);self.bgFogSpine=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.collectRewardBtn);self.collectRewardBtn=nil;
_UIObject_release(self.collectRewardReddot);self.collectRewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showcase_1);self.showcase_1=nil;
_UIObject_release(self.showcase_2);self.showcase_2=nil;
_UIObject_release(self.showcase_3);self.showcase_3=nil;
_UIObject_release(self.showcase_4);self.showcase_4=nil;
_UIObject_release(self.showcase_5);self.showcase_5=nil;
_UIObject_release(self.taLing);self.taLing=nil;
_UIObject_release(self.taLingBtn);self.taLingBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.showcase=nil;
end


















local this

function UIWanLingTaBgWin:onLoaded(...)
self:bindComponents()
self.showcaseId=eWanLingTaShowcaseType.eZMBW
this=self
self:addNotify(notifyConfig.onWanLingTaCollectRewardReceive,self.onWanLingTaCollectRewardReceive)
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTaBgWin:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTaBgWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
if argtable.showcaseId then
self.showcaseId=argtable.showcaseId
end
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgSpine:getID(),true,true,true)
end
if afterOnloaded and not argtable.jumpWin then
self.bgSpine:setChildUIModelShowTarget(5776,1,{},eAnimationID.common_window_enter2_,false,false,0)
self.uiRoot:setChildAnchoredPos(0,-800)
self.bgFogSpine:setChildUIModelShowTarget(6256,1,{},2111,false,false,0)
argtable.showAnim=true
else
self.bgSpine:setChildUIModelShowTarget(5776,1,{},eAnimationID.stand2,false,false,0)
self.taLing:setChildUIModelShowTarget(1114008,0.3,{},eAnimationID.stand,false,false,0.6)
end

self:refreshShowcaseMenu(true)
self:openShowcaseWin(argtable)
self:refreshCollectReddot()
end

function UIWanLingTaBgWin:moveAnim()
local tween=self.uiRoot:setChildDOAnchorPosY(0,2,function()
self.taLing:setChildUIModelShowTarget(1114008,0.3,{},eAnimationID.stand,false,false,0.6)
end)
tween:SetEase(_Ease.Linear)
end

function UIWanLingTaBgWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIWanLingTaBgWin.onWanLingTaCollectRewardReceive(sjId)
this:refreshCollectReddot()
this:refreshShowcaseMenuReddot()
end

function UIWanLingTaBgWin.onWanLingTaTuJianChange(tjId,tjLevel)
this:refreshCollectReddot()
this:refreshShowcaseMenuReddot()
end

function UIWanLingTaBgWin:refreshShowcaseMenu(init)
for id,v in ipairs(self.showcase)do
local widget=v:getWidgetBase()
widget:SetChildButtonClick(0,function()
self:onClickShowcase(id)
end)

local anim=self.showcaseId==id and eAnimationID.stand2 or eAnimationID.stand
if init then
widget:SetChildUIModelShowTarget(4,6257,1,{},anim,false,false,0)
else
widget:SetChildModelAnimationState(4,anim)
end
end
self:refreshShowcaseMenuReddot()
end

function UIWanLingTaBgWin:refreshShowcaseMenuReddot()
for id,v in ipairs(self.showcase)do
local widget=v:getWidgetBase()
local reddot=wanLingTaModel:checkTypeCollectTargetReddot(id)or wanLingTaModel:checkTypeTuJianReddot(id)
widget:SetChildActive(3,reddot)
end
end

function UIWanLingTaBgWin:refreshCollectReddot()
local reddot=wanLingTaModel:checkTypeCollectTargetReddot(self.showcaseId)
self.collectRewardReddot:setActive(reddot)
end

function UIWanLingTaBgWin:onClickShowcase(id)
if self.showcaseId==id then
return
end
local widget=self.showcase[self.showcaseId]:getWidgetBase()

widget:SetChildModelAnimationState(4,eAnimationID.wlt_close)
self.showcaseId=id
widget=self.showcase[self.showcaseId]:getWidgetBase()

widget:SetChildModelAnimationState(4,eAnimationID.wlt_open)
self:openShowcaseWin()
self:refreshCollectReddot()
end

function UIWanLingTaBgWin:openShowcaseWin(attach)
self:hideAllWindow()
if self.showcaseId==eWanLingTaShowcaseType.eZMBW then
self:showWindow("UIWanLingTa_ZMBW",attach)
elseif self.showcaseId==eWanLingTaShowcaseType.eTCDB then
self:showWindow("UIWanLingTa_TCDB",attach)
elseif self.showcaseId==eWanLingTaShowcaseType.eXYHL then
self:showWindow("UIWanLingTa_XYHL",attach)
elseif self.showcaseId==eWanLingTaShowcaseType.eTDLX then
self:showWindow("UIWanLingTa_TDLX",attach)
elseif self.showcaseId==eWanLingTaShowcaseType.eSBLQ then
self:showWindow("UIWanLingTa_SBLQ",attach)
end
end

function UIWanLingTaBgWin:onTaLingBtn()

self:closeSelf()
end

function UIWanLingTaBgWin:onCollectRewardBtn()
self:showWindow("UIWanLingTaCollectWin",{type=self.showcaseId})
end

function UIWanLingTaBgWin:onCancelButton()


self:closeSelf()
end