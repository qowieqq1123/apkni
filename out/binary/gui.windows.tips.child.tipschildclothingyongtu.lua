







def_class("tipsChildClothingYongTu",UICloneObject)





tipsChildClothingYongTu.abName="ui/windows/tips/child/tipschildclothingyongtu.ab"

tipsChildClothingYongTu.assetName="tipsChildClothingYongTu"


function tipsChildClothingYongTu:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildClothingYongTu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function tipsChildClothingYongTu:onLoaded(...)
self:bindComponents()
end


function tipsChildClothingYongTu:__delete()
self:unbindComponents()
end




function tipsChildClothingYongTu:onShow(args,afterOnloaded)
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
end


function tipsChildClothingYongTu:onHide()

end


