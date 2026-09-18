







def_class("UISubAct_GuiTuXiuXingWin",UIWindowBase)









function UISubAct_GuiTuXiuXingWin:bindComponents()

self.daymenu=UIObject.get(self,0)
self.menuGridsList=UIObject.get(self,1)
self.goalTypeScrollView=UIObject.get(self,2)
self.goalScroller=UIObject.get(self,3)
self.libaoScroller=UIObject.get(self,4)
self.goalPanel=UIObject.get(self,5)
self.libaoPanel=UIObject.get(self,6)
self.progress=UIObject.get(self,7)
self.jifenItemIcon=UIObject.get(self,8)
self.jifenCountText=UIText.get(self,9)
self.timeText=UIText.get(self,10)
self.moneyRoot=UIObject.get(self,11)
self.moneyBtn=UIButton.get(self,12)
self.moneyRootXianyu=UIObject.get(self,13)
self.moneyBtnXianyu=UIButton.get(self,14)
self.progressRewardScrollView=UIObject.get(self,15)
self.progressBar=UIObject.get(self,16)
self.progressContent=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.modelATK=UIObject.get(self,19)
self.modelDEF=UIObject.get(self,20)
self.bgModel=UIObject.get(self,21)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.moneyBtnXianyu:setButtonClick(function()self:onMoneyBtnXianyu()end)



end


function UISubAct_GuiTuXiuXingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.daymenu);self.daymenu=nil;
_UIObject_release(self.menuGridsList);self.menuGridsList=nil;
_UIObject_release(self.goalTypeScrollView);self.goalTypeScrollView=nil;
_UIObject_release(self.goalScroller);self.goalScroller=nil;
_UIObject_release(self.libaoScroller);self.libaoScroller=nil;
_UIObject_release(self.goalPanel);self.goalPanel=nil;
_UIObject_release(self.libaoPanel);self.libaoPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.jifenItemIcon);self.jifenItemIcon=nil;
_UIObject_release(self.jifenCountText);self.jifenCountText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyRootXianyu);self.moneyRootXianyu=nil;
_UIObject_release(self.moneyBtnXianyu);self.moneyBtnXianyu=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelATK);self.modelATK=nil;
_UIObject_release(self.modelDEF);self.modelDEF=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpBg=3,
cmpNomalIcon=4,
select=5,
lock=6,
finishFlag=7,
click=8,
}

local goalItemIndex={
goBtn=0,
rewardBtn=1,
gotFlag=2,
rewards=3,
progressbar=4,
name=5,
back=6,
progressValue=7,
outTimeFlag=8,
}

local libaoItemIndex={
nameText=0,
rewards=1,
buyBtn=2,
freeBtn=3,
discountFlag=4,
discountText=5,
priceIcon=6,
priceText=7,
sellOutFlag=8,
limitText=9,
}

local progressRewardItemIndex={
jifenText=0,
gotFlag=1,
reddot=2,
click=3,
point=4,
bg=5,
item=6,
tianmingFlag=7,
select=8,
}

local _scrollLen=7
local _this=nil




function UISubAct_GuiTuXiuXingWin:onLoaded(...)
self:bindComponents()

_this=self

self._on_gt_item_click=function(...)
self:on_gt_item_click(...)
end

self.goalTypeScrollView:setChildScrollViewInit(0,true,self._on_gt_item_click,nil)
self.goalScroller:setChildScrollViewInit(0,true,nil,nil)
self.libaoScroller:setChildScrollViewInit(0,true,nil,nil)

self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end


end


function UISubAct_GuiTuXiuXingWin:__delete()
self:clearTimer()
self:clearAllFMTweener()
self:unbindComponents()
_this=nil



end




function UISubAct_GuiTuXiuXingWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
if argtable.dayIndex then
self.selectDayIdx=argtable.dayIndex
end
if argtable.goalTypeIndex then
self.gtSelectIndex=argtable.goalTypeIndex
end
end
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5358,1,{},eAnimationID.stand)
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.fmTweenerList={}
self.dayCount=#self.config.taskList
self.needRefreshPage=false
self.root:setActive(true)




self:refresh(true)
end


function UISubAct_GuiTuXiuXingWin:onHide()
self:clearTimer()
self.root:setActive(false)
end

function UISubAct_GuiTuXiuXingWin:refresh(isInit)
self:freshDayMenuList(isInit)
self:refreshBottomPanel(true)
self:setRemainingTimeTimer()
end


function UISubAct_GuiTuXiuXingWin:freshDayMenuList(isInit)

for i=1,7 do
self:freshDayMenuItem(i,isInit)
end

if isInit then
if not self.selectDayIdx then
self.selectDayIdx=1
self:freshDayMenuSelect(self.selectDayIdx)
end
end

self:selectDay(self.selectDayIdx,self.gtSelectIndex,isInit)
end


function UISubAct_GuiTuXiuXingWin:freshDayMenuItem(index,isInit)
local item=self.menuGridsList:getChildCommonLayoutGroupWidgetItem(index-1)
if not item then
return
end

local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[index]
if day<=self.dayCount then
item:SetChildActive(-1,true)
item:SetChildActive(_CMP_INDEX.cmpName,true)
item:SetChildActive(_CMP_INDEX.cmpBg,true)
item:SetChildActive(_CMP_INDEX.cmpNomalIcon,false)

local reddot=self.activityData:checkDayReddot(day)
item:SetChildActive(_CMP_INDEX.cmpReddot,reddot)
if reddot then
if isInit and not self.selectDayIdx then
self.selectDayIdx=index
end
end

local isSelect=self.selectDayIdx==index
item:SetChildActive(_CMP_INDEX.select,isSelect)
item:SetChildActive(_CMP_INDEX.cmpBg,not isSelect)
local dayNameList=self.config.dayNameList or{}
local name
if dayNameList[index]then
name=dayNameList[index]
else
name=FMT.fmt("第{0}天",mathHelper.numberToChinese(day))
end
item:SetChildText(_CMP_INDEX.cmpName,name)


local isLock=self.activityData:checkDayLock(day)
item:SetChildActive(_CMP_INDEX.lock,isLock)


local isFinish=self.activityData:checkDayAllFinish(day,true)
item:SetChildActive(_CMP_INDEX.finishFlag,isFinish)

item:SetChildButtonClick(_CMP_INDEX.click,function()
return self:on_click_callback(index,day)
end)
else
item:SetChildActive(-1,false)
end
end


function UISubAct_GuiTuXiuXingWin:selectDay(dayIndex,gtIndex,isInit)
if dayIndex~=self.selectDayIdx then
local oldIndex=self.selectDayIdx
self.selectDayIdx=dayIndex

self:freshDayMenuSelect(oldIndex)
self:freshDayMenuSelect(dayIndex)
end

if gtIndex then
self.gtSelectIndex=gtIndex
elseif not isInit then

self.gtSelectIndex=1
end


self:refreshGoalTypeList(isInit)

self:selectGoalType(self.gtSelectIndex)
end


function UISubAct_GuiTuXiuXingWin:freshDayMenuSelect(index)
if index==nil then
return
end
local item=self.menuGridsList:getChildCommonLayoutGroupWidgetItem(index-1)
item:SetChildActive(_CMP_INDEX.select,self.selectDayIdx==index)
item:SetChildActive(_CMP_INDEX.cmpBg,self.selectDayIdx~=index)
end


function UISubAct_GuiTuXiuXingWin:refreshGoalTypeList(isInit)

self:initGoalTypeList()

local typeCount=#self.gtList
local hasSelect=false
self.goalTypeScrollView:setChildScrollViewCreateGrids(typeCount,0)
local grids=self.goalTypeScrollView:getChildScrollViewItemWidgets()
local count=typeCount
for i=0,count-1 do
local item=grids[i]
local index=i+1

local gtId=self.gtList[index][1]
local gtCfg=cfgHelper.get1(cfg_guituxiuxingtagactivityconfig_get,gtId)
local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[self.selectDayIdx]
local reddot=self.activityData:checkGoalTypeReddot(day,gtId)
item:SetChildActive(3,reddot)
if reddot then
if isInit and not self.gtSelectIndex then
self.gtSelectIndex=index
end
end

local isSelect=self.gtSelectIndex==index
if isSelect then
hasSelect=true
end
item:SetChildActive(2,isSelect)
item:SetChildText(1,gtCfg.name)
end

if not hasSelect then

self.gtSelectIndex=1
local item=self.goalTypeScrollView:getChildScrollViewItemWidget(0)
item:SetChildActive(2,true)
end
end



function UISubAct_GuiTuXiuXingWin:initGoalTypeList()

local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[self.selectDayIdx]
local dayGoalCfg=self.activityData:getDayCfgByDayIndex(day)or{}
self.gtList={}

if dayGoalCfg.tasks and next(dayGoalCfg.tasks)then
for i=1,#dayGoalCfg.tasks do
local taskCfg=dayGoalCfg.tasks[i]
local goal={}
goal[1]=taskCfg[1]
goal[2]=table.weakCopy(taskCfg[2])
table.insert(self.gtList,goal)
end
end

if dayGoalCfg.libao and next(dayGoalCfg.libao)then
local libaoCfg=dayGoalCfg.libao
local libao={}
libao[1]=libaoCfg[1]
libao[2]=table.weakCopy(libaoCfg[2])
table.insert(self.gtList,libao)
end
end


function UISubAct_GuiTuXiuXingWin:selectGoalType(gtIndex)
if gtIndex~=self.gtSelectIndex then
local item=self.goalTypeScrollView:getChildScrollViewItemWidget(self.gtSelectIndex-1)
item:SetChildActive(2,false)

item=self.goalTypeScrollView:getChildScrollViewItemWidget(gtIndex-1)
item:SetChildActive(2,true)

self.gtSelectIndex=gtIndex
end


self:refreshGoalListOrLibaoList()
end


function UISubAct_GuiTuXiuXingWin:refreshGoalListOrLibaoList(isRecv)
if self.isRefreshing then

self.needRefreshPage=true
return
end
self.isRefreshing=true

self.goalList=self.gtList[self.gtSelectIndex]

self:initNowGoalList()

local goalType=self.goalList[1]

if not goalType then
return
end

local goalTypeCfg=cfgHelper.get1(cfg_guituxiuxingtagactivityconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end

if isLibao then

self.goalPanel:setActive(false)
self.libaoPanel:setActive(true)

local libaoCount=#self.goalList[2]
if not isRecv then
self.libaoScroller:setChildScrollViewCreateGrids(0,0)
end
self.libaoScroller:setChildScrollViewCreateGrids(libaoCount,1)
local grids=self.libaoScroller:getChildScrollViewItemWidgets()
for i=1,libaoCount do
self:refreshLibaoItem(grids[i-1],i)
end
else

self.goalPanel:setActive(true)
self.libaoPanel:setActive(false)



local goalCount=#self.goalList[2]
self.goalScroller:setChildScrollViewCreateGrids(0,0)
self.goalScroller:setChildScrollViewCreateGrids(goalCount,1)
local grids=self.goalScroller:getChildScrollViewItemWidgets()
for i=1,goalCount do
self:refreshGoalItem(grids[i-1],i,isRecv)
end
end

self.isRefreshing=false
if self.needRefreshPage then
self.needRefreshPage=false

return self:refreshGoalListOrLibaoList(true)
end
end


function UISubAct_GuiTuXiuXingWin:initNowGoalList()

if not self.goalList or not next(self.goalList)then
return
end

local goalType=self.goalList[1]
local list=self.goalList[2]
local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[self.selectDayIdx]

if not goalType or not list then
return
end

local goalTypeCfg=cfgHelper.get1(cfg_guituxiuxingtagactivityconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end


if isLibao then



for i=1,#list do
local libao={}
if type(list[i])=='number'then
libao.id=list[i]
else
libao.id=list[i].id
end
local buyCount=self.activityData:getLibaoBuyNum(day,libao.id)
local limitCount=cfgHelper.get1(cfg_guituxiuxinglibaoactivityconfig_get,libao.id).buyLimit
local isSellOut=false
if limitCount then
if buyCount>=limitCount then
isSellOut=true
end
end

local weight=1000-i
if isSellOut then
weight=weight-10000
else
weight=weight+10000
end
libao.weight=weight
list[i]=libao
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)
else



for i=1,#list do
local goal={}
if type(list[i])=='number'then
goal.id=list[i]
else
goal.id=list[i].id
end
local isFinish=self.activityData:checkGoalIsFinish(day,goal.id)
local isGot=self.activityData:checkGoalIsGot(day,goal.id)
local sortId=cfgHelper.get1(cfg_guituxiuxingtaskactivityconfig_get,goal.id).sortid
local weight=1000-sortId
if isFinish then
if isGot then
weight=weight-10000
else
weight=weight+10000
end
end
goal.weight=weight
list[i]=goal
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
end


function UISubAct_GuiTuXiuXingWin:refreshLibaoItem(item,index)
if item==nil then
item=self.libaoScroller:getChildScrollViewItemWidget(index-1)
end

local libaoId=self.goalList[2][index].id
local libaoConfig=cfgHelper.get1(cfg_guituxiuxinglibaoactivityconfig_get,libaoId)
if item then

local rw=libaoConfig.items
item:SetChildLayoutGroupCreateItems(libaoItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(libaoItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local isRecharge=false
local isFree=false
if libaoConfig.buy2 then

isRecharge=true
end

if not isRecharge and not libaoConfig.buy1 then

isFree=true
end

item:SetChildText(libaoItemIndex.nameText,libaoConfig.name)

local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[self.selectDayIdx]
local buyCount=self.activityData:getLibaoBuyNum(day,libaoId)
local isSellOut=false

local isShowBuyLimit=false
if libaoConfig.buyLimit then
if buyCount>=libaoConfig.buyLimit then
isSellOut=true
else
isShowBuyLimit=true
end
end
item:SetChildActive(libaoItemIndex.limitText,not isFree and isShowBuyLimit)
if isShowBuyLimit then
local limitStr=FMT.fmt("限购: <color=#ca631d>{0}/{1}</color>",buyCount,libaoConfig.buyLimit)
item:SetChildText(libaoItemIndex.limitText,limitStr)
end


if libaoConfig.zheKou then
item:SetChildActive(libaoItemIndex.discountFlag,true)
local rebate=libaoConfig.zheKou
local rate=(1-rebate/10)*100
item:SetChildText(libaoItemIndex.discountText,FMT.fmt("-{0}%",rate))
else
item:SetChildActive(libaoItemIndex.discountFlag,false)
end


item:SetChildActive(libaoItemIndex.sellOutFlag,isSellOut)


local libaoType=1
local buyParam=nil
if isFree then
libaoType=1
else
if not isRecharge then
libaoType=2
buyParam={}
buyParam.id=libaoConfig.buy1[1]
buyParam.price=libaoConfig.buy1[2]
else
libaoType=3
buyParam={}
buyParam.id=libaoConfig.buy2
end
end

item:SetChildActive(libaoItemIndex.freeBtn,isFree and not isSellOut)
item:SetChildButtonClick(libaoItemIndex.freeBtn,function()
self:onClickBuyLibaoBtn(day,libaoId,1,nil)
end)

item:SetChildActive(libaoItemIndex.buyBtn,not isFree and not isSellOut)
item:SetChildButtonClick(libaoItemIndex.buyBtn,function()
self:onClickBuyLibaoBtn(day,libaoId,libaoType,buyParam)
end)


if not isFree and not isSellOut then

if isRecharge then

local czId=libaoConfig.buy2
local rmb=cfgHelper.get(cfg_rechargeconfig_get,czId,"rmb")

item:SetChildActive(libaoItemIndex.priceIcon,false)

item:SetChildText(libaoItemIndex.priceText,FMT.fmt("￥{0}",rmb))
else

local moneyType=libaoConfig.buy1[1]
local moneyCount=libaoConfig.buy1[2]

item:SetChildActive(libaoItemIndex.priceIcon,true)
item:SetChildIcon(libaoItemIndex.priceIcon,iconHelper.getIconName(moneyType),false)


item:SetChildText(libaoItemIndex.priceText,FMT.fmt("{0}",moneyCount))
end
end


if not isFree and not isRecharge then
self.moneyType=libaoConfig.buy1[1]

end
end
end


function UISubAct_GuiTuXiuXingWin:refreshGoalItem(item,index,isRecv)
if item==nil then
item=self.goalScroller:getChildScrollViewItemWidget(index-1)
end

local taskId=self.goalList[2][index].id
local goalConfig=cfgHelper.get1(cfg_guituxiuxingtaskactivityconfig_get,taskId)
local dayIndexList=self.activityData:getDayIndexList()
local day=dayIndexList[self.selectDayIdx]
if item then

item:SetChildText(goalItemIndex.name,goalConfig.name)


local finishNum=self.activityData:getGoalProgress(day,taskId,isRecv)

local isFinish=self.activityData:checkGoalIsFinish(day,taskId)
local isGot=self.activityData:checkGoalIsGot(day,taskId)
local jumpParam=goalConfig.jump
local hasJump=false
if jumpParam and next(jumpParam)then
hasJump=true
end

local isFinalDay=false
local canGet=not isGot and isFinish

item:SetChildImageExGray(goalItemIndex.back,isFinalDay and not canGet)
item:SetChildImageExGray(goalItemIndex.progressValue,not isGot and not isFinish and isFinalDay)

item:SetChildActive(goalItemIndex.goBtn,not isGot and not isFinish and hasJump and not isFinalDay)
item:SetChildActive(goalItemIndex.rewardBtn,not isGot and isFinish)
item:SetChildActive(goalItemIndex.outTimeFlag,not isGot and not isFinish and isFinalDay)
item:SetChildButtonClick(goalItemIndex.goBtn,function()
self:onClickGoBtn(taskId)
end)
item:SetChildButtonClick(goalItemIndex.rewardBtn,function()
self:onClickRewardBtn(day,taskId)
end)
item:SetChildActive(goalItemIndex.gotFlag,isGot)


local need=self.activityData:getTaskNeedCountByTaskId(taskId)
if not need then
need=1
end

local cur=finishNum
if isFinish or isGot or canGet then

cur=need
end
if cur>need then
cur=need
end
item:SetChildProgressValue(goalItemIndex.progressbar,cur,need)

local taskType=goalConfig.tasktype
if taskType==10 then

item:SetChildProgressText(goalItemIndex.progressbar,FMT.fmt('{0}/{1}',mathHelper.formatNumber(cur),mathHelper.formatNumber(need)))
else
item:SetChildProgressText(goalItemIndex.progressbar,FMT.fmt('{0}/{1}',cur,need))
end

if cur>=need and not isFinish and not isGot then

local goalData=self.activityData:getGoalDataByDayAndTaskId(day,taskId)
local goalDataStr=goalData and serializeHelper.serialize(goalData)or""
logErr(FMT.fmt("归途修行 前端任务状态与实际数量不一致, 任务天数:{0}, 任务id:{1}, 任务数据:{2}",day,taskId,goalDataStr))
end



local rw={}
if goalConfig.jifen then

local jifenItemId=self.config.jifenItem
rw[1]={jifenItemId,goalConfig.jifen}
end
for i,v in ipairs(goalConfig.reward)do
rw[#rw+1]=v
end

item:SetChildLayoutGroupCreateItems(goalItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(goalItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
local itemid=reward[1]
local count=reward[2]
if not count then
logErr(FMT.fmt("无法获取到归途修行任务id:{0} 的奖励道具{1} 的数量 请检查配置是否正确",taskId,itemid))
count=0
end
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=isGot or(not isFinish and isFinalDay)
local graynum=isGray and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end

function UISubAct_GuiTuXiuXingWin:freshMoney(isShow)
if isShow==self.showMoney then
return
end
self.showMoney=isShow
self.moneyRoot:setActive(isShow)
local isSameMoneyType=self.moneyType==eMoneyType.mtXianYu
self.moneyRootXianyu:setActive(isShow and not isSameMoneyType)

if not isShow then
return
end

local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)



if not isSameMoneyType then
local widget=self.winlua:GetChildWidgetBase(self.moneyRootXianyu:getID())
local moneyType=eMoneyType.mtXianYu

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
end
end


function UISubAct_GuiTuXiuXingWin:refreshBottomPanel(isInit)
local nowJifen=self.activityData.data.nowJF or 0
local nowProgressPoint=self.activityData:getProgressPoint()
self.bottomReddotList={}


local progressCfg=self.config.jdReward or{}
local progressRewardCount=#progressCfg-1
self.progressRewardScrollView:setChildScrollViewCreateGrids(progressRewardCount,progressRewardCount)
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local progressRewardItem=grids[i-1]
local itemProgressPoint=i+1
local config=progressCfg[itemProgressPoint]
if progressRewardItem and config then
local needJifen=config[1]
local reward=config[2]

local canGet=nowJifen>=needJifen
local isGot=nowProgressPoint>=itemProgressPoint


progressRewardItem:SetChildText(progressRewardItemIndex.jifenText,needJifen)


local reddot=canGet and not isGot
self.bottomReddotList[i]=reddot or nil

progressRewardItem:SetChildActive(progressRewardItemIndex.select,reddot)


progressRewardItem:SetChildActive(progressRewardItemIndex.gotFlag,isGot)


progressRewardItem:SetChildActive(progressRewardItemIndex.point,canGet)

local itemid=reward[1][1]
local itemCount=reward[1][2]

local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGot
progressRewardItem:SetChildActive(progressRewardItemIndex.item,true)
progressRewardItem:SetChildPropData(progressRewardItemIndex.item,prop)

local rewardItem=progressRewardItem:GetChildWidgetBase(progressRewardItemIndex.item)
if canGet and not isGot then

rewardItem:SetChildButtonClick(1,function()
self:onClickProgressRewardItem(itemProgressPoint)
end)
else

rewardItem:SetChildButtonClick(1,function()
self:onClickRewardItem(itemid)
end)
end

rewardItem:SetChildLongTouch(1,i,0.5,function()
self:onClickRewardItem(itemid)
end)


local funcparam=itemsConfig.getConfig(itemid).funcparam
local isDiscipleItem=false
if funcparam then
if funcparam.type==item_funtion_type.disciple and funcparam.isSpecial then
isDiscipleItem=true
end
end
progressRewardItem:SetChildActive(progressRewardItemIndex.tianmingFlag,isDiscipleItem)
end
end


self:refreshProgress(isInit)


local jifenItemId=self.config.jifenItem
local iconName=iconHelper.getIconName(jifenItemId)
self.jifenItemIcon:setImageIcon(iconName,false)
self.jifenItemIcon:setButtonClick(function()
self:onClickRewardItem(jifenItemId)
end)
self.jifenCountText:setText(nowJifen)
end


function UISubAct_GuiTuXiuXingWin:refreshProgress(isInit)
local progressCfg=self.config.jdReward or{}
local progressPercent=0
local maxProgressPoint=#progressCfg
local progressRewardCount=#progressCfg-1
local nowJifen=self.activityData.data.nowJF or 0
local nowProgressPoint=self.activityData:getProgressPoint()
local finalGotIndex=0


if nowJifen then
local jifenPoint=1
for i=1,#progressCfg do
if nowJifen>=progressCfg[i][1]then
jifenPoint=i
end

local itemProgressPoint=i-1
local isGot=nowProgressPoint>=i
if isGot and finalGotIndex<itemProgressPoint then

finalGotIndex=itemProgressPoint
end

if not isGot then
break
end
end

if jifenPoint<maxProgressPoint then
if jifenPoint<2 then
progressPercent=0
else
local tmpNow=jifenPoint-2
if tmpNow>0 then
progressPercent=tmpNow/(maxProgressPoint-2)
else
progressPercent=0
end

local pointJifen=progressCfg[jifenPoint][1]
local nextProgressPoint=jifenPoint+1
if nextProgressPoint>maxProgressPoint then
nextProgressPoint=maxProgressPoint
end
local nextJifen=progressCfg[nextProgressPoint][1]

local addPercent=((nowJifen-pointJifen)/(nextJifen-pointJifen))

progressPercent=progressPercent+(addPercent/(maxProgressPoint-1))
end
else
progressPercent=1
end
end


local itemWidth=88
local space=30
local startOffset_X=18
local endOffset_X=36

local contentWidth=startOffset_X+(itemWidth+space)*progressRewardCount-space+(endOffset_X-startOffset_X)
local progressBarWidth=contentWidth-itemWidth-(endOffset_X-startOffset_X)-6*2
local progressBarHeight=self.progressBar:getChildSizeDeltaY()
self.progressBar:setChildSizeDelta(progressBarWidth,progressBarHeight)


local progressWidth=(progressBarWidth-10)*progressPercent
if progressPercent<=0 then
progressWidth=0
end
local progressHeight=self.progress:getChildSizeDeltaY()
self.progress:setChildSizeDelta(progressWidth,progressHeight)

if isInit then

local showWidth=self.progressRewardScrollView:getChildRectWidth()
local contentPosX
local finalGotItemPos
if finalGotIndex<=0 then
finalGotItemPos=0
else
finalGotItemPos=startOffset_X+(itemWidth+space)*(finalGotIndex-1)+itemWidth/2
end

local targetShowPos=startOffset_X+30

if finalGotItemPos<=targetShowPos then

contentPosX=0
elseif finalGotItemPos>=contentWidth-(showWidth-targetShowPos)then

contentPosX=contentWidth-showWidth
else

contentPosX=finalGotItemPos-targetShowPos
end
self.progressContent:setLocalPosX(-contentPosX)
end
end



function UISubAct_GuiTuXiuXingWin:setRemainingTimeTimer()
self:clearTimer()
local func
self.nextOpenDay=self.activityData:getNextOpenDay()
func=function()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.endTime
if not endTime then

self:clearTimer()
return
end
local lerp=endTime-nowTime
if lerp>0 then
local timeStr=timeHelper.format_time_stamp11(lerp,true)
self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeStr))

local nextOpenDay=self.nextOpenDay
if nextOpenDay then
lerp=self.activityData:getDayTime(nextOpenDay)-nowTime
if lerp<=0 then

local dayIndexList=self.activityData:getDayIndexList()
local index
for day,i in pairs(dayIndexList)do
if day==nextOpenDay then
index=i
break
end
end
if index then
self:freshDayMenuItem(index)
end
self.nextOpenDay=self.activityData:getNextOpenDay()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end
end
else
self.timeText:setText("活动已结束")
UIManager.info("活动已结束")
return self:onClickClose()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_GuiTuXiuXingWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UISubAct_GuiTuXiuXingWin:onDiziClick()
local diziItemId=self.config.showDiziItem
if not diziItemId then

logErr("没有获取到展示弟子道具id，请检查配置表是否配置")
return
end

self:onClickRewardItem(diziItemId)
end


function UISubAct_GuiTuXiuXingWin:on_click_callback(index,day)
if index==self.selectDayIdx then
return
end

if self.activityData:checkDayLock(day)then
UIManager.info(FMT.fmt("第{0}天开放",mathHelper.numberToChinese(day)))
return
end
self:selectDay(index)



end


function UISubAct_GuiTuXiuXingWin:on_gt_item_click(clicknum,index)
local selectIndex=index+1

if selectIndex==self.gtSelectIndex then
return
end

self:selectGoalType(selectIndex)
end


function UISubAct_GuiTuXiuXingWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end






function UISubAct_GuiTuXiuXingWin:onClickBuyLibaoBtn(day,libaoId,libaoType,buyParam)
if libaoType==1 then


self.activityData:reqBuyLibao(day,libaoId)
elseif libaoType==2 then

local moneyType=buyParam.id
local price=buyParam.price
local exchangeType=eMoneyType.mtXianYu

local buyCount=self.activityData:getLibaoBuyNum(day,libaoId)
local libaoCfg=cfgHelper.get1(cfg_guituxiuxinglibaoactivityconfig_get,libaoId)
local limitCount=libaoCfg.buyLimit
local buyNum=limitCount-buyCount
local showItem=libaoCfg.items
local show_data=
{
rewards=showItem,
name=libaoCfg.name or'提示',
price={moneyType,price},
isCheckMaxSelectCount=true,
leftNum=buyNum,
maxcount=limitCount,
callback=function(num)

self.activityData:reqBuyLibao(day,libaoId,num)
end,
}
self:showWindow("UICommonBuyDialogWin",show_data)
elseif libaoType==3 then

local params=payControl.getActivityPayParams(self.activityId,self.subType,self.subId,{day,libaoId})
payControl.reqPay(buyParam.id,1,params)
end
end


function UISubAct_GuiTuXiuXingWin:onClickGoBtn(taskId)

local goalConfig=cfgHelper.get1(cfg_guituxiuxingtaskactivityconfig_get,taskId)
local taskType=goalConfig.tasktype
local jumpParam=goalConfig.jump
if jumpParam then
local jumpId=jumpParam.id
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end





if jumpId==JUMP_TYPE.eXianZhan or jumpId==JUMP_TYPE.eXianZhanInteract or jumpId==JUMP_TYPE.eXianZhanShop or jumpId==JUMP_TYPE.eXianZhanInteract2 then



local isFinishRepair=false
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if bdData then
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype~=bdFlagType.sectionBuildStart and ftype~=bdFlagType.sectionBuildComplete then
isFinishRepair=true
end
end
if not isFinishRepair then

UIManager.error('仙栈尚未修复，请修复后再前往')
end

local callBack=function()
if _this==nil then return end

_this:onClickClose()
end

jumpManager:jump(jumpParam,callBack,backFlag)
elseif jumpId==JUMP_TYPE.eFriend then

local tabType=FULL_TAB_TYPE.eFriendList
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,checkArgs=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
local typo=checkArgs[1]
local sysid=checkArgs[2]
local limitType=fullScreenModel.LimitType
if typo==limitType.eSystem then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local errtypo=errArgs[1]
local val=errArgs[2]
local name=systemConfig.getSystemName(sysid)
if errtypo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
UIManager.info(FMT.fmt('{0}级开启{1}系统',level,name))
end
end
end
return
else
jumpManager:jump(jumpParam,nil,backFlag)
end
else
jumpManager:jump(jumpParam,nil,backFlag)
end
end
end


function UISubAct_GuiTuXiuXingWin:onClickRewardBtn(day,taskId)

self.activityData:reqGetAllGoalReward()
end


function UISubAct_GuiTuXiuXingWin:onClickProgressRewardItem(progressPoint)

self.activityData:reqGetProgressReward()
end

function UISubAct_GuiTuXiuXingWin:onMoneyBtn()
if self.moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(self.moneyType)
end
end

function UISubAct_GuiTuXiuXingWin:onMoneyBtnXianyu()
UIFullRechargeController:showRechargeWindow()
end

function UISubAct_GuiTuXiuXingWin:onMoneyChange(moneyType,lastVal,val)
if self.moneyType==moneyType then
self:freshMoneyValue(self.moneyType,lastVal)
end

if moneyType==eMoneyType.mtXianYu then
self:freshMoneyValueXianyu(lastVal)
end
end

function UISubAct_GuiTuXiuXingWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
if self.moneyType==itemid then
self:freshMoneyValue(self.moneyType,lastcount)
end

if itemid==eMoneyType.mtXianYu then
self:freshMoneyValueXianyu(lastcount)
end
end

function UISubAct_GuiTuXiuXingWin:freshMoneyValue(moneyType,lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(1)
self.fmTweenerList[1]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UISubAct_GuiTuXiuXingWin:freshMoneyValueXianyu(lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRootXianyu:getID())
local moneyVal=0
if moneyConfig.isMoney(eMoneyType.mtXianYu)then
moneyVal=moneyModel.getMoney(eMoneyType.mtXianYu)
else
moneyVal=bagControl.invokeFuncByItemId(eMoneyType.mtXianYu,'getItemCountByItemID',eMoneyType.mtXianYu)
end
self:clearFMTweenerByIndex(2)
self.fmTweenerList[2]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UISubAct_GuiTuXiuXingWin:clearFMTweenerByIndex(index)
if self.fmTweenerList[index]then
self.fmTweenerList[index]:Kill()
self.fmTweenerList[index]=nil
end
end

function UISubAct_GuiTuXiuXingWin:clearAllFMTweener()
for index,tweener in pairs(self.fmTweenerList)do
tweener:Kill()
self.fmTweenerList[index]=nil
end
end