













local actRecvTypeConfig={
{249,1,nil,function(...)
activitiesModel:recv_actInitDatas(activitiesServerType.eNone,...)
end},
{249,61,nil,function(...)
activitiesModel:recv_actInitDatas(activitiesServerType.eKuafu,...)
end},
{249,103,nil,function(len,actList)
actRoleController:setOpenedActLookup(actList)
actList=actRoleController:checkRemoveRoleActList(actList)
len=actList and#actList or 0
activitiesModel:recv_actInitDatas(activitiesServerType.eRole,len,actList)
end},
{247,116,nil,function(...)
activitiesModel:recv_actInitDatas(activitiesServerType.eBigCross,...)
end},

{249,107,nil,function(len,actList)
if len==0 then return end
actRoleController:removeOpenList(actList)
activitiesModel:recv_openActDatas(activitiesServerType.eRole,len,actList)
end},
{247,68,nil,function(len,tuituList)
if len==0 then return end
activitiesModel:recv_commonActivitiesDatas(commonActivitiesType.tuitu,len,tuituList)
end},
{247,69,nil,function(tuituList)
activitiesModel:recv_changeCommonActivitiesDatas(commonActivitiesType.tuitu,tuituList)
end},
{249,5},{249,6},{249,7},{249,8},{249,85},{249,154},
{249,12},
{249,13},
{249,14},
{249,4,'onLiBaoInit'},{249,160},
{249,21,'onInfoRecv'},
{249,20},
{249,9,'onExchargeShopInit'},
{249,10,'onExchargeShopBuy'},
{249,11,'onExchargeShopRewards'},
{249,15},
{249,16},
{249,17},
{249,18},
{249,19},
{249,22},
{249,23},
{249,24},
{249,25},
{249,26},
{249,27},
{249,28},
{249,29},
{249,30},
{249,31},
{249,32},
{249,33},
{249,35},
{249,36},
{249,37},
{249,38},
{249,39},
{249,40},
{249,41},
{249,42},
{249,43},
{249,44},
{249,45},
{249,46},
{249,47},
{249,48},
{249,49},
{249,50},
{249,51},
{249,52},{249,53},{249,54},{249,55},{249,203},
{249,65},{249,66},{249,67},{249,68},
{249,69},{249,70},{249,71},{249,72},{249,87},{249,155},
{249,73},
{249,78},{249,79},{249,80},{249,81},{249,82},{249,83},
{249,74},{249,75},{249,76},{249,77},
{249,84,'onDaoBingGeInfo'},
{249,86,'onDaoBingGeFreshTask'},
{249,88,'onDaoBingGeBuyLevel'},
{249,89,'onDaoBingGeExchargeGift'},
{249,90,'onDaoBingGeActiveTrain'},
{249,91,'onDaoBingGeLevelPrize'},
{249,56},{249,57},{249,58},{249,59},
{249,92},{249,93},{249,94},
{249,95},{249,97},{249,98},{249,99},{249,100},{249,101},{249,205},
{249,96},
{249,60},
{249,102},
{249,108},
{249,114},
{249,109},{249,110},{249,111},{249,112},
{249,113},
{249,115},
{249,116},
{249,117},
{249,118},{249,119},{249,120},{249,122},{249,123},{249,124},{249,125},
{249,121},{249,126},
{249,130},{249,131},{249,132},{249,133},{249,134},{249,135},{249,136},{249,137},{249,138},{249,139},{249,140},
{249,141},{249,142},{249,145},
{249,143},{249,144},
{249,148},
{249,151},{249,152},{249,153},
{249,161},
{249,162},{249,163},
{249,168},{249,169},{249,170},
{249,171},{249,172},
{249,174},
{249,173},
{249,164},{249,165},{249,166},
{249,146},{249,147},
{249,150},{249,212},
{249,175},{249,176},{249,177},{249,178},{249,179},{249,180},
{249,181},{249,182},{249,183},
{249,184},
{249,185},{249,186},{249,187},{249,188},
{249,189},
{249,191},{249,192},{249,193},{249,202},{249,204},
{249,190},
{249,195},{249,196},
{249,127},{249,128},{249,129},{249,149},
{249,197},{249,198},{249,199},{249,200},{249,201},
{249,194},
{249,207},
{249,208},{249,209},{249,211},
{249,210},
{249,216},{249,217},{249,218},{249,219},
{249,220},{249,221},{249,222},{249,223},
{249,230},{249,231},{249,232},{249,233},{249,234},{249,235},{249,236},{249,237},{249,238},{249,239},{249,240},{249,241},
{249,245},{249,246},{249,247},{249,248},
{249,242},{249,243},
{247,1},{247,2},
{247,3},{247,97},{247,60},
{249,249},{249,250},{249,251},{249,252},{249,253},
{249,224},{249,225},{249,226},
{249,254},
{247,4},{247,5},
{247,6},{247,7},
{247,8},{247,9},
{247,10},{247,11},{247,12},{247,13},{247,14},{247,15},
{247,16},
{247,17},{247,18},
{247,19},{247,20},{247,21},{247,22},{247,23},
{247,24},
{247,25},{247,26},{247,27},{247,28},
{247,29},{247,30},{247,31},{247,32},
{247,33},{247,34},
{247,35},
{247,36},{247,37},{247,38},{247,39},{247,40},{247,41},{247,59},
{247,42},{247,43},{247,44},{247,45},{247,46},{247,47},
{247,53},{247,54},
{247,55},{247,56},
{247,57},{247,58},
{247,49},{247,50},{247,51},{247,52},
{247,61},{247,62},
{247,63},{247,64},{247,65},{247,66},
{247,67},
{247,70},{247,71},{247,72},{247,73},{247,74},
{247,75},{247,76},
{247,77},{247,78},{247,79},{247,80},{247,91},
{247,81},{247,82},{247,83},{247,84},{247,85},{247,86},
{247,87},{247,88},{247,89},
{247,90},
{247,96},
{247,92},{247,93},{247,94},{247,110},
{247,98},{247,99},
{249,213},{249,214},
{249,159},
{247,100},{247,101},{247,102},{247,103},{247,104},{247,109},
{247,105},{247,106},{247,107},
{247,108},
{247,111},{247,112},
{247,113},{247,114},{247,115},{247,122},{247,127},{247,128},
{247,120},{247,121},
{247,123},{247,124},{247,125},{247,126},
}






local subActRecvHandleConfig=
{
[SUB_ACTIVITY_TYPE.eXianShiChouKa]={'activitiesHandle_xianshichouka',{'249_5','249_6','249_7','249_8','249_85','249_154'}},
[SUB_ACTIVITY_TYPE.eXianShiChouKa2]={'activitiesHandle_xianshichouka2',{'249_69','249_70','249_71','249_72','249_87','249_155'}},
[SUB_ACTIVITY_TYPE.eXianShiQianDao]={'activitiesHandle_xianshiqiandao',{'249_12','249_13','249_14','249_184'}},
[SUB_ACTIVITY_TYPE.eXianShiLiBao]={'activitiesHandle_xianshilibao',{'249_4'}},
[SUB_ACTIVITY_TYPE.eBuyAct6]={'activitiesHandle_xianshilibao2',{'249_160'}},
[SUB_ACTIVITY_TYPE.eYueKaZengLi]={'activitiesHandle_monthInvestorGift',{'249_20'}},
[SUB_ACTIVITY_TYPE.eTeHuiLiBao]={'activitiesHandle_tehuilibao',{'249_21'}},
[SUB_ACTIVITY_TYPE.eDuiHuanShangDian]={'activitiesHandle_exchargeshop',{'249_9','249_10','249_11'}},
[SUB_ACTIVITY_TYPE.eMuBiaoHuoDong]={'activitiesHandle_targetActivity',{'249_15','249_16','249_17','249_18','249_19'}},
[SUB_ACTIVITY_TYPE.eJiuCengYaoLou]={'activitiesHandle_jiucengyaolou',{'249_22','249_23','249_46','249_47','249_48'}},
[SUB_ACTIVITY_TYPE.eSuoYaoShiLian]={'activitiesHandle_suoyaoshilian',{'249_24','249_25'}},
[SUB_ACTIVITY_TYPE.eXianGuYiJi]={'activitiesHandle_xianguyiji',{'249_27','249_28','249_29'}},
[SUB_ACTIVITY_TYPE.eLianDanDaHui]={'activitiesHandle_liandandahui',{'249_26'}},
[SUB_ACTIVITY_TYPE.eBigShengChanRank]={'activitiesHandle_manufactureRank',{'249_30','249_43'}},
[SUB_ACTIVITY_TYPE.eBigShengChanFullGoal]={'activitiesHandle_servertask',{'249_31'}},
[SUB_ACTIVITY_TYPE.eXianShiInvest]={'activitiesHandle_limitInvestor',{'249_32'}},
[SUB_ACTIVITY_TYPE.eFuZheXinLing]={'activitiesHandle_fuzhixinling',{'249_33'}},
[SUB_ACTIVITY_TYPE.eSectCompetition]={'activitiesHandle_zongmendabi',{'249_36','249_37','249_38','249_39','249_40','249_41','249_42','249_49','249_50','249_51'},true},
[SUB_ACTIVITY_TYPE.eDuiHuanHuoDong]={'activitiesHandle_duihuanhuodong',{'249_44','249_45'}},
[SUB_ACTIVITY_TYPE.eTanBaoGe]={'activitiesHandle_tanbaoge',{'249_52','249_53','249_54','249_55','249_203'}},
[SUB_ACTIVITY_TYPE.eTianShuXiuXing]={'activitiesHandle_tianshuxiuxing',{'249_65','249_66','249_67','249_68'}},
[SUB_ACTIVITY_TYPE.eDropAct]={'activitiesHandle_dropAct',{'249_73'}},
[SUB_ACTIVITY_TYPE.eCangBaoGe]={'activitiesHandle_cangbaotu',{'249_78','249_79','249_80','249_81','249_82','249_83'}},
[SUB_ACTIVITY_TYPE.eDaoBingGeAct]={'activitiesHandle_daobingge',{'249_84','249_86','249_88','249_89','249_90','249_91'}},
[SUB_ACTIVITY_TYPE.eDongTianFuDi]={'activitiesHandle_dongtianfudi',{'249_74','249_75','249_76','249_77'}},
[SUB_ACTIVITY_TYPE.eTianMingZengLi]={'activitiesHandle_tianmingzengli',{'249_35'}},
[SUB_ACTIVITY_TYPE.eXianJuTeHui]={'activitiesHandle_xianjutehui',{'249_92','249_93','249_94'}},
[SUB_ACTIVITY_TYPE.eFuXingGaoZhao]={'activitiesHandle_fuxinggaozhao',{'249_56','249_57','249_58','249_59'}},
[SUB_ACTIVITY_TYPE.eLianGouHaoLi]={'activitiesHandle_liangouhaoli',{'249_60'}},
[SUB_ACTIVITY_TYPE.eTongBaoXianShi]={'activitiesHandle_tongbaoxianshi',{'249_102'}},
[SUB_ACTIVITY_TYPE.eCloudCityTreasure]={'activitiesHandle_yunchengtanbao',{'249_95','249_96','249_97','249_98','249_99','249_100','249_101','249_205'},true},
[SUB_ACTIVITY_TYPE.eHangDaoTeQuan]={'activitiesHandle_tanxianduitequan',{'249_113'}},
[SUB_ACTIVITY_TYPE.eTanXianLiBao]={'activitiesHandle_tanxianduitanbao',{'249_108'}},
[SUB_ACTIVITY_TYPE.eDailyLiBao]={'activitiesHandle_dailylibao',{'249_114'}},
[SUB_ACTIVITY_TYPE.eTargetTask2]={'activitiesHandle_targetActivity2',{'249_109','249_110','249_111','249_112'}},
[SUB_ACTIVITY_TYPE.eTianTiShiLian]={'activitiesHandle_tiantishilian',{'249_115'}},
[SUB_ACTIVITY_TYPE.eTianDaoMiJi]={'activitiesHandle_gongfagain',{'249_116'}},
[SUB_ACTIVITY_TYPE.eWanBaoJianShang]={'activitiesHandle_wanbaojianshangAct',{'249_117'}},
[SUB_ACTIVITY_TYPE.eDressLottery]={'activitiesHandle_shizhuangchoujian',{'249_121','249_126'},true},
[SUB_ACTIVITY_TYPE.ePaintedPuzzle]={'activitiesHandle_huiyingpintu',{'249_118','249_119','249_120','249_122','249_123','249_124','249_125'},true},
[SUB_ACTIVITY_TYPE.eInvestAct2]={'activitiesHandle_InvestAct2',{'249_141','249_145'}},
[SUB_ACTIVITY_TYPE.eTianMoRuQin]={'activitiesHandle_tianmoruqin',{'249_130','249_131','249_132','249_133','249_134','249_135','249_136','249_137','249_138','249_139','249_140'},true},
[SUB_ACTIVITY_TYPE.eRankAct1]={'activitiesHandle_RankAct1',{'249_142'}},
[SUB_ACTIVITY_TYPE.eTianMoBaoXia]={'activitiesHandle_doubleLottery',{'249_143','249_144'}},
[SUB_ACTIVITY_TYPE.eQingDianQianDao]={'activitiesHandle_qingdianqiandao',{'249_148'}},
[SUB_ACTIVITY_TYPE.eTaiGuShiLian]={'activitiesHandle_taiguBoss',{'249_151','249_152','249_153'}},
[SUB_ACTIVITY_TYPE.eFaBaoMiLu]={'activitiesHandle_fabaomilu',{'249_161'}},
[SUB_ACTIVITY_TYPE.eFaBaoShiLian]={'activitiesHandle_fabaoshilian',{'249_162','249_163'}},
[SUB_ACTIVITY_TYPE.eShiLianMuBiao]={'activitiesHandle_shilianTarget',{'249_168','249_169','249_170'}},
[SUB_ACTIVITY_TYPE.eTargetTask4]={'activitiesHandle_targetActivity4',{'249_171','249_172'}},
[SUB_ACTIVITY_TYPE.egongCheQianDao]={'activitiesHandle_gongceqiandao',{'249_174'}},
[SUB_ACTIVITY_TYPE.eJieRiQianDao]={'activitiesHandle_festivalSignIn',{'249_173'}},
[SUB_ACTIVITY_TYPE.eXianMengTeQuan]={'activitiesHandle_xianmengtequan',{'249_164','249_165',}},
[SUB_ACTIVITY_TYPE.eDaBiaoZengLi]={'activitiesHandle_dabiaozengli',{'249_146','249_147',}},
[SUB_ACTIVITY_TYPE.eRechargeAct1]={'activitiesHandle_totalRecharge',{'249_150','249_212'}},
[SUB_ACTIVITY_TYPE.eXianJieQiYuan]={'activitiesHandle_xianjieqiyuan',{'249_175','249_176','249_177','249_178','249_179','249_180'}},
[SUB_ACTIVITY_TYPE.eFuYaoShiLian]={'activitiesHandle_fuyaoBoss',{'249_181','249_182','249_183'}},
[SUB_ACTIVITY_TYPE.eXianShiChouKa_Role]={'activitiesHandle_xianshichouka_Role',{'249_185','249_186','249_187','249_188',}},
[SUB_ACTIVITY_TYPE.eGuiTuQianDao]={'activitiesHandle_zaixuxianyan_qiandao',{'249_189'}},
[SUB_ACTIVITY_TYPE.eLongHuMountain]={'activitiesHandle_longhudaodan',{'249_191','249_192','249_193','249_202','249_204'}},
[SUB_ACTIVITY_TYPE.eGuiTuTeQuan]={'activitiesHandle_guitutequan',{'249_190'}},
[SUB_ACTIVITY_TYPE.eLongHuXiangYao]={'activitiesHandle_longhuxiangyao',{'249_195','249_196'}},
[SUB_ACTIVITY_TYPE.eGuiTuXiuXing]={'activitiesHandle_guituxiuxing',{'249_127','249_128','249_129','249_149'}},
[SUB_ACTIVITY_TYPE.eLongHuHuiJuan]={'activitiesHandle_longhuhuijuan',{'249_197','249_198','249_199','249_200','249_201',}},
[SUB_ACTIVITY_TYPE.eGuiTuZhiYin]={'activitiesHandle_guituzhiyin',{'249_194'}},
[SUB_ACTIVITY_TYPE.eDingZhiDaZao]={'activitiesHandle_dingzhidazao',{'249_207'}},
[SUB_ACTIVITY_TYPE.eYuFuMuBiao]={'activitiesHandle_yufutarget',{'249_208','249_209','249_211'}},
[SUB_ACTIVITY_TYPE.eHuiHuaDianJi]={'activitiesHandle_drawdianji',{'249_210'}},
[SUB_ACTIVITY_TYPE.eXianTuZhuli]={'activitiesHandle_xiantuzhuli',{'249_216','249_217','249_218','249_219',}},
[SUB_ACTIVITY_TYPE.eNiuDanJi]={'activitiesHandle_niudanji',{'249_220','249_221','249_222','249_223'}},
[SUB_ACTIVITY_TYPE.eChiSeJinDi]={'activitiesHandle_chisejindi',{'249_230','249_231','249_232','249_233','249_234','249_235','249_236','249_237','249_238','249_239','249_240','249_241'}},
[SUB_ACTIVITY_TYPE.eSectPractice]={'activitiesHandle_zongmengxiuxing',{'249_245','249_246','249_247','249_248'}},
[SUB_ACTIVITY_TYPE.eZhenYaoShiLian]={'activitiesHandle_zhenyaoshilian',{'249_242','249_243'}},
[SUB_ACTIVITY_TYPE.eDuiHuanShangDian2]={'activitiesHandle_exchangeshop',{'247_1','247_2'}},
[SUB_ACTIVITY_TYPE.eRankActCross]={'activitiesHandle_crossranking',{'247_3','247_97','247_60'}},
[SUB_ACTIVITY_TYPE.eLingZhenHuiHua]={'activitiesHandle_lingzhendiaoke',{'249_249','249_250','249_251','249_252','249_253'}},
[SUB_ACTIVITY_TYPE.eLingZhenHuiHua2]={'activitiesHandle_rolelingzhendiaoke',{'249_224','249_225','249_226'}},
[SUB_ACTIVITY_TYPE.ebuyact9]={'activitiesHandle_shizhuangzhigou',{'249_254',}},
[SUB_ACTIVITY_TYPE.eTianMoBaoXia2]={'activitiesHandle_roledoubleLottery',{'247_4','247_5'}},
[SUB_ACTIVITY_TYPE.eDuiHuanHuoDong2]={'activitiesHandle_duihuanhuodongActor',{'247_6','247_7'}},
[SUB_ACTIVITY_TYPE.eLanternriddles]={'activitiesHandle_zhongqiudengmi',{'247_8','247_9'}},
[SUB_ACTIVITY_TYPE.eLotteryact7]={'activitiesHandle_chaoslingchi',{'247_10','247_11','247_12','247_13','247_14','247_15'}},
[SUB_ACTIVITY_TYPE.eXianXuanBaoXia]={'activitiesHandle_xianxuanbaoxia',{'247_16',}},
[SUB_ACTIVITY_TYPE.eXiShiZhenBao]={'activitiesHandle_xishizhenbao',{'247_17','247_18',}},
[SUB_ACTIVITY_TYPE.eLotteryact8]={'activitiesHandle_gujixunxian',{'247_19','247_20','247_21','247_22','247_23'}},
[SUB_ACTIVITY_TYPE.eLotteryact9]={'activitiesHandle_yunhaidiaobao',{'247_24'}},
[SUB_ACTIVITY_TYPE.eFeiJianDuoBao]={'activitiesHandle_feijianduobao',{'247_25','247_26','247_27','247_28'}},
[SUB_ACTIVITY_TYPE.eCaiShenJiaDao]={'activitiesHandle_caishenjiadao',{'247_29','247_30','247_31','247_32'}},
[SUB_ACTIVITY_TYPE.eTargetActivity5]={'activitiesHandle_targetActivity5',{'247_33','247_34'}},
[SUB_ACTIVITY_TYPE.eZhouNianQingQianDao]={'activitiesHandle_anniversarysignin',{'247_35'}},
[SUB_ACTIVITY_TYPE.eXianJieQiYuan2]={'activitiesHandle_xianjieqiyuan2',{'247_36','247_37','247_38','247_39','247_40','247_41','247_59'}},
[SUB_ACTIVITY_TYPE.eExchangeAct3config]={'activitiesHandle_anniversaryduihuan',{'247_42','247_43','247_44','247_45','247_46','247_47'}},
[SUB_ACTIVITY_TYPE.eGuBaoShiLian]={"activitiesHandle_gubaoshilian",{"247_53","247_54"}},
[SUB_ACTIVITY_TYPE.ePictureDisciple]={"activitiesHandle_tujiandizi",{"247_55","247_56"}},
[SUB_ACTIVITY_TYPE.ePictureSpeciality]={"activitiesHandle_tujiantezhi",{"247_57","247_58"}},
[SUB_ACTIVITY_TYPE.eLunHuiZhuanPan]={'activitiesHandle_lunhuizhuanpan',{'247_49','247_50','247_51','247_52'}},
[SUB_ACTIVITY_TYPE.eXingJiaoShangRen]={'activitiesHandle_xingjiaoshangren',{'247_61','247_62'}},
[SUB_ACTIVITY_TYPE.eLianQiDaHui]={'activitiesHandle_lianqidahui',{'247_63','247_64','247_65','247_66'}},
[SUB_ACTIVITY_TYPE.eFangYingTing]={'activitiesHandle_fangyingting',{'247_67'}},
[SUB_ACTIVITY_TYPE.eZhongLiXieXin]={'activitiesHandle_zhonglixiexin',{'247_70','247_71','247_72','247_73','247_74'}},
[SUB_ACTIVITY_TYPE.eTianMingJinJie]={'activitiesHandle_tainmingjinjie',{'247_75','247_76'}},
[SUB_ACTIVITY_TYPE.eShiGuangPinTu]={'activitiesHandle_shiguangpintu',{'247_81','247_82','247_83','247_84','247_85','247_86'}},
[SUB_ACTIVITY_TYPE.eWuXingBuTian]={'activitiesHandle_wuxingbutian',{'247_92','247_93','247_94','247_110'}},
[SUB_ACTIVITY_TYPE.eWanZongDuiJue]={'activitiesHandle_wanzongduijue',{'247_77','247_78','247_79','247_80','247_91'}},
[SUB_ACTIVITY_TYPE.eTargetTask6]={'activitiesHandle_zixuantouzi',{'247_87','247_88','247_89'}},
[SUB_ACTIVITY_TYPE.eLotteryact13]={'activitiesHandle_xingyunzhuanpan',{'247_90'},true},
[SUB_ACTIVITY_TYPE.eChaoZhiTeHui]={'activitiesHandle_chaozhitehui',{"247_96"},},
[SUB_ACTIVITY_TYPE.eTargetTask7]={'activitiesHandle_targetActivity7',{'247_98','247_99'}},
[SUB_ACTIVITY_TYPE.eRechargeAct1Role]={'activitiesHandle_totalRechargeRole',{'249_213','249_214'}},
[SUB_ACTIVITY_TYPE.eLianGouHaoLiRole]={'activitiesHandle_liangouhaoliRole',{'249_159'}},
[SUB_ACTIVITY_TYPE.eShenHaiXunBao]={'activitiesHandle_shenhaixunbao',{'247_100','247_101','247_102','247_103','247_104','247_109'}},
[SUB_ACTIVITY_TYPE.eZuShiShouJi]={'activitiesHandle_zushishouji',{'247_105','247_106','247_107'}},
[SUB_ACTIVITY_TYPE.eHuiYingCangXi]={'activitiesHandle_huiyingcangxi',{'247_108'}},
[SUB_ACTIVITY_TYPE.eTianXuYiShi]={'activitiesHandle_tianxuyishi',{'247_111','247_112'}},
[SUB_ACTIVITY_TYPE.eHunYuanDanHui]={'activitiesHandle_hunyuandanhui',{'247_113','247_114','247_115','247_122','247_127','247_128'}},
[SUB_ACTIVITY_TYPE.eLingShuCiFu]={'activitiesHandle_lingshucifu',{'247_120','247_121'}},
[SUB_ACTIVITY_TYPE.eXianMengHongBao]={'activitiesHandle_xianmenghongbao',{'247_123','247_124','247_125','247_126'}},
}


local recvSubActTypeLookup
local actRecvTypeLookup
local actLifeTypeLookup

function activitiesController:initRecvSubActTypeLookup()
local lookup2={}
for i,v in ipairs(actRecvTypeConfig)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
if v[3]==nil then
v[3]=FMT.fmt('recv_{0}',key)
end
lookup2[key]=v
end
actRecvTypeLookup=lookup2
local lookup={}
local lookup3={}
for subActType,v in pairs(subActRecvHandleConfig)do
if v[2]~=nil then
for i,recvType in ipairs(v[2])do
if lookup[recvType]==nil then
lookup[recvType]={}
end
table.insert(lookup[recvType],subActType)
end
end



lookup3[#lookup3+1]=v[1]

end
recvSubActTypeLookup=lookup
actLifeTypeLookup=lookup3
end

function activitiesController:handle_onEnterState()
for subActType,handleName in pairs(actLifeTypeLookup)do
local handle=get_activitiesHandle(handleName)
if handle~=nil and handle.onEnterState then
handle:onEnterState()
end
end
end

function activitiesController:handle_onLeaveState()
for subActType,handleName in pairs(actLifeTypeLookup)do
local handle=get_activitiesHandle(handleName)
if handle~=nil and handle.onLeaveState then
handle:onLeaveState()
end
end
end

function activitiesController:getHandleName(subActType)
return subActRecvHandleConfig[subActType][1]
end

function activitiesController:register_receiver()
activitiesController:initRecvSubActTypeLookup()
for recvType,v in pairs(actRecvTypeLookup)do
local handleFunctionName=v[3]
local preFunc=v[4]
local func=function(...)

if preFunc then
preFunc(...)
end
local lp=recvSubActTypeLookup[recvType]
if lp then
for i,subActType in ipairs(lp)do
local handleName=subActRecvHandleConfig[subActType][1]
local handle=get_activitiesHandle(handleName)
if handle~=nil then
local handlefunc=handle[handleFunctionName]
if handlefunc~=nil then
handlefunc(...)
else



end
else



end
end
else
if preFunc==nil then



end
end
end
socketManager:register_receiver(v[1],v[2],func)
end
end
