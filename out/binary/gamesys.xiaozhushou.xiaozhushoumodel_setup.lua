










xzsDataKey={

cszAutoReceive=1,

gygAutoReceive=1,

cjgAutoStudy=1,

hsAutoDailyChallenge=1,

hsAutoCleanupZhenLing=1,
hsBetterCleanupType=2,
hsAutoBuyCleanup=3,
hsAutoBuyCleanupNum=4,
hsBanCleanupType=5,

mhlAutoReceive=1,


dftAutoFight=1,
dftSelectActor=2,
dftItemFight=3,
dftItemFightNum=4,
dftItemFightUseNum=5,
dftItemFightUseTime=6,
dftChongBangRewardAutoReceive=7,


spAutoQiYu=1,
spAutoReceive=2,

sdAutoDayGiftFree=1,

wxtAutoCleanup=1,


ssTop1=1,
ssGetMoney=2,


ylcAutoReceive=1,
ylcAutoActive=2,
ylcAutoSell=3,

xstAutoReceive=1,

phbUpvote=1,


blsAutoUseFree=1,

fsAutoBuy=1,
fsAutoUseGYQ=2,
fsAutoUseLY=3,
fsAutoUseLYnum=4,


yyhyAutoReceive=1,

lyAutoReceive=1,
lyAutoHandIn=1,

wdtAutostart=1,
wdtAutofinish=2,
wdtAutoshijian=3,
wdtAutodizi1=4,
wdtAutodizi2=5,
wdtAutodizi3=6,
wdtAutoAweak=7,

xianzhanAutoReceive1=1,
xianzhanAutoReceive2=2,

xwlAutoReceive=1,
xwlAutoSubmitType=2,
xwlAutoReward=3,
xwlGongXunRewardAutoReceive=4,

xbdAutoReceive=1,
xbdAutoDispatch=2,
xbdResourcesPriority=3,
xbdAutoRestoreCatTili=4,
xbdAutoIdle=5,
xbdTempResourcesPriority=6,
xbdTriggerReceive=7,
xbdTriggerDispatch=8,

mrqdAutoGetAllReward=1,

mrthAutoGetFree=1,
mrthAutoBuyAll=2,

zzshYBDAutoSaveMoney=1,
zzshYBDAutoSaveMoneyNum=2,

xjYBDAutoSaveMoney=1,
xjYBDAutoSaveMoneyNum=2,

tyscAutoYaoShou=1,
tyscAutoShouLing=2,
tyscAutoReceive=3,
tyscYaoShouType=4,
tyscAutoBuyTimesYS=5,
tyscBuyTimesYS=6,
tyscAutoBuyTimesSL=7,
tyscBuyTimesSL=8,

xfwdAutoChallenge=1,
xfwdPriorityChallenge=2,
xfwdAutoBuyTimes=3,
xfwdBuyTimes=4,

tycyAutoChallenge=1,
tycyAutoReceive=2,
tycyAutoBuyTimes=3,
tycyBuyTimes=4,

twxmAutoChallenge=1,
twxmAutoReceive=2,
twxmAutoBuyTimes=3,
twxmBuyTimes=4,

xianbangAutoReceive=1,

taixucangAutoReceive=1,

littleworldAutoReceive=1,

yfltAutoReceive=1,

zmfyAutoReceive=1,

tdmjAutoReceive=1,
xslbAutoReceive=2,
xsqdAutoReceive=3,

xyxfAutoReceive=1,
dtfdAutoReceive=2,
xgyjAutoReceive=3,
}








local xiaoZhuShouSetupConfig={

[XIAOZHUSHU_ENUM.xzs_ChuanSongZhen]={
init=function(self_,setup)
setup[xzsDataKey.cszAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.cszAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.cxz_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_GuanYingGe]={
init=function(self_,setup)
setup[xzsDataKey.gygAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.gygAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.gyg_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
checkOpen=function()
return adController:supportPlayAD()
end,
},

[XIAOZHUSHU_ENUM.xzs_CangJingGe]={
init=function(self_,setup)
setup[xzsDataKey.cjgAutoStudy]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.cjgAutoStudy]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.cjg_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_HouShan]={
init=function(self_,setup)
setup[xzsDataKey.hsAutoDailyChallenge]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.hsAutoDailyChallenge]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.hs_autoDailyChallenge(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_HouShanZhenLing]={
init=function(self_,setup)
setup[xzsDataKey.hsAutoCleanupZhenLing]=1
setup[xzsDataKey.hsBetterCleanupType]=1
setup[xzsDataKey.hsAutoBuyCleanup]=0
setup[xzsDataKey.hsAutoBuyCleanupNum]=3
setup[xzsDataKey.hsBanCleanupType]={}
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.hsAutoCleanupZhenLing]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.hs_autoCleanupZhenLing(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_MaoHuoLang]={
init=function(self_,setup)
setup[xzsDataKey.mhlAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.mhlAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.mhl_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_DouFaTai]={
init=function(self_,setup)
setup[xzsDataKey.dftAutoFight]=1
setup[xzsDataKey.dftChongBangRewardAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.dftAutoFight]==1
end,
func=function(orderID)

douFaTaiController:startAutoFight(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.dftChongBangRewardAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.dft_chongBangRewardAutoReceive(orderID)
end
}
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_ShanPu]={
init=function(self_,setup)
setup[xzsDataKey.spAutoQiYu]=1
setup[xzsDataKey.spAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.spAutoQiYu]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.sp_autoQiYuChallenge(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.spAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.sp_autoReceiveChallenge(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_Gift]={
init=function(self_,setup)
setup[xzsDataKey.sdAutoDayGiftFree]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.sdAutoDayGiftFree]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.sd_autoDayGiftFreeChallenge(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_WuXingTa]={
init=function(self_,setup)
setup[xzsDataKey.wxtAutoCleanup]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.wxtAutoCleanup]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wxt_autoCleanupChallenge(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_ShangShi]={
init=function(self_,setup)
setup[xzsDataKey.ssTop1]=1
setup[xzsDataKey.ssGetMoney]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.ssTop1]==1 or setupData[xzsDataKey.ssGetMoney]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ss_dianzan(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_YueLongChi]={
init=function(self_,setup)
setup[xzsDataKey.ylcAutoReceive]=1
setup[xzsDataKey.ylcAutoActive]=1
setup[xzsDataKey.ylcAutoSell]=0
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.ylcAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ylc_receiveReward(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.ylcAutoActive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ylc_autoActive(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.ylcAutoSell]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ylc_autoSell(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_WuDaoTang]={
init=function(self_,setup)
setup[xzsDataKey.wdtAutostart]=0
setup[xzsDataKey.wdtAutofinish]=1
setup[xzsDataKey.wdtAutoshijian]=1
setup[xzsDataKey.wdtAutoAweak]=1

setup[xzsDataKey.wdtAutodizi1]=0
setup[xzsDataKey.wdtAutodizi2]=0
setup[xzsDataKey.wdtAutodizi3]=0

end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.wdtAutofinish]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wdt_receiveReward(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.wdtAutostart]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wdt_autoWDStart(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.wdtAutoAweak]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wdt_Aweakdizi(orderID)
end,
},

},
refresh=function(self_,setup)

end,
checkToggle=function(orderID,keyId)
local ispass=true
local setupData=xiaoZhuShouModel:getSetupData(orderID)
if xzsDataKey.wdtAutostart==keyId and setupData[xzsDataKey.wdtAutostart]==0 then
local win=UIManager:findActiveWindow("UIXiaoZhuShou_WuDaoTang_SetupWin")
if win then
if not win:ishaveDZlist()then
ispass=false
UIManager:callWindowFunc("UIXiaoZhuShou_WuDaoTang_SetupWin","onDisciplClick")
end
else
if tonumber(setupData[xzsDataKey.wdtAutodizi1])==0 and tonumber(setupData[xzsDataKey.wdtAutodizi2])==0 and tonumber(setupData[xzsDataKey.wdtAutodizi3])==0 then
ispass=false
UIManager:callWindowFunc("UIXiaoZhuShouWin","openSetupWin",orderID)
end
end
end
return ispass
end,
},

[XIAOZHUSHU_ENUM.xzs_PaiHangBang]={
init=function(self_,setup)
setup[xzsDataKey.phbUpvote]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.phbUpvote]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.phb_upvote(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_XuanShangTai]={
init=function(self_,setup)
setup[xzsDataKey.xstAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xstAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xst_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_DayDiscount]={
init=function(self_,setup)
setup[xzsDataKey.mrthAutoGetFree]=1
setup[xzsDataKey.mrthAutoBuyAll]=0
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOpenAutoGetFree=setupData[xzsDataKey.mrthAutoGetFree]==1
return isOpenAutoGetFree
end,
func=function(orderID)
xiaoZhuShouOrderFunc.mrth_autoGetFreeReward(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOpenAutoBuyAll=setupData[xzsDataKey.mrthAutoBuyAll]==1
if isOpenAutoBuyAll then
local checkNum=1
local _,checkVoucherCount=payControl.getVoucherId(checkNum)
if not checkVoucherCount or checkVoucherCount<=0 then

isOpenAutoBuyAll=false
end
end

return isOpenAutoBuyAll
end,
func=function(orderID)
xiaoZhuShouOrderFunc.mrth_autoBuyOneKeyLiBao(orderID)
end,
},
},
refresh=function(self_,setup)

end,
getShowToggleGroup=function(orderId)
local cfg=xiaoZhuShouModel:getXiaoZhuShouConfig(orderId)
local cfgToggleGroup=cfg.toggleGroup or{}
local toggleGroup={}
for _,v in ipairs(cfgToggleGroup)do
local isInsert=true
local keyId=v[1]
if keyId==xzsDataKey.mrthAutoBuyAll then

isInsert=false
local minNum=1
local itemid,voucherCount=payControl.getVoucherId(minNum)
if itemid and voucherCount>0 then
isInsert=true
end
end

if isInsert then
toggleGroup[#toggleGroup+1]=v
end
end
return toggleGroup
end
},

[XIAOZHUSHU_ENUM.xzs_BaoLingShu]={
init=function(self_,setup)
setup[xzsDataKey.blsAutoUseFree]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.blsAutoUseFree]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.bls_autoUseFreeNum(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_DaySignIn]={
init=function(self_,setup)
setup[xzsDataKey.mrqdAutoGetAllReward]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.mrqdAutoGetAllReward]==1
end,
func=function(orderID)

xiaoZhuShouOrderFunc.mrqd_autoSingIn(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_FangShi]={
init=function(self_,setup)
setup[xzsDataKey.fsAutoBuy]=1
setup[xzsDataKey.fsAutoUseGYQ]=1
setup[xzsDataKey.fsAutoUseLY]=1
setup[xzsDataKey.fsAutoUseLYnum]=0
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.fsAutoBuy]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.fs_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_YiYuHuiYou]={
init=function(self_,setup)
setup[xzsDataKey.yyhyAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.yyhyAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.yyhy_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_LaoYu_zy]={
init=function(self_,setup)
setup[xzsDataKey.lyAutoReceive]=1

end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.lyAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ly_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_LaoYu_jy]={
init=function(self_,setup)

setup[xzsDataKey.lyAutoHandIn]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.lyAutoHandIn]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.ly_autoHandIn(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_XianZhan]={
init=function(self_,setup)
setup[xzsDataKey.xianzhanAutoReceive1]=1
setup[xzsDataKey.xianzhanAutoReceive2]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xianzhanAutoReceive1]==1 or setupData[xzsDataKey.xianzhanAutoReceive2]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xianzhan_receiveReward(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_XianWuLou]={
init=function(self_,setup)
setup[xzsDataKey.xwlAutoReceive]=1
setup[xzsDataKey.xwlAutoSubmitType]=2
setup[xzsDataKey.xwlAutoReward]=1
setup[xzsDataKey.xwlGongXunRewardAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xwlAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xwl_receiveReward(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xwlAutoReward]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xwl_receiveReward2(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xwlGongXunRewardAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xwl_receiveGongXunReward(orderID)
end,
}
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_Mmtxd]={
init=function(self_,setup)
setup[xzsDataKey.xbdAutoReceive]=1
setup[xzsDataKey.xbdAutoDispatch]=0
setup[xzsDataKey.xbdAutoIdle]=1

setup[xzsDataKey.xbdResourcesPriority]={eMoneyType.mtLingCao,eMoneyType.mtLingMu,eMoneyType.mtTieKuang}
setup[xzsDataKey.xbdAutoRestoreCatTili]=0
setup[xzsDataKey.xbdTriggerDispatch]=false
setup[xzsDataKey.xbdTriggerReceive]=false
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOn=setupData[xzsDataKey.xbdAutoReceive]==1
setupData[xzsDataKey.xbdTriggerReceive]=false
return isOn
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wbxbd_autoReceiveReward(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOn=setupData[xzsDataKey.xbdAutoDispatch]==1
setupData[xzsDataKey.xbdTriggerDispatch]=false
return isOn
end,
func=function(orderID)
xiaoZhuShouOrderFunc.wbxbd_autoDispatchAdventure(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local isOn=setupData[xzsDataKey.xbdAutoIdle]==1
local isOnDispatch=setupData[xzsDataKey.xbdAutoDispatch]==1
local isOnReceive=setupData[xzsDataKey.xbdAutoReceive]==1

local channelList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.finish,WBXBD_Channel_STATE.early_return})
local noReceiveChannel=#channelList==0

local channelList=wanBaoXunBaoDuiModel:getChanelListByState({WBXBD_Channel_STATE.idle,WBXBD_Channel_STATE.preparing})
local noDispatchChannel=#channelList==0

return isOn and((isOnReceive and noReceiveChannel)or(isOnDispatch and noDispatchChannel))

end,
func=function(orderID)
xiaoZhuShouOrderFunc.wbxbd_autoIdle(orderID)
end,
},
},
refresh=function(self_,setup)

end,
checkSetup=function(win)
xiaoZhuShouOrderFunc.wbxbd_CheckSetUp(win)
end,
},
[XIAOZHUSHU_ENUM.xzs_ZZSH_YBD]={
init=function(self_,setup)
setup[xzsDataKey.zzshYBDAutoSaveMoney]=0
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.zzshYBDAutoSaveMoney]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.zzshYBDAutoSaveMoney(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},
[XIAOZHUSHU_ENUM.xzs_XJ_YBD]={
init=function(self_,setup)
setup[xzsDataKey.xjYBDAutoSaveMoney]=0
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xjYBDAutoSaveMoney]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xjYBDAutoSaveMoney(orderID)
end,
},
},
refresh=function(self_,setup)

end,
},

[XIAOZHUSHU_ENUM.xzs_TYSC]={
init=function(self_,setup)
setup[xzsDataKey.tyscAutoYaoShou]=1
setup[xzsDataKey.tyscAutoShouLing]=1
setup[xzsDataKey.tyscAutoReceive]=1
setup[xzsDataKey.tyscYaoShouType]=1
setup[xzsDataKey.tyscAutoBuyTimesYS]=0
setup[xzsDataKey.tyscBuyTimesYS]=5
setup[xzsDataKey.tyscAutoBuyTimesSL]=0
setup[xzsDataKey.tyscBuyTimesSL]=3
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.tyscAutoYaoShou]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.tysc_autoChallengeYS(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.tyscAutoShouLing]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.tysc_autoChallengeSL(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.tyscAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.tysc_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_XFWD]={
init=function(self_,setup)
setup[xzsDataKey.xfwdAutoChallenge]=1
setup[xzsDataKey.xfwdPriorityChallenge]=1
setup[xzsDataKey.xfwdAutoBuyTimes]=0
setup[xzsDataKey.xfwdBuyTimes]=5
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xfwdAutoChallenge]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xfwd_autoChallenge(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_TYCY]={
init=function(self_,setup)
setup[xzsDataKey.tycyAutoChallenge]=1
setup[xzsDataKey.tycyAutoReceive]=1
setup[xzsDataKey.tycyAutoBuyTimes]=0
setup[xzsDataKey.tycyBuyTimes]=3
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.tycyAutoChallenge]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.tycy_autoChallenge(orderID)
end,
},









},
},

[XIAOZHUSHU_ENUM.xzs_TWXM]={
init=function(self_,setup)
setup[xzsDataKey.twxmAutoChallenge]=1
setup[xzsDataKey.twxmAutoReceive]=1
setup[xzsDataKey.twxmAutoBuyTimes]=0
setup[xzsDataKey.twxmBuyTimes]=3
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.twxmAutoChallenge]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.twxm_autoChallenge(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.twxmAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.twxm_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_XianBang]={
init=function(self_,setup)
setup[xzsDataKey.xianbangAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xianbangAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xianbang_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_TaiXuCang]={
init=function(self_,setup)
setup[xzsDataKey.taixucangAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.taixucangAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.taixucang_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_LittleWorld]={
init=function(self_,setup)
setup[xzsDataKey.littleworldAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.littleworldAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.littleworld_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_YFLT]={
init=function(self_,setup)
setup[xzsDataKey.yfltAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.yfltAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.yflt_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_ZMFY]={
init=function(self_,setup)
setup[xzsDataKey.zmfyAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.zmfyAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.zmfy_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_ActFreeGift]={
init=function(self_,setup)
setup[xzsDataKey.tdmjAutoReceive]=1
setup[xzsDataKey.xslbAutoReceive]=1
setup[xzsDataKey.xsqdAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.tdmjAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.tdmj_autoReceive(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xslbAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xslb_autoReceive(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xsqdAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xsqd_autoReceive(orderID)
end,
},
},
},

[XIAOZHUSHU_ENUM.xzs_ActFreeLottery]={
init=function(self_,setup)
setup[xzsDataKey.xyxfAutoReceive]=1
setup[xzsDataKey.dtfdAutoReceive]=1
setup[xzsDataKey.xgyjAutoReceive]=1
end,
execute={
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xyxfAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xyxf_autoLottery(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.dtfdAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.dtfd_autoLottery(orderID)
end,
},
{
check=function(orderID)
local setupData=xiaoZhuShouModel:getSetupData(orderID)
return setupData[xzsDataKey.xgyjAutoReceive]==1
end,
func=function(orderID)
xiaoZhuShouOrderFunc.xgyj_autoLottery(orderID)
end,
},
},
},
}

function xiaoZhuShouModel:initSetupConfig()
for orderID,v in pairs(xiaoZhuShouSetupConfig)do
v.orderID=orderID
v.isRefreh=false
end
end

function xiaoZhuShouModel:getSetupConfig(orderID)
local cfg=xiaoZhuShouSetupConfig[orderID]
return cfg
end

function xiaoZhuShouModel:getSetupData(orderID)
local key=tostring(orderID)
local list=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eXiaoZhuShou)or{}
local setup=list[key]

local cfg=xiaoZhuShouSetupConfig[orderID]
if not cfg then
logErr('小助手程序配置未实现',orderID)
end

local change=false
if setup==nil then
setup={}
cfg:init(setup)
change=true
else
local tempSetup={}
cfg:init(tempSetup)
for key,v in pairs(tempSetup)do
if setup[key]==nil or setup[key]=="nil"or tostring(setup[key])=="userdata: NULL"then
setup[key]=v
change=true
end
end
end

list[key]=setup

if change then
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXiaoZhuShou,list)
end

if not cfg.isRefreh then
if cfg.refresh then
local flag=cfg:refresh(setup)
if flag then
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXiaoZhuShou,list)
end
end
cfg.isRefreh=true
end
return setup
end

function xiaoZhuShouModel:flushSetupData()
local list=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eXiaoZhuShou)or{}
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXiaoZhuShou,list)
end

function xiaoZhuShouModel:fixSetupData20250904()
local list=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eFixCode)or{}
local key="xzsFix20250904"
local data=list[key]
if data==nil or data=="nil"or tostring(data)=="userdata: NULL"or type(data)=='userdata'then
local handleList={
{XIAOZHUSHU_ENUM.xzs_YueLongChi,{{xzsDataKey.ylcAutoSell,0},}},
{XIAOZHUSHU_ENUM.xzs_TYSC,{{xzsDataKey.tyscAutoBuyTimesYS,0},{xzsDataKey.tyscAutoBuyTimesSL,0},}},
{XIAOZHUSHU_ENUM.xzs_XFWD,{{xzsDataKey.xfwdAutoBuyTimes,0},}},
{XIAOZHUSHU_ENUM.xzs_TYCY,{{xzsDataKey.tycyAutoBuyTimes,0},}},
{XIAOZHUSHU_ENUM.xzs_TWXM,{{xzsDataKey.twxmAutoBuyTimes,0},}},
}
for _,v in ipairs(handleList)do
local orderID=v[1]
local setupData=xiaoZhuShouModel:getSetupData(orderID)
for _,vv in ipairs(v[2])do
local dataKey=vv[1]
local setVal=vv[2]
setupData[dataKey]=setVal
end
end
xiaoZhuShouModel:flushSetupData()

list[key]=1
serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eFixCode,list)
end
end