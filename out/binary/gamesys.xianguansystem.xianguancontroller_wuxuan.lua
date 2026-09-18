function xianguanController:onAppStart_WuXuan()
socketManager:register_receiver(40,21,self.recv_40_21)
socketManager:register_receiver(40,22,self.recv_40_22)
socketManager:register_receiver(40,23,self.recv_40_23)
socketManager:register_receiver(40,24,self.recv_40_24)
socketManager:register_receiver(40,25,self.recv_40_25)
socketManager:register_receiver(40,26,self.recv_40_26)
socketManager:register_receiver(40,27,self.recv_40_27)
socketManager:register_receiver(40,28,self.recv_40_28)
socketManager:register_receiver(40,29,self.recv_40_29)
socketManager:register_receiver(40,30,self.recv_40_30)
xianguanModel:initWuXuanConfig()
end

function xianguanController:onEnterState_WuXuan()
end

function xianguanController:onLeaveState_WuXuan()
xianguanModel:clearWuXuanData()
xianguanModel:clearWuXuanShareTime()
xianguanModel:clearData_WuXuan_BW()
end

function xianguanController:onNewWeek_WuXuan()
if xianguanModel:checkWuXuanPlatformOpen()then
xianguanController:send_40_21()
end
end

function xianguanController:onNormalUpdate_WuXuan(lastTime)
if not xianguanModel:checkWuXuanPlatformOpen()then return end

local activityData=xianguanModel:getWuXuanActivityData()
if activityData then
local nowTime=timeHelper.getServerShortTime()

if activityData.thisWeek then
local segmentData=activityData.segmentData

if nowTime>=segmentData.endTime and(not xianguanController:isInMatchStage_enter_WuXuan_BW())then
if timeHelper.checkInSameWeek4(activityData.weekBTime)then
local old=segmentData.status
xianguanModel:refreshWuXuanActivitySegmentData(nowTime)
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan,old)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
else
local intervalWeek=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"rest_week")
local intervalSec=(intervalWeek+1)*86400*7
xianguanModel:initWuXuanActivityData(activityData.weekBTime+intervalSec)
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
end
end
if lastTime<activityData.resultTime and nowTime>=activityData.resultTime then
xianguanModel:addMsgJingXuanResultType(XianGuanCampaignType.eWuXuan)
msgWinControl:addMsgWin(msgWinType.eXianGuanJingXuanResult,nil,{delay=self.delayJingXuanResultTime,matchType=1},true)
end
else
local nextTime=activityData.nextTime
if nextTime and nowTime>=nextTime then
xianguanModel:initWuXuanActivityData(nextTime)
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
end
end
end
end


function xianguanController:send_40_21()
socketManager:send_40_21()
end


function xianguanController:send_40_22()
socketManager:send_40_22()
end


function xianguanController:send_40_23_attend(job,declaretion,discipleGuids)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
socketManager:send_40_23(job,declaretion,#discipleGuids,discipleGuids,0)
end

function xianguanController:send_40_23_cancel()
socketManager:send_40_23(0,0,0,{},1)
end


function xianguanController:send_40_24(discipleGuids)
socketManager:send_40_24(#discipleGuids,discipleGuids)
end


function xianguanController:send_40_25(declaration)
socketManager:send_40_25(declaration)
end


function xianguanController:send_40_26(bitIdx)
socketManager:send_40_26(bitIdx)
end












function xianguanController:send_40_28(job,actorIdx)
socketManager:send_40_28(job,actorIdx)
end


function xianguanController:send_40_29()
socketManager:send_40_29()
end



function xianguanController.recv_40_21(beginTime,groupLen,groupList)
if groupLen>0 then
for _,v in ipairs(groupList)do
if v.len>0 then
for _,vv in ipairs(v.attend_list)do
if vv.disciple_list_len>0 then
for _,vvv in ipairs(vv.discilpe_list)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vvv.dzAttrList)
end
end
end
end
end
end
xianguanModel:initWuXuanActivityData(beginTime,groupList)
xianguanModel:initActivityData_WuXuan_BW(beginTime,groupList)
xianguanController:refresUpdateState()
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWuXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
end


function xianguanController.recv_40_22(args)
local jobId=args[1]
local declaration=args[2]
local discipleLen=args[3]
local discipleList=args[4]
local free_flag=args[5]
local inspire_job=args[6]
local inspire_actor=args[7]
local last_share_time=args[8]


local registerStamp=args[9]
xianguanModel:initWuXuanPlayerData(jobId,declaration,discipleList,free_flag,inspire_job,inspire_actor,last_share_time,registerStamp)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanJingXuan)
end


function xianguanController.recv_40_23(args)
local jobId=args[1]
local declaration=args[2]
local discipleLen=args[3]
local discipleGuids=args[4]
local isCancel=args[5]
local cancelStamp=args[6]
if isCancel==1 then
xianguanModel:setWuXuanPlayerData1(0,0,nil)
xianguanModel:setWuXuanPlayerData6(cancelStamp)

UIManager.info("取消参选成功")
else
xianguanModel:setWuXuanPlayerData1(jobId,declaration,discipleGuids)
xianguanModel:setWuXuanPlayerData6(cancelStamp)

UIManager.info("参选成功")
end
end


function xianguanController.recv_40_24(discipleLen,discipleGuids)
xianguanModel:setWuXuanPlayerData3(discipleGuids)

UIManager.info("调整队伍成功")
end


function xianguanController.recv_40_25(declaration)
xianguanModel:setWuXuanPlayerData2(declaration)

UIManager.info("修改宣言")
end


function xianguanController.recv_40_26(bitIdx)
xianguanModel:setWuXuanPlayerData5(bitIdx)

notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWuXuan)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanJingXuan)
end


function xianguanController.recv_40_27(time)

xianguanModel:markWuXuanShareTime(time)
UIManager.info("分享成功")
end


function xianguanController.recv_40_28(job,actorIdx)
xianguanModel:setWuXuanPlayerData4(job,actorIdx)
UIManager.info("鼓舞成功")
end


function xianguanController.recv_40_29(len,battle_list)
xianguanModel:updateWuXuanMatchData(battle_list)
end


function xianguanController.recv_40_30(job,len,attend_list)
if len>0 then
for _,v in ipairs(attend_list)do
if v.disciple_list_len>0 then
for _,vv in ipairs(v.discilpe_list)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
xianguanModel:updateWuXuanRegisterData(job,attend_list)
end

function xianguanController:watchWuXuanBattle(job,round,index)
local matchData=xianguanModel:getWuXuanMatchSingleData(job,round,index)
if matchData and matchData.fight_log_id~=""then
local args={nil,matchData.fight_log_id,eRePlayerType.xianguanwuxuanlog,job,round,index}
fightController:send_254_29(matchData.fight_log_id,args,true,false,nil)
end
end