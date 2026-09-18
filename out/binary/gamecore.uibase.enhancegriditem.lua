










EnhanceGridItem=simple_class(UIWindowBase)
function EnhanceGridItem:__init(gameObject,winlua)
local touch=ComponentHelper.AddComponent(self.gameObject,CS.TouchEvent)
touch.OnClickListen=objectHelper.packFunc(self,self.GridItemClick)
end

function EnhanceGridItem:SetSelected(selIndex)
self.isSelect=selIndex==self.dataIndex and true or false
self:RefreshState()
end


function EnhanceGridItem:SetDataIndex(dataIndex)
self.dataIndex=dataIndex
end

function EnhanceGridItem:SetSelectCallback(callFunc)
self.callFunc=callFunc
end

function EnhanceGridItem:RefreshState()
end

function EnhanceGridItem:RefreshDataInfo(data)
end

function EnhanceGridItem:GridItemClick()
if self.callFunc then
self.callFunc(self.dataIndex)
end
end





EnhanceGridLineItem=simple_class()

function EnhanceGridLineItem:SetSelected(bool)
self.isSelect=bool
self:RefreshState()
end


function EnhanceGridLineItem:SetDataIndex(dataIndex)
self.dataIndex=dataIndex
end

function EnhanceGridLineItem:GetDataIndex()
return self.dataIndex
end


function EnhanceGridLineItem:InitGridItem(Columns,GridItemClass,gridCells)
self.Columns=Columns
self.gridItemList={}
self.GridItemClass=GridItemClass

for i=1,self.Columns do
self.gridItemList[i]=self.GridItemClass.New(gridCells[i].gameObject,gridCells[i])
self.gridItemList[i]:SetSelectCallback(objectHelper.packFunc(self,self.GridItemClick))
end
end

function EnhanceGridLineItem:SetSelectedGridItem(selIndex)
for i,gridItem in ipairs(self.gridItemList)do
gridItem:SetSelected(selIndex)
end
end


function EnhanceGridLineItem:SetDataIndex(lineIndex)
self.lineIndex=lineIndex
end

function EnhanceGridLineItem:GridItemClick(index)
if self.callFunc then
self.callFunc(index)
end
end

function EnhanceGridLineItem:SetSelectCallback(callFunc)
self.callFunc=callFunc
end

function EnhanceGridLineItem:RefreshState()

end

function EnhanceGridLineItem:RefreshDataInfo(Linedata)
if self.gridItemList then
local pos
for i,handleCell in ipairs(self.gridItemList)do
pos=(self.lineIndex-1)*self.Columns+i
handleCell:SetDataIndex(pos)
handleCell:RefreshDataInfo(Linedata[i])
end
end
end

function EnhanceGridLineItem:RefreshData(data)
if self.gridItemList then
for i,handleCell in ipairs(self.gridItemList)do
handleCell:RefreshDataInfo(data[i])
end
end
end

function EnhanceGridLineItem:__delete()
if self.gridItemList then
for i,handleCell in ipairs(self.gridItemList)do
handleCell:deleteSelf();
end
end
end
