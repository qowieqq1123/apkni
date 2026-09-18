





chatCacheControl=gameState.addListener({})

local _sendGUID=0
local _actorInfoLookup={}


function chatCacheControl:onAppStart()

end

function chatCacheControl:onEnterState()
_actorInfoLookup={}
_sendGUID=0
end

function chatCacheControl:onLeaveState()
_actorInfoLookup={}
_sendGUID=0
end







function chatCacheControl.onSendPublicMesg(channelId,mesg)
local sendguid=chatCacheControl.addActorCache(mesg)
chatProtocolControl.sendPublicMesg(channelId,mesg,sendguid)
return sendguid
end





function chatCacheControl.onSendPrivateMesgRet(actorId,sendguid,mesg)
chatCacheControl.deleteActorCache(sendguid)
local stamp=timeHelper.getServerLongTime()
local msgInfoEx=chatActorInfo.createMsgInfoEx(stamp,
CHAT_CHANNNEL.ePrivate,
CHAT_MESSAGE_TYPE.ePrivate,
false,
chatActorInfo.createSelf(),
mesg,
sendguid,
actorId)
chatControl.onRecvAnyChannelMesg(msgInfoEx)
platformSDK:uploadChatMsg(msgInfoEx)

chatModel.insertClientPrivateList(1,{stamp,tostring(actorId),sendguid,mesg})
end

function chatCacheControl.onSendPublicMesgRet(channelId,sendguid,mesg)
chatCacheControl.deleteActorCache(sendguid)
chatModel.setSpeakStampOnChannel(channelId)
local stamp=timeHelper.getServerLongTime()
local msgInfoEx=chatActorInfo.createMsgInfoEx(stamp,
channelId,
CHAT_MESSAGE_TYPE.ePublic,
false,
chatActorInfo.createSelf(),
mesg,
sendguid)
chatControl.onRecvAnyChannelMesg(msgInfoEx)
platformSDK:uploadChatMsg(msgInfoEx)
end





function chatControl.reqSendGUID()
_sendGUID=_sendGUID+1
return _sendGUID
end

function chatCacheControl.addActorCache(mesg)
local guid=chatControl.reqSendGUID()
_actorInfoLookup[guid]=mesg
return guid
end

function chatCacheControl.getActorCache(guid,remove)
local cache=_actorInfoLookup[guid]
if remove then
_actorInfoLookup[guid]=nil
end
return cache or''
end

function chatCacheControl.deleteActorCache(guid)
_actorInfoLookup[guid]=nil
end






function chatCacheControl.tranfromFriendInfo(friend)

end