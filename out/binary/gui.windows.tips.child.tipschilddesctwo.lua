







def_class("tipsChildDescTwo",UICloneObject)





tipsChildDescTwo.abName="ui/windows/tips/child/tipschilddesctwo.ab"

tipsChildDescTwo.assetName="tipsChildDescTwo"


function tipsChildDescTwo:bindComponents()

self.desc=UIText.get(self,0)

end


function tipsChildDescTwo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end








function tipsChildDescTwo:onLoaded(...)
self:bindComponents()
end

function tipsChildDescTwo:__delete()
self:unbindComponents()
end

function tipsChildDescTwo:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc or'描叙无配置')
end

function tipsChildDescTwo:onHide()

end


