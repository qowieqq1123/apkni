







def_class("UIFaBaoYuanPeiTypeFilterSubWin",UIWindowBase)









function UIFaBaoYuanPeiTypeFilterSubWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.bottomLeftCorner=UIObject.get(self,1)
self.topRightCorner=UIObject.get(self,2)
self.typeScrollView=UIObject.get(self,3)
self.winArea=UIObject.get(self,4)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UIFaBaoYuanPeiTypeFilterSubWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.bottomLeftCorner);self.bottomLeftCorner=nil;
_UIObject_release(self.topRightCorner);self.topRightCorner=nil;
_UIObject_release(self.typeScrollView);self.typeScrollView=nil;
_UIObject_release(self.winArea);self.winArea=nil;
end




















function UIFaBaoYuanPeiTypeFilterSubWin:onLoaded(...)
self:bindComponents()
end


function UIFaBaoYuanPeiTypeFilterSubWin:__delete()
self:unbindComponents()
end




function UIFaBaoYuanPeiTypeFilterSubWin:onShow(argtable,afterOnloaded)
self.widgetHeight=argtable.widgetHeight
self.widgetPosition=argtable.widgetPosition
self.invokeWin=argtable.invokeWin
self.closeCallback=argtable.closeCallback
self.selectedTypeId=argtable.selectedTypeId

self.prefixTypeInfoList=argtable.prefixTypeInfoList
self.filterData=argtable.recordData
self.refreshItemCallback=argtable.refreshItemCallback

self.isModified=false


self.winArea:setChildCanvasGroupAlpha(0)

self:delayDo(0.05,function()
self:initialize()
self:delayShow()
end)
end


function UIFaBaoYuanPeiTypeFilterSubWin:onHide()

end






function UIFaBaoYuanPeiTypeFilterSubWin:initialize()
self:initializeLayoutGroupItems()
self:initializeWindowPosition()
end

function UIFaBaoYuanPeiTypeFilterSubWin:initializeLayoutGroupItems()
if self.prefixTypeInfoList==nil then

return
end

local prefixNameCount=#self.prefixTypeInfoList

local _onItemClicked=function(...)
self:onTypeScrollViewItemClicked(...)
end

self.typeScrollView:setChildScrollViewInit(0.5,true,_onItemClicked)
self.typeScrollView:setChildScrollViewCreateGrids(prefixNameCount,1)
self.scrollViewItems=self.typeScrollView:getChildScrollViewItemWidgets()

for i=1,prefixNameCount do
local item=self.scrollViewItems[i-1]
local info=self.prefixTypeInfoList[i]
item:SetChildText(0,info.prefixName)
item:SetChildGray(-1,not self:isInFilterData(info.type2Id))
end
end

function UIFaBaoYuanPeiTypeFilterSubWin:initializeWindowPosition()

local pivot=Vector2.New(0.5,1)
local offsetY=-self.widgetHeight/2


self.winArea:setChildPivot(pivot)
self.winArea:setChildPosition(self.widgetPosition)
local position=self.winArea:getChildLocalPosition()
position.y=position.y+offsetY-5

local topRightPos=self.topRightCorner:getChildLocalPosition()
local winAreaWidth=self.winArea:getChildSizeDeltaX()

local diff=(position.x+(winAreaWidth/2))-topRightPos.x

if diff>0 then
position.x=position.x-diff-30
end

self.winArea:setChildLocalPosition(position)
end



function UIFaBaoYuanPeiTypeFilterSubWin:isInFilterData(type2Id)
return table.containsValue(self.filterData,type2Id)
end


function UIFaBaoYuanPeiTypeFilterSubWin:onTypeScrollViewItemClicked(clickCount,index)
local item=self.scrollViewItems[index]
local itemIndex=index+1
local info=self.prefixTypeInfoList[itemIndex]

local existed=self:isInFilterData(info.type2Id)
item:SetChildGray(-1,existed)


if existed then
for i,v in ipairs(self.filterData)do
if v==info.type2Id then
table.remove(self.filterData,i)
end
end
else
table.insert(self.filterData,info.type2Id)
end


self.refreshItemCallback({
selectedTypeId=self.selectedTypeId,
filterData=self.filterData
})
end

function UIFaBaoYuanPeiTypeFilterSubWin:onBackBtn()
if self.closeCallback then
self.closeCallback({
selectedTypeId=self.selectedTypeId,
filterData=self.filterData
})
end
self:closeSelf()
end

function UIFaBaoYuanPeiTypeFilterSubWin:delayShow()
self.tweener1=self.winArea:setChildCanvasGroupDOFade(1,0.2)
end

function UIFaBaoYuanPeiTypeFilterSubWin:killTweener()
if self.tweener1 then
self.tweener1:Kill()
self.tweener1=nil
end
end


