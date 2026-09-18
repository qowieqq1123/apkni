







activitiesHandle_longhuhuijuan=new_activitiesHandle('activitiesHandle_longhuhuijuan',activitiesHandle)


function activitiesHandle_longhuhuijuan.recv_249_197(args)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan
local actid,act2id,plot_max_id,has_recv,progress,len,repairEvents,main_event_num,lenBLine,lineBits,event_guid_id=table.unpackEx(args)

local eventData={}
if repairEvents then
for i,v in ipairs(repairEvents)do
eventData[v.param_1]=v.param_2
end
end

local data=
{
plot_max_id=plot_max_id,
has_recv=has_recv,
progress=progress,
repairEvents=eventData,
main_event_num=main_event_num,
lineBits=lineBits,
event_guid_id=event_guid_id,
}

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuHuiJuan)

UIManager:callWindowFunc('UILongHuHuiJuanWin','refresh')

if worldController:isInWorld()then
worldLongHuShanController:showAllUnit()
end

activitiesModel:disposeSubActConditionChange(3)
end

function activitiesHandle_longhuhuijuan.recv_249_198(actid,act2id,plot_max_id)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if not data then
return
end
data.plot_max_id=plot_max_id
activitiesModel:setSubActInfoData(actid,subType,act2id,data)
local info=activitiesModel:getSubActInfo(actid,subType,act2id)
if info then
info:addProgress(3)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuHuiJuan)
UIManager:callWindowFunc('UILongHuHuiJuanWin','refreshPlot',plot_max_id,nil,nil,true)
UIManager:callWindowFunc('UILongHuHuiJuanWin','refreshPlot',plot_max_id+1,nil,nil)
UIManager:callWindowFunc('UILongHuHuiJuanWin','setProgress')
activitiesModel:disposeSubActConditionChange(3)
end

function activitiesHandle_longhuhuijuan.recv_249_199(actid,act2id)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if not data then
return
end

data.has_recv=1

activitiesModel:setSubActInfoData(actid,subType,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuHuiJuan)
UIManager:callWindowFunc('UILongHuHuiJuanWin','setProgress')
end

function activitiesHandle_longhuhuijuan.recv_249_200(actid,act2id,event_id,progress,plot)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if not data then
return
end

data.repairEvents[event_id]=progress

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

local info=activitiesModel:getSubActInfo(actid,subType,act2id)
if info then
local cfg=cfgHelper.get(cfg_longhuhuijuaneventconfig_get,event_id)
local repair=cfg.repair
if progress==#repair then
info:addProgress(2)
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuHuiJuan)
UIManager:callWindowFunc('UILongHuHuiJuanWin','setProgress')
UIManager:callWindowFunc('UILongHuHuiJuanWin','refreshPlotZhenJi',plot)
UIManager:callWindowFunc('UIZhenJiFixWin','refresh')

end


function activitiesHandle_longhuhuijuan.recv_249_201(actid,act2id,eventType,idx,event_idx)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if not data then
return
end
if eventType==1 then
local info=activitiesModel:getSubActInfo(actid,subType,act2id)
if info then
info:addMainEventNum()
info:addProgress(1)
end
elseif eventType==2 then
local info=activitiesModel:getSubActInfo(actid,subType,act2id)
if info then
info:setLineEventFinish(idx,event_idx)
end
end
UIManager:callWindowFunc('UILongHuHuiJuanWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuHuiJuan)

activitiesModel:disposeSubActConditionChange(3)
end


function activitiesHandle_longhuhuijuan.req_event_start(actid,subid,eventType,index,lineIndex)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

if eventType==1 then
local info=activitiesModel:getSubActInfo(actid,subType,subid)

if info then
local guid=info:getMysteryEvent(0,0)
if guid then
MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eCloudCityTreasure,guid,{},true,info.resumeCB)
else
local args={4,eventType,index,lineIndex}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end
end
elseif eventType==2 then
local info=activitiesModel:getSubActInfo(actid,subType,subid)
if info then
local guid=info:getMysteryEvent(index,lineIndex)
if guid then
MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eCloudCityTreasure,guid,{},true,info.resumeCB)
else
local args={4,eventType,index,lineIndex}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end
end
else
local args={4,eventType,index,lineIndex}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end
end


function activitiesHandle_longhuhuijuan.recv_249_202(actid,act2id,event_guid)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan


end




function activitiesHandle_longhuhuijuan.req_plot_unlock(actID,subid,id)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local args={1,id}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_longhuhuijuan.req_gubao_get(actID,subid)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local args={2,1}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_longhuhuijuan.req_fix_zhenji(actID,subid,plotId,zhenjiId)
local subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan

local args={3,plotId,zhenjiId}
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end
