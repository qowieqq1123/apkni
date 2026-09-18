







def_class("UIXianJie_yzTeamDzFilterWin",UIWindowBase)









function UIXianJie_yzTeamDzFilterWin:bindComponents()

self.pageCreater=UIObject.get(self,0)
self.cliskMask=UIButton.get(self,1)
self.btnReset=UIButton.get(self,2)
self.btnConfirm=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.titleName=UIText.get(self,5)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_yzTeamDzFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end
















local pageItemCmpIndex={
name=0,
childCreater=1,
toggle=2,
checkMark=3,
}

local childItemCmpIndex={
toggle=0,
name=1,
icon=2,
bg=3,
clickMask=4,
}




function UIXianJie_yzTeamDzFilterWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_yzTeamDzFilterWin:__delete()
self:unbindComponents()
end




function UIXianJie_yzTeamDzFilterWin:onShow(argtable,afterOnloaded)
if argtable then
self.parentWin=argtable.parentWin
self.filterName=argtable.filterName
self.filterFlag=table.deepCopy(argtable.filterFlag)
self.oldFilterFlag=table.deepCopy(argtable.filterFlag)
self.reset=argtable.reset
self.confirmCallback=argtable.confirmCallback
self.attach=argtable.attach


self.notShowPageList={}
local pagenum=#self.filterName
for i=1,pagenum do
local flag=self.filterName[i][1]==nil
self.notShowPageList[i]=flag
end

self:updateView()
end
end


function UIXianJie_yzTeamDzFilterWin:onHide()

end

function UIXianJie_yzTeamDzFilterWin:updateView()
local pagenum=#self.filterName
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIXianJie_yzTeamDzFilterWin:refreshPageItem(item,pageidx)

local notShow=self.notShowPageList[pageidx]
item:SetChildActive(-1,not notShow)
if notShow then
return
end
local pageData=self.filterName[pageidx]
local pageTitle=pageData[1]
local childNameList=pageData[2]
local isCanSelectAll=pageData[3]or false
local isOnlySingleSelect=pageData[4]or false
local childFlagList=self.filterFlag[pageidx]

item:SetChildText(pageItemCmpIndex.name,pageTitle)

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(pageItemCmpIndex.childCreater,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx,isCanSelectAll,isOnlySingleSelect)
end

local isShowSelectAll=isCanSelectAll and not isOnlySingleSelect
self:refreshPageItemToggle(pageidx,isShowSelectAll)
end

function UIXianJie_yzTeamDzFilterWin:refreshPageItemToggle(pageidx,isShowSelectAll)
local item=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
if isShowSelectAll then
item:SetChildActive(pageItemCmpIndex.toggle,true)
local selectAll=self:isSelectAll(pageidx)
item:SetChildToggleChange(pageItemCmpIndex.toggle,nil)
item:SetChildToggle(pageItemCmpIndex.toggle,selectAll)
item:SetChildActive(pageItemCmpIndex.checkMark,selectAll)
item:SetChildToggleChange(pageItemCmpIndex.toggle,function(name,isOn)
self:selectPageAll(pageidx,isOn)
item:SetChildActive(pageItemCmpIndex.checkMark,isOn)
end)
else
item:SetChildActive(pageItemCmpIndex.toggle,false)
end
end

function UIXianJie_yzTeamDzFilterWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx,isCanSelectAll,isOnlySingleSelect)
local desc_str=childNameList[idx].name
local iconname=childNameList[idx].icon or''
local isselect=childFlagList[idx]or false
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)

local isShowSelectAll=isCanSelectAll and not isOnlySingleSelect
if isOnlySingleSelect then
childItem:SetChildActive(childItemCmpIndex.clickMask,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
if childFlagList[idx]==isOn then
return
end
if isOn then
self:selectPageAll(pageidx,false,idx,true)
end
childFlagList[idx]=isOn
childItem:SetChildActive(childItemCmpIndex.clickMask,isOn)
end)
else
childItem:SetChildActive(childItemCmpIndex.clickMask,false)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
self:refreshPageItemToggle(pageidx,isShowSelectAll)
end)
end
childItem:SetChildText(childItemCmpIndex.name,desc_str)
childItem:SetChildIcon(childItemCmpIndex.icon,iconname,false)
end

function UIXianJie_yzTeamDzFilterWin:isSelectAll(pageidx)
local pageData=self.filterName[pageidx]
local childNameList=pageData[2]
local childFlagList=self.filterFlag[pageidx]
local childnum=#childNameList
for i=1,childnum do
local isSelect=childFlagList[i]or false
if not isSelect then
return false
end
end
return true
end

function UIXianJie_yzTeamDzFilterWin:selectPageAll(pageidx,isOn,ignoreIdx,isSetMask)
local pageData=self.filterName[pageidx]
local item=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
local childGrids=item:GetChildLayoutGroupGridList(1)
local childNameList=pageData[2]
local childFlagList=self.filterFlag[pageidx]
local childnum=#childNameList
for i=1,childnum do
if not ignoreIdx or i~=ignoreIdx then
childFlagList[i]=isOn

if not self.notShowPageList[pageidx]then
local childItem=childGrids[i-1]
childItem:SetChildToggle(childItemCmpIndex.toggle,isOn)
if isSetMask then
childItem:SetChildActive(childItemCmpIndex.clickMask,isOn)
else
childItem:SetChildActive(childItemCmpIndex.clickMask,false)
end
end
end
end
end




function UIXianJie_yzTeamDzFilterWin:onCliskMask()
self:closeSelf()
end



function UIXianJie_yzTeamDzFilterWin:onBtnReset()
if self.reset~=nil then
self.filterFlag=table.deepCopy(self.reset)
else
for i,v in ipairs(self.filterFlag)do
local pageData=self.filterName[i]
local isOnlySingleSelect=pageData[4]or false

for i1,v1 in ipairs(v)do
self.filterFlag[i][i1]=false
end

if isOnlySingleSelect then

self.filterFlag[i][1]=true
end
end
end
self:updateView()
end



function UIXianJie_yzTeamDzFilterWin:onBtnConfirm()
local func=self.confirmCallback
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

for i,v in ipairs(self.notShowPageList)do
if v then
self:selectPageAll(i,false)
end
end
func({filterFlag=self.filterFlag,filterName=self.filterName,attach=self.attach})
end
end
self:myClose()
end



function UIXianJie_yzTeamDzFilterWin:onCloseBtn()
self:myClose()
end

function UIXianJie_yzTeamDzFilterWin:myClose()
self:closeSelf()
end
