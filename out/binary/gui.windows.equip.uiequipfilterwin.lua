







def_class("UIEquipFilterWin",UIWindowBase)









function UIEquipFilterWin:bindComponents()

self.root=UIObject.get(self,0)
self.sortPanel=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.midPanel=UIObject.get(self,3)
self.leftPanel=UIObject.get(self,4)
self.sortBgBtn=UIButton.get(self,5)
self.sortScrollView=UIScrollView.get(self,6)
self.discipleList=UIScrollView.get(self,7)
self.listPanel=UIObject.get(self,8)
self.filterPanel=UIObject.get(self,9)
self.dressToggle=UIToggleButton.get(self,10)
self.equipslist=UIObject.get(self,11)
self.lsmodel=UIObject.get(self,12)
self.attrPanel=UIObject.get(self,13)
self.oneKeyTake=UIButton.get(self,14)
self.temptitle=UIText.get(self,15)
self.suitDropdown=UIDropdownEx.get(self,16)
self.Dropdown1=UIButton.get(self,17)
self.Dropdown2=UIButton.get(self,18)
self.dressToggleText=UIText.get(self,19)
self.bagScrollView=UILoopListView.new(self,20)
self.suitLabel=UIText.get(self,21)
self.suitBtnBText=UIText.get(self,22)
self.suitBtnAText=UIText.get(self,23)
self.suitBtnA=UIButton.get(self,24)
self.suitBtnB=UIButton.get(self,25)
self.suitDes=UIText.get(self,26)
self.suitDes2=UIText.get(self,27)
self.bagContent=UIObject.get(self,28)
self.sortContent=UIObject.get(self,29)
self.cizhuiCreater=UIObject.get(self,30)
self.equipAttrCreater=UIObject.get(self,31)
self.Item_Label=UIText.get(self,32)
self.Dropdown3=UIButton.get(self,33)
self.Dropdown4=UIButton.get(self,34)
self.suiticon=UIObject.get(self,35)

self.sortBgBtn:setButtonClick(function()self:onSortBgBtn()end)

self.oneKeyTake:setButtonClick(function()self:onOneKeyTake()end)

self.Dropdown1:setButtonClick(function()self:onDropdown1()end)

self.Dropdown2:setButtonClick(function()self:onDropdown2()end)

self.bagScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.suitBtnA:setButtonClick(function()self:onSuitBtnA()end)

self.suitBtnB:setButtonClick(function()self:onSuitBtnB()end)

self.Dropdown3:setButtonClick(function()self:onDropdown3()end)

self.Dropdown4:setButtonClick(function()self:onDropdown4()end)



end


function UIEquipFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortPanel);self.sortPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.midPanel);self.midPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.sortBgBtn);self.sortBgBtn=nil;
_UIObject_release(self.sortScrollView);self.sortScrollView=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.listPanel);self.listPanel=nil;
_UIObject_release(self.filterPanel);self.filterPanel=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.lsmodel);self.lsmodel=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.oneKeyTake);self.oneKeyTake=nil;
_UIObject_release(self.temptitle);self.temptitle=nil;
_UIObject_release(self.suitDropdown);self.suitDropdown=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
self.bagScrollView:deleteSelf();self.bagScrollView=nil;
_UIObject_release(self.suitLabel);self.suitLabel=nil;
_UIObject_release(self.suitBtnBText);self.suitBtnBText=nil;
_UIObject_release(self.suitBtnAText);self.suitBtnAText=nil;
_UIObject_release(self.suitBtnA);self.suitBtnA=nil;
_UIObject_release(self.suitBtnB);self.suitBtnB=nil;
_UIObject_release(self.suitDes);self.suitDes=nil;
_UIObject_release(self.suitDes2);self.suitDes2=nil;
_UIObject_release(self.bagContent);self.bagContent=nil;
_UIObject_release(self.sortContent);self.sortContent=nil;
_UIObject_release(self.cizhuiCreater);self.cizhuiCreater=nil;
_UIObject_release(self.equipAttrCreater);self.equipAttrCreater=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
_UIObject_release(self.Dropdown3);self.Dropdown3=nil;
_UIObject_release(self.Dropdown4);self.Dropdown4=nil;
_UIObject_release(self.suiticon);self.suiticon=nil;
end

















local _equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
}
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local _equipTypeLookup={}
for k,v in pairs(_equipSlotIndex)do
_equipTypeLookup[v]=k
end

local _sortType=
{
eJingLianLevel=1,
eStage=2,
eAttr=3,
}

local _attrCfg=
{
{id=eAttributeType.eATK,desc='攻击'},
{id=eAttributeType.eDEF,desc='防御'},
{id=eAttributeType.eHP,desc='生命'},
{id=eAttributeType.eSpeed,desc='速度'},
{id=eAttributeType.eATK_PCT,desc='攻击率'},
{id=eAttributeType.eDEF_PCT,desc='防御率'},
{id=eAttributeType.eHP_PCT,desc='生命率'},
{id=eAttributeType.eCritical_rate,desc='暴击率'},
{id=eAttributeType.eCritical_MOD,desc='暴击伤害率'},
{id=eAttributeType.eCritical_DEF,desc='抗暴率'},
{id=eAttributeType.eCritical_DEF_MOD,desc='暴击减伤率'},
{id=eAttributeType.eOut_ATK_DEF,desc='物伤减免率'},
{id=eAttributeType.eIn_ATK_DEF,desc='法伤减免率'},
{id=eAttributeType.eBuff_hit,desc='效果命中'},
{id=eAttributeType.eBuff_dodge,desc='效果抵抗'},
{desc='所有'},
}

local _showAttrCfg={}
local _attrNameLookup={}
for i,v in ipairs(_attrCfg)do
v.sortType=_sortType.eAttr
if v.id then
_showAttrCfg[#_showAttrCfg+1]=v.id
_attrNameLookup[v.id]=v.desc
end
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
cmpSelect=12,
cmpBottomName=13,
cmpSuitIcon=14,
xmicons=15,
xmstagetxt=16,
}
local _sortMenuType=
{
eSort1=1,
eSort2=2,
eSort3=3,
eSort4=4,
}
local _dropItemHeight=150
local _dropViewHeight=506

function UIEquipFilterWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onDiscipleRemove,function(...)self:onDiscipleRemove(...)end)
self:addNotify(notifyConfig.onDiscipleRemove,function(...)self:onDiscipleRemove(...)end)

self.suitDropdown:setChangeAction(function(...)self:onDropdownSuitChange(...)end)
self.suitDropdown:setDropdownCreatedAction(function(...)self:onDropdownSuitCreated(...)end)
self.suitDropdown:setDropdownLayoutedAction(function(...)self:onDropdownLayouted(...)end)

self.defaultEquipType=EQUIP_TYPE.eWeapon

self.suitBtns={self.suitBtnA,self.suitBtnB}
self.suitBtnTexts={self.suitBtnAText,self.suitBtnBText}



local getSuitFilterCfg=function(cfgs)
local list={}
list[#list+1]={name='所有',desc='显示拥有的所有装备'}
for _,cfg in ipairs(cfgs)do
local name=FMT.fmt('<color=#ca631d>[2件套]</color>{0}\n<color=#ca631d>[3件套]</color>{1}',cfg.attr2desc,cfg.attr3desc)
list[#list+1]={desc=name,name=cfg.name,bg=true,cfg=cfg}
end
return list
end

local suitConfig=self:getFilterSuit()
self.filterCfg=getSuitFilterCfg(suitConfig)


self.sortCfg={}
local sortCfg=self.sortCfg
local icfg={sortType=_sortType.eJingLianLevel,desc='等级'}
sortCfg[#sortCfg+1]=icfg
self.jinglianlvSortCfg=icfg

local icfg={sortType=_sortType.eStage,desc='阶数'}
sortCfg[#sortCfg+1]=icfg
self.stageSortCfg=icfg

for i,v in ipairs(_attrCfg)do
sortCfg[#sortCfg+1]=v
end


local equipListWidget=self.equipslist:getChildWidgetBase()
self.equipListWidget=equipListWidget
for equipType,idx in ipairs(_equipSlotIndex)do
equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
self.sortBgBtn:setActive(false)
self.isToggleDress=true
self:freshToggle()
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.dressToggleText:setText('显示已穿戴')

self.sortScrollView:setClickAction(function(...)self:onClickSortMenu(...)end)

self.discipleList:setClickAction(function(...)self:onSelectDZ(...)end)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
self:addNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)


self.sortIdx={}
self.sortInfo={}
self.filterIdx=nil
end

function UIEquipFilterWin:__delete()
self.discipleList:setClickAction(nil)
self.sortScrollView:setClickAction(nil)
self:unbindComponents()
end

function UIEquipFilterWin:onShow(argtable,afterOnloaded)
local dzguid=argtable.dzguid
self.equipType=self.defaultEquipType
self:freshDZList(dzguid)
self:onSelect(dzguid)
end

function UIEquipFilterWin:getDiscipleList()

















local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
return list
end

function UIEquipFilterWin:onHide()

end


function UIEquipFilterWin:onSelect(dzguid)
if mathHelper.compareInt64(self.dzguid,dzguid)then return end

self.dzguid=dzguid
local selectIdx=self.selectIdx
self.selectIdx=self:getDZIdx(dzguid)

if selectIdx~=self.selectIdx then
self.discipleList:jumpToLockX(self.selectIdx)
end
self:showModel()

self:selectEquip()
self:checkAndShowSuitButton()
end

function UIEquipFilterWin:selectEquip()
self:freshEquips()
self:freshListPanel()
self:freshSuitFilter()
self:freshSortFilter()
self:freshAttrPanel()
end


function UIEquipFilterWin:getDZIdx(dzguid)
for i,v in pairs(self.dzlist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,dzguid)then
return i
end
end
end

function UIEquipFilterWin:freshDZList(_dzguid)
if not self.dzlist then
self.dzlist=self:getDiscipleList()
end
local tNum=#self.dzlist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
local info=self.dzlist[i]
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=info.netData.net
local dzguid=netdata.discipleguid



comHelper.setChildModelHeadIconBG(item,0,dzguid)

comHelper.setChildModelRawImage(item,dzguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.dzguid or _dzguid,dzguid)
item:SetChildActive(3,isSelect)
item:SetChildActive(2,false)
item:SetBaseItemChildGUID(-1,dzguid)
end
end

function UIEquipFilterWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIEquipFilterWin:showModel()

self.lsmodel:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dzguid,true,1)
self.lsmodel:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
self.lsmodel:setChildUIModelShowTargetOffset(0,-80)
end

function UIEquipFilterWin:freshEquips()
local dzguid=self.dzguid
local has=0
for equipType,idx in ipairs(_equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(dzguid,equipType)
self:fillEquip(equip,idx)
if equip then
has=has+1
end
end
self.oneKeyTake:setActive(has>0)
end

function UIEquipFilterWin:fillEquip(equip,equipSlotIdx)
local prop={}
local equipListWidget=self.equipListWidget
local equipType=_equipTypeLookup[equipSlotIdx]
local isSelect=self.equipType==equipType
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
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
end

local suitid=equip.itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[{0}]',suitConfig.name)or''
local name=FMT.fmt('<color=#ca631d>{0}</color>{1}',suitName,itemsModel.getNameByItem(equip))

prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=jinglianStr
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=stageStr
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=stageStr~=''or xmstageStr~=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpLock)]=isLock
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpFabaoTag)]=isFabao
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpCountBg)]=jinglianStr~=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpSelect)]=isSelect
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpBottomName)]=name
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpSuitIcon)]=suitIconName
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid or-1
else
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemQualityIdx)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=true
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpLock)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpFabaoTag)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpCountBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpSelect)]=isSelect
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpBottomName)]='<color=#65615f>无装备</color>'
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpSuitIcon)]=''
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
equipListWidget:SetChildPropData(equipSlotIdx,prop)
end

function UIEquipFilterWin:freshListPanel()
local list=self:getListData()
self.list=list
local len=#list
local colomn=1
local row=math.ceil(len/colomn)
local createList={}
for i=1,len do createList[#createList+1]=i end
self.bagScrollView:initData('equipFilterItem',createList)
end

function UIEquipFilterWin:getEquipByFilter(dzguid,equip,voc,equipType)
local filter={}

filter[ITEM_FILTER_TYPE.eEquipType1]=equipType


filter[ITEM_FILTER_TYPE.eEquipWeaponVoc]=voc


if equip then
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,equip.itemguid}
end


local lvSortValue=0
local stageSortValue=0
local attr1SortValue
local attr2SortValue
local attr3SortValue
local attr4SortValue

local attrTypes={}
local attrType
local sortMenuType=_sortMenuType.eSort1
local sortInfo=self.sortInfo[sortMenuType]
if sortInfo then
local sortType=sortInfo.sortType
if sortType==_sortType.eAttr then
attrType=sortInfo.id
attrTypes[#attrTypes+1]=attrType
attr1SortValue=attrType
elseif sortType==_sortType.eJingLianLevel then
lvSortValue=10000000
elseif sortType==_sortType.eStage then
stageSortValue=10000000
end
end

local sortMenuType=_sortMenuType.eSort2
local sortInfo=self.sortInfo[sortMenuType]
if sortInfo then
local sortType=sortInfo.sortType
if sortType==_sortType.eAttr then
if attrType~=sortInfo.id then
attrType=sortInfo.id
attrTypes[#attrTypes+1]=attrType
attr2SortValue=attrType
end
elseif sortType==_sortType.eJingLianLevel then
lvSortValue=100000
elseif sortType==_sortType.eStage then
stageSortValue=100000
end
end

local sortMenuType=_sortMenuType.eSort3
local sortInfo=self.sortInfo[sortMenuType]
if sortInfo then
local sortType=sortInfo.sortType
if sortType==_sortType.eAttr then
if attrType~=sortInfo.id then
attrType=sortInfo.id
attrTypes[#attrTypes+1]=attrType
attr3SortValue=attrType
end
elseif sortType==_sortType.eJingLianLevel then
lvSortValue=1000
elseif sortType==_sortType.eStage then
stageSortValue=1000
end
end

local sortMenuType=_sortMenuType.eSort4
local sortInfo=self.sortInfo[sortMenuType]
if sortInfo then
local sortType=sortInfo.sortType
if sortType==_sortType.eAttr then
if attrType~=sortInfo.id then
attrType=sortInfo.id
attrTypes[#attrTypes+1]=attrType
attr4SortValue=attrType
end
elseif sortType==_sortType.eJingLianLevel then
lvSortValue=10
elseif sortType==_sortType.eStage then
stageSortValue=10
end
end

if#attrTypes>0 then
filter[ITEM_FILTER_TYPE.eEquipRandomAttr]={ITEM_FILTER_COMPARE.eAnd,attrTypes}
end

if not self.isToggleDress then
filter[ITEM_FILTER_TYPE.eIsDress]=false
end


if self.filterIdx then
local filterCfg=self.filterCfg
local idx=self.filterIdx
local cfg=filterCfg[idx].cfg
if cfg then
local suitid=cfg.id
filter[ITEM_FILTER_TYPE.eSuitEquip]={ITEM_FILTER_COMPARE.eEquals,{suitid}}
end
end


local equipList=equipsModel.getEquipByFilter(filter)


local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter)
for i,v in ipairs(bagList)do
equipList[#equipList+1]=v
end


local attrSort={}
local attrSortLookup={}
for i,v in ipairs(equipList)do
local itemguid=v.itemguid
if attr1SortValue or attr2SortValue or attr3SortValue or attr4SortValue then
local lookup=equipsHelper.getTotalRandomAttrLookup(v)
if attr1SortValue then
local attrType=attr1SortValue
local attrValue=lookup[attrType]
if attrSort[attrType]==nil then attrSort[attrType]={}end
local sort=attrSort[attrType]
if attrSortLookup[attrType]==nil then attrSortLookup[attrType]={}end
local sortLookup=attrSortLookup[attrType]
if sortLookup[attrValue]==nil then
sort[#sort+1]=attrValue
end
end
if attr2SortValue then
local attrType=attr2SortValue
local attrValue=lookup[attrType]
if attrSort[attrType]==nil then attrSort[attrType]={}end
local sort=attrSort[attrType]
if attrSortLookup[attrType]==nil then attrSortLookup[attrType]={}end
local sortLookup=attrSortLookup[attrType]
if sortLookup[attrValue]==nil then
sort[#sort+1]=attrValue
end
end
if attr3SortValue then
local attrType=attr3SortValue
local attrValue=lookup[attrType]
if attrSort[attrType]==nil then attrSort[attrType]={}end
local sort=attrSort[attrType]
if attrSortLookup[attrType]==nil then attrSortLookup[attrType]={}end
local sortLookup=attrSortLookup[attrType]
if sortLookup[attrValue]==nil then
sort[#sort+1]=attrValue
end
end
if attr4SortValue then
local attrType=attr4SortValue
local attrValue=lookup[attrType]
if attrSort[attrType]==nil then attrSort[attrType]={}end
local sort=attrSort[attrType]
if attrSortLookup[attrType]==nil then attrSortLookup[attrType]={}end
local sortLookup=attrSortLookup[attrType]
if sortLookup[attrValue]==nil then
sort[#sort+1]=attrValue
end
end
end
end
for i,v in pairs(attrSort)do
if#v>1 then
table.sort(v,function(a,b)return a>b end)
end
end

local attrSortTag={}
for k,v in pairs(attrSort)do
attrSortTag[k]={}
for ii,vv in ipairs(v)do
attrSortTag[k][vv]=ii
end
end
local sortflagTable={}
for i,v in ipairs(equipList)do
local itemguid=v.itemguid
local itemConfig=itemsConfig.getConfig(v.itemid)
local itemData=v.itemData or{}
local jinglianlv=itemData.jinglianlv or 0
local sortflag=1000*jinglianlv+10*itemConfig.stage
if attr1SortValue or attr2SortValue then
sortflag=lvSortValue*jinglianlv+stageSortValue*itemConfig.stage
local lookup=equipsHelper.getTotalRandomAttrLookup(v)
if attr1SortValue then
local attrType=attr1SortValue
local attrValue=lookup[attrType]
local sortValue=attrSortTag[attrType][attrValue]
sortflag=sortflag-sortValue*10000000
end
if attr2SortValue then
local attrType=attr2SortValue
local attrValue=lookup[attrType]
local sortValue=attrSortTag[attrType][attrValue]
sortflag=sortflag-sortValue*100000
end
if attr3SortValue then
local attrType=attr3SortValue
local attrValue=lookup[attrType]
local sortValue=attrSortTag[attrType][attrValue]
sortflag=sortflag-sortValue*1000
end
if attr4SortValue then
local attrType=attr4SortValue
local attrValue=lookup[attrType]
local sortValue=attrSortTag[attrType][attrValue]
sortflag=sortflag-sortValue*10
end
end
sortflagTable[tostring(itemguid)]=sortflag+itemConfig.color+v.itemid/40000+0.0001*i
end
if#equipList>0 then
table.sort(equipList,function(a,b)
local a_sortflag=sortflagTable[tostring(a.itemguid)]
local b_sortflag=sortflagTable[tostring(b.itemguid)]
return a_sortflag>b_sortflag
end)
end
if equip then
table.insert(equipList,1,equip)
end
return equipList
end

function UIEquipFilterWin:getListData()
local dzguid=self.dzguid
local equipType=self.equipType
local diziInfo=UIDiscipleModel:getDiscipleImageInfo(dzguid)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
local voc=diziInfo.job
return self:getEquipByFilter(dzguid,equip,voc,equipType)
end

function UIEquipFilterWin:onStartAction()

end

function UIEquipFilterWin:onFreshAction(index,widget)
local itemInfo=self.list[index]
if itemInfo==nil then return end
local count=itemInfo.itemcount
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local itemData=itemInfo.itemData or{}
local hasEquiped=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local suitid=itemInfo.itemData and itemInfo.itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[{0}]',suitConfig.name)or''
local name=itemsModel.getNameByItem(itemInfo)
name=FMT.fmt('<color=#ca631d>{0}</color>{1}',suitName,name)
local fightStr=equipsHelper.getEquipFightX(itemid,itemguid)
local jinglianlv=itemsConfig.isEquip(itemid)and itemData.jinglianlv
local jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
local iconName=itemsModel.getIconName(itemInfo)
local hasEquiped=dzguid~=nil
local suitIconName=equipsHelper.getSuitIconByArgs(itemguid,itemid)

local isSelect=false
local itemData=itemInfo.itemData or{}
local randattrList=itemData.randattrList or{}
local isSelfEquiped=mathHelper.compareInt64(dzguid,self.dzguid)

local attrRange={10,11,12,13}
for i,v in ipairs(attrRange)do
widget:SetChildText(attrRange[i],'')
end

local len=#randattrList
for i,v in ipairs(randattrList)do
local name,valstr=equipsHelper.getAttr(v.param_1,v.param_2)
widget:SetChildText(attrRange[i],FMT.fmt('{0}:{1}',name,valstr))
end

local isxmEquip=0
local asset=""
local xmstageStr=''
local ninglianStar=0
local isEquip=itemsConfig.isEquip(itemid)
if isEquip then
isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('仙·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_jinlian1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=itemConfig.stage and FMT.fmt('魔·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_moyan1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
end
end


widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildText(2,stageStr)
widget:SetChildText(3,name)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,not isSelfEquiped and hasEquiped)
widget:SetChildText(7,jinglianStr)
widget:SetChildActive(8,stageStr~=''or xmstageStr~='')
widget:SetChildActive(9,jinglianStr~='')
widget:SetChildIcon(17,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetBaseItemChildID(15,itemid)
widget:SetBaseItemChildGUID(15,itemguid)
widget:SetBaseItemClickEvent(15,function(...)self:onItemClick(...)end)
widget:SetChildActive(14,isSelfEquiped)
widget:SetChildActive(16,len==0)
widget:SetChildActive(18,bagHelper.isLock(itemInfo))

widget:SetChildText(20,xmstageStr)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(19,true)
local xmWidget=widget:GetChildWidgetBase(19)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
else
widget:SetChildActive(19,false)
end

if hasEquiped then
comHelper.setChildModelRawImage(widget,dzguid,6,0,eHeadCenterType.eHead,0.6)
end
widget:SetBaseItemClickEvent(-1,function(...)self:onItemClick(...)end)
end

function UIEquipFilterWin:freshToggle(isToggle)
self.dressToggle:setToggle(self.isToggleDress)
end


function UIEquipFilterWin:freshSuitFilter()
local filterCfg=self.filterCfg
local name={}
for i,v in ipairs(filterCfg)do
name[#name+1]=''
end
self.suitDropdown:setOption(name)
local reIdx=self.filterIdx or 1
local name=filterCfg[reIdx].name
if name=='所有'then
self.suitLabel:setText('套装选择')
self.suiticon:setActive(false)
else
local cfg=filterCfg[reIdx]
local suitCfg=cfg.cfg or{}
local iconName=equipsHelper.getEquipSuitIconById(suitCfg.id)
self.suiticon:setActive(true)
self.suiticon:setIcon(iconName,false)
self.suitLabel:setText(FMT.fmt("<color=#ca631d>{0}</color>",name))
end

self.suitDropdown:setValue(reIdx-1)
end

function UIEquipFilterWin:freshSortFilter()
local widget=self.winlua:GetChildWidgetBase(self.Dropdown1:getID())
local sortMenuType=_sortMenuType.eSort1
local sortInfo=self.sortInfo[sortMenuType]
widget:SetChildText(0,sortInfo and sortInfo.desc or'所有')
widget:SetChildDORotation(1,Vector3(0,0,self.sortClick==1 and 180 or 0),0.1)

local widget=self.winlua:GetChildWidgetBase(self.Dropdown2:getID())
local sortMenuType=_sortMenuType.eSort2
local sortInfo=self.sortInfo[sortMenuType]
widget:SetChildText(0,sortInfo and sortInfo.desc or'所有')
widget:SetChildDORotation(1,Vector3(0,0,self.sortClick==2 and 180 or 0),0.1)

local widget=self.winlua:GetChildWidgetBase(self.Dropdown3:getID())
local sortMenuType=_sortMenuType.eSort3
local sortInfo=self.sortInfo[sortMenuType]
widget:SetChildText(0,sortInfo and sortInfo.desc or'所有')
widget:SetChildDORotation(1,Vector3(0,0,self.sortClick==3 and 180 or 0),0.1)

local widget=self.winlua:GetChildWidgetBase(self.Dropdown4:getID())
local sortMenuType=_sortMenuType.eSort4
local sortInfo=self.sortInfo[sortMenuType]
widget:SetChildText(0,sortInfo and sortInfo.desc or'所有')
widget:SetChildDORotation(1,Vector3(0,0,self.sortClick==4 and 180 or 0),0.1)

end

function UIEquipFilterWin:showSortPanel(index)
if self.showSort then return end
self.showSort=true
self.sortClick=index
self:freshSortPanel()
self.winlua:SetChildLocalPosY(self.sortScrollView:getID(),index>2 and 167 or 214.2)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.sortScrollView:getID(),'1',0,3)
self.sortBgBtn:setActive(true)
self.winlua:SetChildLocalPosY(self.sortContent:getID(),0)
end

function UIEquipFilterWin:closeSortPanel()
if not self.showSort then return end
self.sortClick=nil
self.showSort=false
self.sortBgBtn:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.sortScrollView:getID(),'2',0,3)
end

function UIEquipFilterWin:freshSortPanel()
local sortCfg=self.sortCfg
local len=#sortCfg
local colomn=2
local row=math.ceil(len/colomn)
self.sortScrollView:freshGridsNum(len,row,colomn,true)
for i=1,len do
local item=self.sortScrollView:getGridObjectByindex(i-1)
local info=sortCfg[i]
local name=info.desc
local sortType=info.sortType
local id=info.id or 0
local isAttr=sortType==_sortType.eAttr
item:SetChildActive(0,isAttr)
item:SetChildActive(1,not isAttr)
item:SetChildText(2,name)
item:SetBaseItemChildID(-1,sortType)
item:SetBaseItemChildAttach(-1,id)
end
end


function UIEquipFilterWin:freshAttrPanel()
local dzguid=self.dzguid
local attrTemp={}
local suidTemp={}
local suidIds={}
local has=0
for equipType,_ in ipairs(_equipSlotIndex)do
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip then
has=has+1
local itemguid=equip.itemguid
local itemid=equip.itemid
local static=equipsHelper.getEquipBaseAttrsListByItemguid(itemguid,itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local extra=itemConfig.extra or{}
local itemData=equip.itemData or{}
local randattrList=itemData.randattrList
local randattrList=attrListHelper.transformFromNamedList(randattrList)
local temp=table.concatTable(static,extra)
temp=table.concatTable(randattrList,temp)
attrTemp=attrListHelper.concatList(attrTemp,temp)
local suitid=itemData.suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig then
local num=suidTemp[suitid]
if num then
suidTemp[suitid]=num+1
else
suidTemp[suitid]=1
suidIds[#suidIds+1]=suitid
end
end
end
end
self.temptitle:setActive(false)
local attrLookup=attrListHelper.tramsformToLookup(attrTemp)

local len=#_showAttrCfg
local t=math.ceil(len/2)
self.equipAttrCreater:setChildLayoutGroupCreateItems(t)
local grids=self.equipAttrCreater:getChildLayoutGroupGridList()
for i=1,t do
local idx=2*(i-1)+1
local attrId1=_showAttrCfg[idx]
local attrId2=_showAttrCfg[idx+1]


local attr1Value=attrLookup[attrId1]or 0
local attr2Value=attrId2 and attrLookup[attrId2]or 0
local item=grids[i-1]
local widget=item:GetChildSelfWidgetBase()
local widget1=widget:GetChildWidgetBase(0)


local name,valstr=equipsHelper.getAttr(attrId1,attr1Value)
name=_attrNameLookup[attrId1]
widget1:SetChildText(0,name)
widget1:SetChildText(1,valstr)


local hasWidget2=attrId2~=nil
local widget2=widget:GetChildWidgetBase(1)
widget2:SetChildActive(-1,hasWidget2)
if hasWidget2 then
local name,valstr=equipsHelper.getAttr(attrId2,attr2Value)
name=_attrNameLookup[attrId2]
widget2:SetChildText(0,name)
widget2:SetChildText(1,valstr)

end
end

local len=0
local suitTable={}
if#suidIds>0 then
local temp={}
for _,suitid in ipairs(suidIds)do
local num=suidTemp[suitid]
if num>1 then
temp[#temp+1]=suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
if num>=2 then
if suitConfig.attr2desc then
suitTable[#suitTable+1]={suitid,2}
end
end
if num>=3 then
if suitConfig.attr3desc then
suitTable[#suitTable+1]={suitid,3}
end
end
end
end
table.sort(temp,function(a,b)return a<b end)
suidIds=temp
end
local len=#suitTable
self.cizhuiCreater:setChildLayoutGroupCreateItems(len)
if len>0 then
local grids=self.cizhuiCreater:getChildLayoutGroupGridList()
for i,v in ipairs(suitTable)do
local suitid=v[1]
local num=v[2]
local item=grids[i-1]
local suitConfig=equipsConfig.getSuitConfig(suitid)
local attr2desc=suitConfig.attr2desc
local name=suitConfig.name
local desc=''
if attr2desc and num==2 then
local attr4name=FMT.fmt('{0}\194\160[{1}]',name,string.addSpace('2件套',true))
local fontColor=FONT_COLOR.ePurpleActiveColor
desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr2desc)
end

local attr3desc=suitConfig.attr3desc
if attr3desc and num==3 then
local attr4name=FMT.fmt('{0}\194\160[{1}]',name,string.addSpace('3件套',true))
local fontColor=FONT_COLOR.ePurpleActiveColor
desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr3desc)
end
item:SetChildText(0,desc)
end
end
end


function UIEquipFilterWin:onOneKeyTake()
local dzguid=self.dzguid
local equips=equipsModel.getAllEquipsByDizi(dzguid)or{}
local list={}
for k,v in pairs(equips)do
list[#list+1]=v.itemguid
end
if#list>0 then
equipsProtocolControl.req_equip_take_off_onekey(dzguid)
end
end

function UIEquipFilterWin:removeDisciple(dzguid)
local found=self:getDZIdx(dzguid)
if found then
table.remove(self.dzlist,found)
if#self.dzlist>0 then
self.selectIdx=found-1
if self.selectIdx<1 then self.selectIdx=1 end
local netdata=self.dzlist[self.selectIdx].netData.net
self.dzguid=netdata.discipleguid
self:freshDZList()
end
end
end

function UIEquipFilterWin:onDropdownSuitChange(reIdx)
local filterCfg=self.filterCfg
local len=#filterCfg
local idx=reIdx+1
local last=self.filterIdx or 1
if last==idx then return end
self.filterIdx=idx
self:freshSuitFilter()
self:freshListPanel()
end

function UIEquipFilterWin:onDropdownSuitCreated()
local filterCfg=self.filterCfg
local len=#filterCfg
for i=1,len do
local cfg=filterCfg[i]
local suitCfg=cfg.cfg or{}
local iconName=equipsHelper.getEquipSuitIconById(suitCfg.id)
local widget=self.suitDropdown:getDropdownItemWidget(i-1)
widget:SetChildText(0,cfg.desc)
widget:SetChildText(1,cfg.name or'')
widget:SetChildIcon(2,iconName,false)
end
end

function UIEquipFilterWin:onDropdownLayouted(scrollTrans,contentTrans)
local filterIdx=self.filterIdx or 1
local idx=filterIdx-1
idx=#self.filterCfg-idx
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
local max=height-_dropViewHeight
if height>_dropViewHeight then
posY=height-idx*_dropItemHeight
else
posY=0
end
if posY<=0 then posY=0 end
if posY>max then posY=max end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIEquipFilterWin:onBaseItemClick(id,equipType,guid,attach)

if self.equipType==equipType then return end
self.equipType=equipType
self:selectEquip()
end

function UIEquipFilterWin:onToggleChanged(name,isToggle,data)
if self.isToggleDress==isToggle then return end
self.isToggleDress=isToggle
self:freshToggle()
self:freshListPanel()
end

function UIEquipFilterWin:onDropdown1()
self:showSortPanel(1)
end

function UIEquipFilterWin:onDropdown2()
self:showSortPanel(2)
end

function UIEquipFilterWin:onDropdown3()
self:showSortPanel(3)
end

function UIEquipFilterWin:onDropdown4()
self:showSortPanel(4)
end

function UIEquipFilterWin:onClickSortMenu(id,index,guid,attach)
local sortType=id
local sortInfo
local idx
if sortType==_sortType.eAttr then
local id=tonumber(attach)
if id>0 then
for i,v in ipairs(_attrCfg)do
if v.id==id then
sortInfo=v
idx=i+2
break
end
end
end
elseif sortType==_sortType.eJingLianLevel then
sortInfo=self.jinglianlvSortCfg
idx=1
elseif sortType==_sortType.eStage then
sortInfo=self.stageSortCfg
idx=2
end
local hasChange=false
local sort1=_sortMenuType.eSort1
local sort2=_sortMenuType.eSort2
local sort3=_sortMenuType.eSort3
local sort4=_sortMenuType.eSort4
if self.sortClick==sort1 then
if idx~=self.sortIdx[sort1]then
self.sortIdx[sort1]=idx
self.sortInfo[sort1]=sortInfo
hasChange=true
end
elseif self.sortClick==2 then
if idx~=self.sortIdx[sort2]then
self.sortIdx[sort2]=idx
self.sortInfo[sort2]=sortInfo
hasChange=true
end
elseif self.sortClick==sort3 then
if idx~=self.sortIdx[sort3]then
self.sortIdx[sort3]=idx
self.sortInfo[sort3]=sortInfo
hasChange=true
end
elseif self.sortClick==sort4 then
if idx~=self.sortIdx[sort4]then
self.sortIdx[sort4]=idx
self.sortInfo[sort4]=sortInfo
hasChange=true
end
end
self:closeSortPanel()
if not hasChange then return end
self:freshSortFilter()
self:freshListPanel()
end

function UIEquipFilterWin:onSelectDZ(id,index,guid,attach)
if mathHelper.compareInt64(guid,self.dzguid)then return end


local oldIdx=self.selectIdx
local newIdx=index
self.selectIdx=newIdx
if oldIdx then
local olditem=self.discipleList:getGridObjectByindex(oldIdx-1)
self:changItemSelect(olditem,false)
end
local newitem=self.discipleList:getGridObjectByindex(newIdx-1)
self:changItemSelect(newitem,true)


self:onSelect(guid)
end

function UIEquipFilterWin:onClose()
self:closeSelf()
end

function UIEquipFilterWin:onTakeEquips(dzguid)
if mathHelper.compareInt64(dzguid,self.dzguid)then
self:freshEquips()
self:freshAttrPanel()
self:freshListPanel()
self:checkAndShowSuitButton()
else
self:freshListPanel()
end
end

function UIEquipFilterWin:onDressEquip(guid,equipType)
if tostring(guid)~=tostring(self.dzguid)then return end
local diziguid=self.dzguid
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
self:fillEquip(equip,_equipSlotIndex[equipType])
self:freshAttrPanel()
self.oneKeyTake:setActive(true)
local animationList={21,10,11}
local ani=math.random(1,#animationList)
self.lsmodel:setChildModelAnimationState(animationList[ani])
tipsManager.closeTips()
self:checkAndShowSuitButton()
end

function UIEquipFilterWin:onSortBgBtn()
self:closeSortPanel()
end

function UIEquipFilterWin:onItemClick(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
self.args={itemid=itemid,itemguid=itemguid}
self:onShowTips()
end

function UIEquipFilterWin:onShowTips()
local itemid=self.args.itemid
local itemguid=self.args.itemguid
if itemid==nil or itemid==-1 then return end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipFilter,
hideBtnRed=true,
itemid=itemid,
itemguid=itemguid,
attach={diziguid=self.dzguid}})
local dzguid=self.dzguid
local equipType=equipsConfig.getEquipType(itemid)
local equip=equipsHelper.getEquipByDizi(dzguid,equipType)
if equip and not mathHelper.compareInt64(equip.itemguid,itemguid)then
local attach={}
attach.diziguid=self.dzguid
if itemsConfig.isEquip(itemid)then

local isxmEquip=equipsHelper.isEquipXM(itemguid)
if isxmEquip then
if equipsHelper.isCanShowNingLian(equip.itemguid)then
attach.insertBtnList=attach.insertBtnList or{}
table.insert(attach.insertBtnList,TIPS_BTNS_TYPE.eXianMoDuanDa)
end
else
if equipsHelper.isCanShowJinglian(equip.itemguid)then
attach.insertBtnList=attach.insertBtnList or{}
table.insert(attach.insertBtnList,TIPS_BTNS_TYPE.eJinglianEquip)
end
if equipsHelper.isCanChongZhu(equip.itemguid)then
attach.insertBtnList=attach.insertBtnList or{}
table.insert(attach.insertBtnList,TIPS_BTNS_TYPE.eChongZhu)

equipsProtocolControl.req_equip_2_91_ex(itemguid)
end
end
end
tipsCompareManager.showTips({move=TIPS_MOVE_POS.eLeft,
hideBtnRed=true,
isLeftBtn=true,
itemid=equip.itemid,
itemguid=equip.itemguid,
attach=attach,
formType=TIPS_FORM_TYPE.eEquipCompare})
end
end

function UIEquipFilterWin:onItemListChanged(args)
local has=false
for i,v in ipairs(args)do
local itemid=v[3]
if itemsConfig.isEquip(itemid)then
has=true
break
end
end
if has then
self:freshListPanel()
end
end

function UIEquipFilterWin:checkAndShowSuitButton()
local dzguid=self.dzguid
local suitList={}
for equipType,idx in ipairs(_equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(dzguid,equipType)
if equip then
local suit=equip.itemData.suitid
if suit>0 then
suitList[suit]=(suitList[suit]or 0)+1
end
end
end
local slist={}
for k,v in pairs(suitList)do
if v>1 then
table.insert(slist,{k,2})
if v>2 then
table.insert(slist,{k,3})
end
end
end
self.suitDatas=slist
for i=1,2 do
local data=slist[i]
self.suitBtns[i]:setActive(data~=nil)
if data then
local suitConfig=equipsConfig.getSuitConfig(data[1])
self.suitBtnTexts[i]:setText(FMT.fmt('{0}[{1}件]',suitConfig.name,data[2]))
end
end
if#slist>0 then
self.suitDes:setText('套装')
self.suitDes2:setActive(false)
else
self.suitDes:setText('')
self.suitDes2:setActive(true)
end
end

function UIEquipFilterWin:onSuitBtnA()
local data=self.suitDatas[1]
local args={}
args.data=data
args.pos=self.suitBtnA:getChildScreenPointToLocalPointRectangle()
args.offset={0,35}
UIManager:showWindow('UIShowEquipSuitInfoWin',args)
end

function UIEquipFilterWin:onSuitBtnB()
local data=self.suitDatas[2]
local args={}
args.data=data
args.pos=self.suitBtnB:getChildScreenPointToLocalPointRectangle()
args.offset={0,35}
UIManager:showWindow('UIShowEquipSuitInfoWin',args)
end

function UIEquipFilterWin:getFilterSuit()
return equipsHelper.getFilterSuit()
end

function UIEquipFilterWin:onItemLockChanged(itemid,itemguid,isUnlock)
if itemsConfig.isEquip(itemid)then

self:findlock(itemguid)
end
end
function UIEquipFilterWin:findlock(itemguid)
for k,v in ipairs(self.list)do
if v.itemguid==itemguid then
local widget=self.bagScrollView:getItemWidget(k)
widget:SetChildActive(18,bagHelper.isLock(v))
break
end
end
end
