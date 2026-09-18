
EnhancedScrollerItemGrid=simple_class(EnhanceScrollerLua)
local _ts=serializeHelper.serialize

local defaultEmptyCellVis={}

local defaultSelectedVis={[DataPropKey.eItemSelectFlag]=6}

local defaultDeselectedVis={[DataPropKey.eItemSelectFlag]=-1}


function EnhancedScrollerItemGrid:__init()
self.singleSelection=true
self.toVisibleTableCallback=EnhancedScrollerItemGrid.ToBagVisibleTable

self.skipOverLengthVisibleTableCallback=true;

self.selectionTable={}


end




function EnhancedScrollerItemGrid.ToBagVisibleTable(data)
return data:GetBagShowVis()
end




function EnhancedScrollerItemGrid.ToVisibleTable(data)
return data
end




function EnhancedScrollerItemGrid:SetRowProperty(cellCount,emptyCellVis)
emptyCellVis=emptyCellVis or defaultEmptyCellVis
local emptyRowVis={}
for i=1,cellCount,1 do
emptyRowVis[#emptyRowVis+1]=emptyCellVis
end
self.emptyCellVis=emptyCellVis
self.emptyRowVis=emptyRowVis
self.cellCount=cellCount
end




function EnhancedScrollerItemGrid:GetDataIndex(rowIndex,cellIndex)
return(((rowIndex-1)*self.cellCount)+(cellIndex-1))+1
end



function EnhancedScrollerItemGrid:GetRowFirstDataIndex(rowIndex)
return(rowIndex-1)*self.cellCount+1
end



function EnhancedScrollerItemGrid:GetCellIndex(dataIndex)
dataIndex=dataIndex-1
local cellCount=self.cellCount
return dataIndex/cellCount,dataIndex%cellCount
end



function EnhancedScrollerItemGrid:OnSetCellView(rowIndex)
self:OnRefreshCellView(rowIndex)
end







function EnhancedScrollerItemGrid:OnRefreshCellView(rowIndex,cellViewIndex,cellViewComp,cellViewActive)

local dataSet=self.data
local cellMax=self.cellCount-1
local scrollerLua=self.scrollerLua
local emptyCellVis=self.emptyCellVis
local emptyRowVis=self.emptyRowVis
local rowStartDataIndex=self:GetRowFirstDataIndex(rowIndex)


scrollerLua:ClearRowLuaTable(rowIndex-1)


if self.skipOverLengthVisibleTableCallback and rowStartDataIndex>#dataSet then
return
end

local dataHandler=self.toVisibleTableCallback
local data={}

for i=0,cellMax,1 do
local currentIndex=rowStartDataIndex+i
local itemData=dataHandler(self.data[currentIndex],currentIndex)
if itemData~=nil then
data[i]=itemData
end
end

scrollerLua:SetCellLuaTable(rowIndex-1,data)
end

function EnhancedScrollerItemGrid:OnAllCellViewRefreshFinish()
local selected=self.selectionTable

for dataIndex,v in pairs(selected)do
self:SetCellLuaTableByIndex(dataIndex,defaultSelectedVis)
end

end







function EnhancedScrollerItemGrid:onRowTouchEvent(touchEvent,clickCount,rowIndex,cellIndex,cell)

local dataSet=self.data
local dataIndex=self:GetDataIndex(rowIndex,cellIndex)

local data=self.onRowTouchEventCallback(touchEvent,dataSet,dataIndex,clickCount,rowIndex,cellIndex,cell)
if data then
self.scrollerLua:SetCellLuaTable(rowIndex-1,cellIndex-1,data)
end
end




function EnhancedScrollerItemGrid:SetCellLuaTable(dataIndex,data)
self.data[dataIndex]=data
self:SetCellLuaTableByIndex(dataIndex,self.toVisibleTableCallback(data,dataIndex),true)
end





function EnhancedScrollerItemGrid:SetRowCellLuaTable(rowIndex,cellIndex,data)
local dataIndex=self:GetDataIndex(rowIndex,cellIndex)
self.data[dataIndex]=data
self:SetCellLuaTableByIndex(dataIndex,self.toVisibleTableCallback(data,dataIndex),true)
end


function EnhancedScrollerItemGrid:DeSelected()
if self.singleSelection then
local selection=next(self.selectionTable)
if selection then
self:SetCellLuaTableByIndex(selection,defaultDeselectedVis)
end
self.selectionTable={}
else
for dataIndex,v in pairs(self.selectionTable)do

self:SetCellLuaTableByIndex(dataIndex,defaultDeselectedVis)

end
self.selectionTable={}
end

end




function EnhancedScrollerItemGrid:SetToggleSelect(dataIndex)
if self.singleSelection then
local selection=next(self.selectionTable)
if selection then
self:SetCellLuaTableByIndex(selection,defaultDeselectedVis)
end

if selection==dataIndex then
self.selectionTable={}
return false
end

self:SetCellLuaTableByIndex(dataIndex,defaultSelectedVis)
self.selectionTable={[dataIndex]=true}
else

if self.selectionTable[dataIndex]then
self.selectionTable[dataIndex]=nil
self:SetCellLuaTableByIndex(dataIndex,defaultDeselectedVis)
return false
end
self:SetCellLuaTableByIndex(dataIndex,defaultSelectedVis)
self.selectionTable[dataIndex]=true
end
return true
end































function EnhancedScrollerItemGrid:SetCellLuaTableByIndex(dataIndex,visibleTable,clear)
local ri,ci=self:GetCellIndex(dataIndex)

if self.scrollerLua:GetIsActiveCell(ri)then
if clear then
self.scrollerLua:ClearRowLuaTable(ri,ci);
end
self.scrollerLua:SetCellLuaTable(ri,ci,visibleTable);
end
end
