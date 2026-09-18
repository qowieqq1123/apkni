







def_class("UIChatPackageEmotInfoPanel",UIWindowBase)









function UIChatPackageEmotInfoPanel:bindComponents()

self.root=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.spritePlayer=UIObject.get(self,2)



end


function UIChatPackageEmotInfoPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.spritePlayer);self.spritePlayer=nil;
end


















function UIChatPackageEmotInfoPanel:onLoaded(...)
self:bindComponents()
end

function UIChatPackageEmotInfoPanel:__delete()
self:unbindComponents()
end

function UIChatPackageEmotInfoPanel:onShow(argtable,afterOnloaded)
local emotid=argtable[1]
local posx=argtable[2]
local posy=argtable[3]


local emotConfig=chatConfig.getBigEmotConfigById(emotid)
local assetname=emotConfig.assetname
if assetname then
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,true)
else
self.icon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
self.root:setChildUIScreenPosWithOffset(posx,posy,75,5)
end

function UIChatPackageEmotInfoPanel:onHide()

end



