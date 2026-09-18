








activitiesServerType={
eNone=0,
eKuafu=1,
eRole=2,
eBigCross=3,
}


commonActivitiesType={
tuitu=0,
}

function activitiesModel:getServerType(actID)
if actID>70000 then
return activitiesServerType.eBigCross
elseif actID>50000 then
return activitiesServerType.eRole
elseif actID>30000 then
return activitiesServerType.eKuafu
else
return activitiesServerType.eNone
end
end

function activitiesModel:getSendMessageSeverType(actID)
local serverType=activitiesModel:getServerType(actID)
if serverType==activitiesServerType.eKuafu then
return sendMessageServerType.eKuafu
else
return sendMessageServerType.eNone
end
end





subActInfoChildConfig={

[SUB_ACTIVITY_TYPE.eXianShiChouKa]='subActivityInfo_xinashichouka',

[SUB_ACTIVITY_TYPE.eXianShiQianDao]='subActivityInfo_xinashiqiandao',

[SUB_ACTIVITY_TYPE.eXianShiLiBao]='subActivityInfo_xianshilibao',

[SUB_ACTIVITY_TYPE.eDuiHuanShangDian]='subActivityInfo_exchargeshop',

[SUB_ACTIVITY_TYPE.eYueKaZengLi]='subActivityInfo_monthInvestorGift',

[SUB_ACTIVITY_TYPE.eMuBiaoHuoDong]='subActivityInfo_targetActivity',

[SUB_ACTIVITY_TYPE.eTeHuiLiBao]='subActivityInfo_tehuilibao',

[SUB_ACTIVITY_TYPE.eJiuCengYaoLou]='subActivityInfo_jiucengyaolou',

[SUB_ACTIVITY_TYPE.eSuoYaoShiLian]='subActivityInfo_suoyaoshilian',

[SUB_ACTIVITY_TYPE.eXianGuYiJi]='subActivityInfo_xianguyiji',

[SUB_ACTIVITY_TYPE.eLianDanDaHui]='subActivityInfo_liandandahui',

[SUB_ACTIVITY_TYPE.eTuFaEventAct]='subActivityInfo_tufaEvent',

[SUB_ACTIVITY_TYPE.eBigShengChanFullGoal]='subActivityInfo_servertask',

[SUB_ACTIVITY_TYPE.eXianShiInvest]='subActivityInfo_limitInvestor',

[SUB_ACTIVITY_TYPE.eBigShengChanRank]='subActivityInfo_manufactureRank',

[SUB_ACTIVITY_TYPE.eFuZheXinLing]='subActivityInfo_fuzhixinling',

[SUB_ACTIVITY_TYPE.eSectCompetition]='subActivityInfo_zongmendabi',

[SUB_ACTIVITY_TYPE.eDuiHuanHuoDong]='subActivityInfo_duihuanhuodong',

[SUB_ACTIVITY_TYPE.eTanBaoGe]='subActivityInfo_tanbaoge',

[SUB_ACTIVITY_TYPE.eTianShuXiuXing]='subActivityInfo_tianshuxiuxing',

[SUB_ACTIVITY_TYPE.eXianShiChouKa2]='subActivityInfo_xinashichouka2',

[SUB_ACTIVITY_TYPE.eDropAct]='subActivityInfo_dropAct',

[SUB_ACTIVITY_TYPE.eDongTianFuDi]='subActivityInfo_dongtianfudi',

[SUB_ACTIVITY_TYPE.eCangBaoGeOverView]='subActivityInfo_cangbaotu_overview',

[SUB_ACTIVITY_TYPE.eCangBaoGe]='subActivityInfo_cangbaotu',

[SUB_ACTIVITY_TYPE.eDaoBingGeAct]='subActivityInfo_daobingge',

[SUB_ACTIVITY_TYPE.eTianMingZengLi]='subActivityInfo_tianmingzengli',

[SUB_ACTIVITY_TYPE.eFuXingGaoZhao]='subActivityInfo_fuxinggaozhao',

[SUB_ACTIVITY_TYPE.eXianJuTeHui]='subActivityInfo_xianjutehui',

[SUB_ACTIVITY_TYPE.eLianGouHaoLi]='subActivityInfo_liangouhaoli',

[SUB_ACTIVITY_TYPE.eLianGouHaoLiRole]='subActivityInfo_liangouhaoliRole',

[SUB_ACTIVITY_TYPE.eTongBaoXianShi]='subActivityInfo_tongbaoxianshi',

[SUB_ACTIVITY_TYPE.eCloudCityTreasure]='subActivityInfo_yunchengtanbao',

[SUB_ACTIVITY_TYPE.eHangDaoTeQuan]='subActivityInfo_tanxianduitequan',

[SUB_ACTIVITY_TYPE.eDailyLiBao]='subActivityInfo_dailylibao',

[SUB_ACTIVITY_TYPE.eTargetTask2]='subActivityInfo_targetActivity2',

[SUB_ACTIVITY_TYPE.eTianTiShiLian]='subActivityInfo_tiantishilian',

[SUB_ACTIVITY_TYPE.eTianDaoMiJi]='subActivityInfo_gongfagain',

[SUB_ACTIVITY_TYPE.eWanBaoJianShang]='subActivityInfo_wanbaojianshangAct',

[SUB_ACTIVITY_TYPE.eDressLottery]='subActivityInfo_shizhuangchoujian',

[SUB_ACTIVITY_TYPE.eRankAct1]='subActivityInfo_rankAct1',

[SUB_ACTIVITY_TYPE.eInvestAct2]='subActivityInfo_InvestAct2',

[SUB_ACTIVITY_TYPE.eTianMoRuQin]='subActivityInfo_tianmoruqin',

[SUB_ACTIVITY_TYPE.eTianMoBaoXia]='subActivityInfo_doubleLottery',

[SUB_ACTIVITY_TYPE.ePaintedPuzzle]='subActivityInfo_huiyingpintu',

[SUB_ACTIVITY_TYPE.eTanXianLiBao]='subActivityInfo_tanxianduitanbao',

[SUB_ACTIVITY_TYPE.eQingDianQianDao]='subActivityInfo_qingdainqiandao',

[SUB_ACTIVITY_TYPE.eQieShiShenShou]='subActivityInfo_qieshishenshou',

[SUB_ACTIVITY_TYPE.eTaiGuShiLian]='subActivityInfo_taiguBoss',

[SUB_ACTIVITY_TYPE.eFaBaoMiLu]='subActivityInfo_fabaomilu',

[SUB_ACTIVITY_TYPE.eFaBaoShiLian]='subActivityInfo_fabaoshilian',

[SUB_ACTIVITY_TYPE.eShiLianMuBiao]='subActivityInfo_shilianTarget',

[SUB_ACTIVITY_TYPE.eTargetTask4]='subActivityInfo_targetActivity4',

[SUB_ACTIVITY_TYPE.eBuyAct6]='subActivityInfo_xianshilibao2',

[SUB_ACTIVITY_TYPE.eJieRiQianDao]='subActivityInfo_festivalSignIn',

[SUB_ACTIVITY_TYPE.egongCheQianDao]='subActivityInfo_gongceqiandao',

[SUB_ACTIVITY_TYPE.eXianMengTeQuan]='subActivityInfo_xianmengtequan',

[SUB_ACTIVITY_TYPE.eDaBiaoZengLi]='subActivityInfo_dabiaozengli',

[SUB_ACTIVITY_TYPE.eRechargeAct1]='subActivityInfo_totalRecharge',

[SUB_ACTIVITY_TYPE.eXianJieQiYuan]='subActivityInfo_xianjieqiyuan',

[SUB_ACTIVITY_TYPE.eFuYaoShiLian]='subActivityInfo_fuyaoBoss',

[SUB_ACTIVITY_TYPE.eXianShiChouKa_Role]='subActivityInfo_xinashichouka_Role',

[SUB_ACTIVITY_TYPE.eLongHuMountain]='subActivityInfo_longhudaodan',

[SUB_ACTIVITY_TYPE.eGuiTuXiuXing]='subActivityInfo_guituxiuxing',

[SUB_ACTIVITY_TYPE.eGuiTuQianDao]='subActivityInfo_zaixuxianyan_qiandao',

[SUB_ACTIVITY_TYPE.eLongHuZhiBao]='subActivityInfo_longhuzhibao',

[SUB_ACTIVITY_TYPE.eGuiTuTeQuan]='subActivityInfo_guitutequan',

[SUB_ACTIVITY_TYPE.eLongHuXiangYao]='subActivityInfo_longhuxiangyao',

[SUB_ACTIVITY_TYPE.eZaiXuXianYuan]='subActivityInfo_zaixuxianyuan',

[SUB_ACTIVITY_TYPE.eLongHuHuiJuan]='subActivityInfo_longhuhuijuan',

[SUB_ACTIVITY_TYPE.eGuiTuZhiYin]='subActivityInfo_guituzhiyin',

[SUB_ACTIVITY_TYPE.eDingZhiDaZao]='subActivityInfo_dingzhidazao',

[SUB_ACTIVITY_TYPE.eYuFuMuBiao]='subActivityInfo_yufutarget',

[SUB_ACTIVITY_TYPE.eHuiHuaDianJi]='subActivityInfo_drawdianji',

[SUB_ACTIVITY_TYPE.eXianTuZhuli]='subActivityInfo_xiantuzhuli',

[SUB_ACTIVITY_TYPE.eNiuDanJi]='subActivityInfo_niudanji',

[SUB_ACTIVITY_TYPE.ePassPortAct1]='subActivityInfo_tytongxingzhengtab',
[SUB_ACTIVITY_TYPE.ePassPortAct2]='subActivityInfo_tytongxingzheng',
[SUB_ACTIVITY_TYPE.ePassPortAct3]='subActivityInfo_tytongxingzhengtab2',
[SUB_ACTIVITY_TYPE.ePassPortAct4]='subActivityInfo_tytongxingzheng2',

[SUB_ACTIVITY_TYPE.eZhenYaoShiLian]='subActivityInfo_zhenyaoshilian',

[SUB_ACTIVITY_TYPE.eChiSeJinDi]='subActivityInfo_chisejindi',

[SUB_ACTIVITY_TYPE.eSectPractice]='subActivityInfo_zongmengxiuxing',

[SUB_ACTIVITY_TYPE.eDuiHuanShangDian2]='subActivityInfo_exchangeshop',

[SUB_ACTIVITY_TYPE.eRankActCross]='subActivityInfo_crossranking',

[SUB_ACTIVITY_TYPE.eLingZhenHuiHua]='subActivityInfo_lingzhendiaoke',

[SUB_ACTIVITY_TYPE.eLingZhenHuiHua2]='subActivityInfo_rolelingzhendiaoke',

[SUB_ACTIVITY_TYPE.ebuyact9]='subActivityInfo_shizhuangzhigou',

[SUB_ACTIVITY_TYPE.eTianMoBaoXia2]='subActivityInfo_roledoubleLottery',

[SUB_ACTIVITY_TYPE.eDuiHuanHuoDong2]='subActivityInfo_duihuanhuodongActor',

[SUB_ACTIVITY_TYPE.eLanternriddles]='subActivityInfo_zhongqiudengmi',

[SUB_ACTIVITY_TYPE.eLotteryact7]='subActivityInfo_chaoslingchi',

[SUB_ACTIVITY_TYPE.eXianXuanBaoXia]='subActivityInfo_xianxuanbaoxia',

[SUB_ACTIVITY_TYPE.eXiShiZhenBao]='subActivityInfo_xishizhenbao',

[SUB_ACTIVITY_TYPE.eLotteryact8]='subActivityInfo_gujixunbao',

[SUB_ACTIVITY_TYPE.eLotteryact9]='subActivityInfo_yunhaidiaobao',

[SUB_ACTIVITY_TYPE.eFeiJianDuoBao]='subActivityInfo_feijianduobao',

[SUB_ACTIVITY_TYPE.eCaiShenJiaDao]='subActivityInfo_caishenjiadao',

[SUB_ACTIVITY_TYPE.eTargetActivity5]='subActivityInfo_targetactivity5',

[SUB_ACTIVITY_TYPE.eZhouNianQingQianDao]='subActivityInfo_anniversarysignin',

[SUB_ACTIVITY_TYPE.eXianJieQiYuan2]='subActivityInfo_xianjieqiyuan2',

[SUB_ACTIVITY_TYPE.eExchangeAct3config]='subActivityInfo_anniversaryduihuan',

[SUB_ACTIVITY_TYPE.eGuBaoShiLian]='subActivityInfo_gubaoshilian',

[SUB_ACTIVITY_TYPE.ePictureDisciple]='subActivityInfo_tujiandizi',

[SUB_ACTIVITY_TYPE.ePictureSpeciality]='subActivityInfo_tujiantezhi',

[SUB_ACTIVITY_TYPE.eLunHuiZhuanPan]='subActivityInfo_lunhuizhuanpan',

[SUB_ACTIVITY_TYPE.eXingJiaoShangRen]='subActivityInfo_xingjiaoshangren',

[SUB_ACTIVITY_TYPE.eZhongLiXieXin]='subActivityInfo_zhonglixiexin',

[SUB_ACTIVITY_TYPE.eTianMingJinJie]='subActivityInfo_tianmingjinjie',

[SUB_ACTIVITY_TYPE.eLianQiDaHui]='subActivityInfo_lianqidahui',

[SUB_ACTIVITY_TYPE.eWuXingBuTian]='subActivityInfo_wuxingbutian',

[SUB_ACTIVITY_TYPE.eWanZongDuiJue]='subActivityInfo_wanzongduijue',

[SUB_ACTIVITY_TYPE.eShiGuangPinTu]='subActivityInfo_shiguangpintu',

[SUB_ACTIVITY_TYPE.eTargetTask6]='subActivityInfo_zixuantouzi',

[SUB_ACTIVITY_TYPE.eChaoZhiTeHui]='subActivityInfo_chaozhitehui',

[SUB_ACTIVITY_TYPE.eTargetTask7]='subActivityInfo_targetactivity7',

[SUB_ACTIVITY_TYPE.eRechargeAct1Role]='subActivityInfo_totalRechargeRole',

[SUB_ACTIVITY_TYPE.eShenHaiXunBao]='subActivityInfo_shenhaixunbao',

[SUB_ACTIVITY_TYPE.eHuiYingCangXi]='subActivityInfo_huiyingcangxi',

[SUB_ACTIVITY_TYPE.eTianXuYiShi]='subActivityInfo_tianxuyishi',

[SUB_ACTIVITY_TYPE.eHunYuanDanHui]='subActivityInfo_hunyuandanhui',

[SUB_ACTIVITY_TYPE.eLingShuCiFu]='subActivityInfo_lingshucifu',

[SUB_ACTIVITY_TYPE.eXianMengHongBao]='subActivityInfo_xianmenghongbao',




[SUB_ACTIVITY_TYPE.eTianMingZengLi_sys]='subActivityInfo_sys_tianmingzengli',

[SUB_ACTIVITY_TYPE.eXianYouRuYun_sys]='subActivityInfo_sys_xianyouruyun',

[SUB_ACTIVITY_TYPE.eFangYingTing]='subActivityInfo_fangyingting',

[SUB_ACTIVITY_TYPE.eLotteryact13]='subActivityInfo_xingyunzhuanpan',

[SUB_ACTIVITY_TYPE.eZuShiShouJi]='subActivityInfo_zushishouji',
}



ActIconShowConfig=
{

[SUB_ACTIVITY_TYPE.eTaiGuShiLian]=
{
isInit=false,
abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab',
iconname='image_jijiangjiesuan_1',
callback=function(actID,subType,subID)
local result=false
local info=activitiesModel:getSubActInfo(actID,subType,subID)
local start_time=info.start_time
local list=call_activitiesHandle_func('activitiesHandle_taiguBoss','checkbossOpen',actID,subType,subID)
local nowbossID=1
for k,v in ipairs(list)do
if v==1 then
nowbossID=k
end
end

local flag3=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',actID,subID,start_time),false)
if flag3 and flag3~=0 and flag3==nowbossID then
result=true
end
return result
end
},

[SUB_ACTIVITY_TYPE.eLongHuHuiJuan]=
{
isInit=false,
abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab',
iconname='image_jijiangjiesuan_1',
callback=function(actID,subType,subID)
local result=false

return result
end
},
[SUB_ACTIVITY_TYPE.eRankActCross]=
{
isInit=true,
abname='ui/sharedtextures/uiglobalspriteatlas_4.ab',
iconname='image_phyijiesuan_1',
callback=function(actID,subType,subID)
local result=false

local info=activitiesModel:getSubActInfo(actID,subType,subID)
result=info:checkRealFinish()

return result
end
},
}



BigActivityIconConfig=
{

[SUB_ACTIVITY_TYPE.eTaiGuShiLian]=
{
abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab',
iconname='image_shilian_1',
callback=function(actID,subType,subID)
local result=false
local info=activitiesModel:getSubActInfo(actID,subType,subID)
local start_time=info.start_time
local list=call_activitiesHandle_func('activitiesHandle_taiguBoss','checkbossOpen',actID,subType,subID)
local nowbossID=1
for k,v in ipairs(list)do
if v==1 then
nowbossID=k
end
end

local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopen',actID,subID,start_time),false)
if flag and flag~=nowbossID then
result=true
end







local reddot=call_activitiesHandle_func('activitiesHandle_taiguBoss','checkIsNewBoss',actID,subType,subID,nowbossID)
if reddot then
result=true
end

local reddot2=call_activitiesHandle_func('activitiesHandle_taiguBoss','checkIsLastDayBoss',actID,subType,subID)
if reddot2 then
result=true
end
return result
end
},

[SUB_ACTIVITY_TYPE.eFuYaoShiLian]=
{
abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab',
iconname='image_shilian_1',
callback=function(actID,subType,subID)
local result=false
local info=activitiesModel:getSubActInfo(actID,subType,subID)
local start_time=info.start_time
local list=call_activitiesHandle_func('activitiesHandle_fuyaoBoss','checkbossOpen',actID,subType,subID)
local nowbossID=1
for k,v in ipairs(list)do
if v==1 then
nowbossID=k
end
end

local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_fyslopen',actID,subID,start_time),false)
if flag and flag~=nowbossID then
result=true
end







local reddot=call_activitiesHandle_func('activitiesHandle_fuyaoBoss','checkIsNewBoss',actID,subType,subID,nowbossID)
if reddot then
result=true
end

local reddot2=call_activitiesHandle_func('activitiesHandle_fuyaoBoss','checkIsLastDayBoss',actID,subType,subID)
if reddot2 then
result=true
end

return result
end
}
}
