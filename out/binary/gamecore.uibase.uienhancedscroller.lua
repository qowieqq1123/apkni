






UIEnhancedScroller=simple_class(UIWidget)

local TableToObjectArray=CS.TableToObjectArray

function UIEnhancedScroller:__init(view,winlua,events,onStartCallback,name)
if events==nil then
winlua:SetupMonoEvent(true,false,false,false)
end
end


function UIEnhancedScroller:OnSetCellView(dataIndex,cellIndex,cell)
assert(false,'not implemented')


end

function UIEnhancedScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
assert(false,'not implemented')

end

function UIEnhancedScroller:OnScrollerSnapped(cellIndex,cell)
assert(false,'not implemented')

end

function UIEnhancedScroller:initData(data,cellsize,cellCount)
self.data=data
self.cellsize=cellsize
self.cellCount=cellCount


self.winlua:InitData(cellCount,cellsize)

end

function UIEnhancedScroller:doRefreshActiveCellViews()
self.winlua:RefreshActiveCellViews()
end

function UIEnhancedScroller:doRefreshCellView(dataIndex)
self.winlua:DoRefreshCellView(dataIndex-1)
end

function UIEnhancedScroller:getActiveCellView(dataIndex)
return self.winlua:GetActiveCellView(dataIndex-1)
end

function UIEnhancedScroller:GetCell(dataIndex)
return self.winlua:GetCell(dataIndex,0)
end


function UIEnhancedScroller:createGrid(cellsize,cellCount)
self.winlua:InitData(cellCount,cellsize)
end

function UIEnhancedScroller:setCellProperty(data)
local prop=TableToObjectArray(data)
self.winlua:InitCellCellProperty(prop)
end

function UIEnhancedScroller:jumpToDataIndex(dataIndex,scrollerOffset,cellOffset,useSpacing,tweenType,tweenTime,cb)
self.winlua:JumpToDataIndex(dataIndex,scrollerOffset,cellOffset,useSpacing,tweenType,tweenTime,cb)
end

function UIEnhancedScroller:getStartCellViewIndex()
return self.winlua:GetStartCellViewIndex()
end

function UIEnhancedScroller:getEndCellViewIndex()
return self.winlua:GetEndCellViewIndex()
end