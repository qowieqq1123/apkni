





UIScrollView=UIObject


function UIScrollView:setClickAction(action)
self.__owner:setChildUIBaseScrollClickAction(self.__id,action)
end


function UIScrollView:setLongTouchAction(action)
self.__owner:setChildUIBaseScrollLongAction(self.__id,action)
end


function UIScrollView:setItemAction(creatAction,freshAction)
self.__owner.widget:SetUIScrollViewBaseItemAction(self.__id,creatAction,freshAction)
end


function UIScrollView:bindScrollWidget(action)
self.__owner.widget:SetChildUIBaseScrollBindAction(self.__id,action)
end



function UIScrollView:setRecyleData(propArray)
self.__owner:setChildUIBaseScrollRecylePropData(self.__id,propArray)
end


function UIScrollView:stopAllCoroutines()
self.__owner:setChildStopAllCoroutines(self.__id)
end



function UIScrollView:initPropData(propArray)
self.__owner:setChildUIBaseScrollPropData(self.__id,propArray)
end




function UIScrollView:setPropData(startIdx,propArray)
self.__owner:setChildUIBaseScrollReplacePropData(self.__id,startIdx,propArray)
end



function UIScrollView:freshItem(index,key,val)
self.__owner:setChildUIBaseScrollData(self.__id,index,key,val)
end



function UIScrollView:clearItem(startIdx,endIdx)
self.__owner:setChildUIBaseScrollClearPropData(self.__id,startIdx,endIdx)
end


function UIScrollView:clearItems()
self.__owner:setChildUIBaseScrollClearItems(self.__id)
end


function UIScrollView:freshGridsNum(tNum,row,column,setZero)
self.__owner:setChildUIBaseScrollGridsByNum(self.__id,tNum,row,column,setZero)
end


function UIScrollView:getGridObjectByid(id)
return self.__owner:getChildUIScrollBaseItemById(self.__id,id)
end



function UIScrollView:getGridObjectByindex(index)
return self.__owner:getChildUIScrollBaseItemByIndex(self.__id,index)
end




function UIScrollView:freshGirdDisplayByindex(index,key,val)
self.__owner:setUIScrollViewBaseItemByIndex(self.__id,index,key,val)
end




function UIScrollView:freshGirdDisplayByPropKey(index,dataPropKey,compIdx,val)
local key=PropIndex(dataPropKey,compIdx)
self.__owner:setUIScrollViewBaseItemByIndex(self.__id,index,key,val)
end




function UIScrollView:freshGirdDisplayProp(index,prop)
self.__owner:setUIScrollViewBaseItemProp(self.__id,index,prop)
end



function UIScrollView:freshScrollItem(index)
self.__owner:setUIScrollViewBaseItemFresh(self.__id,index,prop)
end


function UIScrollView:freshScrollItemById(id)
self.__owner:setUIScrollViewBaseItemFreshById(self.__id,id)
end


function UIScrollView:freshScrollItemByGUID(guid)
self.__owner:setUIScrollViewBaseItemFreshByGUID(self.__id,guid)
end


function UIScrollView:setItemsBtnAction(index,action)
self.__owner.widget:SetUIScrollViewBaseBtnClickAction(self.__id,index,action)
end

function UIScrollView:jumpToItem(jumpIndex)
self.__owner:setUIScrollViewBaseJumpItem(self.__id,jumpIndex)
end


function UIScrollView:jumpToLockX(jumpIndex)
self.__owner:setUIScrollViewBaseJumpToLockX(self.__id,jumpIndex)
end


function UIScrollView:jumpToLockY(jumpIndex)
self.__owner:setUIScrollViewBaseJumpToLockY(self.__id,jumpIndex)
end

function UIScrollView:checkInShow(index)
return self.__owner:getUIScrollViewBaseCheckInShow(self.__id,index)
end