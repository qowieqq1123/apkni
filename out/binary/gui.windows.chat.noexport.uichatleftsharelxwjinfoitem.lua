







def_class("UIChatLeftShareLXWJInfoItem",UICloneObject)





UIChatLeftShareLXWJInfoItem.abName="ui/windows/chat/child/uichatleftsharelxwjinfoitem.ab"

UIChatLeftShareLXWJInfoItem.assetName="UIChatLeftShareLXWJInfoItem"


function UIChatLeftShareLXWJInfoItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.time=UIText.get(self,1)
self.headBg=UIButton.get(self,2)
self.head=UIObject.get(self,3)
self.name=UIText.get(self,4)
self.bg=UIButton.get(self,5)
self.descTx=UIText.get(self,6)
self.defRate=UIText.get(self,7)
self.atkRate=UIText.get(self,8)
self.wjRate=UIText.get(self,9)
self.bestRate=UIText.get(self,10)
self.symbol=UIObject.get(self,11)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatLeftShareLXWJInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.defRate);self.defRate=nil;
_UIObject_release(self.atkRate);self.atkRate=nil;
_UIObject_release(self.wjRate);self.wjRate=nil;
_UIObject_release(self.bestRate);self.bestRate=nil;
_UIObject_release(self.symbol);self.symbol=nil;
end







function UIChatLeftShareLXWJInfoItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.globa4,'image_zhanji_1')
end


function UIChatLeftShareLXWJInfoItem:__delete()
self:unbindComponents()
end


function UIChatLeftShareLXWJInfoItem:onHide()

end




function UIChatLeftShareLXWJInfoItem:onShow(argtable,afterOnloaded)
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
self:freshRect()

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

local descStr=cfgHelper.getlang('lxwj_tips_2')
self.descTx:setText(descStr)

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
local data
if regexType and regexInfo then
data=chatEmotHelper.getLXWJInfoByRegex(regexInfo)
self.defRate:setText(FMT.fmt('<color=#7d3b17>防守胜率：</color>{0}%',data.def/100))
self.atkRate:setText(FMT.fmt('<color=#7d3b17>进攻胜率：</color>{0}%',data.atk/100))
self.wjRate:setText(FMT.fmt('<color=#7d3b17>问剑胜率：</color>{0}%',data.wj/100))
self.bestRate:setText(FMT.fmt('<color=#7d3b17>全场最佳：</color>{0}次',data.best))
end
end

function UIChatLeftShareLXWJInfoItem:onHeadBg()

end

function UIChatLeftShareLXWJInfoItem:onBg()

end

function UIChatLeftShareLXWJInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=175
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end