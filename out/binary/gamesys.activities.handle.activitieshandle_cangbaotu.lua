







activitiesHandle_cangbaotu=new_activitiesHandle('activitiesHandle_cangbaotu',activitiesHandle)

function activitiesHandle_cangbaotu:onInit()

end

function activitiesHandle_cangbaotu:clearInvailMarkChat()
local allLocalData=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eCangBaoTu,{})

local nowTime=timeHelper.getServerShortTime()
local removes={}
for saveKey,saveData in pairs(allLocalData)do

local spliteInfo=string.split(saveKey,"_")
if#spliteInfo==4 and spliteInfo[4]=="MarkChat"then
local actId=tonumber(spliteInfo[1])
local subId=tonumber(spliteInfo[2])
local endTime=tonumber(spliteInfo[3])
if nowTime>endTime then

table.insert(removes,saveKey)
end
end
end
if#removes>0 then
for i,v in ipairs(removes)do

userActorArraySetting.set(ACTOR_SETTING_TYPE.eCangBaoTu,v,nil)
end
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eCangBaoTu)
end
end


function activitiesHandle_cangbaotu:reqPrize(actId,subId,idxList)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({1,#idxList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data then
data.task.searchtimes=data.task.searchtimes+1
end
end


function activitiesHandle_cangbaotu:reqShareItem(actId,subId,actorid,moneyid,infoGuid)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({2,tostring(actorid),moneyid,tostring(infoGuid or int64.zero)})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)

end



function activitiesHandle_cangbaotu:reqSOSItem(actId,subId,actorid,moneyid)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({3,tostring(actorid),moneyid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
UIManager.info("求助成功")
end


function activitiesHandle_cangbaotu:reqRewardTask(actId,subId,taskidx)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({4,taskidx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_cangbaotu:reqShareRecord(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({5})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end



function activitiesHandle_cangbaotu:reqActiveFragment(actId,subId,fragment)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local jstr=jsonHelper.encode({6,fragment})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_cangbaotu.recv_249_78(args)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local actId=args[1]
local subId=args[2]
local mapid=args[3]
local pieceflag=args[4]
local recordsec=args[5]
local datasec=args[6]
local searchtimes=args[7]
local sharetimes=args[8]
local targetflag=args[9]
local recvtimes=args[10]
local helptimes=args[11]
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

if not timeHelper.isTodayShort(datasec)then
searchtimes=0
sharetimes=0
recvtimes=0
helptimes=0


local taskCfg=activitiesModel:getSubActivityConfig(subType,subId,"target")
for i,v in ipairs(taskCfg)do
if v[1]==1 then
targetflag=mathHelper.clrbit(targetflag,i-1)
end
end
end

if info:hasData()then
info.data.current={mapid=mapid,pieceflag=pieceflag}
info.data.recordsec=recordsec
info.data.datasec=datasec
info.data.task={searchtimes=searchtimes,sharetimes=sharetimes,targetflag=targetflag,recvtimes=recvtimes,helptimes=helptimes}
else
local data={
current={mapid=mapid,pieceflag=pieceflag},
recordsec=recordsec,
datasec=datasec,
task={searchtimes=searchtimes,sharetimes=sharetimes,targetflag=targetflag,recvtimes=recvtimes,helptimes=helptimes},
}
info:setData(data)
end

cangbaotuSheetReddot.addConfig(actId,subId)

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_CangBaoTuCardWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_CangBaoTuTaskWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_CangBaoTuUnlockTips","refreshNum",{actId,subType,subId})

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_cangbaotu.recv_249_79(args)
local actId=args[1]
local subId=args[2]
local actorid=args[3]
local moneyid=args[4]
local guid=args[5]
local res=args[6]

if res>0 then
local str="赠予失败"
if res==1 then
str="已有其他仙友赠送了"
elseif res==2 then
str="仙友今日的获赠次数已达上限"
elseif res==3 then
str="仙友今日的接受分享的次数已达上限"
end
UIManager.error(str)
return
else
UIManager.info("成功赠予")
end

local subType=SUB_ACTIVITY_TYPE.eCangBaoGe

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

local data=info:getData()
if not data then return end

data.task.sharetimes=data.task.sharetimes+1

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshTaskReddot",{actId,subType,subId})

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_cangbaotu.recv_249_80(actId,subId,actorid,moneyid)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

local data=info:getData()
if not data then return end

data.task.sharetimes=data.task.sharetimes+1

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshTaskReddot",{actId,subType,subId})

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_cangbaotu.recv_249_81(actId,subId,targetid)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

local data=info:getData()
if not data then return end

data.task.targetflag=mathHelper.setbit(data.task.targetflag,targetid-1)

UIManager:invokeUIMethod("UISubAct_CangBaoTuTaskWin","afterReward",actId,subType,subId,targetid)
UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshTaskReddot",{actId,subType,subId,targetid})

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_cangbaotu.recv_249_82(actId,subId,len,list)






local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local info=activitiesModel:getSubActInfo(actId,subType,subId)
info:setRecord(list)
info:saveRecordSec(timeHelper.getServerShortTime())

UIManager:invokeUIMethod("UISubAct_CangBaoTuRecordWin","refreshView",{actId,subType,subId})
UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshCardReddot",{actId,subType,subId})

reddotControl.on_change_catch_type(CATCH_TYPE.eCangBaoTuShareRecord,actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_cangbaotu.recv_249_83(actId,subId,recordsec,recvtimes,helptimes)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

local data=info:getData()
if not data then return end

data.recordsec=recordsec
data.task.recvtimes=recvtimes
data.task.helptimes=helptimes

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshCardReddot",{actId,subType,subId})
UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","refreshTaskReddot",{actId,subType,subId})
UIManager:invokeUIMethod("UISubAct_CangBaoTuUnlockTips","refreshNum",{actId,subType,subId})
UIManager:invokeUIMethod("UISubAct_CangBaoTuRecordWin","refreshNum",{actId,subType,subId})

reddotControl.on_change_catch_type(CATCH_TYPE.eCangBaoTuShareRecord,actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
