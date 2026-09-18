








xianjienSceneType={
eXianJie=1,
eMoJie=2,
eXianYu_1=3,
eXianYu_2=4,
eXianYu_3=5,
eXianYu_4=6,
eXianYu_5=7,
eXianYu_6=8,
eXianYu_7=9,
eXianYu_8=10,

eMoGongZhengDuo=1001,

isXianYu=function(self_,v)
return v>=self_.eXianYu_1 and v<=self_.eXianYu_8
end,

isMoJie=function(self_,v)
return v==self_.eMoJie or(v>=11 and v<1000)
end,

isMoJieFirst=function(self_,v)
return v==self_.eMoJie
end,
isMoGongZhengDuo=function(self_,v)
return v==self_.eMoGongZhengDuo
end,
}


xianjienSceneIndexType={
eXianJie=0,
eMoJie=100,
eXianYu_1=1,
eXianYu_2=2,
eXianYu_3=3,
eXianYu_4=4,
eXianYu_5=5,
eXianYu_6=6,
eXianYu_7=7,
eXianYu_8=8,

eMoGongZhengDuo=101,

isXianYu=function(self_,v)
return v>=self_.eXianYu_1 and v<=self_.eXianYu_8
end,
isOhterXianYu=function(self_,v)
return self_:isXianYu(v)and v~=xianjieModel:getXianYuSceneIndex()
end,

isMoJie=function(self_,v)
return v==self_.eMoJie or v<=-1
end,

isMoJieFirst=function(self_,v)
return v==self_.eMoJie
end,
isMoGongZhengDuo=function(self_,v)
return v==self_.eMoGongZhengDuo
end,
}


xjOrderType={
eAttack=1,
eLook=2,
eStation=3,
eStationBack=4,
eYuanZhu=5,
eCheHuiYuanZhu=6,
eJiJieInitiate=7,
eJiJieJoin=8,
eJiJieKickOut=9,
eJiJieInvite=10,
eJiJieTransfer=11,
eJiJieChuZheng=12,
eJiJieChangeAuto=13,
eAttackRole=14,
eCarryRepair=15,
eAttackBoss=16,
eMoJingZhenJi_Normal=19,
eMoJingZhenJi_Origin=20,
eMoJunYaoMo=21,
eDefendXianMeng=22,
eDefendXianMengBack=23,
eAttackXianMeng=24,
eAddMJSLBuff=25,
eMoJieBoxCaiJi=27,
eMoGongZhanHunGe=28,
eMoGongHuLingTa=29,
eMoJieSGMoster=30,

eLingShou=33,
eLingShouGroup=34,
}


xjServerEnityType={
eActor=1,
eGuild=2,
eMonster=3,
eBossMonster=4,
eStation=5,
ePortal=6,
eMonsterHouse=7,
eClientBuild=8,
eMoJieMoZong_Small=9,
eMoJieMoZong_Big=10,
eMoJingZhenJi_Normal=11,
eMoJieMoJunYaoMo=12,
eMoJieMoJunFenShen=13,
eMoJieMoster=16,
eMoJieShangGuMoster=17,
eMoJieBox=18,
eMoJieZhenYan_Small=19,
eMoJieZhenYan_Big=20,
eMoJieZhenYan_Spe=21,
eLingShou=22,
eLingShouGroup=23,

eEnumMax=23,
}





xjServerMarchType={
eKill=1,
eSpy=2,
eStation=3,
eBack=4,
eYuanZhu=5,
eJiJieJoin=8,
eJiJieChuZheng=12,
eAttackRole=14,
eCarry=15,
eKillBossMonster=16,
eMoZongAttack=17,
eMoZongBack=18,
eMoJingZhenJi_Normal=19,
eMoJingZhenJi_Origin=20,
eMoJunYaoMo=21,
eDefendXianMeng=22,
eAttackXianMeng=24,
eMJSLDebuffAdd=25,
eMoJunFenShenAttack=26,
eMoJieBoxCJ=27,
eMoGongZhanHunGe=28,
eMoGongHuLingTa=29,
eMoJieSG=30,
eZhenYanAttack=31,
eZhenYanBack=32,
eLingShouAttack=33,
eLingShouGroupAttak=34,
}


xjSoldierHurtType={
eHealthy=1,
eSlightInjury=2,
eSeriousInjury=3,
}

xjSoldierAttr={
atk="attack",
def="def",
hp="hp",
}


xjEnemyType={
eSelf=1,
eAllies=2,
eEnemy=3,
eStranger=4,
}


xjRuleTipsType={
eEmptyPos=1,
eZongMen=2,
eNormalMonster=3,
ePlotMonster=4,
eBossMonster=5,
eResPointMonster=6,
eStation=7,
eLeyLine=8,
eYunZhouTeam=9,
eYBDRule=10,
eJiJieMsgRule=11,
eXianMeng=12,
}

xjTeamHandleType={
eSearchTeam=1,
ePlotTeam=2,
eMarchKill=3,
eMarchSpy=4,
eMarchStation=5,
eMarchBack=6,
ePlotTeamReract=7,
eMarchYuanZhu=8,
eResPointTeam=9,
eResPointReract=10,
eJiJieWait=11,
eJiJieJoin=12,
eJiJieChuZheng=13,
eAttackRole=14,
eStationTeam=15,
eCarryRepair=16,
eArenaZhuJun=17,
eNotDataMarchTeam=18,
eMoGongZhuJun=19,
eMoZongAttack=20,
eMoZongBack=21,
eMoJingZhenJi_Origin=22,
eDefendXianMeng=23,
eAttackXianMeng=24,
eMoJunYaoMo=25,
eMoJunFenShenAttack=26,
eDefendXianMengStation=27,
eAttackMoJun=28,
eMarchMJSLDebuffAdd=29,
eMarchMJBoxCJ=30,
eMoJunBoxTeam=31,
eMoGongBuffZhuJunTeam=32,
eMoGongBuffMarchTeam=33,
eZhenYanAttack=34,
eZhenYanBack=35,
eMoJingZhenJi_Normal=36,
eLingShouAttack=37,
eLingShouGroupAttack=38,
}


xjDataType={
eCloud=1,
eCloudPlot=2,
eCloudLock=3,
eMonster=4,
eResource=5,
eStation=6,
eZongMen=7,
eXianMeng=8,
eNPC=9,
eMarchTeam=10,

eResPoint_Monster=12,
eResPoint_Event=13,
eResPoint_NPC=14,
eResPoint_Collectible=15,
eResPoint_Mystery=16,
eResPoint_MarchTeam=17,
eCloudQiYu=18,
eLeyLine=19,
eTransfer=20,
eXJFMBoss=21,
eResPoint_CanvertCollectible=22,
eArena=23,
eCloudUnLock=24,
eXJXingYu=25,
eZuoBiao=26,
eMoGong=27,
eNotDataMarchTeam=28,
eMoJiang=29,
eMoJiangRange=30,
eMoJingZhenJi_Origin=31,
eMoJieGate=32,
eXianMengEffect=33,
eMoJun=34,
eMoJunRange=35,
eMoJunTiaoZhanRange=36,
eMoJunEffect=37,
eMoJunBox=38,
eMoJunFenShen=39,
eMoJunBox_MarchTeam=40,
eCaravanEscortEnter=41,
eCaravanEscortTeam=42,
eCaravanEscortHub=43,
eMGZD_ZhanHunGe=44,
eMGZD_HuLingTa=45,
eZhenTai=46,
eMoGongRange=47,
eMoJingZhenJi_Normal=48,
eZhenTaiRange=49,
eLingShou=50,
eLingshouGroup=51,
}

xjJumpSceneType=
{
eSelfZMPos=1000,
eOwnerZMXY=1001,
eNowPos=1002,
eMoJie=1003,
eMoGong=1004,
}
for k,v in pairs(xianjienSceneType)do
xjJumpSceneType[k]=v
end


function xianjieModel.getEntityTypeCfg(typo)
return cfgHelper.get1(cfg_xianjieentityconfig_get,typo)
end

eXjDataChangeType=
{
eXmChange=1,
ePosChange=2,
}

mjZongMenPosRandType={
eSeason=1,
eMoGongZhengDuo=2,
}


eXianJieLogicSceneType={
eXianJie=1,
eMoJie=2,
eMoGong=3,
}

xjMonsterFightOrderMapping={
[xjServerEnityType.eMonsterHouse]=xjOrderType.eJiJieInitiate,
[xjServerEnityType.eBossMonster]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJieMoster]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJieMoZong_Small]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJieMoZong_Big]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJingZhenJi_Normal]=xjOrderType.eMoJingZhenJi_Normal,
[xjServerEnityType.eMoJieMoJunYaoMo]=xjOrderType.eMoJunYaoMo,
[xjServerEnityType.eMoJieShangGuMoster]=xjOrderType.eMoJieSGMoster,
[xjServerEnityType.eMoJieZhenYan_Small]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJieZhenYan_Spe]=xjOrderType.eAttackBoss,
[xjServerEnityType.eMoJieZhenYan_Big]=xjOrderType.eJiJieInitiate,
[xjServerEnityType.eLingShouGroup]=xjOrderType.eJiJieInitiate,
[xjServerEnityType.eLingShou]=xjOrderType.eLingShou,
}

xjMonsterInfoHideStage={
[xjServerEnityType.eMoJieMoZong_Small]=1,
[xjServerEnityType.eMoJieMoZong_Big]=1,
[xjServerEnityType.eMoJieZhenYan_Small]=1,
[xjServerEnityType.eMoJieZhenYan_Spe]=1,
[xjServerEnityType.eMoJieZhenYan_Big]=1,
[xjServerEnityType.eMoJieMoJunYaoMo]=1,
[xjServerEnityType.eBossMonster]=1,
[xjServerEnityType.eMoJieMoster]=1,
[xjServerEnityType.eMoJingZhenJi_Normal]=1,
}

xjMapHideStage={
[xjServerEnityType.eMoJieZhenYan_Small]=1,
[xjServerEnityType.eMoJieZhenYan_Spe]=1,
[xjServerEnityType.eMoJieZhenYan_Big]=1,
[xjServerEnityType.eMoJingZhenJi_Normal]=1,
}

xjEntityShowAttackRange={
[xjServerEnityType.eMoJieMoZong_Small]=1,
[xjServerEnityType.eMoJieMoZong_Big]=1,
[xjServerEnityType.eMoJieZhenYan_Small]=1,
[xjServerEnityType.eMoJieZhenYan_Spe]=1,
[xjServerEnityType.eMoJieZhenYan_Big]=1,
}

xjYuanZhuGroupType={
eXianJie=xianjienSceneIndexType.eXianJie,
eMoJie=xianjienSceneIndexType.eMoJie,
eMoGong=xianjienSceneIndexType.eMoGongZhengDuo,
}

mjWuXingZhenJiType={
eJing=1,
eMu=2,
eShui=3,
eHuo=4,
eTu=5,
}

mjWuXingZhenJiNameByType={
[mjWuXingZhenJiType.eJing]="五行阵基-金",
[mjWuXingZhenJiType.eMu]="五行阵基-木",
[mjWuXingZhenJiType.eShui]="五行阵基-水",
[mjWuXingZhenJiType.eHuo]="五行阵基-火",
[mjWuXingZhenJiType.eTu]="五行阵基-土",
}

eYbdType={
YiShouYbd=1,
ZhanZhengYbd=2,
MoJieYbd=4
}
