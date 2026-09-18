UITextMeshProUGUI=UIObject

function UITextMeshProUGUI:setTMProText(str)
if self.__text==str then
return
end
self.__text=str
self.__owner:setChildProText(self.__id,str)
end


function UITextMeshProUGUI:setTMProColor(resColor)
self.__owner:setChildTMProColor(self.__id,resColor)
end