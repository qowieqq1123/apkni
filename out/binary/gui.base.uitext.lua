UIText=UIObject

function UIText:setText(text)
if self.__text==text then
return
end
self.__text=text
self.__owner:setChildText(self.__id,text)
end

