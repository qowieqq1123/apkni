





itemsFilterHelper={}

local _cache={}
local _cache1={}
local _clear=table.clear





local _idx=0
local getIdx=function()
_idx=_idx+1
return _idx
end

FILTER_CACHE_TABLE={}

ITEM_FILTER_COMPARE=
{
eAnd='eAnd',

eNot='eNot',
eNotNull='eNotNull',

eLess='eLess',
eLessEqulas='eLessEqulas',
eEquals='eEquals',
eGreaterEquals='eGreaterEquals',
eGreater='eGreater',
eMatchType='eMatchType',
}

_idx=0

ITEM_FILTER_TYPE=
{
eItemid=getIdx(),
eItemguid=getIdx(),
eColor=getIdx(),
eStage=getIdx(),
eElement=getIdx(),
eAnyElement=getIdx(),
eSuitEquip=getIdx(),
eWeapon=getIdx(),
eEquipType1=getIdx(),
eEquipWeaponVoc=getIdx(),
eItemType=getIdx(),
eItemConfigAttr=getIdx(),
eItemFuncType=getIdx(),
eFight=getIdx(),
eIsDress=getIdx(),
eIsLock=getIdx(),
eFunc=getIdx(),
eItemType1=getIdx(),
eItemType2=getIdx(),
eItemType1AndType2=getIdx(),
eFabaoJinglian=getIdx(),
eEquipAttr=getIdx(),
eEquipRandomAttr=getIdx(),
eFabaoLianhuaAttr=getIdx(),
eFubaoRandomAttr=getIdx(),
eJinglianLv=getIdx(),
eStarLv=getIdx(),
eDressVoc=getIdx(),
eFaBaoMaterialsType=getIdx(),
eCheckOtherFaBaoOwner=getIdx(),
eFabaoLingXingLv=getIdx(),
eYuanPeiOwnerFabaoType=getIdx(),
eMountType=getIdx(),
eCheckEquipDress=getIdx(),
eCheckHide=getIdx(),
eBagType=getIdx(),
eFaBaoMaterialsFuncType=getIdx(),
eDianHuaEquip=getIdx(),
eDiscipleId=getIdx(),
eIsBinding=getIdx(),
eIsSpecialWire=getIdx(),
eIsBenMingFabao=getIdx(),
eFubaoAttr=getIdx(),
eFubaoRandomSixAttr=getIdx(),
eFubaoRandomAttrProfessionExp=getIdx(),
eFubaoRandomAttrGongFaExp=getIdx(),
eFubaoZhenTu=getIdx(),
eIsEquipQiangHua=getIdx(),
eIsFaBaoQiangHua=getIdx(),
eFaBaoMaterialsLianhuaAttr=getIdx(),
eXingChenRongHe=getIdx(),
eXingChenCiZhui=getIdx(),
eXingChenZhenXi=getIdx(),
eEquipXMType=getIdx(),
eBagEquipType=getIdx(),
eXingChenRongHeChild=getIdx(),
eFaBaoYuanPeiLianZhiMaterial=getIdx(),
eFubaoEffectType=getIdx(),
}


local _filterFunc={
[ITEM_FILTER_TYPE.eItemConfigAttr]=
{
[ITEM_FILTER_COMPARE.eNotNull]=function(...)
return itemsFilterHelper.isItemConfigAttrNotNull(...)
end,
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isItemConfigAttrEquals(...)
end,

},

[ITEM_FILTER_TYPE.eItemType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemMainType(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEqulsItemMainType(...)
end,
},


[ITEM_FILTER_TYPE.eItemType1]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemType1(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEqulsItemType1(...)
end,
},

[ITEM_FILTER_TYPE.eItemType2]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemType2(...)
end,
},

[ITEM_FILTER_TYPE.eItemType1AndType2]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemType1AndType2(...)
end,
},

[ITEM_FILTER_TYPE.eItemid]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemid(...)
end,
},

[ITEM_FILTER_TYPE.eItemguid]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemguid(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotItemguid(...)
end,
},
[ITEM_FILTER_TYPE.eColor]={
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsColor(...)
end,
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsColor(...)
end,
[ITEM_FILTER_COMPARE.eLessEqulas]=function(...)
return itemsFilterHelper.isLessEqualsColor(...)
end,
},

[ITEM_FILTER_TYPE.eStage]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsStage(...)
end,
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsStage(...)
end,

[ITEM_FILTER_COMPARE.eLessEqulas]=function(...)
return itemsFilterHelper.isLessEqualsStage(...)
end,
},
[ITEM_FILTER_TYPE.eElement]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsElement(...)
end,
[ITEM_FILTER_COMPARE.eNotNull]=function(...)
return itemsFilterHelper.isElementNotNull(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEqulsElement(...)
end,
},
[ITEM_FILTER_TYPE.eAnyElement]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsAnyElement(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEqulsAnyElement(...)
end,
},

[ITEM_FILTER_TYPE.eWeapon]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsWeapon(...)
end,
},
[ITEM_FILTER_TYPE.eSuitEquip]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsSuit(...)
end,
},

[ITEM_FILTER_TYPE.eEquipType1]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipType1(...)
end,
},

[ITEM_FILTER_TYPE.eEquipWeaponVoc]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipWeaponVoc(...)
end,
},

[ITEM_FILTER_TYPE.eItemFuncType]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsItemFuncType(...)
end,

},

[ITEM_FILTER_TYPE.eFight]=
{
[ITEM_FILTER_COMPARE.eGreater]=function(...)
return itemsFilterHelper.isGreaterFight(...)
end,

},

[ITEM_FILTER_TYPE.eIsDress]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsDress(...)
end,

},

[ITEM_FILTER_TYPE.eIsLock]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsLock(...)
end,

},

[ITEM_FILTER_TYPE.eFunc]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFunc(...)
end,
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsFunc(...)
end,
[ITEM_FILTER_COMPARE.eLessEqulas]=function(...)
return itemsFilterHelper.isLessEqualsFunc(...)
end,
},

[ITEM_FILTER_TYPE.eFabaoJinglian]=
{
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsFabaoJinglian(...)
end,
[ITEM_FILTER_COMPARE.eLessEqulas]=function(...)
return itemsFilterHelper.isLessEqualsFabaoJinglian(...)
end,
},
[ITEM_FILTER_TYPE.eEquipAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndEquipAttr(...)
end,
},
[ITEM_FILTER_TYPE.eEquipRandomAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndEquipRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEquipRandomAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFabaoLianhuaAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFabaoLianhuaAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndFabaoLianhuaAttr(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotEqualsFabaoLianhuaAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoRandomAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndFubaoRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotFubaoRandomAttr(...)
end,
},
[ITEM_FILTER_TYPE.eJinglianLv]=
{
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsJingLianLv(...)
end,
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsJingLianLv(...)
end,
},
[ITEM_FILTER_TYPE.eStarLv]=
{
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsStarLv(...)
end,
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsStarLv(...)
end,
},
[ITEM_FILTER_TYPE.eDressVoc]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsDressVoc(...)
end,
},
[ITEM_FILTER_TYPE.eFaBaoMaterialsType]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFaBaoMaterialsType(...)
end,
},
[ITEM_FILTER_TYPE.eCheckOtherFaBaoOwner]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsOtherFaBaoOwner(...)
end,

[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotOtherFaBaoOwner(...)
end,
},
[ITEM_FILTER_TYPE.eFabaoLingXingLv]=
{
[ITEM_FILTER_COMPARE.eGreaterEquals]=function(...)
return itemsFilterHelper.isGreaterEqualsFabaoLingXingLv(...)
end,
},
[ITEM_FILTER_TYPE.eYuanPeiOwnerFabaoType]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsYuanPeiOwnerFabaoType(...)
end,
},
[ITEM_FILTER_TYPE.eMountType]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsMountType(...)
end,
},
[ITEM_FILTER_TYPE.eCheckEquipDress]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipDress(...)
end,
},
[ITEM_FILTER_TYPE.eCheckHide]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsHide(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return not itemsFilterHelper.isEqualsHide(...)
end,
},

[ITEM_FILTER_TYPE.eBagType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsItemBagType(...)
end,
},

[ITEM_FILTER_TYPE.eFaBaoMaterialsFuncType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsFaBaoMaterialsFuncType(...)
end,
},
[ITEM_FILTER_TYPE.eDianHuaEquip]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsDianHuaEquip(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotDianHuaEquip(...)
end,
},
[ITEM_FILTER_TYPE.eDiscipleId]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsDiscipleId(...)
end,
},

[ITEM_FILTER_TYPE.eIsBinding]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsBinding(...)
end,

},
[ITEM_FILTER_TYPE.eIsSpecialWire]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsSpecialWire(...)
end,

},
[ITEM_FILTER_TYPE.eIsBenMingFabao]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isBenMingFabao(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoRandomSixAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndFubaoRandomAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoRandomAttrProfessionExp]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndFubaoRandomAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoRandomAttrGongFaExp]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoRandomAttr(...)
end,
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndFubaoRandomAttr(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoZhenTu]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFubaoZhenTu(...)
end,
},
[ITEM_FILTER_TYPE.eIsEquipQiangHua]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsEquipQiangHua(...)
end,
},
[ITEM_FILTER_TYPE.eIsFaBaoQiangHua]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFaBaoQiangHua(...)
end,
},
[ITEM_FILTER_TYPE.eFaBaoMaterialsLianhuaAttr]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsFaBaoMaterialsLianhuaAttr(...)
end,
},
[ITEM_FILTER_TYPE.eXingChenRongHe]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsXingChenRongHe(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return not itemsFilterHelper.isEqualsXingChenRongHe(...)
end,
},
[ITEM_FILTER_TYPE.eXingChenRongHeChild]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsXingChenChildRongHe(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return not itemsFilterHelper.isEqualsXingChenChildRongHe(...)
end,
},
[ITEM_FILTER_TYPE.eXingChenCiZhui]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsXingChenCiZhui(...)
end,
},
[ITEM_FILTER_TYPE.eXingChenZhenXi]=
{
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqualsXingChenZhenXi(...)
end,
},
[ITEM_FILTER_TYPE.eEquipXMType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isEqulsXMItemguid(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotXMItemguid(...)
end,
},
[ITEM_FILTER_TYPE.eBagEquipType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isBagEquipType(...)
end,
},
[ITEM_FILTER_TYPE.eFaBaoYuanPeiLianZhiMaterial]={
[ITEM_FILTER_COMPARE.eAnd]=function(...)
return itemsFilterHelper.isAndYuanPeiLianZhiMaterial(...)
end,
[ITEM_FILTER_COMPARE.eNot]=function(...)
return itemsFilterHelper.isNotYuanPeiLianZhiMaterial(...)
end,
},
[ITEM_FILTER_TYPE.eFubaoEffectType]={
[ITEM_FILTER_COMPARE.eEquals]=function(...)
return itemsFilterHelper.isFubaoEffectType(...)
end,
},
}





function itemsFilterHelper.filterItems(list,filter,useCache)
local temp
if useCache then
_clear(_cache)
temp=_cache
else
temp={}
end
if list==nil then return temp end
for _,v in ipairs(list)do
if itemsFilterHelper.isFilter(filter,v)then
temp[#temp+1]=v
end
end
return temp
end


function itemsFilterHelper.filterLookItems(look,filter,useCache)
local temp
if useCache then
_clear(_cache)
temp=_cache
else
temp={}
end
if look==nil then return temp end
for _,v in pairs(look)do
if itemsFilterHelper.isFilter(filter,v)then
temp[#temp+1]=v
end
end
return temp
end

function itemsFilterHelper.hasFilterItem(look,filter)
if look==nil then return false end
for _,v in pairs(look)do
if itemsFilterHelper.isFilter(filter,v)then
return true
end
end
return false
end









function itemsFilterHelper.isFilter(filter,item)
if filter==nil then return true end
for filterType,filterTable in pairs(filter)do
if not itemsFilterHelper.isFilterByType(filterType,filterTable,item)then
return false
end
end
return true
end


function itemsFilterHelper.isFilterByType(filterType,filterTable,item)
if filterType==nil then return end
local compareType
local filterVal

if filterTable==nil then
return true
end
if type(filterTable)~='table'then
compareType=ITEM_FILTER_COMPARE.eEquals
_clear(_cache1)
_cache1[#_cache1+1]=filterTable
filterVal=_cache1
else
local isIpairs=true
local isPaires=true
for k,v in pairs(filterTable)do
local typeK=type(k)
if typeK=='string'then
isIpairs=false
elseif typeK=='number'then
isPaires=false
end
end
if isIpairs and isPaires then
loggerUtil.logErrFMT('筛选参数错误')
return true
end
if isIpairs then
compareType=filterTable[1]
filterVal=filterTable[2]
local isNotNull=compareType~=ITEM_FILTER_COMPARE.eNotNull
if isNotNull and filterVal==nil then return true end
if isNotNull and type(filterVal)~='table'then
_clear(_cache1)
_cache1[#_cache1+1]=filterVal
filterVal=_cache1
end
else
for compareType,filterVal in pairs(filterTable)do
if not itemsFilterHelper.doFunc(filterType,compareType,filterVal,item)then
return false
end
end
return true
end
end
return itemsFilterHelper.doFunc(filterType,compareType,filterVal,item)
end

function itemsFilterHelper.doFunc(filterType,compareType,filterVal,item)
if compareType==nil then
compareType=ITEM_FILTER_COMPARE.eEquals
end
local funcTable=_filterFunc[filterType]
if funcTable then
local func=funcTable[compareType]
if func then
return func(item,filterVal)
end
end
return true
end





function itemsFilterHelper.isGreaterEqualsColor(item,filterColor)
if filterColor==nil then
return true
end
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemColor=config.color
return itemColor>=filterColor[1]
end

function itemsFilterHelper.isEqualsColor(item,filterColorList)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemColor=config.color
if filterColorList==nil then
return true
else
for i,v in ipairs(filterColorList)do
if v==itemColor then
return true
end
end
return false
end
end

function itemsFilterHelper.isLessEqualsColor(item,filterColor)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemColor=config.color
if filterColor==nil then
return true
else
return itemColor<=filterColor[1]
end
end


function itemsFilterHelper.isEqulsStage(item,filterStage)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemStage=config.stage
if filterStage==nil then
return true
else
for i,v in ipairs(filterStage)do
if v==itemStage then
return true
end
end
return false
end
end


function itemsFilterHelper.isGreaterEqualsStage(item,filterStage)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemStage=config.stage
if filterStage==nil then
return true
else
return itemStage>=filterStage[1]
end
end



function itemsFilterHelper.isLessEqualsStage(item,filterStage)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local itemStage=config.stage
if filterStage==nil then
return true
else
return itemStage<=filterStage[1]
end
end




function itemsFilterHelper.isEqulsElement(item,filterElement)
local itemid=item.itemid
local isFabao=itemsConfig.isFabao(itemid)
local itemMainElement=nil
if isFabao then
itemMainElement=fabaoHelper.getMainElement(item)
else
local config=itemsConfig.getConfig(itemid)
itemMainElement=config.element
end
if filterElement==nil or itemMainElement==nil then
return true
else
for i,v in ipairs(filterElement)do
if v==itemMainElement then
return true
end
end
return false
end
end


function itemsFilterHelper.isNotEqulsElement(item,filterElement)
local itemid=item.itemid
local isFabao=itemsConfig.isFabao(itemid)
local itemMainElement=nil
if isFabao then
itemMainElement=fabaoHelper.getMainElement(item)
else
local config=itemsConfig.getConfig(itemid)
itemMainElement=config.element
end
if filterElement==nil or itemMainElement==nil then
return true
else
for i,v in ipairs(filterElement)do
if v==itemMainElement then
return false
end
end
return true
end
end

function itemsFilterHelper.isElementNotNull(item,filterElement)
local itemid=item.itemid
local isFabao=itemsConfig.isFabao(itemid)
local itemMainElement=nil
if isFabao then
itemMainElement=fabaoHelper.getMainElement(item)
else
local config=itemsConfig.getConfig(itemid)
itemMainElement=config.element
end
return itemMainElement~=nil
end

local _isElement_A=function(elementList,element)
for i,v in ipairs(elementList)do
local elementType=fabaoConfig.getElementTypeByAttrid(v[1])
if element==elementType then return true end
end
return false
end

local _isElement_B=function(elementList,element)
if elementList==nil then return false end
for i,v in ipairs(elementList)do
local elementType=fabaoConfig.getElementTypeByAttrid(v.param_1)
if element==elementType then return true end
end
return false
end

function itemsFilterHelper.isEqulsAnyElement(item,filterElement)
if filterElement==nil then return true end
local itemid=item.itemid
local isFabao=itemsConfig.isFabao(itemid)
if isFabao then
local config=itemsConfig.getConfig(itemid)
local isElement
local elementList
if config.element then
elementList=config.element
isElement=_isElement_A
else
elementList=item.itemData.elementList
isElement=_isElement_B
end
for i,v in ipairs(filterElement)do
if isElement(elementList,v)then return true end
end
return false
else
local config=itemsConfig.getConfig(itemid)
local element=config.element
for i,v in ipairs(filterElement)do
if v==element then
return true
end
end
return false
end
end

function itemsFilterHelper.isNotEqulsAnyElement(item,filterElement)
if filterElement==nil then return true end
local itemid=item.itemid
local isFabao=itemsConfig.isFabao(itemid)
if isFabao then
local config=itemsConfig.getConfig(itemid)
local isElement
local elementList
if config.element then
elementList=config.element
isElement=_isElement_A
else
elementList=item.itemData.elementList
isElement=_isElement_B
end
for i,v in ipairs(filterElement)do
if isElement(elementList,v)then return false end
end
return true
else
local config=itemsConfig.getConfig(itemid)
local element=config.element
for i,v in ipairs(filterElement)do
if v==element then
return false
end
end
return true
end
end




function itemsFilterHelper.isEqulsItemMainType(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
if v==itemsConfig.getMainType(item.itemid)then
return true
end
end
return false
end
function itemsFilterHelper.isNotEqulsItemMainType(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
if v==itemsConfig.getMainType(item.itemid)then
return false
end
end
return true
end

function itemsFilterHelper.isEqulsItemType1(item,filterValList)
if filterValList==nil then
return true
end
local type1=itemsConfig.getConfig(item.itemid).type1

for i,v in ipairs(filterValList)do
if v=='nil'then v=nil end
if v==type1 then
return true
end
end
return false
end

function itemsFilterHelper.isNotEqulsItemType1(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
if v==itemsConfig.getConfig(item.itemid).type1 then
return false
end
end
return true
end

function itemsFilterHelper.isEqulsItemType2(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
if v==itemsConfig.getConfig(item.itemid).type2 then
return true
end
end
return false
end

function itemsFilterHelper.isEqulsItemType1AndType2(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
local cfg=itemsConfig.getConfig(item.itemid)
local type1=cfg.type1 or 0
local type2=cfg.type2 or 0
local num=100*type1+type2
if v==num then
return true
end
end
return false
end



function itemsFilterHelper.isEqulsItemid(item,filterVal)
if filterVal==nil then
return true
end
for i,v in ipairs(filterVal)do
if v==item.itemid then
return true
end
end
return false
end

function itemsFilterHelper.isEqulsItemguid(item,filterVal)
if filterVal==nil then
return true
end
for i,v in ipairs(filterVal)do
if v==item.itemguid then
return true
end
end
return false
end

function itemsFilterHelper.isNotItemguid(item,filterVal)
if filterVal==nil then
return true
end
for i,v in ipairs(filterVal)do
if v==item.itemguid then
return false
end
end
return true
end


function itemsFilterHelper.isEqualsSuit(item,filterSuitList)
if not itemsConfig.isEquip(item.itemid)then
return true
end
if filterSuitList==nil then
return true
end

if not item.itemData then
return false
end

for i,v in ipairs(filterSuitList)do
if v==item.itemData.suitid then
return true
end
end

return false
end


function itemsFilterHelper.isEqualsWeapon(item,filterWeapon)
local itemid=item.itemid
if not equipsHelper.isWeapon(itemid)or
not(itemsConfig.isEquip(itemid)or itemsConfig.isDaoBing(itemid))then
return true
end
if filterWeapon==nil then
return true
else
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local type2=config.type2
for i,v in ipairs(filterWeapon)do
if v==type2 then
return true
end
end
return false
end
end


function itemsFilterHelper.isEqualsEquipType1(item,filterType1)
local isEquip=itemsConfig.isEquip(item.itemid)
if not isEquip then
return true
end

if filterType1==nil then
return true
else
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
for i,v in ipairs(filterType1)do
if v==equipType then
return true
end
end
return false
end
end



function itemsFilterHelper.isEqualsEquipWeaponVoc(item,filterVoc)
if filterVoc==nil then
return true
else
local itemid=item.itemid
local isEquip=itemsConfig.isEquip(itemid)
local isDaoBing=itemsConfig.isDaoBing(itemid)
if isEquip then
for _,v in ipairs(filterVoc)do
if equipsHelper.canEquipWeaponByVoc(itemid,v)then
return true
end
end
elseif isDaoBing then
for _,v in ipairs(filterVoc)do
if daobingHelper.canDressByVoc(itemid,v)then
return true
end
end
end
return false
end
end


function itemsFilterHelper.isItemConfigAttrNotNull(item,filter)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
for _,v in ipairs(filter)do
if config[v]==nil then
return false
end
end
return true
end


function itemsFilterHelper.isItemConfigAttrEquals(item,filter)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
for i,v in ipairs(filter)do
local name=v[1]
local val=v[2]
if config[name]==val then return true end
end
return false
end

function itemsFilterHelper.isEqualsItemFuncType(item,filter)
local itemid=item.itemid
local config=itemsConfig.getConfig(itemid)
local funcparam=config.funcparam
for i,v in ipairs(filter)do
if funcparam and funcparam.type==v then
return true
end
end
return false
end

function itemsFilterHelper.isGreaterFight(item,filter)
local fight=0
if itemsConfig.isEquip(item.itemid)then
fight=equipsHelper.getEquipFightX(item.itemid,item.itemguid)
elseif itemsConfig.isFabao(item.itemid)then
fight=fabaoHelper.getBaseFight(item.itemid,item.itemguid)
elseif itemsConfig.isDaoBing(item.itemid)then
fight=daobingHelper.getEquipFightX(item.itemid,item.itemguid)
elseif itemsConfig.isMount(item.itemid)then
fight=mountHelper.getFight(item.itemid)
elseif itemsConfig.isVocEquip(item.itemid)then
fight=vocEquipHelper.getEquipFightX(item.itemid,item.itemguid)
end
if filter==nil then
return true
else
return fight>filter[1]
end
end

function itemsFilterHelper.isEqualsDress(item,filter)
local isDress=false
if itemsConfig.isEquip(item.itemid)then
isDress=equipsHelper.isDressed(item.itemguid)
elseif itemsConfig.isFabao(item.itemid)then
isDress=fabaoHelper.isDressed(item.itemguid)
elseif itemsConfig.isDaoBing(item.itemid)then
isDress=daobingModel:isEquipedOnAnyDizi(item.itemguid)
elseif itemsConfig.isMount(item.itemid)then
isDress=mountModel:isEquipedOnAnyDZ(item.itemguid)
elseif itemsConfig.isVocEquip(item.itemid)then
isDress=vocEquipModel:isEquipedOnAnyDizi(item.itemguid)
end
if filter==nil then
return true
else
return isDress==filter[1]
end
end

function itemsFilterHelper.isEqualsLock(item,filter)
local isLock=bagHelper.isLock(item)
local itemid=item.itemid
if filter==nil then
return true
else
return isLock==filter[1]
end
end

function itemsFilterHelper.isEqualsFunc(item,filter)
local itemid=item.itemid
local itemguid=item.itemguid
for i,v in ipairs(filter)do
local func=v[1]
local val=v[2]
if func and func(itemid,itemguid)==val then
return true
end
end
return false
end

function itemsFilterHelper.isGreaterEqualsFunc(item,filter)
local itemid=item.itemid
local itemguid=item.itemguid
for i,v in ipairs(filter)do
local func=v[1]
local val=v[2]
if func and func(itemid,itemguid)>=val then
return true
end
end
return false
end

function itemsFilterHelper.isLessEqualsFunc(item,filter)
local itemid=item.itemid
local itemguid=item.itemguid
for i,v in ipairs(filter)do
local func=v[1]
local val=v[2]
if func and func(itemid,itemguid)<=val then
return true
end
end
return false
end

function itemsFilterHelper.isGreaterEqualsFabaoJinglian(item,filter)
local jilianlv=item.itemData and item.itemData.jilianlv or 0
if filter==nil then
return true
else
return jilianlv>=filter[1]
end
return false
end

function itemsFilterHelper.isLessEqualsFabaoJinglian(item,filter)
local jilianlv=item.itemData and item.itemData.jilianlv or 0
if filter==nil then
return true
else
return jilianlv<=filter[1]
end
return false
end

function itemsFilterHelper.isEqualsEquipAttr(item,filter)
local itemguid=item.itemguid
local attrLookup=equipsHelper.getEquipAttrsLookupByItemguid(itemguid)
if filter==nil then return true end
for _,k in pairs(filter)do
if attrLookup[k]then return true end
end
return false
end

function itemsFilterHelper.isAndEquipAttr(item,filter)
local itemguid=item.itemguid
local attrLookup=equipsHelper.getEquipAttrsLookupByItemguid(itemguid)
if filter==nil then return true end
for _,k in pairs(filter)do
if not attrLookup[k]then return false end
end
return true
end

function itemsFilterHelper.isEqualsEquipRandomAttr(item,filter)
local attrLookup=equipsHelper.getRandomAttrLookup(item)
if filter==nil then return true end
for _,k in pairs(filter)do
if attrLookup[k]then return true end
end
return false
end

function itemsFilterHelper.isAndEquipRandomAttr(item,filter)
local attrLookup=equipsHelper.getRandomAttrLookup(item)
if filter==nil then return true end
for _,k in pairs(filter)do
if not attrLookup[k]then return false end
end
return true
end

function itemsFilterHelper.isNotEquipRandomAttr(item,filter)
local attrLookup=equipsHelper.getRandomAttrLookup(item)
if filter==nil then return true end
for _,k in pairs(filter)do
if attrLookup[k]then return false end
end
return true
end

function itemsFilterHelper.isEqualsFabaoLianhuaAttr(item,filter)
local attrLookup=fabaoHelper.getLianhuaAttrsLookup(item)
if attrLookup==nil then return false end
if filter==nil then return true end
for _,k in pairs(filter)do
if attrLookup[k]then return true end
end
return false
end

function itemsFilterHelper.isAndFabaoLianhuaAttr(item,filter)
local attrLookup=fabaoHelper.getLianhuaAttrsLookup(item)
if attrLookup==nil then return false end
if filter==nil then return true end
for _,k in pairs(filter)do
if not attrLookup[k]then return false end
end
return true
end

function itemsFilterHelper.isNotEqualsFabaoLianhuaAttr(item,filter)
local attrLookup=fabaoHelper.getLianhuaAttrsLookup(item)
if attrLookup==nil then return false end
if filter==nil then return true end
for _,k in pairs(filter)do
if attrLookup[k]then return false end
end
return true
end

function itemsFilterHelper.isEqualsFubaoRandomAttr(item,filter)
local attrLookup=UIFuLuFangModel.getFuBaoRandomAttrLookup(item)
if filter==nil then return true end
for _,v in pairs(filter)do
local etype=v[1]
local stype=v[2]
if attrLookup[etype]and attrLookup[etype][stype]then return true end
end
return false
end

function itemsFilterHelper.isAndFubaoRandomAttr(item,filter)
local attrLookup=UIFuLuFangModel.getFuBaoRandomAttrLookup(item)
if filter==nil then return true end
for _,v in pairs(filter)do
local etype=v[1]
local stype=v[2]
if not attrLookup[etype]or not attrLookup[etype][stype]then return false end
end
return true
end

function itemsFilterHelper.isNotFubaoRandomAttr(item,filter)
local attrLookup=UIFuLuFangModel.getFuBaoRandomAttrLookup(item)

if filter==nil then return true end
for _,v in pairs(filter)do
local etype=v[1]
local stype=v[2]
if attrLookup[etype]and attrLookup[etype][stype]then return false end
end
return true
end

function itemsFilterHelper.isEqualsJingLianLv(item,filter)
if filter==nil then return true end
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
for _,v in pairs(filter)do
if jinglianlv==v then return true end
end
return false
end

function itemsFilterHelper.isGreaterEqualsJingLianLv(item,filter)
if filter==nil then return true end
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
for _,v in pairs(filter)do
if jinglianlv>=v then return true end
end
return false
end

function itemsFilterHelper.isEqualsStarLv(item,filter)
if filter==nil then return true end
local star=item.itemData and item.itemData.star or 0
for _,v in pairs(filter)do
if star==v then return true end
end
return false
end

function itemsFilterHelper.isGreaterEqualsStarLv(item,filter)
if filter==nil then return true end
local star=item.itemData and item.itemData.star or 0
for _,v in pairs(filter)do
if star>=v then return true end
end
return false
end

function itemsFilterHelper.isEqualsDressVoc(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local type2=itemCfg.type2
local voclist=equipsHelper.getLimitVoc(type2)
if voclist==nil then return true end

local check=function(voc)
for i,v in ipairs(voclist)do
if v==voc then return true end
end
return false
end
for _,v in ipairs(filter)do
if check(v)then
return true
end
end
return false
end


function itemsFilterHelper.isEqualsFaBaoMaterialsType(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local mainid=fabaoHelper.getMainId(item)
if mainid==0 then return false end
local fbtype=itemsConfig.getConfig(mainid).type2
for i,v in ipairs(filter)do
if v==fbtype then return true end
end
return false
end


function itemsFilterHelper.isEqualsOtherFaBaoOwner(item,filter)
if filter==nil then return true end
local isBenMingFabao=fabaoConfig.isBenMingFabao(item.itemid)
if not isBenMingFabao then return false end
local hasowner,dzguid=benMingFaBaoHelper.hasOwnerByEquip(item)
if hasowner and dzguid~=filter[1]then
return true
end
return false
end


function itemsFilterHelper.isNotOtherFaBaoOwner(item,filter)
if filter==nil then return true end
local isBenMingFabao=fabaoConfig.isBenMingFabao(item.itemid)
if not isBenMingFabao then return true end
local hasowner,dzguid=benMingFaBaoHelper.hasOwnerByEquip(item)
if not hasowner then return true end
if dzguid~=filter[1]then return false end
return true
end


function itemsFilterHelper.isGreaterEqualsFabaoLingXingLv(item,filter)
if filter==nil then return true end
local isBenMingFabao=fabaoConfig.isBenMingFabao(item.itemid)
if not isBenMingFabao then return false end
local level=item.itemData and item.itemData.lingxinglv or 0
for _,v in pairs(filter)do
if level>=v then return true end
end
return false
end


function itemsFilterHelper.isEqualsYuanPeiOwnerFabaoType(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local isFabaoYuanPei=itemsConfig.isFabaoYuanPei(itemid)
if not isFabaoYuanPei then return false end
for i,v in ipairs(filter)do
if benMingFaBaoHelper.hasFabaoTypeByEquip(item,v)then
return true
end
end
return false
end

function itemsFilterHelper.isEqualsMountType(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local isMountType=itemsConfig.isMount(itemid)
if not isMountType then return false end
local type1=itemsConfig.getConfig(itemid).type1
for i,v in ipairs(filter)do
if type1==v then
return true
end
end
return false
end

function itemsFilterHelper.isEqualsEquipDress(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local itemguid=item.itemguid
for _,dzguid in ipairs(filter)do
if itemsConfig.isEquip(itemid)then
if equipsHelper.isCanDress(dzguid,itemid)then return true end
elseif itemsConfig.isFabao(itemid)then
if fabaoHelper.isCanDress(dzguid,itemid,itemguid)then return true end
elseif itemsConfig.isDaoBing(itemid)then
if daobingHelper.isCanDress(dzguid,itemguid)then return true end
elseif itemsConfig.isMount(itemid)then
if mountHelper.isCanDress(dzguid,itemid)then return true end
elseif itemsConfig.isClothing(itemid)then
if ClothingHelper.isCanDressEx(dzguid,itemguid)then return true end
elseif itemsConfig.isVocEquip(itemid)then
if vocEquipHelper.isCanDressEx(dzguid,itemguid)then return true end
end
end
return false
end

function itemsFilterHelper.isEqualsHide(item,filter)
if filter==nil then return true end
local itemid=item.itemid

if filter==nil then
return true
else
return itemsConfig.getConfig(itemid).hide==filter[1]
end
end

function itemsFilterHelper.isEqulsItemBagType(item,filterBagTpye)
if filterBagTpye==nil then return true end
local itemid=item.itemid

if filterBagTpye==nil then
return true
else
for _,v in ipairs(filterBagTpye)do
if itemsConfig.getBagType(itemid)==v then
return true
end
end
end
end

function itemsFilterHelper.isEqulsFaBaoMaterialsFuncType(item,filter)
if filter==nil then return true end
local itemid=item.itemid
if not itemsConfig.isMaterials(itemid)then return false end
if filter==nil then
return true
else
local itemCfg=itemsConfig.getConfig(itemid)
local type3=itemCfg.type3
if type3==nil then return false end
for _,v in ipairs(filter)do
if type3==v then
return true
end
end
end
return false
end

function itemsFilterHelper.isEqulsDianHuaEquip(item,filter)
if filter==nil then return true end
local itemid=item.itemid
if not itemsConfig.isEquip(itemid)then return false end
local cnt=equipsModel:getDianHuaCnt(item)
local flag=filter[1]
local isDH=cnt>0
return flag==isDH
end

function itemsFilterHelper.isNotDianHuaEquip(item,filter)
if filter==nil then return true end
local itemid=item.itemid
if not itemsConfig.isEquip(itemid)then return true end
local cnt=equipsModel:getDianHuaCnt(item)
local flag=filter[1]
local isDH=cnt>0
return flag~=isDH
end

function itemsFilterHelper.isEqulsDiscipleId(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
if not itemCfg.disciple then return true end
return filter[1]==itemCfg.disciple
end

function itemsFilterHelper.isEqualsBinding(item,filter)
local isBinding=bagHelper.isBinding(item)
local itemid=item.itemid
if filter==nil then
return true
else
return isBinding==filter[1]
end
end

function itemsFilterHelper.isEqualsSpecialWire(item,filterValList)
if filterValList==nil then
return true
end
for i,v in ipairs(filterValList)do
local cfg=itemsConfig.getConfig(item.itemid)
local type3=cfg.type3 or 0
local num=100*type3
if v==num then
return true
end
end
return false
end


function itemsFilterHelper.isBenMingFabao(item,filter)
if filter==nil then return true end
local itemid=item.itemid
local isBenMing=fabaoConfig.isBenMingFabao(itemid)
if filter==nil then
return true
else
return isBenMing==(filter[1]~=0)
end
end


function itemsFilterHelper.isEqualsFubaoAttr(item,filter)
if filter==nil then return true end
local itemguid=item.itemguid
local attrLookup=UIFuLuFangModel.getFuBaoAttrLookup(itemguid)

for _,v in pairs(filter)do
local etype=v[1]
local stype=v[2]
if attrLookup[etype]and attrLookup[etype][stype]then return true end
end
return false
end


function itemsFilterHelper.isEqualsFubaoZhenTu(item,filter)
if filter==nil then return true end
local itemguid=item.itemguid
local data=UIYuFuLingZhenControl:getLingZhenData(itemguid)
local ZhenTuLookup
if data and data.zhentuId>0 then
ZhenTuLookup=data.zhentuId
else
ZhenTuLookup=0
end
for _,v in pairs(filter)do
if ZhenTuLookup==v[2]then return true end
end
return false
end



function itemsFilterHelper.isEqualsEquipQiangHua(item,filter)
if filter==nil then return true end
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
for _,v in pairs(filter)do
if v==1 and jinglianlv==0 then return true end
if v==2 and jinglianlv>=1 then return true end
end
return false
end



function itemsFilterHelper.isEqualsFaBaoQiangHua(item,filter)
if filter==nil then return true end
local jilianlv=item.itemData and item.itemData.jilianlv or 0
for _,v in pairs(filter)do
if v==1 and jilianlv==0 then return true end
if v==2 and jilianlv>=1 then return true end
end
return false
end



function itemsFilterHelper.isEqualsFaBaoMaterialsLianhuaAttr(item,filter)
if filter==nil then return true end
local itemConfig=itemsConfig.getConfig(item.itemid)
for _,v in pairs(filter)do
for _,vv in ipairs(itemConfig.lianhua or{})do
if v==vv[1]then
return true
end
end
end
return false
end



function itemsFilterHelper.isEqualsXingChenRongHe(item,filter)

if xingChenBagModel:isRongHeItem(item.itemguid)then
return true
end

return false
end


function itemsFilterHelper.isEqualsXingChenChildRongHe(item,filter)

if xingChenBagModel:isRongHeChildItem(item.itemguid)then
return true
end

return false
end

function itemsFilterHelper.isEqualsXingChenCiZhui(item,filter)
if filter==nil then return true end
local ciZhuiList=xingChenHelper.getAffixList(item)
for _,v in pairs(filter)do
for _,vv in ipairs(ciZhuiList or{})do
if v==vv then
return true
end
end
end
return false
end

function itemsFilterHelper.isEqualsXingChenZhenXi(item,filter)
if filter==nil then return true end
return item.itemData.fin_rare_id~=0
end


function itemsFilterHelper.isEqulsXMItemguid(item,filterVal)
if filterVal==nil then
return true
end
local itemguidtype=equipsHelper.getEquipXMType(item.itemguid)
for i,v in ipairs(filterVal)do
if itemguidtype==v then
return true
end
end
return false
end
function itemsFilterHelper.isNotXMItemguid(item,filterVal)
if filterVal==nil then
return true
end
local itemguidtype=equipsHelper.getEquipXMType(item.itemguid)
for i,v in ipairs(filterVal)do
if itemguidtype==v then
return false
end
end
return true
end



function itemsFilterHelper.isBagEquipType(item,filterVal)
if filterVal==nil then
return true
end


local itemCfg=itemsConfig.getConfig(item.itemid)

local equipType,weaponlist
for i,v in ipairs(filterVal)do
equipType=v[1]
if itemCfg.type1==equipType then
weaponlist=v[2]
if equipType==EQUIP_TYPE.eWeapon then
if weaponlist[1]==0 then
return true
else
if table.findValue(weaponlist,itemCfg.type2)then
return true
else
return false
end
end
else
return true
end
end
end

return false
end





function itemsFilterHelper.isAndYuanPeiLianZhiMaterial(item,filter)
local itemData=item.itemData
if itemData==nil then return false end
local fbTypeList=itemData.fbtypeList
if fbTypeList==nil then return false end

if filter==nil then return true end

for _,v in pairs(filter)do
if not table.containsValue(fbTypeList,v)then
return false
end
end

return true
end

function itemsFilterHelper.isNotYuanPeiLianZhiMaterial(item,filter)
local itemData=item.itemData
if itemData==nil then return false end
local fbTypeList=itemData.fbtypeList
if fbTypeList==nil then return false end

if filter==nil then return true end


for _,v in pairs(filter)do
if table.containsValue(fbTypeList,v)then
return false
end
end

return true
end




function itemsFilterHelper.isFubaoEffectType(item,filterVal)
if filterVal==nil then
return true
end
local itemCfg=itemsConfig.getConfig(item.itemid)
if itemsConfig.isFubao(item.itemid)then
for i,v in ipairs(filterVal)do
if itemCfg.type2==v then
return true
end
end
end
return false
end


function itemsFilterHelper.getFilterNames(list,descfunc,noFilterDesc)
if list==nil then return{}end
local filerDescList={}
if noFilterDesc then
filerDescList[#filerDescList+1]=noFilterDesc
end
for _,typo in ipairs(list)do
filerDescList[#filerDescList+1]=descfunc(typo)
end
return filerDescList
end
