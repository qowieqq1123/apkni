UIIcon=UIObject


function UIIcon:setIcon(iconname,native)
self.__owner:setChildIcon(self.__id,iconname,native)
end


function UIIcon:setIconAlpha(alpah)
self.__owner:setChildIconAlpha(self.__id,alpah)
end


function UIIcon:setIconColor(color)
self.__owner:setChildIconColor(self.__id,color)
end


function UIIcon:setIconFillAmount(fillValue)
self.__owner:setChildIconFillAmount(self.__id,fillValue)
end


function UIIcon:setIconSwitchSlot(slot)
self.__owner:setChildIconSwitchSlot(self.__id,slot)
end

function UIIcon:setChildImageDOColor(endValue,duration,onComplete)
return self.__owner:setChildImageDOColor(self.__id,endValue,duration,onComplete)
end