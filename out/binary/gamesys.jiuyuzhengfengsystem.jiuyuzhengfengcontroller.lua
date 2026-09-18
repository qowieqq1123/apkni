






local _MODULENAME="JiuYuZhengFengController"

gameState.addListener(def_table(_MODULENAME))
JiuYuZhengFengController.name=_MODULENAME
JiuYuZhengFengController.data={}

function JiuYuZhengFengController:onAppStart()

JiuYuZhengFengModel:onAppStart()

socketManager:register_receiver(35,240,JiuYuZhengFengController.recv_35_240)
socketManager:register_receiver(35,241,JiuYuZhengFengController.recv_35_241)
socketManager:register_receiver(35,242,JiuYuZhengFengController.recv_35_242)

end


function JiuYuZhengFengController:onEnterState(isReconnect)
JiuYuZhengFengModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
self.onEnterStateFlag=true
end


function JiuYuZhengFengController:onProtocolReq()
JiuYuZhengFengModel:onProtocolReq()

end


function JiuYuZhengFengController:onLeaveState(isReconnect)
JiuYuZhengFengModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)

self.data={}
self.onEnterStateFlag=false
end


function JiuYuZhengFengController:onLostConnection()

end


function JiuYuZhengFengController:onReConnection(isInitPro)

end




function JiuYuZhengFengController.req_35_240()
socketManager:send_35_240()
end



function JiuYuZhengFengController.req_35_241(cross_id)
socketManager:send_35_241(cross_id)
end


function JiuYuZhengFengController.req_35_242()
socketManager:send_35_242()
end

















function JiuYuZhengFengController.recv_35_240(len,logList)
if logList then
table.sort(logList,function(a,b)
return a.log_time>b.log_time
end)
end
JiuYuZhengFengModel:setLogList(logList)
UIManager:invokeUIMethod("UIJYZF_RecordWin","onShow")
end











function JiuYuZhengFengController.recv_35_241(cross_id,len,scoreList)
JiuYuZhengFengModel:setScoreList(cross_id,scoreList)
UIManager:invokeUIMethod("UIJYZF_RankWin","recvData_35_241",cross_id)
end



function JiuYuZhengFengController.recv_35_242(args)
local data={}
data.is_open=args[1]
data.is_spe_state=args[2]
data.rank_level=args[3]
data.pf_id=args[4]
data.rank_len=args[5]
data.rankList=args[6]
data.new_score=args[7]
data.is_settle=args[8]
if data.rank_len>0 then
for i=data.rank_len,1,-1 do
if data.rankList[i].param_2==0 then
table.remove(data.rankList,i)
end
end
table.sort(data.rankList,function(a,b)
if a.param_2==b.param_2 then
return a.param_1<b.param_1
else
return a.param_2>b.param_2
end
end)















end

JiuYuZhengFengModel:setData(data)
if JiuYuZhengFengController.onEnterStateFlag then
JiuYuZhengFengController.onEnterStateFlag=false
JiuYuZhengFengController:checkAddReqTimer()
JiuYuZhengFengController:checkAddFinshTimer()
JiuYuZhengFengController:checkAddStopTimer()
end
UIManager:invokeUIMethod("UIJYZF_RankWin","onShow")
UIManager:invokeUIMethod("UIXianGongMainWin","refreshJYZFButton")
if not JiuYuZhengFengController:checkSysOpen()then
UIFullJiuYuZhengFengController:closeUI()
end
end






function JiuYuZhengFengController:checkShowStageChangeWin()

local curLevel=JiuYuZhengFengModel:getData_rank_level()
if not curLevel then
return
end

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eJYZFStageChange,{})
local lastLevel=localCfg.lastLevel


if not lastLevel then
localCfg.lastLevel=curLevel
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eJYZFStageChange,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eJYZFStageChange)
return
end

if lastLevel==curLevel then
return
end
localCfg.lastLevel=curLevel
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eJYZFStageChange,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eJYZFStageChange)
if curLevel==0 then
return false
end
return true,lastLevel,curLevel
end


function JiuYuZhengFengController:checkSysOpen()

if JiuYuZhengFengModel:getData_is_open()~=1 then
return false
end

if JiuYuZhengFengModel:getData_is_settle()==1 then
return false
end










return true
end


function JiuYuZhengFengController:checkAddReqTimer()

if not JiuYuZhengFengController:checkSysOpen()then
return
end
local cfg=cfg_xianyulevelbasicconfig_get(1)
local daily_update_time=cfg.daily_update_time
local updateFinishTime=daily_update_time[2]
local todayPass=timeHelper.getServerTodayPass()
local rPass=updateFinishTime[1]*3600+updateFinishTime[2]*60
local left=rPass-todayPass

if left>0 then
local curseverSecond=timeHelper.getServerShortTime()
timeEventController.removeTimingHandler(JiuYuZhengFengController.req_35_242)
timeEventController.addTimingHandler(curseverSecond+left,1,JiuYuZhengFengController.req_35_242)
end
end

function JiuYuZhengFengController.onNewDay()
JiuYuZhengFengController:checkAddReqTimer()
end


function JiuYuZhengFengController:checkAddFinshTimer()

if not JiuYuZhengFengController:checkSysOpen()then
return
end

local pfId=JiuYuZhengFengModel:getData_pfId()
local baseCfg=cfg_xianyulevelbasicconfig_get(1)
local settle_time=baseCfg.settle_time
if settle_time and settle_time[pfId]then
local targetTime=timeHelper.convertShortStamp(timeHelper.dataToTimeStam(settle_time[pfId][2]))+5
if targetTime>timeHelper.getServerShortTime()then
timeEventController.removeTimingHandler(JiuYuZhengFengController.finshFunc)

timeEventController.addTimingHandler(targetTime,1,JiuYuZhengFengController.finshFunc)
end
end
end

function JiuYuZhengFengController.finshFunc()

JiuYuZhengFengController.req_35_242()
end



function JiuYuZhengFengController:checkAddStopTimer()

if not JiuYuZhengFengController:checkSysOpen()then
return
end

local pfId=JiuYuZhengFengModel:getData_pfId()
local baseCfg=cfg_xianyulevelbasicconfig_get(1)
local settle_time=baseCfg.settle_time
if settle_time and settle_time[pfId]then
local targetTime=timeHelper.convertShortStamp(timeHelper.dataToTimeStam(settle_time[pfId][1]))+5
if targetTime>timeHelper.getServerShortTime()then
timeEventController.removeTimingHandler(JiuYuZhengFengController.stopFunc)

timeEventController.addTimingHandler(targetTime,1,JiuYuZhengFengController.stopFunc)
end
end
end

function JiuYuZhengFengController.stopFunc()

JiuYuZhengFengController.req_35_242()
end



