

LuaComboTreeView=simple_class()




function LuaComboTreeView:__init(winlua,cmpObj)
self.winlua=winlua
self.cmpObj=cmpObj
self.mainData={}
self.subData={}
self.showList={}
self.showItem={}
self.expanding=nil
self.refreshAction={}

self.loopListView=self.winlua:GetChildUILoopListView(self.cmpObj:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.cmpObj:getID())
self._onFreshAction=function(index,widget)
self:onFreshAction(index,widget)
end
self._onStartAction=function()
self:onStartAction()
end
self.loopListView:SetAction(self._onFreshAction,self._onStartAction)
end


function LuaComboTreeView:__delete()
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self.loopListViewCmp=nil
end


function LuaComboTreeView:setStartAction(startAction)
self.startAction=startAction
end


function LuaComboTreeView:convertItemIndex(index)
if not self.expanding then
return index,0
end

if self.expanding>=index then
return index,0
end
local subList=self.subData[self.expanding]or{}
local subCnt=#subList
local temp=self.expanding+subCnt
if temp<index then
return index-subCnt,0
end
return self.expanding,index-self.expanding
end


function LuaComboTreeView:convertShowIndex(mainIndex,subIndex)
if mainIndex~=self.expanding and subIndex>0 then
return
end
if mainIndex<self.expanding then
return mainIndex
elseif mainIndex>self.expanding then
local subList=self.subData[self.expanding]or{}
local subCnt=#subList
return mainIndex+subCnt
else
return mainIndex+subIndex
end
end


function LuaComboTreeView:onFreshAction(itemIndex,widget)
local showIndex=itemIndex+1
local itemName=self.showList[showIndex]
if itemName then
self.showItem[showIndex]=widget
local handle=self.refreshAction[itemName]
if handle then
local mainIndex,subIndex=self:convertItemIndex(showIndex)
handle(widget,mainIndex,subIndex)
end
end
end


function LuaComboTreeView:onStartAction()
if self.startAction then
self.startAction()
end
end


function LuaComboTreeView:setMainData(mainNames)
self.mainData=mainNames
self.subData={}
self.expanding=nil
end


function LuaComboTreeView:setSubData(mainIndex,subNames)
local mainData=self.mainData[mainIndex]
if mainData then
self.subData[mainIndex]=subNames
else
loggerUtil.logErrFMT("LuaComboTreeView 没有对应的 mainIndex : {0}",mainIndex)
end
end


function LuaComboTreeView:setItemRefresh(itemName,refreshAction)
self.refreshAction[itemName]=refreshAction
end

function LuaComboTreeView:getShowList()
local list={}
local temp={}
for i,v in ipairs(self.mainData)do
table.insert(list,v)
table.insert(temp,0)
if self.expanding==i then
for j,w in ipairs(self.subData[i])do
table.insert(list,w)
table.insert(temp,0)
end
end
end
return list,temp
end


function LuaComboTreeView:refreshItem(mainIndex,subIndex)
local showIndex=self:convertShowIndex(mainIndex,subIndex)
local item=self.showItem[showIndex]
if item==nil then
return
end
local itemName=self.showList[showIndex]
if itemName then
local handle=self.refreshAction[itemName]
if handle then
local mainIndex,subIndex=self:convertItemIndex(showIndex)
handle(item,mainIndex,subIndex)
end
end
end


function LuaComboTreeView:expandMain(mainIndex)
if mainIndex==nil then
loggerUtil.logErrFMT("LuaComboTreeView expandMain 传入空值 mainIndex")
return
end
if self.expanding~=mainIndex then
local mainData=self.mainData[mainIndex]
if mainData then
self.expanding=mainIndex
else
loggerUtil.logErrFMT("LuaComboTreeView 没有对应的 mainIndex : {0}",mainIndex)
return
end
else
self.expanding=nil
end
self:refreshView()
end


function LuaComboTreeView:isExpanding(mainIndex)
return self.expanding==mainIndex
end


function LuaComboTreeView:refreshView()
local list,temp=self:getShowList()
self.showList=list
self.showItem={}
self.loopListView:InitDataList(#self.showList,self.showList,temp,nil,nil)
self.loopListView:RefreshAllItems()
end