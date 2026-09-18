







def_class("UI_UwpHaoPingWin",UIWindowBase)









function UI_UwpHaoPingWin:bindComponents()

self.goto=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.rewardContent=UIObject.get(self,2)

self.goto:setButtonClick(function()self:onGoto()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UI_UwpHaoPingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.goto);self.goto=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
end



















function UI_UwpHaoPingWin:onLoaded(...)
self:bindComponents()
end


function UI_UwpHaoPingWin:__delete()
self:unbindComponents()
end




function UI_UwpHaoPingWin:onShow(argtable,afterOnloaded)
self:refreshRewardPanel()

end


function UI_UwpHaoPingWin:onHide()

end





function UI_UwpHaoPingWin:onGoto()
platformSDK:invoke("reqShowRatingReview")
end



function UI_UwpHaoPingWin:onBtnClose()
self:closeSelf()
end

function UI_UwpHaoPingWin:refreshRewardPanel()
local giftId=pfwindowslController:getUwpHaoPingGiftIdGiftId()
local rewardList=cfgHelper.get2(cfg_freegiftconfig_get,giftId,"rewards")
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
end
