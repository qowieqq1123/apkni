







def_class("UILongHuDaoDanResultWin",UIWindowBase)









function UILongHuDaoDanResultWin:bindComponents()

self.bg=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.FullScreenClose=UIButton.get(self,2)
self.liandanVal=UILinkImageText.get(self,3)
self.ScrollView=UIObject.get(self,4)
self.Content=UIObject.get(self,5)
self.name=UIText.get(self,6)

self.FullScreenClose:setButtonClick(function()self:onFullScreenClose()end)



end


function UILongHuDaoDanResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.FullScreenClose);self.FullScreenClose=nil;
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.name);self.name=nil;
end



















function UILongHuDaoDanResultWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setChildScrollViewInit(0,true,nil,nil)
self.bg:setChildUIModelShowTarget(5345,1,{},eAnimationID.stand)
self.effect:setChildShowEffect(10010,true)
end


function UILongHuDaoDanResultWin:__delete()
self.ScrollView:setChildScrollViewStopGridCreate()
self:unbindComponents()
end




function UILongHuDaoDanResultWin:onShow(argtable,afterOnloaded)
self.subType=SUB_ACTIVITY_TYPE.eLongHuMountain
local otherItemList=argtable.otherItemList

local items=otherItemList
if items then
local propData={}
for i,v in ipairs(items)do
local num=v.num or 0
table.insert(propData,itemsComponentHelper.getCommonFillData(v,{showname=false,showcount=num>1,itemcount=v.num,showCountBG=num>1,showStageBg=true}))
end
local propDataCnt=#propData
if propDataCnt>0 then
self.gridAnim=true
end
self.propData=propData
local cnt=propDataCnt

self.ScrollView:setChildScrollViewDelayCreateGrids(propDataCnt,12,0.1,1,false,false,function(id,item)
if id+1>=propDataCnt then
self.gridAnim=nil
end
self:refreshItem(id,item,propData)
end)

if cnt<=12 then
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90-8,100)
self.Content:setAnchors(0.5,0.5,0.5,0.5)
end

local itemConfig=itemsConfig.getConfig(items[1].itemid)
self.name:setText(itemConfig.name)
end
end


function UILongHuDaoDanResultWin:onHide()

end

function UILongHuDaoDanResultWin:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
if id<=23 then
item:SetChildShowEffect(2,10078,true)
end
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
item:SetChildActive(3,false)
end

function UILongHuDaoDanResultWin:refreshAll()
if self.gridAnim then
if self.propData then
local cnt=#self.propData
if cnt>1 then
self.ScrollView:setChildScrollViewStopGridCreate()
self.ScrollView:setChildScrollViewCreateGrids(0,0)
self.ScrollView:setChildScrollViewCreateGrids(#self.propData,12)
local grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshItem(i-1,item,self.propData)
end

if cnt<=12 then
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90-8,100)
self.Content:setAnchors(0.5,0.5,0.5,0.5)
end
end
end
self.gridAnim=nil
end
end

function UILongHuDaoDanResultWin:onCloseWin()
if self.gridAnim then
self:refreshAll()
else
self:closeSelf()
end
end




function UILongHuDaoDanResultWin:onFullScreenClose()
end
