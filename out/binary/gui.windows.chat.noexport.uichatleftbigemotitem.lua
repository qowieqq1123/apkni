







def_class("UIChatLeftBigEmotItem",UICloneObject)





UIChatLeftBigEmotItem.abName="ui/windows/chat/child/uichatleftbigemotitem.ab"

UIChatLeftBigEmotItem.assetName="UIChatLeftBigEmotItem"


function UIChatLeftBigEmotItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.descBg=UIObject.get(self,2)
self.head=UIObject.get(self,3)
self.name=UIText.get(self,4)
self.bg=UIObject.get(self,5)
self.emotcon=UIImage.get(self,6)
self.spritePlayer=UIObject.get(self,7)
self.time=UIText.get(self,8)
self.headBg=UIButton.get(self,9)

self.headBg:setButtonClick(function()self:onHeadBg()end)

end


function UIChatLeftBigEmotItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.emotcon);self.emotcon=nil;
_UIObject_release(self.spritePlayer);self.spritePlayer=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.headBg);self.headBg=nil;
end








function UIChatLeftBigEmotItem:onLoaded(...)
self:bindComponents()
end

function UIChatLeftBigEmotItem:__delete()
self:unbindComponents()
end

function UIChatLeftBigEmotItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId

local iconInfo=actorInfo.iconInfo

self:freshRect()

local timeStr=timeHelper.dateServerStamp('[%m-%d %H:%M:%S]',timeStamp)
local packageId,emotid,desc,type=chatEmotHelper.decodeBigEmot(mesg)
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
self.bg:setActive(true)
local isDefineEmot=chatEmotHelper.isDefineEmot(packageId)
if isDefineEmot then
local emotConfig=chatConfig.getDefineEmotConfigById(emotid)
local assetname=emotConfig.assetname
local position=emotConfig.position
local size=emotConfig.size
self.widget:SetChildLocalPos(self.descBg:getID(),position[1],position[2],0)
self.widget:SetChildSizeDelta(self.descBg:getID(),size[1],size[2])
self.desc:setText(desc)
if assetname then
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,false)
else
self.widget:SetChildQualityEffect(self.spritePlayer:getID(),-1)
self.emotcon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
else
self.desc:setText('')
local emotConfig=chatConfig.getBigEmotConfigById(emotid)






local assetname=emotConfig.assetname
if assetname then
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,false)
else
self.widget:SetChildQualityEffect(self.spritePlayer:getID(),-1)
self.emotcon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
end
self.widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)
end

function UIChatLeftBigEmotItem:onHide()

end



function UIChatLeftBigEmotItem:onHeadBg()

end

function UIChatLeftBigEmotItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=150
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end