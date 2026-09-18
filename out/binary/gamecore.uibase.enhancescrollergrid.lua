






EnhanceScrollerGrid=simple_class(EnhanceScrollerLua)

local defaultData={}

function EnhanceScrollerGrid:__init(gameObject,winlua)
self.fixedGridCount=-1
end

function EnhanceScrollerGrid:Init(scrollerLua,cellSize)
self._base.Init(self,scrollerLua,cellSize)
self.columns=self.scrollerLua.Columns
end

function EnhanceScrollerGrid:GridItemClick(gridIndex)
if self.callFunc then
self.callFunc(gridIndex)
end

if self.listData[gridIndex]then
self.selGridIndex=gridIndex
for i,v in pairs(self.cellList)do
v:SetSelectedGridItem(gridIndex)
end
end
end

function EnhanceScrollerGrid:GridItemClass(GridItemClass)
self.gridItemClass=GridItemClass
end


function EnhanceScrollerGrid:SetData(data)
self.listData=data

self.data=self:TransColumnsData(data)


if self.fixedGridCount>0 then
self.scrollerLua:InitData(self.fixedGridCount,self.cellSize)
else
self.scrollerLua:InitData(#self.data,self.cellSize)
end
end

function EnhanceScrollerGrid:RefreshData(data)
if data then self.data=self:TransColumnsData(data)end
for k,v in pairs(self.cellList)do
if self.data[v.lineIndex]then
v:RefreshData(self.data[v.lineIndex])
end
end
end

function EnhanceScrollerGrid:OnSetCellView(dataIndex,cellIndex,cellView,...)
local handleCell=self.cellList[cellView]
if not handleCell then
local gridCells={...}
handleCell=EnhanceGridLineItem.New(cellView.gameObject,cellView)
handleCell:InitGridItem(self.columns,self.gridItemClass,gridCells)
handleCell:SetSelectCallback(objectHelper.packFunc(self,self.GridItemClick))
self.cellList[cellView]=handleCell
end

handleCell:SetDataIndex(dataIndex)
handleCell:RefreshDataInfo(self.data[dataIndex]or defaultData)
end


function EnhanceScrollerGrid:OnRefreshCellView(dataIndex,cellIndex,cellView,...)
local handleCell=self.cellList[cellView]
if handleCell then
handleCell:SetDataIndex(dataIndex)
handleCell:RefreshDataInfo(self.data[dataIndex])

handleCell:SetSelectedGridItem(self.selGridIndex or defaultData)
end
end

function EnhanceScrollerGrid:TransColumnsData(data)
local result={}

local totalCount=#data
local viewCount=math.ceil(totalCount/self.columns)

for paren=1,viewCount do
local childData={}
local maxcell=self.columns*paren
local mincell=maxcell-self.columns+1
for curIndex=mincell,maxcell do
childData[#childData+1]=data[curIndex]
end
result[paren]=childData
end
if self.fixedCount>0 then
self.fixedGridCount=math.floor(self.fixedCount/self.columns)
end
return result
end
