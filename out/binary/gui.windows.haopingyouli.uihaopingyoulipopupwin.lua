







def_class("UIHaoPingYouLiPopupWin",UIWindowBase)









function UIHaoPingYouLiPopupWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.btnJump=UIButton.get(self,1)
self.btnReceive=UIButton.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardScrollView=UIObject.get(self,4)
self.root=UIObject.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnJump:setButtonClick(function()self:onBtnJump()end)

self.btnReceive:setButtonClick(function()self:onBtnReceive()end)



end


function UIHaoPingYouLiPopupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnJump);self.btnJump=nil;
_UIObject_release(self.btnReceive);self.btnReceive=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIHaoPingYouLiPopupWin:onLoaded(...)
self:bindComponents()
end


function UIHaoPingYouLiPopupWin:__delete()
self:unbindComponents()
end




function UIHaoPingYouLiPopupWin:onShow(argtable,afterOnloaded)
self:refreshBtnState()
self:refreshRewardPanel()
end

function UIHaoPingYouLiPopupWin:refreshBtnState()
local haoPingGiftId=pfwindowslController:getHaoPingGiftId()
local flag=FreeGiftController.GetFreeGift(haoPingGiftId)
local haoPing=userActorSetting.get("haoPingYouLi",0)
self.btnJump:setActive(haoPing==1 and flag)
self.btnReceive:setActive(haoPing==2 and flag)
end

function UIHaoPingYouLiPopupWin:refreshRewardPanel()
local haoPingGiftId=pfwindowslController:getHaoPingGiftId()
local rewardList=cfgHelper.get2(cfg_freegiftconfig_get,haoPingGiftId,"rewards")
local len=#rewardList
self.rewardContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])







item:SetChildIcon(0,iconHelper.getIconName(itemId),false)
item:SetChildButtonClick(0,function()
itemsComponentHelper.onItemClickEx(itemId)
end)
local name=itemsModel.getName(itemId)
local countStr=string.format("x%d",itemNum)
item:SetChildText(1,FMT.fmt("{0}<color=#549327>{1}</color>",name,countStr))


end)

local max=math.min(len,2)
self.rewardScrollView:setChildSizeDelta(max*252-82,200)
self.rewardScrollView:setChildScrollRectEnable(len>2)
end



function UIHaoPingYouLiPopupWin:onBtnClose()
self:closeSelf()
end

local AndroidURL="https://play.google.com/store/apps/details?id=com.mover.twzqzs"
function UIHaoPingYouLiPopupWin:onBtnJump()
if pfwindowslController:checkIsGameVersion_yuenan()then
platformSDK:invoke("reqGooglePlay")
else
if deviceHelper.isRunIOS()then
platformSDK:invoke("reqPingLun")
return
end
LuaApplication.GetApplication().OpenURL(AndroidURL)
timeEventController.delayDo(1,function()
userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.eClickURL)
userActorSetting.flush()
UIManager:invokeUIMethod("UIHaoPingYouLiWin","refreshBtnState")
UIManager:invokeUIMethod("UIHaoPingYouLiPopupWin","refreshBtnState")
pfwindowslController:receiveHaoPingReward()
end)
end

end

function UIHaoPingYouLiPopupWin:onBtnReceive()
pfwindowslController:receiveHaoPingReward()
end

