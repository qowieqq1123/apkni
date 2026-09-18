







def_class("UITianMoJieFighPrepareWin",UIWindowBase)









function UITianMoJieFighPrepareWin:bindComponents()

self.root_1=UIObject.get(self,0)
self.root_2=UIObject.get(self,1)
self.root={
self.root_1,
self.root_2,
}



end


function UITianMoJieFighPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root_1);self.root_1=nil;
_UIObject_release(self.root_2);self.root_2=nil;
self.root=nil;
end



















function UITianMoJieFighPrepareWin:onLoaded(...)
self:bindComponents()
end


function UITianMoJieFighPrepareWin:__delete()
self:unbindComponents()
end




function UITianMoJieFighPrepareWin:onShow(argtable,afterOnloaded)
local _self=playerModel:checkActorId(argtable.actor)
self.root_1:setActive(_self)
self.root_2:setActive(not _self)
end


function UITianMoJieFighPrepareWin:onHide()

end



