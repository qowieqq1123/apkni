







def_class("tipsChildFabaoInfo",UICloneObject)





tipsChildFabaoInfo.abName="ui/windows/tips/child/tipschildfabaoinfo.ab"

tipsChildFabaoInfo.assetName="tipsChildFabaoInfo"


function tipsChildFabaoInfo:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.fight=UIText.get(self,2)
self.Icon=UIImage.get(self,3)
self.stage=UIText.get(self,4)
self.equip=UIObject.get(self,5)
self.lock=UIButton.get(self,6)

self.lock:setButtonClick(function()self:onLock()end)

end


function tipsChildFabaoInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.lock);self.lock=nil;
end





local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtJinglian=2,
cmpItemTxtStage=3,
}

local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end
function tipsChildFabaoInfo:onLoaded()
self:bindComponents()
end

function tipsChildFabaoInfo:__delete()
self:unbindComponents()
end

function tipsChildFabaoInfo:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local formType=data.formType
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.formType=formType
self.diziguid=attach.diziguid

local itemConfig=itemsConfig.getConfig(itemid)
if mathHelper.compareInt64(itemguid,int64.new("-1"))then
itemguid=nil
end
local isCfg=equipsHelper.isCfgEquip(itemguid)
self:fillInfo(itemid,itemguid,itemConfig,data)

local showLockImg=self:checkShowLockImg(self.formType)
if showLockImg and isCfg then

local isLock=bagUseControl.isItemInAuctionSellCd(itemguid)
self.lock:setActive(isLock)
else
self.lock:setActive(false)
end
end


function tipsChildFabaoInfo:fillInfo(itemid,itemguid,itemConfig,data)
local isCfg=itemguid==nil
local item=not isCfg and equipsHelper.getEquip(itemguid)or{}
local itemData=item.itemData or{}


local jilianlv=not isCfg and itemData and itemData.jilianlv or 0
local jinglianTxt=jilianlv>0 and FMT.fmt('+{0}',jilianlv)or''
local itemCfg=itemsConfig.getConfig(itemid)
local fabaoName=itemData.name or itemCfg.name
local name=FMT.fmt('{0}{1}',fabaoName,jinglianTxt)


local isBenMingFabao=fabaoConfig.isBenMingFabao(itemid)
local typename
local mainid
if isBenMingFabao then
mainid=fabaoHelper.getReallyMainId(item)
local type1=itemsConfig.getConfig(mainid).type1
typename=cfgHelper.get2(cfg_fabaoyuanpeitypeconfig_get,type1,'name')
else
local isXiantianFabao=fabaoConfig.isXiantianFabao(itemid)
if isXiantianFabao then
mainid=itemCfg.mainid
else
mainid=fabaoHelper.getReallyMainId(item)
end
local type2=itemsConfig.getConfig(mainid).type2
typename=cfgHelper.get2(cfg_fabaoyuanpeitypeconfig_get,type2,'name')
end
local stage=itemConfig.stage or 0
typename=typename and FMT.fmt('{0}阶法宝（{1}）',stage,typename)or FMT.fmt('{0}法宝',stage)
local typetxt=_descFun('类型：',typename)



local needjingjielv=fabaoHelper.getDressJingjielv(itemid,itemguid)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
local enoughJingjie=true
if self.formType==TIPS_FORM_TYPE.eEquipWin or self.formType==TIPS_FORM_TYPE.eEquipListWin then
local jingjielv=self.diziguid and UIDiscipleModel:getDiscipleJJLevel(self.diziguid)or 0
enoughJingjie=jingjielv>=needjingjielv
end
jingjieName=FMT.fmt('{0}期',jingjieName)
jingjieName=enoughJingjie and FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,jingjieName)or toColorStringX('#FF0000',jingjieName)
local stageStr=FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,'境界：'),jingjieName)



local fight=fabaoHelper.getBaseFight(itemid,itemguid)
local fightStr=_descFun('战力：',fight)

if isBenMingFabao then
local selfItem=fabaoBagModel:getItem(itemguid)or fabaoModel.getFabao(itemguid)
local isSelf=selfItem~=nil
if not isSelf then
fightStr=FMT.fmt("{0}<size=20>（含灵性加成）</size>",fightStr)
end
end

local itemCfg=itemsConfig.getConfig(mainid)
local icon=itemCfg.icon
if isBenMingFabao then
icon=itemCfg.fbicon
end
local iconname=iconHelper.getItemIconName(icon)

local isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)

self.equip:setActive(isEquip)
self.name:setText(name)
self.typename:setText(typetxt)
self.stage:setText(stageStr)
self.fight:setText(fightStr)
self.Icon:setImageIcon(iconname,false)
end

function tipsChildFabaoInfo:checkShowLockImg(formType)
if formType==TIPS_FORM_TYPE.eAuctionSellItem then
return true
end
return false
end