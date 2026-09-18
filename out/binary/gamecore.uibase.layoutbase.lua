





LayoutBase=simple_class(UIWidgetRef)
function LayoutBase:__init(gameObject,winlua)
self.selIndex=-1
end

function LayoutBase:CellCall(dataIndex)
if self.selIndex and self.selIndex==dataIndex then
self:DoubleCall(dataIndex)
end

self.selIndex=dataIndex
if self.callFunc then
self.callFunc(dataIndex)
end

if self.cellList then
for k,handleCell in ipairs(self.cellList)do
handleCell:SetSelected(handleCell.dataIndex==self.selIndex)
end
end
end

function LayoutBase:ClickTab(obj,dataIndex)
self:CellCall(dataIndex)
end

function LayoutBase:SetSelectCallback(callFunc)
self.callFunc=callFunc
end

function LayoutBase:SetItemClass(itemClass)
self.itemClass=itemClass
end

function LayoutBase:Init(showPos,clickMode)
self.tabbar=Tabbar(objectHelper.packFunc(self,self.ClickTab),clickMode)
self.cellList={}
local tarns
for i=1,showPos do
tarns=self:FindTransform(tostring(i))
self.cellList[i]=self.itemClass.New(tarns.gameObject,tarns)
self.cellList[i]:SetDataIndex(i)
self.tabbar:AddBtn(tarns.gameObject,i)
end
end


function LayoutBase:DoubleCall(dataIndex)
if self.cellList[dataIndex]then
self.cellList[dataIndex]:DoubleCall()
end
end

function LayoutBase:SetSelected(selIndex)
self.selIndex=-1
selIndex=selIndex and selIndex or 1
self:CellCall(selIndex)
end

function LayoutBase:GetSelectIndex()
return self.selIndex or 1
end

function LayoutBase:ReSetData()
self.selIndex=-1
end

function LayoutBase:SetData(data)
self.data=data
for i,cell in ipairs(self.cellList)do
cell:RefreshDataInfo(self.data[i])
end
end

function LayoutBase:__delete()
for k,handleCell in pairs(self.cellList)do
handleCell:deleteSelf()
end
end




LayoutBaseItem=simple_class(UIWidgetRef)
function LayoutBaseItem:__init(gameObject)
self.gameObject=gameObject
end

function LayoutBaseItem:SetSelected(bool)
self.isSelect=bool
self:RefreshState()
end


function LayoutBaseItem:SetDataIndex(dataIndex)
self.dataIndex=dataIndex
end

function LayoutBaseItem:GetDataIndex()
return self.dataIndex
end

function LayoutBaseItem:DoubleCall()
end

function LayoutBaseItem:RefreshState()
end

function LayoutBaseItem:RefreshDataInfo(data)
end

function LayoutBaseItem:__delete()
end
