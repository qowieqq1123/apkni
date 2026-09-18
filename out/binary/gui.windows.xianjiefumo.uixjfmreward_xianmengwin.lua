







def_class("UIXJFMReward_XianMengWin",UIWindowBase)









function UIXJFMReward_XianMengWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.list=UIObject.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXJFMReward_XianMengWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.list);self.list=nil;
end
















local _this=nil
local _itemCmp={
rankNo=0,
rewardView=1,
rewardList=2,
}



function UIXJFMReward_XianMengWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXJFMReward_XianMengWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXJFMReward_XianMengWin:onShow(argtable,afterOnloaded)
self:updateView()
end


function UIXJFMReward_XianMengWin:onHide()

end




function UIXJFMReward_XianMengWin:onCloseBtn()
self:closeSelf()
end

function UIXJFMReward_XianMengWin:updateView()
local infos=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"rank_guild_reward")
if infos then
self.list:setChildLayoutGroupCreateItems(#infos,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=infos[index]
local mixRank=data[1]
local maxRank=data[2]
local rewards=data[3]
if mixRank==maxRank then
item:SetChildText(_itemCmp.rankNo,FMT.fmt("第{0}名",mixRank))
else
item:SetChildText(_itemCmp.rankNo,FMT.fmt("第{0}~{1}名",mixRank,maxRank))
end
local rewardCnt=#rewards
item:SetChildScrollRectEnable(_itemCmp.rewardView,rewardCnt>10)
item:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,rewardCnt,function(index)
local itemReward=item:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemReward:SetChildPropData(0,prop)
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
end)
else

end
end




function UIXJFMReward_XianMengWin:onCloseBtn()
end

