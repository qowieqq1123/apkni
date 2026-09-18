







def_class("UILDChatRightBigEmotItem",UICloneObject)





UILDChatRightBigEmotItem.abName=""

UILDChatRightBigEmotItem.assetName="UILDChatRightBigEmotItem"


function UILDChatRightBigEmotItem:bindComponents()

self.name=UIText.get(self,0)
self.bg=UIObject.get(self,1)
self.emotcon=UIImage.get(self,2)
self.spritePlayer=UIObject.get(self,3)
self.descBg=UIObject.get(self,4)
self.desc=UIText.get(self,5)

end


function UILDChatRightBigEmotItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.emotcon);self.emotcon=nil;
_UIObject_release(self.spritePlayer);self.spritePlayer=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function UILDChatRightBigEmotItem:onLoaded(...)
self:bindComponents()
end


function UILDChatRightBigEmotItem:__delete()
self:unbindComponents()
end




function UILDChatRightBigEmotItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo

local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}
self.widget:SetChildSizeWithCurrentAnchors(-1,1,215)
local packageId,emotid,desc,type=chatEmotHelper.decodeBigEmot(mesg)
if packageId==nil or emotid==nil then
self:recycleSelf()
return
end

self.name:setText('[我]')

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
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,true)
else
self.widget:SetChildQualityEffect(self.spritePlayer:getID(),-1)
self.emotcon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
else
self.desc:setText('')



local emotConfig=chatConfig.getBigEmotConfigById(emotid)
local assetname=emotConfig.assetname
if assetname then
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,true)
else
self.widget:SetChildQualityEffect(self.spritePlayer:getID(),-1)
self.emotcon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
end
end


function UILDChatRightBigEmotItem:onHide()

end


