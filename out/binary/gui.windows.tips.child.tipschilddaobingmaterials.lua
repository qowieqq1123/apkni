







def_class("tipsChildDaoBingMaterials",UICloneObject)





tipsChildDaoBingMaterials.abName="ui/windows/tips/child/tipschilddaobingmaterials.ab"

tipsChildDaoBingMaterials.assetName="tipsChildDaoBingMaterials"


function tipsChildDaoBingMaterials:bindComponents()

self.name=UIText.get(self,0)
self.star=UIObject.get(self,1)
self.fight=UIText.get(self,2)
self.Icon=UIImage.get(self,3)
self.stage=UIText.get(self,4)
self.starnum_1=UIObject.get(self,5)
self.starnum_2=UIObject.get(self,6)
self.starnum_3=UIObject.get(self,7)
self.starnum_4=UIObject.get(self,8)
self.starnum_5=UIObject.get(self,9)
self.starnum={
self.starnum_1,
self.starnum_2,
self.starnum_3,
self.starnum_4,
self.starnum_5,
}

end


function tipsChildDaoBingMaterials:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.starnum_1);self.starnum_1=nil;
_UIObject_release(self.starnum_2);self.starnum_2=nil;
_UIObject_release(self.starnum_3);self.starnum_3=nil;
_UIObject_release(self.starnum_4);self.starnum_4=nil;
_UIObject_release(self.starnum_5);self.starnum_5=nil;
self.starnum=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildDaoBingMaterials:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterials:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterials:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid

self:fillInfo(itemid,data)
end

function tipsChildDaoBingMaterials:onHide()

end




function tipsChildDaoBingMaterials:fillInfo(oitemid,equip)

local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]

local itemCfg=itemsConfig.getConfig(itemid)

local type1=itemCfg.type1
local type2=itemCfg.type2

local name=oitemCfg.name


local weaponType=equipsConfig.getWeaponConfig(type2).name
local typeName=FMT.fmt('道兵（{0}）',weaponType)
local typetxt=_descFun('类型：',typeName)


local fight=daobingHelper.getEquipFight(itemid)
local fightStr=_descFun('战力：',fight)


local star=0


local itemCfg=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getDaobingBigIcon(itemCfg.icon)

self.widget:SetChildStarNumber(self.star:getID(),star)
self.name:setText(name)
self.stage:setText(typetxt)
self.fight:setText(fightStr)
self.Icon:setImageIcon(iconName,false)
end