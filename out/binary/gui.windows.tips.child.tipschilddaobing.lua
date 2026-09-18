







def_class("tipsChildDaoBing",UICloneObject)





tipsChildDaoBing.abName="ui/windows/tips/child/tipschilddaobing.ab"

tipsChildDaoBing.assetName="tipsChildDaoBing"


function tipsChildDaoBing:bindComponents()

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


function tipsChildDaoBing:unbindComponents()
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







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildDaoBing:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_item_lock_changed,function(...)self:onItemLockChanged(...)end)
end

function tipsChildDaoBing:__delete()
self:unbindComponents()
end

function tipsChildDaoBing:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.attach_starlv=attach.starlv
self.attach_jllv=attach.jllv
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
self.isCompareTips=data.isCompareTips
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

self:fillInfo(itemid,itemguid,itemCfg,data)
end

function tipsChildDaoBing:onHide()

end




function tipsChildDaoBing:fillInfo(itemid,itemguid,itemCfg,data)
local type1=itemCfg.type1
local type2=itemCfg.type2
local equip=data



local jinglianlv=self.attach_jllv or daobingModel:getJilianLv(itemguid)
local jinglianTxt=jinglianlv>0 and FMT.cfmt2('#efb150',FMT.fmt('+{0}',jinglianlv))or''
local name=FMT.fmt('{0}{1}',itemCfg.name,jinglianTxt)


local stage=itemCfg.stage
local weaponType=equipsConfig.getWeaponConfig(type2).name
local purpose=itemCfg.purpose
local purposename=purpose==1 and'攻击'or
purpose==2 and'防御'or'辅助'

local typeName=FMT.fmt('道兵（{0}）',weaponType)
local typetxt=_descFun('类型：',typeName)


local star=self.attach_starlv or daobingModel:getStarLv(itemguid)


local fight=daobingHelper.getEquipFightByLv(itemid,star,jinglianlv)
local fightStr=_descFun('战力：',fight)



local itemCfg=itemsConfig.getConfig(itemid)
local maxStarlv=daobingConfig.getStarMaxLv(itemid)
local isMaxStar=star>=maxStarlv
local iconName=isMaxStar and iconHelper.getDaobingBigBgIcon(itemCfg.icon)or
iconHelper.getDaobingBigIcon(itemCfg.icon)

local isEquip=daobingModel:isEquipedOnAnyDizi(itemguid)


if isEquip and self.formType==TIPS_FORM_TYPE.eEquipFilter then
local diziguid=daobingModel:getDiziguidByItemguid(itemguid)
if not self.isCompareTips and not mathHelper.compareInt64(self.diziguid,diziguid)then
isEquip=false
end
end

self.widget:SetChildStarNumber(self.star:getID(),star)
self.equip:setActive(isEquip)
self.name:setText(name)
self.stage:setText(typetxt)
self.fight:setText(fightStr)
self.Icon:setImageIcon(iconName,false)


for i=1,5 do
if star>=i then
self.starnum[i]:setAnimationStringID('daobing',false)
end
end


self.lock:setActive(false)
self.unlock:setActive(false)
end

function tipsChildDaoBing:onLock()
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

return
end
self:changeLock(true)
end

function tipsChildDaoBing:onUnlock()
self:changeLock(false)
end

function tipsChildDaoBing:onItemLockChanged(itemid,itemguid,isUnlock)
if itemguid and tostring(itemguid)==tostring(self.itemguid)then


end
end

function tipsChildDaoBing:changeLock(flag)
local itemid=self.itemid
if self.diziguid then
bagProtocolControl.req_change_bag_dizi_daobing_lockflag(self.diziguid,flag)
else
bagProtocolControl.req_change_bag_item_lockflag(self.itemguid,flag)
end
end

function tipsChildDaoBing:checkShowLockImg(formType)
if formType==TIPS_FORM_TYPE.eBagGrids or formType==TIPS_FORM_TYPE.eEquipListWin or
formType==TIPS_FORM_TYPE.eEquipWin or formType==TIPS_FORM_TYPE.eLianqiGeBagItem or
formType==TIPS_FORM_TYPE.eLianqiGeItem or formType==TIPS_FORM_TYPE.eAuctionSellItem or
formType==TIPS_FORM_TYPE.eLianqiGeFabaoPreview then
return true
end
return false
end
