
fightActionType=
{
CAST_SKILL=1,
ADD_BUFF=2,
CHANGE_HP=3,
DISPEL_BUFF=4,
SKILL_DODGE=5,
BUFF_EFFECT=6,
DEL_BUFF_EFFECT=7,


ACTION_START=8,
ACTION_END=9,
DISPEL_BUFF_EFFECT=10,
DELETE_BUFF=11,
REBOUND=12,
RESURRECTION=13,
GM=14,
NEW_MON=15,
CHANGE_PROP=16,
HALO_LIST=17,
SKILL_SHOW=18,
UNITE_ATTACK=19,

AIM_ATTACK=20,

LJD_CHANGE=21,

TEAM_SHIELD_CHANGE=22,

FIGHT_LOG_CARD_CHANGE=23,
FIGHT_LOG_CARD_GP=24,

CAST_Move_Target_SKILL=101,

CLIENT_SKILL_ACTION=1001,
CLIENT_SKILL_ACTION_TARGET=1002,
CLIENT_JUN_ZHEN_ACTION=1003,

NONE=10000,
}

buffCheckType=
{
roundEnd=0,
actionStart=1,
actionEnd=2,
}

fightSkillTypo=
{
zhudong=0,
beidong=1,
shuxing=2,
}

fightDamageType=
{
CRITICAL=1,
FANSHE=2
}


fightSkillShow=
{
SHANBI=1,
XISHOU=2,
}


fightCommonTag=
{
typo=1,
typoDizi=0,
holderPlace=-1,
dstID=1,
skillEffectTypo=2,
showName=1,
}



fightEntityType=
{
diZi=0,
monster=1,

shield=-1,
junzhen=-2,
}


fightPlayModeType=
{
eNormal=0,
eJunZhen=1,
}


FIGHT_USE_TYPE=
{
eNormal=0,
eYanShi=1,
}



fightReportTag=
{
stage=1,
attack=2,
defend=3,
yuanjun=4,
round=5,
result=6,
attackResult=7,
defendResult=8,
jzRound=9,
}


fightYuanJunTag=
{
atkYuanJun=1,
defYuanJun=2,
atkDaZhenInfo=3,
defDaZhenInfo=4,
zhanli=5,
}


stageInfoTag=
{
leftTypo=1,
rightTypo=2,
mapID=3,
maxRound=4,
leftZhenFaId=5,
rightZhenFaId=6,
leftActorId=7,
rightActorId=8,
customInfo=9,
}

stageCustomInfoTag=
{
showStartEffect=1,
leftPosOffset=2,
rightPosOffset=3,
enterBTTime=4,
leftEnterBT=5,
rightEnterBT=6,
}

stagePosType=
{
TwoThree=0,
OneTwo=1,
TwoOne=2,
OnePos=3,
}

stagePosWeight=
{
main=0,
assist=100,
}

stageCenterPos=
{
left=200,
right=201,
}


fightEntityHPType=
{
left={1,2},
right={2,1},
}


fightAssistantType=
{
eLingShou=1,
}


fightEntityTag=
{
typo='id',
attr='prop',
baseInfo='dizi',
fabao='gem',
test='test',
assistant='assistant',
junzhen='jz',
}

fightAssistantTag=
{

id=1,
modelId=2,
}


fightBaseInfoTag=
{
jobData=1,
model=2,
name=3,
weapon=4,
tmlv=5,
clothingId=6,
clothingStar=7,
diziId=8,
cvId=9,
xm_voc=10,
hide_xm=11,
disguise=12,
}




fightRoundTag=
{
first=0,
beidong=1,
skill=2,
buff=3,
yuanjun=4,
max=4,
}



fightSkillTag=
{
typo=1,
srcID=2,
id=3,
level=4,
subActions=5,
}


fightBuffTag=
{
typo=1,
guid=2,
subActions=3,
}


fightSkillActionTag=
{
id=1,
subActions=2,
}


fightSkillActionActionTag=
{
dstID=1,
actions=2,
}


fightTeamShieldTag=
{
typo=1,
teamType=2,
num=3,
nownum=4,
}

fightChangeHpTag=
{
typo=1,
dstID=2,
value=3,
demageTypo=4,
nowhp=5,
srcID=6,
}

fightBuffActiongTag=
{
typo=1,
guid=2,
subActions=3,
}

fightAddBuffTag=
{
typo=1,
guid=2,
buffID=3,
level=4,
round=5,
layer=6,
srcID=7,
desID=8,
flag=9,
val=10,
}


fightChangePropTag=
{
typo=1,
dstID=2,
propID=3,
value=4,
}


entityStateID=
{
stand=1,
gaurd=2,
move=10,
run=11,

dead=20,
hit=21,
attak1=1000,
attck2=1001,
}


flowObjTypo=
{
hp=0,
tip=1,
skill=2,
skillEffect=3,
biaoQing=4,
fabao=5,
hp_critical=6,
buff=7,
effect=8,
randomTip=9,
}



fightSceneTypo=
{
preSelect=0,
enter=1,
fight=2,
}

fightCameraMode=
{
preSelect=0,
fight=1,
assistFight=3,
}

monType={
LittleMonster=0,
EliteMonster=1,
Boss=2,
BigBoss=3,
GodAnimal=4,
SpiritAnimal=101,
Puppet=102,
SpiritWorm=103,

isBossType=function(self,typo)
return typo==self.Boss or typo==self.BigBoss or typo==self.GodAnimal
end,

haveBossType=function(self,mons)
for i,v in ipairs(mons)do
if v>0 then
local monCfg=cfgHelper.get1(cfg_monsterconfig_get,v)
if self:isBossType(monCfg.monType)then
return true
end
end
end
return false
end,

getHighestType=function(self,mons,filter)
local highest=0
for i,v in ipairs(mons)do
if v>0 then
local monCfg=cfgHelper.get1(cfg_monsterconfig_get,v)
local monType=monCfg.monType
if filter(monType)then
highest=math.max(highest,monType)
end
end
end
return highest
end
}

monTypeName={
[monType.LittleMonster]="小妖",
[monType.EliteMonster]="精英",
[monType.Boss]="首领",
[monType.BigBoss]="大boss",
[monType.GodAnimal]="神兽",
[monType.SpiritAnimal]="灵兽",
[monType.Puppet]="傀儡",
[monType.SpiritWorm]="灵虫",
}

monTypeTag={
[monType.EliteMonster]="icon_gwbz_3",
[monType.Boss]="icon_gwbz_2",
[monType.GodAnimal]="icon_gwbz_1",
}

monTypeTagA={
[monType.EliteMonster]="icon_gwbz_3A",
[monType.Boss]="icon_gwbz_2A",
[monType.GodAnimal]="icon_gwbz_1A",
}

monTypeBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}

fightResultType={
Victory=1,
Lose=2,
Tie=3,
Lose2=4,
}


eFightMulitResultType={
AndVictory=1,
ResultTimes=2,
ResultOneTimes=3,
}

eShowResultType={
DouFaTai=1,
WuDaoTang=2,
ShiLianTa=3,
MiJing=4,
LiLianGuaiWu=5,
ShiJieGuaiWu=6,
ZiYuanDianGuaiWu=7,
QiYuEvent=8,
zongmenMonster=9,
monsterInvade=10,
npcPK=11,
tuitu=12,
ShiJieShouLing=13,
JiuCengYaoLou=14,
tianyuanshouchao=15,
huanjing=16,
zongmendabi=17,
xianfawendao=18,
xianmengdigong=19,
yunchengtanbao=20,
lingxuwenjian=21,
qiecuo=22,
lingxuwenjian3=23,
wuxingdian=24,
TianMoRuQin_TianMo=25,
TianMoRuQin_ShiJian=26,
taigushilian=27,
yunyouMerchant=28,
qieshishenshou=29,
fabaoshilian=30,
visitorchallenge=31,
fuyaoshilian=32,
zhengzhanshanhailog=33,
houshanzhenling=34,
longhuxiangyao=35,
systemZongMenAttack=36,
systemZongMenDefense=37,
sifangpingyao=39,
dujiexiandan=40,
chisejindi=41,
zhenyaoshilian=42,
tianmojie=43,
xunbaoshilian=47,
wendingcangqiong=48,
xianjielog=49,
wdcqxiweisai=50,
xianjiefumo=51,
xianguanwuxuan=52,
jiuyouta=53,
gubaoshilian=54,
yanfage=55,
xianjunyanzhen=56,
lingShanZhengDuo=57,
lingShanZhengDuo2=58,
activitiesPushMap=59,
xjCaravanEscort=60,
mingyuanzhusha=61,
xingyu=62,
}

eFightBanCheck=
{
eNone=0x0,
eDiscipleState=0x1,
eDiscipleInjury=0x2,
All=0x5,
}

eBattleType={
zongmenMonster=1,
mystery=2,
worldMonster=3,
worldExperience=4,
shilianta=5,
worldResPoint=6,
worldFamilyExpel=7,
worldFamilyContend=8,
wudaotang=9,
doufatai=10,
qiyuEvent=11,
monsterInvade=12,
worldFamilyJinZhu=13,
npcPK=14,
tuitu=15,
tianyuanshouchao=16,
worldLeader=17,
jiucengyaolou=18,
huanjing=19,
zongmendabi=20,
xianfawendao=21,
xianmengdigong=22,
yunchengtanbao=23,
lundaodahuiJueSai=24,
lingxuwenjian=25,
qiecuo=26,
lingxuwenjian2=27,
lingxuwenjian3=28,
wuxingdian=29,
tianmoruqin_tm=30,
tianmoruqin_sj=31,
taigushilian=32,
yunyouMerchant=33,
qieshishenshou=34,
fabaoshilian=35,
visitorchallenge=36,
fuyaoshilian=37,
zhengzhanshanhailog=38,
houshanzhenling=39,
longhuxiangyao=40,
systemZongMenAttack=41,
systemZongMenDefense=42,
sifangpingyao=43,
dujiexiandan=44,
chisejindi=45,
zhenyaoshilian=46,
tianmojie=47,
xunbaoshilian=48,
wengdingcangqiong=49,
xianjielog=50,
wdcqxiweisai=51,
xianjiefumo=52,
xianguanwuxuan=53,
jiuyouta=54,
gubaoshilian=55,
xingyu=56,
yanfage=57,
xianjunyanzhen=58,
lingShanZhengDuo=59,
lingShanZhengDuo2=60,
activitiesPushMap=61,
xjCaravanEscort=62,
mingyuanzhusha=63,
}

eBattleLaunch={
mystery=1,
mysteryPoint=2,
qiyuEvent=3,
zongmenMonster=4,
worldMonster=5,
resPoint=6,
family=7,
wudaotang=8,
shilianta=9,
experience=10,
doufatai=11,
monsterInvade=12,
testFight=13,
npcPK=14,
tuitu=15,
tianyuanshouchao=16,
worldLeader=17,
jiucengyaolou=18,
huanjing=19,
zongmendabi=20,
xianfawendao=21,
xianmengdigong=22,
yunchengtanbao=23,
lingxuwenjian=24,
qiecuo=25,
wuxingdian=27,
tianmoruqin_tm=28,
tianmoruqin_sj=29,
taigushilian=30,
yunyouMerchant=31,
qieshishenshou=32,
fabaoshilian=34,
visitorChallenge=35,
fuyaoshilian=36,
houshanzhenling=37,
longhuxiangyao=38,
sifangpingyao=39,
dujiexiandan=41,
chisejindi=42,
zhenyaoshilian=43,
tianmojie=44,
xianjiePlotMonster=45,
xunbaoshilian=47,
wdcqxiweisai=48,
xianjieResPoint=49,
xianjieFuMo=50,
jiuyouta=52,
gubaoshilian=53,
yanfage=54,
xianjunyanzhen=55,
lingShanZhengDuo=56,
activitiesPushMap=57,
xjCaravanEscort=58,
mingyuanzhusha=59,
}



eBattleLoseClosePrepare={
[eBattleLaunch.lingxuwenjian]=1,
[eBattleLaunch.qiecuo]=1,
[eBattleLaunch.tianmoruqin_tm]=1,
[eBattleLaunch.tianmoruqin_sj]=1,
[eBattleLaunch.tianmojie]=1
}

eDiscipleChangeType={
eGongFaLvUp=1,
eInjuryChange=2,
eShouYuan=3,
eJobExpChange=4,
eSpeciality=5,
eSixAttr=6,
eJJRate=7,
eJingJieChange=8,
eLianTiChange=9,
eJJRate2=10,
}

eRePlayerType={
doufatai='doufataisharefightlog',
lundaodahui='lundaodahuifightlog',
shilianta='shiliantalog',
jiucengyaolou='jiucengyaoloulog',
zongmendabi='zongmendabilog',
xianfawendao='xianfawendao',
lundaodahuiJueSai='lundaodahuiJueSaifightlog',
lingxuwenjian='lingxuwenjianlog',
diziqiecuo='diziqiecuolog',
lingxuwenjian2='lingxuwenjianlog2',
lingxuwenjian3='lingxuwenjianlog3',
wuxingdian='wuxingdian',
shanhailog='shanhailog1',
systemZongMenAttack='systemZongMenAttack',
systemZongMenDefense='systemZongMenDefense',
wendingcangqiong='wendingcangqiongfightlog',
xianjielog='xianjielog',
xiweisailog='xiweisailog',
xianguanwuxuanlog='xianguanwuxuanlog',
jiuyaota='jiuyaota',
xingyu='xingyu',
xianjunyanzhen='xianjunyanzhen',
}


eSkillRangeType=
{
jincheng=0,
yuancheng=1,
}

eBuffEffectType=
{
hunLuan=11,
}


eDamagetype=
{
critical=0,
fanshe=1,
xixue=2,
}


eSkillShowType=
{
shanBi=1,
xishou=2,
debuffShanBi=3,
debuffRebound=4,
quChu=5,
mianYi=6,
geDang=7,
hunluan=8,
wudi=9,

death=10,
relive=11,

mianchu=12,

relive_passive=13,

passive=14,

cure_fanshi=15,

lengqueadd=16,
lengquesub=17,
clear_cd=18,
lengquemax=19,


clientFanShe=100,
clientReLive=101,
}

skillShowTypeTag=
{
[eSkillShowType.shanBi]={name=" {0}闪避",imageID=1},
[eSkillShowType.xishou]={name=" {0}吸收",imageID=2},
[eSkillShowType.debuffShanBi]={name=" {0}抵抗",imageID=3},
[eSkillShowType.debuffRebound]={name=" {0}反弹",imageID=4,speImageID=1,},

[eSkillShowType.quChu]={name=" {0}祛除",imageID=6},
[eSkillShowType.mianYi]={name=" {0}免疫",imageID=7},
[eSkillShowType.geDang]={name=" {0}格挡",imageID=8},
[eSkillShowType.hunluan]={name=" {0}混乱",imageID=9,speImageID=2,},

[eSkillShowType.mianchu]={name=" {0}免除",},

[eSkillShowType.clientFanShe]={name=" {0}反射",imageID=5},

[eSkillShowType.clientReLive]={name=" {0}复活",imageID=22},

[eSkillShowType.wudi]={name=" {0}无敌",imageID=23},

[eSkillShowType.death]={
name=" {0}死亡",
delay=1.75,
exe=function(battle,ent,dstBtPara)
ent:onDead()
battle:insertWitnessBehavior(eFightWitnessEventType.diziDead,{left=ent:isLeft(),immediately=true})
end,
},

[eSkillShowType.relive]={
name=" {0}复活",
delay=2,
exe=function(battle,ent,dstBtPara)
local delay=ent:onResurrenttion(dstBtPara)
return delay or 2
end,
},
[eSkillShowType.relive_passive]={
name=" {0}被动复活",
exe=function(battle,ent,dstBtPara,skillid)
ent:setPassiveResurrenttion(skillid)
end,
},
[eSkillShowType.passive]={
name=" {0}被动技能",
exe=function(battle,ent,dstBtPara,skillid)
local cfg=cfgHelper.get(cfg_skillconfig_get,skillid)

if cfg and cfg.showPassiveName then
ent:flowText(flowObjTypo.skill,{strPara=cfg.name})
end
end,
},
[eSkillShowType.cure_fanshi]={name=" {0}治疗反噬",imageID=24,speImageID=3,},
[eSkillShowType.lengqueadd]={name=" {0}冷却",imageID=25},
[eSkillShowType.lengquesub]={name=" {0}冷却",imageID=26},
[eSkillShowType.clear_cd]={name=" {0}冷却",imageID=27},
[eSkillShowType.lengquemax]={name=" {0}冷却",imageID=28},



}


eSpeSrcID=
{
eSys=10001,
}


fightSkillClass=
{
attack=0,
job=1,
gongfa=2,
fabao=3,
monster=4,
}


eFightWitnessEventType=
{
enter='enter',
victory='victory',
fail='fail',
diziDead='diziDead',
useFaBao='useFaBao',
loop='loopBh',
}


eFightBuffBehave=
{
changeModel=1,
scale=2,
color=3,
addBody=4,
}

eFightNewMonType=
{
yuanJun=0,
zhaohuan=1,
}


eEnityOutEffectType=
{
eTianMing=1,
}

eFightType=
{
eSingle=1,
eMulti=2,
}


eSpEntityName=
{
eEmpty="空实体",
}


eBuffControlType=
{
[8]=1,
[9]=1,
[10]=1,
[11]=1,
[12]=1,
[15]=1,
[16]=1,
[21]=1,
[23]=1,
[27]=1,
[29]=1,
[30]=1,
[32]=1,
[48]=1,
}


eJZEffectType=
{
eFire1=1,
eSword=2,
eLightning=3,
eIce1=4,
eMagic=5,
}



eFightLogReqType=
{
eLocal=0,
eCross=1,
eBigCross=2,
eBigCrossAct=2,
eBigCrossAndLocal=3,
}