







activitiesHandle_liandandahui=new_activitiesHandle('activitiesHandle_liandandahui',activitiesHandle)

function activitiesHandle_liandandahui:onInit()

end

function activitiesHandle_liandandahui.recv_249_26(args)
local actType=SUB_ACTIVITY_TYPE.eLianDanDaHui

local actid=args[1]
local act2id=args[2]
local free=args[3]
local freeSec=args[4]
local timesidx=args[5]
local beginTime=args[6]
local event1Time=args[7]
local event1List=args[9]
local event2Time=args[10]
local event2List=args[12]

local data={free=free,freeSec=freeSec,timesidx=timesidx,beginTime=beginTime,event1Time=event1Time,event1List=event1List,event2Time=event2Time,event2List=event2List}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)
if beginTime and beginTime~=0 then
UIManager:invokeUIMethod("UISubAct_LianDanDaHui_Win","updateState")
end
UIManager:invokeUIMethod("UISubAct_LianDanDaHui_Win","refreshCost")

local info=activitiesModel:getSubActInfo(actid,actType,act2id)
info:getFreeCount()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,actType)
end

function activitiesHandle_liandandahui.sendBeginLianDan(actid,act2id,timesIdx)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLianDanDaHui,act2id,jsonHelper.encode({1,timesIdx}))
end

function activitiesHandle_liandandahui.sendControlFireGame(actid,act2id,lv)
UIManager:invokeUIMethod("UISubAct_LianDanDaHui_Win","showOverEffect",lv)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLianDanDaHui,act2id,jsonHelper.encode({2,lv}))
end

function activitiesHandle_liandandahui.sendSuDanGame(actid,act2id,lv)
UIManager:invokeUIMethod("UISubAct_LianDanDaHui_Win","showOverEffect",lv)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLianDanDaHui,act2id,jsonHelper.encode({3,lv}))
end

function activitiesHandle_liandandahui.sendEndLianDan(actid,act2id)
local actType=SUB_ACTIVITY_TYPE.eLianDanDaHui
local data=activitiesModel:getSubActInfoData(actid,actType,act2id)
if data then
data.beginTime=nil
end
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLianDanDaHui,act2id,jsonHelper.encode({4}))
end
