UIEnhancedScrollerLua=UIObject

function UIEnhancedScrollerLua:getCSharpObject()
return self.__owner:getChildEnhanceScrollerLua(self.__id)
end
