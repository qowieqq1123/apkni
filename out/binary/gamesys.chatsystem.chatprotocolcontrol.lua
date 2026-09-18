





chatProtocolControl=gameState.addListener({})
local _guid=0
local _guidCache={}
local _legalCache={}
local _strCache={}
local _callCache={}
local _initLiuYanReddotData=nil


function chatProtocolControl:onAppStart()
socketManager:register_receiver(252,1,self.onSendPublicRet)
socketManager:register_receiver(252,2,self.onSendPrivateRet)
socketManager:register_receiver(252,3,self.onRecvPublicMesg)
socketManager:register_receiver(252,4,self.onRecvPrivateMesg)
socketManager:register_receiver(252,5,self.onRecvSystemMesg)
socketManager:register_receiver(252,16,self.onRecvLastMesg)

socketManager:register_receiver(252,7,self.onRecvLiuYanMesg)
socketManager:register_receiver(252,8,self.onRecvLiuYanReddot)
socketManager:register_receiver(252,9,self.onRecvRemoveLiuYanMesg)

socketManager:register_receiver(252,11,self.onRecvInitEmot)
socketManager:register_receiver(252,12,self.onRecvPackageEmotUnlock)
socketManager:register_receiver(252,13,self.onRecvAddDefineEmot)
socketManager:register_receiver(252,14,self.onRecvDeleteDefineEmot)
socketManager:register_receiver(252,15,self.onRecvTopDefineEmot)

socketManager:register_receiver(254,27,self.onRecvCheckLegalStr)

socketManager:register_receiver(252,17,chatControl.recv_252_17)

socketManager:register_receiver(252,18,self.recv_252_18)

socketManager:register_receiver(252,19,self.recv_252_19)
socketManager:register_receiver(252,20,chatControl.recv_252_20)
end

function chatProtocolControl:onEnterState()

_guid=0
_guidCache={}
_legalCache={}
_strCache={}
_callCache={}
_initLiuYanReddotData=nil
end

function chatProtocolControl:onLeaveState()
_guid=0
_guidCache={}
_legalCache={}
_strCache={}
_callCache={}
_initLiuYanReddotData=nil
end

function chatProtocolControl:onProtocolReq()
if _initLiuYanReddotData then

chatProtocolControl.onRecvLiuYanReddot(_initLiuYanReddotData.listLen,_initLiuYanReddotData.liuyanList)
_initLiuYanReddotData=nil
end
end


function chatProtocolControl.sendPublicMesg(channelId,mesg,sendguid)
socketManager:send_252_1(channelId,mesg,sendguid)
end



function chatProtocolControl.sendPrivateMesg(actorId,mesg,sendguid,recvServerId)

recvServerId=recvServerId or 0
local chatType=0
if recvServerId then
local selfServerId=playerModel:getActorServerID()
chatType=selfServerId==recvServerId and 1 or 2
end

socketManager:send_252_2(actorId,mesg,sendguid,recvServerId,chatType)
end


function chatProtocolControl.sendXianmengCache()
socketManager:send_252_6()
end


function chatProtocolControl.sendLiuYan(actorId)
socketManager:send_252_7(actorId)
end


function chatProtocolControl.sendRemoveLiuYan(actorId)
socketManager:send_252_9(actorId)
end

function chatProtocolControl.sendInitEmot()
socketManager:send_252_11()
end

function chatProtocolControl.sendAddDefineEmot(emotid,desc)
socketManager:send_252_13(emotid,desc)
end

function chatProtocolControl.sendDeleteDefineEmot(array)
if array==nil or#array==0 then return end
socketManager:send_252_14(#array,array)
end

function chatProtocolControl.sendTopDefineEmot(emotguid)
socketManager:send_252_15(emotguid)
end

function chatProtocolControl.sendUnLockItemEmot(tabid,tabidx)
socketManager:send_252_19(tabid,tabidx)
end



function chatProtocolControl.sendCheckLegalStr(str,call,...)
local sendid=_guidCache[str]
if sendid then
local legalStr=_legalCache[sendid]
if legalStr then
if call then
call(str,legalStr,...)
end
return sendid,legalStr
end
end
if sendid==nil then
_guid=_guid+1
sendid=_guid
end
socketManager:send_254_27(sendid,str)
_guidCache[str]=sendid
_strCache[sendid]=str
if _callCache[sendid]==nil then _callCache[sendid]={}end
local callCache=_callCache[sendid]
callCache[#callCache+1]={call,{...}}
return sendid
end



function chatProtocolControl.onSendPublicRet(ret,channelId,sendguid,mesg)
mesg=chatEmotHelper.clearSpecialSymbol(mesg)
chatControl.onSendPublicRet(ret,channelId,sendguid,mesg)
end

function chatProtocolControl.onSendPrivateRet(ret,actorId,sendguid,mesg)
mesg=chatEmotHelper.clearSpecialSymbol(mesg)
chatControl.onSendPrivateRet(ret,actorId,sendguid,mesg)
end

function chatProtocolControl.onRecvPublicMesg(argstable)
chatControl.onRecvPublicMesg(argstable)
end

function chatProtocolControl.onRecvPrivateMesg(argstable)
chatControl.onRecvPrivateMesg(argstable)
end

function chatProtocolControl.onRecvSystemMesg(num,mesg)
local msgFilterType,showPosValue=mathHelper.splitToInt16(num)
chatControl.onRecvSystemMesg(msgFilterType,showPosValue,mesg)
end

function chatProtocolControl.onRecvLastMesg(len,array)
chatControl.onRecvLastMesg(len,array)
end

function chatProtocolControl.onRecvLiuYanMesg(msgLen,msgList)
if msgLen and msgLen>0 then

chatControl.onRecvLiuYanMesg(msgList)

end
end

function chatProtocolControl.onRecvLiuYanReddot(listLen,liuyanList)
if not initProControl.isDone()then

_initLiuYanReddotData={}
_initLiuYanReddotData.listLen=listLen
_initLiuYanReddotData.liuyanList=liuyanList
return
end

if listLen and listLen>0 then
for i,v in ipairs(liuyanList)do
local id=v.param_1
local count=v.param_2
chatModel.setLiuYanReddotListByActorId(id,count)
end
end
end

function chatProtocolControl.onRecvRemoveLiuYanMesg(actorId)
chatControl.readLiuYanMesgByChannel(actorId)
end

function chatProtocolControl.onRecvInitEmot(args)
local len=args[1]
local list=args[2]
local len2=args[3]
local list2=args[4]
local len3=args[5]
local list3=args[6]
chatEmotControl.onInitEmot(len,list,len2,list2,len3,list3)
end

function chatProtocolControl.onRecvPackageEmotUnlock(info)
chatEmotControl.onUnlockPackageEmot(info)
end

function chatProtocolControl.onRecvAddDefineEmot(emotid,desc)
chatEmotControl.onRecvAddDefineEmot(emotid,desc)
end

function chatProtocolControl.onRecvDeleteDefineEmot(len,array)
chatEmotControl.onRecvDeleteDefineEmot(len,array)
end

function chatProtocolControl.onRecvTopDefineEmot(idx)
chatEmotControl.onRecvTopDefineEmot(idx)
end


function chatProtocolControl.onRecvCheckLegalStr(sendid,legalStr,isCache)
if not isCache then
_legalCache[sendid]=legalStr
end
local str=_strCache[sendid]
UIManager:callWindowFunc('UIChatDefineEmotDetailEditorPanel','onCheckLegalStrRet',sendid,legalStr)

if _callCache[sendid]and#_callCache[sendid]>0 then
local callCache=_callCache[sendid]
for _,info in pairs(callCache)do
if info then
local call=info[1]
local args=info[2]
if call then
call(str,legalStr,unpack(args))
end
end
end
end
_callCache[sendid]=nil

end


function chatProtocolControl.recv_252_18(actorId,msg)

if playerModel:checkActorId(actorId)then return end
local isAll=msg==''or msg==nil
if isAll then
chatControl.deletePlayerAllMsg(actorId)
else
chatControl.deletePlayerMsg(actorId,msg)
end
end

function chatProtocolControl.recv_252_19(tabid,tabidx)
chatEmotModel.setItemEmotState(tabid,tabidx)
UIManager:invokeUIMethod("UIChatEmotWin","onRecvUnlockPackage")
UIManager:invokeUIMethod("UIMain","freshChatReddot")
UIManager:showWindow("UIChatEmotUnLockWin",{tabid=tabid,tabidx=tabidx})
UIManager.info("表情解锁成功")
end