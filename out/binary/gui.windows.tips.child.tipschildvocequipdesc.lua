







def_class("tipsChildVocEquipDesc",UICloneObject)





tipsChildVocEquipDesc.abName="ui/windows/tips/child/tipschildvocequipdesc.ab"

tipsChildVocEquipDesc.assetName="tipsChildVocEquipDesc"


function tipsChildVocEquipDesc:bindComponents()

self.desc=UIText.get(self,0)
self.line=UIObject.get(self,1)

end


function tipsChildVocEquipDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.line);self.line=nil;
end









function tipsChildVocEquipDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildVocEquipDesc:__delete()
self:unbindComponents()
end




function tipsChildVocEquipDesc:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc or'描叙无配置')
self.line:setActive(not self:isLastItem())
end


function tipsChildVocEquipDesc:onHide()

end


