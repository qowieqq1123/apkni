UIItem=UIObject

function UIItem:setPointerEvent(callback)
self.__owner:setItemBasePointerEvent(self.__id,callback)
end
