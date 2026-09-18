







def_class("tipsChildLingZhenRandomAttr",UICloneObject)





tipsChildLingZhenRandomAttr.abName="ui/windows/tips/child/tipschildlingzhenrandomattr.ab"

tipsChildLingZhenRandomAttr.assetName="tipsChildLingZhenRandomAttr"


function tipsChildLingZhenRandomAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildLingZhenRandomAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildLingZhenRandomAttr:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildLingZhenRandomAttr:__delete()
self:unbindComponents()
end




function tipsChildLingZhenRandomAttr:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid

local cfg=itemsConfig.getConfig(itemid)
if cfg.type1~=6 or not itemguid or tostring(itemguid)=='-1'then
self:recycleSelf()
return
end

self.title:setText('随机属性')

local itemData=lingzhenBagModel:getItem(itemguid)
if not itemData then
itemData=UIYuFuLingZhenControl:getLingZhenKongData(itemguid)
end
local attrId=itemData.itemData.randAttrIdList
local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}


local diziAttrs=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg)
local diziAttrLength=diziAttrs~=nil and 1 or 0
local attrlength=#attrs
self.scrollview:setChildScrollViewCreateGrids(attrlength+diziAttrLength,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=attrs[i]

if attr then
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attr[1])
item:SetChildText(0,FMT.fmt('{0}：{1}',attrCfg.attrname,attr[2]))
else
local diziAttr=diziAttrs
item:SetChildText(0,diziAttr)
end
end
end


function tipsChildLingZhenRandomAttr:onHide()

end


