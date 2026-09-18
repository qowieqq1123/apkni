







def_class("UIDiscipleEquipPresetEnableTipsWin",UIWindowBase)









function UIDiscipleEquipPresetEnableTipsWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.condition=UIObject.get(self,2)
self.daobingBg=UIObject.get(self,3)
self.dressBg=UIObject.get(self,4)
self.equipBg=UIObject.get(self,5)
self.fabaoBg=UIObject.get(self,6)
self.gongfaBg=UIObject.get(self,7)
self.mountBg=UIObject.get(self,8)
self.okBtn=UIButton.get(self,9)
self.other=UIObject.get(self,10)
self.presetEquipWidget=UIObject.get(self,11)
self.replaceBtn=UIButton.get(self,12)
self.replaceFlag=UIObject.get(self,13)
self.vocEquipBg=UIObject.get(self,14)
self.yufuBg=UIObject.get(self,15)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.replaceBtn:setButtonClick(function()self:onReplaceBtn()end)



end


function UIDiscipleEquipPresetEnableTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.daobingBg);self.daobingBg=nil;
_UIObject_release(self.dressBg);self.dressBg=nil;
_UIObject_release(self.equipBg);self.equipBg=nil;
_UIObject_release(self.fabaoBg);self.fabaoBg=nil;
_UIObject_release(self.gongfaBg);self.gongfaBg=nil;
_UIObject_release(self.mountBg);self.mountBg=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.other);self.other=nil;
_UIObject_release(self.presetEquipWidget);self.presetEquipWidget=nil;
_UIObject_release(self.replaceBtn);self.replaceBtn=nil;
_UIObject_release(self.replaceFlag);self.replaceFlag=nil;
_UIObject_release(self.vocEquipBg);self.vocEquipBg=nil;
_UIObject_release(self.yufuBg);self.yufuBg=nil;
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
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local _this
local firstX=-451
local firstY=-105
local spaceX=174
local itemX=96
local spaceY=-115
local maxX=361
local panelHeight=65
local rowHeight=110

function UIDiscipleEquipPresetEnableTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleEquipPresetEnableTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleEquipPresetEnableTipsWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable[1]
self.presetIdx=argtable[2]
self.presetDataList=discipleEquipPresetController:getDiscipleEquipPreset(self.disciple_guid)or{}
self.presetIdxMax=#self.presetDataList
self.replace=false
self.replaceFlag:setActive(self.replace)
self:refreshDisciplePreset()
end

function UIDiscipleEquipPresetEnableTipsWin:calculateNextPos(itemNum)
itemNum=itemNum or 0
self.x=self.x+spaceX+itemX*itemNum
if self.x>maxX then
self.x=firstX
self.row=self.row+1
self.y=self.y+spaceY
end
end

function UIDiscipleEquipPresetEnableTipsWin:refreshDisciplePreset()
self.enableError=false
self.x=firstX
self.y=firstY
self.row=1
self.condition:setActive(false)
local presetItem=self.presetEquipWidget:getWidgetBase()
self:refreshPresetBaseEquip(presetItem)
self:refreshPresetFaBao(presetItem)
self:refreshPresetDaoBing(presetItem)
self:refreshPresetVocEquip(presetItem)
self:refreshPresetYuFu(presetItem)
self:refreshPresetMount(presetItem)
self:refreshPresetDress(presetItem)
self:refreshPresetGongFa(presetItem)

if self.enableError then
self.presetEquipWidget:setChildSizeDelta(1057,panelHeight+self.row*rowHeight)
self.condition:setActive(true)
end

self.otherUseList=discipleEquipPresetController:getDiscipleEquipPresetOtherUse(self.disciple_guid,self.presetIdx)
self:refreshOtherUsePanel()
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetGongFa(presetItem)
local hasError=false
local itemNum=-1
local gfSlot=presetItem:GetChildWidgetBase(9)
local gfID1=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa1)
if gfID1 and gfID1>0 and not ban and exist then
self.enableError=true
hasError=true
itemNum=itemNum+1

local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID1)
local gfIcon=gfCfg.icon
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,gfID1)
gfSlot:SetChildActive(-1,true)
gfSlot:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
gfSlot:SetChildImageExGray(0,true)
gfSlot:SetChildActive(1,false)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,gfCfg.name)
gfSlot:SetChildActive(4,true)
gfSlot:SetChildText(5,string.format("%d层",gflv))
gfSlot:SetChildActive(6,true)
gfSlot:SetChildActive(7,false)
gfSlot:SetChildButtonClick(-1,function()
UIManager.error("弟子境界等级不足")
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID1,tipsType=3})
end)
else
gfSlot:SetChildActive(-1,false)
end

local gfSlot=presetItem:GetChildWidgetBase(10)
local gfID2=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eGongFa2)
if gfID2 and gfID2>0 and not ban and exist then
self.enableError=true
hasError=true
itemNum=itemNum+1

local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID2)
local gfIcon=gfCfg.icon
local gflv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,gfID2)
gfSlot:SetChildActive(-1,true)
gfSlot:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
gfSlot:SetChildImageExGray(0,true)
gfSlot:SetChildActive(1,false)
gfSlot:SetChildActive(2,false)
gfSlot:SetChildText(3,gfCfg.name)
gfSlot:SetChildActive(4,true)
gfSlot:SetChildText(5,string.format("%d层",gflv))
gfSlot:SetChildActive(6,true)
gfSlot:SetChildActive(7,false)
gfSlot:SetChildButtonClick(-1,function()
UIManager.error("弟子境界等级不足")
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID2,tipsType=3})
end)
else
gfSlot:SetChildActive(-1,false)
end

self.gongfaBg:setActive(hasError)
if hasError then
self.gongfaBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos(itemNum)
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetBaseEquip(presetItem)
local hasError=false
local typeMap={
{eEquipPresetType.eEquipWeapon,0},
{eEquipPresetType.eEquipClothes,1},
{eEquipPresetType.eEquipCrown,2},
{eEquipPresetType.eEquipShoes,3},
}
local itemNum=-1
for i,v in ipairs(typeMap)do
local presetType=v[1]
local widgetIdx=v[2]
local itemSlot=presetItem:GetChildWidgetBase(widgetIdx)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,presetType)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,presetType)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,presetType)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=equipsModel.getEquip(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
itemNum=itemNum+1
end
end
self.equipBg:setActive(hasError)
if hasError then
self.equipBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos(itemNum)
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetFaBao(presetItem)
local hasError=false
local itemSlot=presetItem:GetChildWidgetBase(4)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eFaBao)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=fabaoHelper.getFabao(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
end
self.fabaoBg:setActive(hasError)
if hasError then
self.fabaoBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos()
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetDaoBing(presetItem)
local hasError=false
local itemSlot=presetItem:GetChildWidgetBase(5)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eDaoBing)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=daobingModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
end
self.daobingBg:setActive(hasError)
if hasError then
self.daobingBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos()
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetVocEquip(presetItem)
local hasError=false
local itemSlot=presetItem:GetChildWidgetBase(6)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eVocEquip)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=vocEquipModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
end
self.vocEquipBg:setActive(hasError)
if hasError then
self.vocEquipBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos()
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetYuFu(presetItem)
local hasError=false
local itemNum=-1
local yfSlot1=presetItem:GetChildWidgetBase(7)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu1)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot1,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
itemNum=itemNum+1
end

local yfSlot2=presetItem:GetChildWidgetBase(8)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eYuFu2)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot2,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
itemNum=itemNum+1
end
self.yufuBg:setActive(hasError)
if hasError then
self.yufuBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos(itemNum)
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetMount(presetItem)
local hasError=false
local itemSlot=presetItem:GetChildWidgetBase(11)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eMount)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=mountModel:getMount(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
end
self.mountBg:setActive(hasError)
if hasError then
self.mountBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos()
end
end


function UIDiscipleEquipPresetEnableTipsWin:refreshPresetDress(presetItem)
local hasError=false
local itemSlot=presetItem:GetChildWidgetBase(12)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,self.presetIdx,eEquipPresetType.eDress)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=ClothingModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,ban)
if not ban and exist then
self.enableError=true
hasError=true
end
self.dressBg:setActive(hasError)
if hasError then
self.dressBg:setChildAnchoredPos(self.x,self.y)
self:calculateNextPos()
end
end

function UIDiscipleEquipPresetEnableTipsWin:fillItem(widget,equip,ban,show)
widget:SetChildActive(-1,true)
if equip and(not ban or show)then
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
widget:SetChildActive(_itemWidgetIdx.ban,not ban)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemQualityIdx,not ban)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemIconIdx,not ban)
widget:SetChildActive(_itemWidgetIdx.exist,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetBaseItemClickEvent(-1,function(id,idx,guid,attach)
if not ban then
UIManager.error("弟子境界等级不足")
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
widget:SetChildActive(-1,false)
end
end

function UIDiscipleEquipPresetEnableTipsWin:fillRole(item,guid,switchIdx)
local netData=UIDiscipleModel:getDiscipleData(guid)
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,netData)

local jobicon=UIDiscipleModel:getJobIconNameX(guid,switchIdx)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei,true,switchIdx)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)


item:SetChildActive(6,true)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
item:SetChildText(6,UIDiscipleModel:fightValueConversion(fight))

item:SetChildText(4,'')


item:SetChildActive(8,false)
item:SetChildText(9,UIDiscipleModel:getDiscipleStateDesc(guid,' '))

item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)
item:SetChildActive(18,beibu)

item:SetChildActive(7,false)

item:SetChildActive(14,false)

item:SetChildActive(11,false)

local showOrder=false
item:SetChildActive(15,showOrder)

local func=function()
self:OnClickRoleItemCallback(guid)
end
item:SetChildButtonClick(-1,func,true)

UIDiscipleController.refreshCommonItemTianMing(item,netData)

local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
item:SetChildActive(22,isShuWUDZ)
item:SetChildText(23,isShuWUDZ and'实'or'战')
if isShuWUDZ then
local shili=UIDiscipleModel:getShuWuFightValue(guid)
item:SetChildText(6,UIDiscipleModel:fightValueConversion(shili))

end

if not chuiwei then
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injuryIcon
local injuryDesc
local icon_=eInjuryType:getIcon(injury)
if icon_~=nil then
injuryIcon='icon_fushang'
injuryDesc=FMT.fmt('<color=#FD7474>{0}</color>',eInjuryType:getName(injury))
end
local showInjury=injuryIcon~=nil
item:SetChildActive(24,showInjury)
if showInjury then
item:SetChildCSImageSprite(25,globalABLookup.global,injuryIcon)
item:SetChildText(26,injuryDesc)
end
else
item:SetChildActive(24,false)
end

local dzId=UIDiscipleModel:getDiscipleID(guid)
local isLDDZ=liandonModel:getLianDonLinkageIdByDZId(dzId)>0
item:SetChildActive(27,isLDDZ)
end


function UIDiscipleEquipPresetEnableTipsWin:OnClickRoleItemCallback(guid)
local func=function()
UIFullCommonControl:jumpDiscipleMain(guid,FULL_TAB_TYPE.eDiscipleEquip)
end
local desc="是否跳转查看该名弟子装备？"
UIDialogManager.getConfirmDialog3(self.dialog,desc,func,REPEAT_TYPE.eEquipPresetJumpDisciple)
end

function UIDiscipleEquipPresetEnableTipsWin:refreshOtherUsePanel()
local len=#self.otherUseList
self.other:setActive(len>0)
self.other:setChildLayoutGroupCreateItems(len,function(index)
local otherItem=self.other:getChildLayoutGroupGridItem(index-1)
local diziguid,itemguid,switchIdx=unpack(self.otherUseList[index])
local itemSlot=otherItem:GetChildWidgetBase(0)
local roleSlot=otherItem:GetChildWidgetBase(1)
local equip=equipsHelper.getEquip(itemguid)
self:fillItem(itemSlot,equip,true,true)
self:fillRole(roleSlot,diziguid,switchIdx)
end)
end



function UIDiscipleEquipPresetEnableTipsWin:onCancelBtn()
self:closeSelf()
end

function UIDiscipleEquipPresetEnableTipsWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleEquipPresetEnableTipsWin:onOkBtn()

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
discipleEquipPresetController:enableDiscipleEquipPreset(self.disciple_guid,self.presetIdx,self.replace)
end

function UIDiscipleEquipPresetEnableTipsWin:onReplaceBtn()
self.replace=not self.replace
self.replaceFlag:setActive(self.replace)
end