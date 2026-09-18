







def_class("UIMapSwitchWin",UIWindowBase)









function UIMapSwitchWin:bindComponents()

self.scrollview=UIObject.get(self,0)



end


function UIMapSwitchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
end
















local _this




function UIMapSwitchWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UIMapSwitchWin:__delete()
self:unbindComponents()

_this=nil
end

function UIMapSwitchWin.on_item_click(clicknum,index)
local mapId=_this.datas[index+1]
local currMap=zongmenModel:getMountainId()
if mapId==currMap then
return
end
if mountainControl:loadAndswitchMapEx(mapId,true)then
_this:onCloseClick()
end
end

function UIMapSwitchWin:getMapList()
local cfgs=cfg_monijysfconfig()
local list={}
for k,v in pairs(cfgs)do
if v.map_type==1 then
table.insert(list,v.id)
end
end
return list
end




function UIMapSwitchWin:onShow(argtable,afterOnloaded)
self.datas=self:getMapList()
local mapId=zongmenModel:getMountainId()
self.scrollview:setChildScrollViewCreateGrids(#self.datas,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local id=self.datas[i+1]
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,id)
item:SetChildActive(1,id==mapId)
item:SetChildText(3,cfg.name)
end
end


function UIMapSwitchWin:onHide()

end




function UIMapSwitchWin:onCloseClick()
self:closeSelf()
end