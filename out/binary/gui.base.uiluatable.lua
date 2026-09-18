UILuaTable=UIObject


function UILuaTable:setLuaTable(luaTable,clearData)
self.__owner:setChildLuaTable(self.__id,luaTable,clearData)
end
