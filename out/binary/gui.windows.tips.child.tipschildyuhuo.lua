







def_class("tipsChildYuHuo",UICloneObject)





tipsChildYuHuo.abName="ui/windows/tips/child/tipschildyuhuo.ab"

tipsChildYuHuo.assetName="tipsChildYuHuo"


function tipsChildYuHuo:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.lingyun=UIText.get(self,2)
self.icon=UIImage.get(self,3)

end


function tipsChildYuHuo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.lingyun);self.lingyun=nil;
_UIObject_release(self.icon);self.icon=nil;
end









function tipsChildYuHuo:onLoaded(...)
self:bindComponents()
end


function tipsChildYuHuo:__delete()
self:unbindComponents()
end

function tipsChildYuHuo:getStrWithColor(des,val)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,des),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,val))
end




function tipsChildYuHuo:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local cfg=itemsConfig.getConfig(itemid)
local data=UIAquariumControl:getItemByGuid(itemguid)
local isSPFish=data and UIAquariumControl:isOrnamentalFish(data)
local sign
if cfg.type1==6 then
sign='[摆件]'
elseif cfg.type1==5 then
sign='[灵物]'
else
sign=isSPFish and'[观赏]'or'[商品]'
end
self.name:setText(FMT.fmt('{0}{1}',sign,cfg.name))
local typeName=UIAquariumControl:getYuTypeName(cfg.type1)
self.typename:setText(self:getStrWithColor('鱼种：',typeName))
local lingyun=UIAquariumControl:countFishLingYun(data,cfg)
self.lingyun:setText(self:getStrWithColor('灵韵：',lingyun))
self.icon:setChildIcon(iconHelper.getIconName(itemid),true)
end


function tipsChildYuHuo:onHide()

end


