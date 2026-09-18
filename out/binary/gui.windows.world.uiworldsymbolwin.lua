







def_class("UIWorldSymbolWin",UIWindowBase)









function UIWorldSymbolWin:bindComponents()

self.SymbolRoot=UIObject.get(self,0)


self.createFrom_SimpleSymbol=function(...)return self:createFromRectTransformPrefab(0,...);end

end


function UIWorldSymbolWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.SymbolRoot);self.SymbolRoot=nil;
end



















function UIWorldSymbolWin:onLoaded(...)
self:bindComponents()
end


function UIWorldSymbolWin:__delete()
self:unbindComponents()
end




function UIWorldSymbolWin:onShow(argtable,afterOnloaded)

end


function UIWorldSymbolWin:onHide()

end



