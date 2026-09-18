









local _BindWindow=CS.BindWindow
local TableToObjectArray=CS.TableToObjectArray

ScrollerOrder={
order=1,
reverse=2,
}

EnhanceScrollerLua=simple_class()

function EnhanceScrollerLua:__init()
self.cellList={}
self.selIndex=-1
self.isCreate=false
self.fixedCount=-1
self.m_order=ScrollerOrder.order
end

function EnhanceScrollerLua:Init(scrollerLua,cellSize)
self.scrollerLua=scrollerLua
_BindWindow(self.scrollerLua,self)

self.cellSize=cellSize or 0
end

function EnhanceScrollerLua:GetContainerRectTransform()
if self.container then
return self.container
end
local gobj=self.scrollerLua.gameObject.transform
self.container=gobj:Find('Container'):GetComponent('RectTransform')
return self.container
end


function EnhanceScrollerLua:SetContainerAnchoredPosition(x,y)
local rect=self:GetContainerRectTransform()
rect.anchoredPosition=Vector2(x,y)
end

function EnhanceScrollerLua:GetSelIndex()
return self.selIndex
end


function EnhanceScrollerLua:SetData(data)
self.data=data
if self.fixedCount>0 then
self.scrollerLua:InitData(self.fixedCount,self.cellSize)
else
self.scrollerLua:InitData(#data,self.cellSize)
end
end


function EnhanceScrollerLua:SetCellCellProperty(index,prefabIndex,height)
self.scrollerLua:SetCellCellProperty(index,prefabIndex,height)
end

function EnhanceScrollerLua:SetCellProperty(data)
local prop=TableToObjectArray(data)
self.scrollerLua:InitCellCellProperty(prop)
end

function EnhanceScrollerLua:SetSelectCallback(callFunc)
self.callFunc=callFunc
end


function EnhanceScrollerLua:SetScrollerEndCall(endFunc)
self.endFunc=endFunc
end


function EnhanceScrollerLua:SetScrollerStartCall(startFunc)
self.startFunc=startFunc
end

function EnhanceScrollerLua:SetItemClass(itemClass,extraData)
self.itemClass=itemClass
self.itemClass.extraData=extraData
end

function EnhanceScrollerLua:JumpToDataIndex(dataIndex,scrollerOffset,cellOffset,useSpacing,tweenType,tweenTime,cb)
self.scrollerLua:JumpToDataIndex(dataIndex-1,scrollerOffset,cellOffset,useSpacing,tweenType,tweenTime,cb)
end

function EnhanceScrollerLua:SetSelectedOutAction(selIndex)
self.selIndex=selIndex and selIndex or self.selIndex
self:CellCall(self.selIndex,self.selIndex)
end

function EnhanceScrollerLua:SetSelected(selIndex,scrollerOffset,cellOffset,noCallFun)
scrollerOffset=scrollerOffset or 0
cellOffset=cellOffset or 0
self.selIndex=selIndex and selIndex or self.selIndex
self:CellCall(self.selIndex,self.selIndex,nil,noCallFun)
self:JumpToDataIndex(self.selIndex,scrollerOffset,cellOffset,true,0,0,nil)
end

function EnhanceScrollerLua:RefreshData(data)
if data then self.data=data end
local count=self.fixedCount>0 and self.fixedCount or#self.data
for k,v in pairs(self.cellList)do

local index=v:GetDataIndex()
if index<=count then
self:RefreshDataInfo(v,index)
end
end
end

function EnhanceScrollerLua:RefreshItemAndData(index,itemData)
self:SetItemData(index,itemData)
self:RefreshItem(index)
end

function EnhanceScrollerLua:SetItemData(index,itemData)
self.data[index]=itemData
end

function EnhanceScrollerLua:RefreshItem(index)

for k,v in pairs(self.cellList)do
if v:GetDataIndex()==index then

self:RefreshDataInfo(v,v:GetDataIndex())
break
end
end
end


function EnhanceScrollerLua:RefreshAllItem()

for k,v in pairs(self.cellList)do
self:RefreshDataInfo(v,v:GetDataIndex())
v:RefreshState(self.selIndex)
end
end



function EnhanceScrollerLua:RefreshDataKeepPos(data)
self:GetContainerRectOffsetMax()
self:SetData(data)
self:KeepPositionOnRefreshList()
end

function EnhanceScrollerLua:SetFixedCount(count)
self.fixedCount=count
end

function EnhanceScrollerLua:SetOrder(order)
self.m_order=order
end


function EnhanceScrollerLua:AutoMove(speed,step,order,vertical,isReset)
self.scrollerLua:AutoMove(speed,step,order,vertical,isReset)
end

function EnhanceScrollerLua:StopAutoMove()
self.scrollerLua:StopAutoMove()
end


function EnhanceScrollerLua:SetMoveCall(callback)
self.moveCallFunc=callback
end

function EnhanceScrollerLua:RefreshMove(dataIndex)
if self.moveCallFunc then
self.moveCallFunc(dataIndex)
end
end





function EnhanceScrollerLua:OnSetCellView(dataIndex,cellIndex,transform)
if not self.cellList[transform]then
self.isCreate=true
self.cellList[transform]=self.itemClass.New(transform.gameObject,transform)

end

local handleCell=self.cellList[transform]

handleCell:SetSelected(dataIndex==self.selIndex)
handleCell:SetDataIndex(dataIndex)
self:RefreshDataInfo(handleCell,dataIndex)
end


function EnhanceScrollerLua:OnRefreshCellView(dataIndex,cellIndex,transform)
local handleCell=self.cellList[transform]
if handleCell then
handleCell:SetSelected(dataIndex==self.selIndex)
handleCell:SetDataIndex(dataIndex)
self:RefreshDataInfo(handleCell,dataIndex)
end
end

function EnhanceScrollerLua:RefreshDataInfo(handleCell,dataIndex)
local data=self.data[dataIndex]
if self.m_order==ScrollerOrder.reverse then
if self.fixedCount>0 then
data=self.data[self.fixedCount-(dataIndex-1)]
else
data=self.data[#self.data-(dataIndex-1)]
end
end
handleCell:RefreshDataInfo(data,dataIndex)
self:RefreshMove(dataIndex)
end

function EnhanceScrollerLua:OnScrollEndCall()
if self.endFunc then
self.endFunc()
end
end

function EnhanceScrollerLua:OnScrollStartCall()
if self.startFunc then
self.startFunc()
end
end


function EnhanceScrollerLua:CellCall(dataIndex,cellIndex,transform,noCallFun)
self.selIndex=dataIndex
if self.callFunc and not noCallFun then
self.callFunc(dataIndex)
end

if self.isCreate then
for k,handleCell in pairs(self.cellList)do
handleCell:SetSelected(handleCell.dataIndex==self.selIndex)
end
end
end


function EnhanceScrollerLua:CanCelCellSelected()
if self.isCreate then
for k,handleCell in pairs(self.cellList)do
handleCell:CanCelSelected()
end
self.selIndex=-1
end
end

function EnhanceScrollerLua:__delete()
self.oldRectOffsetMax=nil
for k,handleCell in pairs(self.cellList)do
handleCell:deleteSelf()
end
end








function EnhanceScrollerLua:GetContainerRectOffsetMax()
self:GetContainerRectTransform()
self.oldRectOffsetMax=self.container.offsetMax
end



function EnhanceScrollerLua:KeepPositionOnRefreshList()
local currentMin=self.container.offsetMin
local currentMax=self.container.offsetMax
local height=math.abs(currentMin.y)+math.abs(currentMax.y)
self.container.offsetMin=Vector2.New(0,self.oldRectOffsetMax.y-height)
self.container.offsetMax=self.oldRectOffsetMax
end

function EnhanceScrollerLua:SetContainerPivot(x,y)
self:GetContainerRectTransform()
if self.container then
self.container.pivot=Vector2.New(x,y)
end
end
