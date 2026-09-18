







def_class("UIEquipWin",UIWindowBase)









function UIEquipWin:bindComponents()

self.equipslist1=UIObject.get(self,0)
self.equipslist2=UIObject.get(self,1)
self.changeBtn=UIButton.get(self,2)
self.changeBtnIcon=UIImage.get(self,3)
self.back=UIImage.get(self,4)
self.model=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.oneKey=UIButton.get(self,7)
self.lsmodel=UIObject.get(self,8)
self.oneKeyTake=UIButton.get(self,9)
self.filter=UIButton.get(self,10)
self.daobingBtn=UIButton.get(self,11)
self.equip6suo=UIObject.get(self,12)
self.specialBg5=UIObject.get(self,13)
self.changeReddot=UIObject.get(self,14)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.oneKey:setButtonClick(function()self:onOneKey()end)

self.oneKeyTake:setButtonClick(function()self:onOneKeyTake()end)

self.filter:setButtonClick(function()self:onFilter()end)

self.daobingBtn:setButtonClick(function()self:onDaobingBtn()end)



end


function UIEquipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.equipslist1);self.equipslist1=nil;
_UIObject_release(self.equipslist2);self.equipslist2=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.changeBtnIcon);self.changeBtnIcon=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.oneKey);self.oneKey=nil;
_UIObject_release(self.lsmodel);self.lsmodel=nil;
_UIObject_release(self.oneKeyTake);self.oneKeyTake=nil;
_UIObject_release(self.filter);self.filter=nil;
_UIObject_release(self.daobingBtn);self.daobingBtn=nil;
_UIObject_release(self.equip6suo);self.equip6suo=nil;
_UIObject_release(self.specialBg5);self.specialBg5=nil;
_UIObject_release(self.changeReddot);self.changeReddot=nil;
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
}
local ab='ui/windows/disciple/sharedtextures/uidisciplemainicons.ab'
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
[EQUIP_TYPE.eFabao]=4,
[EQUIP_TYPE.eDaoBing]=5,
}
local _equipTypeLookup={}
for k,v in pairs(equipSlotIndex)do
_equipTypeLookup[v]=k
end
local fuSlotIndex={
EQUIP_TYPE.eFuBao,
EQUIP_TYPE.eFuBao,
EQUIP_TYPE.eMount,
EQUIP_TYPE.eZhuZhan,
EQUIP_TYPE.eShiZhuang,
EQUIP_TYPE.eVocEquip,
}
local _this
local _equipPage=1

local _mountSlotIdx=2
local _lingshouSlotIdx=3

local _shiZhuangSlotIdx=4
local _vocEquipSlotIdx=5
local fuSlotPosList={
[4]={
[1]={-24.1,8},
[2]={282.5,8},
[3]={-24.1,-133.4},
[4]={135,-133.4},
[5]={282.5,-133.4},
},
[5]={
[1]={-24.1,8},
[2]={282.5,8},
[3]={-24.1,-133.4},
[4]={135,-133.4},
[5]={282.5,-133.4},
},
[6]={
[1]={-15,43.3},
[2]={282,43.3},
[3]={-44,-76.7},
[4]={-15,-176.7},
[5]={312,-76.7},
[6]={282,-176.7},
},
}

function UIEquipWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self.onItemLockChanged)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
self:addNotify(notifyConfig.onMountChanged,function(...)self:onMountChanged(...)end)


self.equipListWidget1=self.equipslist1:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget1:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget1:SetBaseItemChildIndex(idx,equipType)
end
self.equipListWidget2=self.equipslist2:getChildWidgetBase()
for i,equipType in ipairs(fuSlotIndex)do
local index=i-1
if equipType==EQUIP_TYPE.eZhuZhan then
self.equipListWidget2:SetBaseItemClickEvent(index,function(...)self:onLingShouItemClick(...)end)
elseif equipType==EQUIP_TYPE.eMount then
self.equipListWidget2:SetBaseItemClickEvent(index,function(...)self:onMountItemClick(...)end)
elseif equipType==EQUIP_TYPE.eShiZhuang then
self.equipListWidget2:SetBaseItemClickEvent(index,function(...)self:onShiZhuangItemClick(...)end)
elseif equipType==EQUIP_TYPE.eVocEquip then
self.equipListWidget2:SetBaseItemClickEvent(index,function(...)self:onVocEquipItemClick(...)end)
else
self.equipListWidget2:SetBaseItemClickEvent(index,function(...)self:onFuBaoItemClick(i,...)end)
end
self.equipListWidget2:SetBaseItemChildIndex(index,equipType)
end
self.page=_equipPage

end

function UIEquipWin:__delete()
_this=nil
self:unbindComponents()
self.equipListWidget1=nil
self.isRefreshingItemsReddot=nil
self.needRefreshItemsReddot=nil

notifySystem:removelistener(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self.onItemLockChanged)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
if self.fabaoReddotKey and self._onBenMingFabaoReddot then
reddotClassManager.unregister_event(self.fabaoReddotKey,self._onBenMingFabaoReddot)
end
end

function UIEquipWin.onDiscipleLingShouChange(dis_guid,changeType,ls_guid1,ls_guid2)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.diziguid)then return end

_this:rec_setup(changeType,ls_guid1,ls_guid2)
end

function UIEquipWin.onItemLockChanged(itemid,itemguid,isUnlock)
if itemsConfig.isEquip(itemid)then
local diziguid=equipsModel.getDiziguidByItemguid(itemguid)
if diziguid and tostring(diziguid)==tostring(_this.diziguid)then
local equip=equipsHelper.getEquip(itemguid)
local equipType=equipsConfig.getEquipType(itemid)
local equipSlotIdx=equipSlotIndex[equipType]
_this:fillItem(equip,equipSlotIdx)
end
elseif itemsConfig.isVocEquip(itemid)then
local diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
if diziguid and tostring(diziguid)==tostring(_this.diziguid)then
_this:fillVocEquipItem()
end
end
end

function UIEquipWin.onItemListChanged(list)
if list==nil then return end
local checkEquipReddot=false
local checkFabaoReddot=false
local checkDaoBingReddot=true
local checkFubaoReddot=false
local checkMountReddot=false
local checkShiZhuangReddot=false
local checkVocEquipReddot=false
local checkLingShouReddot=false

local isEquipFBNeedTuPo=false
local equip=equipsHelper.getEquipByDizi(_this.diziguid,EQUIP_TYPE.eFabao)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
if fabaoConfig.isBenMingFabao(itemid)then

local lxlv=fabaoModel.getLingXingLv(itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(lxlv)
isEquipFBNeedTuPo=tupocost~=nil
end

if not isEquipFBNeedTuPo then

isEquipFBNeedTuPo=fabaoHelper.isInTuPo(itemguid,itemid)
end
end

for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
if itemsConfig.isEquip(itemid)or itemsConfig.isFabao(itemid)or itemsConfig.isDaoBing(itemid)then
_this:freshByItemChanged(itemid)
if itemsConfig.isEquip(itemid)and equipsConfig.isJinglianItem(itemid)then
checkEquipReddot=true
elseif itemsConfig.isFabao(itemid)and fabaoConfig.isJilianItem(itemid)then
checkFabaoReddot=true
end
else
if isEquipFBNeedTuPo then
checkFabaoReddot=true
end

if not checkEquipReddot and equipsConfig.isJinglianItem(itemid)then
checkEquipReddot=true
elseif not checkFabaoReddot and fabaoConfig.isJilianItem(itemid)then
checkFabaoReddot=true
elseif not checkFubaoReddot and itemsConfig.isFubao(itemid)then
checkFubaoReddot=true
elseif not checkMountReddot and itemsConfig.isMount(itemid)then
checkMountReddot=true
elseif not checkShiZhuangReddot and itemsConfig.isClothing(itemid)then
checkShiZhuangReddot=true
elseif not checkVocEquipReddot and itemsConfig.isVocEquip(itemid)then
checkVocEquipReddot=true
end
end
end

if checkEquipReddot or checkFabaoReddot or checkDaoBingReddot or checkFubaoReddot then
local args={
checkEquip=checkEquipReddot,
checkFabao=checkFabaoReddot,
checkDaoBing=checkDaoBingReddot,
checkFubao=checkFubaoReddot,
checkMount=checkMountReddot,
checkShiZhuang=checkShiZhuangReddot,
checkVocEquip=checkVocEquipReddot,
checkLingShou=checkLingShouReddot,
}
_this:freshItemsReddot(args)
end
end

function UIEquipWin:onMoneyChanged(moneyType)
_this:freshItemsReddot()
end

function UIEquipWin:onMountChanged()
local dzguid=self.diziguid
local node=mountHelper.getMountNode(dzguid)
comHelper.setOutSideChildMount(dzguid,self.winlua,self.model:getID(),node,nil,0,0)
local modelParams=mountHelper.getMountModelParams(dzguid)
local offsetX=0
local offsetY=-80
if modelParams then
local model=modelParams.model
local cfg=cfg_dbbodyconfig_get(model)
local scale2=cfg.scales2 or{}
local offset=scale2[16]
if offset then
offsetX=offset[2]
offsetY=offset[3]
end
end
self.model:setChildUIModelShowTargetOffset(offsetX,offsetY)
end

function UIEquipWin:onShow(argtable,afterOnloaded)
self.diziguid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.diziguid)
local netData=UIDiscipleModel:getDiscipleData(self.diziguid)
local hasTianMing=UIDiscipleModel:checkOponTianMing(netData)
local openDaoBing=systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)
self.daobingBtn:setActive(not hasTianMing or not openDaoBing)
if argtable.subArgs and argtable.subArgs.equipPage then
self.page=argtable.subArgs.equipPage
end

self:showModel()
self:showLSModel()
self:freshEquips(true)
self:refreshPage()
self:freshBenMingFabaoReddotNotify()

self:refreshChangeBtnReddot(true)


end

function UIEquipWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIEquipWin:OnEnable()

end

function UIEquipWin:OnDisable()

end

function UIEquipWin:freshBenMingFabaoReddotNotify()
local dzguid=self.diziguid
local fabao=fabaoModel.getFabaoByDizi(dzguid)
if fabao==nil then return end
local isAbsorbExp=benMingFaBaoHelper.isAbsorbExp(dzguid)
if not isAbsorbExp then return end
local itemguid=fabao.itemguid
local oldKey=self.fabaoReddotKey
local newKey=benMingFaBaoSheetReddot.getItemKey(itemguid)
if newKey==oldKey then return end
if oldKey and self._onBenMingFabaoReddot then
reddotClassManager.unregister_event(oldKey,self._onBenMingFabaoReddot)
end
self._onBenMingFabaoReddot=function()
self:onBenMingFabaoReddot(itemguid)
end
self.fabaoReddotKey=newKey
reddotClassManager.register_event(newKey,self._onBenMingFabaoReddot)
end

function UIEquipWin:onBenMingFabaoReddot(itemguid)
local fabao=fabaoModel.getFabaoByDizi(self.diziguid)
if fabao and tostring(itemguid)==tostring(fabao.itemguid)then
self:refreshBenmingFabaoUpReddot(itemguid)
end
end

function UIEquipWin:freshEquips(isInit)
local diziguid=self.diziguid
if self.page==_equipPage then

for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
self:fillItem(equip,idx,isInit)
end
self:freshFabaoBg()
else
self:checkFuSlotPanelPos()


local fbData=UIFuLuFangModel:getFubaoData(diziguid,1)
self:fillFubaoItem(fbData,0)
fbData=UIFuLuFangModel:getFubaoData(diziguid,2)
self:fillFubaoItem(fbData,1)


self:fillMountItem()


self:fillLingShouItem()


self:fillShiZHuangItem()


self:fillVocEquipItem()
end
end

function UIEquipWin:fillItem(equip,equipSlotIdx,isInit)
local prop={}
local isEquipSlot=self.page==_equipPage
local equipType=_equipTypeLookup[equipSlotIdx]
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local widget=self.equipListWidget1:GetChildWidgetBase(equipSlotIdx)
local scaleTable={}
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
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
reddot=equipsHelper.checkEquipIsCanJingLian(itemguid)
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
xmWidget:SetChildActive(i-1,false)
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
end
elseif itemsConfig.isFubao(itemid)then
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isDaoBing(itemid)then
iconName=iconHelper.getIconName(itemid)
star=daobingModel:getStarLv(itemguid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
hasBetter=false
end
stageStr=''
reddot=daobingHelper.checkDaoBingReddot(itemguid)
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
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter or reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
else

local showAdd=false
if self.showType==dicipleType.eSystem then showAdd=true end
if equipType==EQUIP_TYPE.eDaoBing and not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
showAdd=false
end
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,showAdd and not hasBetter or false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)

if isInit and hasBetter then
scaleTable[#scaleTable+1]=widget
else
widget:SetChildScale(_itemWidgetIdx.cmpItemNew,Vector3(1,1,1))
end
end
for i,widget in ipairs(scaleTable)do
widget:SetChildDOScale(_itemWidgetIdx.cmpItemNew,1,0.5)
end
end

function UIEquipWin:checkFuSlotPanelPos()

local isOpenVocEquip=systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)
local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
local showItemCount=4
if isOpenVocEquip or isOpenLingShou then
showItemCount=6
end
local posParamList=fuSlotPosList[showItemCount]

for i,equipType in ipairs(fuSlotIndex)do
local widget=self.equipListWidget2:GetChildWidgetBase(i-1)
local isShow=false
if equipType==EQUIP_TYPE.eVocEquip then
isShow=showItemCount>=6
elseif equipType==EQUIP_TYPE.eZhuZhan then
isShow=showItemCount>=5
else
isShow=true
end

widget:SetChildActive(-1,isShow)
local posParam=posParamList[i]
if posParam and isShow then
widget:SetChildAnchoredPos(-1,posParam[1],posParam[2])
end
end
end

function UIEquipWin:fillFubaoItem(equip,equipSlotIdx)
local prop={}
local widget=self.equipListWidget2:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
if itemsConfig.isFabao(itemid)then
iconName=itemsModel.getIconName(equip)
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isFubao(itemid)then
iconName=iconHelper.getIconName(itemid)
end
widget:SetChildQulaity(_itemWidgetIdx.cmpItemQualityIdx,color)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
local showAdd=false
if self.showType==dicipleType.eSystem then showAdd=true end
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1


local fubaoList=UIFuLuFangModel.getAllFuBao(self.diziguid,{},false)
local reddot=fubaoList and#fubaoList>0

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,showAdd)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end

widget:SetChildScale(_itemWidgetIdx.cmpItemNew,Vector3(1,1,1))
end

function UIEquipWin:fillLingShouItem()
local unlock=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
local diziguid=self.diziguid
local ls_guid=UIDiscipleModel:getDZLingShou(diziguid)
local lsData=nil
if ls_guid then
lsData=lingshouModel:getLingShouData(ls_guid)
end
local equipSlotIdx=_lingshouSlotIdx
local prop={}
local widget=self.equipListWidget2:GetChildWidgetBase(equipSlotIdx)
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eZhuZhan)or false
if lsData then

local reddot=lingshouModel:checkLingShouReddot(ls_guid)

local color=lingshouModel:getColor(ls_guid)
widget:SetChildQulaity(_itemWidgetIdx.cmpItemQualityIdx,color)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,true)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)

widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,lsData.id)
widget:SetBaseItemChildGUID(-1,ls_guid)
else
local showAdd=false
if self.showType==dicipleType.eSystem then
showAdd=true
end


widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,unlock and showAdd and not hasBetter or false)


widget:SetChildActive(_itemWidgetIdx.cmpItemName,unlock)

widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,showAdd and hasBetter or false)

widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)

widget:SetChildActive(_itemWidgetIdx.cmpLock,not unlock)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
if lsData then
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_itemWidgetIdx.cmpItemIconIdx,0,eHeadCenterType.eHead,1)
end
end

function UIEquipWin:fillMountItem()
local unlock=mountHelper.isCanDressByDZ(self.diziguid)
local equipType=EQUIP_TYPE.eMount
local equipSlotIdx=_mountSlotIdx
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local widget=self.equipListWidget2:GetChildWidgetBase(equipSlotIdx)
local equip=mountModel:getMountByDZ(self.diziguid)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else

local showAdd=false
if self.showType==dicipleType.eSystem then showAdd=true end

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,unlock and showAdd and not hasBetter or false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,not unlock)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIEquipWin:fillShiZHuangItem()
local diziguid=self.diziguid
local equip=ClothingModel:getEquipByDizi(diziguid)
local equipSlotIdx=_shiZhuangSlotIdx
local prop={}
local widget=self.equipListWidget2:GetChildWidgetBase(equipSlotIdx)

local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eClothing)
if not isCan then
local config=systemConfig.getSystemConfig(SYSTEM_DEFINE.eClothing)
for i,v in ipairs(config.openargs)do
for ii,vv in ipairs(v)do
if vv[1]==SYSTEM_OPEN_TYPE.eOpenServerTime and not systemConfig.isEnoughSingleCnd(unpack(vv))then
widget:SetChildActive(-1,false)
return
end
end
end
end

if not ClothingHelper.checkDiziConfig(UIDiscipleModel:getDiscipleID(diziguid))then
widget:SetChildActive(-1,false)
return
end

widget:SetChildActive(-1,true)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(equip)

local star=equip.itemData.star

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetChildActive(10,false)
widget:SetChildStarNumber(11,star)
else
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eClothing)
local showAdd=false
if self.showType==dicipleType.eSystem then
showAdd=true
end
local isnew=false



local hasBetter=equipsReddotHelper.checkDZClothingReddot(diziguid)
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,showAdd)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,isnew)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpLock,not isOpen)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildActive(10,true)
widget:SetChildStarNumber(11,0)
end
if equip then

end
end

function UIEquipWin:fillVocEquipItem(isInit)
local isOpenVocEquip=systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)
if not isOpenVocEquip then
return
end

local slotIdx=_vocEquipSlotIdx
local equipType=EQUIP_TYPE.eVocEquip
local equip=equipsHelper.getEquipByDizi(self.diziguid,equipType)
local prop={}
local isEquipSlot=self.page==_equipPage
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local widget=self.equipListWidget2:GetChildWidgetBase(slotIdx)
local scaleTable={}
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

local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isVocEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.enhancelv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
reddot=vocEquipHelper.isCanLevelUp(itemguid)or vocEquipController:checkVocEquipZhuanHuanReddot()
end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter or reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else

local showAdd=false
if self.showType==dicipleType.eSystem then showAdd=true end
if equipType==EQUIP_TYPE.eDaoBing and not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
showAdd=false
end
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,showAdd and not hasBetter or false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)

if isInit and hasBetter then
scaleTable[#scaleTable+1]=widget
else
widget:SetChildScale(_itemWidgetIdx.cmpItemNew,Vector3(1,1,1))
end
end
for i,widget in ipairs(scaleTable)do
widget:SetChildDOScale(_itemWidgetIdx.cmpItemNew,1,0.5)
end
end

function UIEquipWin:freshItemsReddot(limitCheckList)
if self.isRefreshingItemsReddot then
self.needRefreshItemsReddot=true
self.refreshArgs=limitCheckList
return
end
self.isRefreshingItemsReddot=true

local isRefreshEquip=true
local isRefreshFabao=true
local isRefreshDaoBing=true
local isRefreshFubao=true
local isRefreshMount=true
local isRefreshShiZhuang=true
local isRefreshVocEquip=true
local isRefreshLingShou=true
if limitCheckList~=nil then
isRefreshEquip=limitCheckList.checkEquip
isRefreshFabao=limitCheckList.checkFabao
isRefreshDaoBing=limitCheckList.checkDaoBing
isRefreshFubao=limitCheckList.checkFubao
isRefreshMount=limitCheckList.checkMount
isRefreshShiZhuang=limitCheckList.checkShiZhuang
isRefreshVocEquip=limitCheckList.checkVocEquip
isRefreshLingShou=limitCheckList.checkLingShou
end

local ignoreEquipTypeList={}
if not isRefreshEquip then
ignoreEquipTypeList[EQUIP_TYPE.eWeapon]=true
ignoreEquipTypeList[EQUIP_TYPE.eClothes]=true
ignoreEquipTypeList[EQUIP_TYPE.eCap]=true
ignoreEquipTypeList[EQUIP_TYPE.eShoot]=true
end
if not isRefreshFabao then
ignoreEquipTypeList[EQUIP_TYPE.eFabao]=true
end
if not isRefreshDaoBing then
ignoreEquipTypeList[EQUIP_TYPE.eDaoBing]=true
end
if not isRefreshFubao then
ignoreEquipTypeList[EQUIP_TYPE.eFuBao]=true
end
if not isRefreshMount then
ignoreEquipTypeList[EQUIP_TYPE.eMount]=true
end

if not isRefreshShiZhuang then
ignoreEquipTypeList[EQUIP_TYPE.eShiZhuang]=true
end

if not isRefreshVocEquip then
ignoreEquipTypeList[EQUIP_TYPE.eVocEquip]=true
end

if not isRefreshLingShou then
ignoreEquipTypeList[EQUIP_TYPE.eZhuZhan]=true
end

local diziguid=self.diziguid
if self.page==_equipPage then

for equipType,idx in ipairs(equipSlotIndex)do
if not ignoreEquipTypeList[equipType]then
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
self:fillEquipItemReddot(equip,idx)
end
end
end

local freshChangeBtn=false
local fresh=not ignoreEquipTypeList[EQUIP_TYPE.eFuBao]
if fresh then

if self.page~=_equipPage then
for pos=1,2 do
local fbData=UIFuLuFangModel:getFubaoData(diziguid,pos)
self:fillFubaoItemReddot(fbData,pos-1)
end
end

freshChangeBtn=true
end

local fresh=not ignoreEquipTypeList[EQUIP_TYPE.eMount]
if fresh then
self:fillMountItemReddot()
freshChangeBtn=true
end

local fresh=not ignoreEquipTypeList[EQUIP_TYPE.eShiZhuang]
if fresh then
self:fillShiZHuangItem()
freshChangeBtn=true
end

local fresh=not ignoreEquipTypeList[EQUIP_TYPE.eVocEquip]
if fresh then
self:fillVocEquipItemReddot()
freshChangeBtn=true
end

local fresh=not ignoreEquipTypeList[EQUIP_TYPE.eZhuZhan]
if fresh then
self:fillLingShouItemReddot()
freshChangeBtn=true
end

if freshChangeBtn then
self:refreshChangeBtnReddot()
end

self.isRefreshingItemsReddot=nil
if self.needRefreshItemsReddot then
self.needRefreshItemsReddot=nil
local args=self.refreshArgs
self.refreshArgs=nil
return self:freshItemsReddot(args)
end
end

function UIEquipWin:fillEquipItemReddot(equip,equipSlotIdx)
if not equip then

return
end

local equipType=_equipTypeLookup[equipSlotIdx]
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local widget=self.equipListWidget1:GetChildWidgetBase(equipSlotIdx)

local itemid=equip.itemid
local itemguid=equip.itemguid
local reddot=false
if itemsConfig.isFabao(itemid)then
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
elseif itemsConfig.isEquip(itemid)then
reddot=equipsHelper.checkEquipIsCanJingLian(itemguid)
elseif itemsConfig.isDaoBing(itemid)then
reddot=daobingHelper.checkDaoBingReddot(itemguid)
end

widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter or reddot)
end

function UIEquipWin:fillFubaoItemReddot(fubaoData,idx)
local widget=self.equipListWidget2:GetChildWidgetBase(idx)
local reddot=false
if not fubaoData then

local fubaoList=UIFuLuFangModel.getAllFuBao(self.diziguid,{},false)
reddot=fubaoList and#fubaoList>0
end


widget:SetChildActive(_itemWidgetIdx.cmpItemNew,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
end

function UIEquipWin:fillMountItemReddot()
local widget=self.equipListWidget2:GetChildWidgetBase(_mountSlotIdx)
local unlock=mountHelper.isCanDressByDZ(self.diziguid)
local showAdd=self.showType==dicipleType.eSystem
local hasEquip=mountModel:getMountByDZ(self.diziguid)~=nil
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eMount)
local reddot=false
local new=false
local add=false
if hasEquip then
reddot=hasBetter
else
new=hasBetter
add=unlock and showAdd and not hasBetter or false
end
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,new)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,add)
end

function UIEquipWin:fillVocEquipItemReddot()
local widget=self.equipListWidget2:GetChildWidgetBase(_vocEquipSlotIdx)
local unlock=systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)
local showAdd=self.showType==dicipleType.eSystem
local hasEquip=vocEquipModel:getEquipByDizi(self.diziguid)~=nil
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eVocEquip)
local reddot=false
local new=false
local add=false
if hasEquip then
reddot=hasBetter
else
new=hasBetter
add=unlock and showAdd and not hasBetter or false
end
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,new)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,add)
end

function UIEquipWin:fillLingShouItemReddot()
local widget=self.equipListWidget2:GetChildWidgetBase(_lingshouSlotIdx)
local unlock=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
local showAdd=self.showType==dicipleType.eSystem
local hasEquip=UIDiscipleModel:getDZLingShou(self.diziguid)~=nil
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eZhuZhan)
local reddot=false
local new=false
local add=false
if hasEquip then
reddot=hasBetter
else
new=hasBetter
add=unlock and showAdd and not hasBetter or false
end
local upReddot=lingshouModel:checkLingShouReddotByDzid(self.diziguid)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot or upReddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,new)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,add)
end

function UIEquipWin:refreshBenmingFabaoUpReddot()
local dzguid=self.diziguid
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip==nil then return end
local itemid=equip.itemid
local itemguid=equip.itemguid
local equipSlotIdx=equipSlotIndex[EQUIP_TYPE.eFabao]
local widget=self.equipListWidget1:GetChildWidgetBase(equipSlotIdx)
local equipType=_equipTypeLookup[equipSlotIdx]
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local reddot=false
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
end
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter or reddot)
end


function UIEquipWin:refreshPage()
self.changeBtnIcon:setSprite(ab,'button_dzzbzhuangbeiqh_'..self.page)
self.back:setSprite(ab,'image_dizizhuangbeibgtu_'..self.page)
self.equipslist1:setActive(self.page==1)
self.equipslist2:setActive(self.page==2)
self:freshBtn()
end

function UIEquipWin:freshBtn(useCache)
local visOnekey=false
local showOneKeyTake=false
if self.showType==dicipleType.eSystem then
if self.page==1 then
local equipList=equipsHelper.getBetterEquipListBydizi(self.diziguid,true,true,useCache)
visOnekey=#equipList>0

local hasEquipedAny=equipsModel.isHasAnyEquiped(self.diziguid)
local daobing=daobingModel:getEquipByDizi(self.diziguid)
showOneKeyTake=not visOnekey and
(hasEquipedAny or daobing~=nil)or false
end
end

self.oneKey:setActive(visOnekey)
self.oneKeyTake:setActive(showOneKeyTake)
end


function UIEquipWin:OneKeyDressRet(diziguid)
if tostring(self.diziguid)~=tostring(diziguid)then return end
self.oneKey:setActive(false)
self.oneKeyTake:setActive(true)
end


function UIEquipWin:OneKeyTakeOffRet(diziguid,equipTypes)
if tostring(self.diziguid)~=tostring(diziguid)then return end
for _,equipType in ipairs(equipTypes)do
self:onChangeItem(diziguid,equipType)
self:onWeaponChanged(diziguid,equipType)
end
self:freshBtn()
end

function UIEquipWin:freshByItemChanged(itemid)
if self.page~=1 then return end
local equipType=equipsConfig.getEquipType(itemid)
local equipSlotIdx=equipSlotIndex[equipType]
local widget=self.equipListWidget1:GetChildWidgetBase(equipSlotIdx)
local hasBetter=equipsReddotHelper.getBetterReddotByDZ(self.diziguid,equipType)
local equip=equipsHelper.getEquipByDizi(self.diziguid,equipType)
local hasEquip=equip~=nil
local new=not hasEquip and hasBetter or false
local reddot=hasEquip and hasBetter or false

local showAdd=false
if self.showType==dicipleType.eSystem then showAdd=true end
if equipType==EQUIP_TYPE.eDaoBing and not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
showAdd=false
end


widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,new)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,not hasEquip and showAdd and not hasBetter)
self:freshBtn(true)
end

function UIEquipWin:freshFabaoBg()
local fabao=fabaoModel.getFabaoByDizi(self.diziguid)
local vis=false
if fabao then
vis=fabaoConfig.isBenMingFabao(fabao.itemid)
end
self.specialBg5:setActive(vis)
end

function UIEquipWin:refreshChangeBtnReddot(isInit)
local reddot=UIFuLuFangModel:checkDiscipleNeedEquipFubao(self.diziguid)or
equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eMount)or
equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eShiZhuang)or
equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eZhuZhan)or
equipsReddotHelper.getBetterReddotByDZ(self.diziguid,EQUIP_TYPE.eVocEquip)or
vocEquipController:checkVocEquipZhuanHuanReddot_diziid(self.diziguid)or
lingshouModel:checkLingShouReddotByDzid(self.diziguid)
if isInit and reddot then
self.changeReddot:setChildDOScale(1,0.5)
else
self.changeReddot:setScale(Vector3(1,1,1))
end
self.changeReddot:setActive(reddot)
end

function UIEquipWin:onChangeItem(guid,equipType)
if tostring(guid)~=tostring(self.diziguid)then return end
local diziguid=self.diziguid
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equipType==EQUIP_TYPE.eMount then
self:fillMountItem()
elseif equipType==EQUIP_TYPE.eShiZhuang then
self:fillShiZHuangItem()
else
self:fillItem(equip,equipSlotIndex[equipType])
end
self:freshBtn()
if equipType==EQUIP_TYPE.eDaoBing then
self:showModel()
end
self:refreshChangeBtnReddot()
equipListManager.closeTips()
end

function UIEquipWin:onChangeDaoBing(guid)
if tostring(guid)~=tostring(self.diziguid)then return end
local diziguid=self.diziguid
local equip=daobingModel:getEquipByDizi(diziguid)
self:fillItem(equip,equipSlotIndex[EQUIP_TYPE.eDaoBing])
self:freshBtn()
equipListManager.closeTips()
end

function UIEquipWin:onChangeFabao()
local diziguid=self.diziguid
local equip=fabaoModel.getFabaoByDizi(diziguid)
self:fillItem(equip,equipSlotIndex[EQUIP_TYPE.eFabao])
self:freshBtn()
self:freshFabaoBg()
self:freshBenMingFabaoReddotNotify()
equipListManager.closeTips()
end

function UIEquipWin:onChangeFubao(pos)
local diziguid=self.diziguid
local equip=UIFuLuFangModel:getFubaoData(diziguid,pos)
self:fillFubaoItem(equip,pos-1)
tipsManager.closeTips()
UIManager:closeWindow('UIFuBaoGainWin')
end

function UIEquipWin:onChangeLingShou()
self:fillLingShouItem()
self:showLSModel()

local args={
checkLingShou=true,
}
self:freshItemsReddot(args)
end

function UIEquipWin:onChangeMount(guid)
if tostring(guid)~=tostring(self.diziguid)then return end
self:fillMountItem()
self:freshMountModel()
self:refreshChangeBtnReddot()
equipListManager.closeTips()
end

function UIEquipWin:onChangeClothing(guid)
if tostring(guid)~=tostring(self.diziguid)then return end
local diziguid=self.diziguid

self:fillShiZHuangItem()
self:freshBtn()
equipListManager.closeTips()
end

function UIEquipWin:onChangeVocEquip(guid)
if tostring(guid)~=tostring(self.diziguid)then return end
local diziguid=self.diziguid

self:fillVocEquipItem()
self:freshBtn()
UIManager:closeWindow('UIVocEquipGainWin')
end

function UIEquipWin:onBaseItemClick(id,equipType,guid,attach)

local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if id==-1 then
if self.showType==dicipleType.eSystem then
equipListManager.showTips({movepos=TIPS_MOVE_POS.eLeft,diziguid=self.diziguid,equipType=equipType})
end
else
if self.showType==dicipleType.eSystem then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipWin,itemguid=guid,attach={diziguid=self.diziguid}})
else
tipsManager.showTips({itemid=id,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
end
end

function UIEquipWin:onClickEquipType(equipType)

local equip=equipsHelper.getEquipByDizi(self.diziguid,equipType)
local guid=-1
local itemid=-1
if equip then
itemid=equip.itemid
guid=equip.itemguid
end
self:onBaseItemClick(itemid,equipType,guid,nil)
end

function UIEquipWin:onFuBaoItemClick(index,id,equipType,guid,attach)
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if self.showType==dicipleType.eSystem then
if id>0 then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipWin,itemid=id,itemguid=guid,attach={diziguid=self.diziguid,pos=index}})
else
UIManager:showWindow('UIFuBaoGainWin',{diziguid=self.diziguid,pos=index})
end
else
if id>0 then
tipsManager.showTips({itemid=id,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
end
end

function UIEquipWin:onLingShouItemClick(id,equipType,guid,attach)
if not systemModel.isOpen(SYSTEM_DEFINE.eLingShou)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eLingShou)
UIManager.info(str)
return
end

local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if self.showType==dicipleType.eSystem then
if id>0 then
local fromType=TIPS_FORM_TYPE.eEquipWin
UIManager:showWindow('UILingShouTipsWin',{dzOwner=self.diziguid,ls_guid=guid,fromType=fromType})
else
UIManager:showWindow('UILingShouSetupWin',{dis_guid=self.diziguid})
end
else
if id>0 then

end
end
end

function UIEquipWin:onMountItemClick(id,equipType,guid,attach)

if not mountHelper.isCanDressByDZ(self.diziguid,true)then return end
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if id==-1 then
if self.showType==dicipleType.eSystem then
equipListManager.showTips({movepos=TIPS_MOVE_POS.eLeft,diziguid=self.diziguid,equipType=equipType})
end
else
if self.showType==dicipleType.eSystem then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipWin,itemguid=guid,attach={diziguid=self.diziguid}})
else
tipsManager.showTips({itemid=id,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
end
end

function UIEquipWin:showModel()
local dzguid=self.diziguid
self.model:setChildUIModelRemoveTarget()
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1,args)

modelParams.anim=mountHelper.getMountAni(dzguid,modelParams.anim)
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
self:onMountChanged()

self:initAnimationList()
end

function UIEquipWin:freshMountModel()
local dzguid=self.diziguid
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1,args)
modelParams.anim=mountHelper.getMountAni(dzguid,modelParams.anim)
self:onMountChanged()
self:setChildModelAnimationState(self.model:getID(),modelParams.anim,1,nil)
end

function UIEquipWin:showLSModel()
local ls_guid=UIDiscipleModel:getDZLingShou(self.diziguid)
if ls_guid==nil then
self.lsmodel:setChildUIModelRemoveTarget()
else
local lsData=lingshouModel:getLingShouData(ls_guid)
local modelParams=lingshouModel.getModelParamsEx(lsData.cfg.model)
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'scales')
local scale=scaleArgs and scaleArgs[2]or 1
self.lsmodel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)
end
end



function UIEquipWin:onChangeBtn()
self.page=self.page==1 and 2 or 1
self:refreshPage()
self:freshEquips()
end

function UIEquipWin:onOneKey()
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
local equipList=equipsHelper.getBetterEquipListBydizi(self.diziguid,true,true)
if#equipList>0 then
equipsProtocolControl.req_equip_dress_onekey(self.diziguid,equipList)
end
end


function UIEquipWin:onOneKeyTake()
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
local equips=equipsModel.getAllEquipsByDizi(self.diziguid)or{}
local daobing=daobingModel:getEquipByDizi(self.diziguid)or{}
local list={}
for k,v in pairs(equips)do
list[#list+1]=v.itemguid
end
if daobing then
list[#list+1]=daobing.itemguid
end
if#list>0 then
equipsProtocolControl.req_equip_take_off_onekey(self.diziguid)
end
end

function UIEquipWin:onFilter()
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
UIManager:showWindow('UIEquipFilterWin',{dzguid=self.diziguid})
end

function UIEquipWin:onDaobingBtn()
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
local openDaoBing=systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)
if not openDaoBing then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eDaoBing)
UIManager.error(tips)
return
end
UIManager.error('有天命的弟子才可以穿戴道兵')
end


function UIEquipWin:onWeaponChanged(diziguid,equipType)
if tostring(diziguid)~=tostring(self.diziguid)or equipType~=EQUIP_TYPE.eWeapon then return end
self:showModel()
end

function UIEquipWin:initAnimationList()
self.animationList={0,21,10,11,20}
self.cur_anim=1
local f=false
local weaponID=UIDiscipleModel:getDiscipleShowWeaponID(self.diziguid,true)
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg then
local attactAction=cfgHelper.get2(cfg_discipleweaponconfig_get,equipCfg.type2,'attactAction')
for i,v in ipairs(attactAction)do
table.insert(self.animationList,v)
end
f=true
end
end
if not f then
table.insert(self.animationList,1000)
table.insert(self.animationList,1001)
end
end


function UIEquipWin:onTestAnimation()
self.cur_anim=self.cur_anim+1
if self.cur_anim>#self.animationList then
self.cur_anim=1
end
self.model:setChildModelAnimationState(self.animationList[self.cur_anim])
end

function UIEquipWin:rec_setup(changeType,ls1,ls2)
self:onChangeLingShou()
end

function UIEquipWin:onShiZhuangItemClick(id,equipType,guid,attach)
if not systemModel.isOpen(SYSTEM_DEFINE.eClothing)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eClothing)
UIManager.info(str)
return
end
local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
oneTabScreenController:openUI(SEC_FULL_TYPE.discipleClothing,{guid=self.diziguid,sortType=eDiscipleSortType.eClothing,checkClothing=true})
end

function UIEquipWin:onVocEquipItemClick(id,equipType,guid,attach)
if not systemModel.isOpen(SYSTEM_DEFINE.eVocEquip)then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eVocEquip)
UIManager.info(str)
return
end

local isLDLock=UIDiscipleModel:checkDZClientState(self.diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if id==-1 then
if self.showType==dicipleType.eSystem then
UIManager:showWindow('UIVocEquipGainWin',{diziguid=self.diziguid})
end
else
if self.showType==dicipleType.eSystem then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipWin,itemguid=guid,attach={diziguid=self.diziguid}})
else
tipsManager.showTips({itemid=id,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
end
end
