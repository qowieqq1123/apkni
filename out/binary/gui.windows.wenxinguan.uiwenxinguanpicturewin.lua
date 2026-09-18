







def_class("UIWenXinGuanPictureWin",UIWindowBase)









function UIWenXinGuanPictureWin:bindComponents()

self.picture=UIImage.get(self,0)
self.pictureText=UIText.get(self,1)
self.Root=UIObject.get(self,2)



end


function UIWenXinGuanPictureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.pictureText);self.pictureText=nil;
_UIObject_release(self.Root);self.Root=nil;
end



















function UIWenXinGuanPictureWin:onLoaded(...)
self:bindComponents()
end


function UIWenXinGuanPictureWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanPictureWin:onShow(argtable,afterOnloaded)
self:refreshPicture(argtable)
end


function UIWenXinGuanPictureWin:onHide()

end

function UIWenXinGuanPictureWin:refreshPicture(argtable)
local text=argtable.text
local iconName="image_chahua_1"
local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"

self.picture:setCSImageSprite(abname,iconName)
self.pictureText:setText(text)

self.picture:setActive(true)
local tweener=self.pictureText:setChildCanvasGroupDOFade(1,2)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanPictureWin:onDoFadePicture()
local cb=function()
self:closeSelf()
end

local tweener=self.Root:setChildCanvasGroupDOFade(0,1,cb)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanPictureWin:closeWindow()
self:closeSelf()
end



