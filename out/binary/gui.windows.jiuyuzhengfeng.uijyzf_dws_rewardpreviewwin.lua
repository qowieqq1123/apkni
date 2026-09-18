







def_class("UIJYZF_DWS_RewardPreviewWin",UIWindowBase)









function UIJYZF_DWS_RewardPreviewWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.rankReawrdScrollView=UILoopListView.new(self,1)
self.curRank=UIText.get(self,2)
self.upTips=UIText.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankReawrdScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJYZF_DWS_RewardPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rankReawrdScrollView:deleteSelf();self.rankReawrdScrollView=nil;
_UIObject_release(self.curRank);self.curRank=nil;
_UIObject_release(self.upTips);self.upTips=nil;
end















local rankReawrdItemCmp={
bg=0,
rank=1,
rewardLayout=2,
selfFlag=3,
}



function UIJYZF_DWS_RewardPreviewWin:onLoaded(...)
self:bindComponents()
end


function UIJYZF_DWS_RewardPreviewWin:__delete()
self:unbindComponents()
end




function UIJYZF_DWS_RewardPreviewWin:onShow(argtable,afterOnloaded)
local baseCfg=cfg_xianyulevelbasicconfig_get(1)
local rank_reward=baseCfg.first_rank_reward
local myRankInfo=JiuYuZhengFengModel:getData_myRankInfo()
local uptipsStr=""
if myRankInfo then
local rank=myRankInfo.rank
self.curRank:setText(FMT.fmt("当前排名：<color=#549327>第{0}名</color>",rank))
for i,v in ipairs(rank_reward)do
if rank>=v[1]and rank<=v[2]then
self.rankRewardIndex=i
break
end
end
local lastRewardIndex=self.rankRewardIndex-1
local lastRank
if rank_reward[lastRewardIndex]then
lastRank=rank_reward[lastRewardIndex][2]
local rankList=JiuYuZhengFengModel:getData_rankList()
if rankList then
local lastdata=rankList[lastRank]
local mydata=rankList[rank]
if lastdata and mydata then
local left=lastdata.param_2-mydata.param_2
uptipsStr=FMT.fmt("再获得<color=#BF520E>{0}积分名次</color>可提升到下一奖励档次",left)
end
end
end
else
self.curRank:setText("当前排名：未上榜")
end
self.upTips:setText(uptipsStr)
self.rankReawrdScrollView:refreshAllItems()
self.rankReawrdScrollView:initData("rankReawrdItem",rank_reward,#rank_reward)
end


function UIJYZF_DWS_RewardPreviewWin:onHide()

end

function UIJYZF_DWS_RewardPreviewWin:onFreshAction(index,widget,data)

local min=data[1]
local max=data[2]
local itemList=data[3]
local rankStr=min==max and FMT.fmt("第{0}名",min)or FMT.fmt("第{0}~{1}名",min,max)
widget:SetChildText(rankReawrdItemCmp.rank,rankStr)
widget:SetChildActive(rankReawrdItemCmp.selfFlag,index==self.rankRewardIndex)
widget:SetChildLayoutGroupCreateItems(rankReawrdItemCmp.rewardLayout,#itemList,function(index)
local item=widget:GetChildLayoutGroupGridItem(rankReawrdItemCmp.rewardLayout,index-1)
local rewardData=itemList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end


function UIJYZF_DWS_RewardPreviewWin:onStartAction()
end





function UIJYZF_DWS_RewardPreviewWin:onCloseBtn()
self:closeSelf()
end
