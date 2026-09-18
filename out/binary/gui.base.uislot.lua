UISlot=UIObject


function UISlot:setSlotItem(icon,quality)
self.__owner:setChildSlotItem(self.__id,icon,quality)
end




function UISlot:setSlotItemInfo(icon,countText,color)
self.__owner:setChildSlotItemInfo(self.__id,icon,countText,color)
end



function UISlot:setSlotItemWithCount(icon,count)
self.__owner:setChildSlotItemWithCount(self.__id,icon,count)
end
