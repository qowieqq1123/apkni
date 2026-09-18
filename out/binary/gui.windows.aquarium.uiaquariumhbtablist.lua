







def_class("UIAquariumHBTabList",UIWindowBase)









function UIAquariumHBTabList:bindComponents()

self.pageScrollView=UIObject.get(self,0)



end


function UIAquariumHBTabList:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
end



















function UIAquariumHBTabList:onLoaded(...)
self:bindComponents()

self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
end

function UIAquariumHBTabList:onPageClick(num,index)
local tabType=self.tabTypes[index+1]
if not tabScreenConfig.showTabWarning(tabType)then return end

if self.pageIndex then
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,false)
widget:SetTextColor(1,Color.New(0.92,0.93,0.87))
end
self.pageIndex=index
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,true)
widget:SetTextColor(1,Color.New(0.36,0.36,0.2))

if self.click then
self.click(index+1)
end
end


function UIAquariumHBTabList:__delete()
self:clearReddotFunction()
self:unbindComponents()
end




function UIAquariumHBTabList:onShow(argtable,afterOnloaded)
self.click=argtable.click
self.reddotSubTypes=argtable.reddotSubTypes
self.tabTypes=argtable.tabTypes
self.indexs=argtable.indexs
self.tabNames=argtable.names
local index=argtable.init

self:showPage()
self:onPageClick(0,index-1)
end

function UIAquariumHBTabList:showPage()
self:clearReddotFunction()

local len=#self.tabNames
self.pageScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.pageScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildText(1,self.tabNames[i])

local isreddot=false
local reddotIndx=self.indexs[i]
local reddotSubType=self.reddotSubTypes[reddotIndx]
if reddotSubType then
isreddot=reddotClassManager.get_reddot(reddotSubType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(i,...)
end
self.reddotfuncs[reddotSubType]=func
reddotClassManager.register_event(reddotSubType,func)
end
item:SetChildActive(2,isreddot)
end
end

function UIAquariumHBTabList:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIAquariumHBTabList:refreshReddot(index,class,sub_typo,last_flag,flag)
local widget=self.pageScrollView:getChildScrollViewItemWidget(index-1)
widget:SetChildActive(2,flag)
end


function UIAquariumHBTabList:onHide()
self:clearReddotFunction()
end



