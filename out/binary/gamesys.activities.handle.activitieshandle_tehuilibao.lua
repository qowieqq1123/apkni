







activitiesHandle_tehuilibao=new_activitiesHandle('activitiesHandle_tehuilibao',activitiesHandle)

function activitiesHandle_tehuilibao:onInit()

end

function activitiesHandle_tehuilibao.onInfoRecv(args)
local actid,act2id,last_time,last_box_time,len,list=args[1],args[2],args[3],args[4],args[5],args[6]

local data={}



if last_time~=0 and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(last_time))then
data.last_time=0
len=0
else
data.last_time=last_time
end
if last_box_time~=0 and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(last_box_time))then
data.last_box_time=0
else
data.last_box_time=last_box_time
end

data.info={}
if len>0 then
for i,v in ipairs(list)do
data.info[v]=v
end
end

activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eTeHuiLiBao,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eTeHuiLiBao)
UIManager:invokeUIMethod("SubAct_TeHuiLiBaoWin","refreshWin")
end

function activitiesHandle_tehuilibao.canGetBaoXiang(actid,act2id)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eTeHuiLiBao,act2id)
if data then
local lastBoxTime=data.last_box_time
if lastBoxTime and lastBoxTime>0 then
local longTime=timeHelper.convertLongStamp(lastBoxTime)
local isToday=timeHelper.isTodayStamp(longTime)
return not isToday
end
end
return true
end


function activitiesHandle_tehuilibao:autoReceiveFreeGift(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eTeHuiLiBao
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
if activitiesHandle_tehuilibao.canGetBaoXiang(act_id,sub_act_id)then
if checkReddot then
return true
end
local jsonStr=jsonHelper.encode({1})
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end
