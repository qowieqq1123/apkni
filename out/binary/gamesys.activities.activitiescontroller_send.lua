








actSendType={
eInit=1,
eComonReqInfo=2,
eComonReqHandle=3,
eReqInfoList=4,
eReqOpen=5,
}


local actSendHandleLookup={
[actSendType.eInit]=function(serverType)
serverType=serverType or activitiesServerType.eNone
if serverType==activitiesServerType.eKuafu then
socketManager:send_249_61()
elseif serverType==activitiesServerType.eRole then
socketManager:send_249_103()
elseif serverType==activitiesServerType.eBigCross then
socketManager:send_247_116()
else
socketManager:send_249_1()
end
end,
[actSendType.eComonReqInfo]=function(act_id,sub_act_type,sub_act_id)



local serverType=activitiesModel:getServerType(act_id)
if serverType==activitiesServerType.eKuafu then
socketManager:send_249_62(act_id,sub_act_type,sub_act_id)
elseif serverType==activitiesServerType.eRole then
socketManager:send_249_104(act_id,sub_act_type,sub_act_id)
elseif serverType==activitiesServerType.eBigCross then
socketManager:send_247_117(act_id,sub_act_type,sub_act_id)
else
socketManager:send_249_2(act_id,sub_act_type,sub_act_id)
end
end,
[actSendType.eComonReqHandle]=function(act_id,sub_act_type,sub_act_id,param)









local serverType=activitiesModel:getServerType(act_id)
if serverType==activitiesServerType.eKuafu then
socketManager:send_249_63(act_id,sub_act_type,sub_act_id,param)
elseif serverType==activitiesServerType.eRole then
socketManager:send_249_105(act_id,sub_act_type,sub_act_id,param)
elseif serverType==activitiesServerType.eBigCross then
socketManager:send_247_118(act_id,sub_act_type,sub_act_id,param)
else
socketManager:send_249_3(act_id,sub_act_type,sub_act_id,param)
end

end,
[actSendType.eReqInfoList]=function(serverType,list)




if list==nil then return end
local len=#list
serverType=serverType or activitiesServerType.eNone
if serverType==activitiesServerType.eKuafu then
socketManager:send_249_64(len,list)
elseif serverType==activitiesServerType.eRole then
socketManager:send_249_106(len,list)
elseif serverType==activitiesServerType.eBigCross then
socketManager:send_247_119(len,list)
else
socketManager:send_249_34(len,list)
end
end,

[actSendType.eReqOpen]=function(serverType,list)
if list==nil then return end
local len=#list
serverType=serverType or activitiesServerType.eRole
if serverType==activitiesServerType.eRole then
socketManager:send_249_107(len,list)
end
end,
}


function activitiesController:sendProtocol(sendType,...)
local handle=actSendHandleLookup[sendType]
if handle then
handle(...)
else



end
end
