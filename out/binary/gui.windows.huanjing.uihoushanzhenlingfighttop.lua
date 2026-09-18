







def_class("UIHouShanZhenLingFightTop",UIWindowBase)









function UIHouShanZhenLingFightTop:bindComponents()

self.layer=UIObject.get(self,0)
self.layerText=UIText.get(self,1)


self.sprite_button_zdjiasu_1=0
self.sprite_button_zdjiasu_2=1
self.sprite_button_zdjiasu_3=2

end


function UIHouShanZhenLingFightTop:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.layerText);self.layerText=nil;
end



















function UIHouShanZhenLingFightTop:onLoaded(...)
self:bindComponents()
end


function UIHouShanZhenLingFightTop:__delete()
self:unbindComponents()
end




function UIHouShanZhenLingFightTop:onShow(argtable,afterOnloaded)
self.info=argtable
self:flushLayerInfo(self.info)
end


function UIHouShanZhenLingFightTop:onHide()

end

function UIHouShanZhenLingFightTop:flushLayerInfo(info)
self.layer:setActive(true)
local tname=string.gsub(info,"%b()","")
self.layerText:setText(tname)
end



