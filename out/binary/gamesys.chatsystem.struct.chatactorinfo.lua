





chatActorInfo={}


function chatActorInfo.create(actorId,actorName,level,serverId,iconInfo,chatId,args)

local temp={}
temp.actorId=actorId
temp.actorName=actorName
temp.actorLevel=level
temp.serverId=serverId
temp.iconInfo=iconInfo
temp.chatId=chatId or 1
temp.args=args

if temp.chatId==0 then temp.chatId=1 end
return temp
end

function chatActorInfo.createSelf()
local actorId=playerModel:getActorID()
local actorName=playerModel:getActorName()
local level=playerModel:getActorLevel()
local serverId=playerModel:getActorServerID()
local iconInfo=playerModel:getActorIconInfo()
local chatId=UISettingModel:getCurrentChatKuang()
local chatFlag=chatModel:getSignList()
local args={chatFlag=chatFlag}

if chatId==0 then chatId=1 end

local info=chatActorInfo.create(actorId,actorName,level,serverId,iconInfo,tonumber(chatId),args)
return info
end

function chatActorInfo.convertByFriendInfo(friendInfo)
local v=friendInfo
local actorId=v.actorId
local actorName=v.playerName
local actorLevel=v.zmLevel

local serverId=playerModel:getActorServerID()
local iconInfo=v.iconInfo
local chatId=1
local info=chatActorInfo.create(actorId,actorName,actorLevel,serverId,iconInfo,chatId)
info.offline=v.offline
return info
end

function chatActorInfo.convertByOtherPlayerInfo(actorData)
local v=actorData
local actorId=v.actorId
local actorName=v.name
local actorLevel=v.zmLevel
local serverId=v.serverid or 0
local iconInfo=v.iconInfo
local chatId=1
local info=chatActorInfo.create(actorId,actorName,actorLevel,serverId,iconInfo,chatId)
info.offline=0
return info
end
function chatActorInfo.createMsgInfo(stamp,channelId,handleType,canShield,isTop,args)
local info={}
info.stamp=stamp
info.channelId=channelId
info.handleType=handleType
info.canShield=canShield or false
info.isTop=isTop or false
info.args=args
return info
end

function chatActorInfo.createMsgInfoEx(stamp,channelId,msgType,isTop,actorInfo,mesg,sendguid,holderId,canShield,params)
local info={}
info.stamp=stamp
info.channelId=channelId
info.msgType=msgType
info.isTop=isTop or false
info.actorInfo=actorInfo
info.mesg=mesg
info.sendguid=sendguid
info.holderId=holderId
info.canShield=canShield
info.params=params
return info
end

function chatActorInfo.createPublicActorInfo(argstable)
local actorId=argstable[3]
local actorName=argstable[4]
local level=argstable[5]
local iconInfo=argstable[6]
local chatId=argstable[7]or 1
local serverId=argstable[8]
local chatFlag=argstable[10]or{}
local args={chatFlag=chatFlag}

if chatId==0 then chatId=1 end
return chatActorInfo.create(actorId,actorName,level,serverId,iconInfo,chatId,args)
end

function chatActorInfo.createPrivateActorInfo(argstable)
local mesg=argstable[1]
local actorId=argstable[2]
local actorName=argstable[3]
local level=argstable[4]
local iconInfo=argstable[5]
local chatId=argstable[6]or 1
local serverId=argstable[7]
local chatFlag=argstable[9]or{}
local args={chatFlag=chatFlag}

if chatId==0 then chatId=1 end

return chatActorInfo.create(actorId,actorName,level,serverId,iconInfo,chatId,args)
end

function chatActorInfo.createChatInfo(msgInfoEx)
local stamp=msgInfoEx.stamp
local channelId=msgInfoEx.channelId
local msgType=msgInfoEx.msgType
local isTop=msgInfoEx.isTop or false
local actorInfo=msgInfoEx.actorInfo
local mesg=msgInfoEx.mesg
local sendguid=msgInfoEx.sendguid
local holderId=msgInfoEx.holderId
local params=msgInfoEx.params

return chatStruct.create(isTop,stamp,channelId,msgType,mesg,actorInfo,sendguid,holderId,params)
end