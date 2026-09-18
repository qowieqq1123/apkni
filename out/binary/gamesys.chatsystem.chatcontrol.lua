




chatControl=gameState.addListener({})


local _cache={}
local _isCanRecv=false
local _lookup={}

local _handleType=
{
ePublic=1,
ePrivate=2,
eSystem=3,
}

local _handleDataType=
{
eSingle=1,
eList=2,
}

local _handleFunc=
{
[_handleDataType.eSingle]=
{
[_handleType.ePublic]=function(...)
chatControl.onHandlePublicMesg(...)
end,
[_handleType.ePrivate]=function(...)
chatControl.onHandlePrivateMesg(...)
end,
[_handleType.eSystem]=function(...)
chatControl.onHandleSystemMesg(...)
end,
},
[_handleDataType.eList]=
{
[_handleType.ePublic]=function(...)
chatControl.onHandlePublicMesgList(...)
end,
[_handleType.ePrivate]=function(...)
chatControl.onHandlePrivateMesgList(...)
end,
[_handleType.eSystem]=function(...)
chatControl.onHandleSystemMesgList(...)
end,
}
}


function chatControl:onAppStart()
notifySystem:listenNotify(notifyConfig.on_servertime_init,self.onServertimeInit)
chatControl:onAppStart_win()
chatControl:onAppStart_jianwen()
chatControl:onAppStart_share()
chatControl:onAppStart_reddot()
chatControl:onAppStart_refresh()
end

function chatControl:onEnterState(isReconnet)
chatModel.init()
chatRecentModel.init()
chatModel:setSignList(0,{})
_cache={}
_lookup={}
_isCanRecv=false
chatControl:onEnterState_func(isReconnet)
chatControl:onEnterState_handle(isReconnet)
chatControl:onEnterState_jianwen(isReconnet)
chatControl.onEnterState_win(isReconnet)
chatControl:onEnterState_share(isReconnet)
chatControl:onEnterState_reddot(isReconnet)
chatControl:onEnterState_refresh(isReconnet)
end

function chatControl:onLeaveState(isReconnet)
chatModel.init()
chatRecentModel.init()
chatModel:setSignList(0,{})
_cache={}
_lookup={}
_isCanRecv=false
self.WarningMsg=false
chatControl:onLeaveState_func(isReconnet)
chatControl:onLeaveState_handle(isReconnet)
chatControl:onLeaveState_jianwen(isReconnet)
chatControl:onLeaveState_win(isReconnet)
chatControl:onLeaveState_share(isReconnet)
chatControl:onLeaveState_reddot(isReconnet)
chatControl:onLeaveState_refresh(isReconnet)
end

function chatControl:onProtocolReq()
chatControl:onInit()
end

function chatControl:onProtocolReqKF()
chatControl:onInit()
end

function chatControl:onInit()
if initProControl.isDoneKF()and
initProControl.isDone()then
_isCanRecv=true
chatControl.handleCache()
end
end








function chatControl.onSendPublicRet(ret,channelId,sendguid,mesg)
if ret==0 then
chatCacheControl.onSendPublicMesgRet(channelId,sendguid,mesg)
elseif ret==1 then
UIManager.error('聊天冷却中')
end
end





function chatControl.onSendPrivateRet(ret,actorId,sendguid,mesg)
if ret==0 then
chatCacheControl.onSendPrivateMesgRet(actorId,sendguid,mesg)
elseif ret==1 then
chatCacheControl.getActorCache(sendguid,true)
UIManager.error('对方不在线')
end
end


function chatControl.onRecvPublicMesg(argstable)
local channelId=argstable[1]
local stamp=timeHelper.getServerLongTime()
local handleType=_handleType.ePublic
local msgInfo=chatActorInfo.createMsgInfo(stamp,channelId,handleType,true,false,argstable)
chatControl.handleMsgByRecv(msgInfo)
end


function chatControl.onRecvPrivateMesg(argstable)
local channelId=CHAT_CHANNNEL.ePrivate
local stamp=timeHelper.getServerLongTime()
local msgInfo=chatActorInfo.createMsgInfo(stamp,channelId,_handleType.ePrivate,true,false,argstable)
chatControl.handleMsgByRecv(msgInfo)
end


function chatControl.onRecvLiuYanMesg(array)
local channelId=CHAT_CHANNNEL.ePrivate
local msgInfoList={}

msgInfoList.channelId=channelId
msgInfoList.isRead=true
msgInfoList.isTop=false
msgInfoList.handleType=_handleType.ePrivate
msgInfoList.canShield=true
local blacklist={}
local actorInfolist={}
for i,v in ipairs(array)do
local stamp=timeHelper.convertLongStamp(v.time)
local actorId=v.senderid
local args={
v.msg,
v.senderid,
v.sendername,
v.senderlv,
v.iconInfo,
v.sendbgmid,
v.senderserverid,
v.cfLen,
v.cfList,
}
local actorInfo=friendModel:getFromList(eFriendDataType.eBlack,actorId)
if actorInfo then
blacklist[actorId]=true
else
local msgInfo=chatActorInfo.createMsgInfo(stamp,channelId,_handleType.ePrivate,true,false,args)
local actorInfo=chatActorInfo.createPrivateActorInfo(args)



msgInfoList[#msgInfoList+1]=msgInfo
actorInfolist[#actorInfolist+1]=actorInfo
chatRecentModel.setRecentInfo(actorInfo)
end
end

for actorId,_ in pairs(blacklist)do
chatProtocolControl.sendRemoveLiuYan(actorId)
end
if#actorInfolist>0 then

UIManager:callWindowFunc('UIChatWin','selectBestChannel',{channelId=CHAT_CHANNNEL.ePrivate,
actorInfo=actorInfolist[1],
formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent})
end
chatControl.handleMsgList(msgInfoList)
end


function chatControl.onRecvSystemMesg(msgFilterType,showPosValue,mesg,showTitle,canShield,isTop)
local stamp=timeHelper.getServerLongTime()
if canShield==nil then canShield=true end
local handleType=_handleType.eSystem


local msg,params=chatMesgFilterControl.handleMesg(msgFilterType,mesg)

mesg=msg

local argstable={}
argstable.filterType=msgFilterType
argstable.showPosValue=showPosValue
argstable.mesg=mesg
argstable.showTitle=showTitle
argstable.params=params

local msgInfo=chatActorInfo.createMsgInfo(stamp,nil,handleType,canShield,isTop,argstable)
chatControl.handleMsgByRecv(msgInfo)
end


function chatControl.onRecvLastMesg(len,array)
if len==0 then return end
chatControl:checkInitReddot(len,array)
for i,v in ipairs(array)do
local channelId=v.channelid
local msgInfoList={}
local handleType=channelId==CHAT_CHANNNEL.ePrivate and _handleType.ePrivate
or _handleType.ePublic

msgInfoList.isRead=true
msgInfoList.isTop=true
msgInfoList.channelId=channelId
msgInfoList.handleType=handleType
msgInfoList.canShield=true

local msgLen=v.len
local msgList=v.list
local isPrivate=channelId==CHAT_CHANNNEL.ePrivate
if msgLen>0 then
for ii=1,msgLen do
local msgInfo=msgList[ii]
local stamp=timeHelper.convertLongStamp(msgInfo.sec)
local args={
msgInfo.msg,
msgInfo.senderid,
msgInfo.sendername,
msgInfo.senderlv,
msgInfo.iconInfo,
msgInfo.senderbgmid,
msgInfo.senderserverid,
msgInfo.cfLen,
msgInfo.cfList,
}
if not isPrivate then
table.insert(args,1,channelId)
end
args.isLast=true
local msgInfo=chatActorInfo.createMsgInfo(stamp,channelId,handleType,true,true,args)
msgInfoList[#msgInfoList+1]=msgInfo
end
end
chatControl.handleMsgList(msgInfoList)
end


end


function chatControl.onCheckPlayerOffline(actorid,ret,sendguid,serverId)
local mesg=chatCacheControl.getActorCache(sendguid,false)
chatProtocolControl.sendPrivateMesg(actorid,mesg,sendguid,serverId)
end



function chatControl.onHandlePublicMesg(msgInfo)
local msgInfoEx=chatControl.getPublicMsgInfoEx(msgInfo)
chatControl.onRecvAnyChannelMesg(msgInfoEx)
end


function chatControl.onHandlePublicMesgList(msgInfoList)
local msgInfoExList={}
chatControl.copyListArgs(msgInfoList,msgInfoExList)

for _,msgInfo in ipairs(msgInfoList)do
local msgInfoEx=chatControl.getPublicMsgInfoEx(msgInfo)
if msgInfoEx then
msgInfoExList[#msgInfoExList+1]=msgInfoEx
end
end
chatControl.onRecvAnyMesgList(msgInfoExList)
end

function chatControl.getPublicMsgInfoEx(msgInfo)
local argstable=msgInfo.args
local actorId=argstable[3]

if playerModel:checkActorId(actorId)and not argstable.isLast then return end


local stamp=msgInfo.stamp
local channelId=msgInfo.channelId
local handleType=msgInfo.handleType
local canShield=msgInfo.canShield
local isTop=msgInfo.isTop
local params=msgInfo.params

local mesg=argstable[2]
mesg=chatLinkHelper.clearFengxian(mesg)
mesg=chatEmotHelper.clearSpecialSymbol(mesg)

local actorInfo=chatActorInfo.createPublicActorInfo(argstable)

return chatActorInfo.createMsgInfoEx(stamp,
channelId,
CHAT_MESSAGE_TYPE.ePublic,
isTop,
actorInfo,
mesg,nil,nil,canShield,params)
end


function chatControl.onHandlePrivateMesg(msgInfo)
local msgInfoEx=chatControl.getPrivateMsgInfoEx(msgInfo)
chatControl.onRecvAnyChannelMesg(msgInfoEx)
end

function chatControl.onHandlePrivateMesgList(msgInfoList)
local msgInfoExList={}
chatControl.copyListArgs(msgInfoList,msgInfoExList)

for _,msgInfo in ipairs(msgInfoList)do
local msgInfoEx=chatControl.getPrivateMsgInfoEx(msgInfo)
if msgInfoEx then
msgInfoExList[#msgInfoExList+1]=msgInfoEx
end
end
chatControl.onRecvAnyMesgList(msgInfoExList)

end

function chatControl.getPrivateMsgInfoEx(msgInfo)
local argstable=msgInfo.args
local actorId=argstable[2]

if friendModel:getFromList(eFriendDataType.eBlack,actorId)then return end
if playerModel:checkActorId(actorId)then return end

local stamp=msgInfo.stamp
local channelId=msgInfo.channelId
local handleType=msgInfo.handleType
local canShield=msgInfo.canShield
local isTop=msgInfo.isTop
local params=msgInfo.params

local mesg=argstable[1]
mesg=chatEmotHelper.clearSpecialSymbol(mesg)

local actorInfo=chatActorInfo.createPrivateActorInfo(argstable)

chatModel.insertClientPrivateList(2,{stamp,tostring(actorId),mesg,argstable[3],argstable[4],argstable[5],argstable[6],argstable[7],argstable[9]})
return chatActorInfo.createMsgInfoEx(stamp,
channelId,
CHAT_MESSAGE_TYPE.ePrivate,
isTop,
actorInfo,
mesg,
nil,
actorId,
canShield,
params)
end


function chatControl.onHandleSystemMesg(msgInfo)
local systemInfoList,mainInfoList,chatSystemInfo=chatControl.getSystemMsgInfo(msgInfo)
if systemInfoList then
for channelId,list in pairs(systemInfoList)do
for i,v in ipairs(list)do
chatControl.onHandleRecvMesg(v)
end
end
end

if mainInfoList then
for i,v in ipairs(mainInfoList)do
chatControl.onHandleMainRecvMesg(v)
end
end
if chatSystemInfo then
chatControl.onHandleSystemRecvMesg(chatSystemInfo)
end
end

function chatControl.onHandleSystemMesgList(msgInfoList)
local channelInfoList={}
local chatSystemInfoList={}
local mainSystemInfoList={}
for _,msgInfo in ipairs(msgInfoList)do

local systemChannelInfoList,mainInfoList,chatSystemInfo=chatControl.getSystemMsgInfo(msgInfo)
for channelId,list in pairs(systemChannelInfoList or{})do
channelInfoList[channelId]=table.concatTableX(channelInfoList[channelId],list)
end
mainSystemInfoList=table.concatTableX(mainSystemInfoList,mainInfoList)

chatSystemInfoList[#chatSystemInfoList+1]=chatSystemInfo
end
for channelId,v in pairs(channelInfoList)do
v.channelId=channelId
v.isTop=msgInfoList.isTop or false
chatControl.onHandleRecvMesgList(v)
end

for i,v in ipairs(mainSystemInfoList)do
chatControl.onHandleMainRecvMesg(v)
end

chatControl.onHandleCustomMesgList(chatSystemInfoList)
end

function chatControl.getSystemMsgInfo(msgInfo)
local argstable=msgInfo.args
local msgFilterType=argstable.filterType
local showPosValue=argstable.showPosValue
local mesg=argstable.mesg
local showTitle=argstable.showTitle
if not chatMesgFilterControl.check(msgFilterType,mesg)then return end

local stamp=msgInfo.stamp
local channelId=msgInfo.channelId
local handleType=msgInfo.handleType
local canShield=msgInfo.canShield
local isTop=msgInfo.isTop
local params=argstable.params

local channels=chatConfig.getSystemShowChannels(showPosValue)
local systemInfoList={}
local mainInfoList={}
for i,channelId in ipairs(channels)do
if not chatControl.isDisableReceive(channelId,canShield)then

local systemInfo=chatSystemStruct.create(stamp,channelId,mesg,{showTitle=showTitle,filterType=msgFilterType})
if systemInfoList[channelId]==nil then systemInfoList[channelId]={}end
local list=systemInfoList[channelId]
list[#list+1]=systemInfo
chatControl.addLookup(systemInfo,params)

mainInfoList[#mainInfoList+1]=chatSystemStruct.create(stamp,channelId,mesg,{showTitle=showTitle,filterType=msgFilterType})
end
end


local hourPos1=chatMesgFilterControl.getHourPosByMsgType(msgFilterType)
local hourPos2=chatConfig.getHourPosValue(showPosValue)
local hourPos=chatConfig.contactHourPosValue(hourPos1,hourPos2)
local pos=chatConfig.getSystemPosValue(channels)
pos=pos+hourPos
local chatSystemInfo
if pos and pos>0 then
chatSystemInfo=chatSystemStruct.create(stamp,pos,mesg,{showTitle=showTitle})
end
return systemInfoList,mainInfoList,chatSystemInfo
end






function chatControl.reqSystemMesg(msgFilterType,channelIds,mesg,showTitle,canShield)
if channelIds==nil then return end
local showPosValue=0
for _,v in ipairs(channelIds)do
local pos=CHAT_REF_CHANNNEL[v]
if pos then
showPosValue=showPosValue+bit.lshift(1,pos)
end
end
chatControl.onRecvSystemMesg(msgFilterType,showPosValue,mesg,showTitle,canShield)
end



function chatControl.reqPublicMesg(channelId,mesg)
mesg=chatEmotHelper.clearSpecialSymbol(mesg)
if not chatCommonHelper.isCanSpeakOnChannel(channelId,mesg,true)then return end
local sendguid=chatCacheControl.addActorCache(mesg)
chatProtocolControl.sendPublicMesg(channelId,mesg,sendguid)
return sendguid
end


function chatControl.reqLocalPublicMesg(channelId,mesg)
if not chatCommonHelper.isCanSpeakOnChannel(channelId,mesg,true)then return end
local sendguid=chatCacheControl.addActorCache(mesg)
chatCacheControl.onSendPublicMesgRet(channelId,sendguid,mesg)
end


function chatControl.reqPrivateMesg(fromType,actorId,mesg,serverId)
mesg=chatEmotHelper.clearSpecialSymbol(mesg)
if not chatCommonHelper.isCanSpeakOnChannel(CHAT_CHANNNEL.ePrivate,mesg,true)then return end
local sendguid=chatCacheControl.addActorCache(mesg)
if fromType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend then
local isOnline=friendModel:isOnline(eFriendDataType.eLocal,actorId)
if isOnline==nil then
isOnline=friendModel:isOnline(eFriendDataType.eCross,actorId)
end
if isOnline==nil then
gameUtilityControl:reqCheckPalayerOffline(CHECK_OFFLINE_FORM_TYPE.ePrivateChat,actorId,sendguid,serverId)
else

chatProtocolControl.sendPrivateMesg(actorId,mesg,sendguid,serverId)
end
else
gameUtilityControl:reqCheckPalayerOffline(CHECK_OFFLINE_FORM_TYPE.ePrivateChat,actorId,sendguid,serverId)
end
return sendguid
end




function chatControl.onRecvAnyChannelMesg(msgInfoEx)
if msgInfoEx==nil then return end
local channelId=msgInfoEx.channelId
local msgType=msgInfoEx.msgType
local actorInfo=msgInfoEx.actorInfo
local sendguid=msgInfoEx.sendguid
local holderId=msgInfoEx.holderId
local canShield=msgInfoEx.canShield
local isRecv=sendguid==nil
if chatControl.isDisableReceive(channelId,canShield)then return false end

local chatInfo=chatActorInfo.createChatInfo(msgInfoEx)
if chatInfo==nil then return end
chatControl.addLookup(chatInfo,msgInfoEx.params)


if msgType==CHAT_MESSAGE_TYPE.ePrivate then
chatRecentModel.setRecentInfo(actorInfo)
end


chatControl.onHandleRecvMesg(chatInfo)

local chatInfo=chatActorInfo.createChatInfo(msgInfoEx)
chatControl.onHandleMainRecvMesg(chatInfo)

if isRecv then
notifySystem:postNotify(notifyConfig.onRecvMessage,channelId)
end
end

function chatControl.onRecvAnyMesgList(msgInfoExArray)
if msgInfoExArray==nil or#msgInfoExArray==0 then return end
local chatInfoList={}
local chatInfo2List={}
local isRecv=false
local channelId=msgInfoExArray.channelId
local isTop=msgInfoExArray.isTop or false
local isPrivate=channelId==CHAT_CHANNNEL.ePrivate
chatControl.copyListArgs(msgInfoExArray,chatInfoList)
for _,msgInfoEx in ipairs(msgInfoExArray)do
local actorInfo=msgInfoEx.actorInfo
local sendguid=msgInfoEx.sendguid

local chatInfo=chatActorInfo.createChatInfo(msgInfoEx)
if chatInfo then
chatInfoList[#chatInfoList+1]=chatInfo
chatControl.addLookup(chatInfo,msgInfoEx.params)
chatInfo2List[#chatInfo2List+1]=chatActorInfo.createChatInfo(msgInfoEx)
if isPrivate then
chatRecentModel.setRecentInfo(actorInfo)
end
isRecv=isRecv or sendguid==nil
end
end


chatControl.onHandleRecvMesgList(chatInfoList,isTop)
chatControl.onHandleMainRecvMesg(chatInfo2List,isTop)

if isRecv then
notifySystem:postNotify(notifyConfig.onRecvMessage,channelId)
end
end


function chatControl.onHandleCustomMesg(stamp,showTitle,mesg,hourPos,channels)
local pos=chatConfig.getSystemPosValue(channels)
pos=pos+hourPos
if pos and pos>0 then
local chatSystemInfo=chatSystemStruct.create(stamp,pos,mesg,{showTitle=showTitle})
chatControl.onHandleSystemRecvMesg(chatSystemInfo)
end
end

function chatControl.onHandleCustomMesgList(chatSystemInfoList)
for i,v in ipairs(chatSystemInfoList)do
chatControl.onHandleSystemRecvMesg(v)
end
end

function chatControl.addLookup(chatInfo,params)
local msgID=chatInfo.msgID
if _lookup[msgID]then return end
_lookup[msgID]=chatInfo
chatControl:addNotify_refresh(msgID,params)
end

function chatControl.getMsgInfo(msgID)
return _lookup[msgID]
end

function chatControl.setMsgInfoMsg(msgID,mesg)
local chatInfo=chatControl.getMsgInfo(msgID)
if chatInfo then
chatInfo.mesg=mesg
end
end



function chatControl.handleMsgByRecv(msgInfo)

local channelId=msgInfo.channelId
if channelId==CHAT_CHANNNEL.eJianwen then
loggerUtil.logErrFMT('服务器不应该下发见闻消息，否则需要筛选类型')
return false
end

if not _isCanRecv then
_cache[#_cache+1]=msgInfo
return
end
local handleType=msgInfo.handleType
local dataType=_handleDataType.eSingle

local func=_handleFunc[dataType][handleType]
if func then
func(msgInfo)
end
end



function chatControl.handleMsgList(msgInfoList)


msgInfoList.list=true
if not chatControl.checkList(msgInfoList)then return end

if not _isCanRecv then
_cache[#_cache+1]=msgInfoList
return
end
local dataType=_handleDataType.eList
local handleType=msgInfoList.handleType

local func=_handleFunc[dataType][handleType]
if func then
func(msgInfoList)
end
end


function chatControl.handleCache()
if _isCanRecv then
chatControl.handleClientPrivate()

for _,v in ipairs(_cache)do
chatControl.handleCacheInfo(v)
chatControl.handleCacheList(v)
end
_cache={}

end
end

function chatControl.handleCacheList(v)
if v.list then
local dataType=_handleDataType.eList
local channelId=v.channelId
local handleType=v.handleType
local func=_handleFunc[dataType][handleType]
if func then
func(v)
end
end
end

function chatControl.handleCacheInfo(v)
if not v.list then
local dataType=_handleDataType.eSingle
local channelId=v.channelId
local handleType=v.handleType
local func=_handleFunc[dataType][handleType]
if func then
func(v)
end
end
end

function chatControl.handleClientPrivate()
local channelId=CHAT_CHANNNEL.ePrivate
local holder=chatControl.getHolder(channelId)
if holder then
holder:initClientMesg()
end
end

function chatControl.copyListArgs(sourceTable,destTable)
destTable.channelId=sourceTable.channelId
destTable.isTop=sourceTable.isTop
destTable.isRead=sourceTable.isRead
destTable.handleType=sourceTable.handleType
destTable.canShield=sourceTable.canShield
end

function chatControl.checkList(msgInfoList)
if msgInfoList.channelId==nil then
loggerUtil.logErrFMT('消息列表处理必须要有channelId')
return false
end
if msgInfoList.handleType==nil then
loggerUtil.logErrFMT('消息列表处理必须要有handleType')
return false
end
return true
end









































