





chatMainHolder=simple_class(refObject)

function chatMainHolder.create(mainHoldType)
local object=refObject.get('chatMainHolder',mainHoldType)
return object
end

function chatMainHolder:init(mainHoldType)
local comcfg=chatConfig.getCommonConfig()
local recvchannels=comcfg.recvchannels or{}
local recvchannelCfg=recvchannels[mainHoldType]or{}
local recvChannelsLookup={}
for _,v in ipairs(recvchannelCfg)do
recvChannelsLookup[v]=true
end
self.recvChannelsLookup=recvChannelsLookup
self.cacheNum=webGLHelper:isRunWeiXin()and 5 or comcfg.cacheNum
self.cacheInfoList={}
self.cacheExistLookup={}
self.mainHoldType=mainHoldType

self.handlerLookup={}
end

function chatMainHolder:clearData()
self.cacheExistLookup={}
if self.cacheInfoList then
for _,v in ipairs(self.cacheInfoList)do
refObject.release(v)
end
end
self.cacheInfoList={}
end

function chatMainHolder:onRelease()
self:clearData()
self.recvChannelsLookup={}
self.cacheNum=0
for _,v in pairs(self.handlerLookup)do
refObject.release(v)
end
self.handlerLookup={}
end



function chatMainHolder:onRecvMesg(chatStructInfo)
if chatStructInfo==nil or chatStructInfo.msgID==nil or chatStructInfo.msgID==0 then return end

if self:isReceive(chatStructInfo)and
self:addChatInfo(chatStructInfo)then
self:checkCache()
if chatStructInfo.actorInfo~=nil then
local isBlack=friendModel:isBlack(chatStructInfo.actorInfo.actorId)
if not isBlack then
self:onHandleRecv(chatStructInfo)
end
else
self:onHandleRecv(chatStructInfo)
end
end
end


function chatMainHolder:onRecvMesgList(chatStructInfoList)
if chatStructInfoList==nil then return end

end


function chatMainHolder:isReceive(chatStructInfo)
return self.recvChannelsLookup[chatStructInfo.channelId]==true
end


function chatMainHolder:getCacheList()
self:checkCache()
local cacheList={}
for i,v in ipairs(self.cacheInfoList)do
if v.actorInfo~=nil then
local isBlack=friendModel:isBlack(v.actorInfo.actorId)
if not isBlack then
table.insert(cacheList,v)
end
else
table.insert(cacheList,v)
end
end
return cacheList

end

function chatMainHolder:addHandler(handler)
local guid=handler.guid
if self.handlerLookup[guid]then return end
self.handlerLookup[guid]=handler
end

function chatMainHolder:deleteHandler(handler)
local guid=handler.guid
self.handlerLookup[guid]=nil
end

function chatMainHolder:invokeOneHanderFunc(_handler,func,...)
for _,handler in pairs(self.handlerLookup)do
if _handler.guid==handler.guid and handler[func]then
if handler[func]then
return handler[func](handler,...)
end
end
end
end

function chatMainHolder:invokeHanderFunc(func,...)
for _,handler in pairs(self.handlerLookup)do
if handler[func]then
handler[func](handler,...)
end
end
end

function chatMainHolder:onHandleRecv(chatStructInfo)
for k,v in pairs(self.handlerLookup)do
v:onRecvMesg(chatStructInfo)
end
end

function chatMainHolder:onHandleDelete(msgId)
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsg then
hander:onDeleteMsg(msgId)
end
end
end

function chatMainHolder:onHandleDeleteByIndex(index)
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsgByIndex then
hander:onDeleteMsgByIndex(index)
end
end
end

function chatMainHolder:onHandleDeleteList(msgIdlist)
for k,hander in pairs(self.handlerLookup)do
if hander.onDeleteMsg then
hander:onDeleteMsgList(msgIdlist)
end
end
end

function chatMainHolder:freshCacheMesg(handler)
local cacheList={}
for i,v in ipairs(self.cacheInfoList)do
if v.actorInfo~=nil then
local isBlack=friendModel:isBlack(v.actorInfo.actorId)
if not isBlack then
table.insert(cacheList,v)
end
else
table.insert(cacheList,v)
end
end
if handler then
self:invokeOneHanderFunc(handler,'onHandleMesgList',cacheList)
else
self:invokeHanderFunc('onHandleMesgList',cacheList)
end
end

function chatMainHolder:onDeletePlayerMesg(actorId,msg)
if msg~=nil then
local msgIDArray=self:deleteSinglePlayerChatInfo(actorId,msg)
self:onHandleDeleteList(msgIDArray)
else
local msgIDArray=self:deletePlayerChatInfo(actorId)
self:onHandleDeleteList(msgIDArray)
end
end

function chatMainHolder:addChatInfo(chatInfo)
local msgID=chatInfo.msgID
if self.cacheExistLookup[msgID]then
loggerUtil.logErrFMT('hold已有此消息:{0}',tostring(chatInfo.orgMesg))
return false
end
self.cacheExistLookup[msgID]=true

self.cacheInfoList[#self.cacheInfoList+1]=chatInfo
chatInfo:retain()
return true
end


function chatMainHolder:checkCache()
local cacheInfoList=self.cacheInfoList
if#cacheInfoList<=0 or self.cacheNum==0 then return end
local len=#cacheInfoList
while(len>=self.cacheNum)do
self:deleteDataByIndex(1)
len=#cacheInfoList
end
end


function chatMainHolder:deleteDataByIndex(index)
local chatInfo=self.cacheInfoList[index]
if chatInfo then
local msgID=chatInfo.msgID
self.cacheExistLookup[msgID]=nil

table.remove(self.cacheInfoList,index)
self:onHandleDelete(msgID)
refObject.release(chatInfo)
end
end

function chatMainHolder:deleteSinglePlayerChatInfo(actorId,msg)
local list=self.cacheInfoList
local len=#list
local msgIDArray={}
for i=len,1,-1 do
local chatInfo=list[i]
if chatInfo:isActorId(actorId)and chatInfo.orgMesg==msg then
msgIDArray[#msgIDArray+1]=chatInfo.msgID
table.remove(self.cacheInfoList,i)
refObject.release(chatInfo)
end
end
return msgIDArray
end

function chatMainHolder:deletePlayerChatInfo(actorId)
local list=self.cacheInfoList
local len=#list
local msgIDArray={}
for i=len,1,-1 do
local chatInfo=list[i]
if chatInfo:isActorId(actorId)then
local msgID=chatInfo.msgID
msgIDArray[#msgIDArray+1]=msgID
table.remove(self.cacheInfoList,i)
refObject.release(chatInfo)
end
end
return msgIDArray
end
