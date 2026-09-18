UIToggleButton=UIObject

function UIToggleButton:setToggle(toggle)
self.__owner:setChildToggle(self.__id,toggle)
end

function UIToggleButton:getToggle()
return self.__owner:getChildToggle(self.__id)
end


function UIToggleButton:setToggleButton(isSelect)
self.__owner:setChildToggleButton(self.__id,isSelect)
end

function UIToggleButton:setToggleChange(func,data)
self.__owner:setChildToggleChange(self.__id,func,data)
end