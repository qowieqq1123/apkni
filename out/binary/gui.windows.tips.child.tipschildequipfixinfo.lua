







def_class("tipsChildEquipFixInfo",UICloneObject)





tipsChildEquipFixInfo.abName="ui/windows/tips/child/tipschildequipfixinfo.ab"

tipsChildEquipFixInfo.assetName="tipsChildEquipFixInfo"


function tipsChildEquipFixInfo:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.fight=UIText.get(self,2)
self.Icon=UIImage.get(self,3)
self.stage=UIText.get(self,4)
self.equip=UIObject.get(self,5)
self.lock=UIButton.get(self,6)
self.unlock=UIButton.get(self,7)
self.bind=UIObject.get(self,8)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

end


function tipsChildEquipFixInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.bind);self.bind=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildEquipFixInfo:onLoaded(...)
self:bindComponents()
end

function tipsChildEquipFixInfo:__delete()
self:unbindComponents()
end

function tipsChildEquipFixInfo:onShow(args,afterOnloaded)
local data=args.argtable
local itemid=data.itemid
local itemCfg=itemsConfig.getConfig(itemid)
self:fillInfo(itemid,itemCfg)
end

function tipsChildEquipFixInfo:onHide()

end





function tipsChildEquipFixInfo:fillInfo(itemid,itemCfg)
local equipType=equipsConfig.getEquipType(itemid)
self.equipType=equipType
local type2=itemCfg.type2

local suitid=itemCfg.fix[0].suitid
local suitConfig=suitid and equipsConfig.getSuitConfig(suitid)or nil
local suitName=suitConfig and FMT.fmt('[ {0} ]',suitConfig.name)or''
local name=FMT.fmt('{0} {1}',suitName,itemCfg.name)


local stage=itemCfg.stage
local isWeapon=equipType==EQUIP_TYPE.eWeapon
local weaponType=isWeapon and equipsConfig.getWeaponConfig(type2).name or''
local typeName=isWeapon and FMT.fmt('武器（{0}）',weaponType)or
equipsConfig.getEquipName(equipType)
typeName=FMT.fmt('[{0}阶]{1}',stage,typeName)
local typetxt=_descFun('类型：',typeName)


local needjingjielv=equipsConfig.getDressJingjielv(stage)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
jingjieName=FMT.fmt('{0}期',jingjieName)
local stageStr=FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,'境界：'),jingjieName)


local fight=equipsHelper.getFixEquipFight(itemid)
local fightStr=_descFun('战力：',fight)


local iconname=iconHelper.getIconName(itemid)


self.equip:setActive(false)
self.name:setText(name)
self.typename:setText(typetxt)
self.stage:setText(stageStr)
self.fight:setText(fightStr)
self.Icon:setImageIcon(iconname,false)
self.lock:setActive(false)
self.unlock:setActive(false)
self.bind:setActive(itemCfg.showNotAuction==true)
end