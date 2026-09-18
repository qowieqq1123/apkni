UILoopListView=simple_class(UIObject)


function UILoopListView:bindLoopListView(freshAction,startAction)
self._loopListView=self.__owner.widget:GetChildUILoopListView(self.__id)
self._loopListView2=self.__owner.widget:GetChildLoopListView2(self.__id)
self._startAction=startAction
self._freshAction=freshAction

self._loopListView:SetAction(function(...)
self:freshAction(...)
end,function(...)
self:startAction(...)
end)
end

function UILoopListView:startAction()
if self._startAction then
self._startAction()
end
end

function UILoopListView:freshAction(i,widget)
if self._freshAction then
local dataIndex=i+1
self._freshAction(dataIndex,widget,self._datalist[dataIndex])
end
end

function UILoopListView:__delete()
self._datalist=nil
self._loopListView:SetAction(nil,nil)
self._loopListView=nil
self._startAction=nil
self._freshAction=nil
self._loopListView2=nil
end


function UILoopListView:initData(prefabname,datalist,datalen)
self._datalist=datalist

local len=0
if datalen then
len=datalen
else
if datalist then
len=#datalist
end
end

local idlist={}
local namelist={}
if len>0 then
for i=1,len do
namelist[#namelist+1]=prefabname
idlist[#idlist+1]=0
end
end
self._loopListView:InitDataList(len,namelist,idlist,nil,nil)
end

function UILoopListView:initDataEx(prefabnameList,datalist,datalen)
self._datalist=datalist

local len=0
if datalen then
len=datalen
else
if datalist then
len=#datalist
end
end

local idlist={}
local namelist={}
if len>0 then
for i=1,len do
namelist[#namelist+1]=prefabnameList[i]
idlist[#idlist+1]=0
end
end
self._loopListView:InitDataList(len,namelist,idlist,nil,nil)
end



function UILoopListView:jumpItem(dataIndex)
self._loopListView:JumpIndex(dataIndex-1)
end


function UILoopListView:jumpNewestItem()
self._loopListView:JumpNewestIndex()
end




function UILoopListView:refreshAllItems()
self._loopListView:RefreshAllItems()
end


function UILoopListView:refreshItem(dataIndex)
loggerUtil.debugErrFMT('refreshItem不可用。可使用getListViewItemWidgetByDataIndex')
end




function UILoopListView:isVisiable(dataIndex)
return self._loopListView:CheckItemVisiable(dataIndex-1)
end


function UILoopListView:addItemList(prefabname,datalist)
if datalist==nil then return end
local len=#datalist
if self._datalist==nil then self._datalist={}end
table.addRange(self._datalist,datalist)

local namelist={}
local idlist={}
for i=1,len do
namelist[#namelist+1]=prefabname
idlist[#idlist+1]=0
end
self._loopListView:AddItemList(len,namelist,idlist,nil,nil)
end



function UILoopListView:insertItemList(dataIndex,prefabname,datalist)
if datalist==nil then return end
if self._datalist==nil then self._datalist={}end

table.insertRange(self._datalist,datalist,dataIndex)

local len=#datalist
local namelist={}
local idlist={}
for i=1,len do
namelist[#namelist+1]=prefabname
idlist[#idlist+1]=0
end
self._loopListView:InsertItemList(dataIndex-1,len,namelist,idlist,nil,nil)
end



function UILoopListView:deleteItemList(dataIndexList)
if dataIndexList==nil then return end
if self._datalist==nil then return end

self._datalist=table.deletelist(self._datalist,dataIndexList)

local temp={}
for i,v in ipairs(dataIndexList)do
temp[i]=v-1
end
self._loopListView:DeleteItemListByDataIndex(temp)
end



function UILoopListView:deleteItem(dataIndex)
if dataIndex==nil then return end
self._datalist=table.remove(self._datalist,dataIndex)
self._loopListView:DeleteDataByIndex(dataIndex-1)
end




function UILoopListView:getItemWidget(dataIndex)
local item=self:getListViewItemByDataIndex(dataIndex)
if item then
return item.Widget
end
end



function UILoopListView:getListView2()
return self._loopListView2
end


function UILoopListView:getListViewItemByDataIndex(dataIndex)
return self._loopListView2:GetShownItemByItemIndex(dataIndex-1)
end


function UILoopListView:getListViewSnapItemIndex()
return self._loopListView2:CurSnapNearestItemIndex()+1
end



function UILoopListView:getListViewItemByItemIdx(itemIndex)
return self._loopListView2:GetShownItemByIndexWithoutCheck(itemIndex-1)
end


function UILoopListView:getListViewItemWidgetByDataIndex(dataIndex)
local item=self:getListViewItemByDataIndex(dataIndex)
if item then
return item.Widget
end
end


function UILoopListView:getListViewItemShowCount()
return self._loopListView2.ShownItemCount
end





function UILoopListView:getListViewItemIndex(dataIndex)
dataIndex=dataIndex-1
local startItem=self:getListViewItemByItemIdx(1)
local itemCount=self:getListViewItemShowCount()
local startIndex=startItem.ItemIndex
local endIndex=startIndex+itemCount-1
if dataIndex<startIndex or dataIndex>endIndex then return-1 end
return dataIndex-startIndex+1
end

function UILoopListView:getVisableIndex()
local startItem=self:getListViewItemByItemIdx(1)
local itemCount=self:getListViewItemShowCount()
local startIndex=startItem.ItemIndex+1
local endIndex=startIndex+itemCount
return startIndex,endIndex
end
