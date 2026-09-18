







def_class("UINewbieChildFinger",UICloneObject)





UINewbieChildFinger.abName="ui/windows/newbie/child/uinewbiechildfinger.ab"

UINewbieChildFinger.assetName="UINewbieChildFinger"


function UINewbieChildFinger:bindComponents()


end


function UINewbieChildFinger:unbindComponents()
local _UIObject_release=UIObject.release
end








function UINewbieChildFinger:onLoaded(...)
self:bindComponents()
end

function UINewbieChildFinger:__delete()
self:unbindComponents()
end

function UINewbieChildFinger:onShow(argtable,afterOnloaded)

end

function UINewbieChildFinger:onHide()

end


