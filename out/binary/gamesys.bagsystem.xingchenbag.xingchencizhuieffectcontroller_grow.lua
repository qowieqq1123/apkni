





xingChenGrowEffectChangeType={
eLittleWorldAttrRate=1,
eLittleWorldAttrLimit=2,
eLittleWorldMoneyRate=3,
eFaLingCostChange=4,

eZongMenBuildingRate=5,
eJuTianYiMoneyRate=6,

eDiziVocJingJieRate=8,
eDiziJingJieRate=9,
eDiziLianTiRate=10,
eDiziZhuanYeRate=11,
eDiziAttrInLittleWorld=12,
eGlobalDiZiAttrRate=13,

eXiuShiAddLimit=14,
eXiuShiAddAddRate=15,
}

local xingChenGrowEffectExtraDesc=
{
[xingChenGrowEffectChangeType.eXiuShiAddLimit]='修士人口上限',
[xingChenGrowEffectChangeType.eXiuShiAddAddRate]='修士增长速率',
}


local xingChenGrowEffectNumFlag=
{
[xingChenGrowEffectChangeType.eDiziJingJieRate]=1,
[xingChenGrowEffectChangeType.eDiziLianTiRate]=1,
[xingChenGrowEffectChangeType.eXiuShiAddLimit]=2,
[xingChenGrowEffectChangeType.eXiuShiAddAddRate]=2,
}



local xingChenGrowValFunc={
[xingChenGrowEffectChangeType.eLittleWorldAttrRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eLittleWorldAttrRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eLittleWorldAttrLimit]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eLittleWorldAttrLimit,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eLittleWorldMoneyRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eLittleWorldMoneyRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eFaLingCostChange]=function(guid)
return xingChenHelper.calcEffectVal(xingChenGrowEffectChangeType.eFaLingCostChange,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eZongMenBuildingRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eZongMenBuildingRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eJuTianYiMoneyRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eJuTianYiMoneyRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eDiziVocJingJieRate]=function(guid)
return xingChenHelper.calcEffectAttrListToLookup2(xingChenGrowEffectChangeType.eDiziVocJingJieRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eDiziJingJieRate]=function(guid)
return xingChenHelper.calcEffectVal(xingChenGrowEffectChangeType.eDiziJingJieRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eDiziLianTiRate]=function(guid)
return xingChenHelper.calcEffectVal(xingChenGrowEffectChangeType.eDiziLianTiRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eDiziZhuanYeRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eDiziZhuanYeRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eDiziAttrInLittleWorld]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eDiziAttrInLittleWorld,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eGlobalDiZiAttrRate]=function(guid)
return xingChenHelper.calcEffectAttrLookup(xingChenGrowEffectChangeType.eGlobalDiZiAttrRate,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eXiuShiAddLimit]=function(guid)
return xingChenHelper.calcEffectVal(xingChenGrowEffectChangeType.eXiuShiAddLimit,'grow_effects',guid)
end,
[xingChenGrowEffectChangeType.eXiuShiAddAddRate]=function(guid)
return xingChenHelper.calcEffectVal(xingChenGrowEffectChangeType.eXiuShiAddAddRate,'grow_effects',guid)
end,
}


function xingChenCiZhuiEffectController:getXingChenGrowVal(effectType,guid)
return xingChenGrowValFunc[effectType](guid)
end


function xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(effectType)
if xingChenBagModel:getStarGrowEffectDirty(effectType)then
return self.data.growData[effectType]
else
self.data.growData=self.data.growData or{}
self.data.growData[effectType]=xingChenGrowValFunc[effectType]()
xingChenBagModel:setStarGrowEffectDirty(effectType)
return self.data.growData[effectType]
end
end

function xingChenCiZhuiEffectController.getAttr(effectType,attrValue,bitNum)
if bitNum==nil then bitNum=2 end
local flag=xingChenGrowEffectNumFlag[effectType]
local valStr=attrValue
if flag==2 then
valStr=FMT.fmt('{0}%',mathHelper.decimal(attrValue/100,bitNum))
elseif flag==1 then
valStr=FMT.fmt('{0}%',mathHelper.decimal(attrValue,bitNum))
else
valStr=attrValue
end
return xingChenGrowEffectExtraDesc[effectType],valStr
end