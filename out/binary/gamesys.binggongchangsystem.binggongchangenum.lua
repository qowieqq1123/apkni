
BGF_EQUIP_TYPE=
{
eWeapon=1,
eClothes=2,

checkBGFEquipType=function(type1)
for i,v in pairs(BGFEquipTypeToEquipType)do
for _,et in ipairs(v)do
if type1==et then
return i
end
end
end
end,
getBGFEquipTypeList=function()
return{BGF_EQUIP_TYPE.eWeapon,BGF_EQUIP_TYPE.eClothes}
end
}

BGFEquipTypeToEquipType=
{
[BGF_EQUIP_TYPE.eWeapon]={EQUIP_TYPE.eWeapon},
[BGF_EQUIP_TYPE.eClothes]={EQUIP_TYPE.eClothes,EQUIP_TYPE.eCap,EQUIP_TYPE.eShoot},
}