dialogueRepeatRemindModel={}

local _fileStr='repeatRemind'
local _data={}


REPEAT_TIME_TYPE=
{
eLogin=1,
eDay=2,
eWeek=3,
}

REPEAT_TYPE={
eExchargeXianyuMoney='1',
eJJXiuWeiDanUse='2',
eRongLian='3',
eZheXianLingAni='4',
eSelectDaoBing='5',
eChangeBenMingFaBaoOwner='6',
eUseExpByAbsorbExp='7',
eBuyDaoBingLv='8',
eDaoBingCombine='9',
eXFWDZhanYUDain='10',
eGuanYingGe='11',
eSelectClothing='12',
eXianZhanGaiJianTips='13',
eKickoutDZSelect='14',
eXuanShangHighQualityRefresh='15',
eXuanShangCostRefresh='16',
eXianYuanXunFnagCostChouKa='17',
eXianYuanXunFnagCostChouKa2='18',
eWBSHBuyEnhanced='19',
eBuildingInfoCostSpeedUpTips='20',
eBuildingTearDown='21',
eLayoutEditorStorageAllBuilding='22',
eLayoutEditorDesignReset='23',
eLayoutEditorNotYetApply='24',
eItemHideReconfirmDialog='25',
eItemHideFullSpecialityTipsDialog='26',
eFuLuDecomposeDialog='27',
eFangShiBuyDialog='28',
eDouFaTaiChallengeHonorMaxToday='29',
eHideRemoveFabaoCreatePlanDialog='30',
eChangeBuildSkinDialog='31',
eBaoLintShuBuyDialog='32',
eZongMenDaBiBuyChallengeDialog='33',
eTanBaoGeUseDialog='34',
eItemUseCheckTezhiAddFlag='35',
eAuctionBuyDialog='36',
eAutoTakeDiscipleReward='37',
eFightPreSelectProduction='38',
eFightPreSelectMultiFight='39',
eMiCangTips1='40',
eMiCangTips2='41',
eMiCangTips3='42',
eMiCangTips4='43',
eMiCangTips5='44',
eWBXBDIdleTip='45',
eCatMiJin='46',
eHuiYinPinTu='46',
eWXDBuyLayer='47',
eTianMoRuQinSearch='48',
eXianMenKuFang='49',
eXDTNaoYuTiXing='50',
eYunChenTanBaoItem='51',
eZZSHtips='52',
eZZSHtips2='53',
eYCTBBuyTips='54',
eZMSWBXGetTips='55',
eBatchCancelPlant='56',
eZZSHShop='57',
eZZSHPvPtips='58',
eZZSHPvPtips2='59',
eKickoutDiscipleCouple='60',
eLZDKTips='61',
eTMReset='62',
eTMResetUse='63',
eSystemZMStrength='64',
eUseZhiLiaoTis='65',
eChiSeJinDiCostEnterCopy='66',
eChiSeJinDiFullDailyScore='67',
eIsPlayHuanJingOpenAnim='68',
eChiSeJinDiBetterDisciple='69',
eChiSeJinDiBetterWeapon='70',
eDuJieXianDanLianDan='71',
eDiscipleFashionReset='72',
eUseTeZhiItemTips='73',
eDiscipleQuickUseDanYao='74',
eMaxMailOpenTips='75',
eHongChenJieFreeTips='78',
eWanBaoShangHuiAutoJJ='79',
eHouShanZhenLingCanChalleng='80',
eUIRecruitSelectWincolor='81',
eYLZAcc='82',
eJuTianYiAcc='83',
eYJYFastFinish='84',
eTMResetFirst='85',
ePrisonJY='86',
eXianJieLeyLineRepair='87',
eChuZhanNotEnoughSoldier='88',
eQuZhuTipsTask='89',
eQuZhuTipsBase='90',
eshengchanAddSpeed='91',
eXianJieJiJieEndGo='92',
eXianJieYBDTeamInvalid='93',
eMiCangTips6='94',
eXZSTips='95',
eXianJieSpeedUp='96',
eXianJieSpeedUp2='97',
eXianJieSpeedUp3='98',
eMutipleRoomBuildDestory='99',
eXianJieSpeedUp4='100',
eXJBJdelettips='101',
eXJJunJiaYingSpeedUp='102',
eXJJunJiaYingoneSpeedUp='103',
eXJYuLingZhaiSpeedUp='104',
eSpecialityLoveDelete='105',
eWXSDFight='106',
eSpecialityLoveGiveUp='107',
eXingChenQiangHua='108',
eXianmengPaimai='109',
eLianQiMiniGame1='110',
eLianQiMiniGame2='111',
eLianQiMiniGame3='112',
eItemWine1='113',
eItemWine2='114',
eItemWine3='115',
eMiCangOtherHoldAutoFind='116',
eZZSHSeasonSettlementTips='117',
eChangeSex='118',
eEquipPresetJumpDisciple='119',
eSubZLXXRecordReddot='120',
eItemExpireSell='121',
eXingChenFenJie='122',
eXingChenFenJieRed='123',
eXingChenFenJieRedStar='124',
eXMDGPassBuyProgress='125',
eXingChenQiangHua_RedItem='126',
eXingChenQiangHua_OrangeItem='127',
eZMAttacktip='128',
eZMAttacktipEx='129',
eMJYG_TJYX='130',
eMCBK_Push_Tips='131',
eMCBK_Push_Rule_Tips='132',
eNightFightFatigueTips='133',
eXBSL_TiaoZhanReddot='134',
eBSZLReddot='135',
eMoJieSGTips='136',
eJiuYouTaTiaoZhanReddot='137',
eMXSLPaiQian='138',
eMoJieShop='139',
eMXSLPaiQianColor='140',
eYunZhouComponentsComposeTips='141',
eYaoTianXunXianMaxLP='142',
eHanBaoZhiYin='143',
eHunYuanDanHuiUseItem='144',
eMXSLRefresh='145',
eMXSLMaxColorRefresh='146',
eTianDaoDingLianZhi='147',
eLingShouQianLiDanYaoUseItem='148',
eLingShouXueMaiTuPoTiShi='149',
eFuncItemUseJJOut='150',
eFuncItemUseLTOut='151',
eMingYuanZhuShaCrossRankReq='152',
eLingShouFangShengTiXing='153',
eLingShouFangShengPinzhiTiXing='154',
eXianJieLingShouShare='155',









}

function dialogueRepeatRemindModel.onEnter()
local args=userActorSetting.get(_fileStr,{})

local flag=false

for i,v in pairs(args)do
if tostring(v)=="userdata: NULL"or not v.id then
args[i]=nil
flag=true
end
end

_data={}
for i,v in pairs(args)do
if v then
_data[v.id]=v.content
end
end

local repeatTime=REPEAT_TIME_TYPE.eLogin
if _data[repeatTime]~=nil then
_data[repeatTime]=nil
flag=true
end

if flag then
dialogueRepeatRemindModel:flushVal()
end
end

function dialogueRepeatRemindModel.reset()
_data={}
end

function dialogueRepeatRemindModel.setRepeatVis(repeatTime,repeatType,flag)
if _data[repeatTime]==nil then _data[repeatTime]={}end
local data=_data[repeatTime]
local info=data[repeatType]
if type(data[repeatType])=="userdata"then
local peer=tolua.getpeer(info)
if peer then
local t=nil
peer={}
tolua.setpeer(t,peer)
info=t
else
info=nil
end
end
local vis=info and info[2]or false
if flag==false and vis==flag then return end
local shortTime=flag and timeHelper.getServerShortTime()or 0
data[repeatType]={shortTime,flag}

dialogueRepeatRemindModel:flushVal()
end

function dialogueRepeatRemindModel:flushVal()
local args={}
for i,v in pairs(_data)do
args[#args+1]={id=i,content=v}
end
userActorSetting.flushVal(_fileStr,args)
end

function dialogueRepeatRemindModel.getRepeatVis(repeatTime,repeatType)
if _data[repeatTime]==nil then return false end
local info=_data[repeatTime][repeatType]
if type(info)=="userdata"then
local peer=tolua.getpeer(info)
if not peer then
return false
end
end
if info==nil or info[1]==nil then return false end
if repeatTime==REPEAT_TIME_TYPE.eDay then
return timeHelper.isTodayShort(info[1])
elseif repeatTime==REPEAT_TIME_TYPE.eWeek then
return timeHelper.isToWeekShort(info[1])
else
return info[2]or false
end
end
