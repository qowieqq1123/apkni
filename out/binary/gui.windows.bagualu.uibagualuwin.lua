







def_class("UIBaGuaLuWin",UIWindowBase)









function UIBaGuaLuWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectPanel=UIObject.get(self,1)
self.selectPanelMask=UIButton.get(self,2)
self.raycast=UIObject.get(self,3)
self.flyRoot=UIObject.get(self,4)
self.effect2=UIObject.get(self,5)
self.effect1=UIObject.get(self,6)
self.leftPanel=UIObject.get(self,7)
self.rightPanel=UIObject.get(self,8)
self.effect=UIObject.get(self,9)
self.selectCloseBtn=UIButton.get(self,10)
self.filterBtn=UIButton.get(self,11)
self.btnRongLian=UIButton.get(self,12)
self.luzi=UIObject.get(self,13)
self.items=UIObject.get(self,14)
self.item4=UIBaseItem.get(self,15)
self.item2=UIBaseItem.get(self,16)
self.item3=UIBaseItem.get(self,17)
self.itemBg=UIObject.get(self,18)
self.item1=UIBaseItem.get(self,19)
self.selectCount=UIText.get(self,20)
self.lock=UIObject.get(self,21)
self.selectFabao=UIObject.get(self,22)
self.selectEquip=UIObject.get(self,23)
self.btnSetting=UIButton.get(self,24)
self.btnConfirm=UIButton.get(self,25)
self.btnReset=UIButton.get(self,26)
self.btnEquip=UIButton.get(self,27)
self.btnFabao=UIButton.get(self,28)
self.Content=UIObject.get(self,29)
self.ScrollView=UILoopListView.new(self,30)
self.Dropdown2=UIDropdownEx.get(self,31)
self.Dropdown1=UIDropdownEx.get(self,32)
self.pageCreater=UIObject.get(self,33)
self.Item_Label=UIText.get(self,34)
self.openflag=UIObject.get(self,35)
self.closeflag=UIObject.get(self,36)
self.txtSetting=UIText.get(self,37)
self.btnYuanpei=UIButton.get(self,38)
self.selectYuanpei=UIObject.get(self,39)
self.helpBtn=UIButton.get(self,40)
self.tequantext=UIText.get(self,41)
self.tqbtn=UIButton.get(self,42)
self.gdpanel=UIObject.get(self,43)
self.tqluck=UIObject.get(self,44)
self.lightbg=UIObject.get(self,45)

self.selectPanelMask:setButtonClick(function()self:onSelectPanelMask()end)

self.selectCloseBtn:setButtonClick(function()self:onSelectCloseBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.btnRongLian:setButtonClick(function()self:onBtnRongLian()end)

self.btnSetting:setButtonClick(function()self:onBtnSetting()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnEquip:setButtonClick(function()self:onBtnEquip()end)

self.btnFabao:setButtonClick(function()self:onBtnFabao()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.btnYuanpei:setButtonClick(function()self:onBtnYuanpei()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.tqbtn:setButtonClick(function()self:onTqbtn()end)



end


function UIBaGuaLuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selectPanelMask);self.selectPanelMask=nil;
_UIObject_release(self.raycast);self.raycast=nil;
_UIObject_release(self.flyRoot);self.flyRoot=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.selectCloseBtn);self.selectCloseBtn=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.btnRongLian);self.btnRongLian=nil;
_UIObject_release(self.luzi);self.luzi=nil;
_UIObject_release(self.items);self.items=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.itemBg);self.itemBg=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.selectCount);self.selectCount=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.selectFabao);self.selectFabao=nil;
_UIObject_release(self.selectEquip);self.selectEquip=nil;
_UIObject_release(self.btnSetting);self.btnSetting=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnEquip);self.btnEquip=nil;
_UIObject_release(self.btnFabao);self.btnFabao=nil;
_UIObject_release(self.Content);self.Content=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
_UIObject_release(self.openflag);self.openflag=nil;
_UIObject_release(self.closeflag);self.closeflag=nil;
_UIObject_release(self.txtSetting);self.txtSetting=nil;
_UIObject_release(self.btnYuanpei);self.btnYuanpei=nil;
_UIObject_release(self.selectYuanpei);self.selectYuanpei=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.tequantext);self.tequantext=nil;
_UIObject_release(self.tqbtn);self.tqbtn=nil;
_UIObject_release(self.gdpanel);self.gdpanel=nil;
_UIObject_release(self.tqluck);self.tqluck=nil;
_UIObject_release(self.lightbg);self.lightbg=nil;
end


















local _colomn=5
local _row=5
local _dropItemHeight=40
local _dropViewHeight=150


local _filterTypeName={
[BAG_TYPE.eEquipBag]="装备",
[BAG_TYPE.eFabaoBag]="法宝",
[BAG_TYPE.eItemBag]="原胚",
}

local _filterTypeCfgs=
{
[BAG_TYPE.eEquipBag]=
{
{
filterType=ITEM_FILTER_TYPE.eEquipType1,
name='部位',
},
{
filterType=ITEM_FILTER_TYPE.eColor,
name='品质',
},
{
filterType=ITEM_FILTER_TYPE.eStage,
name='阶数',
},
{
filterType=ITEM_FILTER_TYPE.eSuitEquip,
name='套装',
reverse=true,
filter=true,
line=true,
},
{
filterType=ITEM_FILTER_TYPE.eEquipRandomAttr,
name='随机属性',
reverse=true,
native=false,
},
},

[BAG_TYPE.eFabaoBag]=
{
{
filterType=ITEM_FILTER_TYPE.eColor,
name='品质',
},
{
filterType=ITEM_FILTER_TYPE.eStage,
name='阶数',
},
{
filterType=ITEM_FILTER_TYPE.eAnyElement,
name='五行属性',
reverse=true,
native=true,
filter=true,
line=true,
},
{
filterType=ITEM_FILTER_TYPE.eFabaoLianhuaAttr,
name='炼化属性',
reverse=true,
native=false,
},
},
[BAG_TYPE.eItemBag]=
{
{
filterType=ITEM_FILTER_TYPE.eColor,
name='品质',
},
{
filterType=ITEM_FILTER_TYPE.eItemType1AndType2,
name='类型',
},

}
}

local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}

local _filterLookupCfg={}
for bagType,v in pairs(_filterTypeCfgs)do
_filterLookupCfg[bagType]={}
for _,vv in ipairs(v)do
_filterLookupCfg[bagType][vv.filterType]=vv
end
end
local _bgBundle=globalABLookup.global
local _filterTwoLookupCfg={}

local yuekafanhuantype={
eEquip=8,
eFabao=9,
eYiWang=10,
}
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"

function UIBaGuaLuWin:onLoaded(...)
self:bindComponents()
self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.ScrollView:getID())

local itemsList={}
self.itemsList=itemsList
itemsList[#itemsList+1]=self.item1
itemsList[#itemsList+1]=self.item2
itemsList[#itemsList+1]=self.item3
itemsList[#itemsList+1]=self.item4

for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)self:onItemClick(...)end)
end


local rangeList=table.toTable(eQualityColor.eBlue,eQualityColor.eRed)
local commonlist={}
commonlist[#commonlist+1]={
nameFunc=function()
return'所有品质'
end,
compareType=0,
}

for _,color in ipairs(rangeList)do
commonlist[#commonlist+1]={
nameFunc=function()
return FMT.cfmt(color,FMT.fmt('{0}及以上',eQualityColorName[color]))
end,
compareType=color,
}
end



local bagType=BAG_TYPE.eEquipBag
local filterBagCfg=_filterLookupCfg[bagType]

_filterTwoLookupCfg[bagType]=commonlist




local filterType=ITEM_FILTER_TYPE.eEquipType1
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot)
for i,equipType in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return equipsConfig.getEquipName(equipType)
end,
compareType=equipType,
}
end


self.defaultFilter={}
self.defaultFilter[bagType]={}

local defaltBagFilter=self.defaultFilter[bagType]
defaltBagFilter[filterType]={}
for i,equipType in ipairs(rangeList)do
defaltBagFilter[filterType][i]=true
end





local filterType=ITEM_FILTER_TYPE.eColor
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
for i,color in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.cfmt(color,eQualityColorName[color])
end,
compareType=color,
}
end


defaltBagFilter[filterType]={}
defaltBagFilter[filterType][1]=true
defaltBagFilter[filterType][2]=true




local filterType=ITEM_FILTER_TYPE.eStage
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(1,5)
for i,stage in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.fmt('{0}阶',stage)
end,
compareType=stage,
}
end


defaltBagFilter[filterType]={}
defaltBagFilter[filterType][1]=true
defaltBagFilter[filterType][2]=true




local filterType=ITEM_FILTER_TYPE.eSuitEquip
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list

local suitConfig=equipsConfig.getAllSuitConfig()






for i,v in ipairs(suitConfig)do
if v.filter then
local suitid=v.id
local name=v.name
filterlist[#filterlist+1]={
nameFunc=function()
return name
end,
compareType=suitid,
bgAsset='image_jzaplgdise_6'
}
end
end







local filterType=ITEM_FILTER_TYPE.eEquipRandomAttr
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local attrs=equipsConfig.getEquipConstConfig().rangeattrs
for i,attrid in ipairs(attrs)do
filterlist[#filterlist+1]={
nameFunc=function()
if _renameType[attrid]then return _renameType[attrid]end
return helper.getAttributeName(attrid)
end,
compareType=attrid,
bgBundle=globalABLookup.globa4,
bgAsset='image_jzaplgdise_7'
}
end




local bagType=BAG_TYPE.eFabaoBag
local filterBagCfg=_filterLookupCfg[bagType]
_filterTwoLookupCfg[bagType]=commonlist




local filterType=ITEM_FILTER_TYPE.eColor
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
for i,color in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.cfmt(color,eQualityColorName[color])
end,
compareType=color,
}
end


self.defaultFilter[bagType]={}

local defaltBagFilter=self.defaultFilter[bagType]
defaltBagFilter[filterType]={}
defaltBagFilter[filterType][1]=true




local filterType=ITEM_FILTER_TYPE.eStage
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(1,5)
for i,stage in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.fmt('{0}阶',stage)
end,
compareType=stage,
}
end


defaltBagFilter[filterType]={}
defaltBagFilter[filterType][1]=true






local nameColor=
{
[ELEMENT_TYPE.eGold]='#ae8434',
[ELEMENT_TYPE.eWood]='#549327',
[ELEMENT_TYPE.eWater]='#3375c0',
[ELEMENT_TYPE.eFire]='#c82c2c',
[ELEMENT_TYPE.eSoil]='#7d3b17',
}
local bgAssets=
{
[ELEMENT_TYPE.eGold]='image_jzaplgdise_1',
[ELEMENT_TYPE.eWood]='image_jzaplgdise_2',
[ELEMENT_TYPE.eWater]='image_jzaplgdise_3',
[ELEMENT_TYPE.eFire]='image_jzaplgdise_4',
[ELEMENT_TYPE.eSoil]='image_jzaplgdise_5',
}

local filterType=ITEM_FILTER_TYPE.eAnyElement
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
for i,element in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.cfmt2(nameColor[element],'{0}系',ELEMENT_TYPE.getName(element))
end,
compareType=element,
bgAsset=bgAssets[element],
}
end





local filterType=ITEM_FILTER_TYPE.eFabaoLianhuaAttr
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local attrs=fabaoConfig.getCommonConfig().lianhuaattrs
for i,attrid in ipairs(attrs)do
filterlist[#filterlist+1]={
nameFunc=function()
if _renameType[attrid]then return _renameType[attrid]end
return helper.getAttributeName(attrid)
end,
compareType=attrid,
bgAsset='image_jzaplgdise_6'
}
end




local bagType=BAG_TYPE.eItemBag
local filterBagCfg=_filterLookupCfg[bagType]
_filterTwoLookupCfg[bagType]=commonlist




local filterType=ITEM_FILTER_TYPE.eColor
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local rangeList=table.toTable(eQualityColor.ePurple,eQualityColor.eRed)
for i,color in ipairs(rangeList)do
filterlist[#filterlist+1]={
nameFunc=function()
return FMT.cfmt(color,eQualityColorName[color])
end,
compareType=color,
}
end


self.defaultFilter[bagType]={}

local defaltBagFilter=self.defaultFilter[bagType]
defaltBagFilter[filterType]={}





local filterType=ITEM_FILTER_TYPE.eItemType1AndType2
local filterCfg=filterBagCfg[filterType]
filterCfg.list={}
local filterlist=filterCfg.list
local allPrefixCfg=cfg_fabaoyuanpeiprefixtypeconfig()
for i,cfg in ipairs(allPrefixCfg)do
local prefixName=cfg.prefixName
local type1=cfg.type1 or 0
local type2=cfg.type2 or 0
local typeKey=type1*100+type2
filterlist[#filterlist+1]={
nameFunc=function()
return prefixName
end,
compareType=typeKey
}
end


defaltBagFilter[filterType]={}

self.filterTwoCfg={}

self:readLocalSetting()
self.tempFilterData=nil

self.selectBagType=nil
self.selectGUIDList={}
self.defaultBagType=BAG_TYPE.eEquipBag

self.selectLookup={}
self.isChange=true
self.bagList=nil
self.xmEquipType=0
self.xmEquipid=nil

self.highset=userActorSetting.get('bagualuset',false)
self:freshSettingBtn()
end

function UIBaGuaLuWin:__delete()
self:stopBehavior()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
UIFullBaGuaLuControl:clearRongLianData()

end

function UIBaGuaLuWin:onShow(argtable,afterOnloaded)
self.monthInvestorCfg=cfg_yuekaconfig()
local bagType=argtable and argtable.bagType or nil

self:selectBag(bagType or self.defaultBagType)
self:TeQuanRefresh()
end

function UIBaGuaLuWin:onHide()
self:stopBehavior()
end



function UIBaGuaLuWin:onBtnRongLian()
local bagType=self.selectBagType
local len=#self.selectGUIDList
if len<=0 then
UIManager.error('请选择熔炼的装备、法宝或原胚')
return
end













if self.xmRandList and next(self.xmRandList)~=nil then
local content="本次熔炼中含有<color=#c82c2c>仙魔装备</color>，"

for itemid,rand in pairs(self.xmRandList)do
local xmEquipType=rand[3]
local name=itemsConfig.getItemName(itemid)

if xmEquipType==EQUIP_XianMo_TYPES.eXian then
content=FMT.fmt("{0}每件仙装分解会有概率获得{1}~{2}个<color=#c82c2c>【{3}】</color>",content,rand[1],rand[2],name)
elseif xmEquipType==EQUIP_XianMo_TYPES.eMo then
content=FMT.fmt("{0}每件魔装分解会有概率获得{1}~{2}个<color=#c82c2c>【{3}】</color>",content,rand[1],rand[2],name)
end
end
content=FMT.fmt("{0},是否执行?",content)


local rlitems=self.rlitems
local selectGUIDList=self.selectGUIDList
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=content,
closetopbtn=true,
cellcallback=function()
UIFullBaGuaLuControl:setRongLianGUID(selectGUIDList,rlitems)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
UIFullBaGuaLuControl:setRongLianGUID(self.selectGUIDList,self.rlitems)
end
end

function UIBaGuaLuWin:onBtnSetting()
self.highset=not self.highset
self:freshSettingBtn()
self:refreshSelectPanel()
userActorSetting.flushVal('bagualuset',self.highset)
end


function UIBaGuaLuWin:onBtnEquip()
local bagType=BAG_TYPE.eEquipBag
self:selectBag(bagType)
end


function UIBaGuaLuWin:onBtnFabao()
local bagType=BAG_TYPE.eFabaoBag
self:selectBag(bagType)
end

function UIBaGuaLuWin:onBtnYuanpei()
local bagType=BAG_TYPE.eItemBag
self:selectBag(bagType)
end


function UIBaGuaLuWin:onSelectCloseBtn()
self:closeSelectPanel()
end


function UIBaGuaLuWin:onFilterBtn()
if self.isShowSelectPanel then
self:closeSelectPanel()
else
self:showSelectPanel()
end
end


function UIBaGuaLuWin:onBtnReset()
local selectBagType=self.selectBagType
if self.tempFilterData then
self.tempFilterData[selectBagType]=nil
end
if self.tempTwoFilterData then
self.tempTwoFilterData[selectBagType]=1
end
self:refreshSelectPanel()
end


function UIBaGuaLuWin:onBtnConfirm()
if self.tempFilterData==nil then return end
local tempFilterData=self.tempFilterData
local isChange=not table.equals(tempFilterData,self.filterData)or
not table.equals(self.tempTwoFilterData,self.filterData)
self:closeSelectPanel()
if not isChange then return end
self.filterData=table.deepCopy(tempFilterData)or{}
self.twoFilterData=table.deepCopy(self.tempTwoFilterData)or{}
self:saveLocalSetting()
self:freshInfo()
end


function UIBaGuaLuWin:onSelectPanelMask()

self:closeSelectPanel()
end

function UIBaGuaLuWin:onItemClick(itemid,index,itemguid,attach)
if itemid==-1 then return end
tipsManager.showTips({itemid=itemid})
end

function UIBaGuaLuWin:onLongClickGrid(itemid,index,guid,attach)
if itemid==-1 then return end
tipsManager.showTips({itemid=itemid,itemguid=guid,formType=TIPS_FORM_TYPE.eBaGuaLuWin})
end

function UIBaGuaLuWin:onClickGrid(id,index,guid,attach)
local itemid=id
if itemid==-1 then return end
local color=itemsConfig.getConfig(itemid).color

local guidStr=tostring(guid)
local cb=function()
if self==nil or self.isClose then return end
local flag=self.selectLookup[guidStr]or false
if not flag then
local item=bagModel.getItem(guid)
if item and bagHelper.isLock(item)then
UIManager.error('物品已锁定，无法熔炼')
return
end
end
local nextFlag=not flag
self.selectLookup[guidStr]=nextFlag
for i,v in ipairs(self.selectGUIDList)do
if tostring(v)==guidStr then
table.remove(self.selectGUIDList,i)
break
end
end
if nextFlag then
self.selectGUIDList[#self.selectGUIDList+1]=guid
end
self:freshSelectSingleGirid(guid,nextFlag)
self:freshRlItems()
end

local equip=equipsHelper.getEquip(guid)
local itemConfig=itemsConfig.getConfig(itemid)
local xmEquipType=equipsHelper.getEquipXMTypebyItemid(itemid)
local isninglian=false
if xmEquipType>0 then
local ninglian_star=equipsModel.getNingLianStar(equip)
if ninglian_star>0 then
isninglian=true
end
end

local isSelect=self.selectLookup[guidStr]or false
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eRongLian)
if not isSelect and color>=eQualityColor.eOrange and not flag then
local itemTypeName=_filterTypeName[self.selectBagType]
if self.selectBagType~=BAG_TYPE.eItemBag then
itemTypeName=FMT.fmt("的{0}",itemTypeName)
end
local _str=FMT.fmt('本次熔炼含有珍稀{0}，是否确认进行熔炼？',itemTypeName)
if xmEquipType>0 then
_str=FMT.fmt('本次熔炼含有珍稀的<color=#c82c2c>仙魔装备</color>，是否确认进行熔炼？')
end
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',_str)
self.dialog.choosetext="今日不再提示"
self.dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eRongLian,flag)
end
self.dialog.okcallback=function()
if isninglian then
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=FMT.fmt("当前仙魔装备<color={1}>【{0}】</color>已凝炼\n分解后将返还<color=#549327>100%</color>的凝炼材料\n是否执行？",itemConfig.name,FONT_COLOR_VAL[color]),
closetopbtn=true,
cellcallback=cb,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
cb()
end
end
self.dialog:show()
else
if isninglian and not isSelect then
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=FMT.fmt("当前仙魔装备<color={1}>【{0}】</color>已凝炼\n分解后将返还<color=#549327>100%</color>的凝炼材料\n是否执行？",itemConfig.name,FONT_COLOR_VAL[color]),
closetopbtn=true,
cellcallback=cb,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
cb()
end
end
end

function UIBaGuaLuWin:onClickSpecial()

end

function UIBaGuaLuWin:selectBag(bagType)
if bagType==self.selectBagType then return end
self.raycast:setActive(false)
self.selectBagType=bagType
self:TeQuanRefresh()
self:freshInfo()
self.selectEquip:setActive(bagType==BAG_TYPE.eEquipBag)
self.selectFabao:setActive(bagType==BAG_TYPE.eFabaoBag)
self.selectYuanpei:setActive(bagType==BAG_TYPE.eItemBag)
tipsManager.closeTips()
end

function UIBaGuaLuWin:freshInfo()
self:freshLeftInfo()
self:freshRlItems()
end


function UIBaGuaLuWin:freshLeftInfo()

local filterlist=self:getFilterList(self.filterData,self.twoFilterData)

self.selectLookup={}
self.selectGUIDList={}
for _,v in ipairs(filterlist)do
local xmtype=equipsHelper.getEquipXMType(v.itemguid)
if xmtype==0 then
local guidStr=v.guidStr or tostring(v.itemguid)
self.selectLookup[guidStr]=true
self.selectGUIDList[#self.selectGUIDList+1]=v.itemguid
end
end

local filter={}
if self.selectBagType==BAG_TYPE.eFabaoBag then
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eNot,{FABAO_TYPE.eBenMing}}
elseif self.selectBagType==BAG_TYPE.eItemBag then

filter[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eFabaoYuanPei}}
end
self.bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter,false)
self:onSortBag(self.selectLookup,self.bagList)
self:freshLeftGrids(self.bagList)
end

function UIBaGuaLuWin:freshLeftGrids(list)
local rNum=math.ceil(#list/_colomn)
local pageNum=_row
if rNum<pageNum then rNum=pageNum end
local createList={}
for i=1,rNum do createList[#createList+1]=i end
self.ScrollView:initData('itemPanel',createList)
end

function UIBaGuaLuWin:onStartAction()

end

function UIBaGuaLuWin:onFreshAction(index,itemWidget)
local idx=(index-1)*_colomn+1
for i=0,4 do
local widget=itemWidget:GetChildCSGUIBaseItem(i)
local itemInfo=self.bagList[idx+i]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local showStage=stage~=nil
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local isSelect=self:isSelect(itemguid)
local jinglianStr=''
local suitIcon=''
local item=bagModel.getItem(itemguid)
local isLock=item and bagHelper.isLock(item)
local xmEquipType=0
local asset=""
local xmstageStr=''
local ninglianStar=0

if itemsConfig.isFabao(itemid)then
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
suitIcon=equipsHelper.getEquipSuitIcon(itemInfo)

xmEquipType=equipsHelper.getEquipXMTypebyItemid(itemid)
if xmEquipType==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_jinlian1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
elseif xmEquipType==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',itemConfig.stage,stageTitile)or''
asset="image_dzzb_moyan1"
ninglianStar=equipsModel.getNingLianStar(itemInfo)
end
end

widgetHelper.setItemQulaity(widget,itemid,1)
widget:SetChildActive(2,true)
widget:SetChildIcon(2,iconName,false)
widget:SetChildActive(3,isSelect)
widget:SetChildActive(4,showStage or xmstageStr~='')
widget:SetChildText(5,stageStr)
widget:SetChildActive(6,jinglianStr~='')
widget:SetChildText(7,jinglianStr)
widget:SetChildIcon(8,suitIcon,false)
widget:SetChildActive(9,isLock)
widget:SetChildText(11,xmstageStr)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(10,true)
local xmWidget=widget:GetChildWidgetBase(10)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
else
widget:SetChildActive(10,false)
end

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)

widget:SetChildButtonClick(-1,function(...)
self:onClickGrid(itemid,index,itemguid,nil)
end)
widget:SetChildLongTouch(-1,index,0.5,function(...)
self:onLongClickGrid(itemid,index,itemguid,nil)
end)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildActive(6,false)
widget:SetChildText(7,'')
widget:SetChildIcon(8,'',false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetChildText(11,'')
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end
end

function UIBaGuaLuWin:isSelect(itemguid)
return self.selectLookup[tostring(itemguid)]==true
end

function UIBaGuaLuWin:onSortBag(selectLookup,bagList)
local sortTag={}
for i,v in ipairs(bagList)do
local guidStr=v.guidStr or tostring(v.itemguid)
local len=string.len(guidStr)
local numStr=string.sub(guidStr,len-3,len)
local guidNum=tonumber(numStr)
local itemid=v.itemid
local itemData=v.itemData
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
local stage=cfg.stage or 0
local isSelect=selectLookup[guidStr]or false
local val=0
local jinglianStr=0
local isxmsotr=0
if itemsConfig.isFabao(itemid)then
local jinglianlv=itemData and itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and-jinglianlv or 0
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=itemData and itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and-jinglianlv or 0
local xmEquipType=equipsHelper.getEquipXMTypebyItemid(itemid)
if xmEquipType>0 then
isxmsotr=-1
end
end
if isSelect then
val=val-1000000000
end
val=val+1000000*stage+10000*color+0.0001*itemid-guidNum+jinglianStr*10000000+isxmsotr*1000000000
sortTag[guidStr]=val
end

_sort(bagList,function(a,b)
local itemguid_a=a.guidStr or tostring(a.itemguid)
local itemguid_b=b.guidStr or tostring(b.itemguid)
return sortTag[itemguid_a]<sortTag[itemguid_b]
end)
end

function UIBaGuaLuWin:freshSelectSingleGirid(itemguid,flag)
local idx,subIdx=self:getBagItemIdx(itemguid)

local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==idx-1 then
local widget=item.Widget:GetChildWidgetBase(subIdx)
widget:SetChildActive(3,flag)

local itemData=bagModel.getItem(itemguid)
local isLock=itemData and bagHelper.isLock(itemData)
widget:SetChildActive(9,isLock)
break
end
end
end

function UIBaGuaLuWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if v.itemguid==itemguid then
local idx=i%_colomn
return math.ceil(i/_colomn),idx==0 and _colomn-1 or idx-1
end
end
end



function UIBaGuaLuWin:calcuItems()
local selectBagType=self.selectBagType
local selectGUIDList=self.selectGUIDList or{}
local rlitems={}
local xmlist={}
local xmRandList={}
self.xmEquipType=0
for _,itemguid in ipairs(selectGUIDList)do
local item=itemsModel.getItem(itemguid)
local items
if selectBagType==BAG_TYPE.eFabaoBag then
items=fabaoHelper.returnRonglianItems(item)
elseif selectBagType==BAG_TYPE.eEquipBag then
items=equipsHelper.returnRonglianItems(item)
local xmEquipType=equipsHelper.getEquipXMTypebyItemid(item.itemid)
if xmEquipType>0 then
xmlist=self:calcuItems2(item.itemid,xmlist)
self:calcuItems4(item.itemid,xmRandList,xmEquipType)
if self.xmEquipType==0 then
self.xmEquipType=xmEquipType
self.xmEquipid=item.itemid
end
end
elseif selectBagType==BAG_TYPE.eItemBag then
items=fabaoHelper.returnRonglianItems_YuanPei(item)
end
rlitems=table.concatTableXX(rlitems,items)
end
local rrlitems={}
for i,v in ipairs(rlitems)do
if not itemsConfig.isMoney(v[1])then
rrlitems[#rrlitems+1]=v
end
end
local xxmlist={}
for i,v in pairs(xmlist)do
if not itemsConfig.isMoney(i)then
xxmlist[i]=true
end
end
return rrlitems,xxmlist,xmRandList
end

function UIBaGuaLuWin:calcuItems2(itemid,xmlist)

local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
if ninglian_conf[1]and ninglian_conf[1].cost then
local _cost=ninglian_conf[1].cost[1]
if _cost and _cost[1]then
xmlist[_cost[1]]=true
end
end
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(itemid)
if fenjie_rand_reward and fenjie_rand_reward[3]then
xmlist[fenjie_rand_reward[3]]=true
end
return xmlist
end

function UIBaGuaLuWin:calcuItems3(rlitems,xmlist)
if rlitems and xmlist then
local list={}
for k,v in ipairs(rlitems)do
local itemid=v[1]
if not xmlist[itemid]then
list[#list+1]=v
end
end
for k,v in pairs(xmlist)do
list[#list+1]={k,2,xmflag=true}
end
return list
else
return rlitems
end
end
function UIBaGuaLuWin:calcuItems4(itemid,xmRandList,xmEquipType)
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(itemid)
if fenjie_rand_reward and fenjie_rand_reward[3]then
local temp=xmRandList[fenjie_rand_reward[3]]or{0,0,xmEquipType}

temp[1]=temp[1]+fenjie_rand_reward[1]
temp[2]=temp[2]+fenjie_rand_reward[2]

xmRandList[fenjie_rand_reward[3]]=temp
end
end

function UIBaGuaLuWin:freshRlItems()
local rlitems,xmlist,xmRandList=self:calcuItems()
self.rlitems=rlitems
self.xmRandList=xmRandList
rlitems=self:calcuItems3(rlitems,xmlist)
local len=#rlitems
local itemsList=self.itemsList
for i,v in ipairs(itemsList)do
local info=rlitems[i]
v:setActive(info~=nil)
if info then
local itemid=info[1]
local num=info[2]
local specialflag=info.xmflag
if specialflag then
local item={itemid=itemid}
local count=xmRandList[itemid]==nil and"???"or string.format("%d~%d",xmRandList[itemid][1],xmRandList[itemid][2])
local conf={showname=false,itemcount=count,showCountBG=true}
v:setChildPropData(self:getSelectFillData(i,item,conf))
else
local item={itemid=itemid}
local conf={showname=false,itemcount=num,showCountBG=num>1}
v:setChildPropData(self:getSelectFillData(i,item,conf))
end
end
end
self.btnRongLian:setActive(len>0)
self.itemBg:setActive(len>0)
end

function UIBaGuaLuWin:onLayout()
self.winlua:SetChildLocalPosY(self.pageCreater:getID(),0)
end

function UIBaGuaLuWin:getSelectFillData(index,item,conf)
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[DataPropKey.eItemIndex]=index
return prop
end

function UIBaGuaLuWin:showSelectPanel()
self.tempFilterData=table.deepCopy(self.filterData)
self.tempTwoFilterData=table.deepCopy(self.twoFilterData)
self.isShowSelectPanel=true
self.winlua:SetChildDOLocalMoveX(self.selectPanel:getID(),0,0.3)
self.winlua:SetChildLocalPosY(self.pageCreater:getID(),0)
self.selectPanelMask:setActive(true)
self:refreshSelectPanel()
end

function UIBaGuaLuWin:closeSelectPanel()
self.tempFilterData=nil
self.isShowSelectPanel=false
self.winlua:SetChildDOLocalMoveX(self.selectPanel:getID(),-1500,0.3)
self.selectPanelMask:setActive(false)
self.pageCreater:setChildLayoutGroupCreateItems(0)
end



function UIBaGuaLuWin:refreshSelectPanel()
self:freshSelectNum()

local selectBagType=self.selectBagType
local filterTypeCfgs=_filterTypeCfgs[selectBagType]

local temp={}
if not self.highset then
for i,v in ipairs(filterTypeCfgs)do
if not v.reverse then
temp[#temp+1]=v
end
end
else
temp=filterTypeCfgs
end

self.filterTypeCfgs=temp

local len=#temp

self.pageCreater:setChildLayoutGroupCreateItems(len)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
self:refreshPageItem(item,i)
end

local isShowBtnSetting=self.selectBagType~=BAG_TYPE.eItemBag
self.btnSetting:setActive(isShowBtnSetting)
end

function UIBaGuaLuWin:refreshPageItem(widget,pageidx)
local selectBagType=self.selectBagType
local filterTypeCfg=_filterTypeCfgs[selectBagType][pageidx]
local filterType=filterTypeCfg.filterType
local filterCfg=_filterLookupCfg[selectBagType][filterType]

local name=filterCfg.name
local list=filterCfg.list
local line=filterCfg.line or false
local showfilter=filterCfg.filter or false
local reverse=filterCfg.reverse
local selectAll=self:isSelectAll(selectBagType,pageidx)

widget:SetChildText(0,name)

local len=#list
widget:SetChildLayoutGroupCreateItems(1,len)
local grids=widget:GetChildLayoutGroupGridList(1)
for i=1,len do
local item=grids[i-1]
self:refreshChildItem(item,filterType,i,pageidx)
end
widget:SetChildToggleChange(4,nil)
widget:SetChildToggle(4,selectAll)
widget:SetChildActive(5,selectAll)
widget:SetChildToggleChange(4,function(name,isOn)
if selectBagType~=self.selectBagType then return end
self:selectPageAll(selectBagType,pageidx,isOn)
self:freshSinglePageToggle(selectBagType,pageidx)
self:freshSelectNum()
end)
local vis=reverse and showfilter
widget:SetChildActive(3,vis)
if vis then
local selectBagType=self.selectBagType
local isEquipBag=selectBagType==BAG_TYPE.eEquipBag

local bagName=_filterTypeName[selectBagType]
local tips1='（      拥有勾选的套装和随机属性的装备将不会被筛选熔炼，仅针对'
local tips2='（      拥有勾选的五行和炼化属性的法宝将不会被筛选熔炼，仅针对'
local tips=isEquipBag and tips1 or tips2
local tipelse=isEquipBag and'的装备生效）'or'的法宝生效）'
local filter=self.tempTwoFilterData[selectBagType]or 1
local options=self:getOptions()

widget:SetChildText(2,tips)
widget:SetChildText(6,tipelse)
widget:SetChildDropDownOption(7,options)
widget:SetChildDropDownValue(7,filter-1)
widget:SetChildDropDownChangeAction(7,function(idx)
local index=idx+1
local select=self.tempTwoFilterData[selectBagType]or 1
if select==index then return end
self.tempTwoFilterData[selectBagType]=index
self:freshSelectNum()
end)
end
end

function UIBaGuaLuWin:freshSinglePageToggle(bagType,pageidx)
local filterTypeCfg=_filterTypeCfgs[bagType][pageidx]
local filterType=filterTypeCfg.filterType
local filterCfg=_filterLookupCfg[bagType][filterType]
local list=filterCfg.list
local len=#list
local widget=self.pageCreater:getChildLayoutGroupGridItem(pageidx-1)
local grids=widget:GetChildLayoutGroupGridList(1)
for i=1,len do
local item=grids[i-1]
self:refreshChildItemToggle(item,filterType,i,pageidx)
end
local selectAll=self:isSelectAll(bagType,pageidx)

widget:SetChildToggleChange(4,nil)
widget:SetChildActive(5,selectAll)
widget:SetChildToggle(4,selectAll)
widget:SetChildToggleChange(4,function(name,isOn)
if bagType~=self.selectBagType then return end
self:selectPageAll(bagType,pageidx,isOn)
self:freshSinglePageToggle(bagType,pageidx)
self:freshSelectNum()
end)
end

function UIBaGuaLuWin:isSelectAll(bagType,pageidx)
local filterTypeCfg=_filterTypeCfgs[bagType][pageidx]
local filterType=filterTypeCfg.filterType
local filterCfg=_filterLookupCfg[bagType][filterType]
local list=filterCfg.list
local bagFilterData=self.tempFilterData[bagType]or{}
local filterData=bagFilterData[filterType]or{}
local isSelect=true
for i,v in ipairs(list)do
isSelect=isSelect and(filterData[i]or false)
if not isSelect then return false end
end
return true
end

function UIBaGuaLuWin:selectPageAll(bagType,pageidx,select)
local filterTypeCfg=_filterTypeCfgs[bagType][pageidx]
local filterType=filterTypeCfg.filterType
local filterCfg=_filterLookupCfg[bagType][filterType]
local list=filterCfg.list
if self.tempFilterData==nil then self.tempFilterData={}end
if self.tempFilterData[bagType]==nil then self.tempFilterData[bagType]={}end
if self.tempFilterData[bagType][filterType]==nil then self.tempFilterData[bagType][filterType]={}end
for i,v in ipairs(list)do
self.tempFilterData[bagType][filterType][i]=select
end
end

function UIBaGuaLuWin:refreshChildItemToggle(item,filterType,idx,pageidx)
local selectBagType=self.selectBagType
local tempFilterData=self.tempFilterData or{}
local bagFilterData=tempFilterData[selectBagType]or{}
local filterData=bagFilterData[filterType]or{}
local isSelect=filterData[idx]or false
item:SetChildToggleChange(0,nil)
item:SetChildToggle(0,isSelect)
item:SetChildToggleChange(0,function(name,isOn)
if self.selectBagType~=selectBagType then return end
if self.tempFilterData==nil then self.tempFilterData={}end
if self.tempFilterData[selectBagType]==nil then self.tempFilterData[selectBagType]={}end
if self.tempFilterData[selectBagType][filterType]==nil then self.tempFilterData[selectBagType][filterType]={}end
self.tempFilterData[selectBagType][filterType][idx]=isOn
self:freshSinglePageToggle(selectBagType,pageidx)
self:freshSelectNum()
end)
end

function UIBaGuaLuWin:refreshChildItem(item,filterType,idx,pageidx)
local selectBagType=self.selectBagType
local filterCfg=_filterLookupCfg[selectBagType][filterType]
local list=filterCfg.list
local info=list[idx]
local assetname=info.bgAsset
local bundlename=info.bgBundle or _bgBundle
local native=filterCfg.native or false
item:SetChildCSImageIcon(2,'',native)
local name=info.nameFunc()
local tempFilterData=self.tempFilterData or{}
local bagFilterData=tempFilterData[selectBagType]or{}
local filterData=bagFilterData[filterType]or{}
local isSelect=filterData[idx]or false
item:SetChildToggleChange(0,nil)
item:SetChildToggle(0,isSelect)
item:SetChildToggleChange(0,function(name,isOn)
if self.selectBagType~=selectBagType then return end
if self.tempFilterData==nil then self.tempFilterData={}end
if self.tempFilterData[selectBagType]==nil then self.tempFilterData[selectBagType]={}end
if self.tempFilterData[selectBagType][filterType]==nil then self.tempFilterData[selectBagType][filterType]={}end
self.tempFilterData[selectBagType][filterType][idx]=isOn
self:freshSinglePageToggle(selectBagType,pageidx)
self:freshSelectNum()
end)
item:SetChildText(1,name)
if assetname then
item:SetChildActive(2,true)
item:SetChildCSImageSprite(2,bundlename,assetname)
else
item:SetChildActive(2,false)
end
end

function UIBaGuaLuWin:freshSettingBtn()
local vis=self.highset or false
self.openflag:setActive(not vis)
self.closeflag:setActive(vis)
self.txtSetting:setText(vis and'高级设置'or'基础设置')
end

function UIBaGuaLuWin:freshSelectNum()
local list=self:getFilterList(self.tempFilterData,self.tempTwoFilterData)
local selectCount=#list
local str=""
if selectCount<=0 then
str=FMT.fmt("熔炼数量: <color=#D00000>{0}</color>",selectCount)
else
str=FMT.fmt("熔炼数量: {0}",selectCount)
end
self.selectCount:setText(str)
end

function UIBaGuaLuWin:getFilterList(filterData,twofilterData)
filterData=filterData or{}
local filter={}
local selectBagType=self.selectBagType
local bagFilterCfgs=_filterLookupCfg[selectBagType]
local bagFilterData=filterData[selectBagType]or{}
local filterList=_filterTypeCfgs[selectBagType]


local hasSelect=false
local noSelectCache={}
for _,vt in pairs(filterList)do
local filterType=vt.filterType
local filterCfgs=bagFilterCfgs[filterType]
local list=filterCfgs.list
local reverse=filterCfgs.reverse or false
local filterTypeData=bagFilterData[filterType]or{}
local has=false
for i,v in ipairs(list)do
local isToggle=filterTypeData[i]or false
if isToggle then
if filter[filterType]==nil then filter[filterType]={}end
if filterType==ITEM_FILTER_TYPE.eEquipRandomAttr then
filter[filterType][1]=ITEM_FILTER_COMPARE.eAnd
else
filter[filterType][1]=ITEM_FILTER_COMPARE.eEquals
end
if reverse then

else
if filter[filterType][2]==nil then filter[filterType][2]={}end
local filterTable=filter[filterType][2]
filterTable[#filterTable+1]=v.compareType
if not reverse then
hasSelect=true
end
end
end
has=has or isToggle
end

if not has then
if reverse then
noSelectCache[filterType]=true
else
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType]={ITEM_FILTER_COMPARE.eEquals,-1}
end
end
end




for _,vt in pairs(filterList)do
local filterType=vt.filterType
if noSelectCache[filterType]then
local filterCfgs=bagFilterCfgs[filterType]
local list=filterCfgs.list
for i,v in ipairs(list)do
local flag=false
if hasSelect then
flag=true
end
if flag then
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType]={ITEM_FILTER_COMPARE.eNot,{-1}}
else
filter[filterType]={ITEM_FILTER_COMPARE.eEquals,{-1}}
end
end
end
end

if selectBagType==BAG_TYPE.eFabaoBag then
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eNot,{FABAO_TYPE.eBenMing}}
elseif selectBagType==BAG_TYPE.eItemBag then

filter[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eFabaoYuanPei}}
end
filter[ITEM_FILTER_TYPE.eIsLock]=false

local itemsList=bagControl.getBagItemsByFilter(selectBagType,filter,false)


local flag=false
local filter={}
local filterTwoIdx=twofilterData[selectBagType]or 1
local twolist=_filterTwoLookupCfg[selectBagType]
for _,vt in pairs(filterList)do
local filterType=vt.filterType
local filterCfgs=bagFilterCfgs[filterType]
local list=filterCfgs.list
local reverse=filterCfgs.reverse or false
if reverse then
local has=false
local filterTypeData=bagFilterData[filterType]or{}
for i,v in ipairs(list)do
local isToggle=filterTypeData[i]or false
if isToggle then
has=true
flag=true
if filter[filterType]==nil then filter[filterType]={}end
filter[filterType][1]=ITEM_FILTER_COMPARE.eEquals
if filter[filterType][2]==nil then filter[filterType][2]={}end
local temp=filter[filterType][2]
temp[#temp+1]=v.compareType
end
end
if has and filter[ITEM_FILTER_TYPE.eColor]==nil then
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{twolist[filterTwoIdx].compareType}}
end
end
end
if flag then

local itemsList1=bagControl.getBagItemsByFilter(selectBagType,filter,false)

local skipFunc=function(item)
for i,v in ipairs(itemsList1)do
if v.itemguid==item.itemguid then
return true
end
end
return false
end
local temp={}
for i,v in ipairs(itemsList)do
if not skipFunc(v)then
temp[#temp+1]=v
end
end
itemsList=temp
end
return itemsList
end


































function UIBaGuaLuWin:getOptions()
local temp={}
local list=_filterTwoLookupCfg[self.selectBagType]
for i,v in ipairs(list)do
temp[#temp+1]=v.nameFunc()
end
return temp
end




function UIBaGuaLuWin:onRongLian()
if self.isRonglian then return end
self.isRonglian=true
tipsManager.closeTips()

AudioManager.playAudio(561)
self.winlua:SetChildShowEffect(self.effect1:getID(),10131,true)
self.winlua:SetChildShowEffect(self.effect2:getID(),10132,true)
self:startBehavior()
end

function UIBaGuaLuWin:onClickBg()

end

function UIBaGuaLuWin:onClickLuzi()

end

function UIBaGuaLuWin:onRongLianAni()
self.isRonglian=false
self:freshInfo()
self.raycast:setActive(false)
end


function UIBaGuaLuWin:startBehavior()
local selectGUIDList={}
local startposList={}
local len=0
local max=math.min(#self.selectGUIDList,5)
for i,v in ipairs(self.bagList)do
if len>=max then break end
local itemguid=v.itemguid
local guidStr=tostring(itemguid)
if self.selectLookup[guidStr]then
local idx,subIdx=self:getBagItemIdx(itemguid)
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==idx-1 then
local widget=item.Widget:GetChildWidgetBase(subIdx)
len=len+1
local pos1=widget:GetChildPosition(0)
startposList[#startposList+1]=pos1
selectGUIDList[#selectGUIDList+1]=itemguid
break
end
end
end
end
self.btnRongLian:setActive(false)
self.raycast:setActive(true)
if#startposList<=0 then return end
local flag=0
for i=1,5 do
local itemguid=selectGUIDList[i]
if itemguid then
flag=flag+math.pow(2,i-1)
end
end

local parent=self.flyRoot:getID()
local target=self.effect:getID()
local pos=self.winlua:GetChildPosition(target)
local initData=
{
stateId=flag,
widget=self.winlua,
target=target,
parent=parent,
pos=pos,

startpos1=startposList[1],
startpos2=startposList[2],
startpos3=startposList[3],
startpos4=startposList[4],
startpos5=startposList[5],

duration1=1,
duration2=1.1,
duration3=1.2,
duration4=1.3,
duration5=1.4,


eSlider1=Vector2.New(0.3,0.4),
oSlider1=Vector2.New(0.3,0.4),

eSlider2=Vector2.New(0.1,0.2),
oSlider2=Vector2.New(0.1,0.2),

eSlider3=Vector2.New(0,0),
oSlider3=Vector2.New(0,0),

eSlider4=Vector2.New(-0.1,-0.2),
oSlider4=Vector2.New(-0.1,-0.2),

eSlider5=Vector2.New(-0.3,-0.4),
oSlider5=Vector2.New(-0.3,-0.4),
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree(btType.bt_ui_bagualu_fly,nil,true,initData)
end

function UIBaGuaLuWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIBaGuaLuWin:saveLocalSetting()
local typo=ACTOR_SETTING_TYPE.eFilterSetting
local temp={}
for bagType,v in pairs(self.filterData)do
local s_bagType=FMT.fmt('s{0}',bagType)
temp[s_bagType]={}
for filterType,vv in pairs(v)do
local s_filterType=FMT.fmt('s{0}',filterType)
temp[s_bagType][s_filterType]={}
for idx,vvv in pairs(vv)do
local s_idx=FMT.fmt('s{0}',idx)
temp[s_bagType][s_filterType][s_idx]=vvv
end
end
end
userActorArraySetting.set(typo,'bagualufilterEx',temp)

local temp={}
for bagType,v in pairs(self.twoFilterData or{})do
local s_bagType=FMT.fmt('s{0}',bagType)
temp[s_bagType]=v
end
userActorArraySetting.set(typo,'bagualutwofilterEx',temp)

userActorArraySetting.flush(typo)
end

function UIBaGuaLuWin:readLocalSetting()
local typo=ACTOR_SETTING_TYPE.eFilterSetting
local setting=userActorArraySetting.get(typo,'bagualufilterEx',nil)


if setting==nil then
self.filterData=self.defaultFilter
self.twoFilterData={}
self:saveLocalSetting()
return
end
local temp={}
for s_bagType,v in pairs(setting)do
local bagType=string.replace(s_bagType,'s','')
bagType=tonumber(bagType)
temp[bagType]={}
for s_filterType,vv in pairs(v)do
local filterType=string.replace(s_filterType,'s','')
filterType=tonumber(filterType)
temp[bagType][filterType]={}
for s_idx,vvv in pairs(vv)do
local idx=string.replace(s_idx,'s','')
idx=tonumber(idx)
temp[bagType][filterType][idx]=vvv
end
end
end
self.filterData=temp

local temp={}
local setting=userActorArraySetting.get(typo,'bagualutwofilterEx',{})
for s_bagType,v in pairs(setting)do
local bagType=string.replace(s_bagType,'s','')
bagType=tonumber(bagType)
temp[bagType]=v
end
self.twoFilterData=temp
end

function UIBaGuaLuWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIBaGuaLuWin_rank_Equip_%d'
d.showBlack=true

if self.selectBagType then
if self.selectBagType==BAG_TYPE.eEquipBag then
d.name='UIBaGuaLuWin_rank_Equip_%d'
elseif self.selectBagType==BAG_TYPE.eFabaoBag then
d.name='UIBaGuaLuWin_rank_Fabao_%d'
elseif self.selectBagType==BAG_TYPE.eItemBag then
d.name='UIBaGuaLuWin_rank_YuanPei_%d'
end
end

UIManager:showWindow('UIRuleWin',d)
end


function UIBaGuaLuWin:TeQuanRefresh()

self.gdpanel:setActive(false)
if self.selectBagType and self.monthInvestorCfg and self.monthInvestorCfg[2]then
local highMonthCfg=self.monthInvestorCfg[2]
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)

self.tqluck:setActive(not isActive)
self.lightbg:setActive(isActive)
if self.selectBagType==BAG_TYPE.eEquipBag then
self.gdpanel:setActive(true)
elseif self.selectBagType==BAG_TYPE.eFabaoBag then
self.gdpanel:setActive(true)
end
end
end

function UIBaGuaLuWin:onTqbtn()



if self.selectBagType and self.monthInvestorCfg and self.monthInvestorCfg[2]then
local highMonthCfg=self.monthInvestorCfg[2]
local fhtqListText_cfg=highMonthCfg.fhtqListText
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)

if self.selectBagType==BAG_TYPE.eEquipBag then
self.gdpanel:setActive(true)
if fhtqListText_cfg and fhtqListText_cfg[yuekafanhuantype.eEquip]then
local idx=isActive and 2 or 1
local str=fhtqListText_cfg[yuekafanhuantype.eEquip][idx]or""
str=FMT.fmt("<color=#f1ce78>{0}</color>",str)
self:showWindow('UICommonHelpE',{content=str,posx=225,posy=212})
end
elseif self.selectBagType==BAG_TYPE.eFabaoBag then
self.gdpanel:setActive(true)
if fhtqListText_cfg and fhtqListText_cfg[yuekafanhuantype.eFabao]then
local idx=isActive and 2 or 1
local str=fhtqListText_cfg[yuekafanhuantype.eFabao][idx]or""
str=FMT.fmt("<color=#f1ce78>{0}</color>",str)
self:showWindow('UICommonHelpE',{content=str,posx=225,posy=212})
end
end
end
end

function UIBaGuaLuWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshLockFlag(itemguid)
end

function UIBaGuaLuWin:freshLockFlag(guid)
if self==nil or self.isClose then return end
if guid==nil then return end

local guidStr=tostring(guid)
local flag=self.selectLookup[guidStr]or false
if flag then
local item=bagModel.getItem(guid)
if item and bagHelper.isLock(item)then
self.selectLookup[guidStr]=false
for i,v in ipairs(self.selectGUIDList)do
if v==guid then
table.remove(self.selectGUIDList,i)
break
end
end
self:freshRlItems()
end
end
local flag=self.selectLookup[guidStr]or false
self:freshSelectSingleGirid(guid,flag)
end
