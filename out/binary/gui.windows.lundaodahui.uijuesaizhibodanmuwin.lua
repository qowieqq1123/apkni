







def_class("UIJueSaiZhiBoDanMuWin",UIWindowBase)









function UIJueSaiZhiBoDanMuWin:bindComponents()

self.danmuRoot=UIObject.get(self,0)



end


function UIJueSaiZhiBoDanMuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.danmuRoot);self.danmuRoot=nil;
end



















local YList={-15,40}


function UIJueSaiZhiBoDanMuWin:onLoaded(...)
self:bindComponents()
self.danMuQueue=queue.New()
self.YListIndex={1,2}
self.channelId=CHAT_CHANNNEL.eKuafu
end


function UIJueSaiZhiBoDanMuWin:__delete()
self:unbindComponents()
self:unregChatHandle()
end




function UIJueSaiZhiBoDanMuWin:onShow(argtable,afterOnloaded)
self:regChatHandle()
end


function UIJueSaiZhiBoDanMuWin:onHide()
self:unregChatHandle()
end




function UIJueSaiZhiBoDanMuWin:regChatHandle()
local handler=self.handler
if handler then return end

local channelId=self.channelId

handler=chatMessageHandler.create(channelId,self)

self.handler=handler
chatControl.addHandler(channelId,handler)
end

function UIJueSaiZhiBoDanMuWin:unregChatHandle()
local handler=self.handler
if not handler then return end
local channelId=self.channelId
self.handle=nil
chatControl.deleteHandler(channelId,handler)
end

function UIJueSaiZhiBoDanMuWin:chatRegex(mesg)
return string.find(mesg,chatConfig.chatRegex)~=nil
end

function UIJueSaiZhiBoDanMuWin:shareQieCuoInfo(mesg)
return string.find(mesg,chatConfig.shareQieCuoInfo)~=nil
end

function UIJueSaiZhiBoDanMuWin:shareDiscipleInfo(mesg)
return(string.find(mesg,chatConfig.shareDiscipleInfo)or
string.find(mesg,chatConfig.shareDiscipleInfoFormat))~=nil
end

function UIJueSaiZhiBoDanMuWin:voiceRegex(mesg)
return(string.find(mesg,chatConfig.voiceRegex)or
string.find(mesg,chatConfig.voiceString))~=nil
end

function UIJueSaiZhiBoDanMuWin:linkRegex(mesg)
return(string.find(mesg,chatConfig.linkRegex)or
string.find(mesg,chatConfig.linkRegexFormat)or
string.find(mesg,chatConfig.linkRegexFormatEx))~=nil
end

function UIJueSaiZhiBoDanMuWin:actRegex(mesg)
return string.find(mesg,chatConfig.actRegex)~=nil
end


function UIJueSaiZhiBoDanMuWin:onRecvPublicMessage(channelId,chatInfo)
local isBigEmoji=chatEmotHelper.containsBigEmot(chatInfo.mesg)
local isVoiceRegex=self:voiceRegex(chatInfo.mesg)
local isLinkRegex=self:linkRegex(chatInfo.mesg)
local isActRegex=self:actRegex(chatInfo.mesg)
local isChatRegex=self:chatRegex(chatInfo.mesg)
local isShareQieCuoInfo=self:shareQieCuoInfo(chatInfo.mesg)
local isShareDiscipleInfo=self:shareDiscipleInfo(chatInfo.mesg)


if isBigEmoji or isActRegex or isLinkRegex or isVoiceRegex or isChatRegex or isShareQieCuoInfo or isShareDiscipleInfo then return end

local actorId=playerModel:getActorID()
if chatInfo.actorInfo then
local name=chatInfo.actorInfo.actorName
local serverId=string.format("[%s服]",chatInfo.actorInfo.serverId)

if actorId==chatInfo.actorInfo.actorId then
name="我"
serverId=""
end

local mesg=FMT.fmt("<color=#ffe699>{2}{0}</color>: {1}",
name,chatInfo.mesg,serverId)

self:delayDo(2,function()
self:onRecvMesg(mesg)
end)
end
end

function UIJueSaiZhiBoDanMuWin:onRecvMesg(mesg)
local danMu=self.danMuQueue:dequeue()
if not danMu then
self.danmuItemNum=self.danmuItemNum or 0
if self.danmuItemNum<2 then
self.danmuRoot:setChildLayoutGroupAddItem()
self.danmuItemNum=self.danmuItemNum+1
danMu=self.danmuRoot:getChildLayoutGroupGridItem(self.danmuItemNum-1)
end
end
if danMu then
local randomYIndex=math.random(1,#self.YListIndex)
local YIndex=self.YListIndex[randomYIndex]
table.remove(self.YListIndex,randomYIndex)

local x=0
danMu:SetChildCanvasGroupAlpha(-1,1)
danMu:SetChildLocalPosition(-1,Vector3(x,YList[YIndex],0))

local value=8










local timer
local distance=1600
timer=self:setTimer(0,0,function()
local curAcc=Time.timeScale
local timerId=timer
local index=YIndex
local x=danMu:GetChildLocalPosition(-1)
local changeDistance=distance*Time.deltaTime/value/curAcc
x.x=x.x-changeDistance
if x.x<=-distance then
self:clearTimerById(danMu,index,timerId)
end

danMu:SetChildLocalPosition(-1,x)
end)
danMu:SetChildText(0,mesg)
else
self:delayDo(8,function()
self:onRecvMesg(mesg)
end)
end
end

function UIJueSaiZhiBoDanMuWin:clearTimerById(danMu,YIndex,timerId)
danMu:SetChildCanvasGroupAlpha(-1,0)
self.danMuQueue:enqueue(danMu)
table.insert(self.YListIndex,YIndex)
self:stopTimerByID(timerId)
end