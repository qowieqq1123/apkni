local _cacheHolderLookup={}
local _cacheMainHolderLookup={}
local _selectHandler=nil

MAIN_HOLD_TYPE=
{
eMain=1,
eBattleField=2,
}

function chatControl:onEnterState_handle(isReconnet)
_selectHandler=nil
chatControl:initHandler(isReconnet)
end

function chatControl:onLeaveState_handle(isReconnet)
_selectHandler=nil
chatControl:clearHandler(isReconnet)
end



function chatControl:initHandler(isReconnet)
if isReconnet then
for channelId,holder in pairs(_cacheHolderLookup)do
holder:clearData()
end

for _,holder in ipairs(_cacheMainHolderLookup)do
holder:clearData()
end
else
_cacheHolderLookup={}

local configs=chatConfig.getAllChannelConfig()
for channelId,v in pairs(configs)do
local holder=chatHolder.create(channelId)
chatControl.addHolder(channelId,holder)
end


self.systemHandler=chatSystemHandler.create()


local type=MAIN_HOLD_TYPE.eMain
local holder=chatMainHolder.create(type)
_cacheMainHolderLookup[type]=holder


local type=MAIN_HOLD_TYPE.eBattleField
local holder=chatMainHolder.create(type)
_cacheMainHolderLookup[type]=holder


eventTextNotifyControl.register(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziProduct,
EVENT_NORMAL_SUB_TYPE.eDiziYouli,
EVENT_NORMAL_SUB_TYPE.eDiziXiulian,
EVENT_NORMAL_SUB_TYPE.eDiziRelation,
EVENT_NORMAL_SUB_TYPE.eEmergencies,
EVENT_NORMAL_SUB_TYPE.eChuWuDai,
},
chatControl.onRecvEventJianWenMesg)
end
end

function chatControl:clearHandler(isReconnet)
if isReconnet then return end
eventTextNotifyControl.unregister(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziProduct,
EVENT_NORMAL_SUB_TYPE.eDiziYouli,
EVENT_NORMAL_SUB_TYPE.eDiziXiulian,
EVENT_NORMAL_SUB_TYPE.eDiziRelation,
EVENT_NORMAL_SUB_TYPE.eEmergencies,
EVENT_NORMAL_SUB_TYPE.eChuWuDai,
},
chatControl.onRecvEventJianWenMesg)

for channelId,holder in pairs(_cacheHolderLookup)do
refObject.release(holder,true)
end
_cacheHolderLookup={}

refObject.release(self.systemHandler,true)

for _,holder in pairs(_cacheMainHolderLookup)do
refObject.release(holder,true)
end
_cacheMainHolderLookup={}

self.systemHandler=nil
end

function chatControl.addHolder(channelId,holder)
if _cacheHolderLookup[channelId]then
loggerUtil.logErrFMT('频道{0}已有cacheHolder',channelId)
end
_cacheHolderLookup[channelId]=holder
end


function chatControl.selectHandler(handler)
_selectHandler=handler
end


function chatControl.invokeSelectHandlerFunc(func,...)
if _selectHandler and _selectHandler[func]then
_selectHandler[func](_selectHandler,...)
end
end

function chatControl.getAllMainHolder()
return _cacheMainHolderLookup
end

function chatControl.getMainHolder(mainHolderType)
return _cacheMainHolderLookup[mainHolderType]
end

function chatControl.registerMainHandler(mainHolderType,handler)
local holder=chatControl.getMainHolder(mainHolderType)
if holder then
holder:addHandler(handler)
end
end

function chatControl.unregisterMainHandler(mainHolderType,handler)
local holder=chatControl.getMainHolder(mainHolderType)
if holder then
holder:deleteHandler(handler)
end
end

function chatControl.onHandleRecvMesg(chatInfo)
for _,holder in pairs(_cacheHolderLookup)do
holder:onRecvMesg(chatInfo)
end
end

function chatControl.onHandleMainRecvMesg(chatInfo)
for _,holder in pairs(_cacheMainHolderLookup)do
holder:onRecvMesg(chatInfo)
end
end


function chatControl.onHandleSystemRecvMesg(chatSystemInfo)
chatControl.systemHandler:onRecvMesg(chatSystemInfo)
end

function chatControl.onHandleRecvMesgList(chatInfoList)
local channelId=chatInfoList.channelId
if channelId==nil then
loggerUtil.logErrFMT('使用列表处理数据，必须传入数据channelId')
return
end
chatControl.invokeHolder(channelId,'onRecvMesgList',chatInfoList)
end

function chatControl.onHandleMainRecvMesgList(chatInfoList)
for _,holder in pairs(_cacheMainHolderLookup)do
holder:onRecvMesgList(chatInfoList)
end
end

function chatControl.onHandleSystemRecvMesgList(chatSystemInfo)
chatControl.systemHandler:onRecvMesgList(chatSystemInfo)
end

function chatControl.onHandleDeleteMesgByIndex(channelId,index)
chatControl.invokeHolder(channelId,'onHandleDeleteByIndex',index)
end

function chatControl.onHandleDeleteMesg(channelId,msgID)
chatControl.invokeHolder(channelId,'onHandleDelete',msgID)
end

function chatControl.getHolder(channelId)
return _cacheHolderLookup[channelId]
end

function chatControl.getAllHolder()
return _cacheHolderLookup
end

function chatControl.invokeHolder(channelId,funcname,...)
local holder=chatControl.getHolder(channelId)
if holder and holder[funcname]then
return holder[funcname](holder,...)
end
end

function chatControl.onInvokeAllMainHolder(funcName,...)
for _,holder in pairs(_cacheMainHolderLookup)do
if holder[funcName]then
holder[funcName](holder,...)
end
end
end

function chatControl.onInvokeMainHolder(mainHolderType,funcName,...)
local holder=chatControl.getMainHolder(mainHolderType)
if holder and holder[funcName]then
return holder[funcName](holder,...)
end
end

function chatControl.onInvokeSystemHander(funcName,...)
if chatControl.systemHandler and chatControl.systemHandler[funcName]then
local handlder=chatControl.systemHandler
return handlder[funcName](handlder,...)
end
end


function chatControl.addHandler(channelId,handle)
chatControl.invokeHolder(channelId,'addHandler',handle)
end


function chatControl.deleteHandler(channelId,handle)
chatControl.invokeHolder(channelId,'deleteHandler',handle)
end

function chatControl.getHandlers(channelId)
return chatControl.invokeHolder(channelId,'getHandlers')
end

function chatControl.freshMainMesgPanel(mainHolderType,handler)
local holder=chatControl.getMainHolder(mainHolderType)
if holder and holder.freshCacheMesg then
holder:freshCacheMesg(handler)
end
end












function chatControl.registerHandler(handler)





end

function chatControl.unregisterHandler(handler)




end

function chatControl.onHandleTestRecvMesg(index,chatInfo)
for _,holder in pairs(_cacheHolderLookup)do
holder:insertPublic(chatInfo,index)
holder:invokeHanderFunc('onTestRecvMesg',index,chatInfo)
end
end
