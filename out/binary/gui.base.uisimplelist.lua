UISimpleList=UIObject


function UISimpleList:setSimpleList(Count,isClear)
self.__owner:setChildSimpleList(self.__id,Count,isClear)
end



function UISimpleList:setSimpleListAndWinlua(Count,winlua)
self.__owner:setChildSimpleListAndWinlua(self.__id,Count,winlua)
end


function UISimpleList:setRefreshList(index1)
self.__owner:setChildRefreshList(self.__id,index1)
end
