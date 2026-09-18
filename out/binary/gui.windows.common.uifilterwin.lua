







def_class("UIFilterWin",UIWindowBase)









function UIFilterWin:bindComponents()

self.pageCreater=UIObject.get(self,0)



end


function UIFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageCreater);self.pageCreater=nil;
end



















function UIFilterWin:onLoaded(...)
self:bindComponents()
end


function UIFilterWin:__delete()
self:unbindComponents()
end




function UIFilterWin:onShow(argtable,afterOnloaded)
if argtable then
self.parentWin=argtable.parentWin
self.filterName=argtable.filterName
self.filterFlag=table.deepCopy(argtable.filterFlag)
self.oldFilterFlag=table.deepCopy(argtable.filterFlag)
self.conflictList=argtable.conflictList
self.reset=argtable.reset
self.comfirmCallback=argtable.comfirmCallback
self.attach=argtable.attach
self:updateView()
end
end


function UIFilterWin:onHide()

end






















































function UIFilterWin:updateView()
local pagenum=#self.filterName
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIFilterWin:refreshPageItem(item,pageidx)
local pageData=self.filterName[pageidx]
local pageTitle=pageData[1]
local childNameList=pageData[2]
local childFlagList=self.filterFlag[pageidx]

item:SetChildText(0,pageTitle)

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx)
end
end

function UIFilterWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx].name
local iconname=childNameList[idx].icon or''
local isselect=childFlagList[idx]or false
childItem:SetChildToggle(0,isselect)
childItem:SetChildToggleChange(0,function(name,isOn)
childFlagList[idx]=isOn
if isOn then
self:checkConflict(pageidx,idx,childFlagList)
end
end)
childItem:SetChildText(1,desc_str)
childItem:SetChildIcon(2,iconname,false)
end

function UIFilterWin:checkConflict(pageidx,idx,childFlagList)
if not self.conflictList then
return
end
local subConflictList=self.conflictList[pageidx]
if not subConflictList or not next(subConflictList)then
return
end
local conflictidxList=subConflictList[idx]
if not conflictidxList or not next(conflictidxList)then
return
end
local item=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
for i,v in ipairs(conflictidxList)do
local childItem=item:GetChildLayoutGroupGridItem(1,v-1)
childItem:SetChildToggle(0,false)
childFlagList[v]=false
end
end



function UIFilterWin:onResetClick()
if self.reset~=nil then
self.filterFlag=table.deepCopy(self.reset)
else
for i,v in ipairs(self.filterFlag)do
for i1,v1 in ipairs(v)do
self.filterFlag[i][i1]=false
end
end
end
self:updateView()
end

function UIFilterWin:onComfirmClick()
local func=self.comfirmCallback
if func then
local change=false
for i,v in ipairs(self.filterFlag)do
for i1,v1 in ipairs(v)do
if v1~=self.oldFilterFlag[i][i1]then
change=true
break
end
end
if change then
break
end
end
if change then
func({filterFlag=self.filterFlag,filterName=self.filterName,attach=self.attach})
end
end
self:myClose()
end

function UIFilterWin:myClose()
self.parentWin:onCloseClick()
end
