





chatSystemHandler=simple_class(chatSimpleHandler)


function chatSystemHandler.create()
local object=refObject.get('chatSystemHandler')
object:initChild()
return object
end

function chatSystemHandler:init()
self.mesgType=CHAT_MESSAGE_TYPE.eSystem
self.channelId=CHAT_CHANNNEL.eNone
end

function chatSystemHandler:onRelease()
self.mesgType=CHAT_MESSAGE_TYPE.eNone
self.channelId=CHAT_CHANNNEL.eNone
end


function chatSystemHandler:onRecvMesg(chatSystemInfo)
if chatSystemInfo.msgType~=CHAT_MESSAGE_TYPE.eSystem then return end
if chatSystemInfo.isVoice or chatEmotHelper.containsBigEmot(chatSystemInfo.mesg)then return end
local mesg=chatLinkHelper.clearLink(chatSystemInfo.mesg)
local showPos=chatSystemInfo.channelId
if showPos==nil then return end
if mathHelper.getBitValue(showPos,CHAT_SYSYTEM_POS.eTopHourse)then
UIManager.topHourceLamp(FMT.cfmt(FONT_COLOR.eNomalBlackColor,mesg))
end
if mathHelper.getBitValue(showPos,CHAT_SYSYTEM_POS.eMidHourse)then
UIManager.midHourceLamp(FMT.cfmt(FONT_COLOR.eNomalBlackColor,mesg))
end
end