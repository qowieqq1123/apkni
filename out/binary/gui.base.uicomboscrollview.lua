UIComboScrollView=UIObject

function UIComboScrollView:setAction(mainClickAction,subClickAction,mainCreateAction,subCreateAction,onExpandAction)
self.__owner.widget:SetChildComboScrollViewActions(self.__id,mainClickAction,subClickAction,mainCreateAction,subCreateAction,onExpandAction)
end

function UIComboScrollView:createMainGrids(row,colum,setZero)
self.__owner.widget:SetChildComboScrollViewCreateGrids(self.__id,row,colum,setZero)
end

function UIComboScrollView:removeAllGrids()
self.__owner.widget:SetChildComboScrollViewRemoveAllGrids(self.__id)
end

function UIComboScrollView:rebuildSubItems(mainIndex,subItemCount,finishAction)
return self.__owner.widget:SetChildComboScrollViewRebuildGrids(self.__id,mainIndex,subItemCount,finishAction)
end

function UIComboScrollView:getMainItemsList()
return self.__owner.widget:GetChildComboScrollViewAllMainItemList(self.__id)
end

function UIComboScrollView:getSubItemsList()
return self.__owner.widget:GetChildComboScrollViewAllSubItemList(self.__id)
end

function UIComboScrollView:getMainItem(mainIndex)
return self.__owner.widget:GetChildComboScrollViewMainItem(self.__id,mainIndex)
end

function UIComboScrollView:getSubItem(mainIndex,subIndex)
return self.__owner.widget:GetChildComboScrollViewSubItemWidget(self.__id,mainIndex,subIndex)
end

function UIComboScrollView:clickItem(mainIndex)
self.__owner.widget:ClickChildComboScrollViewMainItem(self.__id,mainIndex)
end

function UIComboScrollView:isExpending()
return self.__owner.widget:GetChildComboScrollViewIsExpending(self.__id)
end