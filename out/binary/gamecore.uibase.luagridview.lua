






LuaGridView=simple_class(LuaListView)


local GridOpearteType={
Add=1,
Remove=2,
}
local Constraint={
Flexible=0,
FixedColumnCount=1,
FixedRowCount=2,
}


function LuaGridView:__init(gameObject,GridLayout)
self.mGridLayoutGroup=GridLayout
end

function LuaGridView:UpdateContentSize(index)
local constraint=self.mGridLayoutGroup.constraint:ToInt()
local constraintCount=self.mGridLayoutGroup.constraintCount


local rowsCount=constraint==Constraint.Flexible and 1 or constraintCount

local lineCount=math.ceil(#self.mLuaNodeList/rowsCount)

local cellsize=self.mGridLayoutGroup.cellSize
local spacing=self.mGridLayoutGroup.spacing
local padding=self.padding and self.padding or{left=0,right=0,top=0,bottom=0}
local left=padding.left or 0
local right=padding.right or 0
local top=padding.top or 0
local bottom=padding.bottom or 0


if Constraint.FixedRowCount==constraint then
local temp=rowsCount
rowsCount=lineCount
lineCount=temp
end

local newWidth=rowsCount*(cellsize.x+spacing.x)-spacing.x+left+right
local newHeigh=lineCount*(cellsize.y+spacing.y)-spacing.y+top+bottom


self.transform.sizeDelta=Vector2(newWidth,newHeigh)


if self.OnSizeChangeCall then
self.OnSizeChangeCall(newWidth,newHeigh)
end
end
