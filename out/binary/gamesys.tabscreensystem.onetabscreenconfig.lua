









local _MODULENAME="oneTabScreenConfig"
def_table(_MODULENAME)

oneTabScreenConfig.name=_MODULENAME




local skinConfig=
{
[eOneTabScreenSkinType.eSkin1]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponent",
[eOneTabScreenNode.tabList]="UITabListComponent",
},
[eOneTabScreenSkinType.eSkin2]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponentSmall",
[eOneTabScreenNode.tabList]="UITabListComponentSmall",
},
[eOneTabScreenSkinType.eSkin3]=
{
[eOneTabScreenNode.bgPanel]="UIAquariumHandbookBGWin",
[eOneTabScreenNode.tabList]="UIAquariumHBTabList",
},
[eOneTabScreenSkinType.eSkin4]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponent2",
[eOneTabScreenNode.tabList]="UITabListComponent",
},
[eOneTabScreenSkinType.eSkin5]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponentSmall2",
[eOneTabScreenNode.tabList]="UITabListComponentSmall",
},
[eOneTabScreenSkinType.eSkin6]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponent_XJFM",
[eOneTabScreenNode.tabList]="UITabListComponent_XJFM",
},
[eOneTabScreenSkinType.eSkin7]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponent7",
[eOneTabScreenNode.tabList]="UITabListComponent7",
},
[eOneTabScreenSkinType.eSkin8]=
{
[eOneTabScreenNode.bgPanel]="UIBackgroundComponent8",
[eOneTabScreenNode.tabList]="UITabListComponent8",
},
}

local screenConfig=
{
[SEC_FULL_TYPE.discipleSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"guid"},
children=
{
SEC_FULL_TAB_TYPE.discipleNote,
SEC_FULL_TAB_TYPE.discipleBag,

SEC_FULL_TAB_TYPE.discipleRelationship,
SEC_FULL_TAB_TYPE.discipleCouple,
SEC_FULL_TAB_TYPE.discipleSpeak,

}
},
[SEC_FULL_TYPE.gubaoSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"gbid"},
children=
{
SEC_FULL_TAB_TYPE.gubaolianhua,
SEC_FULL_TAB_TYPE.gubaoupstar,
SEC_FULL_TAB_TYPE.gubaoawake,
}
},
[SEC_FULL_TYPE.fuluSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.fuluFuBao,
SEC_FULL_TAB_TYPE.fuluXianFu,
}
},
[SEC_FULL_TYPE.yuGangSecondary]=
{
skin=eOneTabScreenSkinType.eSkin3,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.yuZhongTuJian,
SEC_FULL_TAB_TYPE.yuZhongZongLan,
}
},
[SEC_FULL_TYPE.xfwdRankSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.xfwdRank,
SEC_FULL_TAB_TYPE.xfwdReward,
}
},
[SEC_FULL_TYPE.fabaoSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"itemguid"},
children=
{
SEC_FULL_TAB_TYPE.fabaoBenMingInfo,
SEC_FULL_TAB_TYPE.fabaoBenYunYang,
SEC_FULL_TAB_TYPE.fabaojilian,
SEC_FULL_TAB_TYPE.fabaolianhua,
}
},
[SEC_FULL_TYPE.equipSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"itemguid"},
closeWinFunc=function()
UIManager:callWindowFunc('UIEquipFilterWin','onShowTips')
UIManager:callWindowFunc('UIBagWin','onShowTips')
end,
children=
{
SEC_FULL_TAB_TYPE.eEquipJingLian,
SEC_FULL_TAB_TYPE.eEquipChongZhu,
SEC_FULL_TAB_TYPE.eEquipNingLian,
SEC_FULL_TAB_TYPE.eEquipRonghe,
}
},
[SEC_FULL_TYPE.baolingshuSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"cjType","showType"},
children=
{
SEC_FULL_TAB_TYPE.blsrewards,
SEC_FULL_TAB_TYPE.blsdetails,
}
},


[SEC_FULL_TYPE.zmDailyPaperSecondary]=
{
skin=eOneTabScreenSkinType.eSkin2,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.dailyPaperShangpu,
SEC_FULL_TAB_TYPE.dailyPaperJiazu,
SEC_FULL_TAB_TYPE.dailyPaperPostWage,
}
},
[SEC_FULL_TYPE.shopCountSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'mode'},
children=
{
SEC_FULL_TAB_TYPE.shopCount,
}
},
[SEC_FULL_TYPE.lotterySecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'activityId','subType','subId'},
children=
{
SEC_FULL_TAB_TYPE.lotteryDetail,
SEC_FULL_TAB_TYPE.lotteryPercent,
SEC_FULL_TAB_TYPE.lotteryRule,
}
},
[SEC_FULL_TYPE.kuangSecondary]=
{
skin=eOneTabScreenSkinType.eSkin7,
commonArgs={'itemId'},
children=
{
SEC_FULL_TAB_TYPE.head,
SEC_FULL_TAB_TYPE.headkuang,
SEC_FULL_TAB_TYPE.chatkuang,
SEC_FULL_TAB_TYPE.eSetting_ZongMen,

SEC_FULL_TAB_TYPE.eSetting_YunZhou,
}
},
[SEC_FULL_TYPE.worldLeaderRewardSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'monsterIdx','stageIdx'},
children=
{
SEC_FULL_TAB_TYPE.eWorldLeaderRankReward,
SEC_FULL_TAB_TYPE.eWorldLeaderChallengeReward,
}
},
[SEC_FULL_TYPE.cangbaotuCardSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'activityId','subType','subId'},
children=
{
SEC_FULL_TAB_TYPE.cangbaotuMyCard,
SEC_FULL_TAB_TYPE.cangbaotuMyRecord,
}
},
[SEC_FULL_TYPE.discipleClothing]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"guid","sortType","checkClothing"},
children=
{
SEC_FULL_TAB_TYPE.discipleClothing,
SEC_FULL_TAB_TYPE.dzMount,
}
},
[SEC_FULL_TYPE.eZhengZhanShanHaiLog]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.eZhengZhanShanHaiFightLog,
SEC_FULL_TAB_TYPE.eZhengZhanShanHaiMonsterLog,
SEC_FULL_TAB_TYPE.eZhengZhanShanHaiResourceLog,
SEC_FULL_TAB_TYPE.eZhengZhanShanHaiLingShanLog
}
},
[SEC_FULL_TYPE.eXianJieLog]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.eXianJieMonsterLog,
SEC_FULL_TAB_TYPE.eXianJieResourceLog,
SEC_FULL_TAB_TYPE.eXianJieFightLog,
SEC_FULL_TAB_TYPE.eMoGongZhengDuoLog,
}
},
[SEC_FULL_TYPE.tanbaogeSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'activityId','subType','subId','floorNumMin','floorNumMax','floorNumMin_ignoreLoop'},
children=
{
SEC_FULL_TAB_TYPE.tanbaogeLotteryDetail,
SEC_FULL_TAB_TYPE.tanbaogeLotteryPercent,
SEC_FULL_TAB_TYPE.tanbaogeLotteryRule,
}
},
[SEC_FULL_TYPE.wdcqRewardSecondary]=
{
skin=eOneTabScreenSkinType.eSkin4,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.wdcqMC,
SEC_FULL_TAB_TYPE.wdcqQF,
SEC_FULL_TAB_TYPE.wdcqJC,
}
},
[SEC_FULL_TYPE.hdlcJLSecondary]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'activityId','subType','subId'},
children=
{
SEC_FULL_TAB_TYPE.hdlcGRJL,
SEC_FULL_TAB_TYPE.hdlcQFJL,
}
},
[SEC_FULL_TYPE.eYunZhouWarehouse]=
{
skin=eOneTabScreenSkinType.eSkin5,
commonArgs={},
children=
{

SEC_FULL_TAB_TYPE.eYunZhouComponentsWarehouse,
}
},
[SEC_FULL_TYPE.eYunZhouComponents]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={"itemid","itemguid","boat_id","pos"},
children=
{
SEC_FULL_TAB_TYPE.eYunZhouComponentsStrengthen,
SEC_FULL_TAB_TYPE.eYunZhouComponentsCompose,
}
},
[SEC_FULL_TYPE.XJFMRewardSecondary]=
{
skin=eOneTabScreenSkinType.eSkin6,
commonArgs={'monsterIdx'},
children=
{
SEC_FULL_TAB_TYPE.eXJFMreward_GeRen,
SEC_FULL_TAB_TYPE.eXJFMreward_XianMeng,
SEC_FULL_TAB_TYPE.eXJFMreward_Challenge,
SEC_FULL_TAB_TYPE.eXJFMreward_Target,
}
},
[SEC_FULL_TYPE.XYRewardSecondary]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={'xyId'},
children=
{
SEC_FULL_TAB_TYPE.eXYReward_Reward,
SEC_FULL_TAB_TYPE.eXYReward_TanSuo,
SEC_FULL_TAB_TYPE.eXYReward_DuiZhan,
}
},
[SEC_FULL_TYPE.XYTanSuoJiShi]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={'xyId'},
children=
{
SEC_FULL_TAB_TYPE.eXYTanSuoJiShi_ZuShi,
SEC_FULL_TAB_TYPE.eXYTanSuoJiShi_XingYu,
}
},
[SEC_FULL_TYPE.XYZhenDuoZhan]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={'xyId'},
children=
{
SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round1,
SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round2,
SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round3,
SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round4,
SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round5,
}
},
[SEC_FULL_TYPE.vocEquipSecondary]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={"itemguid"},
closeWinFunc=function()
UIManager:callWindowFunc('UIEquipFilterWin','onShowTips')
UIManager:callWindowFunc('UIBagWin','onShowTips')
end,
children=
{
SEC_FULL_TAB_TYPE.eVocEquipStrengthen,
}
},
[SEC_FULL_TYPE.lotterySecondary_lunhuizhuanpan]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={'activityId','subType','subId'},
children=
{
SEC_FULL_TAB_TYPE.lotteryDetail_lunhuizhuanpan,
SEC_FULL_TAB_TYPE.lotteryRule_lunhuizhuanpan,
}
},
[SEC_FULL_TYPE.XYZDZReward]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={'xyId'},
children=
{
SEC_FULL_TAB_TYPE.eXYZDZReward_Round1,
SEC_FULL_TAB_TYPE.eXYZDZReward_Round2,
SEC_FULL_TAB_TYPE.eXYZDZReward_Round3,
SEC_FULL_TAB_TYPE.eXYZDZReward_Round4,
SEC_FULL_TAB_TYPE.eXYZDZReward_Round5,
}
},
[SEC_FULL_TYPE.eJiuYuZhengFeng]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={},
children=
{

SEC_FULL_TAB_TYPE.eJYZF_Rule,
SEC_FULL_TAB_TYPE.eJYZF_Record,
SEC_FULL_TAB_TYPE.eJYZF_MoJie,
}
},
[SEC_FULL_TYPE.lotterySecondary_noActivity]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={'configstr','configidx'},
children=
{
SEC_FULL_TAB_TYPE.lotteryDetail_noActivity,
SEC_FULL_TAB_TYPE.lotteryPercent_noActivity,
SEC_FULL_TAB_TYPE.lotteryRule_noActivity,
}
},
[SEC_FULL_TYPE.eXianJieMXSLLog]=
{
skin=eOneTabScreenSkinType.eSkin1,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.eXianJieMXSLSingleLog,
}
},
[SEC_FULL_TYPE.eMingYuanZhuSha]=
{
skin=eOneTabScreenSkinType.eSkin8,
commonArgs={},
children=
{
SEC_FULL_TAB_TYPE.eMYZS_DisicpleState,
SEC_FULL_TAB_TYPE.eMYZS_BWDetail,
}
},
}

local screenLookup={}
for i,v in pairs(screenConfig)do
for j,w in ipairs(v.children)do
if not screenLookup[w]then
screenLookup[w]={i,j}
else
loggerUtil.logErrFMT('oneTabScreenConfig配置中存在多个id为{0}的界面',w)
end
end
end

function oneTabScreenConfig:getSkinConfig(eType)
return skinConfig[eType]
end

function oneTabScreenConfig:getScreenConfig(eType)
return screenConfig[eType]
end

function oneTabScreenConfig:getScreenLookup(eChildType)
return screenLookup[eChildType]
end

function oneTabScreenConfig:getScreenLookupMain(eChildType)
local lookup=self:getScreenLookup(eChildType)
if lookup then
return lookup[1]
end
end

function oneTabScreenConfig:getScreenLookupSecondary(eChildType)
local lookup=self:getScreenLookup(eChildType)
if lookup then
return lookup[2]
end
end

function oneTabScreenConfig:lookupScreenConfig(eChildType)
local eType=self:getScreenLookupMain(eChildType)
if eType then
return self:getScreenConfig(eType)
end
end