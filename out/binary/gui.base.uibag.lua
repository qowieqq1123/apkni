UIBag=UIObject

function UIBag:setBagScrollView(propArray)
self.__owner:setChildBagScrollView_InitSlotArray(self.__id,propArray)
end



function UIBag:setBagScrollView(cellindex,prop)
self.__owner:setChildBagScrollView_RefreshSlot(self.__id,cellindex,prop)
end


function UIBag:setBagScrollView(propArray)
self.__owner:setChildBagScrollView_RefreshSlotArray(self.__id,propArray)
end
