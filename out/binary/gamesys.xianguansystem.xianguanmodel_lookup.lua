
function xianguanModel:onEnterState_LookUp(isReconnect)
self.data.centerLookup={}
end

function xianguanModel:onLeaveState_LookUp(isReconnect)
end

XIANGUAN_INFO_KEY_ENUM={

eXGInfo_Self_TqID_XgType=1,
eXGInfo_Self_XgType=2,

eXGInfo_ActorID_XgType=3,
eXGInfo_ActorId_XgType_TqID=4,


eTQInfo_self_TqID_XgID=1001
}





local _generateKeyFuncs={

[XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_TqID_XgType]={
generatekey=function(tqId,xgType)
return string.format("1_%d_%d_%d",tqId,xgType,XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_TqID_XgType)
end,
checkKeyArgs=function(tqId,xgType)
return tqId~=nil and xgType~=nil
end,
},

[XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_XgType]={
generatekey=function(xgType)
return string.format("2_%d_%d",xgType,XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_XgType)
end,
checkKeyArgs=function(xgType)
return xgType~=nil
end,
},

[XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorID_XgType]={
generatekey=function(actorId,xgType)
return string.format("3_%s_%d_%d",tostring(actorId),xgType,XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorID_XgType)
end,
checkKeyArgs=function(actorId,xgType)
return xgType~=nil and actorId~=nil
end,
},

[XIANGUAN_INFO_KEY_ENUM.eTQInfo_self_TqID_XgID]={
generatekey=function(tqId,xgId)
return string.format("4_%d_%d_%d",tqId,xgId,XIANGUAN_INFO_KEY_ENUM.eTQInfo_self_TqID_XgID)
end,
checkKeyArgs=function(tqId,xgId)
return tqId~=nil and xgId~=nil
end,
},

[XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorId_XgType_TqID]={
generatekey=function(actorId,xgType,tqId)
return string.format("5_%s_%d_%d_%d",tostring(actorId),xgType,tqId,XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorId_XgType_TqID)
end,
checkKeyArgs=function(actorId,xgType,tqId)
return actorId~=nil and xgType~=nil and tqId~=nil
end,
},
}

function xianguanModel.getLookUpKey(info_Key_Enum,...)
local funcs=_generateKeyFuncs[info_Key_Enum]
if funcs then
if funcs.checkKeyArgs and funcs.checkKeyArgs(...)then
if funcs.generatekey then
return funcs.generatekey(...)
end
end
else

end
end

function xianguanModel:setDataToLookUp(info_Key_Enum,data,...)
local key=xianguanModel.getLookUpKey(info_Key_Enum,...)
if key then
self.data.centerLookup[key]=data
else
end
end

function xianguanModel:removeDataToLookUp(info_Key_Enum,...)
local key=xianguanModel.getLookUpKey(info_Key_Enum,...)
if key then
self.data.centerLookup[key]=nil
else
end
end

function xianguanModel:getDataBykey(info_Key_Enum,...)
local key=xianguanModel.getLookUpKey(info_Key_Enum,...)
if key then
return self.data.centerLookup[key]
else
end
end

function xianguanModel:resetCenterLookup()
self.data.centerLookup={}
end



function xianguanModel.freshLookUp_XgInfo(xgInfo)

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,xgInfo.actorid)

if isSelf then
xianguanModel.freshLookUp_XgInfo_Self_TqID_XgType(xgInfo)
xianguanModel.freshLookUp_XgInfo_Self_XgType(xgInfo)
end

xianguanModel.freshLookUp_XgInfo_ActorID_XgType(xgInfo)
xianguanModel.freshLookUp_XgInfo_ActorID_XgType_TqID(xgInfo)

end

function xianguanModel.removeLookUp_XgInfo(xgInfo)
local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,xgInfo.actorid)

if isSelf then
xianguanModel.removeLookUp_XgInfo_Self_TqID_XgType(xgInfo)
xianguanModel.removeLookUp_XgInfo_Self_XgType(xgInfo)
end

xianguanModel.removeLookUp_XgInfo_ActorID_XgType(xgInfo)
xianguanModel.removeLookUp_XgInfo_ActorID_XgType_TqID(xgInfo)
end

function xianguanModel.freshLookUp_XgInfo_Self_TqID_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(xgInfo.jobId)

for index,tqId in ipairs(privilegeList)do
xianguanModel:setDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_TqID_XgType,xgInfo,tqId,xgType)
end
end

function xianguanModel.removeLookUp_XgInfo_Self_TqID_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(xgInfo.jobId)

for index,tqId in ipairs(privilegeList)do
xianguanModel:removeDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_TqID_XgType,tqId,xgType)
end
end

function xianguanModel.freshLookUp_XgInfo_Self_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end
local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
xianguanModel:setDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_XgType,xgInfo,xgType)
end

function xianguanModel.removeLookUp_XgInfo_Self_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end
local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
xianguanModel:removeDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_Self_XgType,xgType)
end

function xianguanModel.freshLookUp_XgInfo_ActorID_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
xianguanModel:setDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorID_XgType,xgInfo,xgInfo.actorid,xgType)
end

function xianguanModel.removeLookUp_XgInfo_ActorID_XgType(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
xianguanModel:removeDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorID_XgType,xgInfo.actorid,xgType)
end

function xianguanModel.freshLookUp_XgInfo_ActorID_XgType_TqID(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(xgInfo.jobId)

for index,tqId in ipairs(privilegeList)do
xianguanModel:setDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorId_XgType_TqID,xgInfo,xgInfo.actorid,xgType,tqId)
end
end

function xianguanModel.removeLookUp_XgInfo_ActorID_XgType_TqID(xgInfo)
if xgInfo==nil then return end
if xgInfo.actorid==nil then return end

local xgType=xianguanConfig.getJobConfig2(xgInfo.jobId,'type')
local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(xgInfo.jobId)

for index,tqId in ipairs(privilegeList)do
xianguanModel:removeDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorId_XgType_TqID,xgInfo.actorid,xgType,tqId)
end
end




function xianguanModel.freshLookUp_TqInfo(tqInfo)
xianguanModel.freshLookUp_TqInfo_Self_TqId_XgID(tqInfo)
end

function xianguanModel.removeLookUp_TqInfo(tqInfo)
end

function xianguanModel.freshLookUp_TqInfo_Self_TqId_XgID(tqInfo)
if tqInfo==nil then return end
xianguanModel:setDataToLookUp(XIANGUAN_INFO_KEY_ENUM.eTQInfo_self_TqID_XgID,tqInfo,tqInfo.tqid,tqInfo.xgid)
end
