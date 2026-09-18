





UIBaseItem=UIObject

function UIBaseItem:setBaseItemChildID(id)
self.__owner.widget:SetBaseItemChildID(self.__id,id)
end

function UIBaseItem:setBaseItemChildGUID(guid)
self.__owner.widget:SetBaseItemChildGUID(self.__id,guid)
end

function UIBaseItem:setBaseItemChildAttach(attach)
self.__owner.widget:SetBaseItemChildAttach(self.__id,attach)
end

function UIBaseItem:setBaseItemClickEvent(action)
self.__owner.widget:SetBaseItemClickEvent(self.__id,action)
end

function UIBaseItem:setBaseItemLongTouchEvent(action)
self.__owner.widget:SetBaseItemLongTouchEvent(self.__id,action)
end

function UIBaseItem:getChildCSGUIBaseItem(idx)
return self.__owner.widget:GetChildCSGUIBaseItem(self.__id,idx)
end

function UIBaseItem:setChildPropData(prop)
return self.__owner.widget:SetChildPropData(self.__id,prop)
end

function UIBaseItem:setChildItemData(key,value)
return self.__owner.widget:SetChildItemData(self.__id,key,value)
end


function UIBaseItem:setChildItemDataByDataPropKey(dataPropKey,compIdx,value)
local key=PropIndex(dataPropKey,compIdx)
return self.__owner.widget:SetChildItemData(self.__id,key,value)
end

function UIBaseItem:setBaseItemChildIndex(index)
return self.__owner.widget:SetBaseItemChildIndex(self.__id,index)
end

function UIBaseItem:setBtnAction(index,action)
return self.__owner.widget:SetChildButtonClick(self.__id,index,action,true)
end