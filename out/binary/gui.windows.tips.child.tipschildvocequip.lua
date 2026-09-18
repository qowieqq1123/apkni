







def_class("tipsChildVocEquip",UICloneObject)





tipsChildVocEquip.abName="ui/windows/tips/child/tipschildvocequip.ab"

tipsChildVocEquip.assetName="tipsChildVocEquip"


function tipsChildVocEquip:bindComponents()

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


function tipsChildVocEquip:unbindComponents()
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


function tipsChildVocEquip:onLoaded(...)
self:bindComponents()
self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self.xmiconlist={self.xmicon1,self.xmicon2,self.xmicon3}
end


function tipsChildVocEquip:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
end




function tipsChildVocEquip:onShow(args,afterOnloaded)
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
self.showEnhancelv=attach and attach.showEnhancelv

local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

self:fillInfo(itemid,itemguid,itemConfig,data)

self.xmicons:setActive(false)
self.xmspine:setActive(false)

end


function tipsChildVocEquip:onHide()

end

function tipsChildVocEquip:fillInfo(itemid,itemguid,itemConfig,data)
local equipType=equipsConfig.getEquipType(itemid)
self.equipType=equipType
local type2=itemConfig.type2
local equip=equipsHelper.getEquip(itemguid)
local itemData=equip and equip.itemData or{}



local strengthenLv=equip and equip.itemData and equip.itemData.enhancelv or 0
if self.showEnhancelv and self.showEnhancelv>0 then
strengthenLv=self.showEnhancelv
end
local strengthenLvTxt=strengthenLv>0 and FMT.fmt('+{0}',strengthenLv)or''
local itemName=equip and itemsModel.getNameByItem(equip)or
itemsModel.getName(itemid)
local name=FMT.fmt('{0}{1}',itemName,strengthenLvTxt)


local stage=itemConfig.stage
local typeName="职业装备"
local typetxt=_descFun('类型：',typeName)


local needjingjielv=equipsConfig.getDressJingjielv(stage)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
local enoughJingjie=true
if self.formType==TIPS_FORM_TYPE.eEquipWin or self.formType==TIPS_FORM_TYPE.eEquipListWin then
local jingjielv=self.diziguid and UIDiscipleModel:getDiscipleJJLevel(self.diziguid)or 0
enoughJingjie=jingjielv>=needjingjielv
end
jingjieName=FMT.fmt('{0}期',jingjieName)
jingjieName=enoughJingjie and FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,jingjieName)or toColorStringX('#FF0000',jingjieName)
local stageStr=FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,'境界：'),jingjieName)


local fight=vocEquipHelper.getEquipFightX(itemid,itemguid)
local fightStr=_descFun('战力：',fight)


local iconname=equip and itemsModel.getIconName(equip)or
iconHelper.getIconName(itemid)

local isEquip=vocEquipModel:isEquipedOnAnyDizi(itemguid)


if isEquip and self.formType==TIPS_FORM_TYPE.eEquipFilter then
local diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
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

function tipsChildVocEquip:onLock()
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

return
end
self:changeLock(true)
end

function tipsChildVocEquip:onUnlock()
self:changeLock(false)
end

function tipsChildVocEquip:onItemLockChanged(itemid,itemguid,isUnlock)
if itemguid and tostring(itemguid)==tostring(self.itemguid)then
self.unlock:setActive(isUnlock)
self.lock:setActive(not isUnlock)
end
end

function tipsChildVocEquip:changeLock(flag)
local itemid=self.itemid
local itemguid=self.itemguid
local isEquip=vocEquipModel:isEquipedOnAnyDizi(itemguid)
if isEquip then
local diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
bagProtocolControl.req_change_bag_dizi_vocequip_lockflag(diziguid,flag)
return
end
bagProtocolControl.req_change_bag_item_lockflag(self.itemguid,flag)
end

function tipsChildVocEquip:checkShowLockImg(formType)
local showLockImgFormTypeList={
[TIPS_FORM_TYPE.eBagGrids]=true,
[TIPS_FORM_TYPE.eEquipListWin]=true,
[TIPS_FORM_TYPE.eEquipWin]=true,
[TIPS_FORM_TYPE.eLianqiGeBagItem]=true,
[TIPS_FORM_TYPE.eLianqiGeItem]=true,
[TIPS_FORM_TYPE.eAuctionSellItem]=true,
[TIPS_FORM_TYPE.eLianqiGeFabaoPreview]=true,
[TIPS_FORM_TYPE.eBaGuaLuWin]=true,
[TIPS_FORM_TYPE.eEquipFilter]=true,
[TIPS_FORM_TYPE.eEquipCompare]=true,
}
if showLockImgFormTypeList[formType]then
return true
end
return false
end

function tipsChildVocEquip:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByItemId(self.itemid)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

