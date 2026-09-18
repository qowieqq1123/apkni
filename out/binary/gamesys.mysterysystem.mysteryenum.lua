

MysterySenceType=
{
Lilian=1,
ZongMen=2,
ResPoint=3,
ShangGuXianDi=4,
World=5,
ZiYuan=6,
qiyu=8,
XianJieResPoint=9,
}


HexMapLayer=
{
Ground=0,
Data=1,
Room=2,
RoomData=3,
Room2=4,
RoomData2=5,
}


MapDataType=
{
None=-1,
Walkable=0,
Fog=1,
Obstacle=2,
}


HexMapType=
{
Main=1,
Room=2,
Room2=3,
}


MysteryRuleEnterType=
{
Choice=1,
Dice=2,
Event=3,
}


eMysteryQuitType=
{
eFinish=0,
eBreak=1,
eFail=2,
}


eMysteryEnterType=
{
eMystery=0,
eQiYuEvent=1,
eLiLian=2,
}


eMysteryHUDType=
{
eMonster="UIMysteryHUD",
eTreasure="UIMysteryTreasureHUD",
eSamePosCount="UIMysteryCountHUD",
eBloodShow="UIMysteryBloodHUD",
eBloodNumShow="UIMysteryBloodNumHUD",
eModel="UIMysteryModelHUD",
eMoveTreasure="UIMysteryMoveTreasureHUD",
eTalk="UIMysteryTalkHUD",
eArrow='UIMysteryArrowHUD',
eBloodDur="UIMysteryBloodDurHUD",
eTrapCount="UIMysteryTrapHUD",
}

eMysteryFromType=
{
eNone=0,
eFixed=1,
eRandom=2,
eItem=3,
eTask=4,
eRes=5,
eZongMen=6,
}


eMysteryPauseType=
{
eGlobal=0,
eCameraMove=1,
eCameraMoveFlag=2,
ePlayerRunBehavior=3,
eWaitToMoveRecv=4,
eWaitToRoomInit=5,
eInitJumpRoom=6,
eTeamDead=7,
eFireBomb=8,
eTrap=9,
eLingShou=10,
}


eMysteryTemplateType=
{
eFixed=1,
eRandom=2,
eXianDi=3,

eRoom=4,
}

local fixedMapPath="/data/mjmap/map/"
local templateMapPath="data/mjmap/randomMap/"
local roomMapPath="data/mjmap/roomMap/"

eMysteryPathFunc=
{
[eMysteryTemplateType.eFixed]=function(fbId)
local fbCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local template=fbCfg.template[2]
local path=FMT.fmt("{0}{1}",fixedMapPath,template)
return path
end,
[eMysteryTemplateType.eRandom]=function(fbId)

local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)
return path
end,
[eMysteryTemplateType.eXianDi]=function(fbId)
local path=FMT.fmt("{0}randomMap_{1}",templateMapPath,fbId)
return path
end,
[eMysteryTemplateType.eRoom]=function(roomId)
local path=FMT.fmt("{0}roomMap_{1}",roomMapPath,roomId)
return path
end,
}