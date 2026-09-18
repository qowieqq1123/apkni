







activitiesHandle_anniversarysignin=new_activitiesHandle('activitiesHandle_anniversarysignin',activitiesHandle)

function activitiesHandle_anniversarysignin:onInit()

end

function activitiesHandle_anniversarysignin:onDelete()

end

function activitiesHandle_anniversarysignin.recv_247_35(args)
local actId=args[1]
local subId=args[2]
local qd_times=args[3]
local reward_times=args[4]
local reward_idx=args[5]
local bq_times=args[6]




local subType=SUB_ACTIVITY_TYPE.eZhouNianQingQianDao

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

info:setData(qd_times,reward_times,reward_idx,bq_times)
end