







def_class("tipsChildYuHuoDesc",UICloneObject)





tipsChildYuHuoDesc.abName="ui/windows/tips/child/tipschildyuhuodesc.ab"

tipsChildYuHuoDesc.assetName="tipsChildYuHuoDesc"


function tipsChildYuHuoDesc:bindComponents()

self.desc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildYuHuoDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYuHuoDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildYuHuoDesc:__delete()
self:unbindComponents()
end




function tipsChildYuHuoDesc:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local cfg=itemsConfig.getConfig(itemid)
self.title:setText('描述')
self.desc:setText(cfg.desc)
end


function tipsChildYuHuoDesc:onHide()

end


