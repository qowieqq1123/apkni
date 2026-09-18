
local _MODULENAME="MysteryEventEnum"


def_table(_MODULENAME)
MysteryEventEnum.name=_MODULENAME


MysteryEventSendType=
{
eMystery=1,
eLiLian=2,
eResPoint=3,
eActivies=4,
eYSLK=6,
eSFPY=7,
eXianJie=8,
eXianJieResPoint=9,
eXianJieForce=10,
eZongMenScene=11,
}


MysteryEventSendData=
{
[MysteryEventSendType.eMystery]={sysId=SYSTEM_DEFINE.eMiJing},
[MysteryEventSendType.eLiLian]={sysId=SYSTEM_DEFINE.eLiLian},
[MysteryEventSendType.eResPoint]={sysId=SYSTEM_DEFINE.eWorldResPoint},
[MysteryEventSendType.eXianJie]={sysId=SYSTEM_DEFINE.eJiuChongTianJieComplete},
[MysteryEventSendType.eXianJieResPoint]={sysId=SYSTEM_DEFINE.eFairyLandResource},
}




MysteryEventCndType=
{
attr=1,
item=2,
jobLevel=3,
gongfa=4,
speciality=5,
job=6,
shanEValue=7,
}


MysteryEventDiceResultAttrType=
{
eCommonGreen=1,
eCommonRed=2,
eDizi=3,
}