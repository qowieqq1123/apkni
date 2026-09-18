







def_class("UIWorldBigBossActivityRewardWin",UIWindowBase)









function UIWorldBigBossActivityRewardWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.list=UIObject.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWorldBigBossActivityRewardWin:unbindComponents()
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



function UIWorldBigBossActivityRewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldBigBossActivityRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWorldBigBossActivityRewardWin:onShow(argtable,afterOnloaded)
if argtable and self.stageIdx~=argtable.stageIdx then
self.stageIdx=argtable.stageIdx
self:updateView()
end
end


function UIWorldBigBossActivityRewardWin:onHide()

end




function UIWorldBigBossActivityRewardWin:onCloseBtn()
self:closeSelf()
end

function UIWorldBigBossActivityRewardWin:updateView()

local cfg=cfgHelper.get1(cfg_worldbosslevelconfig_get,self.stageIdx)
if cfg then
local infos=cfg['3']
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
