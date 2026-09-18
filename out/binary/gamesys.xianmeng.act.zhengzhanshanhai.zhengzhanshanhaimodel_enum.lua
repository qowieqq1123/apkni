








eZZSHEntityType={
eZhuanShi=1,
eLingDi=2,
eMonster=3,
eResource=4,
ePvEXianMeng=5,
ePvETeam=6,
eMonsterPos=7,
ePvPLine=8,
ePvPTeam=9,
eLingShan=10,
}


zzshEntityCfgs={
[eZZSHEntityType.eZhuanShi]={'zzshEntityInfo_zhuangshi',INSTANCE_TYPE.eZZSHZhuangShi,5,nil},
[eZZSHEntityType.eLingDi]={'zzshEntityInfo_lingdi',INSTANCE_TYPE.eZZSHLingDi,2,2},
[eZZSHEntityType.eMonster]={'zzshEntityInfo_monster',INSTANCE_TYPE.eZZSHMonster,10,4},
[eZZSHEntityType.eResource]={'zzshEntityInfo_resource',INSTANCE_TYPE.eZZSHResource,10,4},
[eZZSHEntityType.eMonsterPos]={'zzshEntityInfo_monsterPos',INSTANCE_TYPE.eZZSHMonsterPos,1,4},
[eZZSHEntityType.ePvEXianMeng]={'zzshEntityInfo_PvEXianMeng',INSTANCE_TYPE.eZZSHPvEXianMeng,10,6},
[eZZSHEntityType.ePvETeam]={'zzshEntityInfo_PvETeam',INSTANCE_TYPE.eZZSHPvETeam,10,8},
[eZZSHEntityType.ePvPLine]={'zzshEntityInfo_PvPLine',INSTANCE_TYPE.eZZSHPvPLine,1,8},
[eZZSHEntityType.ePvPTeam]={'zzshEntityInfo_PvPTeam',INSTANCE_TYPE.eZZSHPvPTeam,10,8},
[eZZSHEntityType.eLingShan]={'zzshEntityInfo_lingShan',INSTANCE_TYPE.eZZSHLingShan,2,4},
}

function xianmengdigongModel:getEntityUIOrder(entityType)
return zzshEntityCfgs[entityType][4]or 0
end

local lineIcons={

{'ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/image_shsjxianduan_1.ab','image_shsjxianduan_1'},

{'ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/image_shsjxianduan_2.ab','image_shsjxianduan_2'},

{'ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/image_shsjxianduan_3.ab','image_shsjxianduan_3'},
}

function xianmengdigongModel:getLineIcon(typo)
local d=lineIcons[typo]
if d then
return d[1],d[2]
end
return nil,nil
end