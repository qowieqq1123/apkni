







def_class("tipsChildYuHuoFeature",UICloneObject)





tipsChildYuHuoFeature.abName="ui/windows/tips/child/tipschildyuhuofeature.ab"

tipsChildYuHuoFeature.assetName="tipsChildYuHuoFeature"


function tipsChildYuHuoFeature:bindComponents()

self.scrollview=UIObject.get(self,0)
self.tips=UIText.get(self,1)
self.title=UIText.get(self,2)

end


function tipsChildYuHuoFeature:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYuHuoFeature:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function tipsChildYuHuoFeature:__delete()
self:unbindComponents()
end




function tipsChildYuHuoFeature:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid

if not itemguid or tostring(itemguid)=='-1'then
self:recycleSelf()
return
end

self.title:setText('鱼种特性')

local data=UIAquariumControl:getItemByGuid(itemguid)
local txList=data.itemData.featureList or{}
local len=#txList
self.scrollview:setChildScrollViewCreateGrids(len,3)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tx=txList[i]
local txcfg=cfgHelper.get1(cfg_fishfeatureconfig_get,tx)
item:SetChildText(1,txcfg.name)
item:SetChildButtonClick(0,function()
UIAquariumControl:showSpecialityTips(tx,item)
end)
end
self.tips:setText(len>0 and''or'该鱼没有特性')
end


function tipsChildYuHuoFeature:onHide()

end


