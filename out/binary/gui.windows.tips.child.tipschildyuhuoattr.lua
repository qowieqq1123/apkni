







def_class("tipsChildYuHuoAttr",UICloneObject)





tipsChildYuHuoAttr.abName="ui/windows/tips/child/tipschildyuhuoattr.ab"

tipsChildYuHuoAttr.assetName="tipsChildYuHuoAttr"


function tipsChildYuHuoAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildYuHuoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYuHuoAttr:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildYuHuoAttr:__delete()
self:unbindComponents()
end




function tipsChildYuHuoAttr:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid

if not itemguid or tostring(itemguid)=='-1'then
self:recycleSelf()
return
end

self.title:setText('图鉴属性')

local itemCfg=itemsConfig.getConfig(itemid)
local hbdata=UIAquariumControl:getHandleBookData(itemCfg.bookid)
local showStar=hbdata.star~=-1 and hbdata.star or 0

local hbcfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,itemCfg.bookid)
local attrs=hbcfg.star[showStar][2]

self.scrollview:setChildScrollViewCreateGrids(#attrs,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=attrs[i]
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attr[1])
item:SetChildText(0,FMT.fmt('{0}：{1}',attrCfg.attrname,attr[2]))
end
end


function tipsChildYuHuoAttr:onHide()

end


