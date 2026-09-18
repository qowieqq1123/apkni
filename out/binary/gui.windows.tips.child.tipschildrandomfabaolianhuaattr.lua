







def_class("tipsChildRandomFabaoLianhuaAttr",UICloneObject)





tipsChildRandomFabaoLianhuaAttr.abName="ui/windows/tips/child/tipschildrandomfabaolianhuaattr.ab"

tipsChildRandomFabaoLianhuaAttr.assetName="tipsChildRandomFabaoLianhuaAttr"


function tipsChildRandomFabaoLianhuaAttr:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildRandomFabaoLianhuaAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end








function tipsChildRandomFabaoLianhuaAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildRandomFabaoLianhuaAttr:__delete()
self:unbindComponents()
end

function tipsChildRandomFabaoLianhuaAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)

self.title:setText('炼化属性')
self.desc:setText('随机属性：根据主材料和副材料类型随机生成')
end

function tipsChildRandomFabaoLianhuaAttr:onHide()

end


