









local _MODULENAME="tabScreenConfig"
def_table(_MODULENAME)

tabScreenConfig.name=_MODULENAME
local _tabCfg
local tabConfig=
{


[SEC_FULL_TAB_TYPE.discipleNote]=
{
views={"UIDiscipleInfoComponent","UIDiscipleNoteComponent","UIDiscipleListComponent"},
},

[SEC_FULL_TAB_TYPE.discipleBag]=
{
views={"UIDiscipleInfoComponent","UIDiscipleBagComponent","UIDiscipleListComponent"},
},

[SEC_FULL_TAB_TYPE.discipleRelationship]=
{
views={'UIDiscipleRelationWin','UIDiscipleListComponent'},
},

[SEC_FULL_TAB_TYPE.discipleCouple]=
{
views={'UIDiscipleCoupleWin'},
checkOpen=function(winArgs)
return systemModel.isOpen(SYSTEM_DEFINE.eDiscipleCouple)
end,
},

[SEC_FULL_TAB_TYPE.dzMount]=
{
views={'UIDZMountWin','UIDiscipleListComponent'},
},

[SEC_FULL_TAB_TYPE.discipleClothing]={
views={'UIDiscipleShiZhuangComponent','UIDiscipleListComponent'},
checkOpen=function(winArgs)
return true
end,
},


[SEC_FULL_TAB_TYPE.discipleSpeak]={
views={'UIDZSpeakWin','UIDiscipleListComponent'},
checkOpen=function(winArgs)

return roleAudioController:checkRoleSpeak(winArgs)
end,
},

[SEC_FULL_TAB_TYPE.discipleBackStory]={
views={"UIDiscipleListConditionComponent","UIDiscipleInfo2Component","UIDiscipleLifeHistoryComponent"},
checkOpen=function(winArgs)
local state=true



local guid=winArgs.guid
local diziid=UIDiscipleModel:getDiscipleID(guid)
local config=cfg_disciplespebackstoryconfig()
if config[diziid]==nil then
state=false
end

return state
end,
},



[SEC_FULL_TAB_TYPE.gubaolianhua]=
{
views={'UIGuBaoLianHuaWin'},
checkOpen=function(winArgs)
local gbid=winArgs.gbid
local isActive=gubaoModel:checkActive(gbid)
if isActive then
local fulllianhua=gubaoModel:checkFullLianHuaEx(gbid)
if not fulllianhua then
return true
end
end
return false
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local gbid=winArgs.gbid
return gubaoLianHuaSheetReddot:getSubReddotKey(gbid)
end,
},

[SEC_FULL_TAB_TYPE.gubaoupstar]=
{
views={'UIGuBaoUpStarWin'},
checkOpen=function(winArgs)
local gbid=winArgs.gbid
local isActive=gubaoModel:checkActive(gbid)
if isActive then
local fullupstar=gubaoModel:checkFullUpStar(gbid)
if not fullupstar then
return true
end
end
return false
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local gbid=winArgs.gbid
return gubaoUpStarSheetReddot:getSubReddotKey(gbid)
end,
},

[SEC_FULL_TAB_TYPE.gubaoawake]=
{
views={'UIGuBaoUpStarWin'},
checkOpen=function(winArgs)
local gbid=winArgs.gbid
local isActive=gubaoModel:checkActive(gbid)
if isActive then
if gubaoModel:checkOpenAwake(gbid)and gubaoModel:checkFullUpStar(gbid)and not gubaoModel:checkAwake(gbid)then
return true
end
end
return false
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local gbid=winArgs.gbid
return gubaoAwakeSheetReddot:getSubReddotKey(gbid)
end,
},



[SEC_FULL_TAB_TYPE.fuluFuBao]=
{
views={'UIYuFuSelectMakeWin'},
reddotSubType=REDDIT_SUB_TYPE.sYuFuMake,
},

[SEC_FULL_TAB_TYPE.fuluXianFu]=
{
views={'UIFuLuSelectMakeWin'},
},



[SEC_FULL_TAB_TYPE.yuZhongTuJian]=
{
views={'UIAquariumHandbookWin'},
reddotSubType=REDDIT_SUB_TYPE.sYLCHandBook,
},

[SEC_FULL_TAB_TYPE.yuZhongZongLan]=
{
views={'UIAquariumUnlockWin'},
reddotSubType=REDDIT_SUB_TYPE.sYLCSuit,
},



[SEC_FULL_TAB_TYPE.xfwdRank]=
{
views={'UIXFWDRankingWin'},

},

[SEC_FULL_TAB_TYPE.xfwdReward]=
{
views={'UIXFWDRewardWin'},

},




[SEC_FULL_TAB_TYPE.fabaoBenMingInfo]=
{
views={'UIFabaoBenMingInfoWin','UIFaBaoDiscipleMainWin'},
checkOpen=function(winArgs)
if winArgs==nil then return false end
local itemguid=winArgs.itemguid
if itemguid==nil then return false end
local equip=fabaoHelper.getFabao(itemguid)
return fabaoConfig.isBenMingFabao(equip.itemid)
end,
showTips=function(attach)
end,
},


[SEC_FULL_TAB_TYPE.fabaoBenYunYang]=
{
views={'UIFabaoYunYangWin','UIFaBaoDiscipleMainWin'},
checkOpen=function(winArgs)
if winArgs==nil then return false end
local itemguid=winArgs.itemguid
if itemguid==nil then return false end
local equip=fabaoHelper.getFabao(itemguid)
return fabaoConfig.isBenMingFabao(equip.itemid)
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
return benMingFaBaoSheetReddot.getItemKey(winArgs.itemguid)
end,
showTips=function(attach)
end,
},

[SEC_FULL_TAB_TYPE.fabaojilian]=
{
views={'UIFabaoJilianWin','UIFaBaoDiscipleMainWin'},
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local itemguid=winArgs.itemguid
local sub_type=discipleFabaoSheetReddot.sub_type.eJiLian
return discipleFabaoSheetReddot:getSubTypeReddotId(sub_type,itemguid)
end,
},

[SEC_FULL_TAB_TYPE.fabaolianhua]=
{
views={'UIFabaoLianhuaWin','UIFaBaoDiscipleMainWin'},
},


[SEC_FULL_TAB_TYPE.eEquipJingLian]=
{
views={'UIEquipJinglianWin'},
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local itemguid=winArgs.itemguid
local sub_type=discipleEquipSheetReddot.sub_type.eJingLian
return discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)
end,
},

[SEC_FULL_TAB_TYPE.eEquipChongZhu]=
{
views={'UIEquipChongZhuWin'},
checkOpen=function(winArgs)
return equipsHelper.isCanShowChongZhu(winArgs.itemguid,false)
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local itemguid=winArgs.itemguid
local sub_type=discipleEquipSheetReddot.sub_type.eChongZhu
return discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)
end,
},

[SEC_FULL_TAB_TYPE.eEquipNingLian]=
{
views={'UIEquipNingLianWin'},
checkOpen=function(winArgs)
return equipsHelper.isCanShowNingLian(winArgs.itemguid,false)
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local itemguid=winArgs.itemguid
local sub_type=discipleEquipSheetReddot.sub_type.eNingLian
return discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)
end,
showTips=function(attach)
end,
},

[SEC_FULL_TAB_TYPE.eEquipRonghe]=
{
views={'UIEquipRongHeWin'},
checkOpen=function(winArgs)
return equipsHelper.isCanShowRongHe(winArgs.itemguid,false)
end,
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)


return false
end,
showTips=function(attach)
end,
},



[SEC_FULL_TAB_TYPE.blsrewards]=
{
views={'UIBaoLingDetailsRewardWin'},
},

[SEC_FULL_TAB_TYPE.blsdetails]=
{
views={'UIBaoLingDetailsWin'},
},


[SEC_FULL_TAB_TYPE.dailyPaperShangpu]=
{
views={'UIZongmenEarningsWin','UIZongmenResChangeWin'},
},

[SEC_FULL_TAB_TYPE.dailyPaperJiazu]=
{
views={'UIZongmenEarningsWin','UIZongmenResChangeWin'},
},

[SEC_FULL_TAB_TYPE.dailyPaperPostWage]=
{
views={'UIZongmenEarnings2Win','UIZongmenResChangeWin'},
},



[SEC_FULL_TAB_TYPE.shopCount]=
{
views={'UIZongmenEarningsWin','UIZongmenResChangeWin'},
},


[SEC_FULL_TAB_TYPE.lotteryDetail]=
{
views={'UI_activity_lotteryDetail'},
},

[SEC_FULL_TAB_TYPE.lotteryPercent]=
{
views={'UI_activity_lotteryPercent'},
checkOpen=function(winArgs)
local subType=winArgs.subType
local subId=winArgs.subId
if not(subType and subId)then
return false
end
local config=activitiesModel:getSubActivityConfig(subType,subId)or{}
return config.reward_percent~=nil
end,
},

[SEC_FULL_TAB_TYPE.lotteryRule]=
{
views={'UI_activity_lotteryRule'},
},


[SEC_FULL_TAB_TYPE.lotteryDetail_noActivity]=
{
views={'UI_win_lotteryDetail'},
},

[SEC_FULL_TAB_TYPE.lotteryPercent_noActivity]=
{
views={'UI_win_lotteryPercent'},
checkOpen=function(winArgs)
local configstr=winArgs.configstr
local config={}
if configstr then
local configidx=winArgs.configidx or 1
if'UIMoJie_SYMZMainWin'==configstr then
config=cfg_devildomshenyuanmizangconfig_get(configidx)
if not config then
config=cfg_devildomshenyuanmizangconfig_get(1)
end
end
end
return config.reward_percent~=nil
end,
},

[SEC_FULL_TAB_TYPE.lotteryRule_noActivity]=
{
views={'UI_win_lotteryRule'},
},

[SEC_FULL_TAB_TYPE.head]=
{
reddotSubType=REDDIT_SUB_TYPE.sHead,
views={'UIHeadSelectWin'},
},
[SEC_FULL_TAB_TYPE.headkuang]=
{
reddotSubType=REDDIT_SUB_TYPE.sHeadKuang,
views={'UIHeadSelectWin'},
},
[SEC_FULL_TAB_TYPE.chatkuang]=
{
reddotSubType=REDDIT_SUB_TYPE.sChatKuang,
views={'UIChatKuangSettingWin'},
},

[SEC_FULL_TAB_TYPE.eWorldLeaderRankReward]=
{
views={'UIWorldBigBossActivityRewardWin'},
},
[SEC_FULL_TAB_TYPE.eWorldLeaderChallengeReward]=
{
views={'UIWorldBigBossActivityDropWin'},
},

[SEC_FULL_TAB_TYPE.cangbaotuMyCard]=
{
views={'UISubAct_CangBaoTuCollectWin'},
},
[SEC_FULL_TAB_TYPE.cangbaotuMyRecord]=
{
views={'UISubAct_CangBaoTuRecordWin'},
reddotSubType=nil,
reddotSubTypeFunc=function(winArgs)
local actId=winArgs.activityId
local subId=winArgs.subId
return cangbaotuSheetReddot.getSubActivityKey(actId,subId)
end,
},

[SEC_FULL_TAB_TYPE.eZhengZhanShanHaiMonsterLog]=
{
views={'UIXM_ZZSH_noteMonsterWin'},
reddotSubType=REDDIT_SUB_TYPE.szzshMonsterLog,
},
[SEC_FULL_TAB_TYPE.eZhengZhanShanHaiResourceLog]=
{
views={'UIXM_ZZSH_noteResourceWin'},
reddotSubType=REDDIT_SUB_TYPE.szzshResourceLog,
},
[SEC_FULL_TAB_TYPE.eZhengZhanShanHaiFightLog]=
{
views={'UIXM_ZZSH_noteFightWin'},

},
[SEC_FULL_TAB_TYPE.eZhengZhanShanHaiLingShanLog]=
{
views={'UILingShanNoteWin'},
reddotSubType=REDDIT_SUB_TYPE.szzshLingShanLog,
checkOpen=function(winArgs)
local check=UILSZDControl:isLingShanOpen(true)
return check
end,
showTips=function(attach)
end,
},

[SEC_FULL_TAB_TYPE.eXianJieMonsterLog]=
{
views={'UIXianJie_noteMonsterWin'},
reddotSubType=REDDIT_SUB_TYPE.sXianJieMonsterLog,
},
[SEC_FULL_TAB_TYPE.eXianJieResourceLog]=
{
views={'UIXianJie_noteResourceWin'},
reddotSubType=REDDIT_SUB_TYPE.sXianJieResourceLog,
},
[SEC_FULL_TAB_TYPE.eXianJieFightLog]=
{


views={'UIXianJie_noteArenaWin'},
reddotSubType=REDDIT_SUB_TYPE.sXianJieArenaLog,
},
[SEC_FULL_TAB_TYPE.eMoGongZhengDuoLog]=
{
views={'UIMoGongZhengDuoAct_noteWin'},
reddotSubType=REDDIT_SUB_TYPE.sXianJieMoGongZhengDuoLog,
checkOpen=function(winArgs)
if pfwindowslController:getGameVersion()==pfwindowslController.sdkPFVersion.game_fanti_GA then
return false
end
return true
end,
},

[SEC_FULL_TAB_TYPE.eXianJieMXSLSingleLog]=
{
views={'UIXianJie_noteMXSLSingleWin'},
reddotSubType=REDDIT_SUB_TYPE.sXianJieMXSLSingleLog,
},


[SEC_FULL_TAB_TYPE.tanbaogeLotteryDetail]=
{
views={'UISubAct_tanbaoge_detailWin'},
},

[SEC_FULL_TAB_TYPE.tanbaogeLotteryPercent]=
{
views={'UISubAct_tanbaoge_percentWin'},
},

[SEC_FULL_TAB_TYPE.tanbaogeLotteryRule]=
{
views={'UI_activity_lotteryRule'},
},


[SEC_FULL_TAB_TYPE.wdcqMC]=
{
views={'UIWDCQSecondMCWin'},
},

[SEC_FULL_TAB_TYPE.wdcqQF]=
{
views={'UIWDCQSecondQFWin'},
},

[SEC_FULL_TAB_TYPE.wdcqJC]=
{
views={'UIWDCQSecondJCWin'},
},


[SEC_FULL_TAB_TYPE.hdlcGRJL]=
{
views={'UISubAct_ChaosLingChiRecordWin'},
checkOpen=function(winArgs)
local subType=winArgs.subType
local subId=winArgs.subId
if not(subType and subId)then
return false
end
local config=activitiesModel:getSubActivityConfig(subType,subId)or{}
return config.self_record_cnt>0
end,
},

[SEC_FULL_TAB_TYPE.hdlcQFJL]=
{
views={'UISubAct_ChaosLingChiRecord2Win'},
checkOpen=function(winArgs)
local subType=winArgs.subType
local subId=winArgs.subId
if not(subType and subId)then
return false
end
local config=activitiesModel:getSubActivityConfig(subType,subId)or{}
return config.record_cnt>0
end,
},

[SEC_FULL_TAB_TYPE.eYunZhouFlagWarehouse]=
{
views={'UIYunZhouWarehouseWin'},
},

[SEC_FULL_TAB_TYPE.eYunZhouComponentsWarehouse]=
{
views={'UIYunZhouWarehouseWin'},
},

[SEC_FULL_TAB_TYPE.eYunZhouComponentsStrengthen]=
{
views={'UIYunZhouComponentsStrengthenWin'},
},

[SEC_FULL_TAB_TYPE.eYunZhouComponentsCompose]=
{
views={'UIYunZhouComponentsComposeWin'},
},

[SEC_FULL_TAB_TYPE.eXJFMreward_GeRen]=
{
views={'UIXJFMReward_GeRenWin'},
},

[SEC_FULL_TAB_TYPE.eXJFMreward_XianMeng]=
{
views={'UIXJFMReward_XianMengWin'},
},

[SEC_FULL_TAB_TYPE.eXJFMreward_Challenge]=
{
views={'UIXJFMReward_ChallengeWin'},
},

[SEC_FULL_TAB_TYPE.eXJFMreward_Target]=
{
views={'UIXJFMReward_TargetWin'},
reddotSubType=REDDIT_SUB_TYPE.sXJFMreward_Target,
},

[SEC_FULL_TAB_TYPE.eSetting_ZongMen]=
{
reddotSubType=REDDIT_SUB_TYPE.sSettingZongMen,
views={'UISettingZongMenSelectWin'},
},

[SEC_FULL_TAB_TYPE.eSetting_FeiJian]=
{
reddotSubType=REDDIT_SUB_TYPE.sSettingFeiJian,
views={'UISettingFeiJianSelectWin'},
},

[SEC_FULL_TAB_TYPE.eSetting_YunZhou]=
{
reddotSubType=REDDIT_SUB_TYPE.sSettingYunZhou,
views={'UISettingYunZhouSelectWin'},
},

[SEC_FULL_TAB_TYPE.eXYReward_Reward]=
{
views={'UIXYRewardSubWin_Reward'},
},

[SEC_FULL_TAB_TYPE.eXYReward_TanSuo]=
{
views={'UIXYRewardSubWin_TanSuo'},
},

[SEC_FULL_TAB_TYPE.eXYReward_DuiZhan]=
{
views={'UIXYRewardSubWin_DuiZhan'},
},

[SEC_FULL_TAB_TYPE.eXYTanSuoJiShi_ZuShi]=
{
views={'UIXYJiShiSubWin_ZuShi'},
},

[SEC_FULL_TAB_TYPE.eXYTanSuoJiShi_XingYu]=
{
views={'UIXYJiShiSubWin_XingYu'},
},

[SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round1]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,1)
end,
views={'UIXYZDZhanRoundWin'},
},

[SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round2]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,2)
end,
views={'UIXYZDZhanRoundWin'},
},

[SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round3]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,3)
end,
views={'UIXYZDZhanRoundWin'},
},

[SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round4]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,4)
end,
views={'UIXYZDZhanRoundWin'},
},

[SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round5]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,5)
end,
views={'UIXYZDZhanRoundWin'},
},

[SEC_FULL_TAB_TYPE.eVocEquipStrengthen]=
{
views={'UIVocEquipStrengthenWin'},
},

[SEC_FULL_TAB_TYPE.lotteryDetail_lunhuizhuanpan]=
{
views={'UI_activity_lotteryDetail_lunhuizhuanpan'},
},

[SEC_FULL_TAB_TYPE.lotteryRule_lunhuizhuanpan]=
{
views={'UI_activity_lotteryRule'},
},


[SEC_FULL_TAB_TYPE.eXYZDZReward_Round1]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,1)
end,
views={'UIXYZDZRoundRewardWin'},
},

[SEC_FULL_TAB_TYPE.eXYZDZReward_Round2]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,2)
end,
views={'UIXYZDZRoundRewardWin'},
},

[SEC_FULL_TAB_TYPE.eXYZDZReward_Round3]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,3)
end,
views={'UIXYZDZRoundRewardWin'},
},

[SEC_FULL_TAB_TYPE.eXYZDZReward_Round4]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,4)
end,
views={'UIXYZDZRoundRewardWin'},
},

[SEC_FULL_TAB_TYPE.eXYZDZReward_Round5]=
{
checkOpen=function(winArgs)
local xyId=winArgs.xyId
return XingYuController.checkXingYuHasZDRound(xyId,5)
end,
views={'UIXYZDZRoundRewardWin'},
},






[SEC_FULL_TAB_TYPE.eJYZF_Rule]=
{
views={'UIJYZF_RuleWin_New'},
},

[SEC_FULL_TAB_TYPE.eJYZF_Record]=
{
views={'UIJYZF_RecordWin'},
},

[SEC_FULL_TAB_TYPE.eJYZF_MoJie]=
{
checkOpen=function(winArgs)
return xianjieModel:checkCurrentMoJieEnterTime()
end,
views={'UIJYZF_RuleWin_MoJie'},
},

[SEC_FULL_TAB_TYPE.eMYZS_DisicpleState]=
{
views={'UIMingYuanZhuSha_DiscipleTeamStateWin'},
},

[SEC_FULL_TAB_TYPE.eMYZS_BWDetail]=
{
views={'UIMingYuanZhuSha_BaoWuDetailWin'},
},
}

function tabScreenConfig:getTabScreenConfig(tabType)
return tabConfig[tabType]
end


function tabScreenConfig:getTabConfig(tabType)
if _tabCfg==nil then
_tabCfg={}
for _,v in pairs(cfg_secfulltabconfig())do
_tabCfg[v.cfgid]=v
end
end
return _tabCfg[tabType]
end

function tabScreenConfig.getTabMoneyByConfig(tabType)
local tabconfig=tabScreenConfig:getTabConfig(tabType)
return tabconfig.money
end

function tabScreenConfig.isTabActive(tabType,luaCfg,attach,warn)
local fulltabconfig=tabScreenConfig:getTabConfig(tabType)
local rule=fulltabconfig.localshowrule
if rule~=1 then
local ret,args=fullScreenModel.checkCND(fulltabconfig.cnd)
if not ret then
if warn then
tabScreenConfig.showTabWarning(tabType)
end
return ret,args
end
if luaCfg.checkOpen then
local ret=luaCfg.checkOpen(attach)
if warn then
if luaCfg.showTips then
luaCfg.showTips(attach)
else
loggerUtil.logErrFMT('二级页签{0}设置了checkOpen。但没有配置对应的解锁提示!!!',tabType)
end
end
return ret
end
return true
end
return true
end

function tabScreenConfig.showTabWarning(tabType)
local fulltabconfig=tabScreenConfig:getTabConfig(tabType)
local ret,args=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
local typo=args[1]
local val=args[2]
local val2=args[3]
local limitType=fullScreenModel.LimitType
if typo==limitType.eSystem then
local desc=systemModel.getOpenTips(val)
UIManager.info(desc)
elseif typo==limitType.eLevel then
local sysname=systemConfig.getSystemName(val)
UIManager.info(FMT.fmt('宗门等级达到{0}级开启',val))
elseif typo==_fullTabLimitType.eZheXianLing then
local bookStr=mathHelper.numberToChinese(val)
local str
if val2 and val2>0 then
local chapterStr=mathHelper.numberToChinese(val2)
str=FMT.fmt('完成谪仙令{0}卷{1}章开启',bookStr,chapterStr)
else
str=FMT.fmt('完成谪仙令{0}卷开启',bookStr)
end
UIManager.info(str)
end
return false
end
return true
end
