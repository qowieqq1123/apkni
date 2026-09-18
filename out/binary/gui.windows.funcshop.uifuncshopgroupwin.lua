







def_class("UIFuncShopGroupWin",UIWindowBase)









function UIFuncShopGroupWin:bindComponents()

self.groupScrollView=UIObject.get(self,0)
self.Root=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)



end


function UIFuncShopGroupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.groupScrollView);self.groupScrollView=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIFuncShopGroupWin:onLoaded(...)
self:bindComponents()

local grpupClickFunc=function(...)
self:onGroupClick(...)
end
self.groupScrollView:setChildScrollViewInit(0,true,grpupClickFunc,nil)
end


function UIFuncShopGroupWin:__delete()
self:unbindComponents()
end




function UIFuncShopGroupWin:onShow(argtable,afterOnloaded)
local shopId=argtable.shopId
self.shopId=shopId
self.parentWin=argtable.parentWin

self:refreshGroup(shopId)

if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end
end


function UIFuncShopGroupWin:onHide()

end


local _Cmp_Group_Item_Index={
select=0,
name=1,
gray=2,
reddot=3,
}

function UIFuncShopGroupWin:refreshGroup(shopId)
self.groupList=funcShopModel:get_menu_group()

local groupLen=#self.groupList
local isShowGroup=groupLen>0
self.groupScrollView:setActive(isShowGroup)

if isShowGroup then
local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
for gIndex,groupCfg in ipairs(self.groupList)do
if shopCfg.shopGroup==groupCfg.id then
self.groupIndex=gIndex
end
end

self.groupScrollView:setChildScrollViewCreateGrids(groupLen,groupLen)

self.grids=self.groupScrollView:getChildScrollViewItemWidgets()
local gridLen=self.grids.Count

for gIndex=1,gridLen do
local data=self.groupList[gIndex]
local grid=self.grids[gIndex-1]
self:fillGroup(gIndex,grid,data)
end

self.groupScrollView:setChildScrollRectEnable(groupLen>6)
end

end

function UIFuncShopGroupWin:fillGroup(index,item,data)
item:SetChildText(_Cmp_Group_Item_Index.name,data.name)
item:SetChildActive(_Cmp_Group_Item_Index.select,self.groupIndex==index)
end

function UIFuncShopGroupWin:onGroupClick(_,index)
local preItem=self.grids[self.groupIndex-1]
preItem:SetChildActive(_Cmp_Group_Item_Index.select,false)

local item=self.grids[index]
item:SetChildActive(_Cmp_Group_Item_Index.select,true)
self.groupIndex=index+1

local groupData=self.groupList[self.groupIndex]
local groupId=groupData.id
local groupMenuList=funcShopModel:get_group(groupId)
local firstShopId=groupMenuList[1].shopType

if not funcShopModel:checkInit(firstShopId)then
funcShopController.send_23_1(firstShopId)
end

self.parentWin:refreshMenu(firstShopId)
self.parentWin:showShopWindow(firstShopId)
end




