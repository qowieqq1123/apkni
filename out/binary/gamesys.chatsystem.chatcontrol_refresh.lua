
function chatControl:onAppStart_refresh()
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestServer,self.requestServerNameCallBack)
end

function chatControl:onEnterState_refresh(isReconnet)
self.listenMsgLookup={}
end

function chatControl:onLeaveState_refresh(isReconnet)
self.listenMsgLookup={}
end

function chatControl.requestServerNameCallBack()
local self=chatControl
local refreshType=CHAT_MESG_REFRESH_TYPE.eRefreshServerName
if self.listenMsgLookup[refreshType]==nil then return end
local listT=self.listenMsgLookup[refreshType]
local len=#listT
for i=len,1,-1 do
local args=listT[i]
if chatControl:handleNotifyFunc(args)then
_remove(listT,i)
end
end
end

function chatControl:addNotify_refresh(msgID,params)
if params==nil then return end
local refreshType=params.refreshType
self.listenMsgLookup[refreshType]=self.listenMsgLookup[refreshType]or{}
local list=self.listenMsgLookup[refreshType]
list[#list+1]={msgID,params}
end

function chatControl:handleNotifyFunc(args)
local msgID=args[1]
local params=args[2]
local funcType=params.funcType
local refreshArgs=params.refreshArgs
if funcType==CHAT_MESG_NOTIFY_TYPE.eFilterMesg then
local mesg,ret=chatMesgFilterControl.handleMesg(unpack(refreshArgs))
if ret==nil then
chatControl.setMsgInfoMsg(msgID,mesg)
return true
end
end
return false
end