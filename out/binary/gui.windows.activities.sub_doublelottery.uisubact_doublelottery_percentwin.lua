







def_class("UISubAct_doubleLottery_PercentWin",UIWindowBase)









function UISubAct_doubleLottery_PercentWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.percentTypeList=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_doubleLottery_PercentWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.percentTypeList);self.percentTypeList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local percentTypeItemIndex={
itemList=0,
titleName=1,
}

local percentItemIndex={
item=0,
percentText=1,
}



function UISubAct_doubleLottery_PercentWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_doubleLottery_PercentWin:__delete()
self:unbindComponents()
end




function UISubAct_doubleLottery_PercentWin:onShow(argtable,afterOnloaded)
self.percentTypeCfgList=argtable and argtable.percentList or{}
self:refresh()
end


function UISubAct_doubleLottery_PercentWin:onHide()

end

function UISubAct_doubleLottery_PercentWin:refresh()
self.percentTypeList:setChildLayoutGroupCreateItems(#self.percentTypeCfgList)
local grids=self.percentTypeList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
local percentTypeCfg=self.percentTypeCfgList[i]
if percentTypeCfg then
widget:SetChildActive(-1,true)
widget:SetChildText(percentTypeItemIndex.titleName,percentTypeCfg.name)
local rewardList=percentTypeCfg.rewards
local rewardCount=#rewardList
widget:SetChildLayoutGroupCreateItems(percentTypeItemIndex.itemList,rewardCount)
local itemGrids=widget:GetChildLayoutGroupGridList(percentTypeItemIndex.itemList)
for j=1,itemGrids.Count do
local item=itemGrids[j-1]
item:SetChildActive(-1,true)
local itemCfg=rewardList[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local itemPercent=itemCfg[3]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(percentItemIndex.item,prop)



item:SetBaseItemClickEvent(percentItemIndex.item,function(...)
self:onClickRewardItem(...)
end)

item:SetChildText(percentItemIndex.percentText,FMT.fmt("{0}%",itemPercent))
end
end
end
end





function UISubAct_doubleLottery_PercentWin:onClickMask()
self:onCloseBtn()
end


function UISubAct_doubleLottery_PercentWin:onCloseBtn()
self:closeSelf()
end


function UISubAct_doubleLottery_PercentWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end