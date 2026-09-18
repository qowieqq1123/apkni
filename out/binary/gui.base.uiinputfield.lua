UIInputField=UIObject


function UIInputField:setInputFieldValue(content)
self.__owner:setChildInputFieldValue(self.__id,content)
end



function UIInputField:getInputFieldValue()
return self.__owner:getChildInputFieldValue(self.__id)
end

function UIInputField:setChildInputFieldChange(isClear,func)
self.__owner:setChildInputFieldChange(self.__id,isClear,func)
end

function UIInputField:setInputCharacterLimit(limit)
self.__owner:setChildInputCharacterLimit(self.__id,limit)
end

function UIInputField:getInputCharacterLimit()
self.__owner:getChildInputCharacterLimit(self.__id)
end