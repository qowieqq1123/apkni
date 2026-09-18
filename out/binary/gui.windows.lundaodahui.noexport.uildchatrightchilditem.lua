







def_class("UILDChatRightChildItem",UICloneObject)





UILDChatRightChildItem.abName=""

UILDChatRightChildItem.assetName="UILDChatRightChildItem"


function UILDChatRightChildItem:bindComponents()

self.name=UIText.get(self,0)
self.layout=UIObject.get(self,1)
self.mesg=UILinkImageText.get(self,2)
self.bg=UIObject.get(self,3)

end


function UILDChatRightChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.mesg);self.mesg=nil;
_UIObject_release(self.bg);self.bg=nil;
end









function UILDChatRightChildItem:onLoaded(...)
self:bindComponents()
end


function UILDChatRightChildItem:__delete()
self:unbindComponents()
end




function UILDChatRightChildItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local mesg=chatInfo.mesg
self.mesg:setText(FMT.cfmt(FONT_COLOR.eNomalColor,mesg))
self.name:setText('[我]')

self:freshRect()
end


function UILDChatRightChildItem:onHide()

end



function UILDChatRightChildItem:freshRect()
self.widget:ForceLayoutVertical(self.mesg:getID())
self.widget:ForceLayoutRect(self.layout:getID())
self.widget:SetLayoutRect(self.mesg:getID(),self.bg:getID(),
15,15,0,0)
local msgY=self.widget:GetChildSizeDeltaY(self.mesg:getID())
local topY=45
local tSize=topY+msgY+35
self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)
end