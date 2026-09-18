











welfareController=gameState.addListener({})






function welfareController:onAppStart()

welfareModel:onAppStart()
welfareController:onAppStart_ActivityCalendar()
welfareController:onAppStart_WXAddReward()


socketManager:register_receiver(6,60,welfareController.recv_6_60)
socketManager:register_receiver(6,61,welfareController.recv_6_61)
socketManager:register_receiver(6,62,welfareController.recv_6_62)

socketManager:register_receiver(6,66,welfareController.recv_6_66)
socketManager:register_receiver(6,67,welfareController.recv_6_67)

socketManager:register_receiver(6,68,welfareController.recv_6_68)
socketManager:register_receiver(6,69,welfareController.recv_6_69)

socketManager:register_receiver(6,186,welfareController.recv_6_186)
socketManager:register_receiver(6,187,welfareController.recv_6_187)

socketManager:register_receiver(6,77,welfareController.recv_6_77)

socketManager:register_receiver(6,88,welfareController.recv_6_88)
socketManager:register_receiver(6,89,welfareController.recv_6_89)
socketManager:register_receiver(6,90,welfareController.recv_6_90)

socketManager:register_receiver(14,17,welfareController.recv_14_17)
socketManager:register_receiver(14,18,welfareController.recv_14_18)
socketManager:register_receiver(14,19,welfareController.recv_14_19)

socketManager:register_receiver(32,1,welfareController.recv_32_1)
socketManager:register_receiver(32,2,welfareController.recv_32_2)
socketManager:register_receiver(32,3,welfareController.recv_32_3)
socketManager:register_receiver(32,4,welfareController.recv_32_4)
socketManager:register_receiver(32,5,welfareController.recv_32_5)
socketManager:register_receiver(32,6,welfareController.recv_32_6)

socketManager:register_receiver(32,21,welfareController.recv_32_21)
socketManager:register_receiver(32,22,welfareController.recv_32_22)
socketManager:register_receiver(32,23,welfareController.recv_32_23)
socketManager:register_receiver(32,24,welfareController.recv_32_24)

socketManager:register_receiver(254,91,welfareController.recv_254_91)
socketManager:register_receiver(254,92,welfareController.recv_254_92)
socketManager:register_receiver(254,93,welfareController.recv_254_93)








end

function welfareController.onCloseUI(name)
if name=="UIZongmenLevelUpWin"then
if systemModel.isOpen(SYSTEM_DEFINE.eGuildGift)and welfareController.isOpenGuildGift then

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.guildgiftLuaFunc)
end
end
end

function welfareController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eGuildGift then
welfareController.isOpenGuildGift=true
elseif sysId==SYSTEM_DEFINE.eYaoQingMa and houtaiModel:isOpenYaoQingMa()then


reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end

function welfareController.on_building_event(etype,level,exp,lastLv)
if etype==buildingEvent.zongmenLevelUp then

local allGradeList=cfgHelper.get2(cfg_tiantianfanliactconfig_get,1,'czDangCi')
local hasInitData=false
for i,gradeId in ipairs(allGradeList)do
local isOpen=welfareModel:checkDailyRebateGradeOpenLimit(gradeId)
local hasData=welfareModel:getDailyRebateDataByGradeId(gradeId)~=nil
if not hasData and isOpen then

welfareModel:setDailyRebateGradeData(gradeId)
hasInitData=true
end
end

if hasInitData then

UIManager:invokeUIMethod('UIDailyRebateWin','refresh',true,true,true,true)
end


local invitationTaskType=1
welfareController.checkInvitationTaskDataUpdate(invitationTaskType,level)





reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end

function welfareController.onNewDay()

local allGradeList=cfgHelper.get2(cfg_tiantianfanliactconfig_get,1,'czDangCi')
local hasInitData=false
for i,gradeId in ipairs(allGradeList)do
local isOpen=welfareModel:checkDailyRebateGradeOpenLimit(gradeId)
local hasData=welfareModel:getDailyRebateDataByGradeId(gradeId)~=nil
if not hasData and isOpen then

welfareModel:setDailyRebateGradeData(gradeId)
hasInitData=true
end
end

if hasInitData then

UIManager:invokeUIMethod('UIDailyRebateWin','refresh',true,true,true,true)

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
if welfareModel:checkWXGameCircleOpen()then

if welfareModel:checkWXGameCircleNextRound()then
welfareModel:NextRoundWXGameCircle()
UIManager:invokeUIMethod('UIWXGameCircleWin','refreshTitle')
UIManager:invokeUIMethod('UIWXGameCircleWin','refreshTaskItemList')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
else
local data=welfareModel:getData_WXGameCircle()
if data then
data.today=0
end
end
end
welfareController.onNewDay_ActivityCalendar()
welfareController.onNewDay_WXAddReward()
end

function welfareController.onNewWeek()
reddotControl.on_change_catch_type(CATCH_TYPE.eSheQuAct)
end

function welfareController.onZongMenFightChange(oldVal,fight)

local invitationTaskType=2
welfareController.checkInvitationTaskDataUpdate(invitationTaskType,fight)
end


function welfareController.checkInvitationTaskDataUpdate(invitationTaskType,param)

local nowBindingCode=welfareModel:getBindInvitationCode()
if not nowBindingCode or mathHelper.compareInt64(nowBindingCode,int64.new('0'))then

return
end


local targetCfgList=cfg_yaoqingmaconfig()
for _,v in ipairs(targetCfgList)do
local taskParam
for _,taskCfg in ipairs(v.taskInfo)do
local taskType=taskCfg[1]
if not invitationTaskType then
if taskType==1 then
param=zongmenModel:getLevel()
elseif taskType==2 then
param=playerModel:getActorFightValue()
end
taskParam=taskCfg[2]
break
else
if taskType==invitationTaskType then
taskParam=taskCfg[2]
break
end
end
end
local taskId=v.id
if taskParam and param>=taskParam then

local isUpDate=welfareModel:checkInvitationUpdateTaskById(taskId)
if not isUpDate then

welfareController:reqInvitationCodeUpdateTaskData(taskId)
end
end
end
end


function welfareController:onEnterState()
welfareModel:onEnterState()
welfareController:onEnterState_ActivityCalendar()
welfareController:onEnterState_WXAddReward()
self.isOpenGuildGift=nil
notifySystem:listenNotify(notifyConfig.closeUI,self.onCloseUI)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.onZongMenFightChange,self.onZongMenFightChange)
end


function welfareController:onServerDataInitFinish()
welfareModel:onServerDataInitFinish()
welfareController:onServerDataInitFinish_ActivityCalendar()
welfareController:onServerDataInitFinish_WXAddReward()
end

function welfareController:onProtocolReq()
welfareModel:onProtocolReq()
welfareController:onProtocolReq_ActivityCalendar()
welfareController:onProtocolReq_WXAddReward()
end


function welfareController:onLeaveState()
welfareModel:onLeaveState()
welfareController:onLeaveState_ActivityCalendar()
welfareController:onLeaveState_WXAddReward()
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.closeUI,self.onCloseUI)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:removelistener(notifyConfig.onZongMenFightChange,self.onZongMenFightChange)

self.data={}
end


function welfareController:onLostConnection()
welfareController:onLostConnection_ActivityCalendar()
welfareController:onLostConnection_WXAddReward()
end

function welfareController:checkSelfInvitationCode()
if not welfareModel:isOpenYaoQingMa()then
return false
end
local nowZmLevel=zongmenModel:getLevel()
local const_def=cfg_yaoqingmaconfig().const_def
local targetZmLevel=const_def.openLv
if nowZmLevel>=targetZmLevel then








welfareController:reqInvitationCodeCreate()
end
end

function welfareController:checkSelfReturnCode()
if not welfareModel:checkXianYouZhaoHuiOpen()then
return false
end
local nowZmLevel=zongmenModel:getLevel()
local const_def=cfg_yaoqingmaconfig().const_def
local targetZmLevel=const_def.openLv
if nowZmLevel>=targetZmLevel then

welfareController:reqInvitationCodeCreate()
end
end



function welfareController:reqDailySignInData()
socketManager:send_6_60()
end


function welfareController:reqDailySignInGetLeiJiReward(isAssistant)
local assistantFlag=isAssistant and 1 or 0
socketManager:send_6_61(assistantFlag)
end


function welfareController:reqDailySignInGetReward(isAssistant)
local assistantFlag=isAssistant and 1 or 0
socketManager:send_6_62(assistantFlag)
end


function welfareController:reqSevenDaySignInData()
socketManager:send_6_66()
end


function welfareController:reqSevenDaySignInGetReward()
socketManager:send_6_67()
end


function welfareController:reqZongmenLevelInvestorGetReward(taskId)
socketManager:send_6_69(taskId)
end


function welfareController:reqZongmenLevelInvestorGetReward2(taskId)
socketManager:send_6_187(taskId)
end


function welfareController:reqLoginReward(day)
socketManager:send_6_89(day)
end


function welfareController:reqDailyRebateData()
socketManager:send_14_17()
end


function welfareController:reqDailyRebateGetFreeReward(gradeId)
socketManager:send_14_18(gradeId)
end


function welfareController:reqDailyRebateGetRoundReward(gradeId)
socketManager:send_14_19(gradeId)
end


function welfareController:reqInvitationCodeCreate()
socketManager:send_32_1()
end


function welfareController:reqInvitationCodeBind(invitationCodeNum_int_64)
socketManager:send_32_2(invitationCodeNum_int_64)
end


function welfareController:reqInvitationCodeUpdateTaskData(taskId)
socketManager:send_32_3(taskId)
end


function welfareController:reqGetInvitationTaskData()
socketManager:send_32_4()
end


function welfareController:reqInvitationCodeGetTaskReward(taskId)
socketManager:send_32_5(taskId)
end


function welfareController:reqInvitedDataList()
socketManager:send_32_6()
end


function welfareController:reqReturnCodeBind(returnCodeNum_int_64)
socketManager:send_32_21(returnCodeNum_int_64)
end


function welfareController:reqGetReturnCodeData()
socketManager:send_32_22()
end


function welfareController:reqReturnCodeGetTaskReward(taskId)
socketManager:send_32_23(taskId)
end


function welfareController:reqReturnCodePlayerData()
socketManager:send_32_24()
end


function welfareController:reqGetInvitedFreeReward()
if welfareModel:checkInvitationFreeRewardCanGet()then
local const_def=cfg_yaoqingmaconfig().const_def
local giftId=const_def.freeRewardId
if giftId then
return FreeGiftController.SendFreeGift(giftId,nil,function(result)
if result then

local win=UIManager:findActiveWindow('UIInvitationCodeWin')
if win then
win:refreshInputCodePanel()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end)
end
end
end

function welfareController:reqGetXianYouZhaoHuiFreeReward()
if welfareModel:checkXianYouZhaoHuiFreeRewardCanGet()then
local const_def=cfg_zhaohuimaconfig().const_def
local giftId=const_def.zhmFreeReward
if giftId then
local openTime=const_def.opentime
return FreeGiftController.SendFreeGift(giftId,{openTime[1],openTime[2],const_def.min_openday},function(result)
if result then

local win=UIManager:findActiveWindow('UIXianYouZhaoHuiWin')
if win then
win:refreshFreeReward()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end)
end
end
end

function welfareController:reqGetHuiGuiBangDingFreeReward()
if welfareModel:checkHuiGuiBangDingFreeRewardCanGet()then
local const_def=cfg_zhaohuimaconfig().const_def
local giftId=const_def.bindFreeReward
if giftId then
local openTime=const_def.opentime
return FreeGiftController.SendFreeGift(giftId,{openTime[1],openTime[2],const_def.min_openday},function(result)
if result then

local win=UIManager:findActiveWindow('UIHuiGuiBangDingWin')
if win then
win:refreshFreeReward()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end)
end
end
end


function welfareController:reqWXGameCircleData()
socketManager:send_254_91()
end


function welfareController:reqWXGameCircleSignIn()
socketManager:send_254_92()
end


function welfareController:reqWXGameCircleReward(idx)
socketManager:send_254_93(idx)
end



function welfareController.recv_6_60(confId,day,rwListLen,rwList)
welfareModel:setDailySignInData(confId,day,rwListLen,rwList)

local win=UIManager:findActiveWindow('UIDailySignInWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_61(result)
if result==1 then
return
end


welfareModel:setDailySignInLeiJiRewardFlag(result)















local win=UIManager:findActiveWindow('UIDailySignInWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_62(rwListLen,rwList)











welfareModel:setDailySignInRewardList(rwListLen,rwList)















local win=UIManager:findActiveWindow('UIDailySignInWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end



function welfareController.recv_6_66(qdListLen,qdList)
welfareModel:setSevenDaySignInData(qdListLen,qdList)

local win=UIManager:findActiveWindow('UISevenDaySignInWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_6_67(qdListLen,qdList)

local signInData=welfareModel:getSevenDaySignInData()
local getRewardStart=1
local getRewardEnd=qdListLen
for i=1,signInData.signInDayListLen do
if signInData.signInDayList[i].rewardFlag==0 then
getRewardStart=i
break
end
end
local rewardList=welfareModel:getSevenDaySignInRewardByDayRange(getRewardStart,getRewardEnd)

welfareModel:setSevenDaySignInData(qdListLen,qdList)


local conf={}
for k,v in ipairs(rewardList)do
local itemid=v[1]
local itemConfig=itemsConfig.getConfig(itemid)
table.insert(conf,{itemid=itemid,num=v[2],color=itemConfig.color})
end
table.sort(conf,function(a,b)return a.color>b.color end)

showPrizeControl.showWindowNow(conf)


local win=UIManager:findActiveWindow('UISevenDaySignInWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end



function welfareController.recv_6_68(len,gotRewardList,recharge_id)
welfareModel:setZongmenLevelInvestorData(len,gotRewardList,recharge_id)

local win=UIManager:findActiveWindow('UIZongmenLevelInvestorWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_69(taskId)


welfareModel:setZongmenLevelInvestorTaskStateByTaskId(taskId)

local win=UIManager:findActiveWindow('UIZongmenLevelInvestorWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_186(len,gotRewardList,recharge_id)
welfareModel:setZongmenLevelInvestorData2(len,gotRewardList,recharge_id)

local win=UIManager:findActiveWindow('UIZongmenLevelInvestorWin2')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_187(taskId)


welfareModel:setZongmenLevelInvestorTaskStateByTaskId2(taskId)

local win=UIManager:findActiveWindow('UIZongmenLevelInvestorWin2')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_6_77(len,flagList,aLen,againList)
welfareModel:setKaiZongGiftFlag(flagList)
welfareModel:setKaiZongGiftAgainFlag(againList)
local win=UIManager:findActiveWindow('UIWelfare_kaizonggift_win')
if win then
win:onRefresh()
end
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_6_88(datas)
welfareModel:setLoginRewardData(datas)

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_6_89(day)
local data=welfareModel:getLoginRewardData()
data.recv_day1=day
if data.recharge_id>0 then
data.recv_day2=day
end
UIManager:callWindowFunc('UILoginRewardWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_6_90(id)
local data=welfareModel:getLoginRewardData()
data.recharge_id=id
UIManager:callWindowFunc('UILoginRewardWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_14_17(len,rebateDataList)
welfareModel:setDailyRebateData(len,rebateDataList)


UIManager:invokeUIMethod('UIDailyRebateWin','refresh',true,true,true,true)

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_14_18(gradeId,roundIndex,gotFlag)
welfareModel:setDailyRebateFreeRewardGotFlag(gradeId,roundIndex,gotFlag)

UIManager:invokeUIMethod('UIDailyRebateWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_14_19(gradeId,roundIndex,maxGotDay)
welfareModel:setDailyRebateMaxGotDay(gradeId,roundIndex,maxGotDay)


UIManager:invokeUIMethod('UIDailyRebateWin','refresh',nil,nil,true,true)

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end



function welfareController.recv_32_1(yqm_id)
welfareModel:setSelfInvitationCode(yqm_id)
welfareModel:setSelfReturnCode(yqm_id)

UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitationPanel',true)

UIManager:invokeUIMethod('UIShareImageFrameWin','refreshInvitationCode')

UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitationPanel',true)
end


function welfareController.recv_32_2(ret,yqm_id)
if ret==0 then
welfareModel:setBindInvitationCode(yqm_id)


UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInputCodePanel')


welfareController.checkInvitationTaskDataUpdate()
else
UIManager.error("邀请码错误")
end
end


function welfareController.recv_32_3(ret,task_id)
if ret==0 then
welfareModel:setInvitationUpdateTaskById(task_id)
end
end


function welfareController.recv_32_4(args)

local self_yqm=args[1]
local bind_yqm=args[2]
local updateTaskCount=args[3]
local updateTaskList=args[4]
local finishTaskCount=args[5]
local taskDataList=args[6]
welfareModel:setSelfInvitationCode(self_yqm)
welfareModel:setBindInvitationCode(bind_yqm)
local oldFinishTaskCount=welfareModel:getInvitationAllFinishTaskCount()
welfareModel:setInvitationTaskData(updateTaskCount,updateTaskList,finishTaskCount,taskDataList)

UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitationPanel',true)
UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitationPanel_targetPage')
UIManager:invokeUIMethod('UIInvitationCodeWin','refreshTargetListBtnReddot')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)

if oldFinishTaskCount~=finishTaskCount then

if UIManager:isActive('UIInvitationCodeWin')then
welfareController:reqInvitedDataList()
end
end


local shareGotRewardCount=args[7]
local shareDataList=args[8]
shareImageModel:setShareRewardAllGotNum(shareGotRewardCount)
shareImageModel:setShareRewardGotNumList(shareDataList)


welfareController.checkInvitationTaskDataUpdate()
end


function welfareController.recv_32_5(task_id,get_num)
welfareModel:setInvitationTaskGotCountByTaskId(task_id,get_num)


UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitationPanel_targetPage')
UIManager:invokeUIMethod('UIInvitationCodeWin','refreshTargetListBtnReddot')


reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function welfareController.recv_32_6(num,dataList)
welfareModel:setInvitedData(num,dataList)

UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitedCount')
UIManager:invokeUIMethod('UIInvitationCodeWin','refreshInvitationPanel_invitedPage')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end







function welfareController:test_reqInvitationCodeBind(codeStr)
local codeNum=mathHelper.convert35SystemToDecimal(codeStr)
local codeNum_int_64=mathHelper.number_to_int64(codeNum)

welfareController:reqInvitationCodeBind(codeNum_int_64)
end



function welfareController.recv_32_21(ret,zhm_id)
if ret==0 then
welfareModel:setBindReturnCode(zhm_id)

UIManager:invokeUIMethod('UIHuiGuiBangDingWin','refreshInputCodePanel')

UIManager:invokeUIMethod('UIHuiGuiBangDingDialogWin','onShow')

UIManager:invokeUIMethod('UIShareImageFrameWin','refreshInvitationCode')
else
UIManager.error("回归码输入错误")
end
end

function welfareController.recv_32_22(self_zhm,bind_zhm,invite_num,reward_idx)
local oldReturnCodeInviteNum=welfareModel:getReturnCodeInviteNum()
if oldReturnCodeInviteNum~=invite_num then

if UIManager:isActive('UIXianYouZhaoHuiWin')then
welfareController:reqReturnCodePlayerData()
end
end
welfareModel:setReturnCodeData(self_zhm,bind_zhm,invite_num,reward_idx)

UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitationPanel',true)
UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitationPanel_targetPage')
UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshTargetListBtnReddot')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_32_23(reward_idx)
welfareModel:setReturnCodeRewardIdx(reward_idx)

UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitationPanel_targetPage')
UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshTargetListBtnReddot')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function welfareController.recv_32_24(invite_num,zhmInviteInfo)
welfareModel:setReturnCodePlayerData(invite_num,zhmInviteInfo)

UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitedCount')
UIManager:invokeUIMethod('UIXianYouZhaoHuiWin','refreshInvitationPanel_invitedPage')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end







function welfareController.recv_254_91(round,day,flag,today)
local data={}
data.round=round
data.day=day
data.flag=flag
data.today=today
welfareModel:setData_WXGameCircle(data)



end


function welfareController.recv_254_92()
local data=welfareModel:getData_WXGameCircle()
if not data or not data.day then
logErr("微信签到没有data/data.day数据")
return
end
data.day=data.day+1
data.today=1
UIManager:invokeUIMethod('UIWXGameCircleWin','refreshTitle')
UIManager:invokeUIMethod('UIWXGameCircleWin','refreshTaskItemList')


reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)

end



function welfareController.recv_254_93(idx)
local data=welfareModel:getData_WXGameCircle()
if not data or not data.flag then
logErr("微信签到没有data/data.flag数据")
return
end
data.flag=mathHelper.setbit(data.flag,idx-1)
UIManager:invokeUIMethod('UIWXGameCircleWin','refreshTaskItemList')

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end






function welfareController:hasReddot()
local hasReddot=false

if welfareModel:checkDailySignInReddot()
or welfareModel:checkSevenDaySignInReddot()
or welfareModel:checkZongmenLevelInvestorReddot()
or welfareModel:checkCdKeyReddot()
or welfareModel:checkKaiZongReddot()
or welfareModel:checkLoginRewardReddot()
or welfareModel:checkDailyRebateEnterReddot()
or welfareModel:checkInvitationCodeEnterReddot()
or(welfareModel:checkXianYuanShareOpen()and xianyuanShareModel:getReddot())
or welfareModel:checkGuanZhuActReddot()
or welfareModel:checkWeekendWelfareReddot()
or welfareModel:checkXianYouZhaoHuiReddot()
or welfareModel:checkHuiGuiBangDingReddot()
or welfareModel:checkWXGameCircleReddot()
then
hasReddot=true
end
return hasReddot
end









