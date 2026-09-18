
msgWinControl=gameState.addListener({})

msgWinType=
{
eEmergenciesWraning=1,
eEmergenciesSettlement=2,
eZMDailyPaper=3,
eZMCreateName=4,
eCommonShowPrize=5,
eTopEventWin=6,
ePushGift=7,
eFlyWin=8,
eMonthInvestorDaily=9,
eLimitActPreview=10,
eActPreview=11,
eUseTianMingItem=12,
ePushGiftTwo=13,
eLunDaoInvitation=14,
eReviews=15,
eBLSPickUpTips=16,
eXMFXZYRewardMailTips=17,
eHuntMonsterTeamLose=18,
eHuntMonsterTeamComplete=19,
eGongceqiandao=20,
eLunDaoJinJi=21,
eLunDaoXiBai=22,
eLunDaoGuanJun=23,
eShiliantaGuaJi=24,
ePushGiftThree=25,
eTianJiangFuYuan=26,
eReturningPlayer=27,
ePlayerCreateName=28,
eXianTuManMan=29,
eSystemZongMenFightForetell=30,
eSystemZongMenDefenseSuccess=31,
eSystemZongMenDefenseFailure=32,
eMonthCard=33,
eGongGao=34,
eLunDaoRank=35,
eLianDongZY=36,
eWages=37,
eWDCQGJXX=38,
eWDCQQFZY=39,
eWDCQYQCS=40,
eWDCQCSJG=41,
eWDCQYYCS=42,
eWDCQZZJG=43,
eHouShanGuaJi=44,
eWDCQJCJG=45,
eXWSRank=46,
eXWSTips=47,
eHaoPingYouLi=48,
eLTYWRankBg=49,
eXianJieJieYinAskSuccess=50,
eXianGuanJingXuanResult=51,
eXianGuanTeQuanSketchyLog=52,
eAnniversarySignIn=53,
eJiuYouTa=54,
eXianMengDiGong=55,
eMoJieOpenCD=56,
eMoJieCloseCD=57,
eFirstAscentTips=58,
eXianJieRebuildPreview=59,
eMGZDRankBg=60,
eMoJiangFinish=61,
eMoJunFinish=62,
eActivityEnterMerge_1=63,
eMoJunBoxTips=64,
eMoJieShop=65,
eMGZDSettlement=66,
eActivityMain_ChaoZhiTeHui=67,
eZhenTaiFinish=68,
eGongCeQianDao_KPBL=69,
}






local _msgWinDefine=
{
[msgWinType.eEmergenciesWraning]=
{
name='UIEmergenciesWraning',
extraCondition=function(data)

local isOpenWorldMapWin=UIManager:isActive('UIWorldMapWinEx')
return not isOpenWorldMapWin
end,
},

[msgWinType.eEmergenciesSettlement]=
{
name='UIEmergenciesSettlement',
extraCondition=function(data)
local isInHome=isometricMapSystem:IsInHome()

local isOpenWorldMapWin=UIManager:isActive('UIWorldMapWinEx')

return not isOpenWorldMapWin and isInHome==true
end,
},

[msgWinType.eZMDailyPaper]=
{
name='UIZongmenDailyWin',
},

[msgWinType.eZMCreateName]=
{
name='UICreateZMNameWin',
removeCondition=function(data)
return UIManager:isActive('UICreateZMNameWin',true)
end
},
[msgWinType.eCommonShowPrize]=
{
name='UICommonShowPrizeWin',
},
[msgWinType.eTopEventWin]=
{
name='UISMBaiShanEventWin',
},

[msgWinType.ePushGift]=
{
name='UIPushGiftWin',
},
[msgWinType.ePushGiftTwo]=
{
name='UIPushGiftAdvertWin',
},
[msgWinType.ePushGiftThree]=
{
name='UIPushGiftAdvertThreeWin',
},
[msgWinType.eFlyWin]=
{
name='UIFlyIconWin',
extraCondition=function(data)
local hasState=wuXingDianModel:getInFight()
return not hasState
end,
},
[msgWinType.eMonthInvestorDaily]=
{
name='UIMonthInvestorDailyWin',
},
[msgWinType.eLimitActPreview]=
{
name='UILimitActPreviewMainWin',
},
[msgWinType.eActPreview]=
{
name='UIActPreviewWin',
},
[msgWinType.eUseTianMingItem]=
{
name='UIUseTianMingItemWin',
},
[msgWinType.eLunDaoInvitation]=
{
name='UILunDaoInvitationWin',
removeCondition=function(data)

local isTruce=douFaTaiModel:checkIsTruce()
local selfRank=0
local doufataiData=douFaTaiModel:get_doufatai_data()
if isTruce then

selfRank=doufataiData and doufataiData.rank or 0
else

selfRank=doufataiData and doufataiData.lastSelfRank or 0
end
if selfRank and selfRank>0 then
return false
end


return true
end
},
[msgWinType.eReviews]=
{
name='UIGoodReviewsWin',
},
[msgWinType.eBLSPickUpTips]=
{
name='UIBaoLingShuPickUp_TipsWin',
},
[msgWinType.eXMFXZYRewardMailTips]=
{
name='UIXMFXZYGainDialog',
},
[msgWinType.eHuntMonsterTeamLose]=
{
name='UIWorldMonsterHurtTeamLoseWin',
},
[msgWinType.eHuntMonsterTeamComplete]=
{
name='UIWorldMonsterHurtTeamCompletedWin',
},
[msgWinType.eGongceqiandao]=
{
name='UISubAct_QianDaoWin',
removeCondition=function(data)
local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.egongCheQianDao)
if#(sub_actList or{})>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and activitiesModel:checkActOpen(sub_actInfo.act_id)and sub_actInfo:checkShowLogin()and sub_actInfo:checkReddot()then
return false
end
end
end
return true
end,
},
[msgWinType.eLunDaoJinJi]=
{
name='UILunDaoJinJiWin',
},
[msgWinType.eLunDaoXiBai]=
{
name='UILunDaoXiBaiWin',
},
[msgWinType.eLunDaoRank]=
{
name='UILunDaoRankWin',
},
[msgWinType.eLunDaoGuanJun]=
{
name='UILunDaoGuanJunWin',
removeCondition=function(data)
if lundaodahuiModel:isShowGuanJunWin()then
return true
end
return false
end,
},
[msgWinType.eShiliantaGuaJi]=
{
name='UIShiLianTaGuaJiLoseWin',
extraCondition=function(data)
return shiLianTaModel:getGuaJILoseArgs()~=nil and
MysteryModel:get_cur_fbid()==nil and
shiLianTaModel:getGuaJILoseLayer()~=nil and
shiLianTaModel:getGuaJILayer()~=nil
end,
},
[msgWinType.eHouShanGuaJi]=
{
name='UIHuanJingGuaJiLoseWin',
extraCondition=function(data)
return UIHuanJingControl:getGuaJILoseArgs()~=nil and
MysteryModel:get_cur_fbid()==nil and
UIHuanJingControl:getGuaJILayer()~=nil
end,
},
[msgWinType.eJiuYouTa]=
{
name='UIJiuYouTaGuaJiLoseWin',
extraCondition=function(data)
return JiuYouTaModel:getGuaJILoseArgs()~=nil and
MysteryModel:get_cur_fbid()==nil and
JiuYouTaModel:getGuaJILayer()~=nil
end,
},
[msgWinType.eTianJiangFuYuan]={
name='UITianjiangfuyuanWin',
extraCondition=function(data)
local list=tianJiangFuYuanModel:getThemeList()
return list and next(list)~=nil
end,
removeCondition=function(data)
local list=tianJiangFuYuanModel:getThemeList()
return list==nil or next(list)==nil
end
},
[msgWinType.eReturningPlayer]=
{
name='UIGuiTuZhiYinWin',
},
[msgWinType.ePlayerCreateName]={
name='UICreateRoleWin',
removeCondition=function(data)
return UIManager:isActive('UICreateRoleWin',true)
end
},
[msgWinType.eXianTuManMan]={
name='UIXianTuManManWin',
removeCondition=function(data)
return not XianTuManManController:checkEnter()
end
},
[msgWinType.eSystemZongMenFightForetell]={
name='UISystemZongMenFightForetellWin',
},
[msgWinType.eSystemZongMenDefenseSuccess]={
name='UISystemZongMenFightDefenseSuccessWin',
},
[msgWinType.eSystemZongMenDefenseFailure]={
name='UISystemZongMenFightDefenseFailureWin',
},
[msgWinType.eMonthCard]=
{
name='UIMonthInvestorWin_zhekou',
},
[msgWinType.eGongGao]=
{
name='UIGongGaoWin',
},
[msgWinType.eLianDongZY]=
{
name='UIUseLianDongItemWin',
},
[msgWinType.eWages]=
{
name='UIWagesInfoWin'
},
[msgWinType.eWDCQGJXX]=
{
name='UIWDCQGJXXWin'
},
[msgWinType.eWDCQQFZY]=
{
name='UIWDCQQFZYWin'
},
[msgWinType.eWDCQYQCS]=
{
name='UIWDCQYQCSWin',








},
[msgWinType.eWDCQCSJG]=
{
name='UIWDCQCSJGWin'
},
[msgWinType.eWDCQYYCS]=
{
name='UIWDCQYYCSWin',
extraCondition=function(data)
WDCQModel:refreshBookWin()
if not WDCQModel:hasBookWin()then
return true
end
if WDCQModel:getShowBookWin()then
return true
end
return false
end,
removeCondition=function(data)
return not WDCQModel:hasBookWin()
end,
},
[msgWinType.eWDCQZZJG]=
{
name='UIWDCQZZJGWin'
},
[msgWinType.eWDCQJCJG]=
{
name='UIWDCQGuessResultWin'
},
[msgWinType.eXWSRank]=
{
name='UIXWSRankWin'
},
[msgWinType.eXWSTips]=
{
name='UIXWSTipsWin'
},
[msgWinType.eHaoPingYouLi]=
{
name='UIHaoPingYouLiPopupWin'
},
[msgWinType.eLTYWRankBg]=
{
name='UIXianJieArenaAct_rankBgWin',
extraCondition=function(data)
if xianjieController:chcekIsInStoryMode()then
return false
end
return true
end
},
[msgWinType.eMGZDRankBg]=
{
name='UIMoGongZhengDuoAct_rankBgWin',
extraCondition=function(data)
if xianjieController:chcekIsInStoryMode()then
return false
end
return true
end
},
[msgWinType.eXianJieJieYinAskSuccess]=
{
name='UIXianJieJieYin_AskSuccessWin'
},
[msgWinType.eXianGuanJingXuanResult]=
{
name="UIXianGuanJingXuanResultWin",
extraCondition=function(data)
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)and xianguanModel:getReceiveServerDataState()
end,
removeCondition=function(data)
local types=xianguanModel:getMsgJingXuanResultType()
local nowTime=timeHelper.getServerShortTime()
for campaignType,temp in pairs(types)do
local check=xianguanController:isJingXuanWeek(campaignType)
if check then
local startTime,endTime=xianguanController:getJingXuanResultTime(campaignType)
if startTime<=nowTime and nowTime<endTime then
xianguanModel:deleteMsgJingXuanResultType(campaignType)
end
end
end
return not xianguanModel:checkExistMsgJingXuanResultType()
end
},
[msgWinType.eXianGuanTeQuanSketchyLog]=
{
name='UIXianGuanSketchyLogWin'
},
[msgWinType.eAnniversarySignIn]=
{
name='UISubAct_AnniversarySignInWin',
extraCondition=function(data)
local args=data.args
local actInfo=activitiesModel:getActInfo(args.act_id)
local sub_actInfo=activitiesModel:getSubActInfo(args.act_id,args.sub_act_type,args.sub_act_id)
return actInfo:checkOpen()and sub_actInfo:checkOpen()
end,
},
[msgWinType.eXianMengDiGong]=
{
name='UI_XMDG_PreviewWin',
extraCondition=function(data)
local args=data.args
local actInfo=limitActivitiesModel:getActInfo(args.act_id)
local actList=actPreviewModel:getPreviewSortList()or{}
for i,d in ipairs(actList)do
if d:checkReward()or actPreviewModel:getActPreviewMark()then
userActorSetting.set('act_XMDG_preview_oldTime',tostring(actInfo.start_time))
userActorSetting.flush()
return false
end
end
local oldTime=userActorSetting.get("act_XMDG_preview_oldTime",nil)
if tostring(actInfo.start_time)==oldTime then
return false
end
return xianmengModel:hasXM()and actInfo:checkOpen()and actInfo:checkDoing()
end,
},
[msgWinType.eMoJieOpenCD]=
{
name='UIMoJieCDOpenWin',
extraCondition=function()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local config=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local nowTime=timeHelper.getServerShortTime()
local deadline=enterData.sTime-config.preview[1]*86400
return nowTime>=deadline and nowTime<enterData.eTime
end
return true
end,

removeCondition=function(data)

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return true
end

if MojiePreviewExtendController.checkPoKaiMoJieFlag()then
return true
end

return false
end,
},
[msgWinType.eMoJieCloseCD]=
{
name='UIMoJieCDCloseWin',
extraCondition=function()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local config=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local nowTime=timeHelper.getServerShortTime()
local deadline=enterData.eTime-config.preview[2]*86400
return nowTime>=deadline and xianjieModel:checkFinishPreview()and xianjieModel:checkJoin_mojie()
end
return true
end,
removeCondition=function(data)
local enterData=xianjieModel:getMoJieEnterData()
return enterData==nil or enterData.eTime<=timeHelper.getServerShortTime()
end,
},
[msgWinType.eMoJieShop]=
{
name='UIMJ_ShopWinChangeTipsWin',

},
[msgWinType.eFirstAscentTips]=
{
name='UIJiuChongTianJieFirstAscentWin',
extraCondition=function(data)
return jiuchongtianjieFirstAscentModel:getIsCanAutoTips()
end,
removeCondition=function(data)
return not jiuchongtianjieFirstAscentModel:getCanTipsByDay()
end,
},
[msgWinType.eXianJieRebuildPreview]=
{
name='UICommonVisualGuideWin',
removeCondition=function(data)
local time=timeHelper.getServerShortTime()
return time>=data.args.endTime
end,
},
[msgWinType.eMoJiangFinish]=
{
name='UIZhengTaoMoJiangFinishWin',
removeCondition=function(data)
local seasonType=data.args.seasonType
local stageIndex=data.args.stageIndex
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
return xianjieModel:checkMoJiangFinishFlag(seasonType,stageIndex,stage.beginTime)
end
return true
end,
},
[msgWinType.eMoJunFinish]=
{
name='UIMoJieMoJunFinishWin',
removeCondition=function(data)
local seasonType=data.args.seasonType
local stageIndex=data.args.stageIndex
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
return xianjieModel:checkMoJunFinishFlag(seasonType,stageIndex,stage.beginTime)
end
return true
end,
},
[msgWinType.eActivityEnterMerge_1]=
{
name='UI_activityMerge_main_Win',
},
[msgWinType.eMoJunBoxTips]=
{
name='UIMoJieMoJunBoxTipsWin',
},
[msgWinType.eMGZDSettlement]=
{
name='UIMoGongZhengDuoAct_SettlementWin',
},
[msgWinType.eActivityMain_ChaoZhiTeHui]=
{
name='UI_activity_main_Win_ChaoZhiTeHui',
},
[msgWinType.eZhenTaiFinish]=
{
name='UIMoJieZhenTaiFinishWin',
removeCondition=function(data)
local seasonType=data.args.seasonType
local stageIndex=data.args.stageIndex
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
return xianjieModel:checkZhenTaiFinishFlag(seasonType,stageIndex,stage.beginTime)
end
return true
end,
},
[msgWinType.eGongCeQianDao_KPBL]=
{
name='UISubAct_QianDaoWin_KPBL',
removeCondition=function(data)
local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.egongCheQianDao)
if#(sub_actList or{})>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and activitiesModel:checkActOpen(sub_actInfo.act_id)and sub_actInfo:checkShowLogin()and sub_actInfo:checkReddot()then
return false
end
end
end
return true
end,
},
}

local _msgWinNum
local _msgWinQueue
local _currWinData
local _lockMark=false

function msgWinControl:onEnterState(...)
_msgWinQueue={}
_msgWinNum={}

if webGLHelper:isRunWebGL()then

self.allowShowWinTime=os.time()+15
end

notifySystem:listenNotify(notifyConfig.closeUIEx,self.on_close_ui)
notifySystem:listenNotify(notifyConfig.onServerPlatformInited,self.onServerPlatformInited)
notifySystem:listenNotify(notifyConfig.needLoadFinish,self.needLoadFinish)
end

function msgWinControl:onLeaveState(...)
_msgWinQueue=nil
_currWinData=nil
_msgWinNum=nil

timeEventController.removeQuickTimerHandler('msgWinControl')

notifySystem:removelistener(notifyConfig.closeUIEx,self.on_close_ui)
notifySystem:removelistener(notifyConfig.onServerPlatformInited,self.onServerPlatformInited)
notifySystem:removelistener(notifyConfig.needLoadFinish,self.needLoadFinish)
end

function msgWinControl.needLoadFinish()
msgWinControl.allowShowWinTime=nil
end

function msgWinControl:onProtocolReq()
timeEventController.addQuickTimerHandler('msgWinControl',self)
end

function msgWinControl.on_close_ui(name)
if _currWinData then
local def=_msgWinDefine[_currWinData.type]
if name==def.name then
if def.onCloseWin then
def.onCloseWin(_currWinData.args)
end
if _currWinData.exArgs.callback then
_currWinData.exArgs.callback()
end
local num=_msgWinNum[_currWinData.type]
_msgWinNum[_currWinData.type]=num-1
_currWinData=nil
msgWinControl:showNextWin()
end
end
end

function msgWinControl.onServerPlatformInited()
msgWinControl:initData()
end

function msgWinControl:onQuickUpdate(delta)
if webGLHelper:isRunWebGL()and self.allowShowWinTime then
local time=os.time()
if time<self.allowShowWinTime then
return
end
end
self:showNextWin()
end

function msgWinControl:initData()




local cfgs=cfg_msgwinconfig()
local cfgdir={}
for i,v in ipairs(cfgs)do
cfgdir[v.name]=v
end

for i,v in ipairs(_msgWinDefine)do
local cfg=cfgdir[v.name]
if not cfg then
logErr(FMT.fmt('[msgWinControl][initData] 缺少弹窗配置 窗口名:{0}',v.name))
end
v.scenes={}
for ii,vv in ipairs(cfg.scenes)do
v.scenes[vv]=true
end
v.validPeriod=cfg.valid_period
v.hcWins=cfg.hc_win
v.xqWins=cfg.xq_win
v.allowFullScreen=cfg.allow_full_screen
v.allowNovicePeriod=cfg.allow_novice_period
v.priority=cfg.priority
end

end

function msgWinControl:isCanShowNext(index)
local data=_msgWinQueue[index]
local def=_msgWinDefine[data.type]

if not sceneControl:isEnter()then return false end

if newbieControl.isInNewbie()then
return false
end

if not isometricMapSystem:isCanControl()then
return false
end

if not xianjieController:getCameraControl()then
return false
end

local stype=mainControl:getSceneType()
if not def.scenes[stype]then
return false
end

if def.validPeriod then
local currtime=gameUtilityModel.getServerShortTime()
if currtime>data.time+def.validPeriod then
return false,true
end
end

if not def.allowFullScreen then
if fullScreenUI.isActiveFull()then
return false
end
end

if not def.allowNovicePeriod then
if gameplotModel:inNovicePlot()then
return false
end
end

if def.hcWins then
for i,v in ipairs(def.hcWins)do
if UIManager:findActiveWindow(v)then
return false
end
end
end

if def.xqWins then
for i,v in ipairs(def.xqWins)do
if not UIManager:findActiveWindow(v)then
return false
end
end
end

if not isometricMapSystem:isInNormalMode()then
return false
end

local exArgs=data.exArgs
if exArgs.delay then
local currtime=gameUtilityModel.getServerShortTime()
local pt=data.time+exArgs.delay
if currtime<pt then
return false
end
end

if def.extraCondition then
if not def.extraCondition(data)then
return false
end
end

if def.removeCondition then
if def.removeCondition(data)then
return false,true
end
end

return true
end



function msgWinControl:getNextWinData()
if not initProControl.isDone()then
return
end

if xianjieController:checkXianJieSystemOpen()and not xianjieModel:checkInit()then
return
end

if _lockMark then return end

local len=#_msgWinQueue
if len<=0 then
return nil
end

local lstate=sceneControl:getLoadingState()
if lstate==eSceneLoadState.Loading then
return nil
end
if mainControl:isWaitSceneChange()then
return nil
end

local count=1
while(true)do
local canshow,bremove=self:isCanShowNext(count)
if canshow then
local data=_msgWinQueue[count]
table.remove(_msgWinQueue,count)


return data
end
if bremove then
local data=_msgWinQueue[count]
local num=_msgWinNum[data.type]
_msgWinNum[data.type]=num-1
table.remove(_msgWinQueue,count)
count=count-1
len=len-1
end
count=count+1
if count>len then
break
end
end

return nil
end

function msgWinControl:showNextWin()

if storyAICommonManager:isPlayingStory()then return end
if _currWinData then
return
end
local data=self:getNextWinData()
if data then

local def=_msgWinDefine[data.type]
local check=UIManager:showWindow(def.name,data.args)
if check then
if def.onShowWin then
def.onShowWin(data.args)
end
_currWinData=data
end
end
end






function msgWinControl:addMsgWin(winType,winArgs,exArgs,onlyOne)

if verifyManager:checkSkipMsgWin(winType)then
return
end

if verifyManager:isHideActPreview()then
if winType==11 then
return
end
end
gameUtilityModel.checkPlotBatchWarning(FMT.fmt("弹窗系统添加弹窗，但是服务器平台数据未下发 ：{0}",winType))
local num=_msgWinNum[winType]or 0
if onlyOne and num>0 then return end
local currtime=gameUtilityModel.getServerShortTime()

local data=
{
type=winType,
args=winArgs,
exArgs=exArgs or{},
time=currtime,
priority=_msgWinDefine[winType].priority
}
_msgWinNum[winType]=num+1
table.insert(_msgWinQueue,data)
table.sort(_msgWinQueue,self.sort_func)

self:showNextWin()
end

function msgWinControl.sort_func(a,b)
if a.priority>b.priority then
return true
elseif a.priority==b.priority then
return a.time<b.time
else
return false
end
end

function msgWinControl.markLock(lock)
_lockMark=lock
end

function msgWinControl:getCurrentWinData()
return _currWinData
end



function msgWinControl:checkMsgWinIsShow(ignoreList)
local len=#_msgWinQueue
if not _currWinData and len<=0 then
return false
end

local isShowNow=false
local hasWaitToShow=false
if ignoreList and next(ignoreList)then
local ignoreList_lookup={}
for i,winType in ipairs(ignoreList)do
ignoreList_lookup[winType]=true
end
local waitWinCount=0
for i,data in pairs(_msgWinQueue)do
if not ignoreList_lookup[data.type]then
local def=_msgWinDefine[data.type]
if def.extraCondition==nil or def.extraCondition(data)then
waitWinCount=waitWinCount+1
end
end
end
hasWaitToShow=waitWinCount>0
if _currWinData and ignoreList_lookup[_currWinData.type]then
isShowNow=true
end
else
isShowNow=_currWinData~=nil
hasWaitToShow=len>0
end

return isShowNow or hasWaitToShow
end