







def_class("UIChatLeftVoiceChildItem",UICloneObject)





UIChatLeftVoiceChildItem.abName="ui/windows/chat/child/uichatleftvoicechilditem.ab"

UIChatLeftVoiceChildItem.assetName="UIChatLeftVoiceChildItem"


function UIChatLeftVoiceChildItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.bottom=UIObject.get(self,1)
self.layout=UIObject.get(self,2)
self.signGrid=UIObject.get(self,3)
self.btnSec=UIText.get(self,4)
self.play=UIImage.get(self,5)
self.headBg=UIButton.get(self,6)
self.head=UIObject.get(self,7)
self.name=UIText.get(self,8)
self.btnVoice=UIButton.get(self,9)
self.time=UIText.get(self,10)
self.bg=UIObject.get(self,11)
self.mesg=UIText.get(self,12)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.btnVoice:setButtonClick(function()self:onBtnVoice()end)

end


function UIChatLeftVoiceChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.signGrid);self.signGrid=nil;
_UIObject_release(self.btnSec);self.btnSec=nil;
_UIObject_release(self.play);self.play=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.btnVoice);self.btnVoice=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.mesg);self.mesg=nil;
end







local _height=44
local _minX=100
local _maxX=350
local _maxMsgSize=355

function UIChatLeftVoiceChildItem:onLoaded(...)
self:bindComponents()
self._onStartPlay=function(...)
self:onStartPlay(...)
end
self._onPlayComplete=function(...)
self:onPlayComplete(...)
end
self:addVoiceNotify()

end

function UIChatLeftVoiceChildItem:__delete()
self:unbindComponents()
self:removeVoiceNotify()
end

function UIChatLeftVoiceChildItem:onShow(argtable,afterOnloaded)
local widget=self.widget
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local chatId=actorInfo.chatId
local iconInfo=actorInfo.iconInfo


local timeFlag=chatInfo.timeFlag or false
self.timeFlag=timeFlag
self.timeRoot:setActive(timeFlag)
if timeFlag then
local txt=''
if timeHelper.isTodayStamp(timeStamp)then
txt=timeHelper.getTwoFormatByStamp(timeStamp)
else
txt=timeHelper.getFourFormatByStamp(timeStamp)
end
self.time:setText(txt)
end

if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end

playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)


local chatBgCfg=cfg_bubbleframeconfig_get(chatId)
self.bg:setImageIcon(iconHelper.getChatKuangIcon(1),false)


local chatFlag=actorInfo.args.chatFlag or{}
local len=#chatFlag
self.signGrid:setChildLayoutGroupCreateItems(len)
local items=self.signGrid:getChildLayoutGroupGridList()
for i=1,len do
local item=items[i-1]
local flag=chatFlag[i]
local isShow=flag>0
item:SetChildActive(-1,isShow)

if isShow then
local flagCfg=cfgHelper.get1(cfg_chatflagconfig_get,chatFlag[i])
item:SetChildActive(1,flagCfg.showType==2)
if flagCfg.showType==1 then
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
item:SetChildIcon(0,icon,false)
end
elseif flagCfg.showType==2 then
item:SetChildText(3,flagCfg.name)
end
end
end


local voiceArgs=chatInfo.voiceArgs
local CKId=voiceArgs.CKId
local sec=voiceArgs.sec
local fileId=voiceArgs.fileId
local txt=voiceArgs.txt
self.CKId=CKId
self.widget:SetChildIcon(self.btnVoice:getID(),iconHelper.getChatKuangIcon(1),false)
self.widget:SetChildSizeDelta(self.btnVoice:getID(),self:getSizeX(sec),_height)
self.btnSec:setText(FMT.fmt('{0}秒',sec))
local isPlay=chatVoiceHelper:isPlayCKId(CKId)
self.play:setActive(isPlay)
local supportSpeech=chatVoiceHelper:isSupportSpeech()
self.bottom:setActive(supportSpeech)

if supportSpeech then
self.mesg:setText(txt)
self.bg:setActive(txt~='')
self.showTxt=txt~=''
else
self.mesg:setText('')
self.bg:setActive(false)
self.showTxt=false
end

self.widget:ForceLayoutVertical(-1)
local sizeX=self.widget:GetChildPreferredSize(self.mesg:getID(),0)
if sizeX>_maxMsgSize then sizeX=_maxMsgSize end
self.widget:SetChildSizeWithCurrentAnchors(self.mesg:getID(),0,sizeX)
self:freshRect()
end

function UIChatLeftVoiceChildItem:onHide()

end




function UIChatLeftVoiceChildItem:addVoiceNotify()
if self.addVoiceFlag then return end
self.addVoiceFlag=true
chatVoiceHelper:registerPlayStartAction(self._onStartPlay,true)
chatVoiceHelper:registerPlayCompleteAction(self._onPlayComplete,true)
end

function UIChatLeftVoiceChildItem:removeVoiceNotify()
if not self.addVoiceFlag then return end
self.addVoiceFlag=nil
chatVoiceHelper:registerPlayStartAction(self._onStartPlay,false)
chatVoiceHelper:registerPlayCompleteAction(self._onPlayComplete,false)
end

function UIChatLeftVoiceChildItem:onStartPlay(CKId)
if self.CKId~=CKId then return end
self.play:setActive(true)
end

function UIChatLeftVoiceChildItem:onPlayComplete(CKId)
if self.CKId~=CKId then return end
self.play:setActive(false)
end

function UIChatLeftVoiceChildItem:onHeadBg()

end

function UIChatLeftVoiceChildItem:onBtnVoice()
if not chatVoiceHelper:checkAPI()then
UIManager.error('当前版本不支持此功能')
return
end
chatVoiceHelper:startPlay(self.CKId)
end

function UIChatLeftVoiceChildItem:getSizeX(sec)
local x=sec*10+_minX
if x>=_maxX then x=_maxX end
return x
end

function UIChatLeftVoiceChildItem:freshRect()
local sizeY=0
if chatVoiceHelper:isSupportSpeech()then
self.widget:ForceLayoutVertical(self.mesg:getID())
sizeY=self.widget:GetChildPreferredSize(self.mesg:getID(),1)
end
if not self.showTxt then sizeY=0 end
local topSpace=10
local timeY=self.timeFlag and 35 or 0
local topY=100
local bottomSpace=30
local size=topSpace+timeY+topY+sizeY+bottomSpace
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
