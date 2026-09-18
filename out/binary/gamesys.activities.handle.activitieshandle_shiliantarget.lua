







activitiesHandle_shilianTarget=new_activitiesHandle('activitiesHandle_shilianTarget',activitiesHandle)



function activitiesHandle_shilianTarget:onInit()

end

function activitiesHandle_shilianTarget.recv_249_168(actid,act2id,day_idx,recv_idx)
local subType=SUB_ACTIVITY_TYPE.eShiLianMuBiao

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.day_idx=day_idx
data.recv_idx=recv_idx

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_ShiLianMuBiao","freshInfo")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_shilianTarget.recv_249_169(actid,act2id,day_idx)
local subType=SUB_ACTIVITY_TYPE.eShiLianMuBiao
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.day_idx=day_idx
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_ShiLianMuBiao","refreshDayBtn")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_shilianTarget.recv_249_170(actid,act2id,recv_idx)
local subType=SUB_ACTIVITY_TYPE.eShiLianMuBiao

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.recv_idx=recv_idx

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_ShiLianMuBiao","refreshSignInList")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
