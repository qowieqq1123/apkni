




chatModel={}
local _data={}

local privateMax=500
local checkPrivateTime=86400*7

function chatModel.init()
_data={}
_data.channelStampLookup={}

_data.unlockEmotList={}
_data.unlockEmotLookup={}
_data._channelStampLookup={}
_data.liuyanReddotList={}

_data.clientPrivateList={}

chatModel.initClientPrivateList()
end

function chatModel.setSpeakStampOnChannel(channelId)
_data._channelStampLookup[channelId]=timeHelper.getServerLongTime()
end

function chatModel.getSpeakStampOnChannel(channelId)
return _data._channelStampLookup[channelId]or 0
end

function chatModel.initClientPrivateList()
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePrivateChat,1,{})
_data.clientPrivateList={}

local removeList={}
local now=os.time()
local actorId,actorInfo,idStr,aType,stamp
for i,v in ipairs(list)do
actorInfo=v[2]
actorId=actorInfo[2]

stamp=actorInfo[1]

if now<=stamp+checkPrivateTime then
idStr=tostring(actorId)
_data.clientPrivateList[idStr]=_data.clientPrivateList[idStr]or{}
table.insert(_data.clientPrivateList[idStr],v)
else
table.insert(removeList,i)
end
end
for i,v in ipairs(removeList)do
table.remove(list,v)
end

for i,v in pairs(_data.clientPrivateList)do
table.sort(v,function(a,b)return a[2][1]<b[2][1]end)
end

if next(removeList)then
userActorArraySetting.set(ACTOR_SETTING_TYPE.ePrivateChat,1,list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.ePrivateChat)
end
end

function chatModel.insertClientPrivateList(aType,actorInfo)
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePrivateChat,1,{})
if#list>=privateMax then
table.remove(list,1)
end
table.insert(list,{aType,actorInfo})
userActorArraySetting.set(ACTOR_SETTING_TYPE.ePrivateChat,1,list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.ePrivateChat)
end

function chatModel.getClientPrivateList()
return _data.clientPrivateList
end


function chatModel.setLiuYanReddotListByActorId(actorId,msgCount)
if actorId==nil then
return false
end

if chatControl.isDisableReceive(CHAT_CHANNNEL.ePrivate)then


chatProtocolControl.sendRemoveLiuYan(actorId)
return
end

if not _data.liuyanReddotList[tostring(actorId)]then
_data.liuyanReddotList[tostring(actorId)]={}
end
_data.liuyanReddotList[tostring(actorId)].actorId=actorId
_data.liuyanReddotList[tostring(actorId)].msgCount=msgCount

end

function chatModel.checkLiuYanReddot()
if not next(_data.liuyanReddotList)then
return false
end

return true
end

function chatModel.checkFriendAndRecentLiuYanReddot()
local friendReddot=false
local recentReddot=false
if next(_data.liuyanReddotList)then
for i,v in pairs(_data.liuyanReddotList)do
if friendModel:isFriend(v.actorId)then
friendReddot=true
else
recentReddot=true
end
if friendReddot and recentReddot then
break
end
end
end

return friendReddot,recentReddot
end


function chatModel.checkLiuYanActor()
if next(_data.liuyanReddotList)then
for i,v in pairs(_data.liuyanReddotList)do
if not friendModel:isFriend(v.actorId)and not chatRecentModel.getIdx(v.actorId)then

chatProtocolControl.sendLiuYan(v.actorId)
end
end
end
end

function chatModel.checkLiuYanReddotByActorId(actorId)
if actorId==nil or not next(_data.liuyanReddotList)then
return false
end

if _data.liuyanReddotList[tostring(actorId)]then
return true
end
return false
end

function chatModel.clearLiuYanReddotByActorId(actorId)
if actorId==nil or not next(_data.liuyanReddotList)then
return
end

local key=tostring(actorId)
if _data.liuyanReddotList[key]~=nil then
_data.liuyanReddotList[key]=nil
end
end

function chatModel.getLiuYanCount()
local count=0
for i,v in pairs(_data.liuyanReddotList)do
count=count+v.msgCount
end
return count
end

function chatModel.getLiuYanCountByActorId(actorId)
if actorId==nil or not next(_data.liuyanReddotList)then
return 0
end

local key=tostring(actorId)
if _data.liuyanReddotList[key]==nil then return 0 end
return _data.liuyanReddotList[key].msgCount
end

function chatModel:setLastChannel(channelId)
if self.channelId==channelId then return end
self.channelId=channelId
userActorSetting.set('lastChannel',channelId)
userActorSetting.flush(true)
end

function chatModel:getLastChannel()
if self.channelId==nil then
local channelId=userActorSetting.get('lastChannel')
if channelId==nil then
chatModel:setLastChannel(CHAT_CHANNNEL.eWorld)
else
self.channelId=channelId
end
end
return self.channelId
end

