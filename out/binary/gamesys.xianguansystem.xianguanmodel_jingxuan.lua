
local _jingxuanResultTime=nil

local _jingxuanShareData=nil

local _jingxuanResultMsg={}

function xianguanModel:loadJingXuanClientData()
_jingxuanResultTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXResultTime",{})
_jingxuanShareData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXShareData",nil)
if _jingxuanShareData==nil then
_jingxuanShareData={}
for i,v in pairs(XianGuanCampaignType)do
local data={}
data.timeStamp=0
data.actorData={}
_jingxuanShareData[v]=data
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXShareData",_jingxuanShareData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianGuanJingXuan,true)
else
self:clearAllJingXuanShareRecord()
end
end

function xianguanModel:getJingXuanResultTime(campaignType)
if type(_jingxuanResultTime[campaignType])~="number"then
return nil
end
return _jingxuanResultTime[campaignType]
end

function xianguanModel:recordJingXuanResultTime(campaignType,time,dirty)
_jingxuanResultTime[campaignType]=time

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXResultTime",_jingxuanResultTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianGuanJingXuan,dirty)
end

function xianguanModel:clearAllJingXuanShareRecord()
for i,v in pairs(_jingxuanShareData)do
if not timeHelper.checkInSameWeek4(v.timeStamp)then
v.timeStamp=timeHelper.getServerShortTime()
v.actorData={}

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXShareData",_jingxuanShareData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianGuanJingXuan,true)
end
end
end

function xianguanModel:getJingXuanShareRecord(campaignType,actorId)
local key=tostring(actorId)
local status=_jingxuanShareData[campaignType].actorData[key]
return status or XianGuanJingXuanShareState.eNormal
end

function xianguanModel:setJingXuanShareRecord(campaignType,actorId,status,dirty)
local key=tostring(actorId)
_jingxuanShareData[campaignType].actorData[key]=status

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianGuanJingXuan,"XGJXShareData",_jingxuanShareData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianGuanJingXuan,dirty)
end

function xianguanModel:addMsgJingXuanResultType(campaignType)
_jingxuanResultMsg[campaignType]=true
end

function xianguanModel:deleteMsgJingXuanResultType(campaignType)
_jingxuanResultMsg[campaignType]=nil
end

function xianguanModel:clearMsgJingXuanResultType()
table.clear(_jingxuanResultMsg)
end

function xianguanModel:getMsgJingXuanResultType()
return _jingxuanResultMsg
end

function xianguanModel:checkExistMsgJingXuanResultType()
return next(_jingxuanResultMsg)~=nil
end