







def_class("UIWDCQSecondMCWin",UIWindowBase)









function UIWDCQSecondMCWin:bindComponents()

self.dropDownRoot=UIObject.get(self,0)
self.keyRoot=UIObject.get(self,1)
self.rankInfoSCrollView=UIScrollView.get(self,2)
self.Root=UIObject.get(self,3)
self.tip=UIText.get(self,4)



end


function UIWDCQSecondMCWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dropDownRoot);self.dropDownRoot=nil;
_UIObject_release(self.keyRoot);self.keyRoot=nil;
_UIObject_release(self.rankInfoSCrollView);self.rankInfoSCrollView=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tip);self.tip=nil;
end
















local rankIconResInfo={
[1]={icon="imge_lundaopm_1"},
[2]={icon="imge_lundaopm_2"},
[3]={icon="imge_lundaopm_3"},
[4]={icon="image_ldjswz_1"},
[5]={icon="image_ldjswz_2"},
[6]={icon="image_ldjswz_3"},
[7]={icon="image_ldjswz_4"},
}

local CmpRankRewardInfoSlotIndex={
icon=0,
grRewardList=1,
qfRewardList=2,
}




function UIWDCQSecondMCWin:onLoaded(...)
self:bindComponents()

local bindWidget=function(...)self:bindRankWidget(...)end
self.rankInfoSCrollView:bindScrollWidget(bindWidget)
end


function UIWDCQSecondMCWin:__delete()
self:unbindComponents()
end




function UIWDCQSecondMCWin:onShow(argtable,afterOnloaded)

self:refreshAll()

end


function UIWDCQSecondMCWin:onHide()

end



function UIWDCQSecondMCWin:refreshAll()

self:refreshDropDown()

self:refreshGroupInfo()

self:refreshRewardInfo()
end

function UIWDCQSecondMCWin:refreshGroupInfo()

end

function UIWDCQSecondMCWin:refreshRewardInfo()
self.infoList=cfgHelper.get1(cfg_wendingcangqiongrankconfig_get,self.selectGroup)

local len=#self.infoList

self.rankInfoSCrollView:freshGridsNum(len,len,1)
end

function UIWDCQSecondMCWin:bindRankWidget(index,item)
local data=self.infoList[index]

local iconInfo=rankIconResInfo[data.rank_idx]
item:SetChildCSImageSprite(CmpRankRewardInfoSlotIndex.icon,globalABLookup.lundaodahui,iconInfo.icon)


local rewards={}
local head_portrait=data.head_portrait
if head_portrait then
rewards=table.weakCopy(data.rewards)
for k,itemid in ipairs(head_portrait)do
rewards[#rewards+1]={itemid,1}
end
else
rewards=data.rewards
end
local grRewardLen=#rewards
local grCreateFunc=function(grIndex)
local rdata=rewards[grIndex]
local itemid=rdata[1]
local itemcount=rdata[2]
local showCountBG=itemcount>1
local countStr=showCountBG and itemcount or""

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local ritem=item:GetChildLayoutGroupGridItem(CmpRankRewardInfoSlotIndex.grRewardList,grIndex-1)
ritem:SetChildPropData(-1,propData)

ritem:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemid)
end)
end
item:SetChildLayoutGroupCreateItems(CmpRankRewardInfoSlotIndex.grRewardList,grRewardLen,grCreateFunc)

local isShowQfReward=data.server_rewards~=nil
item:SetChildActive(CmpRankRewardInfoSlotIndex.qfRewardList,isShowQfReward)
if isShowQfReward then
local qfRewardLen=#data.server_rewards
local qfCreateFunc=function(qfIndex)
local rdata=data.server_rewards[qfIndex]
local itemid=rdata[1]
local itemcount=rdata[2]
local showCountBG=itemcount>1
local countStr=showCountBG and itemcount or""

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local ritem=item:GetChildLayoutGroupGridItem(CmpRankRewardInfoSlotIndex.qfRewardList,qfIndex-1)
ritem:SetChildPropData(-1,propData)

ritem:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemid)
end)
end
item:SetChildLayoutGroupCreateItems(CmpRankRewardInfoSlotIndex.qfRewardList,qfRewardLen,qfCreateFunc)
end
end


local CmpDropDownWidgetIndex={
scrollView=0,
list=1,
selectItem=2,
open=3,
selectIcon=4,
}


local _dropOptionItemHeight=55
local _dropOptionListTopPadding=5
local _dropOptionListBottonPadding=30
local _dropOptionListSpacing=5
local _dropOptionScrollViewWidth=184


local _aniMoveDuration=0.2


function UIWDCQSecondMCWin:refreshDropDown()

self.selectGroup=1
self.isOpenOptionList=false

self.dropDownWidget=self.dropDownRoot:getWidgetBase()

self.dropItemInfoList=WDCQController:getUnlockGroupCfgList()
self.dropItemNum=#self.dropItemInfoList

self:refreshSelectItem()

self:refreshSubItemList()
end

function UIWDCQSecondMCWin:refreshSelectItem()

self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.open,self.isOpenOptionList)


local id=self.dropItemInfoList[self.selectGroup].id
local iconName=WDCQController.getGroupIconName(id)
self.dropDownWidget:SetChildCSImageSprite(CmpDropDownWidgetIndex.selectIcon,globalABLookup.wendingcangqiong,iconName)
self.dropDownWidget:SetChildButtonClick(CmpDropDownWidgetIndex.selectItem,function()

self.isOpenOptionList=not self.isOpenOptionList
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.open,self.isOpenOptionList)

if self.isOpenOptionList then
self:playOpenAni()
else
self:hideOptionList()
end
end,true)
end

function UIWDCQSecondMCWin:refreshSubItemList()

local createFunc=function(index)
local dropItem=self.dropDownWidget:GetChildLayoutGroupGridItem(CmpDropDownWidgetIndex.list,index-1)

local id=self.dropItemInfoList[index].id

local groupIconName=WDCQController.getGroupIconName(id)

dropItem:SetChildCSImageSprite(0,globalABLookup.wendingcangqiong,groupIconName)

dropItem:SetBaseItemClickEvent(-1,function()
self.selectGroup=index

self.isOpenOptionList=false

self:hideOptionList()

self:refreshSelectItem()

self:onDropClickCallBack()
end)
end

self.dropDownWidget:SetChildLayoutGroupCreateItems(CmpDropDownWidgetIndex.list,self.dropItemNum,createFunc)
end

function UIWDCQSecondMCWin:playOpenAni()
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,true)


local totalHeight=self:caculateDropListHeight()

self.openDropDownListDt=self.dropDownWidget:SetChildDOSizeDelta(CmpDropDownWidgetIndex.scrollView,Vector2(_dropOptionScrollViewWidth,totalHeight),_aniMoveDuration)
end

function UIWDCQSecondMCWin:hideOptionList()
self.dropDownWidget:SetChildActive(CmpDropDownWidgetIndex.scrollView,false)

if self.openDropDownListDt then
self.openDropDownListDt:Complete()
self.openDropDownListDt:Kill()
end

self.dropDownWidget:SetChildSizeDelta(CmpDropDownWidgetIndex.scrollView,_dropOptionScrollViewWidth,0)
end

function UIWDCQSecondMCWin:caculateDropListHeight()
local num=self.dropItemNum

return(num*_dropOptionItemHeight)+((num-1)*_dropOptionListSpacing)+_dropOptionListTopPadding+_dropOptionListBottonPadding
end

function UIWDCQSecondMCWin:onDropClickCallBack()
self:refreshRewardInfo()
end


