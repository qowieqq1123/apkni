







def_class("tipsChildNotJinShou",UICloneObject)





tipsChildNotJinShou.abName="ui/windows/tips/child/tipschildnotjinshou.ab"

tipsChildNotJinShou.assetName="tipsChildNotJinShou"


function tipsChildNotJinShou:bindComponents()

self.Root=UIObject.get(self,0)
self.Text=UIText.get(self,1)

end


function tipsChildNotJinShou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Text);self.Text=nil;
end









function tipsChildNotJinShou:onLoaded(...)
self:bindComponents()
end


function tipsChildNotJinShou:__delete()
self:unbindComponents()
end




function tipsChildNotJinShou:onShow(args)
end


function tipsChildNotJinShou:onHide()

end


