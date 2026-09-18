







def_class("UIYunJiaYing_speedUpWin",UIWindowBase)









function UIYunJiaYing_speedUpWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.bg=UIObject.get(self,1)
self.btnClose=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.confirmBtn=UIButton.get(self,4)
self.countInputText=UIInputField.get(self,5)
self.mask=UIButton.get(self,6)
self.oneKeyBtn=UIButton.get(self,7)
self.oneKeyItemGroup=UIObject.get(self,8)
self.oneKeyPanel=UIObject.get(self,9)
self.oneKeySpeedUpTimeText=UIText.get(self,10)
self.remainingTimeText=UIText.get(self,11)
self.selectCntSlider=UIObject.get(self,12)
self.selectItemPanel=UIObject.get(self,13)
self.sliderClickMask=UIObject.get(self,14)
self.speedUpItemGroup=UIObject.get(self,15)
self.speedUpItemScrollView=UIObject.get(self,16)
self.speedUpTimeText=UIText.get(self,17)
self.subBtn=UIButton.get(self,18)
self.useBtn=UIButton.get(self,19)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIYunJiaYing_speedUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.countInputText);self.countInputText=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.oneKeyItemGroup);self.oneKeyItemGroup=nil;
_UIObject_release(self.oneKeyPanel);self.oneKeyPanel=nil;
_UIObject_release(self.oneKeySpeedUpTimeText);self.oneKeySpeedUpTimeText=nil;
_UIObject_release(self.remainingTimeText);self.remainingTimeText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectItemPanel);self.selectItemPanel=nil;
_UIObject_release(self.sliderClickMask);self.sliderClickMask=nil;
_UIObject_release(self.speedUpItemGroup);self.speedUpItemGroup=nil;
_UIObject_release(self.speedUpItemScrollView);self.speedUpItemScrollView=nil;
_UIObject_release(self.speedUpTimeText);self.speedUpTimeText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
end
















local _this

local _speedUpItemCmpIndex={
item=0,
select=1,
timeText=2,
itemPanel=3,
notPanel=4,
notClick=5,
}

local _maxSpeedUpItemCount=4




function UIYunJiaYing_speedUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIYunJiaYing_speedUpWin:__delete()
_this=nil
self:clearRemainingTimer()
self:unbindComponents()
end




function UIYunJiaYing_speedUpWin:onShow(argtable,afterOnloaded)
if argtable then
self.build_id=argtable.build_id
self.un_build_id=argtable.un_build_id

self.initFinishTime=argtable.finishTime
self.showPage=argtable.showPage or 1
self.backImg=argtable.backImg
self.speedType=argtable.speedType
self.tipsText=argtable.tipsText or"训练"

self.bg:setCSImageSprite(self.backImg[1],self.backImg[2])
end

self.selectItemIndex=1
self.selectItemCount=1
if self.showPage==2 then
if argtable and argtable.selectItemList then
self.selectItemList=argtable and argtable.selectItemList
self.useList=argtable and argtable.useList
self.speedUpAllTime=argtable and argtable.speedUpAllTime
else
self:initSortSpeedUpItemList()
end
self.isCloseSelfOnCancel=true
end

self:refresh()
end


function UIYunJiaYing_speedUpWin:onHide()
self:clearRemainingTimer()
end

function UIYunJiaYing_speedUpWin:initSortSpeedUpItemList()

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local speedUpItemList={}
for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local itemCount=itemsModel.getCount(itemId)
local canUseBuildList=v[4]
local isCanUse=false
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
end
if isCanUse and itemCount>0 then
speedUpItemList[#speedUpItemList+1]={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
}
end
end

if next(speedUpItemList)then
table.sort(speedUpItemList,function(a,b)
if a.itemColor==b.itemColor then
if a.speedUpTime==b.speedUpTime then
return a.itemId<b.itemId
else
return a.speedUpTime<b.speedUpTime
end
else
return a.itemColor<b.itemColor
end
end)
end


local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local itemList={}
local itemIdxList_lookup={}
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=itemsModel.getCount(itemId)
local speedUpTime=v.speedUpTime
if itemCount>0 then
itemList[#itemList+1]={itemId,itemCount,speedUpTime}
itemIdxList_lookup[itemId]=i
end
end
local selectList_lookup=zongmenControl:getSpeedUpItemAutoSelectList(itemList,remainingTime)
local selectList={}
local speedUpAllTime=0
local useList={}
local ubdId=self.un_build_id
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=selectList_lookup[itemId]
if itemCount and itemCount>0 then
local speedUpTime=v.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}
useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end
end

if not next(selectList)and next(speedUpItemList)then

local item=speedUpItemList[1]
local itemId=item.itemId
local itemCount=1
local speedUpTime=item.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}
useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end

self.selectItemList=selectList
self.useList=useList
self.speedUpAllTime=speedUpAllTime
end

function UIYunJiaYing_speedUpWin:refresh()
self:clearRemainingTimer()

local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
if remainingTime<=0 then
UIManager.error(FMT.fmt("此{0}已完成",self.tipsText))
return self:onBtnClose()
end
self.remainingTimeText:setText(FMT.fmt("<color=#7d3b17>{1}剩余时长：</color>{0}",timeHelper.format_time_stamp4(remainingTime),self.tipsText))

self:setRemainingTimer()

self:refreshPage()
end

function UIYunJiaYing_speedUpWin:refreshPage()
self.selectItemPanel:setActive(self.showPage==1)
self.oneKeyPanel:setActive(self.showPage==2)

if self.showPage==1 then
self:refreshInfo()
elseif self.showPage==2 then
self:refreshOneKeyPanel()
end
end

function UIYunJiaYing_speedUpWin:refreshInfo()

local speedUpItemList=self:getSortSpeedUpItemList()or{}
local gridsCount=#speedUpItemList+1
self.speedUpItemScrollView:setChildScrollRectEnable(gridsCount>_maxSpeedUpItemCount)
self.speedUpItemGroup:setChildLayoutGroupCreateItems(gridsCount,function(index)
local widget=self.speedUpItemGroup:getChildLayoutGroupGridItem(index-1)
local item=speedUpItemList[index]
widget:SetChildActive(-1,true)
if item then
widget:SetChildActive(_speedUpItemCmpIndex.itemPanel,true)
widget:SetChildActive(_speedUpItemCmpIndex.notPanel,false)
local itemId=item.itemId
local hasCount=itemsModel.getCount(itemId)
local countStr=mathHelper.formatNumber(hasCount)
local showCountBG=true
if hasCount<=1 then
showCountBG=false
countStr=''
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(_speedUpItemCmpIndex.item,prop)
widget:SetBaseItemClickEvent(_speedUpItemCmpIndex.item,function(...)
self:selectSpeedUpItem(index)
end)

local speedTimeStr=timeHelper.format_time_stamp4(item.speedUpTime)
widget:SetChildText(_speedUpItemCmpIndex.timeText,speedTimeStr)

local isSelect=self.selectItemIndex==index
widget:SetChildActive(_speedUpItemCmpIndex.select,isSelect)
else
widget:SetChildActive(_speedUpItemCmpIndex.itemPanel,false)
widget:SetChildActive(_speedUpItemCmpIndex.notPanel,true)

widget:SetChildButtonClick(_speedUpItemCmpIndex.notClick,function()
return self:onClickNotItem()
end,true)
end
end)


local selectItem=speedUpItemList[self.selectItemIndex]
local itemCount=selectItem and itemsModel.getCount(selectItem.itemId)or 0
local maxItemSelectCount=self:getMaxItemSelectCount()
self.maxSelectCount=math.min(maxItemSelectCount,itemCount)

local count=self.selectItemCount or 1
local minCount=1
local canChangeCount=true
local showMaxCount=self.maxSelectCount
if self.maxSelectCount<=0 then
canChangeCount=false
showMaxCount=1
if self.maxSelectCount<minCount then
minCount=0
count=0
end
end
self.minCount=minCount
self.sliderClickMask:setActive(not canChangeCount)

self.countInputText:setChildInputFieldChange(true,function(...)
if not _this then return end
return _this:changeSelectCount(...)
end)

local func=function(...)
if not _this then return end
return _this:onSliderChange(...)
end
self.selectCntSlider:setChildSliderInit(count,minCount,showMaxCount,func)
self.countInputText:setInputFieldValue(count)
self.selectCntSlider:setChildSliderValue(count)
self.selectItemCount=count

local speedUpAllTime=self:getSpeedUpAllTime()

local timeStr=timeHelper.format_time_stamp4(speedUpAllTime)
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
if speedUpAllTime<=0 then
timeStr="0秒"
elseif speedUpAllTime>remainingTime then
timeStr=FMT.cfmt(FONT_COLOR.eRedColor,timeStr)
end
self.speedUpAllTime=speedUpAllTime
self.speedUpTimeText:setText(FMT.fmt("<color=#7d3b17>总加速时长：</color>{0}",timeStr))

self.useBtn:setButtonEnable(canChangeCount,not canChangeCount)
self.oneKeyBtn:setButtonEnable(canChangeCount,not canChangeCount)
end

function UIYunJiaYing_speedUpWin:getSortSpeedUpItemList()
if self.speedUpItemList and next(self.speedUpItemList)then
return self.speedUpItemList
end

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local itemList={}
for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local itemCount=itemsModel.getCount(itemId)
local canUseBuildList=v[4]
local isCanUse=false
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
end
if isCanUse and itemCount>0 then
itemList[#itemList+1]={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
}
end
end

if next(itemList)then
table.sort(itemList,function(a,b)
if a.itemColor==b.itemColor then
if a.speedUpTime==b.speedUpTime then
return a.itemId<b.itemId
else
return a.speedUpTime<b.speedUpTime
end
else
return a.itemColor<b.itemColor
end
end)
end

self.speedUpItemList=itemList
return self.speedUpItemList
end

function UIYunJiaYing_speedUpWin:getMinSpeedUpItem()
if self.minSpeedUpItem and next(self.minSpeedUpItem)then
return self.minSpeedUpItem
end

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local minSpeedUpItem
local checkFunc=function(a,b)
if a.speedUpTime==b.speedUpTime then
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor<b.itemColor
end
else
return a.speedUpTime<b.speedUpTime
end
end

for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local canUseBuildList=v[4]
local isCanUse=false
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
end
if isCanUse then
local item={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
}
if not minSpeedUpItem or checkFunc(item,minSpeedUpItem)then
minSpeedUpItem=item
end
end
end

self.minSpeedUpItem=minSpeedUpItem
return self.minSpeedUpItem
end

function UIYunJiaYing_speedUpWin:selectSpeedUpItem(index)
if index==self.selectItemIndex then
return
end
self.selectItemIndex=index
self.selectItemCount=1
return self:refreshInfo()
end

function UIYunJiaYing_speedUpWin:changeSelectCount(str)

local count=tonumber(str)

local originalCount=self.selectItemCount or self.minCount
local isNeedReset=false
if count==nil then

count=self.minCount
isNeedReset=true
elseif count==originalCount then

return
elseif count<self.minCount then

count=self.minCount
isNeedReset=true
elseif count>self.maxSelectCount then

count=self.maxSelectCount
isNeedReset=true
end

if isNeedReset then
self.countInputText:setInputFieldValue(count)
return
end

if self.selectItemCount==count then
return
end

self.selectItemCount=count
return self:refreshInfo()
end

function UIYunJiaYing_speedUpWin:onSliderChange(value)
if not value then return end
if self.selectItemCount==value then return end

self.selectItemCount=value
return self:refreshInfo()
end

function UIYunJiaYing_speedUpWin:setRemainingTimer()
self:clearRemainingTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime

local speedUpAllTime=self.speedUpAllTime or 0
local timeStr=timeHelper.format_time_stamp4(speedUpAllTime)
if speedUpAllTime<=0 then
timeStr="0秒"
elseif speedUpAllTime>remainingTime then
timeStr=FMT.cfmt(FONT_COLOR.eRedColor,timeStr)
end
self.speedUpTimeText:setText(FMT.fmt("<color=#7d3b17>总加速时长：</color>{0}",timeStr))

if remainingTime<=0 then
UIManager.error(FMT.fmt("此{0}已完成",self.tipsText))
return self:onBtnClose()
end

self.remainingTimeText:setText(FMT.fmt("<color=#7d3b17>{1}剩余时长：</color>{0}",timeHelper.format_time_stamp4(remainingTime),self.tipsText))
end

self.remainingTimer=self:setTimer(1,0,func)
end

function UIYunJiaYing_speedUpWin:clearRemainingTimer()
if self.remainingTimer then
self:stopTimerByID(self.remainingTimer)
self.remainingTimer=nil
end
end

function UIYunJiaYing_speedUpWin:getSpeedUpAllTime()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectItemIndex]
local speedUpTime=item and item.speedUpTime*self.selectItemCount or 0
return speedUpTime
end

function UIYunJiaYing_speedUpWin:getMaxItemSelectCount()
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local selectItem=speedUpItemList[self.selectItemIndex]
if not selectItem then
return 0
end
local singleTime=selectItem.speedUpTime
local count=math.ceil(remainingTime/singleTime)
return count
end

function UIYunJiaYing_speedUpWin:refreshOneKeyPanel()
local selectItemList=self.selectItemList
self.oneKeyItemGroup:setChildLayoutGroupCreateItems(#selectItemList,function(index)
local widget=self.oneKeyItemGroup:getChildLayoutGroupGridItem(index-1)
local item=selectItemList[index]
if item then
widget:SetChildActive(-1,true)
local itemId=item[1]
local itemCount=item[2]
local countStr=mathHelper.formatNumber(itemCount)
local showCountBG=true
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(_speedUpItemCmpIndex.item,prop)
widget:SetBaseItemClickEvent(_speedUpItemCmpIndex.item,itemsComponentHelper.onItemClick)

local speedUpTime=item[3]
local speedTimeStr=timeHelper.format_time_stamp4(speedUpTime)
widget:SetChildText(_speedUpItemCmpIndex.timeText,speedTimeStr)

local isSelect=false
widget:SetChildActive(_speedUpItemCmpIndex.select,isSelect)

widget:SetChildActive(_speedUpItemCmpIndex.itemPanel,true)
widget:SetChildActive(_speedUpItemCmpIndex.notPanel,false)
else
widget:SetChildActive(-1,false)
end
end)

local speedUpAllTime=self.speedUpAllTime

local timeStr=timeHelper.format_time_stamp4(speedUpAllTime)
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
if speedUpAllTime<=0 then
timeStr="0秒"
elseif speedUpAllTime>remainingTime then
timeStr=FMT.cfmt(FONT_COLOR.eRedColor,timeStr)
end
self.oneKeySpeedUpTimeText:setText(FMT.fmt("<color=#7d3b17>总加速时长：</color>{0}",timeStr))
end




function UIYunJiaYing_speedUpWin:onMask()
self:onBtnClose()
end



function UIYunJiaYing_speedUpWin:onSubBtn()
if self.selectItemCount<=self.minCount then
return
end

self.selectItemCount=self.selectItemCount-1
if self.selectItemCount<self.minCount then
self.selectItemCount=self.minCount
end
return self:refreshInfo()
end



function UIYunJiaYing_speedUpWin:onAddBtn()
if self.selectItemCount>=self.maxSelectCount then
return
end

self.selectItemCount=self.selectItemCount+1
if self.selectItemCount>self.maxSelectCount then
self.selectItemCount=self.maxSelectCount
end
return self:refreshInfo()
end



function UIYunJiaYing_speedUpWin:onUseBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectItemIndex]
local itemCount=self.selectItemCount
local itemId=item.itemId
local ubdId=self.un_build_id
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,{{ubdId,itemCount,itemId}})
end



function UIYunJiaYing_speedUpWin:onOneKeyBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local itemList={}
local itemIdxList_lookup={}
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=itemsModel.getCount(itemId)
local speedUpTime=v.speedUpTime
if itemCount>0 then
itemList[#itemList+1]={itemId,itemCount,speedUpTime}
itemIdxList_lookup[itemId]=i
end
end
local selectList_lookup=zongmenControl:getSpeedUpItemAutoSelectList(itemList,remainingTime)
local selectList={}
local speedUpAllTime=0
local useList={}
local ubdId=self.un_build_id
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=selectList_lookup[itemId]
if itemCount and itemCount>0 then
local speedUpTime=v.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}

useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end
end

if not next(selectList)then

local item=speedUpItemList[1]
local itemId=item.itemId
local itemCount=1
local speedUpTime=item.speedUpTime
selectList[#selectList+1]={itemId,itemCount,speedUpTime}
useList[#useList+1]={ubdId,itemCount,itemId}
speedUpAllTime=speedUpAllTime+speedUpTime*itemCount
end



self.selectItemList=selectList
self.useList=useList
self.speedUpAllTime=speedUpAllTime
self.showPage=2
return self:refreshPage()
end

function UIYunJiaYing_speedUpWin:onBtnClose()
self:closeSelf()
end

function UIYunJiaYing_speedUpWin:onCancelBtn()
if self.isCloseSelfOnCancel then
UIManager:closeWindow('UIYunJiaYing_pageBgWin')

else
self.selectItemList=nil
self.useList=nil
self.speedUpAllTime=nil
self.showPage=1
return self:refreshPage()
end
end

function UIYunJiaYing_speedUpWin:onConfirmBtn()
local useList=self.useList
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,useList)
UIManager:closeWindow('UIYunJiaYing_pageBgWin')

end

function UIYunJiaYing_speedUpWin:onClickNotItem()
local item=self:getMinSpeedUpItem()
local itemId=item.itemId
gainControl:showGainWin(itemId)
end