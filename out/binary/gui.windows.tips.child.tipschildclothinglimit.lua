







def_class("tipsChildClothingLimit",UICloneObject)





tipsChildClothingLimit.abName="ui/windows/tips/child/tipschildclothinglimit.ab"

tipsChildClothingLimit.assetName="tipsChildClothingLimit"


function tipsChildClothingLimit:bindComponents()

self.voc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildClothingLimit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.voc);self.voc=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildClothingLimit:onLoaded(...)
self:bindComponents()
end


function tipsChildClothingLimit:__delete()
self:unbindComponents()
end




function tipsChildClothingLimit:onShow(args,afterOnloaded)
local data=args.argtable
local itemid=data.itemid


local cfg=itemsConfig.getConfig(itemid)
if cfg.disciple then
self.title:setText("角色限定")

local name=cfgHelper.get(cfg_discipleconfig_get,cfg.disciple,"name")

self.voc:setText(FMT.fmt("【专属弟子：{0}】",name))
else
self.title:setText("职业限定")
local name=cfgHelper.get(cfg_disciplevocationconfig_get,cfg.type1,"name")
self.voc:setText(FMT.fmt("【{0}】",name))
end

end


function tipsChildClothingLimit:onHide()

end


