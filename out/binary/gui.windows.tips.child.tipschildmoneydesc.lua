







def_class("tipsChildMoneyDesc",UICloneObject)





tipsChildMoneyDesc.abName="ui/windows/tips/child/tipschildmoneydesc.ab"

tipsChildMoneyDesc.assetName="tipsChildMoneyDesc"


function tipsChildMoneyDesc:bindComponents()

self.desc=UIText.get(self,0)

end


function tipsChildMoneyDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end






function tipsChildMoneyDesc:onLoaded()
self:bindComponents()
end

function tipsChildMoneyDesc:__delete()
self:unbindComponents()
end

function tipsChildMoneyDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc)
end