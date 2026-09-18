







def_class("UIJYZF_RewardPreviewWin",UIWindowBase)









function UIJYZF_RewardPreviewWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.tabContent=UIObject.get(self,1)
self.stageRewardRoot=UIObject.get(self,2)
self.stageRewardLayout=UIObject.get(self,3)
self.rankReawrdScrollView=UILoopListView.new(self,4)
self.model=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankReawrdScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJYZF_RewardPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tabContent);self.tabContent=nil;
_UIObject_release(self.stageRewardRoot);self.stageRewardRoot=nil;
_UIObject_release(self.stageRewardLayout);self.stageRewardLayout=nil;
self.rankReawrdScrollView:deleteSelf();self.rankReawrdScrollView=nil;
_UIObject_release(self.model);self.model=nil;
end















local tabItemCmp={
select=0,
Bg=1,
name=2,
}

local rankReawrdItemCmp={
bg=0,
rank=1,
rewardLayout=2,
}



function UIJYZF_RewardPreviewWin:onLoaded(...)
self:bindComponents()
local cfg=cfg_xianyulevelcconfig()
self.cfg=cfg
self.tabContent:setChildLayoutGroupCreateItems(#cfg,function(index)
local item=self.tabContent:getChildLayoutGroupGridItem(index-1)
local data=cfg[#cfg-index+1]
local name=data.name
item:SetChildText(tabItemCmp.name,name)
item:SetChildActive(tabItemCmp.select,false)
item:SetChildButtonClick(tabItemCmp.Bg,function()
self:onTabClick(index)
end)
end)
end


function UIJYZF_RewardPreviewWin:__delete()
self:unbindComponents()
end




function UIJYZF_RewardPreviewWin:onShow(argtable,afterOnloaded)
local tabIndex=argtable and argtable.tabIndex or 1
self:onTabClick(tabIndex)
end


function UIJYZF_RewardPreviewWin:onHide()

end

function UIJYZF_RewardPreviewWin:refresh()
local stageCfg=self.cfg[#self.cfg-self.tabIndex+1]

local list=stageCfg.level_reward
self.stageRewardLayout:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.stageRewardLayout:getChildLayoutGroupGridItem(index-1)
local rewardData=list[index]
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
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,true)
end

self.model:setChildUIModelShowTarget(stageCfg.model,1,nil,eAnimationID.stand)


local rank_reward=stageCfg.rank_reward
self.rankReawrdScrollView:refreshAllItems()
self.rankReawrdScrollView:initData("rankReawrdItem",rank_reward,#rank_reward)

end


function UIJYZF_RewardPreviewWin:onFreshAction(index,widget,data)

local min=data[1]
local max=data[2]
local itemList=data[3]
local rankStr=min==max and FMT.fmt("第{0}名",min)or FMT.fmt("第{0}~{1}名",min,max)
widget:SetChildText(rankReawrdItemCmp.rank,rankStr)

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


function UIJYZF_RewardPreviewWin:onStartAction()
end





function UIJYZF_RewardPreviewWin:onCloseBtn()
self:closeSelf()
end

function UIJYZF_RewardPreviewWin:onTabClick(index)
if self.tabIndex and self.tabIndex==index then
return
end
local oldIndex=self.tabIndex
self.tabIndex=index
if oldIndex then
local olditem=self.tabContent:getChildLayoutGroupGridItem(oldIndex-1)
olditem:SetChildActive(tabItemCmp.select,false)
end
local newitem=self.tabContent:getChildLayoutGroupGridItem(index-1)
newitem:SetChildActive(tabItemCmp.select,true)
self:refresh()
end
