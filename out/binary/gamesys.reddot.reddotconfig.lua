




reddotConfig={}


local _subNameLookup={}
local _nameLookup={}
local _lookup={}
local _baseVal=10000000


local _i1=0
local function _cindex()
_i1=_i1+1
return _i1
end

CATCH_TYPE={
eMoney=_cindex(),
eItem=_cindex(),


eMail=_cindex(),
eFriend=_cindex(),
eFriendPoint=_cindex(),
eDailyTask=_cindex(),
eGuBao=_cindex(),
eGongFa=_cindex(),
eSchool=_cindex(),
eDisciple=_cindex(),
eDiscipleJJ=_cindex(),
eDiscipleLT=_cindex(),
eXianGouLiBao=_cindex(),
eFaBaoCreate=_cindex(),
eDanFangNew=_cindex(),
eFuluReward=_cindex(),
eZhenFa=_cindex(),
eXMApplication=_cindex(),
eWelfare=_cindex(),
eDiscipleTianMing=_cindex(),
eDiscipleChangeTab=_cindex(),
eInitBagData=_cindex(),
eXianShu=_cindex(),
eZongMenLevel=_cindex(),
eDiziChuiWei=_cindex(),
eActivityChange=_cindex(),
eNewDay=_cindex(),
eLimitActChange=_cindex(),
eShiLianTaLayerChange=_cindex(),
eActorHeadChange=_cindex(),
eChatBgExperience=_cindex(),
eGuildOrderReddotChange=_cindex(),
eBuildActive=_cindex(),
eXMRepairCollect=_cindex(),
eMountainSwitch=_cindex(),
eDiscipleQiZhen=_cindex(),
eDiscipleCuiTi=_cindex(),
eDZQiZhenSystemOpen=_cindex(),
eFaZeBaoDian=_cindex(),
eRoadActive=_cindex(),
eBuildSuitActive=_cindex(),
eBuildSuitReward=_cindex(),
eXianDiTouZi=_cindex(),
eFaBaoLxExp=_cindex(),
eCangBaoTuShareRecord=_cindex(),
eDaoBingCombine=_cindex(),
eDiscipleFightChanged=_cindex(),
eEquipJingLianFilterChanged=_cindex(),
eFabaoJiLianFilterChanged=_cindex(),
eMoneyInit=_cindex(),
eFaBaoLvChange=_cindex(),
eBenMingFaBaoReddotChange=_cindex(),
eDiscipleGongFaChange=_cindex(),
eXianTuChengJiuTaskProgress=_cindex(),
eZongMenXianTuReward=_cindex(),
eGuBaoSkillLevelChange=_cindex(),
eZongMenXianTuStage=_cindex(),
eZongMenXianTuAnimation=_cindex(),
eWanBaoXunBaoDuiTask=_cindex(),
eWanBaoXunBaoDuiRecruit=_cindex(),
eXianXunBangRewardChange=_cindex(),
eXianMengWeekScoreChange=_cindex(),
eXianWuLouRewardChange=_cindex(),
eXianWuLouProgressChange=_cindex(),
eYiYuHuiYouShengJiChange=_cindex(),
eYueLongChi=_cindex(),
efreshGift=_cindex(),
eXMFXZYSeek=_cindex(),
eBLSPickUp=_cindex(),
eDiscipleSpriteRoot=_cindex(),
eSectPalaceReddotChange=_cindex(),
eZMLevel=_cindex(),
eFair=_cindex(),
eDesignLayoutOpen=_cindex(),
eLingZhenDiaoke=_cindex(),
eZZSHLog=_cindex(),
eLunDaoRewards=_cindex(),
eWXSDRewards=_cindex(),
eTMZLsys=_cindex(),
eShopCreate=_cindex(),
eChongZhu=_cindex(),
eLingTuYanJiu=_cindex(),
eSHZhanLing=_cindex(),
eDuJieXianDan=_cindex(),
eSheQuAct=_cindex(),
eSelectLiBao=_cindex(),
eXianBao=_cindex(),
eQiYuanShu=_cindex(),
eTeZhiTuJian=_cindex(),
eXWLfeisheng=_cindex(),
eWenDingCangQiong=_cindex(),
eBaoLingShuXBSL=_cindex(),
eXianZhi=_cindex(),
eXianJieLog=_cindex(),
eWDCQQFAct=_cindex(),
eTaskreddot=_cindex(),
eXJFM_Target=_cindex(),
eXianGongBangYu=_cindex(),
eXMZengLi=_cindex(),
eChangeAct=_cindex(),
eSetingTypeChange=_cindex(),
eXianGuanJingXuan=_cindex(),
eNingLian=_cindex(),
eRonghe=_cindex(),
eXianGuanTeQuan=_cindex(),
eXMDGShopManage=_cindex(),
eXJFaction_XianGong=_cindex(),
eDiscipleDaoYan=_cindex(),
eBlueDiamond=_cindex(),
eSJXianZang=_cindex(),
eShowcaseTeam=_cindex(),
eXMDGPass=_cindex(),
eWeekCard=_cindex(),
eSystemOpen=_cindex(),
eMJYGExtend=_cindex(),
eXJCaravanEscortChange=_cindex(),
eYanDaoTaiChange=_cindex(),
eChangeBao=_cindex(),
eHunQiTai=_cindex(),
eMYZSTXZ=_cindex(),
eDiscipleLingShouChange=_cindex(),
eLingShouMainSkillChange=_cindex(),
eLingShouChangeTab=_cindex(),
}

for k,v in pairs(CATCH_TYPE)do
_lookup[v]=tostring(k)
end



local _i2=0
local function _rindex()
_i2=_i2+1
return _i2
end


REDDIT_SUB_TYPE=
{



sMailBase=_rindex(),
sFriendBase=_rindex(),
sFriendPoint=_rindex(),
sDailyTaskBase=_rindex(),
sGuBaoBase=_rindex(),
sGuBaoCollect=_rindex(),
sGuBaoLianHua=_rindex(),
sGuBaoUpStar=_rindex(),
sGuBaoAwake=_rindex(),
sGongFaBuildHud=_rindex(),
sSchoolReward=_rindex(),
sDiscipleBase=_rindex(),
sXianGouLiBao=_rindex(),
sFaBaoCreate=_rindex(),
sDanFang=_rindex(),
sFuLuReward=_rindex(),
sZhenFa=_rindex(),
sXianMengBase=_rindex(),
sXianMengPalace=_rindex(),
sXianGouWeekLiBao=_rindex(),
sXianGouMonthLiBao=_rindex(),
sXianGouGuangGaoLiBao=_rindex(),
sMonthInvestor=_rindex(),
sDailySignIn=_rindex(),
sSevenDaySignIn=_rindex(),
sStoreHouseBase=_rindex(),
sDiscipleInfo=_rindex(),
sDiscipleTianMing=_rindex(),
sXianShu=_rindex(),
sXianShuTask=_rindex(),
sZongmenLevelInvestor=_rindex(),
sHead=_rindex(),
sHeadKuang=_rindex(),
sChatKuang=_rindex(),
sGuildOrder=_rindex(),
sLayoutBuild=_rindex(),
sFaZeBaoDian=_rindex(),
sWelfareCdKey=_rindex(),
sWelfareKaiZongZengLi=_rindex(),
eXianDiTouZi=_rindex(),
sBenMingFabaoBase=_rindex(),
sRechargeDailyTeHui=_rindex(),
sCangBaoTuCardRecord=_rindex(),
sDaoBingCombine=_rindex(),
sDiscipleInfo_Equip=_rindex(),
sDiscipleInfo_Skill=_rindex(),
sDiscipleEquip=_rindex(),
sDiscipleFabao=_rindex(),
sXianTuChengJiu_Base=_rindex(),
sXianTuChengJiu_ZongMenXianTu=_rindex(),
sXianTuChengJiu_XianTuChengJiu=_rindex(),
sXianTuChengJiu_FeiShengDaoTu=_rindex(),
sWanBaoXunBaoDui_MT=_rindex(),
sWanBaoXunBaoDui_GY=_rindex(),
sWanBaoXunBaoDui_DZ=_rindex(),
sWanBaoXunBaoDui_TQ=_rindex(),
sLoginReward=_rindex(),
eYiYuHuiYouShopShengji=_rindex(),
sXianWuLou=_rindex(),
sYLCHandBook=_rindex(),
sYLCSuit=_rindex(),
sXFWDRank=_rindex(),
sXFWDReward=_rindex(),
sRechargeDailyTeHuiSingleDay=_rindex(),
sPushGift=_rindex(),
sZhenBaoGe=_rindex(),
sXMFXZYBase=_rindex(),
sBLSPickUpTarget=_rindex(),
sBLSPickUpLiBao=_rindex(),
sBLSPickUpShop=_rindex(),
sDailyRebate=_rindex(),
sDiscipleLingGen=_rindex(),
sWelfareInvitationCode=_rindex(),
sSectPalaceInfo=_rindex(),
sXianYuanShare=_rindex(),
sGuanZhuAct=_rindex(),
sHeiShi=_rindex(),
sWeekendWelfare=_rindex(),
slingZhenDiaoke=_rindex(),
szzshMonsterLog=_rindex(),
szzshResourceLog=_rindex(),
szzshLingShanLog=_rindex(),
sXianDiTouZi=_rindex(),
sLunDaoRewards=_rindex(),
sWuXingShengDianRewards=_rindex(),
sTMZLsys=_rindex(),
sShopCreate=_rindex(),
sHuiGuiBangDing=_rindex(),
sXianYouZhaoHui=_rindex(),
sChongZhu=_rindex(),
sLingZhenYanJiu=_rindex(),
sYuFuMake=_rindex(),
sWXGameCircle=_rindex(),
sSHZhanLing=_rindex(),
sActivityCalendar=_rindex(),
sDuJieXianDan=_rindex(),
eSheQuAct=_rindex(),
eSheQuAct2=_rindex(),
eSheQuAct3=_rindex(),
sSelectLiBao=_rindex(),
sWXAddReward=_rindex(),
sXBBag=_rindex(),
sXBTujian=_rindex(),
sBaoLingShu=_rindex(),
sQiYuanShu=_rindex(),
sQiYuanShop=_rindex(),
sTeZhiTuJian=_rindex(),
sXWLFenXiangZiYuan=_rindex(),
sWenDingCangQiong=_rindex(),
sXunBaoShiLian=_rindex(),
sXianZhi=_rindex(),
sXianJieMonsterLog=_rindex(),
sXianJieResourceLog=_rindex(),
sWDCQQFActReward=_rindex(),
sTaskreddot=_rindex(),
sXianJieSearchLog=_rindex(),
sXJFMreward_Target=_rindex(),
sDiscipleWenXin=_rindex(),
sDiscipleXianMo=_rindex(),
sCangJingGeXianShu=_rindex(),
sCangJingGeMoGong=_rindex(),
sXianGongBangYu=_rindex(),
sXianJieArenaLog=_rindex(),
sSettingZongMen=_rindex(),
sSettingFeiJian=_rindex(),
sSettingYunZhou=_rindex(),
eChangeAct=_rindex(),
sXianMengZengLi=_rindex(),
sXianGongXianGuan=_rindex(),
sXianGuanTeQuan=_rindex(),
sZongmenLevelInvestor2=_rindex(),
sXianMengDiGong=_rindex(),
sXianGongFaction=_rindex(),
sXianJieMoGongZhengDuoLog=_rindex(),
sBlueDiamondDailyGift=_rindex(),
sBlueDiamondGrowUpGift=_rindex(),
sBlueDiamondNewBieGift=_rindex(),
sSaiJiXianZang=_rindex(),
sShowcaseTeam=_rindex(),
sXMDGPass=_rindex(),
sXianMengZhan=_rindex(),
sMJYGTJYX=_rindex(),
sMJYGBZZM=_rindex(),
sMJYGMZYH=_rindex(),
sXianJieMXSLSingleLog=_rindex(),
sYanDaoTaiCC=_rindex(),
sYanDaoTaiDZ=_rindex(),
eChangeBao=_rindex(),
eHunQiTai=_rindex(),
sMYZSTXZ=_rindex(),
sLingShouEnter=_rindex(),
sLingShouInfo=_rindex(),
sLingShouJingJie=_rindex(),
sLingShouXueMai=_rindex(),
sLingShouBase=_rindex(),
}



local _i3=0
local function _tindex()
_i3=_i3-1
return _i3
end

REDDIT_TYPE=
{



eMail=_tindex(),
eFriend=_tindex(),
eFriendPoint=_tindex(),
eDailyTask=_tindex(),
eGuBaoBase=_tindex(),
eGuBaoCollect=_tindex(),
eGuBaoLianHua=_tindex(),
eGuBaoUpStar=_tindex(),
eGuBaoAwake=_tindex(),
eGongFaBuildHud=_tindex(),
eSchoolReward=_tindex(),
eDiscipleBase=_tindex(),
eXianGouLiBao=_tindex(),
eFaBaoCreateBase=_tindex(),
eDanYao=_tindex(),
eFuLu=_tindex(),
eZhenFa=_tindex(),
eXianMengBase=_tindex(),
eXianMengPalace=_tindex(),
eWelfare=_tindex(),
eStoreHouseBase=_tindex(),
eDiscipleInfo=_tindex(),
eDiscipleTianMing=_tindex(),
eXianShu=_tindex(),
eHeadKuang=_tindex(),
eSectPalace=_tindex(),
eLayoutBuild=_tindex(),
eFaZeBaoDian=_tindex(),
eXianDiTouZi=_tindex(),
eBenMingFaBaoBase=_tindex(),
eCangBaoTuCardRecord=_tindex(),
eDaoBing=_tindex(),
eDiscipleEquip=_tindex(),
eDiscipleFabao=_tindex(),
eXianTuChengJiu_Base=_tindex(),
eXianTuChengJiu_ZongMenXianTu=_tindex(),
eXianTuChengJiu_XianTuChengJiu=_tindex(),
eXianTuChengJiu_FeiShengDaoTu=_tindex(),
eWanBaoXunBaoDui=_tindex(),
eYiYuHuiYouShop=_tindex(),
eXianWuLou=_tindex(),
eYueLongChi=_tindex(),
eXMFXZY=_tindex(),
eBLSPickUp=_tindex(),
eFair=_tindex(),
elingZhenDiaoke=_tindex(),
eZZSHLog=_tindex(),
eTotalTouZiActivity=_tindex(),
eTMZLsys=_tindex(),
eShop=_tindex(),
eLingZhenYanJiu=_tindex(),
eSHZhanLing=_tindex(),
eXianBao=_tindex(),
eBaoLingShu=_tindex(),
eQiYuanShu=_tindex(),
eTeZhiTuJian=_tindex(),
eWenDingCangQiong=_tindex(),
eXianZhi=_tindex(),
eXianJieLog=_tindex(),
eWDCQQFAct=_tindex(),
eXianjieFuMo=_tindex(),
eCangJingGeXinFa=_tindex(),
eXianGong=_tindex(),
eXianMengDiGong=_tindex(),
eBlueDiamond=_tindex(),
ePlayerSetting=_tindex(),
eXMDGPass=_tindex(),
eXianMengZhan=_tindex(),
eMJYGExtend=_tindex(),
eXianJieMXSLLog=_tindex(),
eYanDaoTai=_tindex(),
eHunQiTai=_tindex(),
eLingShouBase=_tindex(),
eLingShou=_tindex(),
}



for k,v in pairs(REDDIT_SUB_TYPE)do
_subNameLookup[v]=tostring(k)
end

for k,v in pairs(REDDIT_TYPE)do
_nameLookup[v]=tostring(k)
end



function reddotConfig.get_sub_name_by_type(subType)
if subType==nil then return''end
local str=_subNameLookup[subType]
if str then
return string.format('REDDIT_SUB_TYPE.%s',str)



end
return tostring(subType)
end

function reddotConfig.get_name_by_type(typo)
if typo==nil then return''end
local str=_nameLookup[typo]
if str then
return string.format('REDDIT_TYPE.%s',_nameLookup[typo])
end
return tostring(typo)
end

function reddotConfig.get_base_val()
return _baseVal
end

function reddotConfig.isSubType(reddotType)
return reddotType>0
end


