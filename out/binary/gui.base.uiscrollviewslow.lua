





UIScrollViewSlow=UIObject


function UIScrollViewSlow:setSlowClickAction(action)
self.__owner:setChildSlowScrollClickAction(self.__id,action)
end

function UIScrollViewSlow:setSlowLongClickAction(action)
self.__owner:setChildSlowScrollLongAction(self.__id,action)
end



function UIScrollViewSlow:bindSlowWidget(action)
self.__owner:setChildSlowScrollBindAction(self.__id,action)
end



function UIScrollViewSlow:checkItemInRect(index)
return self.__owner:checkUIScrollViewBaseItemInViewRect(self.__id,index)
end



function UIScrollViewSlow:freshSlowItem(index)
self.__owner:freshChildSlowScrollItem(self.__id,index)
end



function UIScrollViewSlow:freshSlowItemByGUID(guid)
return self.__owner:freshChildSlowScrollItemByGUID(self.__id,guid)
end


function UIScrollViewSlow:freshSlowGrids(tNum,row,column,setZero)
self.__owner:freshChildSlowScrollGrids(self.__id,tNum,row,column,setZero)
end


function UIScrollViewSlow:getSlowItemById(id)
return self.__owner:getChildSlowScrollItemById(self.__id,id)
end



function UIScrollViewSlow:getSlowItemByIndex(index)
return self.__owner:getChildSlowScrollItemByIndex(self.__id,index)
end

function UIScrollViewSlow:clearSlowItems()
return self.__owner:clearChildSlowScrollItems(self.__id)
end

function UIScrollViewSlow:freshAllItems()
self.__owner:refreshSlowScrollAllItems(self.__id)
end

function UIScrollViewSlow:jumpToSlowItem(jumpIndex)
self.__owner:jumpChildSlowScrollItem(self.__id,jumpIndex)
end
