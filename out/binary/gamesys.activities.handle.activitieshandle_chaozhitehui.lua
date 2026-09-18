
activitiesHandle_chaozhitehui=new_activitiesHandle('activitiesHandle_chaozhitehui',activitiesHandle)




function activitiesHandle_chaozhitehui.recv_247_96(act_id,act2_id,buy_idx,buy_times)
local subType=SUB_ACTIVITY_TYPE.eChaoZhiTeHui
local actID=act_id
local subID=act2_id
local data={}
data.rechargeIndex=buy_idx
data.buyCnt=buy_times
activitiesModel:setSubActInfoData(actID,subType,subID,data)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subID)
if sub_actInfo then
sub_actInfo:refreshCondition()
end
UIManager:invokeUIMethod("UISubAct_zhaozhitehui_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

