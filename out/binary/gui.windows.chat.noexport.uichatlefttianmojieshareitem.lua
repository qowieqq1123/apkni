







def_class("UIChatLeftTianMoJieShareItem",UICloneObject)





UIChatLeftTianMoJieShareItem.abName=""

UIChatLeftTianMoJieShareItem.assetName="UIChatLeftTianMoJieShareItem"


function UIChatLeftTianMoJieShareItem:bindComponents()

self.bg=UIObject.get(self,0)
self.gotoBtn=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.headBg=UIButton.get(self,3)
self.name=UIText.get(self,4)
self.time=UIText.get(self,5)
self.timeRoot=UIObject.get(self,6)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.headBg:setButtonClick(function()self:onHeadBg()end)

end


function UIChatLeftTianMoJieShareItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
end









function UIChatLeftTianMoJieShareItem:onLoaded(...)
self:bindComponents()
end


function UIChatLeftTianMoJieShareItem:__delete()
self:unbindComponents()
end




function UIChatLeftTianMoJieShareItem:onShow(argtable,afterOnloaded)
local widget=self.widget
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
self.actorInfo=chatInfo.actorInfo or{}
local actorID=self.actorInfo.actorId
local actorName=self.actorInfo.actorName
local actorLevel=self.actorInfo.actorLevel
local serverId=self.actorInfo.serverId
local chatId=self.actorInfo.chatId
local iconInfo=self.actorInfo.iconInfo

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

self:freshRect()
end


function UIChatLeftTianMoJieShareItem:onHide()

end



function UIChatLeftTianMoJieShareItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=200
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftTianMoJieShareItem:onGotoBtn()
local haveLv=zongmenModel:getLevel()
local needLv=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"assistLv")
if haveLv<needLv then
UIManager.info(FMT.fmt("宗门等级不足{0}级，无法协助挑战",needLv))
return
end

local have=tianMoJieModel:getDaily()
local max=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"daily")
if have<max then
tianMoJieModel:setVisitorLocate(self.actorInfo.actorId)
if mainControl:isSceneType(eSceneType.eZongmen)then
visitControl:reqEnterVisitMap(self.actorInfo.serverId,self.actorInfo.actorId)
else
mainControl:enterHome(nil,function()
visitControl:reqEnterVisitMap(self.actorInfo.serverId,self.actorInfo.actorId)
end)
end
UIManager:closeWindow("UIChatWin")
else
UIManager.error("今日已协助挑战天魔，无法继续协助")
end
end