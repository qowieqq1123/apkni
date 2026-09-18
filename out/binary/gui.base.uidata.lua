UIData=UIObject

function UIData:setDataProp(prop)
self.__owner:setChildDataProp(self.__id,prop)
end



function UIData:setDataPropArray(subIndex,prop)
self.__owner:setChildDataPropArray(self.__id,subIndex,prop)
end
