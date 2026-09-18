







def_class("UIChatMainVoiceItem",UICloneObject)





UIChatMainVoiceItem.abName="ui/windows/main/child/uichatmainvoiceitem.ab"

UIChatMainVoiceItem.assetName="UIChatMainVoiceItem"


function UIChatMainVoiceItem:bindComponents()

self.UIChatMainVoiceItem=UIObject.get(self,0)
self.bg1=UIObject.get(self,1)
self.bg2=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.btnVoice=UIButton.get(self,4)
self.btnSec=UIText.get(self,5)
self.play=UIImage.get(self,6)

self.btnVoice:setButtonClick(function()self:onBtnVoice()end)

end


function UIChatMainVoiceItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UIChatMainVoiceItem);self.UIChatMainVoiceItem=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.btnVoice);self.btnVoice=nil;
_UIObject_release(self.btnSec);self.btnSec=nil;
_UIObject_release(self.play);self.play=nil;
end







local _height=44
local _minX=100
local _maxX=350

function UIChatMainVoiceItem:onLoaded(...)
self:bindComponents()
CS.BindWidget(self.widget,self)
self:setChildCanvasGroupAlpha(self.UIChatMainVoiceItem:getID(),0)
self._onStartPlay=function(...)
self:onStartPlay(...)
end
self._onPlayComplete=function(...)
self:onPlayComplete(...)
end
self:addVoiceNotify()
end

function UIChatMainVoiceItem:__delete()
self:unbindComponents()
self:removeVoiceNotify()
self.isPlayAni=nil
end

function UIChatMainVoiceItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local isVoice=chatInfo.isVoice
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local isSelf=chatInfo:isSelfActor()
local channelName=CHAT_CHANNNEL_NAME[channelId]
local name=not isSelf and FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}] ',actorName)or
FMT.cfmt(FONT_COLOR.eGreenColor,'[我] ')
self.channelId=channelId

self.name:setText(name)
self.bg1:setActive(not isSelf)
self.bg2:setActive(isSelf)


local voiceArgs=chatInfo.voiceArgs
local CKId=voiceArgs.CKId
local sec=voiceArgs.sec
local fileId=voiceArgs.fileId
self.CKId=CKId
self.widget:SetChildSizeDelta(self.btnVoice:getID(),self:getSizeX(sec),_height)
self.btnSec:setText(FMT.fmt('{0}秒',sec))

local isPlay=chatVoiceHelper:isPlayCKId(CKId)
self.play:setActive(isPlay)
end

function UIChatMainVoiceItem:onHide()

end



function UIChatMainVoiceItem:clickBg()
local _channelId=self.channelId
UIManager:showWindow('UIChatWin')
end

function UIChatMainVoiceItem:onBtnVoice()
if not chatVoiceHelper:checkAPI()then return false end
chatVoiceHelper:startPlay(self.CKId)
end

function UIChatMainVoiceItem:playAni()
self:setChildCanvasGroupAlpha(self.UIChatMainVoiceItem:getID(),1)
self:setChildAnimatorInteger(self.UIChatMainVoiceItem:getID(),'int',self.isPlayAni and 2 or 1,true)
self.isPlayAni=true
end

function UIChatMainVoiceItem:addVoiceNotify()
if self.addVoiceFlag then return end
self.addVoiceFlag=true
chatVoiceHelper:registerPlayStartAction(self._onStartPlay,true)
chatVoiceHelper:registerPlayCompleteAction(self._onPlayComplete,true)
end

function UIChatMainVoiceItem:removeVoiceNotify()
if not self.addVoiceFlag then return end
self.addVoiceFlag=nil
chatVoiceHelper:registerPlayStartAction(self._onStartPlay,false)
chatVoiceHelper:registerPlayCompleteAction(self._onPlayComplete,false)
end

function UIChatMainVoiceItem:onStartPlay(CKId)
if self.CKId~=CKId then return end
self.play:setActive(true)
end

function UIChatMainVoiceItem:onPlayComplete(CKId)
if self.CKId~=CKId then return end
self.play:setActive(false)
end

function UIChatMainVoiceItem:getSizeX(sec)
local x=sec*10+_minX
if x>=_maxX then x=_maxX end
return x
end