







def_class("UIFilterTwoWin",UIWindowBase)









function UIFilterTwoWin:bindComponents()

self.titleText=UIText.get(self,0)
self.pageCreater=UIObject.get(self,1)



end


function UIFilterTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
end

















function UIFilterTwoWin:onLoaded(...)
self:bindComponents()
end


function UIFilterTwoWin:__delete()
self:unbindComponents()
end


function UIFilterTwoWin:onHide()

end




function UIFilterTwoWin:onShow(argtable,afterOnloaded)
self.filterName=argtable.filterName
self.filterFlag=table.deepCopy(argtable.filterFlag)
self.oldFilterFlag=table.deepCopy(argtable.filterFlag)
self.reset=argtable.reset
self.comfirmCallback=argtable.comfirmCallback
self.attach=argtable.attach
local titleName=argtable.titleName
self.titleText:setText(titleName)
self:updateView()
end














































function UIFilterTwoWin:updateView()
local pagenum=#self.filterName
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIFilterTwoWin:refreshPageItem(item,pageidx)
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
self:refreshChildItem(childItem,i,childNameList,childFlagList)
end
end

function UIFilterTwoWin:refreshChildItem(childItem,idx,childNameList,childFlagList)
local data=childNameList[idx]
local desc_str=data.name
local icon=data.icon
local isselect=childFlagList[idx]or false

childItem:SetChildToggle(0,isselect)
childItem:SetChildToggleChange(0,function(name,isOn)
childFlagList[idx]=isOn
end)

childItem:SetChildText(1,desc_str)

local showIcon=icon~=nil
childItem:SetChildActive(2,showIcon)
if showIcon then
local abname=data.abname
if abname~=nil then
childItem:SetChildCSImageSprite(2,abname,icon)
else
childItem:SetChildCSImageIcon(2,icon,false)
end
end
end



function UIFilterTwoWin:onResetClick()
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

function UIFilterTwoWin:onComfirmClick()
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
self:closeSelf()
end