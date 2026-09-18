







def_class("UIDiscipleListConditionComponent",UIWindowBase)









function UIDiscipleListConditionComponent:bindComponents()

self.root=UIObject.get(self,0)
self.discipleList=UIScrollView.get(self,1)



end


function UIDiscipleListConditionComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
end



















function UIDiscipleListConditionComponent:onLoaded(...)
self:bindComponents()
end


function UIDiscipleListConditionComponent:__delete()
self:unbindComponents()
end




function UIDiscipleListConditionComponent:onShow(argtable,afterOnloaded)

end


function UIDiscipleListConditionComponent:onHide()

end



