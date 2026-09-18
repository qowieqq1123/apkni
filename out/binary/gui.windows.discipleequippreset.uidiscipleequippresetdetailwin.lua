







def_class("UIDiscipleEquipPresetDetailWin",UIWindowBase)









function UIDiscipleEquipPresetDetailWin:bindComponents()

self.baseAttrContent=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.emptyTips=UIText.get(self,2)
self.emptyTipsBg=UIObject.get(self,3)
self.emptyTipsMask=UIButton.get(self,4)
self.leftArrow=UIButton.get(self,5)
self.otherAttrContent=UIObject.get(self,6)
self.presetEquipWidget=UIObject.get(self,7)
self.presetName=UIText.get(self,8)
self.rightArrow=UIButton.get(self,9)
self.saveBtn=UIButton.get(self,10)
self.used=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.emptyTipsMask:setButtonClick(function()self:onEmptyTipsMask()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.saveBtn:setButtonClick(function()self:onSaveBtn()end)



end


function UIDiscipleEquipPresetDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baseAttrContent);self.baseAttrContent=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
_UIObject_release(self.emptyTipsBg);self.emptyTipsBg=nil;
_UIObject_release(self.emptyTipsMask);self.emptyTipsMask=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.otherAttrContent);self.otherAttrContent=nil;
_UIObject_release(self.presetEquipWidget);self.presetEquipWidget=nil;
_UIObject_release(self.presetName);self.presetName=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.saveBtn);self.saveBtn=nil;
_UIObject_release(self.used);self.used=nil;
end



















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
xmicons=15,
xmstagetxt=16,
ban=17,
exist=18,
}
local _this
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
function UIDiscipleEquipPresetDetailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleEquipPresetDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleEquipPresetDetailWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable[1]
self.presetIdx=argtable[2]
self.presetDataList=discipleEquipPresetController:getDiscipleEquipPreset(self.disciple_guid)or{}
self.presetIdxMax=#self.presetDataList
self:refreshDisciplePreset()
end


function UIDiscipleEquipPresetDetailWin:refreshDisciplePreset()
local presetData=self.presetDataList[self.presetIdx]
local isUsed=discipleEquipPresetController:checkDiscipleEquipPresetSame(self.disciple_guid,self.presetIdx)
self.isUsed=isUsed
self.presetName:setText(string.format("方案%s：%s",mathHelper.numberToChinese(self.presetIdx),presetData.presetName))
self.used:setActive(isUsed)
self.saveBtn:setActive(not isUsed)
self.leftArrow:setActive(self.presetIdx>1)
self.rightArrow:setActive(self.presetIdx<self.presetIdxMax)
self.enableError=false

local presetItem=self.presetEquipWidget:getWidgetBase()
self:refreshPresetBaseEquip(presetItem)
self:refreshPresetGongFa(presetItem)
self:refreshPresetFaBao(presetItem)
self:refreshPresetDaoBing(presetItem)
self:refreshPresetYuFu(presetItem)
self:refreshPresetVocEquip(presetItem)
self:refreshPresetMount(presetItem)
self:refreshPresetDress(presetItem)


self:refreshPresetAttr()
end


function UIDiscipleEquipPresetDetailWin:refreshPresetGongFa(presetItem)
local gfSlot=presetItem:GetChildWidgetBase(9)
local gfID1=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
if gfID1 and gfID1>0 and not ban then
self.enableError=true
end
if gfID1 and gfID1>0 and exist then
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID1)
local gfIcon=gfCfg.icon
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,gfID1)
gfSlot:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
gfSlot:SetChildImageExGray(0,not ban)
gfSlot:SetChildActive(1,false)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,gfCfg.name)
gfSlot:SetChildActive(4,true)
gfSlot:SetChildText(5,string.format("%d层",gflv))
gfSlot:SetChildActive(6,not ban)
gfSlot:SetChildActive(7,false)
gfSlot:SetChildButtonClick(-1,function()
if not ban then
UIManager.error("弟子境界等级不足")
end
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID1,tipsType=3})
end)
else
gfSlot:SetChildIcon(0,nil,false)
gfSlot:SetChildImageExGray(0,false)
gfSlot:SetChildActive(1,true)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,"暂无功法")
gfSlot:SetChildActive(4,false)
gfSlot:SetChildText(5,"")
gfSlot:SetChildActive(6,false)
gfSlot:SetChildActive(7,not exist)
gfSlot:SetChildButtonClick(-1,function()
if not exist then
local screenPos=gfSlot:GetChildUIScreenPos(6)
self:clickNotExistItem(screenPos,self.presetIdx,eEquipPresetType.eGongFa1)
end
end)
end

local gfSlot=presetItem:GetChildWidgetBase(10)
local gfID2=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
if gfID2 and gfID2>0 and not ban then
self.enableError=true
end
if gfID2 and gfID2>0 and exist then
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID2)
local gfIcon=gfCfg.icon
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,gfID2)
gfSlot:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
gfSlot:SetChildImageExGray(0,not ban)
gfSlot:SetChildActive(1,false)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,gfCfg.name)
gfSlot:SetChildActive(4,true)
gfSlot:SetChildText(5,string.format("%d层",gflv))
gfSlot:SetChildActive(6,not ban)
gfSlot:SetChildActive(7,false)
gfSlot:SetChildButtonClick(-1,function()
if not ban then
UIManager.error("弟子境界等级不足")
end
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID2,tipsType=3})
end)
else
gfSlot:SetChildIcon(0,nil,false)
gfSlot:SetChildImageExGray(0,false)
gfSlot:SetChildActive(1,true)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,"暂无功法")
gfSlot:SetChildActive(4,false)
gfSlot:SetChildText(5,"")
gfSlot:SetChildActive(6,false)
gfSlot:SetChildActive(7,not exist)
gfSlot:SetChildButtonClick(-1,function()
if not exist then
local screenPos=gfSlot:GetChildUIScreenPos(6)
self:clickNotExistItem(screenPos,self.presetIdx,eEquipPresetType.eGongFa2)
end
end)
end
end


function UIDiscipleEquipPresetDetailWin:refreshPresetBaseEquip(presetItem)
local typeMap={
{eEquipPresetType.eEquipWeapon,0},
{eEquipPresetType.eEquipClothes,1},
{eEquipPresetType.eEquipCrown,2},
{eEquipPresetType.eEquipShoes,3},
}
for i,v in ipairs(typeMap)do
local presetType=v[1]
local widgetIdx=v[2]
local itemSlot=presetItem:GetChildWidgetBase(widgetIdx)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,presetType)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,presetType)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,presetType)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,presetType)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=equipsModel.getEquip(itemguid)
end
self:fillItem(itemSlot,equip,presetType,ban,exist,otherUse)
end
end


function UIDiscipleEquipPresetDetailWin:refreshPresetFaBao(presetItem)
local itemSlot=presetItem:GetChildWidgetBase(4)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=fabaoHelper.getFabao(itemguid)
end
self:fillItem(itemSlot,equip,eEquipPresetType.eFaBao,ban,exist,otherUse)
end


function UIDiscipleEquipPresetDetailWin:refreshPresetDaoBing(presetItem)
local itemSlot=presetItem:GetChildWidgetBase(5)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=daobingModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,eEquipPresetType.eDaoBing,ban,exist,otherUse)
end


function UIDiscipleEquipPresetDetailWin:refreshPresetVocEquip(presetItem)
local itemSlot=presetItem:GetChildWidgetBase(6)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=vocEquipModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,eEquipPresetType.eVocEquip,ban,exist,otherUse)
end


function UIDiscipleEquipPresetDetailWin:refreshPresetYuFu(presetItem)
local yfSlot1=presetItem:GetChildWidgetBase(7)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot1,equip,eEquipPresetType.eYuFu1,ban,exist,otherUse)

local yfSlot2=presetItem:GetChildWidgetBase(8)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot2,equip,eEquipPresetType.eYuFu2,ban,exist,otherUse)
end


function UIDiscipleEquipPresetDetailWin:refreshPresetMount(presetItem)
local itemSlot=presetItem:GetChildWidgetBase(11)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=mountModel:getMount(itemguid)
end
self:fillItem(itemSlot,equip,eEquipPresetType.eMount,ban,exist,otherUse)
end


function UIDiscipleEquipPresetDetailWin:refreshPresetDress(presetItem)
local itemSlot=presetItem:GetChildWidgetBase(12)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=ClothingModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,eEquipPresetType.eDress,ban,exist,otherUse)
end

function UIDiscipleEquipPresetDetailWin:fillItem(widget,equip,presetType,ban,exist,otherUse)
if(equip and not ban)or otherUse then
self.enableError=true
end
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local star=0
local reddot=false
local suitIconName=''
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
local asset=""
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
asset="image_dzzb_jinlian1"
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
asset="image_dzzb_moyan1"
end
local ninglianStar=equipsModel.getNingLianStar(equip)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
end
elseif itemsConfig.isDaoBing(itemid)then
star=daobingModel:getStarLv(itemguid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isVocEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.enhancelv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
else
iconName=iconHelper.getIconName(itemid)
end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildActive(_itemWidgetIdx.ban,not ban or otherUse)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemQualityIdx,not ban or otherUse)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemIconIdx,not ban or otherUse)
widget:SetChildActive(_itemWidgetIdx.exist,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetBaseItemClickEvent(-1,function(id,idx,guid,attach)
if not ban then
UIManager.error("弟子境界等级不足")
elseif otherUse then
UIManager.error("配装正在被其他弟子穿戴")
end
tipsManager.showTips({itemid=id,itemguid=guid})
end)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetChildActive(_itemWidgetIdx.ban,false)
widget:SetChildActive(_itemWidgetIdx.exist,not exist)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetBaseItemClickEvent(-1,function(id,idx,guid,attach)
if not exist then
local screenPos=widget:GetChildUIScreenPos(_itemWidgetIdx.ban)
self:clickNotExistItem(screenPos,self.presetIdx,presetType)
end
end)
end
end
local baseAttrTypeLookup={
[eAttributeType.eATK]=1,
[eAttributeType.eDEF]=1,
[eAttributeType.eHP]=1,
[eAttributeType.eSpeed]=1,
}
local baseAttrTypeList={
eAttributeType.eATK,
eAttributeType.eDEF,
eAttributeType.eHP,
eAttributeType.eSpeed,
}
function UIDiscipleEquipPresetDetailWin:refreshPresetAttr()
if self.isUsed then
local attrsLookup=discipleEquipPresetController:getDiscipleEquipedAttrLookup(self.disciple_guid)
local attrsList=attrListHelper.transformToList(attrsLookup)
self.baseAttrContent:setChildLayoutGroupCreateItems(#baseAttrTypeList,function(index)
local attrItem=self.baseAttrContent:getChildLayoutGroupGridItem(index-1)
local attrType=baseAttrTypeList[index]
local attrVal=attrsLookup[attrType]or 0

attrItem:SetChildText(0,helper.getAttributeName(attrType))
attrItem:SetChildText(1,helper.getAttributeStrEx(attrType,attrVal))
attrItem:SetChildActive(2,false)
attrItem:SetChildActive(3,false)
attrItem:SetChildText(4,'')
end)
self.otherAttrContent:setChildLayoutGroupCreateItems(#attrsList,function(index)
local attrItem=self.otherAttrContent:getChildLayoutGroupGridItem(index-1)
local attrs=attrsList[index]
local attrType=attrs[1]
local attrVal=attrs[2]or 0
if baseAttrTypeLookup[attrType]then
attrItem:SetChildActive(-1,false)
else
attrItem:SetChildActive(-1,true)
attrItem:SetChildText(0,helper.getAttributeName(attrType))
attrItem:SetChildText(1,helper.getAttributeStrEx(attrType,attrVal))
attrItem:SetChildActive(2,false)
attrItem:SetChildActive(3,false)
attrItem:SetChildText(4,'')
end
end)
else
local equipedAttrsLookup=discipleEquipPresetController:getDiscipleEquipedAttrLookup(self.disciple_guid)
local presetAttrsLookup=discipleEquipPresetController:getDisciplePresetAttrLookup(self.disciple_guid,self.presetIdx)
local equipedAttrsList=attrListHelper.transformToList(equipedAttrsLookup)
self.baseAttrContent:setChildLayoutGroupCreateItems(#baseAttrTypeList,function(index)
local attrItem=self.baseAttrContent:getChildLayoutGroupGridItem(index-1)
local attrType=baseAttrTypeList[index]
local attrVal=equipedAttrsLookup[attrType]or 0
local newAttrVal=presetAttrsLookup[attrType]or 0
local isUp=attrVal<newAttrVal
local isDown=attrVal>newAttrVal
local diffVal=newAttrVal-attrVal
local colorStr=isUp and"#528c2a"or"#c82c2c"
local newValStr=helper.getAttributeStrEx(attrType,newAttrVal)
local diffValStr=helper.getAttributeStrEx(attrType,diffVal)
local symbol=diffVal>=0 and"+"or""

attrItem:SetChildText(0,helper.getAttributeName(attrType))
attrItem:SetChildText(1,helper.getAttributeStrEx(attrType,attrVal))
attrItem:SetChildActive(2,isUp)
attrItem:SetChildActive(3,isDown)
attrItem:SetChildText(4,diffVal==0 and''or string.format("<color=%s>%s  (%s%s)</color>",colorStr,newValStr,symbol,diffValStr))
end)
self.otherAttrContent:setChildLayoutGroupCreateItems(#equipedAttrsList,function(index)
local attrItem=self.otherAttrContent:getChildLayoutGroupGridItem(index-1)
local attrs=equipedAttrsList[index]
local attrType=attrs[1]
local attrVal=attrs[2]or 0
local newAttrVal=presetAttrsLookup[attrType]or 0
local isUp=attrVal<newAttrVal
local isDown=attrVal>newAttrVal
local diffVal=newAttrVal-attrVal
local colorStr=isUp and"#528c2a"or"#c82c2c"
local newValStr=helper.getAttributeStrEx(attrType,newAttrVal)
local diffValStr=helper.getAttributeStrEx(attrType,diffVal)
local symbol=diffVal>=0 and"+"or""

if baseAttrTypeLookup[attrType]then
attrItem:SetChildActive(-1,false)
else
attrItem:SetChildActive(-1,true)
attrItem:SetChildText(0,helper.getAttributeName(attrType))
attrItem:SetChildText(1,helper.getAttributeStrEx(attrType,attrVal))
attrItem:SetChildActive(2,isUp)
attrItem:SetChildActive(3,isDown)
attrItem:SetChildText(4,diffVal==0 and''or string.format("<color=%s>%s  (%s%s)</color>",colorStr,newValStr,symbol,diffValStr))
end
end)
end
end

function UIDiscipleEquipPresetDetailWin:clickNotExistItem(screenPos,presetIdx,presetType)
self.emptyPresetIdx=presetIdx
self.emptyPresetType=presetType
local tips="装备已被移除，可启用配装后修改"
if presetType==eEquipPresetType.eGongFa1 or presetType==eEquipPresetType.eGongFa2 then
tips="功法已被遗忘，可启用配装后修改"
end
self.emptyTipsBg:setChildUIScreenPos(Vector2(screenPos.x,screenPos.y+25))
self.emptyTips:setText(tips)
self.emptyTipsMask:setActive(true)
self.emptyTipsBg:setActive(true)
end


function UIDiscipleEquipPresetDetailWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleEquipPresetDetailWin:onLeftArrow()
if self.presetIdx>1 then
self.presetIdx=self.presetIdx-1
self:refreshDisciplePreset()
end
end

function UIDiscipleEquipPresetDetailWin:onRightArrow()
if self.presetIdx<self.presetIdxMax then
self.presetIdx=self.presetIdx+1
self:refreshDisciplePreset()
end
end

function UIDiscipleEquipPresetDetailWin:onSaveBtn()

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if self.enableError then
self:showWindow("UIDiscipleEquipPresetEnableTipsWin",{self.disciple_guid,self.presetIdx})
else
discipleEquipPresetController:enableDiscipleEquipPreset(self.disciple_guid,self.presetIdx)
end
end

function UIDiscipleEquipPresetDetailWin:onEmptyTipsMask()
self.emptyTipsMask:setActive(false)
self.emptyTipsBg:setActive(false)
discipleEquipPresetController:setDiscipleEquipPresetEmpty(self.disciple_guid,self.emptyPresetIdx,self.emptyPresetType)
end