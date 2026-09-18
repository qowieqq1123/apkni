







def_class("UILDChatLeftChildItem",UICloneObject)





UILDChatLeftChildItem.abName=""

UILDChatLeftChildItem.assetName="UILDChatLeftChildItem"


function UILDChatLeftChildItem:bindComponents()

self.name=UIText.get(self,0)
self.layout=UIObject.get(self,1)
self.bg=UIObject.get(self,2)
self.mesg=UILinkImageText.get(self,3)

end


function UILDChatLeftChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.mesg);self.mesg=nil;
end









function UILDChatLeftChildItem:onLoaded(...)
self:bindComponents()
end


function UILDChatLeftChildItem:__delete()
self:unbindComponents()
end




function UILDChatLeftChildItem:onShow(argtable,afterOnloaded)
local widget=self.widget
local chatInfo=argtable.chatInfo

local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}

local actorName=actorInfo.actorName or''


if chatInfo.holderId==-100 then
self.name:setText(FMT.fmt('{0}',actorName))
else
local serverId=actorInfo.serverId or''
local serverName=loginModel:getServerName(serverId)
self.name:setText(FMT.fmt('[{0}]{1}',serverName,actorName))
end


self.mesg:setText(FMT.cfmt(FONT_COLOR.eNomalColor,mesg))

self:freshRect()
end


function UILDChatLeftChildItem:onHide()

end



function UILDChatLeftChildItem:freshRect()
local sizeX=self.widget:GetChildPreferredSize(self.mesg:getID(),0)
local max=370
if sizeX>max then sizeX=max end
self.widget:SetChildSizeWithCurrentAnchors(self.mesg:getID(),0,sizeX)
self.widget:ForceLayoutVertical(self.mesg:getID())
local msgY=self.widget:GetChildPreferredSize(self.mesg:getID(),1)
local topY=45
local tSize=topY+msgY+35
self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)
end