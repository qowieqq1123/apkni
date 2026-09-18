





UIDropdown=UIObject

function UIDropdown:setChangeAction(action)
self.__owner:setChildDropDownChangeAction(self.__id,action)
end

function UIDropdown:hideList()
self.__owner:setChildDropDownHideList(self.__id)
end

function UIDropdown:showList()
self.__owner:setChildDropDownShowList(self.__id)
end

function UIDropdown:clearOptions()
self.__owner:setChildDropDownClearOption(self.__id)
end

function UIDropdown:getItemText()
return self.__owner:getChildDropDownItemText(self.__id)
end

function UIDropdown:getCaptionText()
return self.__owner:getChildDropDownCaptionText(self.__id)
end

function UIDropdown:getValue()
return self.__owner:getChildDropDownValue(self.__id)
end

function UIDropdown:setItemText(txt)
self.__owner:setChildDropDownItemText(self.__id,txt)
end

function UIDropdown:setCaptionText(txt)
self.__owner:setChildDropDownCaptionText(self.__id,txt)
end


function UIDropdown:setValue(val)
self.__owner:setChildDropDownValue(self.__id,val)
end



function UIDropdown:setOptionsOnLua(array)
self.__owner:setChildDropDownOptionOnLua(self.__id,array)
end


function UIDropdown:setOptionsOnLua(textArray,spriteArray)
self.__owner:setChildDropDownOptionOnLua(self.__id,textArray,spriteArray)
end


function UIDropdown:addOptionOnLua(text,iconname)
self.__owner.winlua:addChildDropDownOptionOnLua(self.__id,text,iconname)
end


function UIDropdown:addOptionOnLua(text,pariteIdx)
self.__owner.winlua:addChildDropDownOptionOnLua(self.__id,text,pariteIdx)
end

function UIDropdown:addOption(text)
self.__owner.winlua:AddChildDropDownOption(self.__id,text)
end

function UIDropdown:setOption(textArray)
self.__owner:setChildDropDownOption(self.__id,textArray)
end