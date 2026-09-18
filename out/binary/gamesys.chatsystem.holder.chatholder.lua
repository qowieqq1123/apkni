





chatHolder=simple_class(refObject)

function chatHolder.create(channelId)
local object=refObject.get('chatHolder',channelId)
return object
end

function chatHolder:init(channelId)
self:onRelease()
self.channelId=channelId
self.showTimeCfg=self:isShowTimeFlag()
end

function chatHolder:onRelease()
self.channelId=CHAT_CHANNNEL.eNone
self:clearData()
self.showTimeCfg=0

for _,v in pairs(self.handlerLookup or{})do
refObject.release(v)
end
self.handlerLookup={}
end

function chatHolder:clearData()

if self.cacheInfoList then
for i,v in ipairs(self.cacheInfoList)do
refObject.release(v)
end
end
self.cacheInfoList={}

self.cacheExistLookup={}

if self.cachePlayerInfoList then
for _,list in pairs(self.cachePlayerInfoList)do
for _,v in ipairs(list)do
refObject.release(v)
end
end
end
self.cachePlayerInfoList={}


self.indexLookup={}
self.playerIndexLookup={}


self.readMesgId=0
self.readPlayerMesgId={}


self.readMesgIdx=0
self.readPlayerMesgIdx={}


self.newestMesgNum=0
self.newestPlayerMesgNum={}


self.newestMesgStamp=nil
self.newestPlayerMesgStamp={}


self.lastTime={}
self.timeList={}
self.playerTimeList={}
end

function chatHolder:clearRead()

self.readMesgId=0
self.readPlayerMesgId={}


self.readMesgIdx=0
self.readPlayerMesgIdx={}
end

function chatHolder:initClientMesg()
local clientInfoList=chatModel.getClientPrivateList()
if clientInfoList then
for actorId,v in pairs(clientInfoList)do
actorId=int64.new(actorId)
for _,info in ipairs(v)do
local aType=info[1]
local m=info[2]
if aType==1 then
local msgInfoEx=chatActorInfo.createMsgInfoEx(m[1],
CHAT_CHANNNEL.ePrivate,
CHAT_MESSAGE_TYPE.ePrivate,
false,
chatActorInfo.createSelf(),
m[4],
m[3],
actorId)
local chatInfo=chatActorInfo.createChatInfo(msgInfoEx)
self:addChatInfo(chatInfo,true)
else
local cFlagLen=0
if m[9]then cFlagLen=#m[9]end
local args={m[3],actorId,m[4],m[5],m[6],m[7],m[8],cFlagLen,m[9]}
local actorInfo=chatActorInfo.createPrivateActorInfo(args)
local msgInfo=chatActorInfo.createMsgInfoEx(m[1],
CHAT_CHANNNEL.ePrivate,
CHAT_MESSAGE_TYPE.ePrivate,
false,
actorInfo,
m[3],
nil,
actorId)

local chatInfo=chatActorInfo.createChatInfo(msgInfo)
self:addChatInfo(chatInfo,true)
end
end
end
end
end



function chatHolder:onRecvMesg(chatStructInfo)
if chatStructInfo==nil or chatStructInfo.msgID==nil or chatStructInfo.msgID==0 then return end
if self:isReceive(chatStructInfo)and
self:addChatInfo(chatStructInfo)then

local isBlack=false
if chatStructInfo.actorInfo then
isBlack=friendModel:isBlack(chatStructInfo.actorInfo.actorId)
end
if not isBlack then
self:onHandleRecv(chatStructInfo)
end
end
end

function chatHolder:onRecvMesgList(chatStructInfoList)
if chatStructInfoList==nil then return end
local isTop=chatStructInfoList.isTop or false
self:addChatInfoList(chatStructInfoList,isTop)
self:onHandleListRecv(chatStructInfoList,isTop)
end


function chatHolder:onDeleteMesg(msgID)
if self:deleteChatInfoBymsgID(msgID)then
self:onHandleDelete(msgID)
end
end


function chatHolder:onDeletePlayerAllMesg(actorId)
local msgIDArray=self:deleteChatInfoByActorId(actorId)
if msgIDArray and#msgIDArray>0 then
self:onHandleDeleteList(msgIDArray)
end
end


function chatHolder:onDeletePlayerMesg(actorId,msg)
local msgIDArray=self:deleteChatInfoByActorIdMesg(actorId,msg)
if msgIDArray and#msgIDArray>0 then
self:onHandleDeleteList(msgIDArray)
end
end




function chatHolder:addHandler(handle)
local guid=handle.guid
if self.handlerLookup[guid]then return end
self.handlerLookup[guid]=handle
end

function chatHolder:deleteHandler(handle)
local guid=handle.guid
self.handlerLookup[guid]=nil
end

function chatHolder:getHandlers()
return self.handlerLookup
end

function chatHolder:invokeHanderFunc(func,...)
for _,handler in pairs(self.handlerLookup)do
if handler[func]then
handler[func](handler,...)
end
end
end

function chatHolder:invokeOneHanderFunc(_handler,func,...)
for guid,handler in pairs(self.handlerLookup)do
if _handler.guid==guid and handler[func]then
if handler[func]then
return handler[func](handler,...)
end
end
end
end

function chatHolder:onHandleRecv(chatStructInfo)
local channelId=chatStructInfo.channelId
for k,v in pairs(self.handlerLookup)do
v:onRecvMesg(chatStructInfo)
end
end

function chatHolder:onHandleListRecv(chatStructInfoList,isTop)
for k,v in pairs(self.handlerLookup)do
v:onRecvMesgList(chatStructInfoList,isTop)
end
end

function chatHolder:onHandleDelete(msgId)
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsg then
hander:onDeleteMsg(msgId)
end
end
end

function chatHolder:onHandleDeleteByIndex(index)
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsgByIndex then
hander:onDeleteMsgByIndex(index)
end
end
end

function chatHolder:onHandleDeleteList(msgIdlist)
if msgIdlist==nil or#msgIdlist==0 then return end
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsg then
hander:onDeleteMsgList(msgIdlist)
end
end
end


function chatHolder:isReceive(chatStructInfo)
return self.channelId==chatStructInfo.channelId
end


function chatHolder:freshAllPublicIndex()
self.indexLookup={}
local lookup=self.indexLookup
local list=self.cacheInfoList
for i,v in ipairs(list)do
local msgID=v.msgID
lookup[msgID]=i
end
end


function chatHolder:freshAllPlayerIndex(actorId)
if actorId==nil then return end
local idStr=tostring(actorId)
self.playerIndexLookup[idStr]={}
local lookup=self.playerIndexLookup[idStr]
if self.cachePlayerInfoList[idStr]==nil then return end
local list=self.cachePlayerInfoList[idStr]
for i,v in ipairs(list)do
local msgID=v.msgID
lookup[msgID]=i
end
end


function chatHolder:getPublicIndex(msgID)
return self.indexLookup[msgID]
end


function chatHolder:getPlayerIndex(actorId,msgID)
local idStr=tostring(actorId)
return self.playerIndexLookup[idStr][msgID]
end


function chatHolder:getPublicLen()
local list=self.cacheInfoList
return#list
end


function chatHolder:getPrivateLen(actorId)
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return 0 end
return#self.cachePlayerInfoList[idStr]
end



function chatHolder:getPublicTotalInfoList()
local list={}
for i,v in ipairs(self.cacheInfoList)do
if v.actorInfo~=nil then
local isBlack=friendModel:isBlack(v.actorInfo.actorId)
if not isBlack then
table.insert(list,v)
end
else
table.insert(list,v)
end
end
return list
end


function chatHolder:getPrivateTotalInfoList(actorId)
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return end
local list=self.cachePlayerInfoList[idStr]
local tNum=#list
return list
end


function chatHolder:getPrivateTotalSendList(actorId)
local idStr=tostring(actorId)
if self.cachePlayerSendList[idStr]==nil then return end
local list=self.cachePlayerSendList[idStr]
return list
end


function chatHolder:getPublicLastInfoList(len,endIndex)
local list=self.cacheInfoList
local tNum=#list
if endIndex and endIndex<1 then return end
if tNum==0 then return{},0,0 end
if endIndex==nil or endIndex>tNum then endIndex=tNum end
local startIndex=endIndex-len
if startIndex<1 then startIndex=1 end
return table.sub(self.cacheInfoList,startIndex,endIndex),startIndex,endIndex
end


function chatHolder:getPrivateLastInfoList(len,endIndex,actorId)
if endIndex and endIndex<1 then return end
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return end
local list=self.cachePlayerInfoList[idStr]
local tNum=#list
if tNum==0 then return{},0,0 end
if endIndex==nil or endIndex>tNum then endIndex=tNum end
local startIndex=endIndex-len
if startIndex<1 then startIndex=1 end
return table.sub(list,startIndex,endIndex),startIndex,endIndex
end


function chatHolder:getPublicNextInfoList(len,startIndex)
local list=self.cacheInfoList
local tNum=#list
if startIndex and startIndex>tNum then return end
if tNum==0 then return{},0,0 end
if startIndex==nil or startIndex<1 then startIndex=1 end
local endIndex=startIndex+len
if endIndex>tNum then endIndex=tNum end
return table.sub(self.cacheInfoList,startIndex,endIndex),startIndex,endIndex
end


function chatHolder:getPrivateNextInfoList(len,startIndex,actorId)
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return end
local list=self.cachePlayerInfoList[idStr]
local tNum=#list
if startIndex and startIndex>tNum then return end
if tNum==0 then return{},0,0 end
if startIndex==nil or startIndex<1 then startIndex=1 end
local endIndex=startIndex+len
if endIndex>tNum then endIndex=tNum end
return table.sub(list,startIndex,endIndex),startIndex,endIndex
end


function chatHolder:getPublicReadIdx()
local num=chatControl:getInitReddot(self.channelId)
if num<=0 then
return self.readMesgIdx or 0
end
local idx=self.readMesgIdx-num
if idx<=1 then idx=1 end
return idx
end


function chatHolder:getPrivateReadIdx(actorId)
if self.channelId~=CHAT_CHANNNEL.ePrivate then return 0 end
local idStr=tostring(actorId)
return self.readPlayerMesgIdx[idStr]or 0
end


function chatHolder:readNewestMesgByChannel(isinit)
if self.channelId==CHAT_CHANNNEL.ePrivate then return end
local list=self.cacheInfoList
local len=#list
if len==0 then return end
self.readMesgIdx=len
self.readMesgId=list[#list].msgID
self.newestMesgNum=0
if not isinit then
chatControl:clearInitReddot(self.channelId)
chatControl:setReadStamp(self.channelId)
end
end


function chatHolder:readNewestMesgByPlayer(actorId,isinit)
if self.channelId~=CHAT_CHANNNEL.ePrivate then return end
local idStr=tostring(actorId)
local playerInfoList=self.cachePlayerInfoList[idStr]or{}
local len=#playerInfoList
if len==0 then return end
local newestId=playerInfoList[len].msgID
self.readPlayerMesgIdx[idStr]=len
self.readPlayerMesgId[idStr]=newestId
self.newestMesgNum=0
self.newestPlayerMesgNum[idStr]=0



end


function chatHolder:hasNewMesgByChannel()
if self.channelId~=CHAT_CHANNNEL.ePrivate then
local readMsgID=self.readMesgId
local list=self.cacheInfoList
local len=#list
if len==0 then return false end
local newestMesgNum=self.newestMesgNum+chatControl:getInitReddot(self.channelId)
return newestMesgNum>0
else
local hasMesg=false
local hasFriendMesg=false
local hasRecentMesg=false

if chatModel.checkLiuYanReddot()then
hasMesg=true
hasFriendMesg,hasRecentMesg=chatModel.checkFriendAndRecentLiuYanReddot()
end

if hasMesg and hasFriendMesg and hasRecentMesg then

return hasMesg,hasFriendMesg,hasRecentMesg
end

for idStr,v in pairs(self.cachePlayerInfoList)do
if self:hasNewMesgByPlayer(idStr)then
hasMesg=true
for _,vv in ipairs(v)do
if vv.actorInfo and not vv:isSelfActor()then
local isFriend=friendModel:isFriend(vv.actorInfo.actorId)
hasFriendMesg=hasFriendMesg or isFriend
hasRecentMesg=hasRecentMesg or not isFriend
end

if hasMesg and hasFriendMesg and hasRecentMesg then
return true,true,true
end
end
end
end
return hasMesg,hasFriendMesg,hasRecentMesg
end
end


function chatHolder:hasNewMesgByPlayer(idStr)
idStr=tostring(idStr)
if self.channelId~=CHAT_CHANNNEL.ePrivate then return false end
if self.cachePlayerInfoList[idStr]==nil then return false end
local list=self.cachePlayerInfoList[idStr]
local len=#list
if len==0 then return false end
local num=self.newestPlayerMesgNum[idStr]or 0
return num>0
end


function chatHolder:getNewMesgNumByChannel(channelId)
if channelId==CHAT_CHANNNEL.ePrivate then
return self:getNewMesgByPrivateChannel()
end
local num=self.newestMesgNum or 0
num=num+chatControl:getInitReddot(channelId)
return num
end

function chatHolder:setNewMesgNumByChannel(channelId,num)
if channelId~=CHAT_CHANNNEL.ePrivate then
if num<=0 then

self:readNewestMesgByChannel()
else
self.newestMesgNum=num
end
end
end


function chatHolder:getNewMesgByPrivateChannel()
local num=0
local channelId=CHAT_CHANNNEL.ePrivate
local liuyan=chatModel.getLiuYanCount()

for k,v in pairs(self.cachePlayerInfoList)do
num=num+self:getNewMesgNumByPlayer(k)
end
return num+liuyan
end


function chatHolder:getNewMesgNumByPlayer(actorId)
local idStr=tostring(actorId)
return self.newestPlayerMesgNum[idStr]or 0
end


function chatHolder:getNewMesgStampByChannel(channelId)
return self.newestMesgStamp or 0
end

function chatHolder:getNewMesgStampByPlayer(actorId)
local idStr=tostring(actorId)
return self.newestPlayerMesgStamp[idStr]or 0
end

function chatHolder:printPublicMesg()







end

function chatHolder:addChatInfo(chatInfo,isHistory)
local msgID=chatInfo.msgID
if self.cacheExistLookup[msgID]then
loggerUtil.logErrFMT('hold已有此消息:{0}',tostring(chatInfo.orgMesg))
return false
end

local isTop=chatInfo.isTop
self.cacheExistLookup[msgID]=true

local channelId=chatInfo.channelId

if channelId==CHAT_CHANNNEL.ePrivate then
local actorId=chatInfo:getHolderId()
local len=self:getPrivateLen(actorId)
local index=isTop and 1 or len+1
self:insertPrivate(chatInfo,index,isHistory)
else
local len=self:getPublicLen()
local index=isTop and 1 or len+1
self:insertPublic(chatInfo,index)
end
return true
end


function chatHolder:insertPublic(chatInfo,index)
local msgID=chatInfo.msgID

local msgType=chatInfo.msgType
local actorMsg=msgType==CHAT_MESSAGE_TYPE.ePublic or
msgType==CHAT_MESSAGE_TYPE.ePrivate

local list=self.cacheInfoList
local len=#list

local readMesgIdx=self.readMesgIdx
local isSelfActor=chatInfo:isSelfActor()
local isInsert=index<=len
local isRead=readMesgIdx>=index
local isReadSelf=index==(readMesgIdx+1)and isSelfActor
local isBlack=false
if chatInfo.actorInfo then
isBlack=friendModel:isBlack(chatInfo.actorInfo.actorId)
end
local isNewMesg=not isSelfActor and actorMsg and not isRead and not isBlack
local indexLookup=self.indexLookup

table.insert(list,index,chatInfo)
chatInfo:retain()

local stamp=chatInfo.timeStamp
if self.newestMesgStamp==nil or self.newestMesgStamp<stamp then
self.newestMesgStamp=stamp
end

indexLookup[msgID]=index

if isInsert then
self:freshAllPublicIndex()
end

if isNewMesg then
self.newestMesgNum=self.newestMesgNum+1
end



if isInsert and isRead or isReadSelf then
self.readMesgIdx=self.readMesgIdx+1
end

if self.readMesgIdx<0 then self.readMesgIdx=0 end

if actorMsg then
self:freshPublicTimeFlag(index)
end
end

function chatHolder:insertPrivate(chatInfo,index,isHistory)
if self.channelId~=CHAT_CHANNNEL.ePrivate then return end
local msgID=chatInfo.msgID
local msgType=chatInfo.msgType
local actorMsg=msgType==CHAT_MESSAGE_TYPE.ePublic or
msgType==CHAT_MESSAGE_TYPE.ePrivate

local actorId=chatInfo:getHolderId()

local isSelfActor=chatInfo:isSelfActor()

local idStr=tostring(actorId)

if self.cachePlayerInfoList[idStr]==nil then self.cachePlayerInfoList[idStr]={}end
local list=self.cachePlayerInfoList[idStr]
local len=#list

if self.playerIndexLookup[idStr]==nil then self.playerIndexLookup[idStr]={}end
local indexLookup=self.playerIndexLookup[idStr]

if self.readPlayerMesgIdx[idStr]==nil then self.readPlayerMesgIdx[idStr]=0 end
if self.newestPlayerMesgNum[idStr]==nil then self.newestPlayerMesgNum[idStr]=0 end


local stamp=chatInfo.timeStamp
if self.newestPlayerMesgStamp[idStr]==nil or self.newestPlayerMesgStamp[idStr]<stamp then
self.newestPlayerMesgStamp[idStr]=stamp
end

local readMesgIdx=self.readPlayerMesgIdx[idStr]

local isInsert=index<=len
local isRead=readMesgIdx>=index
local isReadSelf=index==(readMesgIdx+1)and isSelfActor
local isNewMesg=not isSelfActor and actorMsg and not isRead and not isHistory

table.insert(list,index,chatInfo)
chatInfo:retain()

indexLookup[msgID]=index

if isInsert then
self:freshAllPlayerIndex(actorId)
end

if isNewMesg then
local old=self.newestPlayerMesgNum[idStr]or 0
self.newestPlayerMesgNum[idStr]=old+1
end



if isInsert and isRead or isReadSelf then
self.readPlayerMesgIdx[idStr]=readMesgIdx+1
end

if self.readPlayerMesgIdx[idStr]<0 then
self.readPlayerMesgIdx[idStr]=0
end

if actorMsg then
self:freshPrivateTimeFlag(actorId,index)
end
end

function chatHolder:addChatInfoList(chatInfoList,isTop)
local isRead=chatInfoList.isRead or false
local _channelId=chatInfoList.channelId

local actorIds={}
local actorIdLookup={}
local startIndex=0
local playerStartIndex={}

for _,chatInfo in ipairs(chatInfoList)do
local msgID=chatInfo.msgID
if not self.cacheExistLookup[msgID]then
self.cacheExistLookup[msgID]=true

local channelId=chatInfo.channelId
if channelId~=_channelId then
loggerUtil.logErrFMT('不能同时处理不同频道的信息列表')
end

if channelId==CHAT_CHANNNEL.ePrivate then
local actorId=chatInfo:getHolderId()
if not actorIdLookup[tostring(actorId)]then
actorIdLookup[tostring(actorId)]=true
actorIds[#actorIds+1]=actorId
end
if isTop then
local index=(playerStartIndex[tostring(actorId)]or 0)+1
self:insertPrivate(chatInfo,index)
playerStartIndex[tostring(actorId)]=index
else
local len=self:getPrivateLen(actorId)
self:insertPrivate(chatInfo,len+1)
end
else
if isTop then
local index=startIndex+1
self:insertPublic(chatInfo,index)
startIndex=index
else
local len=self:getPublicLen()
self:insertPublic(chatInfo,len+1)
end
end
end
end

if isRead then
if _channelId==CHAT_CHANNNEL.ePrivate then
for i,v in ipairs(actorIds)do
self:readNewestMesgByPlayer(v,true)
end
else
self:readNewestMesgByChannel(true)
end
end
end


function chatHolder:deleteChatInfoBymsgID(msgID)
local channelId=self.channelId
if not self.cacheExistLookup[msgID]then
return false
end
self.cacheExistLookup[msgID]=nil

local isPrivate=channelId==CHAT_CHANNNEL.ePrivate
if isPrivate then
local ret,actorId=self:deletePrivateDataByMsgID(msgID)
if ret then
self:freshAllPlayerIndex(actorId)
end
return ret
else
local ret=self:deletePublicData(msgID)
if ret then
self:freshAllPublicIndex()
end
return ret
end
end

function chatHolder:deleteChatInfoByActorId(actorId)
local channelId=self.channelId
local isPrivate=channelId==CHAT_CHANNNEL.ePrivate
local msgIDArray
if isPrivate then
msgIDArray=self:deletePrivatePlayerData(actorId)
if msgIDArray and#msgIDArray>0 then
self:freshAllPlayerIndex(actorId)
end
else
msgIDArray=self:deletePublicPlayerData(actorId)
if msgIDArray and#msgIDArray>0 then
self:freshAllPublicIndex()
end
end
return msgIDArray
end

function chatHolder:deleteChatInfoByActorIdMesg(actorId,mesg)
local channelId=self.channelId
local isPrivate=channelId==CHAT_CHANNNEL.ePrivate
local msgIDArray
if isPrivate then
msgIDArray=self:deletePrivatePlayerDataByMsg(actorId,mesg)
if msgIDArray and#msgIDArray>0 then
self:freshAllPlayerIndex(actorId)
end
else
msgIDArray=self:deletePublicPlayerDataByMsg(actorId,mesg)
if msgIDArray and#msgIDArray>0 then
self:freshAllPublicIndex()
end
end
return msgIDArray
end


function chatHolder:deletePublicData(msgID)
local list=self.cacheInfoList
local len=#list
if len<=0 then return false end
local readMesgIdx=self.readMesgIdx
local readMesgId=self.readMesgId
for i=len,1,-1 do
local chatInfo=list[i]
if msgID==chatInfo.msgID then
table.remove(list,i)
self.cacheExistLookup[msgID]=nil
if i<=readMesgIdx then
readMesgIdx=readMesgIdx-1
if readMesgIdx<0 then readMesgIdx=0 end

if list[readMesgIdx]then
readMesgId=list[readMesgIdx].msgID
else
readMesgId=0
end
self.readMesgIdx=readMesgIdx
self.readMesgId=readMesgId
end
refObject.release(chatInfo)
return true
end
end
return false
end

function chatHolder:deletePrivateData(actorId,msgID)
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return false end
local list=self.cachePlayerInfoList[idStr]or{}
local len=#list
if len<=0 then return false end
local readMesgIdx=self.readPlayerMesgIdx[idStr]
local readMesgId=self.readPlayerMesgId[idStr]
for i=len,1,-1 do
local chatInfo=list[i]
if msgID==chatInfo.msgID then
table.remove(list,i)
if i<=readMesgIdx then
readMesgIdx=readMesgIdx-1
if readMesgIdx<0 then readMesgIdx=0 end

if list[readMesgIdx]then
readMesgId=list[readMesgIdx].msgID
else
readMesgId=0
end
self.readPlayerMesgIdx[idStr]=readMesgIdx
self.readPlayerMesgId[idStr]=readMesgId
end
refObject.release(chatInfo)
return true
end
end
return false
end

function chatHolder:deletePrivateDataByMsgID(msgID)
for idStr,list in pairs(self.cachePlayerInfoList)do
if self:deletePrivateData(int64.new(idStr),msgID)then
return true,int64.new(idStr)
end
end
return false
end

function chatHolder:deletePublicPlayerDataByMsg(actorId,msg)
local list=self.cacheInfoList
local len=#list
if len<=0 then return{}end
local msgIDArray={}
local readMesgIdx=self.readMesgIdx
local readMesgId=self.readMesgId
for i=len,1,-1 do
local chatInfo=list[i]
local msgID=chatInfo.msgID
if chatInfo:isActorId(actorId)and chatInfo.orgMesg==msg then
table.remove(list,i)
msgIDArray[#msgIDArray+1]=msgID
self.cacheExistLookup[msgID]=nil
if i<=readMesgIdx then
readMesgIdx=readMesgIdx-1
if readMesgIdx<0 then readMesgIdx=0 end

if list[readMesgIdx]then
readMesgId=list[readMesgIdx].msgID
else
readMesgId=0
end
self.readMesgIdx=readMesgIdx
self.readMesgId=readMesgId
end
refObject.release(chatInfo)
end
end
return msgIDArray
end

function chatHolder:deletePublicPlayerData(actorId)
local list=self.cacheInfoList
local len=#list
if len<=0 then return{}end
local msgIDArray={}
local readMesgIdx=self.readMesgIdx
local readMesgId=self.readMesgId
for i=len,1,-1 do
local chatInfo=list[i]
local msgID=chatInfo.msgID
if chatInfo:isActorId(actorId)then
table.remove(list,i)
msgIDArray[#msgIDArray+1]=msgID
self.cacheExistLookup[msgID]=nil
if i<=readMesgIdx then
readMesgIdx=readMesgIdx-1
if readMesgIdx<0 then readMesgIdx=0 end

if list[readMesgIdx]then
readMesgId=list[readMesgIdx].msgID
else
readMesgId=0
end
self.readMesgIdx=readMesgIdx
self.readMesgId=readMesgId
end
refObject.release(chatInfo)
end
end
return msgIDArray
end

function chatHolder:deletePrivatePlayerDataByMsg(actorId,msg)
local idStr=tostring(actorId)
if self.cachePlayerInfoList[idStr]==nil then return{}end
local list=self.cachePlayerInfoList[idStr]
local len=#list
if len<=0 then return{}end
local msgIDArray={}
local readMesgIdx=self.readMesgIdx
local readMesgId=self.readMesgId
for i=len,1,-1 do
local chatInfo=list[i]
local msgID=chatInfo.msgID
if chatInfo.orgMesg==msg then
table.remove(list,i)
msgIDArray[#msgIDArray+1]=msgID
if i<=readMesgIdx then
readMesgIdx=readMesgIdx-1
if readMesgIdx<0 then readMesgIdx=0 end

if list[readMesgIdx]then
readMesgId=list[readMesgIdx].msgID
else
readMesgId=0
end
self.readPlayerMesgIdx[idStr]=readMesgIdx
self.readPlayerMesgId[idStr]=readMesgId
end
refObject.release(chatInfo)
end
end
return msgIDArray
end

function chatHolder:deletePrivatePlayerData(actorId)
local idStr=tostring(actorId)
local array=self.cachePlayerInfoList[idStr]
if array==nil then return end
local msgIDArray={}
for i,v in ipairs(array)do
msgIDArray[#msgIDArray+1]=v.msgID
end
self.cachePlayerInfoList[idStr]=nil
self.readPlayerMesgIdx[idStr]=0
self.readPlayerMesgId[idStr]=0
return msgIDArray
end


function chatHolder:isMarkTime(oldTimeStamp,newTimeStamp)
if not self.showTimeCfg then return false end
if oldTimeStamp==nil then return true end
local div=newTimeStamp-oldTimeStamp or 0
local timeSpace=chatConfig.getCommonConfig().timeSpace
return div>timeSpace
end

function chatHolder:isShowTimeFlag()
local comcfg=chatConfig.getCommonConfig()
local flag=false
local showTime=comcfg.showTime
for _,v in ipairs(showTime)do
if v==self.channelId then
flag=true
break
end
end
return flag
end

function chatHolder:setPublicTimeFlag(chatStructInfo)
local stamp=chatStructInfo.timeStamp
if self:isMarkTime(self.lastTime,stamp)then
chatStructInfo.timeFlag=true
self.lastTime=stamp
self.timeList[#self.timeList+1]=stamp
table.sort(self.timeList,function(a,b)
return a<b
end)
end
end

function chatHolder:setPrivateTimeFlag(chatStructInfo,actorid)
local stamp=chatStructInfo.timeStamp
local idStr=tostring(actorid)
if self.playerTimeList[idStr]==nil then self.playerTimeList[idStr]={}end
local timeList=self.playerTimeList[idStr]
if self:isMarkTime(self.lastTime[actorid],stamp)then
chatStructInfo.timeFlag=true
self.lastTime[actorid]=stamp
timeList[#timeList+1]=stamp
table.sort(timeList,function(a,b)
return a<b
end)
end
end

function chatHolder:isMark(starttime,time,endtime)
if starttime==nil and endtime==nil then return true end
if endtime==nil then return self:isMarkTime(starttime,time)end
if starttime==nil then return self:isMarkTime(time,endtime)end
return self:isMarkTime(starttime,time)and
self:isMarkTime(time,endtime)
end

function chatHolder:checkMsgType(msgType)
return msgType==CHAT_MESSAGE_TYPE.ePublic or
msgType==CHAT_MESSAGE_TYPE.ePrivate
end


function chatHolder:freshPublicTimeFlag(index)
if not self.showTimeCfg then return end
local list=self.cacheInfoList
local timeList=self.timeList

local len=#list
if len<=0 then return end

local chatInfo=list[index]
if chatInfo.timeFlag then return end

local len=#list
local endStamp=nil
local startStamp=nil
for i=1,len do
local timeStamp=list[i].timeStamp
if timeStamp then
if i<index then
if startStamp==nil or timeStamp>startStamp then
startStamp=timeStamp
end
elseif i>index then
if startStamp==nil or timeStamp<startStamp then
startStamp=timeStamp
end
end
end
end

if self:checkMsgType(chatInfo.msgType)and
self:isMark(startStamp,chatInfo.timeStamp,endStamp)then
chatInfo.timeFlag=true
timeList[#timeList+1]=chatInfo.timeStamp
startStamp=chatInfo.timeStamp
end


table.sort(timeList,function(a,b)
return a<b
end)
end


function chatHolder:freshPrivateTimeFlag(actorId,index)
if actorId==nil then return end
local idStr=tostring(actorId)

if self.playerTimeList[idStr]==nil then self.playerTimeList[idStr]={}end
local timeList=self.playerTimeList[idStr]

if self.cachePlayerInfoList[idStr]==nil then return end
local list=self.cachePlayerInfoList[idStr]

local len=#list
if len<=0 then return end

local chatInfo=list[index]
if chatInfo.timeFlag then return end

local len=#list
local endStamp=nil
local startStamp=nil
for i=1,len do
local timeFlag=list[i].timeFlag
if timeFlag then
local timeStamp=list[i].timeStamp
if i<index then
if startStamp==nil or timeStamp>startStamp then
startStamp=timeStamp
end
elseif i>index then
if startStamp==nil or timeStamp<startStamp then
startStamp=timeStamp
end
end
end
end

if self:checkMsgType(chatInfo.msgType)and
self:isMark(startStamp,chatInfo.timeStamp,endStamp)then
chatInfo.timeFlag=true
timeList[#timeList+1]=chatInfo.timeStamp
startStamp=chatInfo.timeStamp
end


table.sort(timeList,function(a,b)
return a<b
end)
end
