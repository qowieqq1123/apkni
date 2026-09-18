







def_class("UIShiLianTaFightTop",UIWindowBase)









function UIShiLianTaFightTop:bindComponents()

self.layer=UIObject.get(self,0)
self.layerText=UIText.get(self,1)


self.sprite_button_zdjiasu_1=0
self.sprite_button_zdjiasu_2=1
self.sprite_button_zdjiasu_3=2

end


function UIShiLianTaFightTop:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.layerText);self.layerText=nil;
end



















function UIShiLianTaFightTop:onLoaded(...)
self:bindComponents()
end


function UIShiLianTaFightTop:__delete()
self:unbindComponents()
end




function UIShiLianTaFightTop:onShow(argtable,afterOnloaded)
if argtable then
self.showLayer=argtable
end
self:flushLayerInfo(self.showLayer)
end


function UIShiLianTaFightTop:onHide()

end

function UIShiLianTaFightTop:flushLayerInfo(showLayer)
local layer=showLayer or shiLianTaModel:getFightingLayer()
if layer then
self.layer:setActive(true)
self.layerText:setText(FMT.fmt("第{0}层",layer))
end
end



