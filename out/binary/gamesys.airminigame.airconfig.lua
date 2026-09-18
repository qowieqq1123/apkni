airConfig={}

eAirEntityType=
{
TYPE_ROLE=1,
TYPE_MONSTER=2,
TYPE_SKILL=3,
TYPE_DROP=4,
TYPE_BULLET=5,
TYPE_NPC=6,
TYPE_PET=7,
TYPE_HALO=8,
TYPE_SUMMON=9,
TYPE_COLLECTABLE=10,
TYPE_BUILDING=11,
TYPE_TELEPORT=12,
TYPE_WEAPON=13,
TYPE_OTHER=14,


TYPE_MONSTER_ELITE=100,
TYPE_MONSTER_BOSS=101,
TYPE_MONSTER_SKILL=102,

TYPE_MONSTER_DEAD=103,

TYPE_TOWER=104,
TYPE_MONSTER_NEUTRAL=105,
TYPE_TRAP=106,
TYPE_ENTITY_REPLACE=107,
}


eAirOtherEntityType=
{
eMonsterMask=-1,
eHarm=-2,
}


eAirEntityTeam=
{
eRole=0,
eMonster=1,
eNeutral=2,
}

eAirEntityColliderInfo=
{



[eAirEntityType.TYPE_ROLE]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=12,
droplayer=11,
sortingLayer='ITDecoration2',
},

[eAirEntityType.TYPE_WEAPON]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=13,
sortingLayer='ITDecoration4',
},


[eAirEntityType.TYPE_MONSTER]=
{
isTrigger=false,
kinematic=false,
interpolate=0,
detection=3,
layer=14,
atklayer=10,
sortingLayer='ITDecoration2',
},

[eAirEntityType.TYPE_MONSTER_NEUTRAL]=
{
isTrigger=false,
kinematic=false,
interpolate=0,
detection=3,
layer=14,
atklayer=10,
sortingLayer='ITDecoration2',
},

[eAirEntityType.TYPE_MONSTER_ELITE]=
{
isTrigger=false,
kinematic=false,
interpolate=0,
detection=3,
layer=18,
atklayer=10,
sortingLayer='ITDecoration2',
},

[eAirEntityType.TYPE_MONSTER_BOSS]=
{
isTrigger=false,
kinematic=false,
interpolate=0,
detection=3,
layer=19,
atklayer=10,
sortingLayer='ITDecoration2',
},


[eAirEntityType.TYPE_DROP]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=15,
sortingLayer='Entity',
},


[eAirEntityType.TYPE_SKILL]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=0,
layer=16,
sortingLayer='ITArea1',
},

[eAirEntityType.TYPE_MONSTER_SKILL]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=17,
sortingLayer='ITArea1',
},
[eAirEntityType.TYPE_MONSTER_DEAD]=
{
isTrigger=false,
kinematic=false,
interpolate=0,
detection=3,
layer=17,
sortingLayer='ITArea1',
},


[eAirEntityType.TYPE_TOWER]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=12,
roleLayer=15,
sortingLayer='ITDecoration2',
},

[eAirEntityType.TYPE_TRAP]=
{
isTrigger=true,
kinematic=false,
interpolate=0,
detection=3,
layer=12,
sortingLayer='ITDecoration2',
},

}



eAirEntityColliderType=
{
eRect=1,
eCircle=2,
eCapsule=3,
eFan=4,
}

eAirSkillCenterType=
{
eTarget=1,
eSelf=2,
eWeapon=3,
}

eAirSkillRangeType=
{
eSingle=1,
eCircle=2,
eFan=3,
eRect=4,
}

eAirSkillTargetType=
{
eSelf=1,
eEnemy=2,
eTeam=3,
eAll=4,
}

eAirSkillType=
{
eVocSkill=1,
eWeaponSkill=2,
eMountSkill=3,
eMonsterSkill=4,
eTowerSkill=5,
}

eAirMonsterType=
{
eLittle=1,
eElite=2,
eBoss=3,
eNeutral=4,
}

eAirSkillResultType=
{
eDamageAndBuff=1,
eRestoreHP=2,
eAddBuff=3,
}

eAirMonsterType2=
{
eMonster=1,
eNeutral=2,
}

eAirMonsterAiType=
{
eMelee=0,
eRanged=1,
eRoaming=2,
eNeutral=3,
}

eAirSkillBehavourType=
{
eBase=0,
eShot=1,
eMove=2,
eBaWangQiang=3,
eXueYinDao=4,
ePanGuanBi=5,
eQingYunShan=6,
eQianKunZhu=7,
eWanDuFan=8,
eJianXiu=9,
eEffect=10,
eHalo=11,
eCreateMon=12,
eDeadSkill=13,
eMoveToTarget=14,
eRangeArea=15,
eCreateEnt=16,
eCastSkillProbabilty=17,
}

eAirSkillEntityType=
{
eCommon=0,
eShot=1,
eKuoSan=2,
eRoundTrip=3,
eRoundTrip2=4,
eFan=5,
eJianXiuShot=6,
eSkillRange=7,
eTargetRoundSkill=8,
}

eSkillHurtType2=
{
ePenetration=1,
eRange=2,
}

eHUDCatchType=
{
eDamage=1,
eRestoreHP=2,
eDodge=3,
eStealHP=4,
eReflect=5,
eDead=6,
eHP=7,
}

eHudType=
{
eBlood=1,
eTarget=2,
eHarm=3,
}

eDropType=
{
eMoney=1,
eBox=2,
eRestoreHP=3,
}

eBuffMoment=
{
eLevelStart=1,
eDodge=2,
eCirticalkillEnemy=3,
ekillEnemy=4,
eOnDamage=5,
eLevelEnd=6,
eWeaponAttack=7,
eReflect=8,
eCastVocSkill=9,
eCastMountSkill=10,
eCastWeaponSkill=11,
}

eBuffStatus=
{
eIdle=1,
eDead=2,
eXuanYun=3,
eWuDi=4,
}

eBuffType=
{
eChangeAttr=1,
eMoneyGain=2,
ekillEnemyPickUpDrop=3,
eChangeSpeed=4,
eAddSpecificUnitDamage=5,
ePickUpDropChangeAttr=6,
eAddSummon=7,
eAddXiaoHaoPinRestore=8,
eChangeMonsterRefreshTime=9,
eMomentCastSkill=10,
eStatusCastSkill=11,
eMomentChangeAttr=12,
eStatusChangeAttr=13,
eChangeSkillDamage=14,
eChangeSkillRange=15,
eChangeItemPrice=16,
eChangePickUpGain=17,
eAddShopDiscount=18,
eSpeMoneyUniqueBuff=19,
eConvertAttrToDamage=20,
eChangeExpGain=21,
eMomentChangeDrop=22,
eChiXuDamage=23,
eAttackRatioAddBuff=24,
eForceHP=25,
eConvertAttrToAttr=26,
eHpLimitAddAttr=27,
eTuPoAttrTopLimit=28,
eEnterStatus=29,
eDyingRebirth=30,
eHoldWeaponChangeAttrs=31,
eOwnerSummonChangeAttrs=32,
eRangeEnemyChangeAttrs=33,
eChiXuCasterSkill=34,
eUpWeaponOrChangeAttrs=35,
eHpLimitOnDropChangeAttr=36,
}

eDamageType=
{
eProactiveAttack=1,
eChiXuDamage=2,
eReduceHP=3,
eReflect=4,
}

eSummonType=
{
eMonster=1,
eTowner=2,
eTrop=3,
}


function airConfig.getColliderType(skillRangeType)
if skillRangeType==eAirSkillRangeType.eCircle then
return eAirEntityColliderType.eCircle
elseif skillRangeType==eAirSkillRangeType.eFan then
return eAirEntityColliderType.eFan
elseif skillRangeType==eAirSkillRangeType.eRect then
return eAirEntityColliderType.eRect
end
end

function airConfig.getMonsterType(extraTargetReleation)
if extraTargetReleation==eAirMonsterType.eLittle then
return eAirEntityType.TYPE_MONSTER
elseif extraTargetReleation==eAirMonsterType.eElite then
return eAirEntityType.TYPE_MONSTER_ELITE
elseif extraTargetReleation==eAirMonsterType.eBoss then
return eAirEntityType.TYPE_MONSTER_BOSS
elseif extraTargetReleation==eAirMonsterType.eNeutral then
return eAirEntityType.TYPE_MONSTER_NEUTRAL
end
end

function airConfig.isAttackAttr(attributeType)
return cfgHelper.get2(cfg_airattributesconfig_get,attributeType,'attack')==true
end

function airConfig.getEntityColliderLayer(entityType)
local cfg=airConfig.getEntityColliderConfig(entityType)
return cfg.layer
end

function airConfig.getEntityBitLayer(entityType)
local cfg=airConfig.getEntityColliderConfig(entityType)
return airConfig.getBitLayer(cfg.layer)
end

function airConfig.getBitLayer(layer)
return bit.lshift(1,layer)
end

function airConfig.getEntitySortingLayer(entityType)
local cfg=airConfig.getEntityColliderConfig(entityType)
return cfg.sortingLayer
end

function airConfig.getEntityColliderConfig(entityType)
return eAirEntityColliderInfo[entityType]
end

function airConfig.getMoneyType()
local id=cfgHelper.get2(cfg_aircommonconfig_get,1,'money')
return cfgHelper.get2(cfg_airdropconfig_get,id,'type2')
end

function airConfig.getSkillImgName(id)
return FMT.fmt('icon_bullet_{0}',id)
end


function airConfig.isAttr_P(attrid)
return cfgHelper.get2(cfg_airattributesconfig_get,attrid,'flag')==2
end

function airConfig.getDamageTypeName(damageType)
if damageType==eDamageType.eProactiveAttack then
return'主动攻击'
elseif damageType==eDamageType.eChiXuDamage then
return'持续伤害'
elseif damageType==eDamageType.eReduceHP then
return'扣减生命'
elseif damageType==eDamageType.eReflect then
return'反击'
end
end

function airConfig.getSummonType(entityType)
if entityType==eAirEntityType.TYPE_TOWER then
return eSummonType.eTowner
elseif entityType==eAirEntityType.TYPE_TOWER then
return eSummonType.eTrop
end
end