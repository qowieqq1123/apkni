







def_class("UIChatLeftZongMenUnderAttackShareItem",UICloneObject)





UIChatLeftZongMenUnderAttackShareItem.abName=""

UIChatLeftZongMenUnderAttackShareItem.assetName="UIChatLeftZongMenUnderAttackShareItem"


function UIChatLeftZongMenUnderAttackShareItem:bindComponents()

self.bg=UIObject.get(self,0)
self.gotoBtn=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.headBg=UIButton.get(self,3)
self.name=UIText.get(self,4)
self.time=UIText.get(self,5)
self.timeRoot=UIObject.get(self,6)
self.tips=UIText.get(self,7)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.headBg:setButtonClick(function()self:onHeadBg()end)

end


function UIChatLeftZongMenUnderAttackShareItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.tips);self.tips=nil;
end








function UIChatLeftZongMenUnderAttackShareItem:onLoaded(...)
self:bindComponents()
end

function UIChatLeftZongMenUnderAttackShareItem:__delete()
self:unbindComponents()
end

function UIChatLeftZongMenUnderAttackShareItem:onShow(argtable,afterOnloaded)
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

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
if regexType and regexInfo then
self.regexData=chatEmotHelper.getXJQiuYuanInfoByRegex(regexInfo)
end
local tabType=self.regexData and self.regexData.tabType or ATTACKTABTYPE.eXJ
local abname="ui/windows/xianjie/zm_attacker_atlas_pak.ab"
if tabType==ATTACKTABTYPE.eXJ then
self.bg:setCSImageSprite(abname,"image_baoleiyuxi_11")
self.tips:setText("仙界战争")
elseif tabType==ATTACKTABTYPE.eMJ then

self.bg:setCSImageSprite(abname,"image_baoleiyuxi_11")
self.tips:setText("魔界战争")
elseif tabType==ATTACKTABTYPE.eBaoLei then

self.bg:setCSImageSprite(abname,"image_baoleiyuxi_11")
self.tips:setText("魔界战争")
elseif tabType==ATTACKTABTYPE.eMG then

self.bg:setCSImageSprite(abname,"image_baoleiyuxi_11")
self.tips:setText("魔界战事")
end

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

function UIChatLeftZongMenUnderAttackShareItem:onHide()

end



function UIChatLeftZongMenUnderAttackShareItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=200
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftZongMenUnderAttackShareItem:onGotoBtn()
local regexData=self.regexData
local tabType=regexData and regexData.tabType or ATTACKTABTYPE.eXJ
if tabType==ATTACKTABTYPE.eBaoLei then

else
xianjieController:jumpGrid(regexData.sceneidx,regexData.x,regexData.y)
end
end