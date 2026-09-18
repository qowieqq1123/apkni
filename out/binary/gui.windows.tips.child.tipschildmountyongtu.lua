







def_class("tipsChildMountYongTu",UICloneObject)





tipsChildMountYongTu.abName="ui/windows/tips/child/tipschildmountyongtu.ab"

tipsChildMountYongTu.assetName="tipsChildMountYongTu"


function tipsChildMountYongTu:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildMountYongTu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end








function tipsChildMountYongTu:onLoaded(...)
self:bindComponents()
end

function tipsChildMountYongTu:__delete()
self:unbindComponents()
end

function tipsChildMountYongTu:onShow(args,afterOnloaded)
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
self.isCompareTips=data.isCompareTips
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

self.desc:setText(itemCfg.usage)
self.title:setText('用途')
end

function tipsChildMountYongTu:onHide()

end


