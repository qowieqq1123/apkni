


















local _MODULENAME="xianjieController"
xianjieController=gameState.addListener({})
xianjieController.name=_MODULENAME

local xjServerEnityTypeHandle={
[xjServerEnityType.eActor]=xianjieModel.refreshZongMenData,
[xjServerEnityType.eGuild]=xianjieModel.refreshXianMengData,
[xjServerEnityType.eMonster]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eBossMonster]=xianjieModel.refreshMonsterData,

[xjServerEnityType.eStation]=xianjieModel.refreshStationData,
[xjServerEnityType.eMonsterHouse]=xianjieModel.refreshMonsterData,

[xjServerEnityType.eMoJieMoZong_Small]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieMoZong_Big]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJingZhenJi_Normal]=xianjieModel.refreshPuTongZhenJiData,
[xjServerEnityType.eMoJieMoJunYaoMo]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieMoJunFenShen]=xianjieModel.refreshMoJunFenShenData,
[xjServerEnityType.eMoJieMoster]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieShangGuMoster]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieBox]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieZhenYan_Spe]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieZhenYan_Big]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eMoJieZhenYan_Small]=xianjieModel.refreshMonsterData,
[xjServerEnityType.eLingShou]=xianjieModel.refreshXJLingShouData,
[xjServerEnityType.eLingShouGroup]=xianjieModel.refreshXJLingShouGroupData,
}

local listenMark=nil
local enterMapMark=nil
local mark35_1=nil
local mark35_3=nil
local isInit35_1=nil
local _lastFpsTime=nil

local _isFpsJianHuaMode=nil
local _fpsDelay=nil
local _fpsMaxCount=2
local _fpsCount=nil
local _startFpsTime=nil

xianjieController.lineRealCount=0
xianjieController.totalCount=0
xianjieController.maxShowLine=30
xianjieController.lineDrawCache={}
xianjieController.hideOtherLineLOD=2
xianjieController.curlodLevel=-1

xianjieController.pcallError=function(err)
loggerUtil.logErrFMT(err)
end

function xianjieController:clearListenMark()
listenMark=nil

xianjieModel:timeoutMapData()
xianjieModel:timeoutMapData_allXianJie()
end

function xianjieController:onAppStart()
xianjieController:onAppStart_scene()
xianjieController:onAppStart_plot()
xianjieController:onAppStart_xianjie()
xianjieController:onAppStart_xianyu()
xianjieController:onAppStart_mojie()
xianjieController:onAppStart_log()
xianjieController:onAppStart_exploration()
xianjieController:onAppStart_huzhu()
xianjieController:onAppStart_ResPoint()
xianjieController:onAppStart_buff()
xianjieController:onAppStart_zongmen()
xianjieController:onAppStart_LeyLine()
xianjieController:onAppStart_halo()
xianjieController:onAppStart_RDPosPint()
xianjieController:onAppStart_mojiang()
xianjieController:onAppStart_mojingzhenji()
xianjieController:onAppStart_mojieGate()
xianjieController:onAppStart_mojun()
xianjieController:onAppStart_xianmeng()
xianjieController:onAppStart_HitCount()
xianjieController:onAppStart_zhentai()
xianjieController:onAppStart_lingshou()
xianjieMainWinSimpleModeConfig:onAppStart()

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onShowUI,self.onShowUI)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
notifySystem:listenNotify(notifyConfig.onMoJieSeasonFogDissipate,self.onMoJieSeasonFogDissipate)

notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)

socketManager:register_receiver(35,1,xianjieController.recv_protocol_35_1)
socketManager:register_receiver(35,2,xianjieController.recv_protocol_35_2)
socketManager:register_receiver(35,3,xianjieController.recv_protocol_35_3)
socketManager:register_receiver(35,4,xianjieController.recv_protocol_35_4)
socketManager:register_receiver(35,5,xianjieController.recv_protocol_35_5)
socketManager:register_receiver(35,10,xianjieController.recv_protocol_35_10)
socketManager:register_receiver(35,11,xianjieController.recv_protocol_35_11)
socketManager:register_receiver(35,12,xianjieController.recv_protocol_35_12)
socketManager:register_receiver(35,27,xianjieController.recv_protocol_35_27)
socketManager:register_receiver(35,31,xianjieController.recv_protocol_35_31)
socketManager:register_receiver(35,32,xianjieController.recv_protocol_35_32)


socketManager:register_receiver(35,35,xianjieController.recv_protocol_35_35)
socketManager:register_receiver(35,36,xianjieController.recv_protocol_35_36)
socketManager:register_receiver(35,41,xianjieController.recv_protocol_35_41)

socketManager:register_receiver(35,51,xianjieController.recv_protocol_35_51)
socketManager:register_receiver(35,52,xianjieController.recv_protocol_35_52)
socketManager:register_receiver(35,53,xianjieController.recv_protocol_35_53)
socketManager:register_receiver(35,54,xianjieController.recv_protocol_35_54)
socketManager:register_receiver(35,55,xianjieController.recv_protocol_35_55)
socketManager:register_receiver(35,56,xianjieController.recv_protocol_35_56)
socketManager:register_receiver(35,57,xianjieController.recv_protocol_35_57)

socketManager:register_receiver(35,61,xianjieController.recv_protocol_35_61)
socketManager:register_receiver(35,62,xianjieController.recv_protocol_35_62)
socketManager:register_receiver(35,63,xianjieController.recv_protocol_35_63)
socketManager:register_receiver(35,64,xianjieController.recv_protocol_35_64)

socketManager:register_receiver(35,90,xianjieController.recv_protocol_35_90)
socketManager:register_receiver(35,91,xianjieController.recv_protocol_35_91)
socketManager:register_receiver(35,92,xianjieController.recv_protocol_35_92)
end

function xianjieController:onEnterState(isReconnet)
isInit35_1=nil
xianjieModel:initCfg()
xianjieModel:initMapConfig()
xianjieModel:initMonsterTeamInfo()
xianjieModel:initStory()
xianjieController:onEnterState_mojiang(isReconnet)
xianjieController:onEnterState_mojingzhenji(isReconnet)
xianjieController:onEnterState_mojieGate(isReconnet)
xianjieController:onEnterState_mojun(isReconnet)
xianjieController:onEnterState_plot(isReconnet)
xianjieController:onEnterState_xianjie(isReconnet)
xianjieController:onEnterState_xianyu(isReconnet)
xianjieController:onEnterState_mojie(isReconnet)
xianjieController:onEnterState_log(isReconnet)
xianjieController:onEnterState_exploration(isReconnet)
xianjieController:onEnterState_ResPoint(isReconnet)
xianjieController:onEnterState_RDPosPint(isReconnet)
xianjieController:onEnterState_buff(isReconnet)
xianjieController:onEnterState_zongmen(isReconnet)
xianjieController:onEnterState_LeyLine(isReconnet)
xianjieModel:onEnterState_ShouMo(isReconnet)
xianjieController:onEnterState_Story(isReconnet)
xianjieController:onEnterState_JZAttribute(isReconnet)
xianjieController:onEnterState_halo(isReconnet)
xianjieController:onEnterState_RebuildPreview(isReconnet)
xianjieController:onEnterState_HitCount(isReconnet)
xianjieController:onEnterState_zhentai(isReconnet)
xianjieController:onEnterState_lingshou(isReconnet)

xianjieModel:initTransferData()

ims_fort_ai:onEnterState_ai(isReconnet)
end

function xianjieController:onLeaveState(isReconnet)
if isReconnet then
xianjieController:removeFPSTimer()
end

xianjieModel:clearData(isReconnet)
xianjieModel:clearData_mojie(isReconnet)
xianjieModel:clearMapConfig()
xianjieModel:clearData_zongmen()
xianjieModel:clearData_monster()
xianjieModel:clearMonsterTeamInfo()
xianjieModel:clearData_resource()
xianjieModel:clearData_xianmeng()
xianjieModel:clearAllXianMengGarrisonData()
xianjieModel:clearData_station()
xianjieModel:clearData_marchTeam()
xianjieModel:clearData_marchTeam_notData()
xianjieModel:clearData_jiJieTeamDetail()
xianjieModel:clearData_selfJiJieTeam()
xianjieModel:clearData_selfStationTeam()
xianjieModel:clearData_selfYuanJunTeam()
xianjieModel:clearData_selfYuanJunTeam_MoJie()
xianjieModel:clearData_selfYuanJunTeam_MoGong()
xianjieModel:clearData_jiJieYBDListData()
xianjieModel:clearData_jiJieSelfMassYBDCdStamp()
xianjieModel:clearData_arenaZJTeam()
xianjieModel:clearData_moGongZJTeam()
xianjieModel:clearData_MGZDBuildZJTeam()
xianjieModel:clearData_yunzhouTeam()
xianjieModel:clearData_jijieSimpleData()
xianjieModel:clearData_jiJieDirtyDataList()
xianjieModel:clearData_jiJieLocalData()
xianjieModel:clearData_NPC()
xianjieModel:clearData_force()
xianjieModel:clearData_allArena()
xianjieModel:clearData_caravanEscort()
xianjieModel:clearData_allMoGong()
xianjieModel:clearData_allMGZDClientBuild()
xianjieModel:clearData_MGZDBuildServerDataList()
xianjieModel:clearData_allZB()
xianjieController:clearData_openWin()
xianjieModel:clearSceneState()
xianjieModel:ClearData_ShouMo()
xianjieModel:clearData_Story()
xianjieModel:clearData_attribute()
xianjieModel:clearData_moJunFenShen()
xianjieModel:clearData_puTongZhenJi()
xianjieController:onLeaveState_mojiang(isReconnet)
xianjieController:onLeaveState_mojingzhenji(isReconnet)
xianjieController:onLeaveState_mojieGate(isReconnet)
xianjieController:onLeaveState_mojun(isReconnet)
xianjieController:onLeaveState_plot(isReconnet)
xianjieController:onLeaveState_xianjie(isReconnet)
xianjieController:onLeaveState_xianyu(isReconnet)
xianjieController:onLeaveState_mojie(isReconnet)
xianjieController:onLeaveState_log(isReconnet)
xianjieController:onLeaveState_exploration(isReconnet)
xianjieController:onLeaveState_ResPoint(isReconnet)
xianjieController:onLeaveState_RDPosPint(isReconnet)
xianjieController:onLeaveState_buff(isReconnet)
xianjieController:onLeaveState_zongmen(isReconnet)
xianjieController:onLeaveState_LeyLine(isReconnet)
xianjieController:onLeaveState_Story(isReconnet)
xianjieController:onLeaveState_HitCount(isReconnet)
xianjieController:onLeaveState_zhentai(isReconnet)
xianjieController:onLeaveState_lingshou(isReconnet)
XianJieFuMoController:removeBossData()
XingYuController:removeAllEntityData()
ims_fort_ai:onLeaveState_ai(isReconnet)
xianjieController:onLeaveState_JZAttribute(isReconnet)
xianjieController:onLeaveState_halo(isReconnet)
xianjieController:onLeaveState_RebuildPreview(isReconnet)
xianjieModel:onLeaveState_buffEntity()
xianjieModel:clearMoJieEnterData()
xianjieModel:clearFinishPreview()
xianjieController:setCameraMoving(nil)
listenMark=nil
enterMapMark=nil
mark35_1=nil
mark35_3=nil
isInit35_1=nil
self.send_35_31_ing=nil

xianjieController:clearAllEntity(isReconnet)
xianjieController:clearAllEntityHud()
xianjieController:clearAllBuoy()
clear_xjTeamHandleLookup()
clear_xjClassLookup()

xianjieController.lineRealCount=0
xianjieController.lineDrawCache={}
end

function xianjieController:onProtocolReq(isReconnet)
xianjieController:onProtocolReq_ResPoint(isReconnet)
xianjieController:onProtocolReq_RDPosPint(isReconnet)
xianjieModel:onProtocol_ShouMo()

xianjieModel:initXJAddAttr()









end

function xianjieController:onStartReconnect()
local sceneType=xianjieModel:getScenceType()
if sceneType then
xianjieController:setWaitLoadMap(true)
loadingControl.openCloud()
end
end

function xianjieController:onReConnection()
local sceneType=xianjieModel:getScenceType()
if sceneType then
xianjieController:onIntoScene_finish(false)
loadingControl.closeCloud()
end
end

function xianjieController:onProtocolReqKF(isReconnet)
if mark35_1 then
local args=mark35_1
mark35_1=nil
xianjieController.recv_protocol_35_1(args)
end
xianjieController:onProtocolReqKF_ResPoint(isReconnet)
xianjieController:onProtocolReqKF_mojie(isReconnet)
MojiePreviewExtendController.checkPopWin()
seasonModel:checkTriggerShowPreview()
seasonController:refreshLimitActCondition()
end



function xianjieController:onLeaveMap(ischange)

local sceneType=xianjieModel:getScenceType()
if not ischange then

local sceneidx=xianjieModel:getSceneIndex(sceneType)
xianjieController:reqMapListen(0,sceneidx)
xianjieController:closeWin3()
xjBehaviorManager:clearData2()
timeEventController.removeNormalTimerHandler(4,_MODULENAME)
if self.frameUpdateTimer~=nil then
self.frameUpdateTimer:cancel()
self.frameUpdateTimer=nil
end

fullScreenUI.destroyAllWindow()
xianjieModel:clearGuid2EntityType()
end

_isFpsJianHuaMode=false
xianjieController:removeFPSTimer()

local isPlot=false
if sceneType==xianjienSceneType.eXianJie then
if xianjieModel:checkEnterPlotMark()then
isPlot=true
xianjieController:onLeaveMap_plot(ischange)
else
xianjieController:onLeaveMap_xianjie(ischange)
end
elseif xianjienSceneType:isMoJie(sceneType)then
xianjieController:onLeaveMap_mojie(ischange)
elseif xianjienSceneType:isMoGongZhengDuo(sceneType)then
xianjieController:onLeaveMap_mogongzhengduo(ischange)
else
xianjieController:onLeaveMap_xianyu(ischange)
end
if not isPlot then
xianjieModel:removeAllZongMenEnities()
xianjieModel:removeAllXianMengEnities()
xianjieModel:removeAllMonsterEnities()
xianjieModel:removeAllResourceEnities()
xianjieModel:removeAllStationEnities()
xianjieModel:removeAllArenaEntities()
xianjieModel:removeAllZBEntities()
xianjieModel:removeAllMoGongEntities()
xianjieModel:removeAllMoJunFenShenEnities()
xianjieModel:removeAllPuTongZhenJiEnities()

xianjieModel:removeCaravanEscortHubEntities()
xianjieModel:removeAllCaravanEscortTeamBehavior()
xianjieModel:removeXJLingShouEnities()
xianjieModel:removeXJLingShouGroupEnities()
if ischange then
xianjieModel:clearData_marchTeamBehavior()
else
xianjieModel:clearData_marchTeam()

xianjieModel:clearData_marchTeam_notData()
end
end
xianjieModel:removeAllNPCEnities()
xianjieModel:removeAllTransferEntities()
xianjieController:onExitMap_ResPoint()
xianjieController:onExitMap_mojiang()
xianjieController:onExitMap_mojingzhenji()
xianjieController:onExitMap_mojieGate()
xianjieController:onExitMap_mojun()
xianjieController:onExitMap_LeyLine()
xianjieController:onLeaveMap_halo()
xianjieController:onExitMap_mojieFog()
xianjieModel:onLeaveMap_buffEntity()
xianjieController:onExitMap_zhentai()
xianjieController:setCameraMoving(nil)
xianjieController:clearAllEntity()
xianjieController:clearAllEntityHud()
xianjieController:clearAllBattleEffect()
xianjieController:clearAllBuoy()
if ischange then
xianjieModel:clearMapConfig_leave()
end
end



function xianjieController:onEnterMap(ischange,enterParam)

if not ischange then
timeEventController.addNormalTimerHandler(4,_MODULENAME,self)

if self.frameUpdateTimer~=nil then
self.frameUpdateTimer:cancel()
self.frameUpdateTimer=nil
end
self.frameUpdateTimer=timer.new()
self.frameUpdateTimer:start(0,xianjieController.onFrameUpdate,-1)
end

local Frame=userActorSetting.get('setFrame',nil)
if not Frame then
if webGLHelper:isRunMiniGame()then
Frame=webGLHelper:getAllowMaxFrameRate()
else
Frame=FRAME_LEVEL.eLow
end
end
xianjieController:onSetJianHuaMode(false,true)
_fpsCount=0
_fpsDelay=math.floor(2000/Frame)/1000
_startFpsTime=os_clock()+5
xianjieController:removeFPSTimer()
self.fpsUpdateTimer=timer.new()
self.fpsUpdateTimer:start(0.01,xianjieController.onFPSUpdate,-1)

local isPlot=xianjieController:checkInPlotScene()
if isPlot then
xianjieController:onEnterMap_listen(ischange,enterParam,true)
else
local sceneidx=xianjieModel:getSceneIndex()


if listenMark==nil or xianjienSceneIndexType:isMoJie(listenMark)~=xianjienSceneIndexType:isMoJie(sceneidx)
or xianjienSceneIndexType:isMoGongZhengDuo(listenMark)~=xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
xianjieModel:initAllMarchTeamDatas(true)
enterMapMark={ischange,enterParam}
if listenMark then

xianjieModel:checkMarchBaseWaiPaiData(sceneidx)
end
else

xianjieController:onEnterMap_listen(ischange,enterParam,false)
end

xianjieController:reqMapListen(1,sceneidx)
xianjieController:reqMassTeamList()
end
end


function xianjieController:onEnterMap_listen(ischange,enterParam,isPlot)
if isPlot then
xpcall(function()
xianjieController:onEnterMap_plot(ischange,enterParam)
end,xianjieController.pcallError)
else
xpcall(function()
xianjieModel:createAllZongMenEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllXianMengEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllMonsterEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllResourceEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllStationEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllMoJunFenShenEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllMarchTeamBehavior(nil,true)
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllArenaEntities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllZBEntities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createXJLingShouEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createXJLingShouGroupEnities()
end,xianjieController.pcallError)





xpcall(function()
xianjieModel:createCaravanEscortHubEntities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createCaravanEscortTeamListBehavior(nil,true)
end,xianjieController.pcallError)
local sceneType=xianjieModel:getScenceType()
if sceneType==xianjienSceneType.eXianJie then
xpcall(function()
xianjieController:onEnterMap_xianjie(ischange,enterParam)
end,xianjieController.pcallError)
elseif xianjienSceneType:isMoJie(sceneType)then
xpcall(function()
xianjieController:onEnterMap_mojie(ischange,enterParam)
end,xianjieController.pcallError)
elseif xianjienSceneType:isMoGongZhengDuo(sceneType)then
xpcall(function()
xianjieController:onEnterMap_mogongzhengduo(ischange,enterParam)
end,xianjieController.pcallError)
else
xpcall(function()
xianjieController:onEnterMap_xianyu(ischange,enterParam)
end,xianjieController.pcallError)
end
xpcall(function()
xianjieModel:createAllPuTongZhenJiEnities()
end,xianjieController.pcallError)
end
xpcall(function()
xianjieController:onEnterMap_ResPoint()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_LeyLine()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_zongmen()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_mojiang()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_mojingzhenji()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_mojieGate()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_mojun()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_mojieFog()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:onEnterMap_buffEntity()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:onEnterMap_zhentai()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllNPCEnities()
end,xianjieController.pcallError)
xpcall(function()
xianjieModel:createAllTransferEntities()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:initBuoy()
end,xianjieController.pcallError)
xpcall(function()
xianjieController:refreshAOIEntity_lua()
end,xianjieController.pcallError)

end

function xianjieController:handleEnterParam_pvp(enterParam,ischange)
if enterParam==nil then return end
local monsterInfo=enterParam.monsterInfo
if monsterInfo then
xianjieController:openMonsterInfoWin(monsterInfo[1])
end
end

function xianjieController:onNormalUpdate(delay)

xianjieController:updataAllEntitiyHud()
xianjieController:updataAllEntitiy()
xianjieController:onNormalUpdate_log()
xianjieController:onNormalUpdate_ResPoint()
xianjieController:onNormalUpdate_lingshou()
xianjieModel:onNormalUpdate_Monster()

local sceneType=xianjieModel:getScenceType()
if sceneType==xianjienSceneType.eXianJie then


elseif xianjienSceneType:isMoJie(sceneType)then
xianjieController:onNormalUpdate_mojie(delay)
else

end
end

function xianjieController:onFPSUpdate(delay)
local e=os_clock()
if _lastFpsTime then
local dt=e-_lastFpsTime
if dt>_fpsDelay and e>_startFpsTime then
_fpsCount=_fpsCount+1
if _fpsCount>=_fpsMaxCount then
xianjieController:removeFPSTimer()
xianjieController:onSetJianHuaMode(true)
end
else
_fpsCount=0
end
end
_lastFpsTime=e
end

function xianjieController:onSetJianHuaMode(flag,isInit)
_isFpsJianHuaMode=flag

if not isInit then
xianjieModel:refreshAllZongMenEntityModel()
xianjieModel:refreshAllMarchTeamModel()
end

notifySystem:postNotify(notifyConfig.onFPSJianHuaChange,flag,isInit)
end

function xianjieController:getJianHuaMode()
return _isFpsJianHuaMode==true
end

function xianjieController:removeFPSTimer()
_lastFpsTime=nil
if self.fpsUpdateTimer~=nil then
self.fpsUpdateTimer:cancel()
self.fpsUpdateTimer=nil
end
end

local pcallQuickUpdateFunc1=function()
xianjieController.updateEntityWidgetCache()
end
local pcallQuickUpdateFunc2=function(err)
loggerUtil.logErrFMT('xj updateEntityWidgetCache err!{0}',err)
end
local pcallQuickUpdateFunc3=function()
xianjieController:aWakeWaitHud()
end
local pcallQuickUpdateFunc4=function(err)
loggerUtil.logErrFMT('xj aWakeWaitHud err!{0}',err)
end
local pcallQuickUpdateFunc5=function()
xianjieController.updateEntityRomoveCache()
end
local pcallQuickUpdateFunc6=function(err)
loggerUtil.logErrFMT('xj updateEntityRomoveCache err!{0}',err)
end

function xianjieController.onFrameUpdate()
xpcall(pcallQuickUpdateFunc1,pcallQuickUpdateFunc2)
xpcall(pcallQuickUpdateFunc3,pcallQuickUpdateFunc4)
xpcall(pcallQuickUpdateFunc5,pcallQuickUpdateFunc6)
end

function xianjieController.onDiscipleRemove(reason,discipleGuid)
xianjieModel:removeXJYunZhouDz(discipleGuid)
xianjieModel:removeXJYunZhouTeamDz(discipleGuid)
end

function xianjieController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
xianjieController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
xianjieController:onLeaveHome()
end
end

function xianjieController:onEnterHome()
ims_fort_ai:onEnterHome_ai()
end

function xianjieController:onLeaveHome()
ims_fort_ai:onLeaveHome_ai()
end

function xianjieController:checkClickEmptyPos(sceneidx,gridX,gridZ,pos,isValid)
if isValid then

if not xianjienSceneIndexType:isOhterXianYu(sceneidx)then
local campos=xianjieController:getCameraPosition()
if campos.y<=xianjieController:getCameraYClick()then
xianjieController:onClickEmptyPos(sceneidx,gridX,gridZ)
else
xianjieModel:enterSceneState(xjSceneStateType.eClickEmpty,gridX,gridZ,1,1)
end
end
notifySystem:postNotify(notifyConfig.onClickXianJiePlane,gridX,gridZ,pos.x,pos.z)
end
return true
end

function xianjieController:onClickEmptyPos(sceneidx,gridX,gridZ)
if not xianjieModel:checkGridState3(sceneidx,gridX,gridZ)then
xianjieController:openEmptyPosWin(gridX,gridZ)
end
end

function xianjieController:openEmptyPosWin(gridX,gridZ)
local winParams={}
local width=1
local height=1
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
winParams.lookAtPos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c)
winParams.pos={gridX,gridZ}
winParams.pos_c={gridX_c,gridZ_c}
winParams.width=width
winParams.height=height
xianjieController:openWin('UIXianJie_emptyPosWin',winParams)
end

function xianjieController:openXianJieWin()

UIManager:showWindow('UIXianJieHudWin')
UIManager:showWindow('UIXianJieMainWin')
end

function xianjieController:hideXianJieWin()
UIManager:hideWindow('UIXianJieMainWin')
end

function xianjieController:closeXianJieWin()

UIManager:closeWindow('UIXianJieMainWin')
UIManager:closeWindow('UIXianJieHudWin')
end

function xianjieController:activeXianJieHud(isActive)
if isActive then
if UIManager:findActiveWindow('UIXianJieHudWin')and not UIManager:isActive('UIXianJieHudWin')then
UIManager:showWindow('UIXianJieHudWin')
end
else
UIManager:hideWindow('UIXianJieHudWin')
end
end

function xianjieController:checkXianJieSystemOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)
end

function xianjieController:checkXianYuOpen(isWarning)
local flag=systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)and not xianjieController:checkInPlotScene2()
if not flag and isWarning then
UIManager.info('仙域入口尚未开启')
end
return flag
end




function xianjieController:reqInfo()
socketManager:send_35_2()
end


function xianjieController:reqMapListen(listen,sceneidx)



if listen==0 then

if listenMark~=nil then
if gameState.isEnter()then
mark35_3=true
socketManager:send_35_3(listen,listenMark)
end
end
else

if listenMark~=sceneidx then
socketManager:send_35_3(listen,sceneidx)
end

if listenMark==nil then
xianjieController:reqInfo()
end

if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieController:reqInfo_mojie()
end
end
end


function xianjieController:reqSetAllow(allow)
socketManager:send_35_27(allow)
end


function xianjieController:reqCreateZMPos()
if not self.send_35_31_ing then
socketManager:send_35_31()
self.send_35_31_ing=true
end
end


function xianjieController:reqMoveZMPos(x,y)



local sceneidx=xianjieModel:getSceneIndex()
if xianjieController:checkInPlotScene()then
xianjieController:reqMoveZMPos_plot(sceneidx,x,y)
elseif xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieController:reqMoveZMPos_mojie(sceneidx,x,y)
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
xianjieController:reqMoveZMPos_mojie(sceneidx,x,y)
else
socketManager:send_35_32(sceneidx,x,y)
end
end

function xianjieController:reqOrder(guid,ordertype,guidList,moneyList,params,boatId,sendArgs,gateList,sceneidx)














guidList=guidList or{}
moneyList=moneyList or{}
params=params or''
boatId=boatId or 0
if sendArgs then
xianjieController.send_35_35_sendArgs=sendArgs
else
xianjieController.send_35_35_sendArgs=nil
end
sceneidx=sceneidx or xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
gateList=gateList or{}
socketManager:send_35_185(guid,ordertype,boatId,#guidList,guidList,#moneyList,moneyList,params,#gateList,gateList)
else
socketManager:send_35_35(guid,ordertype,boatId,#guidList,guidList,#moneyList,moneyList,params)
end
end


function xianjieController:reqMarchSpeedUp(marchguid,param)


local indexList
if type(param)=='number'then
indexList={param}
else
indexList=param
end
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
socketManager:send_35_186(marchguid,#indexList,indexList)
else
socketManager:send_35_36(marchguid,#indexList,indexList)
end
end


function xianjieController:reqMarchRetract(marchguid)

local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
socketManager:send_35_191(marchguid)
else
socketManager:send_35_41(marchguid)
end
end


function xianjieController:reqMassYBDChangeOpenFlag(openFlag)
socketManager:send_35_51(openFlag)
end



function xianjieController:reqMassYBDChangeOpenFlagWithType(jjType,isOpen)
local ybdData=xianjieModel:getJiJieYBDData()
local checkPosIndex
if jjType==xjJjJieBaseType.eMonster then
checkPosIndex=0
elseif jjType==xjJjJieBaseType.eWar then
checkPosIndex=1
end
local openFlag=ybdData and ybdData.openFlag or 0
if isOpen then
openFlag=bitHelper.set_1(openFlag,checkPosIndex)
else
openFlag=bitHelper.set_0(openFlag,checkPosIndex)
end
xianjieController:reqMassYBDChangeOpenFlag(openFlag)
end


function xianjieController:reqMassYBDMoneyAndSoldierSave(moneyNum)
socketManager:send_35_52(moneyNum)
end



function xianjieController:reqMassYBDSetPveCnd_pveChange(stage,rewardJoinFlag,lsRewardJoinFlag)
socketManager:send_35_53(stage,rewardJoinFlag,lsRewardJoinFlag)
end


function xianjieController:reqMassYBDTeamChange(ybdType,teamData)
socketManager:send_35_54(ybdType,teamData)
end


function xianjieController:reqMassYBDList(rtType,guid)
socketManager:send_35_55(rtType,guid)
end


function xianjieController:reqMassYBDSetPostLimitList(rtType,list)
socketManager:send_35_56(rtType,#list,list)
end


function xianjieController:reqMassYBDSetXianXuRejectedList(xmList,xgList)
socketManager:send_35_57(#xmList,xmList,#xgList,xgList)
end


function xianjieController:reqMassTeamList(massGuid)
local needReqMoJieJiJie=false


local isOpenMoJie=limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJieSaiJi)
if isOpenMoJie then
if massGuid then

local isMoJieMass=xianjieModel:checkJiJieIsMoJieByMassGuid(massGuid)
if isMoJieMass==nil then

isMoJieMass=true
end
needReqMoJieJiJie=isMoJieMass
else
needReqMoJieJiJie=true
end
end

socketManager:send_35_61()
if needReqMoJieJiJie then
socketManager:send_35_196()
end
end


function xianjieController:reqMassDetail(actorId,guid,sendArgs,sceneidx)

local isMoJie
if sceneidx then
isMoJie=xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)or false
else
isMoJie=xianjieModel:checkJiJieIsMoJieByMassGuid(guid)
end


if isMoJie then
if sendArgs then
xianjieController.send_35_197_sendArgs=sendArgs
else
xianjieController.send_35_197_sendArgs=nil
end

socketManager:send_35_197(actorId,guid)
else
if sendArgs then
xianjieController.send_35_62_sendArgs=sendArgs
else
xianjieController.send_35_62_sendArgs=nil
end

socketManager:send_35_62(actorId,guid)
end
end


function xianjieController:reqMonsterTeamInfo(infoguid)
socketManager:send_35_63(infoguid)
end


function xianjieController:send_35_90()
socketManager:send_35_90()
end


function xianjieController:send_35_91(entityID)
socketManager:send_35_91(entityID)
end


function xianjieController:send_35_92(entityID)
socketManager:send_35_92(entityID)
end





function xianjieController.recv_protocol_35_1(args)










if not initProControl.isDoneKF()then
mark35_1=args
return
end

local isInit=xianjieModel:initData(args[1])
if isInit then
xianjieModel:initJiJieYBDData()
xianjieModel:createLeyLineData()
end
xianjieModel:setJiJieYBDData_openFlag(args[2])
xianjieModel:setJiJieYBDData_moneyNum(args[3])
local teamDataList_PVE=args[5]or{}
local teamDataList_PVP=args[7]or{}
xianjieModel:setJiJieYBDData_teamData(1,teamDataList_PVE[1])
xianjieModel:setJiJieYBDData_teamData(2,teamDataList_PVP[1])
local teamDataList_MJ=args[24]or{}
xianjieModel:setJiJieYBDData_teamData(eYbdType.MoJieYbd,teamDataList_MJ[1])





tianshudazhenModel:onYunZhouSet({args[10],args[11],args[12],args[13],args[14],args[15]})
xianjieModel:setAllow(args[16])
xianjieModel:initZongMenOutPos(args[17],args[18],args[19])
xianjieModel:setMonsterRewardTimes(args[21]or{})
xianjieModel:setJiJieYBDData_moling(args[22])
if systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)and xianjieModel:checkAllCloudUnlockEx()and not xianjieModel:checkJoin()then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.forceEnterXianYu,true)
end
isInit35_1=true
notifySystem:postNotify(notifyConfig.onXianJieDataFreshInit)
notifySystem:postNotify(notifyConfig.onJoinXianYuFlagChange)
end


function xianjieController.recv_protocol_35_2(args)
local len=args[1]
local list=args[2]
local stage=args[3]
local poslistlen=args[4]
local posList=args[5]
local stagelistlen=args[6]
local stagelist=args[7]
local moveTimes=args[8]
local rewardJoinFlag=args[9]
local biaojilen=args[10]
local biaojlist=args[11]
local xmListLen=args[12]
local xmList=args[13]
local xgListLen=args[14]
local xgList=args[15]
local poslistlen2=args[16]
local posList2=args[17]
local lsRewardJoinFlag=args[18]





xianjieModel:initBaseData()
xianjieModel:initAllJiJieData()
xianjieModel:initSelfYuanJunTeamDatas()
xianjieModel:initselfYuanJunTeamDatas_MoJie()
xianjieModel:initselfYuanJunTeamDatas_MoGong()
xianjieModel:initSelfMoJunTeamDatas()
xianjieModel:initSelfDefendXianMengTeamDatas(true)
xianjieModel:initBaseWaiPaiDatas(list)
xianjieController:initRDPosPint(biaojilen,biaojlist)

xianjieModel:setJiJieYBDData_pveCndStage(stage)

xianjieModel:setJiJieYBDData_postLimitList(eYbdType.ZhanZhengYbd,poslistlen,posList)
xianjieModel:setJiJieYBDData_postLimitList(eYbdType.MoJieYbd,poslistlen2,posList2)
xianjieController:setjieshuData(stagelistlen,stagelist)
xianjieModel:setJiJieYBDData_rewardJoinFlag(rewardJoinFlag)
xianjieModel:setJiJieYBDData_lsRewardJoinFlag(lsRewardJoinFlag)
xianjieModel:setJiJieYBDData_rejectedXmXXList(xmListLen,xmList)
xianjieModel:setJiJieYBDData_rejectedXgXXList(xgListLen,xgList)

xianjieModel:setCurCountToday(moveTimes)

if stagelistlen>0 then
notifySystem:postNotify(notifyConfig.onXianJieEntityStageChange,stagelist)
end
end


function xianjieController.recv_protocol_35_3(listen,sceneidx)


mark35_3=nil
if xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
moGongZhengDuoActController:reqUpdateActState(1)
end
if listen==1 then
local old=listenMark
listenMark=sceneidx

if old==nil then return end
if xianjienSceneIndexType:isMoJie(old)then
if not xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieModel:timeoutMapData()
end
elseif xianjienSceneIndexType:isMoGongZhengDuo(old)then
if not xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
xianjieModel:timeoutMapData()
end
elseif xianjienSceneIndexType:isXianYu(old)or old==xianjienSceneIndexType.eXianJie then
if xianjienSceneIndexType:isXianYu(sceneidx)or sceneidx==xianjienSceneIndexType.eXianJie then
return
end
xianjieModel:timeoutMapData()
end
else
xianjieController:clearListenMark()
end
end


function xianjieController.recv_protocol_35_4(args1,args2,args3,args4,args5,args6)

if mark35_3 then return end
local args={}
if args1 then
if type(args1)=='table'then
args=args1
else
args={args1,args2,args3,args4,args5,args6}
end
end
local entitylistlen=args[1]
local entityList=args[2]
local marchlistlen=args[3]
local marchList=args[4]
local jslen=args[5]
local jsarry=args[6]

















local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
local isInit_allXianJie=not xianjieModel:checkIsInitMapData_allXianJie()
if isInit then
xianjieModel:setInitMapData()
xianjieModel:initAllZongMenDatas()
xianjieModel:initAllMonsterDatas()
xianjieModel:initLimitNotOpenMonsterData()
xianjieModel:initAllResourceDatas()
xianjieModel:initAllXianMengDatas()
xianjieModel:initAllStationDatas(isInit_allXianJie)
xianjieModel:initAllMarchTeamDatas()
xianjieModel:initAllYunZhouTeamData()
xianjieModel:initArenaZJTeamDatas(isInit_allXianJie)
xianjieModel:initMoGongZJTeamDatas()
xianjieModel:initMGZDBuildZJTeamDatas()
xianjieModel:initAllMoJunFenShenDatas()
xianjieModel:initAllPuTongZhenJiDatas()
xianjieModel:initAllXJLingShouDatas()
xianjieModel:initAllXJLingShouGroupDatas()
end
if entitylistlen>0 then
local myActorid_str,myGuildid_str
for i,v in ipairs(entityList)do
local entitytype=v.entitytype
local handle=xjServerEnityTypeHandle[entitytype]
local check=handle~=nil
if check then
if entitytype==xjServerEnityType.eActor then
if myActorid_str==nil then
local myActorid=playerModel:getActorID()
myActorid_str=tostring(myActorid)
end
local actorid_str=tostring(v.actorid)
v.actorid_str=actorid_str
v.ismy=actorid_str==myActorid_str
elseif entitytype==xjServerEnityType.eGuild then
if myGuildid_str==nil then
local myGuildid=xianmengModel:myXMGuildID()
if myGuildid then
myGuildid_str=tostring(myGuildid)
else
myGuildid_str=''
end
end
local guildid_str=tostring(v.guildid)
v.guildid_str=guildid_str
v.ismy=guildid_str==myGuildid_str
end

handle(xianjieModel,v,isInit)
else



end
end
end
if marchlistlen>0 then
for i,v in ipairs(marchList)do

local marchtype=v.marchtype
if marchtype==0 or v.list then
if v.list and#v.list>1 then
table.sort(v.list,function(a,b)
return a.param_1<b.param_1
end)
end
local check=marchtype==0 or xjServerMarch2TeamHandleType[marchtype]~=nil
if check then
v.marchguid_str=tostring(v.marchguid)
xianjieModel:refreshMarchTeamData(v,isInit)
else



end
else
local marchguid_str=tostring(v.marchguid)
logErr(FMT.fmt('仙界行军类型{0}，guid为{1}的行军数据中缺少速度参数列表，前端已忽略该行军\n 行军数据：{2}',marchtype,marchguid_str,serializeHelper.serialize(v)))
end
end
end

xianjieModel:dirtyAllMonsterTeamInfoCacheValid()


if isInit then
assert(enterMapMark~=nil)
xianjieController:onEnterMap_listen(enterMapMark[1],enterMapMark[2],false)
enterMapMark=nil

notifySystem:postNotify(notifyConfig.onXianJieMapDataInit)
end

xianjieController:setJiShaData(jslen,jsarry)
end


function xianjieController.recv_protocol_35_10(timeslistlen,timesList)
for i=1,timeslistlen do
local data=timesList[i]
xianjieModel:setMonsterRewardTime(data.param_1,data.param_2)
end
end


function xianjieController.recv_protocol_35_5(occupytype,guid,len,infoList)

if occupytype~=0 then
if occupytype==xjWaiPiaBaseType.eJiJIe or occupytype==xjWaiPiaBaseType.eMarckTeam then
local massguid
if occupytype==xjWaiPiaBaseType.eJiJIe then
massguid=guid
elseif occupytype==xjWaiPiaBaseType.eMarckTeam then

local marchData=xianjieModel:getMarchTeamData(guid)
if marchData and marchData.marchtype==xjServerMarchType.eJiJieJoin then
massguid=marchData.massguid
end
end

local teamData=massguid and xianjieModel:getSelfJiJieTeamData(massguid)or nil
if teamData then
local paramList=teamData and teamData.data and teamData.data.paramList
if paramList and next(paramList)then
local actorId=paramList[2]
if actorId then

xianjieModel:removeJiJieTeamDetail(actorId,massguid)
end
end
end
if massguid then

xianjieController:reqMassTeamList(massguid)
end
end
local isChangeTeamOccupy=len>0
xianjieModel:removeBaseWaiPaiData(occupytype,guid,nil,nil,nil,isChangeTeamOccupy)
end
if len>0 then
for _,info in ipairs(infoList)do
xianjieModel:refreshBaseWaiPaiData(info)
end
end
end

function xianjieController.recv_protocol_35_11(len,arry)
xianjieController:changejieshuData(len,arry)
xianjieController:refreshFilterlookup()
notifySystem:postNotify(notifyConfig.onXianJieEntityStageChange,arry)
end

function xianjieController.recv_protocol_35_27(allow)


xianjieModel:setAllow(allow)
end


function xianjieController.recv_protocol_35_31(sceneidx,x,y,reason)



xianjieController.send_35_31_ing=nil
if reason==0 then
xianjieModel:initZongMenOutPos(sceneidx,x,y)
if not xianjieModel:checkJoin()then
xianjieModel:setJoin()

local sceneidx_=xianjieModel:getXianYuSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx_)
xianjieController:jumpXianJie(sceneType,nil,function()
MojiePreviewExtendController.checkPopWin()
end)
end
xianjieController:deleteAllMarchErrorSoureInfo()
xianjieController:deleteAllMoJunBoxMarchErrorSoureInfo()
else
xianjieModel:changeMyZongMenPos(sceneidx,x,y,reason)
xianjieController:deleteAllMarchErrorSoureInfo()
xianjieController:deleteAllMoJunBoxMarchErrorSoureInfo()
end
notifySystem:postNotify(notifyConfig.onJoinXianYuFlagChange)
end


function xianjieController.recv_protocol_35_32(sceneidx,x,y,reason)





xianjieModel:changeMyZongMenPos(sceneidx,x,y,0)
if reason==0 then
xianjieModel:addCurCountToday()
end
xianjieModel:refreshLeyLineEntity()
end


function xianjieController.recv_protocol_35_35(args)



















local guid=args[1]
local ordertype=args[2]
local boatid=args[3]
local guidlistlen=args[4]
local guidList=args[5]
local moneylistlen=args[6]
local moneyList=args[7]
local params=args[8]
local marchguid=args[9]
local massguid=args[10]
local ret=args[11]
local sceneidx=args[12]
if boatid==0 then
boatid=nil
end
if ret==0 then

if ordertype==xjOrderType.eAttack or ordertype==xjOrderType.eAttackBoss or ordertype==xjOrderType.eAttackRole or
ordertype==xjOrderType.eMoJingZhenJi_Normal or ordertype==xjOrderType.eMoJingZhenJi_Origin or
ordertype==xjOrderType.eDefendXianMeng or ordertype==xjOrderType.eAttackXianMeng or
ordertype==xjOrderType.eMoJunYaoMo or ordertype==xjOrderType.eMoJieBoxCaiJi or ordertype==xjOrderType.eMoJieSGMoster or
ordertype==xjOrderType.eLingShou then
UIManager.info('发起行军成功')
local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)

if ordertype==xjOrderType.eAttackBoss and xianjieModel:isMoJiangBuild_int64(guid)then
local build_id=mathHelper.int64_to_number(guid)
local json=jsonHelper.decode(params)
local seasonType=json[1]
local stageIndex=json[2]
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if entityData then
entityData.fightTimes=entityData.fightTimes+1
else
loggerUtil.logErrFMT("下达指令攻打魔将，未能找到魔将实体，信息:{0}，{1}，{2}",seasonType,stageIndex,build_id)
end


end
elseif ordertype==xjOrderType.eYuanZhu then
UIManager.info('发起援助成功')

local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)
UIManager:invokeUIMethod("UIOthePlayerInfoWin","updateYuanZhuBtn")
elseif ordertype==xjOrderType.eCheHuiYuanZhu then
UIManager.info('撤回援助队伍成功')
local _params=jsonHelper.decode(params)
YingXianGeModel:delZhiYuanData(_params,sceneidx)
UIManager:invokeUIMethod("UIOthePlayerInfoWin","updateYuanZhuBtn")
elseif ordertype==xjOrderType.eStation then
local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)
elseif ordertype==xjOrderType.eJiJieInitiate then

UIManager.info('发起集结成功')

local actorId=playerModel:getActorID()
UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
elseif ordertype==xjOrderType.eJiJieJoin then

UIManager.info('参与集结成功')
local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)
elseif ordertype==xjOrderType.eJiJieKickOut then

local _params=jsonHelper.decode(params)
local actorId=_params and _params[1]and int64.new(_params[1])
local kickActorId=_params and _params[2]and int64.new(_params[2])
if actorId and kickActorId then
local isSelfInitiator=playerModel:checkActorId(actorId)
if playerModel:checkActorId(kickActorId)then

if isSelfInitiator then

UIManager.info('解散集结成功')
else

UIManager.info('退出集结成功')
end

UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","onCloseBtn")
else

if isSelfInitiator then

UIManager.info('已成功踢出玩家')
xianjieModel:setJiJieSelfMassYBDCdStamp(massguid,kickActorId)
end
end
end
elseif ordertype==xjOrderType.eJiJieInvite then
UIManager.info('邀请成功')
local _params=jsonHelper.decode(params)
local actorIdStrList=_params or{}
for i,actorIdStr in ipairs(actorIdStrList)do
local actorId=int64.new(actorIdStr)
xianjieModel:setJiJieSelfMassYBDCdStamp(massguid,actorId)
end
elseif ordertype==xjOrderType.eJiJieTransfer then
UIManager.info('转让先锋成功')



elseif ordertype==xjOrderType.eJiJieChuZheng then

UIManager.info("集结队伍已出发")

UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","onCloseBtn")
elseif ordertype==xjOrderType.eJiJieChangeAuto then

local _params=jsonHelper.decode(params)
local isAutoFlag=_params and _params[1]
local isEndGoFlag=_params and _params[2]
local actorId=playerModel:getActorID()
xianjieModel:setJiJieTeamDetail_autoFlag(actorId,massguid,isAutoFlag)
xianjieModel:setJiJieTeamDetail_endGoFlag(actorId,massguid,isEndGoFlag)

UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","refresh")
UIManager:invokeUIMethod("UIXianJie_JiJie_msgSettingWin","refresh")
elseif ordertype==xjOrderType.eLook then
UIManager.info('发起查看成功')

local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)
elseif ordertype==xjOrderType.eCarryRepair then
UIManager.info('输送材料出发')
local data={
occupytype=xjWaiPiaBaseType.eMarckTeam,
guid=marchguid,
guidlistlen=guidlistlen,
guidList=guidList,
moneylistlen=moneylistlen,
moneyList=moneyList,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshBaseWaiPaiData(data)
end

if boatid and boatid~=0 then

xianjieModel:checkXJYZChuZhenTeamResetYzData(boatid)
XianYunGangModel:setBoatShow(boatid)
end
else

if ret==1 then
return UIManager.error("消耗不足")
elseif ret==2 then
return UIManager.error("目标不存在")
elseif ret==3 or ret==5 then

return UIManager.error("太晚了，集结已完成")
elseif ret==4 then

return UIManager.error("太晚了，集结已出征")
elseif ret==6 then

return UIManager.error("修士数量超过集结上限，参与集结失败")
elseif ret==7 then

return UIManager.error("参与失败，集结已解散")
elseif ret==8 then
return UIManager.error("操作失败，关口情况已改变")
elseif ret==9 then
return UIManager.error("操作失败，目的地不可达，关口禁止通行")
end
end

if xianjieController.send_35_35_sendArgs then
local isPassCheck=true
if xianjieController.send_35_35_sendArgs.checkFunc then
local checkFunc=xianjieController.send_35_35_sendArgs.checkFunc
isPassCheck=checkFunc(guid,ordertype,marchguid,params,massguid,ret)
end

if isPassCheck and xianjieController.send_35_35_sendArgs.callback then
xianjieController.send_35_35_sendArgs.callback(guid,ordertype,marchguid,params,massguid,ret)
xianjieController.send_35_35_sendArgs=nil
end
end
end


function xianjieController.recv_protocol_35_36(marchguid,itemid)



local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData then
UIManager.info('加速成功')
end
end


function xianjieController.recv_protocol_35_41(marchguid)


local teamData=xianjieModel:getMarchTeamData(marchguid)
if teamData then
UIManager.info('召回成功')
end
end


function xianjieController.recv_protocol_35_51(openFlag)
xianjieModel:setJiJieYBDData_openFlag(openFlag)



UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetBgWin","refreshAllMenuOpenState")
UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVEWin","refresh")
UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVPWin","refresh")
UIManager:invokeUIMethod("UIMoJie_JiJie_YBDSetPVEWin","refreshYBDSwitchBtnView")
end


function xianjieController.recv_protocol_35_52(moneyNum,reason)
local jjYBDData=xianjieModel:getJiJieYBDData()
local old=jjYBDData.moneyNum
xianjieModel:setJiJieYBDData_moneyNum(moneyNum)

if reason==1 then
UIManager.info("设置成功")
end



UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVEWin","refresh")
notifySystem:postNotify(notifyConfig.onXianJieYBDMoneyChange,moneyNum,old,reason)
end


function xianjieController.recv_protocol_35_53(stage,rewardJoinFlag,lsRewardJoinFlag)
xianjieModel:setJiJieYBDData_pveCndStage(stage)
xianjieModel:setJiJieYBDData_rewardJoinFlag(rewardJoinFlag)
xianjieModel:setJiJieYBDData_lsRewardJoinFlag(lsRewardJoinFlag)


UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVEWin","refreshPVECndPanel")
UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVEWin","refreshXianXuPanel")
end


function xianjieController.recv_protocol_35_54(ybdType,ybdTeamInfo)


xianjieModel:setJiJieYBDData_teamData(ybdType,ybdTeamInfo)

UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetWin","refresh")
end


function xianjieController.recv_protocol_35_55(rtTYpe,len,list)
xianjieModel:setJiJieYBDListData(len,list)

UIManager:invokeUIMethod("UIXianJie_JiJie_YBDListWin","refresh")
end


function xianjieController.recv_protocol_35_56(rtType,len,list)

xianjieModel:setJiJieYBDData_postLimitList(rtType,len,list)



UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVPWin","refreshPVPCndPanel",true)
end


function xianjieController.recv_protocol_35_57(xmListLen,xmList,xgListLen,xgList)

xianjieModel:setJiJieYBDData_rejectedXmXXList(xmListLen,xmList)
xianjieModel:setJiJieYBDData_rejectedXgXXList(xgListLen,xgList)

UIManager:invokeUIMethod("UIXianJie_JiJie_YBDSetPVEWin","refreshXianXuPanel")
end


function xianjieController.recv_protocol_35_61(len,massTeamList)
xianjieModel:setJiJieSimpleDataList(len,massTeamList,true)
xianjieModel:initJiJieDirtyDataList()


UIManager:invokeUIMethod("UIXianJie_JiJie_teamListMonsterWin","refresh",true)
UIManager:invokeUIMethod("UIXianJie_JiJie_teamListWarWin","refresh",true)


UIManager:invokeUIMethod("UIXianJie_JiJie_teamListBgWin","refreshAllMenuReddot")

UIManager:invokeUIMethod("UIXianJieMainWin","onMassTeamListInitRecv")

UIManager:invokeUIMethod("UIXianJieMainWin","callExtraFunc","onMassTeamListInitRecv")
end


function xianjieController.recv_protocol_35_62(args)
local actorId=args[1]
local guid=args[2]
local infoguid=args[3]
local goSec=args[4]
local autoGo=args[5]
local len=args[6]
local list=args[7]
local max=args[8]
local endGo=args[9]
xianjieModel:refreshJiJieTeamDetail(actorId,guid,goSec,autoGo,len,list,max,endGo,infoguid)


UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","refresh",true)

UIManager:invokeUIMethod("UIXianJie_JiJie_YBDListWin","initMemberActorIdLookup")
UIManager:invokeUIMethod("UIXianJie_JiJie_YBDListWin","refresh",nil,true)


if xianjieController.send_35_62_sendArgs then
if xianjieController.send_35_62_sendArgs.callback then
if list==nil then
UIManager.error("集结已结束")
else
xianjieController.send_35_62_sendArgs.callback(list)
end
end
xianjieController.send_35_62_sendArgs=nil
end
end


function xianjieController.recv_protocol_35_63(infoguid,len,teamInfos)
xianjieModel:saveMonsterTeamInfo(infoguid,teamInfos or{})
end


function xianjieController.recv_protocol_35_64(actorId,massguid,guid,flag)
xianjieModel:setJiJieDirtyData(actorId,massguid,guid,flag)

UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","onMassDetailDataChangeRecv",actorId,massguid)




UIManager:invokeUIMethod("UIXianJieMainWin","onMassDetailDataChangeRecv",actorId,massguid,flag)
UIManager:invokeUIMethod("UIXianJieMainWin","callExtraFunc","onMassDetailDataChangeRecv",actorId,massguid,flag)

end


function xianjieController.recv_protocol_35_90(len,fairylandFixBuild_list)
xianjieModel:clearLeyLineRepairData()

for i=1,len do
local fairylandFixBuild=fairylandFixBuild_list[i]
xianjieController.recv_protocol_35_91(fairylandFixBuild)
end
end


function xianjieController.recv_protocol_35_91(fairylandFixBuild)
if fairylandFixBuild.fix_build_id==xjClientBuildType.flcbXianYuLingMai then
xianjieModel:setLeyLineRepairData(fairylandFixBuild)

local stages=xianjieModel:findLeyLineRepairSeasonStage()
for i,v in ipairs(stages)do
local id=v.handle.id
local index=v.index
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,id,index)

if v:isFinish()then
local nowTime=timeHelper.getServerShortTime()
if v.endTime<=0 or v.endTime>nowTime then
v.endTime=nowTime
end





end

seasonController:handleSeasonStageDataChange(id,index)
end

if xianjieModel:checkLeyLineScene()and xianjieModel:isLeyLineRepairFinish()then
cameraControl.setBeautifyTone(false,-1.05,Color.New(1,0.9732,0.9198,1),0.95,1.05)
xianjieModel:refreshLeyLineEntity()
end
end
end


function xianjieController.recv_protocol_35_92(fix_build_id,stage_rw_flag)
if fix_build_id==xjClientBuildType.flcbXianYuLingMai then
xianjieModel:updateLeyLineRepairFlag(stage_rw_flag)

local stages=xianjieModel:findLeyLineRepairSeasonStage()
for i,v in ipairs(stages)do
local id=v.handle.id
local index=v.index
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,id,index)

seasonController:handleSeasonStageDataChange(id,index)
end
end
end


function xianjieController.recv_protocol_35_12(entitytype,etGuid)
if entitytype==4 or entitytype==16 then

xianjieModel:removeAutoTeam(etGuid)
end
end


function xianjieController:checkShowFuncStorageWin()

if systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)then
return MysteryModel:get_cur_fbid()==nil
end
return false
end

function xianjieController.onNewDay5am()
xianjieModel:onMonsterRewardTimeDayUp(2)
xianjieModel:setCurCountToday_mojie()
xianjieModel:setXianMengMoveTimes()
end

function xianjieController.onNewDay()
xianjieModel:onMonsterRewardTimeDayUp(1)
xianjieModel:resetLeyLineRepairCount()
xianjieModel:onNewDay_huzhu()
xianjieModel:onNewDay_mojiang()
xianjieModel:onNewDay_mojun()
UIManager:invokeUIMethod("UIXianJie_LeyLineInfoWin","refreshRepairCnt")
MojiePreviewExtendController.checkPopFinishWin()
end

function xianjieController.onNewWeek()

end

function xianjieController:showMarchTeamDetailWin(occupytype,guid,extraAttrType,canvas)
local waiPaiData=xianjieModel:getWaiPaiData(occupytype,guid)
local discipleList={}
for i=1,waiPaiData.guidlistlen do
local dzGuid=waiPaiData.guidList[i]
if dzGuid==0 or dzGuid==int64.zero then
table.insert(discipleList,{flag=0})
else
local dzData=UIDiscipleModel:getDiscipleData(dzGuid)
if dzData~=nil then
dzData.flag=i
table.insert(discipleList,dzData)
else
table.insert(discipleList,{flag=0})
end
end
end
local args={
actorid=playerModel:getActorID(),
marchguid=self.marchguid,
isleader=0,
moneylistlen=waiPaiData.moneylistlen,
moneyList=waiPaiData.moneyList,
disciplelistlen=waiPaiData.guidlistlen,
discipleList=discipleList,
}
if not waiPaiData.boatid or waiPaiData.boatid==0 then
args.boatlistlen=0
else
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,waiPaiData.boatid)
if not cfg then
args.boatlistlen=0
else

local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eYZ_Speed,
eAttributeType.ePoZhen,
eAttributeType.eJunSha,
}

local list={}
local yzAttrList=XianYunGangModel:getYunZhouJunZhenAttrsLookup(waiPaiData.boatid)
helper.getAttrRelationShipChange(yzAttrList)
local isJijie=occupytype==xjWaiPiaBaseType.eJiJIe
local yzztdata=YunZhouZhenTuModel:getYZZTJunZhenAttr(discipleList)

local sceneIdx=xianjieModel:getSceneIndex()
for _,attrId in ipairs(attrTypes)do
local attrVal=xianjieModel:getJZAttrLookup(attrId,sceneIdx)or 0
local yzAttrVal=yzAttrList[attrId]or 0
local extraAttrVal=extraAttrType and xianjieModel:getBuffAttribute(extraAttrType,attrId,sceneIdx)or 0
local notJiJieAttrVal=not isJijie and xianjieModel:getBuffAttribute(xjBuffEffectType.eYunZhouAttrJiaChengNotJiJie,attrId,sceneIdx)or 0
local yzztAttrVal=yzztdata[attrId]or 0

local attr={}
attr.param_1=attrId
attr.param_2=attrVal+yzAttrVal+extraAttrVal+notJiJieAttrVal+yzztAttrVal
table.insert(list,attr)
end

local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
local buildName=cfg.name
if bdData and bdData.name then
buildName=bdData.name
end
local boatData=XianYunGangModel:getBoatData(waiPaiData.boatid)
args.boatlistlen=1
args.boatList={
{
boatid=waiPaiData.boatid,
name=buildName,
zq4listlen=boatData.zq4listlen,
zq4List=boatData.zq4List,
zq2listlen=boatData.zq2listlen,
zq2List=boatData.zq2List,
}
}
args.bonuslistlen=#list
args.bonusList=list
end
end
UIManager:showWindow('UIXianJie_marchTeamDetailWin',{list={args},canvas=canvas})
end

function xianjieController:checkInXianJie()
return UIManager:isActive('UIXianJieMainWin')
end

function xianjieController:isPauseUpdateInXianJie()
return mainControl:isInScene(eSceneType.eXianJie)
end

function xianjieController:checkXianJieInit_35_1()
return isInit35_1
end

function xianjieController.onXianMengChange()
xianjieModel:refreshMyXianMengBuoy()
xianjieController.onXianMengChange_mojieGate()
end

function xianjieController.onLimitActStateChange(actID,state)
if actID==LIMIT_ACT_TYPE.eMoJiang then
xianjieModel:refreshAllMoJiangEntity()
elseif actID==LIMIT_ACT_TYPE.eMoJieSaiJi then
if state==limitActivitiesModel.actFinishState then
xianjieController:send_35_149()
end
end
end

function xianjieController.onSeasonChange()
xianjieModel:refreshAllMoJiangStage()
xianjieController:refreshFilterlookup()
xianjieController.onSeasonChange_MoJie_Fog()
xianjieModel:refreshMoJiangDefaultData()
xianjieModel:getFilterHUD2Record(true)
xianjieController:getFilterEntity2DCfg(true)
end

function xianjieController.onSeasonStageChange(season_id,chapter_idx)
xianjieController:refreshFilterlookup()
xianjieController.onSeasonStageChange_MoJie_Fog(season_id,chapter_idx)
xianjieController.onSeasonStageChange_MoJie_MoJun(season_id,chapter_idx)
end

function xianjieController.onMoJieSeasonFogDissipate(season_id,chapter_idx,stageFogId)
xianjieModel:refreshMoJiangDefaultData(season_id)
xianjieModel:updateRefreshMonsterData(season_id,chapter_idx,stageFogId)
xianjieModel:refreshBenYuanZhenJiDatas(season_id,chapter_idx)
xianjieModel:refreshAllZhenTaiEntity()
end

function xianjieController.onZongMengLevelChange()
xianjieModel:updateLimitNotOpenMonsterData()
end
