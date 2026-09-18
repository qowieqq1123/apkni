







def_class("UISubAct_TotalRecharge_simpleWin",UIWindowBase)









function UISubAct_TotalRecharge_simpleWin:bindComponents()

self.taskScroller=UIObject.get(self,0)
self.freeRewardBtn=UIButton.get(self,1)
self.freeRewardReddot=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)
self.timeText=UIText.get(self,4)
self.totalCount=UIText.get(self,5)
self.helpBtn=UIButton.get(self,6)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UISubAct_TotalRecharge_simpleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.freeRewardReddot);self.freeRewardReddot=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.totalCount);self.totalCount=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end
















local taskItemIndex={
titleText=0,
rewards=1,
getRewardBtn=2,
gotFlag=3,
gotoBtn=4,
back=5,
empty=6,
}

local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}




function UISubAct_TotalRecharge_simpleWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_TotalRecharge_simpleWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UISubAct_TotalRecharge_simpleWin:onShow(argtable,afterOnloaded)
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
end

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),6316,1,{},eAnimationID.enter)
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refresh(true,true)


self:setRemainingTimeTimer()
end


function UISubAct_TotalRecharge_simpleWin:onHide()
self:clearTimer()
end

function UISubAct_TotalRecharge_simpleWin:refresh(isInit,isResetModel)

self:refreshTaskPanel()


local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local totalRechargeRMB=math.floor(totalRechargeNum/10)
self.totalCount:setText(FMT.fmt("{0}",totalRechargeRMB))


self:refreshFreeReward()
end

function UISubAct_TotalRecharge_simpleWin:refreshTaskPanel()

self.taskSortList=self:getSortTaskList()
local taskCount=#self.taskSortList


self.taskScroller:setChildScrollViewCreateGrids(taskCount,0)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
self.finishAndNotGotList={}
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshTaskItem(i,widget)
end
end

function UISubAct_TotalRecharge_simpleWin:refreshTaskItem(i,widget)
local taskData=self.taskSortList[i]
local taskTargetRechargeNum=taskData.targetRechargeNum
local taskIndex=taskData.taskIndex

local targetStr
local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local totalRechargeRMB=math.floor(totalRechargeNum/10)
local taskTargetRechargeRMB=math.floor(taskTargetRechargeNum/10)
if taskData.isFinish then
targetStr=FMT.fmt("<color=#549327>{0}</color><color=#171311>/{1}</color>",totalRechargeRMB,taskTargetRechargeRMB)
else
targetStr=FMT.fmt("<color=#c82c2c>{0}</color><color=#171311>/{1}</color>",totalRechargeRMB,taskTargetRechargeRMB)
end
widget:SetChildText(taskItemIndex.titleText,FMT.fmt("累计获得（{0}）仙缘",targetStr))


local rewards=taskData.rewards or{}
local selectRewards=taskData.selectRewards or{}
local rewardsLen=#rewards
local hasSelect=next(selectRewards)~=nil
local isFinish=taskData.isFinish or false
local isGot=taskData.isGot or false

widget:SetChildLayoutGroupCreateItems(taskItemIndex.rewards,rewardsLen+#selectRewards)
local rwGrids=widget:GetChildLayoutGroupGridList(taskItemIndex.rewards)
for i=1,rwGrids.Count do
local rwWidget=rwGrids[i-1]
if i>rewardsLen then
i=i-rewardsLen
self:refreshSelectReward(rwWidget,taskIndex,i,selectRewards,isGot)
else
local reward=rewards[i]
self:refreshReward(rwWidget,reward)
end
end


local needSelect=false
local selectList={}
if isFinish and not isGot and hasSelect then
if hasSelect then
local selectData=self.activityData:getSelectDataByTaskIndex(taskIndex)or{}

for i,v in ipairs(selectRewards)do
if not selectData[i]then
needSelect=true
break
else
selectList[i]=selectData[i]
end
end
end
end


widget:SetChildActive(taskItemIndex.getRewardBtn,isFinish and not isGot)
widget:SetChildActive(taskItemIndex.gotoBtn,not isFinish and not isGot)

widget:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
if needSelect then
UIManager.error("需选定奖励后再领取")
else
self:onGetRewardBtn(taskIndex)
end

end)

if isFinish and not isGot and not needSelect then

self.finishAndNotGotList=self.finishAndNotGotList or{}
table.insert(self.finishAndNotGotList,taskIndex)
end
widget:SetChildButtonClick(taskItemIndex.gotoBtn,function()
self:onClickGotoBtn()
end)


widget:SetChildActive(taskItemIndex.gotFlag,isGot)


local isShowLayoutEmpty=i%2==0
widget:SetChildActive(taskItemIndex.empty,isShowLayoutEmpty)
end


function UISubAct_TotalRecharge_simpleWin:refreshTaskItemByTaskIndex(taskIndex)
for i,v in ipairs(self.taskSortList)do
if v.taskIndex==taskIndex then
local grid=self.taskScroller:getChildScrollViewItemWidget(i-1)
if grid then
self:refreshTaskItem(i,grid)
end
end
end
end

function UISubAct_TotalRecharge_simpleWin:refreshReward(rwWidget,reward)
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowEffect=reward.showEffect~=nil and reward.showEffect==1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=isShowEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)

rwWidget:SetChildActive(2,false)
rwWidget:SetChildActive(3,false)
rwWidget:SetChildActive(4,false)
rwWidget:SetChildActive(5,false)


rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

function UISubAct_TotalRecharge_simpleWin:refreshSelectReward(rwWidget,taskIndex,rewardIndex,selectRewards,isGot)
local reward=selectRewards[rewardIndex]
local selectid=reward[1]
local cfg=cfgHelper.get(cfg_rechargeact1selectconfig_get,selectid)
local selectIdx=self.activityData:getSelectData(taskIndex,rewardIndex)

local isSelected=selectIdx>0
rwWidget:SetChildActive(3,true)
if isSelected then
local item=cfg.selectlist[selectIdx]
local itemid=item[1]
local count=item[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isShowEffect=reward.showEffect==1 or reward[2]==1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=isShowEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildActive(0,true)
rwWidget:SetChildPropData(0,prop)

rwWidget:SetChildActive(2,false)

rwWidget:SetChildActive(4,true)
rwWidget:SetChildActive(5,false)

rwWidget:SetChildButtonClick(3,function()
if isGot then
itemsComponentHelper.onItemClick(itemid)
else
self:onClickSelectItem(taskIndex,rewardIndex)
end
end)

else
rwWidget:SetChildActive(0,false)
rwWidget:SetChildActive(2,true)
rwWidget:SetChildActive(4,false)
rwWidget:SetChildActive(5,false)

rwWidget:SetChildButtonClick(3,function()
if not isGot then
self:onClickSelectItem(taskIndex,rewardIndex)
end
end)
end





end

function UISubAct_TotalRecharge_simpleWin:getSortTaskList()
local allCfgList=self.config.recharge
local totalRechargeNum=self.activityData.data.totalRechargeNum or 0
local taskList={}
for i,v in ipairs(allCfgList)do
local targetRechargeNum=v[1]
local rewards=v[2]
local selectRewards=v[3]
local sortWeight=i
local isFinish=totalRechargeNum>=targetRechargeNum
local isGot=self.activityData:checkTaskIsGot(i)
if isFinish then
sortWeight=sortWeight-100
end
if isGot then
sortWeight=sortWeight+10000
end
local taskItem={
taskIndex=i,
targetRechargeNum=targetRechargeNum,
rewards=rewards,
selectRewards=selectRewards,
sortWeight=sortWeight,
isFinish=isFinish,
isGot=isGot,
}
table.insert(taskList,taskItem)
end
table.sort(taskList,function(a,b)
return a.sortWeight<b.sortWeight
end)

return taskList
end

function UISubAct_TotalRecharge_simpleWin:refreshFreeReward()

local isGot=self.activityData:reqTotalRecharge_checkFreeRewardsIsGot()


self.freeRewardBtn:setActive(not isGot)
end


function UISubAct_TotalRecharge_simpleWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

if self.nextRefreshTime and nowTime>=self.nextRefreshTime then
self:initDate()
self:refresh()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_TotalRecharge_simpleWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end





function UISubAct_TotalRecharge_simpleWin:onFreeRewardBtn()

local isGot=self.activityData:reqTotalRecharge_checkFreeRewardsIsGot()
if isGot then

return
end


self.activityData:reqTotalRecharge_getFreeRewards()
end



function UISubAct_TotalRecharge_simpleWin:onHelpBtn()
local rule_str="每充值1元可获得1仙缘"
local pos=Vector2.New(16,15)
self:showWindow('UIConditionTipsOne',{str=rule_str,posItem=self.helpBtn,pos=pos,showType=2})
end

function UISubAct_TotalRecharge_simpleWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_TotalRecharge_simpleWin:onGetRewardBtn(taskIndex,selectList)














if self.finishAndNotGotList and next(self.finishAndNotGotList)then
self.activityData:reqTotalRecharge_getTaskReward(self.finishAndNotGotList)
else
UIManager.error("没有可领取的奖励")
end
end

function UISubAct_TotalRecharge_simpleWin:onClickSelectItem(taskIndex,clickIndex)

self:showWindow("UIRechargeSelectLiBao_selectWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,taskIndex=taskIndex,defaultSelect=clickIndex,selectCall=function(selectIdxList)
local select=false
for i,v in ipairs(selectIdxList)do
if v>0 then select=true break end
end
if select then
self.activityData:reqTotalRecharge_selectTaskReward(taskIndex,selectIdxList)
end

end})
end


function UISubAct_TotalRecharge_simpleWin:onClickGotoBtn()
if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then

local data,dataLen=firstRechargeModel:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRechargeModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRechargeModel:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRechargeModel:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then

local data,dataLen=firstRechargeNewModel:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRechargeNewModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRechargeNewModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRechargeNewModel:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRechargeNewModel:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin2",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then

local data,dataLen=firstRecharge3Model:getFirstRechargeAllData()

if dataLen then
local sortCfgList=firstRecharge3Model:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isCanShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if isCanShow and not firstRecharge3Model:checkIsBought(rechargeId)then

local dayIndex=1
local tabIndex=firstRecharge3Model:getShowTabIndexByRechargeId(rechargeId)
return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return UIManager:showWindow("UIFirstRechargeWin3",{id=tabIndex,dayIndex=dayIndex})
end)
end
end
end
end


local tabType
if not tabType and systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then

local isBought=not rechargeController:checkDailyTeHuiTenDayIsExpire()
if not isBought then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHui
end
end

if not tabType and systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then

local libaoAllCfg=cfg_daydiscountsnewconfig()
local isGotAll=true
for i,v in ipairs(libaoAllCfg)do
if v.recharge_id then

local isBought=rechargeModel:checkDailyTeHuiSingleDayGotByIndex(v.id)
if not isBought then
isGotAll=false
break
end
end
end

if not isGotAll then
tabType=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay
end
end

if not tabType then

local config=cfg_limitedgiftconfig()
local giftType=1
for i,v in pairs(config)do
if v.gifttype==giftType then
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local sellOut=buyNum>=v.maxcount
local rechargeid=v.rechargeid
if not sellOut and rechargeid then
tabType=FULL_TAB_TYPE.eReChargeLiBao
break
end
end
end
end

if not tabType then
tabType=FULL_TAB_TYPE.eRecharge
end
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=tabType}})
end