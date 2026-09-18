







def_class("UIFeatureWin",UIWindowBase)









function UIFeatureWin:bindComponents()

self.root=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.des=UIText.get(self,2)



end


function UIFeatureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.des);self.des=nil;
end



















function UIFeatureWin:onLoaded(...)
self:bindComponents()
end


function UIFeatureWin:__delete()
self:unbindComponents()
end




function UIFeatureWin:onShow(argtable,afterOnloaded)
local id=argtable
local cfg=cfgHelper.get1(cfg_xiuzhenfamilycharacteristicconfig_get,id)
local tdStr=id>0 and cfg.desc or'无特点'
self.name:setText(cfg.name)
self.des:setText(tdStr)
end


function UIFeatureWin:onHide()

end




function UIFeatureWin:onClickClose()
self:closeSelf()
end