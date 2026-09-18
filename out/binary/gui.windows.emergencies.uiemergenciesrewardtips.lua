







def_class("UIEmergenciesRewardTips",UIWindowBase)









function UIEmergenciesRewardTips:bindComponents()

self.background=UIButton.get(self,0)
self.model=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.rewardList=UIObject.get(self,3)
self.rewardTitle=UIText.get(self,4)
self.closeTips=UIText.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIEmergenciesRewardTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardTitle);self.rewardTitle=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
end



















function UIEmergenciesRewardTips:onLoaded(...)
self:bindComponents()
end


function UIEmergenciesRewardTips:__delete()
self:unbindComponents()
end




function UIEmergenciesRewardTips:onShow(argtable,afterOnloaded)
local model=argtable.model
local title=argtable.title or"奖励"
local tips=argtable.tips or""
local closeTips=argtable.closeTips or"点击空白区域关闭"
local rewards=argtable.rewards
self.model:setChildUIModelShowTarget(model.body,model.scale or 1,model.componets or{},model.animation or 0,false,false,0)
if model.offset then
self.model:setChildUIModelShowTargetOffset(model.offset[1],model.offset[2])
end
self.rewardTitle:setText(title)
self.tips:setText(tips)
self.closeTips:setText(closeTips)
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClick(...)end)
rewardItem:SetChildPropData(0,prop)
end)
end


function UIEmergenciesRewardTips:onHide()

end




function UIEmergenciesRewardTips:onBackground()
self:closeSelf()
end

