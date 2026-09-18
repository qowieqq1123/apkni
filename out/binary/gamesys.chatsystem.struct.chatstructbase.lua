





chatStructBase=simple_class(refObject)

local _newGUID=0

function chatStructBase.create(msgType,mesg)
local object=refObject.get('chatStructBase',msgType,mesg)
return object
end

function chatStructBase:init(isTop,stamp,msgType,mesg,decode,args)
if decode==nil then decode=true end
self.msgType=msgType

self.args=args
mesg=mesg or''

self.orgMesg=mesg
if decode then
mesg=chatEmotHelper.decodeChatEmot(mesg)
end
self.mesg=mesg

self.isTop=isTop or false

_newGUID=_newGUID+1
self.msgID=_newGUID

local timeStamp=stamp or timeHelper.getServerLongTime()
if timeStamp==0 then
loggerUtil.logErrFMT('服务器尚未下发时间协议')
end
self.timeStamp=timeStamp

local CKId,fileId,sec,speechTxt=chatVoiceHelper:matchVoice(mesg)
self.isVoice=CKId~=nil
if self.isVoice then
chatVoiceHelper:addKeyValue(CKId,fileId)
self.voiceArgs={CKId=CKId,fileId=fileId,sec=sec,txt=speechTxt}
end

local actMatch,actArgs=chatActivityHelper:matchActivity(mesg,self.actorInfo)
if actMatch==true then
if actArgs~=nil then
self.actArgs=actArgs
else
self.mesg="错误的活动聊天信息"
end
elseif actMatch==false then
self.mesg="错误的活动聊天信息"
end

self.regexInfo=chatCommonHelper:matchChatRegex(mesg)
local regexType=self.regexInfo and self.regexInfo[1][1]or nil
if regexType then
self.regexType=tonumber(regexType)
end

self.lost=chatControl.checkRegexInfoLost(self.regexType,self.regexInfo,self.actorInfo)
end

function chatStructBase:isSelfActor()
return false
end

function chatStructBase:onRelease()
self.msgType=CHAT_MESSAGE_TYPE.eNone
self.msgID=0
self.mesg=''
self.orgMesg=''
self.timeStamp=0
self.isVoice=nil
self.actArgs=nil
self.args=nil
self.timeFlag=nil
self.voiceArgs=nil
self.regexInfo=nil
self.regexType=nil
self.lost=nil
end



