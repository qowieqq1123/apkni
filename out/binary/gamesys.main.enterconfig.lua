enterConfig={}


ENTER_ICON_TYPE=
{
eBig=1,
eNomal=2,
}

ENTER_ACT_Kind=
{
eAct=1,
eGame=2,
}


local _idx=0
local _getIdx=function()
_idx=_idx+1
return _idx
end


ENTER_TYPE=
{
eOperActivity=1,
eWenJuan=2,
eFirstRecharge=3,
eSevenDayGoal=4,
ePushGift=5,
eXianShu=6,
eAuction=7,
eLunDaoDaHui=8,
eRongYuTang=9,
eXianFaBang=10,
eLimitAct=11,
eExtend=12,
ePushGiftTwo=13,
eNewWenJuan=14,
eLXWJZhiZunBang=15,
eSuperZuShi=16,
ePushGiftThree=17,
eTianJiangFuyuan=18,
eTianMingZengLi=20,
eTotalTouZiActivity=19,
eXianTuManMan=21,
eWenDingCangQiong=22,
eWenDingBang=23,
eWDCQQFAct=24,
eBindPhone=25,
eVisitGameCenter=26,
eChangeAct=27,
eFirstRecharge2=28,
eXianYuanXunFang=29,
eFirstAscent=30,
eUwpHaoPing=31,
eBlueDiamond=32,
eQQLobbyAct=33,
eMergeActivity=34,
eFirstRecharge3=35,
eMiniGame=36,
eServerTransfer=37,
eDYClientTransfer=38,
eWangYeTiaoZhuan=39,
eBindAccount=40,
}




local _enterConfig=
{
[ENTER_ICON_TYPE.eNomal]=
{
[ENTER_TYPE.eWenJuan]=
{
sort=function(info)
return 0
end,
creator='UIEnterWenJuan',
iconType=ICON_TYPE.mainWenJuan,
},
[ENTER_TYPE.eOperActivity]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterActivity',
},
[ENTER_TYPE.eLimitAct]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterLimitActivity',
},
[ENTER_TYPE.eFirstRecharge]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterFirstRecharge',
iconType=ICON_TYPE.mainFirstRecharge,
},
[ENTER_TYPE.eFirstRecharge2]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterFirstRecharge2',
iconType=ICON_TYPE.mainFirstRecharge2,
},
[ENTER_TYPE.eFirstRecharge3]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterFirstRecharge3',
iconType=ICON_TYPE.mainFirstRecharge3,
},
[ENTER_TYPE.eXianYuanXunFang]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterXianYuanXunFang',
iconType=ICON_TYPE.mainXianYuanXunFang,
},
[ENTER_TYPE.eSevenDayGoal]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterSevenDayGoal',
iconType=ICON_TYPE.mainSevenDayGoal,
},
[ENTER_TYPE.ePushGift]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterPushGift',
},
[ENTER_TYPE.eXianShu]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterXianShu',
},
[ENTER_TYPE.eXianFaBang]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterXianFaBang',
},
[ENTER_TYPE.eAuction]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterAuction',
iconType=ICON_TYPE.mainAuction,
},
[ENTER_TYPE.eLunDaoDaHui]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterLunDaoDaHui',
iconType=ICON_TYPE.mainAuction,
},
[ENTER_TYPE.eRongYuTang]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterLunDaoDaHui_RongYuTang',
iconType=ICON_TYPE.mainAuction,
},
[ENTER_TYPE.eExtend]=
{
sort=function(info)
return 999
end,
creator='UIEnterExtend',
},

[ENTER_TYPE.ePushGiftTwo]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterPushGiftTwo',
},
[ENTER_TYPE.ePushGiftThree]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterPushGiftThree',
},
[ENTER_TYPE.eLXWJZhiZunBang]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterLXWJZhiZunBang',
},
[ENTER_TYPE.eNewWenJuan]=
{
sort=function(info)
return 0
end,
creator='UIEnterNewWenJuan',
},
[ENTER_TYPE.eSuperZuShi]=
{
sort=function(info)
return 0
end,
creator='UIEnterSuperZuShi',
},
[ENTER_TYPE.eTianJiangFuyuan]=
{
sort=function(info)
return 0
end,
creator='UIEnterTianJiangFuYuan',
},
[ENTER_TYPE.eTianMingZengLi]=
{
sort=function(info)
return 0
end,
creator='UIEnterTianMingZengLi',
},
[ENTER_TYPE.eTotalTouZiActivity]=
{
sort=function(info)
return 0
end,
creator='UIEnterTotalTouZiActivity',
},
[ENTER_TYPE.eXianTuManMan]=
{
sort=function(info)
return 0
end,
creator='UIEnterXianTuManMan',
},
[ENTER_TYPE.eWenDingCangQiong]=
{
sort=function(info)
return 0
end,
creator='UIEnterWenDingCangQiong',
},
[ENTER_TYPE.eWenDingBang]=
{
sort=function(info)
return 0
end,
creator='UIEnterWenDingBang',
},
[ENTER_TYPE.eWDCQQFAct]=
{
sort=function(info)
return 0
end,
creator='UIEnterWDCQQuFuAct',
},
[ENTER_TYPE.eBindPhone]=
{
sort=function(info)
return 0
end,
creator='UIEnterBindPhone',
},
[ENTER_TYPE.eVisitGameCenter]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterVisitGameCenter',
},
[ENTER_TYPE.eChangeAct]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterChangeAct',
},
[ENTER_TYPE.eFirstAscent]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterFirstAscent',
},
[ENTER_TYPE.eUwpHaoPing]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterUwpHaoPing',
},
[ENTER_TYPE.eBlueDiamond]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterBlueDiamond',
},
[ENTER_TYPE.eQQLobbyAct]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterQQLobbyAct',
},
[ENTER_TYPE.eMergeActivity]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIMergeEnterActivity',
},
[ENTER_TYPE.eMiniGame]=
{
sort=function(info)
return info.sort or 0
end,
creator='UIEnterMiniGame',
},
[ENTER_TYPE.eServerTransfer]=
{
sort=function(info)
return info.sort or 0
end,
creator='UIEnterServerTransfer',
},
[ENTER_TYPE.eDYClientTransfer]=
{
sort=function(info)
return info.sort or 0
end,
creator='UIEnterDYClientTransfer',
},
[ENTER_TYPE.eWangYeTiaoZhuan]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterWangYeTiaoZhuan',
},

[ENTER_TYPE.eBindAccount]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterBindAccount_OM',
},
},
[ENTER_ICON_TYPE.eBig]=
{
[ENTER_TYPE.eOperActivity]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterBigActivity',
},
[ENTER_TYPE.eLimitAct]=
{
sort=function(info)
return info.sort or 1
end,
creator='UIEnterBigLimitActivity',
},
}
}

local _sceneCfg=
{
[eSceneType.eZongmen]=
{
[mapIdType.zhufeng]=
{
[ENTER_TYPE.eLimitAct]=function(id)
return false
end,
act_extend_limit={
normal=9,
big=2,
}
},
[mapIdType.xianmeng]=
{
unknown=false,
[ENTER_TYPE.eLimitAct]=function(id)
local cfg=cfg_clientxianshihuodongconfig_get(id,false)or
cfg_xianshihuodongconfig_get(id,false)
if limitActivitiesModel.checkActForbidden(cfg)then return false end
local showSceneCfg=cfg.showScene
if showSceneCfg==nil then return false end
for i,v in ipairs(showSceneCfg)do
if v==mapIdType.xianmeng then return true end
end
return false
end,
act_extend_limit={
normal=9,
big=5,
}
},
[mapIdType.fort]=
{
[ENTER_TYPE.eLimitAct]=function(id)
return false
end,
act_extend_limit={
normal=9,
big=2,
}
},
[mapIdType.lingshoudao]=
{
unknown=false,
[ENTER_TYPE.eLimitAct]=function(id)








return false
end,
[ENTER_TYPE.eOperActivity]=function(id)
local cfg=activitiesModel:getActConfig(id)
local showSceneCfg=cfg.showScene
if showSceneCfg==nil then return false end
for i,v in ipairs(showSceneCfg)do
if v[1]==eSceneType.eZongmen then
local mapIds=v[2]
if mapIds then
for _,mapId in ipairs(mapIds)do
if mapId==mapIdType.lingshoudao then return true end
end
end
end
end
return false
end,
act_extend_limit={
normal=9,
big=2,
}
},
},
[eSceneType.eXianJie]=
{
{
[ENTER_TYPE.eOperActivity]=function(id)
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx then
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
return false
end
end

local cfg=activitiesModel:getActConfig(id)
local showSceneCfg=cfg.showScene
if showSceneCfg==nil then return false end
for i,v in ipairs(showSceneCfg)do
if v[1]==eSceneType.eXianJie then return true end
end
return false
end,
act_extend_limit={
normal=3,
big=2,
},
normalLimit=3,
bigLimit=0,
unknown=false,
},
},
}


function enterConfig.getConfig(enterIconType,enterType)
if _enterConfig[enterIconType]==nil then return end
return _enterConfig[enterIconType][enterType]
end

function enterConfig.getSpriteAB()
return globalABLookup.mainEntrySprite
end

function enterConfig.getMapCfg(sceneType,mapId)
if _sceneCfg[sceneType]==nil then return end
if sceneType==eSceneType.eXianJie then
return _sceneCfg[sceneType][1]
end
return _sceneCfg[sceneType][mapId]
end

function enterConfig.preInitEnter(enterItem)
if enterItem.lldhQiPao then
enterItem.lldhQiPao:setActive(false)
end
end

