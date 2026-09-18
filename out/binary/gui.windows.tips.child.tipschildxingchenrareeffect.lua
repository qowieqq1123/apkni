







def_class("tipsChildXingChenRareEffect",UICloneObject)





tipsChildXingChenRareEffect.abName="ui/windows/tips/child/tipschildxingchenrareeffect.ab"

tipsChildXingChenRareEffect.assetName="tipsChildXingChenRareEffect"


function tipsChildXingChenRareEffect:bindComponents()

self.desc=UIText.get(self,0)
self.zhenxiPanel=UIObject.get(self,1)

end


function tipsChildXingChenRareEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.zhenxiPanel);self.zhenxiPanel=nil;
end









function tipsChildXingChenRareEffect:onLoaded(...)
self:bindComponents()
end


function tipsChildXingChenRareEffect:__delete()
self:unbindComponents()
end




function tipsChildXingChenRareEffect:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
self.itemid=itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach
local equip=equipsHelper.getEquip(itemguid)
if equip and equip.itemData.fin_rare_id~=0 then
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id,"effects_adddesc")
self.zhenxiPanel:setChildLayoutGroupCreateItems(#zxConfig)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,zxConfig[i])
end
else
self:recycleSelf()
end
end


function tipsChildXingChenRareEffect:onHide()

end


