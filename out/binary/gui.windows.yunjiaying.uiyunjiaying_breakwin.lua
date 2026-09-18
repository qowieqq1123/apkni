







def_class("UIYunJiaYing_breakWin",UIWindowBase)









function UIYunJiaYing_breakWin:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.finishBtn=UIButton.get(self,2)
self.finishCostText=UIText.get(self,3)
self.confirmBtn=UIButton.get(self,4)
self.costTimeText=UIText.get(self,5)
self.cannotTrainTips=UIObject.get(self,6)
self.cannotTrainTipsText=UIText.get(self,7)
self.costPanel=UIObject.get(self,8)
self.costItemGroup=UIObject.get(self,9)
self.countInputText=UIInputField.get(self,10)
self.selectCntSlider=UIObject.get(self,11)
self.clickMask=UIObject.get(self,12)
self.subBtn=UIButton.get(self,13)
self.addBtn=UIButton.get(self,14)
self.infoPanel=UIObject.get(self,15)
self.finishCostIcon=UIImage.get(self,16)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UIYunJiaYing_breakWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.finishCostText);self.finishCostText=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.costTimeText);self.costTimeText=nil;
_UIObject_release(self.cannotTrainTips);self.cannotTrainTips=nil;
_UIObject_release(self.cannotTrainTipsText);self.cannotTrainTipsText=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costItemGroup);self.costItemGroup=nil;
_UIObject_release(self.countInputText);self.countInputText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.finishCostIcon);self.finishCostIcon=nil;
end
















local _this




function UIYunJiaYing_breakWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIYunJiaYing_breakWin:__delete()
_this=nil
self:unbindComponents()
end




function UIYunJiaYing_breakWin:onShow(argtable,afterOnloaded)
self.un_build_id=argtable and argtable.un_build_id
if self.un_build_id then
self.bdData=zongmenModel:getBuildingData(self.un_build_id)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
end
self.levelIdx=argtable and argtable.levelIdx
self.targetLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
self:refresh(true)
end


function UIYunJiaYing_breakWin:onHide()

end

function UIYunJiaYing_breakWin:refresh(isInit)
self.soldierCountList,self.allMoneyCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)


self:refreshInfoPanel(isInit)


self:refreshCostPanel()
end

function UIYunJiaYing_breakWin:refreshInfoPanel(isInit)
local grids=self.infoPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local levelIdx
if i==1 then

levelIdx=self.levelIdx
elseif i==2 then

levelIdx=self.targetLevelIdx
end

local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,levelIdx)

local levelName=levelCfg.name
widget:SetChildText(0,FMT.fmt("{0}修士",levelName))


local soldierCount=self.soldierCountList[levelIdx]or 0
widget:SetChildText(1,FMT.fmt("(当前：{0})",mathHelper.formatNumber4(soldierCount,1)))

if isInit then

local jzCfg=cfgHelper.get(cfg_jzconfig_get,levelIdx)
local abName=jzCfg.uiModel
local maxShowNum=50
local percent=0.2
widget:SetChildTroop(2,abName,maxShowNum,percent,function()
return
end)
end

end
end

function UIYunJiaYing_breakWin:refreshCostPanel()
local nowMaxLevelIdx=yunjiayingModel:getTrainMaxBreakLevel()
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()
local soldierCount=self.soldierCountList[self.levelIdx]or 0
local maxCount=math.min(maxTrainCount,soldierCount)
local isCanTrain=maxCount and maxCount>0
self.costPanel:setActive(isCanTrain)
self.cannotTrainTips:setActive(not isCanTrain)
if not isCanTrain then
local tipsStr=""
if soldierCount<=0 then
tipsStr="该等级修士可突破数量<color=#c82c2c>不足</color>"
end
self.cannotTrainTipsText:setText(tipsStr)
else
local count=self.trainSelectCount
if self.trainSelectCount then
count=self.trainSelectCount
else
local maxEnoughCount=yunjiayingModel:getTrainMaxEnoughCostCount(self.levelIdx,nowMaxLevelIdx)
count=maxEnoughCount<maxCount and maxEnoughCount or maxCount
if count<=0 then
count=1
end
end


local minCount=1
self.clickMask:setActive(maxCount<=1)
self.maxCount=maxCount
self.countInputText:setChildInputFieldChange(true,function(...)
if not _this then return end
return _this:changeSelectCount(...)
end)

local func=function(...)
if not _this then return end
return _this:onSliderChange(...)
end

self.selectCntSlider:setChildSliderInit(count,minCount,maxCount,func)
self.countInputText:setInputFieldValue(count)
self.selectCntSlider:setChildSliderValue(count)
local needTime=yunjiayingModel:getTrainNeedTime(self.levelIdx,nowMaxLevelIdx,count)
local costList=yunjiayingModel:getTrainNeedCost(self.levelIdx,nowMaxLevelIdx,count,true)


self.costItemGroup:setChildLayoutGroupCreateItems(#costList)
local grids=self.costItemGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
local item=costList[i]
local itemid=item[1]
local itemCount=item[2]
local hasCount=itemsModel.getCount(itemid)
local countStr=''
countStr=mathHelper.formatNumber(itemCount)
if hasCount<itemCount then
countStr=FMT.fmt("<color=#FF0000>{0}</color>",countStr)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


self.costTimeText:setText(timeHelper.format_time_stamp(needTime))

local trainList=yunjiayingModel:getTrainList()or{}
if not next(trainList)then

self:showFinishBtn(needTime)
else

self.finishBtn:setActive(false)
end
end
end

function UIYunJiaYing_breakWin:changeSelectCount(str)

local count=tonumber(str)

local originalCount=self.trainSelectCount or 0
local isNeedReset=false
if count==nil then

count=1
isNeedReset=true
elseif count==originalCount then

return
elseif count<1 then

count=1
isNeedReset=true
elseif count>self.maxCount then

count=self.maxCount
isNeedReset=true
end

if isNeedReset then
self.countInputText:setInputFieldValue(count)
return
end

if self.trainSelectCount==count then
return
end
self.trainSelectCount=count
self:refreshCostPanel()
end

function UIYunJiaYing_breakWin:onSliderChange(value)
if not value then
return
end
if self.trainSelectCount==value then
return
end
self.trainSelectCount=value
self:refreshCostPanel()
end

function UIYunJiaYing_breakWin:showFinishBtn(needTime)

local spcfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_allow',speedUpType.eYunJiaYingTrain)or{}
if spcfg[speedUpMode.eMoneyBuilding]then
self.finishBtn:setActive(true)
local baseCfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_times')
local costParamList=baseCfg[speedUpMode.eMoneyBuilding]
local costParam=costParamList[self.bdData.build_id]
if costParam then
local costMoneyType=costParam[1]
local costMoneyNum=costParam[2]
local costTime=costParam[3]

local needMoneyCount=math.ceil(needTime/costTime)*costMoneyNum

local moneyIconName=iconHelper.getIconName(costMoneyType)
self.finishCostIcon:setChildIcon(moneyIconName)


local hasCount=itemsModel.getCount(costMoneyType)
local moneyStr=mathHelper.formatNumber(needMoneyCount)
if hasCount<needMoneyCount then
moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,moneyStr)
end
self.finishCostText:setText(moneyStr)
self.finishBtnCost={costMoneyType,needMoneyCount}
else

self.finishBtn:setActive(false)
end
else

self.finishBtn:setActive(false)
end
end

function UIYunJiaYing_breakWin:checkConfirm()
local maxTrainCount=yunjiayingModel:getMaxTrainingSoldierCount()
local soldierCount=self.soldierCountList[self.levelIdx]or 0
local maxCount=math.min(maxTrainCount,soldierCount)
local isCanTrain=maxCount and maxCount>0
if not isCanTrain then
local tipsStr=""
if soldierCount<=0 then
tipsStr="该等级修士可突破数量不足"
end
UIManager.error(tipsStr)
return false
end

local startLevelIdx=self.levelIdx
local targetLevelIdx=self.targetLevelIdx
local trainCount=self.trainSelectCount

local costList=yunjiayingModel:getTrainNeedCost(startLevelIdx,targetLevelIdx,self.trainSelectCount)
for _,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
local isEnough=itemsModel.checkItemEnough(itemId,itemCount)
if not isEnough then
local itemName=itemsModel.getName(itemId)
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(itemId)
return false
end
end


local freeCount=yunjiayingModel:getFreeTrainCount()
if not freeCount or freeCount<=0 then
UIManager.error("当前训练队伍队列已满")
return false
end
return true
end




function UIYunJiaYing_breakWin:onMask()
self:onCloseBtn()
end



function UIYunJiaYing_breakWin:onCloseBtn()
self:closeSelf()
end



function UIYunJiaYing_breakWin:onFinishBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法立即完成")
return
end
if not self:checkConfirm()then
return
end

if not self.finishBtnCost or not next(self.finishBtnCost)then
return
end

local moneyType=self.finishBtnCost[1]
local moneyCount=self.finishBtnCost[2]
local moneyName=moneyModel.getMoneyName(moneyType)
local startId=self.levelIdx
local targetId=self.targetLevelIdx
local trainCount=self.trainSelectCount
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n立即完成这批修士的训练",mathHelper.formatNumber(moneyCount),moneyName)
local ubdId=self.un_build_id
local okCallback=function()
moneySystem:useMoney(moneyType,moneyCount,function()

yunjiayingController:reqFastFinishTrain(ubdId,startId,targetId,trainCount,{moneyType,moneyCount},true)
UIManager:invokeUIMethod("UIYunJiaYing_breakWin","onCloseBtn")
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
end



function UIYunJiaYing_breakWin:onConfirmBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error("云甲营正在升级中，暂时无法新增突破")
return
end
if not self:checkConfirm()then
return
end


local startLevelIdx=self.levelIdx
local targetLevelIdx=self.targetLevelIdx
local trainCount=self.trainSelectCount
local trainList={{startLevelIdx,targetLevelIdx,trainCount}}
yunjiayingController:reqStartTrain(trainList)
self:onCloseBtn()
end



function UIYunJiaYing_breakWin:onSubBtn()
if self.trainSelectCount<=1 then
return
end

self.trainSelectCount=self.trainSelectCount-1
if self.trainSelectCount<1 then
self.trainSelectCount=1
end
return self:refreshCostPanel()
end



function UIYunJiaYing_breakWin:onAddBtn()
if self.trainSelectCount>=self.maxCount then
return
end

self.trainSelectCount=self.trainSelectCount+1
if self.trainSelectCount>self.maxCount then
self.trainSelectCount=self.maxCount
end
return self:refreshCostPanel()
end

function UIYunJiaYing_breakWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


