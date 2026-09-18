







def_class("UIFilterThreeWin",UIWindowBase)









function UIFilterThreeWin:bindComponents()

self.btnConfirm=UIButton.get(self,0)
self.btnReset=UIButton.get(self,1)
self.cliskMask=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.pageCreater=UIObject.get(self,4)
self.titleName=UIText.get(self,5)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIFilterThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end
















local pageItemCmpIndex={
name=0,
childCreater=1,
toggle=2,
checkMark=3,
tips=4,
}

local childItemCmpIndex={
toggle=0,
name=1,
icon=2,
bg=3,
}



function UIFilterThreeWin:onLoaded(...)
self:bindComponents()
end


function UIFilterThreeWin:__delete()
self:unbindComponents()
end




function UIFilterThreeWin:onShow(argtable,afterOnloaded)
if argtable then
self.parentWin=argtable.parentWin
self.filterName=argtable.filterName
self.filterFlag=table.deepCopy(argtable.filterFlag)
self.oldFilterFlag=table.deepCopy(argtable.filterFlag)
self.reset=argtable.reset
self.comfirmCallback=argtable.comfirmCallback
self.attach=argtable.attach

self.stackBefore=argtable.stackBefore
self.stackConfirmCallback=argtable.stackConfirmCallback


self.notShowPageList={}
local pagenum=#self.filterName
for i=1,pagenum do
local flag=self.filterName[i][1]==nil
self.notShowPageList[i]=flag
end

self:updateView()
end
end


function UIFilterThreeWin:onHide()

end

function UIFilterThreeWin:updateView()
local pagenum=#self.filterName
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIFilterThreeWin:refreshPageItem(item,pageidx)

local notShow=self.notShowPageList[pageidx]
item:SetChildActive(-1,not notShow)
if notShow then
return
end
local pageData=self.filterName[pageidx]
local pageTitle=pageData[1]
local childNameList=pageData[2]
local tipsDesc=pageData[3]
local childFlagList=self.filterFlag[pageidx]

item:SetChildText(pageItemCmpIndex.name,pageTitle)

local isShowTips=tipsDesc~=nil and tipsDesc~=""
item:SetChildActive(pageItemCmpIndex.tips,isShowTips)
if isShowTips then
item:SetChildText(pageItemCmpIndex.tips,tipsDesc)
end

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(pageItemCmpIndex.childCreater,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx)
end

self:refreshPageItemToggle(pageidx)
end

function UIFilterThreeWin:refreshPageItemToggle(pageidx)
local item=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
local selectAll=self:isSelectAll(pageidx)
item:SetChildToggleChange(pageItemCmpIndex.toggle,nil)
item:SetChildToggle(pageItemCmpIndex.toggle,selectAll)
item:SetChildActive(pageItemCmpIndex.checkMark,selectAll)
item:SetChildToggleChange(pageItemCmpIndex.toggle,function(name,isOn)
self:selectPageAll(pageidx,isOn)
item:SetChildActive(pageItemCmpIndex.checkMark,isOn)
end)
end

function UIFilterThreeWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx].name
local iconname=childNameList[idx].icon or''
local isselect=childFlagList[idx]or false
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
self:refreshPageItemToggle(pageidx)
end)
childItem:SetChildText(childItemCmpIndex.name,desc_str)
childItem:SetChildIcon(childItemCmpIndex.icon,iconname,false)
end

function UIFilterThreeWin:isSelectAll(pageidx)
local pageData=self.filterName[pageidx]
local childNameList=pageData[2]
local childFlagList=self.filterFlag[pageidx]
local childnum=#childNameList
if childnum==0 then
return false
end
for i=1,childnum do
local isSelect=childFlagList[i]or false
if not isSelect then
return false
end
end
return true
end

function UIFilterThreeWin:selectPageAll(pageidx,isOn)
local pageData=self.filterName[pageidx]
local item=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
local childGrids=item:GetChildLayoutGroupGridList(1)
local childNameList=pageData[2]
local childFlagList=self.filterFlag[pageidx]
local childnum=#childNameList
for i=1,childnum do
childFlagList[i]=isOn

if not self.notShowPageList[pageidx]then
local childItem=childGrids[i-1]
childItem:SetChildToggle(childItemCmpIndex.toggle,isOn)
end
end
end




function UIFilterThreeWin:onCliskMask()
self:closeSelf()
end



function UIFilterThreeWin:onBtnReset()
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



function UIFilterThreeWin:onBtnConfirm()
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

for i,v in ipairs(self.notShowPageList)do
if v then
self:selectPageAll(i,false)
end
end

local payload={filterFlag=self.filterFlag,filterName=self.filterName,attach=self.attach}
if self.stackBefore~=nil then
payload.stackBefore=self.stackBefore
end
local extraCb=self.stackConfirmCallback
if extraCb then
extraCb(payload)
end
func(payload)
end
end
self:myClose()
end



function UIFilterThreeWin:onCloseBtn()
self:myClose()
end


function UIFilterThreeWin:myClose()

self.parentWin:onCloseClick()
end

