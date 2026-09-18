wuXingDianConfig={}

wuXingDianBaseType=
{
eGold=1,
eWood=2,
eWater=3,
eFire=4,
eSoil=5,
}

wuXingDianType=
{
eSD=0,
eGold=1,
eWood=2,
eWater=3,
eFire=4,
eSoil=5,
}


fightTeam=
{
[1]=fightPreSelectModel.fightType.wuxingdian_gold,
[2]=fightPreSelectModel.fightType.wuxingdian_wood,
[3]=fightPreSelectModel.fightType.wuxingdian_water,
[4]=fightPreSelectModel.fightType.wuxingdian_fire,
[5]=fightPreSelectModel.fightType.wuxingdian_soil,
}

wuXingDianTypeName=
{
[wuXingDianType.eSD]='圣',
[wuXingDianType.eGold]='金',
[wuXingDianType.eWood]='木',
[wuXingDianType.eWater]='水',
[wuXingDianType.eFire]='火',
[wuXingDianType.eSoil]='土',
}

wuXingDianAssetName=
{
[wuXingDianType.eSD]='image_jlbeishuflui_9',
[wuXingDianType.eGold]='image_jlbeishuflui_4',
[wuXingDianType.eWood]='image_jlbeishuflui_5',
[wuXingDianType.eWater]='image_jlbeishuflui_6',
[wuXingDianType.eFire]='image_jlbeishuflui_7',
[wuXingDianType.eSoil]='image_jlbeishuflui_8',
}

function wuXingDianConfig.isSD(wxdId)
return wuXingDianType.eSD==wxdId
end

function wuXingDianConfig.getSDType()
return wuXingDianType.eSD
end

function wuXingDianConfig.getCfg(wxdId)
if wuXingDianConfig.isSD(wxdId)then
return cfgHelper.get1(cfg_fiveelementsholytempleconfig_get,wxdId)
else
return cfgHelper.get1(cfg_fiveelementstempleconfig_get,wxdId)
end
end

function wuXingDianConfig.getShouyiRatio(wxdId)
if wuXingDianConfig.isSD(wxdId)then
return cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'ratio')
else
return cfgHelper.get2(cfg_fiveelementstempleconfig_get,wxdId,'ratio')
end
end

function wuXingDianConfig.getFullName(wxdId)
if wuXingDianConfig.isSD(wxdId)then
return cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'name')
else
return cfgHelper.get2(cfg_fiveelementstempleconfig_get,wxdId,'name')
end
end