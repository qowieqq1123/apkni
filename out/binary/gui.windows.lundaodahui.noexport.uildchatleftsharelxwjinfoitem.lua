







def_class("UILDChatLeftShareLXWJInfoItem",UICloneObject)





UILDChatLeftShareLXWJInfoItem.abName=""

UILDChatLeftShareLXWJInfoItem.assetName="UILDChatLeftShareLXWJInfoItem"


function UILDChatLeftShareLXWJInfoItem:bindComponents()

self.name=UIText.get(self,0)
self.bg=UIButton.get(self,1)
self.descTx=UIText.get(self,2)
self.defRate=UIText.get(self,3)
self.atkRate=UIText.get(self,4)
self.wjRate=UIText.get(self,5)
self.bestRate=UIText.get(self,6)

self.bg:setButtonClick(function()self:onBg()end)

end


function UILDChatLeftShareLXWJInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.defRate);self.defRate=nil;
_UIObject_release(self.atkRate);self.atkRate=nil;
_UIObject_release(self.wjRate);self.wjRate=nil;
_UIObject_release(self.bestRate);self.bestRate=nil;
end







function UILDChatLeftShareLXWJInfoItem:onLoaded(...)
self:bindComponents()
end


function UILDChatLeftShareLXWJInfoItem:__delete()
self:unbindComponents()
end


function UILDChatLeftShareLXWJInfoItem:onHide()

end




function UILDChatLeftShareLXWJInfoItem:onShow(argtable,afterOnloaded)
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

if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end

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

function UILDChatLeftShareLXWJInfoItem:onBg()

end

function UILDChatLeftShareLXWJInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local topY=45
local bottomY=190
local size=topY+bottomY
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end