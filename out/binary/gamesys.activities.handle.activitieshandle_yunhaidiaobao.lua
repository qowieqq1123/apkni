







activitiesHandle_yunhaidiaobao=new_activitiesHandle('activitiesHandle_yunhaidiaobao',activitiesHandle)

function activitiesHandle_yunhaidiaobao:onInit()

end

function activitiesHandle_yunhaidiaobao.recv_247_24(actId,subId,great,free)
local subType=SUB_ACTIVITY_TYPE.eLotteryact9




local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

if info:hasData()then
info.data.free=free
info.data.great=great
else
local data={
free=free,
great=great,
}
info:setData(data)
end
UIManager:invokeUIMethod("UISubAct_YunHaiDiaoBaoWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end