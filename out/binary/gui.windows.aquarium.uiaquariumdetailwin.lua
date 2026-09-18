







def_class("UIAquariumDetailWin",UIWindowBase)









function UIAquariumDetailWin:bindComponents()

self.attrScrollView=UIObject.get(self,0)
self.speScrollView=UIObject.get(self,1)



end


function UIAquariumDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.speScrollView);self.speScrollView=nil;
end



















function UIAquariumDetailWin:onLoaded(...)
self:bindComponents()

self.attrScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.speScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIAquariumDetailWin:__delete()
self:unbindComponents()
end

function UIAquariumDetailWin:getAttrDatas()
local attrs=UIAquariumControl:getTotalAttrData()
local list={}
for k,v in pairs(attrs)do
table.insert(list,{k,v})
end
return list
end




function UIAquariumDetailWin:onShow(argtable,afterOnloaded)
local attrs=self:getAttrDatas()
local len=#attrs
self.attrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.attrScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=attrs[i]
local cfg=cfgHelper.get1(cfg_attributesconfig_get,data[1])
item:SetChildText(0,cfg.attrname)
item:SetChildText(1,data[2])
end

local ftlist=UIAquariumControl:getAllActiveFeature(true)
len=#ftlist
self.speScrollView:setChildScrollViewCreateGrids(len,3)
grids=self.speScrollView:getChildScrollViewItemWidgets()
count=grids.Count
for i=1,count do
local item=grids[i-1]
local fId=ftlist[i]
local txcfg=cfgHelper.get1(cfg_fishfeatureconfig_get,fId)
item:SetChildText(1,txcfg.name)
item:SetChildButtonClick(0,function()
UIAquariumControl:showSpecialityTips(fId,item)
end)
end
end


function UIAquariumDetailWin:onHide()

end




function UIAquariumDetailWin:onCloseClick()
self:closeSelf()
end