UIStar=UIObject


function UIStar:setInitStarLabel(totalNum,starNum)
self.__owner:setChildInitStarLabel(self.__id,totalNum,starNum)
end



function UIStar:setSingleGroundStar(starNum,otherfalse)
self.__owner:setChildSingleGroundStar(self.__id,starNum,otherfalse)
end



function UIStar:setSingleStar(starNum,otherfalse)
self.__owner:setChildSingleStar(self.__id,starNum,otherfalse)
end


function UIStar:setStarLabel(starNum)
self.__owner:setChildStarLabel(self.__id,starNum)
end



function UIStar:setStarLabelWithTemp(totalStar,solidStar)
self.__owner:setChildStarLabelWithTemp(self.__id,totalStar,solidStar)
end


function UIStar:setStarNumber(starNum)
self.__owner:setChildStarNumber(self.__id,starNum)
end





function UIStar:setStarSlot(icon,quality,totalNum,solidNum)
self.__owner:setChildStarSlot(self.__id,icon,quality,totalNum,solidNum)
end


function UIStar:setGroundStarNum(starNum)
self.__owner:setChildGroundStarNum(self.__id,starNum)
end
