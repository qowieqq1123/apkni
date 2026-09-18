







def_class("StoryHUD2",UICloneObject)





StoryHUD2.abName="ui/windows/world/hud/storyhud2.ab"

StoryHUD2.assetName="StoryHUD2"


function StoryHUD2:bindComponents()

self.skin=UIImage.get(self,0)
self.Text=UILinkImageText.get(self,1)

end


function StoryHUD2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skin);self.skin=nil;
_UIObject_release(self.Text);self.Text=nil;
end









function StoryHUD2:onLoaded(...)
self:bindComponents()
end


function StoryHUD2:__delete()
self:unbindComponents()
end




function StoryHUD2:onShow(argtable,afterOnloaded)

end


function StoryHUD2:onHide()

end


