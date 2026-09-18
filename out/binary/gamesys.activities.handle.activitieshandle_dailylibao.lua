
activitiesHandle_dailylibao=new_activitiesHandle('activitiesHandle_dailylibao',activitiesHandle)

dailylibaoCustomType=
{
eGuBaoUpActivity=1,
}

function activitiesHandle_dailylibao:onInit()

end

function activitiesHandle_dailylibao.recv_249_114(actid,subId,stamp)
local subType=SUB_ACTIVITY_TYPE.eDailyLiBao
local actCfg=cfgHelper.get1(cfg_dailylibaoactconfig_get,subId)
local rwLimit=actCfg.rwLimit==1
if rwLimit then
local activityInfo=activitiesModel:getSubActInfo(actid,subType,subId)
local beginTime=activityInfo.start_time
local endTime=activityInfo.end_time
local flag=stamp>=beginTime and stamp<=endTime and 1 or 0
activitiesModel:setSubActInfoData(actid,subType,subId,flag)
else
local resetTime=actCfg.reset
local zeroStamp=timeHelper.getTodayZeroStamp()
local resetStamp=zeroStamp+resetTime*3600
local longStamp=timeHelper.convertLongStamp(stamp)
local needReset=longStamp<resetStamp
local flag=needReset and 0 or 1
activitiesModel:setSubActInfoData(actid,subType,subId,flag)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_dailylibao:setPreViewFlag(flag)
self.preViewFlag=flag
end

function activitiesHandle_dailylibao:getPreViewFlag()
return self.preViewFlag or false
end