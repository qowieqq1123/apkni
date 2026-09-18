







def_class("tipsChildFabaoYuanPeiCiZuiAttr",UICloneObject)





tipsChildFabaoYuanPeiCiZuiAttr.abName="ui/windows/tips/child/tipschildfabaoyuanpeicizuiattr.ab"

tipsChildFabaoYuanPeiCiZuiAttr.assetName="tipsChildFabaoYuanPeiCiZuiAttr"


function tipsChildFabaoYuanPeiCiZuiAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildFabaoYuanPeiCiZuiAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildFabaoYuanPeiCiZuiAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildFabaoYuanPeiCiZuiAttr:__delete()
self:unbindComponents()
end

function tipsChildFabaoYuanPeiCiZuiAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
local cz=itemConfig.cz
local len=#cz
self.title:setText('本命词缀')
self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
local czid=cz[i]
local czcfg=cfg_disciplefabaoczconfig_get(czid)
local czname=czcfg.name
local desc=czcfg.descEx or czcfg.desc
item:SetChildText(0,FMT.fmt('【{0}】{1}',czname,desc))
end
end

function tipsChildFabaoYuanPeiCiZuiAttr:onHide()

end


