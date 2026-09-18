







def_class("UIHaoPingYouLiWin",UIWindowBase)









function UIHaoPingYouLiWin:bindComponents()

self.btnJump=UIButton.get(self,0)
self.btnReceive=UIButton.get(self,1)
self.rewardContent=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.btnJump:setButtonClick(function()self:onBtnJump()end)

self.btnReceive:setButtonClick(function()self:onBtnReceive()end)



end


function UIHaoPingYouLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnJump);self.btnJump=nil;
_UIObject_release(self.btnReceive);self.btnReceive=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIHaoPingYouLiWin:onLoaded(...)
self:bindComponents()
end


function UIHaoPingYouLiWin:__delete()
self:unbindComponents()
end




function UIHaoPingYouLiWin:onShow(argtable,afterOnloaded)
self:refreshBtnState()
self:refreshRewardPanel()
end

function UIHaoPingYouLiWin:refreshBtnState()
local haoPingGiftId=pfwindowslController:getHaoPingGiftId()
local flag=FreeGiftController.GetFreeGift(haoPingGiftId)
local haoPing=userActorSetting.get("haoPingYouLi",0)
self.btnJump:setActive(haoPing==1 and flag)
self.btnReceive:setActive(haoPing==2 and flag)
end

function UIHaoPingYouLiWin:refreshRewardPanel()
local haoPingGiftId=pfwindowslController:getHaoPingGiftId()
local rewardList=cfgHelper.get2(cfg_freegiftconfig_get,haoPingGiftId,"rewards")
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])







item:SetChildIcon(0,iconHelper.getIconName(itemId),false)
item:SetChildButtonClick(0,function()
itemsComponentHelper.onItemClickEx(itemId)
end)
item:SetChildText(1,string.format("%s<color=#549327>x%d</color>",itemsModel.getName(itemId),itemNum))
end)
end



local AndroidURL="https://play.google.com/store/apps/details?id=com.mover.twzqzs"
function UIHaoPingYouLiWin:onBtnJump()
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

function UIHaoPingYouLiWin:onBtnReceive()
pfwindowslController:receiveHaoPingReward()
end

