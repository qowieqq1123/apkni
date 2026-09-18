







def_class("UIDuJieXianDanFinishWin",UIWindowBase)









function UIDuJieXianDanFinishWin:bindComponents()

self.dan=UIObject.get(self,0)
self.danwenRoot=UIObject.get(self,1)
self.img=UIObject.get(self,2)
self.liandanRoot=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.Text=UIText.get(self,5)
self.wenText=UIObject.get(self,6)



end


function UIDuJieXianDanFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dan);self.dan=nil;
_UIObject_release(self.danwenRoot);self.danwenRoot=nil;
_UIObject_release(self.img);self.img=nil;
_UIObject_release(self.liandanRoot);self.liandanRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.wenText);self.wenText=nil;
end



















function UIDuJieXianDanFinishWin:onLoaded(...)
self:bindComponents()
end


function UIDuJieXianDanFinishWin:__delete()
self:unbindComponents()
end




function UIDuJieXianDanFinishWin:onShow(argtable,afterOnloaded)
if argtable then
self.closeCall=argtable.closeCall

if argtable.jieduan then
local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,argtable.jieduan)
self.dan:setChildShowEffect(jdConfig.jdEffect,true)
else
local effectid=cfgHelper.get(cfg_dujietreasuresbasicconfig_get,1,"jdEffect")
self.dan:setChildShowEffect(effectid,true)
end

if argtable.hideImg then
self.img:setActive(false)
end
if argtable.mainText then
self.Text:setText(argtable.mainText)
end
end
end


function UIDuJieXianDanFinishWin:onHide()

end

function UIDuJieXianDanFinishWin:onCloseBtn()
if self.closeCall then
self.closeCall()
end
self:closeSelf()
end


