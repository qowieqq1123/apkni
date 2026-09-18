







def_class("UIXJBuildingSpeedUpWin",UIWindowBase)









function UIXJBuildingSpeedUpWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.bg=UIImage.get(self,1)
self.btnClose=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.chooseBox=UIToggleButton.get(self,4)
self.chooseText=UIText.get(self,5)
self.confirmBtn=UIButton.get(self,6)
self.countInputText=UIInputField.get(self,7)
self.finishBtn=UIButton.get(self,8)
self.finishCostIcon=UIImage.get(self,9)
self.finishCostText=UIText.get(self,10)
self.mask=UIButton.get(self,11)
self.oneKeyBtn=UIButton.get(self,12)
self.oneKeyItemGroup=UIObject.get(self,13)
self.oneKeyOverTimeTipsText=UIText.get(self,14)
self.oneKeyPanel=UIObject.get(self,15)
self.oneKeySpeedUpTimeText=UIText.get(self,16)
self.remainingTimeText=UIText.get(self,17)
self.ruleBtn=UIButton.get(self,18)
self.selectCntSlider=UIObject.get(self,19)
self.selectItemPanel=UIObject.get(self,20)
self.sliderClickMask=UIObject.get(self,21)
self.speedUpItemGroup=UIObject.get(self,22)
self.speedUpItemScrollView=UIObject.get(self,23)
self.speedUpTimeText=UIText.get(self,24)
self.subBtn=UIButton.get(self,25)
self.useBtn=UIButton.get(self,26)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIXJBuildingSpeedUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.countInputText);self.countInputText=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.finishCostIcon);self.finishCostIcon=nil;
_UIObject_release(self.finishCostText);self.finishCostText=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.oneKeyItemGroup);self.oneKeyItemGroup=nil;
_UIObject_release(self.oneKeyOverTimeTipsText);self.oneKeyOverTimeTipsText=nil;
_UIObject_release(self.oneKeyPanel);self.oneKeyPanel=nil;
_UIObject_release(self.oneKeySpeedUpTimeText);self.oneKeySpeedUpTimeText=nil;
_UIObject_release(self.remainingTimeText);self.remainingTimeText=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
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
timeBg=6,
}

local _maxSpeedUpItemCount=4




function UIXJBuildingSpeedUpWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.building_event,self.on_building_event)
end


function UIXJBuildingSpeedUpWin:__delete()
self:SetRepeatVis()
_this=nil
self:clearRemainingTimer()
self:unbindComponents()
end




function UIXJBuildingSpeedUpWin:onShow(argtable,afterOnloaded)
if argtable then
self.build_id=argtable.build_id
self.un_build_id=argtable.un_build_id

self.initFinishTime=argtable.finishTime
self.initFinishTimeFunc=argtable.initFinishTimeFunc
self.showPage=argtable.showPage or 1
self.backImg=argtable.backImg
self.speedType=argtable.speedType
self.tipsText=argtable.tipsText or"训练"
self.XJSpeedUp=argtable.XJSpeedUp

self.bg:setCSImageSprite(self.backImg[1],self.backImg[2])
end



self.selectItemIndex=self:getDefaultSelectItemIndex()
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

self:refresh(true)
end


function UIXJBuildingSpeedUpWin:onHide()
self:clearRemainingTimer()
end

function UIXJBuildingSpeedUpWin:getDefaultSelectItemIndex()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local defaultIndex
local selectItemTime
for i,v in ipairs(speedUpItemList)do
if not selectItemTime or v.speedUpTime>selectItemTime then
if v.speedUpTime<remainingTime then
defaultIndex=i
selectItemTime=v.speedUpTime
else
break
end
end
end
if not defaultIndex then
defaultIndex=1
end

return defaultIndex
end

function UIXJBuildingSpeedUpWin:initSortSpeedUpItemList()

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local speedUpItemList={}
for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local itemCount=itemsModel.getCount(itemId)
local canUseBuildList=v[4]
local isCanUse=false
local isOnly
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
isOnly=true
for buildId,_ in pairs(canUseBuildList)do
if buildId~=self.build_id then
isOnly=false
break
end
end
end
if isCanUse and itemCount>0 then
speedUpItemList[#speedUpItemList+1]={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
isOnly=isOnly,
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
local price=v.isOnly and 100 or 0
if itemCount>0 then
itemList[#itemList+1]={itemId,itemCount,speedUpTime,price}
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

function UIXJBuildingSpeedUpWin:refresh(isInit)
self:clearRemainingTimer()

local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
if remainingTime<=0 then
UIManager.error(FMT.fmt("此{0}已完成",self.tipsText))
return self:onBtnClose()
end
self.remainingTimeText:setText(FMT.fmt("<color=#7d3b17>{1}剩余时长：</color>{0}",timeHelper.format_time_stamp4(remainingTime),self.tipsText))

self:setRemainingTimer()

self:refreshPage(isInit)

local ruleLangIdList=cfgHelper.get2(cfg_monijybasicconfig_get,1,'xjBuildReduceRuleLangIdList')
local isShowRuleBtn=false
if ruleLangIdList and ruleLangIdList[self.speedType]then
self.ruleLangId=ruleLangIdList[self.speedType]
isShowRuleBtn=true
end
self.ruleBtn:setActive(isShowRuleBtn)
end

function UIXJBuildingSpeedUpWin:refreshPage(isInit)
self.selectItemPanel:setActive(self.showPage==1)
self.oneKeyPanel:setActive(self.showPage==2)

if self.showPage==1 then
self:refreshInfo(isInit)
elseif self.showPage==2 then
self:refreshOneKeyPanel()
end
end

function UIXJBuildingSpeedUpWin:refreshInfo(isInit)

local speedUpItemList=self:getSortSpeedUpItemList()or{}
local gridsCount=#speedUpItemList+1

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


widget:SetBaseItemLongTouchEvent(_speedUpItemCmpIndex.item,itemsComponentHelper.onItemClick)

local speedTimeStr=timeHelper.format_time_stamp4(item.speedUpTime)

widget:SetChildActive(_speedUpItemCmpIndex.timeBg,false)

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
if isInit then

local leftSpace=5
local rightSpace=5
local itemSpace=0
local itemWidth=82

local contentWidth=gridsCount*(itemWidth+itemSpace)-itemSpace+leftSpace+rightSpace
local showWidth=self.speedUpItemScrollView:getChildRectWidth()
local maxRight=contentWidth-showWidth
if contentWidth<showWidth then
maxRight=0
end
local targetItemLeft=(self.selectItemIndex-1)*(itemWidth+itemSpace)+leftSpace
local contentPosX=targetItemLeft-itemWidth/2
if contentPosX<0 then
contentPosX=0
elseif contentPosX>maxRight then
contentPosX=maxRight
end
self.speedUpItemGroup:setLocalPosX(-contentPosX)
end


local selectItem=speedUpItemList[self.selectItemIndex]
local itemCount=selectItem and itemsModel.getCount(selectItem.itemId)or 0
local maxItemSelectCount=self:getMaxItemSelectCount()
self.maxSelectCount=math.min(maxItemSelectCount,itemCount)
local isMaxOverTime=itemCount>=maxItemSelectCount


local count=self.selectItemCount
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
if not count then
if self.maxSelectCount>0 then
if isMaxOverTime then
if self.maxSelectCount==1 then
count=1
else
count=self.maxSelectCount-1
end
else
count=self.maxSelectCount
end
else
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

function UIXJBuildingSpeedUpWin:getSortSpeedUpItemList()
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
local isOnly
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
isOnly=true
for buildId,_ in pairs(canUseBuildList)do
if buildId~=self.build_id then
isOnly=false
break
end
end
end
if isCanUse and itemCount>0 then
itemList[#itemList+1]={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
isOnly=isOnly,
}
end
end

if next(itemList)then
table.sort(itemList,function(a,b)
local isOnly_a=a.isOnly and 100 or 0
local isOnly_b=b.isOnly and 100 or 0

if isOnly_a==isOnly_b then
if a.itemColor==b.itemColor then
if a.speedUpTime==b.speedUpTime then
return a.itemId<b.itemId
else
return a.speedUpTime<b.speedUpTime
end
else
return a.itemColor<b.itemColor
end
else
return isOnly_a>isOnly_b
end
end)
end

self.speedUpItemList=itemList
return self.speedUpItemList
end

function UIXJBuildingSpeedUpWin:getMinSpeedUpItem()
if self.minSpeedUpItem and next(self.minSpeedUpItem)then
return self.minSpeedUpItem
end

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local itemList_lookup=baseCfg[speedUpMode.eItemBuilding]
local minSpeedUpItem
local checkFunc=function(a,b)
local isOnly_a=a.isOnly and 100 or 0
local isOnly_b=b.isOnly and 100 or 0

if isOnly_a==isOnly_b then
if a.speedUpTime==b.speedUpTime then
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor<b.itemColor
end
else
return a.speedUpTime<b.speedUpTime
end
else
return isOnly_a>isOnly_b
end
end

for itemId,v in pairs(itemList_lookup)do
local itemColor=itemsConfig.getItemColor(itemId)
local canUseBuildList=v[4]
local isCanUse=false
local isOnly
if not canUseBuildList or canUseBuildList[self.build_id]then
isCanUse=true
isOnly=true
for buildId,_ in pairs(canUseBuildList)do
if buildId~=self.build_id then
isOnly=false
break
end
end
end
if isCanUse then
local item={
itemId=itemId,
itemColor=itemColor,
useCount=v[1],
speedUpTime=v[2],
isOnly=isOnly,
}
if not minSpeedUpItem or checkFunc(item,minSpeedUpItem)then
minSpeedUpItem=item
end
end
end

self.minSpeedUpItem=minSpeedUpItem
return self.minSpeedUpItem
end

function UIXJBuildingSpeedUpWin:selectSpeedUpItem(index)
if index==self.selectItemIndex then
return
end
self.selectItemIndex=index

self.selectItemCount=nil
return self:refreshInfo()
end

function UIXJBuildingSpeedUpWin:changeSelectCount(str)

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

function UIXJBuildingSpeedUpWin:onSliderChange(value)
if not value then return end
if self.selectItemCount==value then return end

self.selectItemCount=value
return self:refreshInfo()
end

function UIXJBuildingSpeedUpWin:setRemainingTimer()

local baseCfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_times')


if self.speedType==speedUpType.eYunJiaYingTrain then
local costParamList=baseCfg[speedUpMode.eMoneyBuilding]
self.costParam=costParamList[SLG_SYSTEM_TYPE.eYunJiaYing]
end

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

if self.speedType==speedUpType.eYunJiaYingTrain and self.costParam then
self.needCount=math.ceil(remainingTime/self.costParam[3])
self.needAllMoney=self.needCount*self.costParam[2]
self.finishCostText:setText(self.needAllMoney)
elseif self.speedType==speedUpType.eYuLingZhai then
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local finCost=bdConfig.rapid_recover
self.needAllMoney=math.ceil(finCost[2]*remainingTime/(finCost[3]or 1))
self.finishCostText:setText(self.needAllMoney)
end
end
func()
self.remainingTimer=self:setTimer(1,0,func)
end




function UIXJBuildingSpeedUpWin:clearRemainingTimer()
if self.remainingTimer then
self:stopTimerByID(self.remainingTimer)
self.remainingTimer=nil
end
end

function UIXJBuildingSpeedUpWin:getSpeedUpAllTime()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectItemIndex]
local speedUpTime=item and item.speedUpTime*self.selectItemCount or 0
return speedUpTime
end

function UIXJBuildingSpeedUpWin:getMaxItemSelectCount()
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

function UIXJBuildingSpeedUpWin:refreshOneKeyPanel()
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

widget:SetChildActive(_speedUpItemCmpIndex.timeBg,false)

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
local isShowOverTimeTips=false
if speedUpAllTime<=0 then
timeStr="0秒"
elseif speedUpAllTime>remainingTime then
timeStr=FMT.cfmt(FONT_COLOR.eRedColor,timeStr)
isShowOverTimeTips=true
end
self.oneKeySpeedUpTimeText:setText(FMT.fmt("<color=#7d3b17>总加速时长：</color>{0}",timeStr))
self.oneKeyOverTimeTipsText:setActive(isShowOverTimeTips)
end

function UIXJBuildingSpeedUpWin:onSpeedUpRecv()
self:clearRemainingTimer()
if self.initFinishTimeFunc then
local func=self.initFinishTimeFunc
self.initFinishTime=func()
end

local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.initFinishTime then
UIManager.error(FMT.fmt("此{0}已完成",self.tipsText))
return UIManager:closeWindow('UIXJBuildingPageBgWin')
end
self.speedUpItemList=nil
self.selectItemCount=nil
self.selectItemIndex=self:getDefaultSelectItemIndex()
self:refresh(true)
end

function UIXJBuildingSpeedUpWin.on_building_event(etype,sfId,ubdId)
if not _this then return end
if etype==buildingEvent.speedUpComplete and sfId==mapIdType.fort and ubdId==_this.un_build_id then
return _this:onSpeedUpRecv()
end
end




function UIXJBuildingSpeedUpWin:onAddBtn()
if self.selectItemCount>=self.maxSelectCount then
return
end

self.selectItemCount=self.selectItemCount+1
if self.selectItemCount>self.maxSelectCount then
self.selectItemCount=self.maxSelectCount
end
return self:refreshInfo()
end



function UIXJBuildingSpeedUpWin:onBtnClose()

UIManager:closeWindow('UIXJBuildingPageBgWin')
end



function UIXJBuildingSpeedUpWin:onCancelBtn()
if self.isCloseSelfOnCancel then
UIManager:closeWindow('UIXJBuildingPageBgWin')

else
self.selectItemList=nil
self.useList=nil
self.speedUpAllTime=nil
self.showPage=1
return self:refreshPage()
end
end



function UIXJBuildingSpeedUpWin:onConfirmBtn()
local useList=self.useList
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,useList)
UIManager:closeWindow('UIXJBuildingPageBgWin')

end



function UIXJBuildingSpeedUpWin:onMask()
self:onBtnClose()
end



function UIXJBuildingSpeedUpWin:onOneKeyBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
local itemList={}
local itemIdxList_lookup={}
for i,v in ipairs(speedUpItemList)do
local itemId=v.itemId
local itemCount=itemsModel.getCount(itemId)
local speedUpTime=v.speedUpTime
local price=v.isOnly and 100 or 0
if itemCount>0 then
itemList[#itemList+1]={itemId,itemCount,speedUpTime,price}
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
if self.XJSpeedUp then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,self.XJSpeedUp)
if flag then
self:onConfirmBtn()
return
end
end
self.showPage=2
return self:refreshPage()
end



function UIXJBuildingSpeedUpWin:onSubBtn()
if self.selectItemCount<=self.minCount then
return
end

self.selectItemCount=self.selectItemCount-1
if self.selectItemCount<self.minCount then
self.selectItemCount=self.minCount
end
return self:refreshInfo()
end



function UIXJBuildingSpeedUpWin:onUseBtn()
local speedUpItemList=self:getSortSpeedUpItemList()or{}
local item=speedUpItemList[self.selectItemIndex]
local itemCount=self.selectItemCount
local itemId=item.itemId
local ubdId=self.un_build_id
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,{{ubdId,itemCount,itemId}})
local maxItemSelectCount=self:getMaxItemSelectCount()
if self.selectItemCount>=maxItemSelectCount then
self:onBtnClose()
end
end

function UIXJBuildingSpeedUpWin:onClickNotItem()
local item=self:getMinSpeedUpItem()
local itemId=item.itemId
gainControl:showGainWin(itemId)
end


function UIXJBuildingSpeedUpWin:onFinishBtn()
if self.speedType==speedUpType.eYunJiaYingTrain then
local moneyType=self.costParam[1]
local moneyCount=self.needAllMoney
local moneyName=moneyModel.getMoneyName(moneyType)
local ubdId=self.un_build_id
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n立即完成这批修士的训练",mathHelper.formatNumber(moneyCount),moneyName)
local okCallback=function()
moneySystem:useMoney(moneyType,moneyCount,function()


return zongmenControl:reqSpeedup(speedUpMode.eMoneyBuilding,0,0,speedUpType.eYunJiaYingTrain,mapIdType.fort,0,{{ubdId,self.needCount,moneyType}})
end,WARNING_TYPE.eWarning)
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYJYFastFinish)
if flag then
okCallback()
return
end

local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okCallback,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYJYFastFinish,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
elseif self.speedType==speedUpType.eYuLingZhai then
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local finCost=bdConfig.rapid_recover
local have=UIDanYaoModel:getHaveItemCount(finCost[1])
local needCount=self.needAllMoney
if have<needCount then
gainControl:showCommonGainWin_item(finCost[1],{needCount=needCount})
return
end
local healData=YuLingZhaiModel:getHealData()
if healData then
local sendList={}
for id,v in pairs(healData)do
if v>0 then
table.insert(sendList,{id,v})
end
end
local len=#sendList
if len>0 then
local desc=FMT.fmt('是否花费<color=#5b9856>{0}</color>灵玉\n立即完成这批重伤修士的救治？',needCount)
self.comfirmDialog=UIDialogManager.getConfirmDialog(self.comfirmDialog,'提示',desc)
self.comfirmDialog.okcallback=function()
local nowTime=timeHelper.getServerShortTime()
local remainingTime=self.initFinishTime-nowTime
if remainingTime<=0 then
return
end
YuLingZhaiController.req_6_132(3,len,sendList)
self:onBtnClose()
end
self.comfirmDialog:show()
end
end
end
end

function UIXJBuildingSpeedUpWin:onRuleBtn()
if not self.ruleLangId then
return
end

local d={}
d.mode=3
d.title="规则"
d.name=self.ruleLangId
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UIXJBuildingSpeedUpWin:onChangeChoose()

AudioManager.playBtnClick()
end

function UIXJBuildingSpeedUpWin:SetRepeatVis()
if not self.XJSpeedUp then
return
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,self.XJSpeedUp)
if flag then
return
end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,self.XJSpeedUp,self.chooseBox:getToggle())
end
