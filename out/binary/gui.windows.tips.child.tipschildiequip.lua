







def_class("tipsChildIEquip",UICloneObject)





tipsChildIEquip.abName="ui/windows/tips/child/tipschildiequip.ab"

tipsChildIEquip.assetName="tipsChildIEquip"


function tipsChildIEquip:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.fight=UIText.get(self,2)
self.Icon=UIImage.get(self,3)
self.stage=UIText.get(self,4)
self.equip=UIObject.get(self,5)
self.lock=UIButton.get(self,6)
self.unlock=UIButton.get(self,7)
self.bind=UIObject.get(self,8)
self.liandonBtn=UIButton.get(self,9)
self.liandon=UIObject.get(self,10)
self.xmimg=UIImage.get(self,11)
self.xmicons=UIObject.get(self,12)
self.xmicon1=UIImage.get(self,13)
self.xmicon2=UIImage.get(self,14)
self.xmicon3=UIImage.get(self,15)
self.xmspine=UIObject.get(self,16)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

end


function tipsChildIEquip:unbindComponents()
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
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.xmimg);self.xmimg=nil;
_UIObject_release(self.xmicons);self.xmicons=nil;
_UIObject_release(self.xmicon1);self.xmicon1=nil;
_UIObject_release(self.xmicon2);self.xmicon2=nil;
_UIObject_release(self.xmicon3);self.xmicon3=nil;
_UIObject_release(self.xmspine);self.xmspine=nil;
end













local abname="ui/windows/equip/chongzhu_atlas_pak.ab"

local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end
function tipsChildIEquip:onLoaded()
self:bindComponents()
self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self.xmiconlist={self.xmicon1,self.xmicon2,self.xmicon3}
end

function tipsChildIEquip:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
end

function tipsChildIEquip:onShow(args)
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

local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
self.isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)

self:fillInfo(itemid,itemguid,itemConfig,data)

self.xmicons:setActive(false)
self.xmspine:setActive(false)
if itemsConfig.isEquip(itemid)and self.isxmEquip and self.isxmEquip>0 then
self.xmspine:setActive(true)
local asset=""
if self.isxmEquip==EQUIP_XianMo_TYPES.eXian then
self.xmspine:setChildUIModelShowTarget(6078,1,nil,3070)
asset="image_dzzb_jinlian1"
elseif self.isxmEquip==EQUIP_XianMo_TYPES.eMo then
self.xmspine:setChildUIModelShowTarget(6078,1,nil,3071)
asset="image_dzzb_moyan1"
end
















end
end



















function tipsChildIEquip:fillInfo(itemid,itemguid,itemConfig,data)
local equipType=equipsConfig.getEquipType(itemid)
self.equipType=equipType
local type2=itemConfig.type2
local equip=equipsHelper.getEquip(itemguid)
local itemData=equip and equip.itemData or{}


local suitid=itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[ {0} ]',suitConfig.name)or''

local jinglian=equip and equip.itemData and equip.itemData.jinglianlv or 0
local jinglianTxt=jinglian>0 and FMT.fmt('+{0}',jinglian)or''
local itemName=equip and itemsModel.getNameByItem(equip)or
itemsModel.getName(itemid)
local name=suitConfig and FMT.fmt('{0} {1}{2}',suitName,itemName,jinglianTxt)or FMT.fmt('{0}{1}',itemName,jinglianTxt)


local stage=itemConfig.stage
local isWeapon=equipType==EQUIP_TYPE.eWeapon
local weaponType=isWeapon and equipsConfig.getWeaponConfig(type2).name or''
local typeName=isWeapon and FMT.fmt('武器（{0}）',weaponType)or
equipsConfig.getEquipName(equipType)
typeName=FMT.fmt('[{0}阶]{1}',stage,typeName)


local xmname=''
if self.isxmEquip and self.isxmEquip>0 then
local joblist=equipsModel.getEquipXMJobList(itemid)
local xm_name=''
for k,v in pairs(joblist)do
xm_name=cfgHelper.get2(cfg_disciplevocationconfig_get,k,"xm_name")
xmname=cfgHelper.get2(cfg_disciplevocationconfig_get,k,"name")
end
if self.isxmEquip==EQUIP_XianMo_TYPES.eXian then
typeName='仙武'or equipsConfig.getEquipName(equipType)
xmname=FMT.fmt('{0}·{1}',xmname,xm_name[1])
elseif self.isxmEquip==EQUIP_XianMo_TYPES.eMo then
typeName='魔武'or equipsConfig.getEquipName(equipType)
xmname=FMT.fmt('{0}·{1}',xmname,xm_name[2])
end
typeName=FMT.fmt('[{0}阶]{1}',stage,typeName)
end

local typetxt=_descFun('类型：',typeName)


local needjingjielv=equipsConfig.getDressJingjielv(stage)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
local enoughJingjie=true
if self.formType==TIPS_FORM_TYPE.eEquipWin or self.formType==TIPS_FORM_TYPE.eEquipListWin then
local jingjielv=self.diziguid and UIDiscipleModel:getDiscipleJJLevel(self.diziguid)or 0
enoughJingjie=jingjielv>=needjingjielv
end

if xmname and xmname~=''then
jingjieName=FMT.fmt('{0}期 {1}',jingjieName,xmname)
end
jingjieName=enoughJingjie and FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,jingjieName)or toColorStringX('#FF0000',jingjieName)
local stageStr=FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,'境界：'),jingjieName)


local fight=equipsHelper.getEquipFightX(itemid,itemguid)
local fightStr=_descFun('战力：',fight)


local iconname=equip and itemsModel.getIconName(equip)or
iconHelper.getIconName(itemid)

local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)


if isEquip and self.formType==TIPS_FORM_TYPE.eEquipFilter then
local diziguid=equipsModel.getDiziguidByItemguid(itemguid)
if not self.isCompareTips and not mathHelper.compareInt64(self.diziguid,diziguid)then
isEquip=false
end
end
self.equip:setActive(isEquip)
self.name:setText(name)
self.typename:setText(typetxt)
self.stage:setText(stageStr)
self.fight:setText(fightStr)
self.Icon:setImageIcon(iconname,false)

local showLockImg=self:checkShowLockImg(self.formType)
if showLockImg then
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

local isLock=bagUseControl.isItemInAuctionSellCd(itemguid)
self.lock:setActive(isLock)
self.unlock:setActive(false)
else
local isLock=bagHelper.isLock(equip)
self.lock:setActive(isLock)
self.unlock:setActive(not isLock)
end
else
self.lock:setActive(false)
self.unlock:setActive(false)
end


local itemflag=equip and equip.itemflag
local isBind=itemflag and mathHelper.getBitValue(itemflag,1-1)or false
self.bind:setActive(itemConfig.showNotAuction or isBind)


local isLD=liandonModel:getIsLianDonItem(itemid)
self.liandon:setActive(isLD)
end

function tipsChildIEquip:onLock()
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

return
end
self:changeLock(true)
end

function tipsChildIEquip:onUnlock()
self:changeLock(false)
end

function tipsChildIEquip:onItemLockChanged(itemid,itemguid,isUnlock)
if itemguid and tostring(itemguid)==tostring(self.itemguid)then
self.unlock:setActive(isUnlock)
self.lock:setActive(not isUnlock)
end
end

function tipsChildIEquip:changeLock(flag)
local itemid=self.itemid
local itemguid=self.itemguid
if itemsConfig.isFabao(itemid)then
local isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
if isEquip then
local diziguid=fabaoModel.getDiziguidByItemguid(itemguid)
bagProtocolControl.req_change_bag_dizi_fabao_lockflag(diziguid,flag)
return
end
elseif itemsConfig.isEquip(itemid)then
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)
if isEquip then
local diziguid=equipsModel.getDiziguidByItemguid(itemguid)
bagProtocolControl.req_change_bag_dizi_equip_lockflag(diziguid,self.equipType,flag)
return
end
end
bagProtocolControl.req_change_bag_item_lockflag(self.itemguid,flag)
end

function tipsChildIEquip:checkShowLockImg(formType)

if formType==TIPS_FORM_TYPE.eBagGrids or formType==TIPS_FORM_TYPE.eEquipListWin or
formType==TIPS_FORM_TYPE.eEquipWin or formType==TIPS_FORM_TYPE.eLianqiGeBagItem or
formType==TIPS_FORM_TYPE.eLianqiGeItem or formType==TIPS_FORM_TYPE.eAuctionSellItem or
formType==TIPS_FORM_TYPE.eLianqiGeFabaoPreview or formType==TIPS_FORM_TYPE.eBaGuaLuWin or
formType==TIPS_FORM_TYPE.eEquipFilter or formType==TIPS_FORM_TYPE.eEquipCompare then
return true
end
return false
end

function tipsChildIEquip:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByItemId(self.itemid)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end