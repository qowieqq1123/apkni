







def_class("tipsChildClothing",UICloneObject)





tipsChildClothing.abName="ui/windows/tips/child/tipschildclothing.ab"

tipsChildClothing.assetName="tipsChildClothing"


function tipsChildClothing:bindComponents()

self.name=UIText.get(self,0)
self.star=UIObject.get(self,1)
self.fight=UIText.get(self,2)
self.Icon=UIImage.get(self,3)
self.stage=UIText.get(self,4)
self.equip=UIObject.get(self,5)
self.lock=UIButton.get(self,6)
self.unlock=UIButton.get(self,7)
self.starnum_1=UIObject.get(self,8)
self.starnum_2=UIObject.get(self,9)
self.starnum_3=UIObject.get(self,10)
self.starnum_4=UIObject.get(self,11)
self.starnum_5=UIObject.get(self,12)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)
self.starnum={
self.starnum_1,
self.starnum_2,
self.starnum_3,
self.starnum_4,
self.starnum_5,
}

end


function tipsChildClothing:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.starnum_1);self.starnum_1=nil;
_UIObject_release(self.starnum_2);self.starnum_2=nil;
_UIObject_release(self.starnum_3);self.starnum_3=nil;
_UIObject_release(self.starnum_4);self.starnum_4=nil;
_UIObject_release(self.starnum_5);self.starnum_5=nil;
self.starnum=nil;
end









function tipsChildClothing:onLoaded(...)
self:bindComponents()
end


function tipsChildClothing:__delete()
self:unbindComponents()
end




function tipsChildClothing:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
self.attach_starlv=attach.star
self:fillInfo(itemid,itemguid,itemCfg,data)
end

function tipsChildClothing:fillInfo(itemid,itemguid,itemCfg,data)
local type1=itemCfg.type1
local type2=itemCfg.type2
local equip=data



local name=itemCfg.name






local star=self.attach_starlv or ClothingModel:getStarLv(itemguid)


local itemCfg=itemsConfig.getConfig(itemid)
local maxStarlv=ClothingConfig.getStarMaxLv(itemid)
local isMaxStar=star>=maxStarlv


local iconName=iconHelper.getIconName(itemid)

local isEquip=ClothingModel:isEquipedOnAnyDizi(itemguid)


if isEquip and self.formType==TIPS_FORM_TYPE.eEquipFilter then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
if not self.isCompareTips and not mathHelper.compareInt64(self.diziguid,diziguid)then
isEquip=false
end
end

self.widget:SetChildStarNumber(self.star:getID(),star)
self.equip:setActive(isEquip)
self.name:setText(name)
self.Icon:setImageIcon(iconName,false)


for i=1,5 do
if star>=i then
self.starnum[i]:setAnimationStringID('daobing',false)
end
end


self.lock:setActive(false)
self.unlock:setActive(false)

local name
local cfg=itemsConfig.getConfig(itemid)
if cfg.disciple then
name=cfgHelper.get(cfg_discipleconfig_get,cfg.disciple,"name")
else
name=cfgHelper.get(cfg_disciplevocationconfig_get,cfg.type1,"name")
end
local equipData
local itemData
if itemguid then
if isEquip then
equipData=ClothingModel:getEquip(itemguid)
else
equipData=equipsHelper.getEquip(itemguid)
end
if equipData then
itemData=equipData.itemData
end
end
if itemData then
self.fight:setText(FMT.fmt("战力：{0}",ClothingHelper.getEquipFightX(itemguid)))
else
self.fight:setText(FMT.fmt("战力：{0}",ClothingHelper.getEquipFight(itemid)))
end

self.stage:setText(FMT.fmt("类型：时装（{0}）",name))
end



function tipsChildClothing:onHide()

end


