






local _MODULENAME="moGongZhengDuoActController"

gameState.addListener(def_table(_MODULENAME))
moGongZhengDuoActController.name=_MODULENAME
moGongZhengDuoActController.data={}

local checkActAutoOpenWin=function()
if xianjieController:isShowSideWin()then

return
end

local isOpened=moGongZhengDuoActModel:checkIsXJArenaActOpened()
local isOpenAct=moGongZhengDuoActModel:checkIsXJArenaActDoing()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
if isOpened and isOpen and not isOpenAct then
local list=moGongZhengDuoActModel:getArenaBuildList()

if list==nil or next(list)==nil then
moGongZhengDuoActController:reqMoGongActData({callback=function()
local winShowFlag=moGongZhengDuoActModel:getArenaRewardWinShowFlag()
local isCanRecv=moGongZhengDuoActModel:checkIsCanGetArenaReward()
if winShowFlag==0 or isCanRecv then
msgWinControl:addMsgWin(msgWinType.eMGZDSettlement,nil,nil,true)
end
end})
return
end

local winShowFlag=moGongZhengDuoActModel:getArenaRewardWinShowFlag()
local isCanRecv=moGongZhengDuoActModel:checkIsCanGetArenaReward()
if winShowFlag==0 or isCanRecv then
msgWinControl:addMsgWin(msgWinType.eMGZDSettlement,nil,nil,true)
end
end
end


function moGongZhengDuoActController:onAppStart()

moGongZhengDuoActModel:onAppStart()


socketManager:register_receiver(35,116,moGongZhengDuoActController.recv_35_116)
socketManager:register_receiver(35,117,moGongZhengDuoActController.recv_35_117)
socketManager:register_receiver(35,115,moGongZhengDuoActController.recv_35_115)
socketManager:register_receiver(35,118,moGongZhengDuoActController.recv_35_118)
socketManager:register_receiver(35,119,moGongZhengDuoActController.recv_35_119)
socketManager:register_receiver(35,120,moGongZhengDuoActController.recv_35_120)
socketManager:register_receiver(35,121,moGongZhengDuoActController.recv_35_121)
socketManager:register_receiver(35,122,moGongZhengDuoActController.recv_35_122)
socketManager:register_receiver(35,123,moGongZhengDuoActController.recv_35_123)
socketManager:register_receiver(35,124,moGongZhengDuoActController.recv_35_124)
socketManager:register_receiver(35,125,moGongZhengDuoActController.recv_35_125)
socketManager:register_receiver(35,127,moGongZhengDuoActController.recv_35_127)
socketManager:register_receiver(35,128,moGongZhengDuoActController.recv_35_128)
socketManager:register_receiver(35,129,moGongZhengDuoActController.recv_35_129)














































end


function moGongZhengDuoActController:onEnterState(isReconnect)
moGongZhengDuoActModel:onEnterState()

notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)

notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.showPrize)
end


function moGongZhengDuoActController:onProtocolReq()
end

function moGongZhengDuoActController:onProtocolReqLargeXJKF()
moGongZhengDuoActModel:onProtocolReq()

end


function moGongZhengDuoActController:onLeaveState(isReconnect)
moGongZhengDuoActModel:onLeaveState(isReconnect)

self.data={}

moGongZhengDuoActController:clearSettlementTimer()
moGongZhengDuoActController:stopLimitActTimer()

notifySystem:removelistener(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:removelistener(notifyConfig.leaveXianJie,self.onLeaveXianJie)

notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onShowPrize,self.showPrize)
end


function moGongZhengDuoActController:onLostConnection()

end


function moGongZhengDuoActController:onReConnection(isInitPro)

end


function moGongZhengDuoActController:onOpenView(isReconnect)

local actInSceneFlag=moGongZhengDuoActModel:getActInSceneFlag()
if actInSceneFlag~=1 then return end


local isActDoing=moGongZhengDuoActModel:checkIsXJArenaActDoing()
if not isActDoing then return end

local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx and xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then return end


timeEventController.delayDo(0.5,function()
local actInSceneFlag2=moGongZhengDuoActModel:getActInSceneFlag()
if actInSceneFlag2~=1 then return end

local sceneIdx2=xianjieModel:getSceneIndex()
if sceneIdx2 and xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx2)then return end

xianjieController:jumpXianJie(xianjienSceneType.eMoGongZhengDuo)
end,true)
end


function moGongZhengDuoActController.onEnterXianJie(sceneType)
if xianjienSceneType:isMoGongZhengDuo(sceneType)then

local isOpenedAct=moGongZhengDuoActModel:checkIsXJArenaActOpened()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
if isOpenedAct and isOpen then

moGongZhengDuoActController:createArenaBuild(true)
moGongZhengDuoActController:checkCreateClientBuild()
end

moGongZhengDuoActController:initLimitAct()
elseif xianjienSceneType:isMoJie(sceneType)then
checkActAutoOpenWin()
xianjieModel:clearData_allMGZDClientBuild()
else
xianjieModel:clearData_allMGZDClientBuild()
end
end

function moGongZhengDuoActController.onLeaveXianJie(sceneType)

xianjieModel:clearData_allMGZDClientBuild()
end

function moGongZhengDuoActController.onLimitActStateChange(actID,actState)
local flag=actID==LIMIT_ACT_TYPE.eMoGongZhengDuo
if not flag then
return
end

if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actState==limitActivitiesModel.actDoingState then
moGongZhengDuoActModel:setArenaRewardGotFlag(0)
moGongZhengDuoActModel:setArenaRewardWinShowFlag(0)
moGongZhengDuoActModel:resetAllArenaOccupyData()

elseif actState==limitActivitiesModel.actFinishState then
moGongZhengDuoActModel:setArenaRewardWinShowFlag(0)
local sceneType=xianjieModel:getScenceType()
if sceneType and xianjienSceneType:isMoJie(sceneType)then
checkActAutoOpenWin()
end
end

moGongZhengDuoActController:resetAllArenaHud()
end
end

function moGongZhengDuoActController.onLimitActOpen(actID,flag)
local actFlag=actID==LIMIT_ACT_TYPE.eMoGongZhengDuo
if actFlag and flag then
moGongZhengDuoActController:checkCreateArenaBuild(true)
end
end

function moGongZhengDuoActController.showPrize(prizeType,rewards_,effectData)
if prizeType==ePrizeType.eMoGongZhengDuo then

local arenaCount=effectData.len or 1
if arenaCount>0 then
local tempLookup={}
local occupyRewardBuffShowList=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"occupyRewardBuffShow")or{}
local buffItemList=occupyRewardBuffShowList[arenaCount]
if buffItemList and next(buffItemList)then
for _,itemId in ipairs(buffItemList)do
showPrizeControl.insertCommon(rewards_,tempLookup,nil,itemId,1,false)
end
end
showPrizeControl.showWindow(rewards_,nil)
end
end
end




function moGongZhengDuoActController:resetAllArenaHud()
self:resetArenaHudById(xjClientBuildType.flcbMoGong1)
end

function moGongZhengDuoActController:checkCreateArenaBuild(isInit)

local isOpenedAct=moGongZhengDuoActModel:checkIsXJArenaActOpened()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
if isOpenedAct and isOpen then
moGongZhengDuoActController:createArenaBuild(isInit)
end
end

function moGongZhengDuoActController:createArenaBuild(isInitMap)

local arenaList=moGongZhengDuoActModel:getArenaBuildList()

if arenaList then
local createNum=0
for i,v in pairs(arenaList)do
local arenaId=v.buildId
local ret=xianjieModel:createMoGongData(arenaId)
createNum=createNum+1
end
if createNum>0 then
xianjieModel:createAllMoGongEntities()
end
elseif isInitMap then

moGongZhengDuoActController:reqMoGongActData()
end
end

function moGongZhengDuoActController:checkCreateClientBuild()
if not moGongZhengDuoActModel:checkInActScene()then return end
local allbuffBuildCfg=cfg_mogongyibanjianzhugeconfig()

for buildID,buildCfg in pairs(allbuffBuildCfg)do
local dataType=xianjieModel:getMGZDBuildCfgByBuildID(buildID,'clientParam','buffBuildDataType')


xianjieModel:createMGZDClientBuildData(buildID,dataType)
end
end

function moGongZhengDuoActController:clearArenaBuild()
xianjieModel:clearData_allMoGong()
end

function moGongZhengDuoActController:resetArenaHudById(arenaId)

local arenaEntData=xianjieModel:getMoGongDataByMoGongId(arenaId)
if not arenaEntData then
return
end


local arenaEnt=xianjieController:getEntity(arenaEntData.ent_key)
if not arenaEnt then
return
end


local arenaHud=arenaEnt:getHud()
if not arenaHud then
return
end


if arenaHud.resetShow~=nil then
arenaHud:resetShow()
end
end


function moGongZhengDuoActController:reqXJArenaUpdateDataDelay(delaTime)
self:clearDelayTimer()
self.delayTimer=timer.new()
delaTime=delaTime or 5
self.delayTimer:start(delaTime,function()
return moGongZhengDuoActController:reqMoGongActData()
end,1)
end


function moGongZhengDuoActController:clearDelayTimer()
if self.delayTimer then
self.delayTimer:cancel()
self.delayTimer=nil
end
end


function moGongZhengDuoActController:checkActIsInSettlement()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
local delayTime=0
if actInfo then
local nowTime=timeHelper.getServerShortTime()
local settlementTime=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"delaySettlementTime")
local isInSettlement=false
if actInfo.pre_end_time then

if nowTime>=actInfo.pre_end_time and nowTime<actInfo.pre_end_time+settlementTime then
isInSettlement=true
delayTime=actInfo.pre_end_time+settlementTime-nowTime
end
end

if not isInSettlement and actInfo.end_time then

if nowTime>=actInfo.end_time and nowTime<actInfo.end_time+settlementTime then
isInSettlement=true
delayTime=actInfo.end_time+settlementTime-nowTime
end
end

return isInSettlement,delayTime
else

return false,delayTime
end
end

function moGongZhengDuoActController:openArenaInfoWin(arenaId,openPageIndex,param)
arenaId=arenaId or xjClientBuildType.flcbMoGong1
local winParams={arenaId=arenaId,openSelectMenuIndex=openPageIndex}


local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
local arenaData=xianjieModel:getMoGongDataByMoGongId(arenaId)

if not arenaData then
logErr(FMT.fmt("擂台数据为空 擂台id={0}",arenaId))
return
end
winParams.lookAtPos=arenaData:getWorldPos()
end
local isDoing=moGongZhengDuoActModel:checkIsXJArenaActDoing()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
local isInMGZDScene=xianjienSceneIndexType:isMoGongZhengDuo(xianjieModel:getSceneIndex())

if isOpen and isDoing and isInMGZDScene then
xianjieController:openWin('UIMoGongZhengDuoAct_infoWin',winParams)
else
xianjieController:openWin('UIMoGongZhengDuoAct_buffWin',winParams)
end
end





function moGongZhengDuoActController:reqGetMoGongZhuJunDzList(massActorid,massGuid,buildId,sendArgs)
moGongZhengDuoActController.send_35_115_sendArgs=sendArgs

socketManager:send_35_115(massActorid,massGuid,buildId)
end


function moGongZhengDuoActController:reqMoGongActData(sendArgs)
moGongZhengDuoActController.send_35_116_sendArgs=sendArgs


socketManager:send_35_116()
end


function moGongZhengDuoActController:reqGetMoGongZhuJunRetract(arenaId,guid)
socketManager:send_35_117(arenaId,guid)
end


function moGongZhengDuoActController:reqGetMoGongActData_arenaInfo(arenaId)
socketManager:send_35_118(arenaId)
end


function moGongZhengDuoActController:reqMoGongRankList(rankType)
if rankType==MGZD_RANK_TYPE.ePersonRank then
socketManager:send_35_119()
elseif rankType==MGZD_RANK_TYPE.eXianMengRank then
socketManager:send_35_121()
elseif rankType==MGZD_RANK_TYPE.eZhanYunRank then
socketManager:send_35_120()
end
end


function moGongZhengDuoActController:reqMoGongActOccupyReward()
socketManager:send_35_122()
end


function moGongZhengDuoActController:reqMoGongSetRewardWinShowFlag(flag)
socketManager:send_35_124(flag)
end


function moGongZhengDuoActController:reqMoGongAllTeamList()
socketManager:send_35_125()
end



function moGongZhengDuoActController:reqUpdateActState(inSceneFlag,callback)

moGongZhengDuoActController.updateActStateCallback=callback

socketManager:send_35_127(inSceneFlag)
end






function moGongZhengDuoActController.recv_35_116(args)

local len,list,jsrwFlag,dlgFlag,lastMoveTime,buildZLLen,buildZLInfo=unpack(args)

moGongZhengDuoActModel:setArenaBuildList(len,list)
moGongZhengDuoActModel:setArenaRewardGotFlag(jsrwFlag)
moGongZhengDuoActModel:setArenaRewardWinShowFlag(dlgFlag)
moGongZhengDuoActController:checkCreateArenaBuild()
moGongZhengDuoActModel:setMoveZongMenCD(lastMoveTime)
xianjieModel:setMGZDBuildServerDataList(buildZLLen,buildZLInfo)

UIManager:invokeUIMethod("UIMoGongZhengDuoAct_OccupyWin","refresh",true)
UIManager:invokeUIMethod("UIMoGongZhengDuoAct_SettlementWin","refreshAll",true)



UIManager:invokeUIMethod("UIMoGongZhengDuoAct_rankBgWin","refreshAllMenuReddot")

moGongZhengDuoActController:resetAllArenaHud()


local isInSettlement,delaySettleTime=moGongZhengDuoActController:checkActIsInSettlement()
if isInSettlement and delaySettleTime>0 then

moGongZhengDuoActController:reqXJArenaUpdateDataDelay(delaySettleTime)
end

if moGongZhengDuoActController.send_35_116_sendArgs then
if moGongZhengDuoActController.send_35_116_sendArgs.callback then
moGongZhengDuoActController.send_35_116_sendArgs.callback(list)
end
moGongZhengDuoActController.send_35_116_sendArgs=nil
end
end




function moGongZhengDuoActController.recv_35_117(buildId,guid)
UIManager.info("撤离驻军成功")
end







function moGongZhengDuoActController.recv_35_115(massActorid,massGuid,len,dzList,buildId)
moGongZhengDuoActModel:setArenaZhuJunDzList(massActorid,massGuid,len,dzList,buildId)
if moGongZhengDuoActController.send_35_115_sendArgs then
if moGongZhengDuoActController.send_35_115_sendArgs.callback then
moGongZhengDuoActController.send_35_115_sendArgs.callback(massActorid,massGuid,len,dzList)
end
moGongZhengDuoActController.send_35_115_sendArgs=nil
end

end







function moGongZhengDuoActController.recv_35_118(buildId,len,logList,len2,zjList)
moGongZhengDuoActModel:setArenaLogList(buildId,len,logList)
moGongZhengDuoActModel:setArenaZhuJunList(buildId,len2,zjList)


UIManager:invokeUIMethod("UIMoGongZhengDuoAct_infoWin","refresh",true)
UIManager:invokeUIMethod("UIMoGongZhengDuoAct_buffInfoWin","refresh",true)
end





function moGongZhengDuoActController.recv_35_119(len,rankList,myZhanJi)
moGongZhengDuoActModel:setArenaRankList(LTYW_Rank_Type.ePersonRank,len,rankList)
moGongZhengDuoActModel:setArenaSelfRankValue(LTYW_Rank_Type.ePersonRank,myZhanJi)


UIManager:invokeUIMethod("UIMoGongZhengDuoAct_rankPersonWin","refresh",true)
end





function moGongZhengDuoActController.recv_35_120(len,rankList,myZhanSun)
moGongZhengDuoActModel:setArenaRankList(LTYW_Rank_Type.eZhanYunRank,len,rankList)
moGongZhengDuoActModel:setArenaSelfRankValue(LTYW_Rank_Type.eZhanYunRank,myZhanSun)


UIManager:invokeUIMethod("UIMoGongZhengDuoAct_rankZhanYunWin","refresh",true)
end





function moGongZhengDuoActController.recv_35_121(len,rankList,myGuildZhanJi)
moGongZhengDuoActModel:setArenaRankList(LTYW_Rank_Type.eXianMengRank,len,rankList)
moGongZhengDuoActModel:setArenaSelfRankValue(LTYW_Rank_Type.eXianMengRank,myGuildZhanJi)


UIManager:invokeUIMethod("UIMoGongZhengDuoAct_rankXMWin","refresh",true)
end

function moGongZhengDuoActController.recv_35_122(flag)
moGongZhengDuoActModel:setArenaRewardGotFlag(flag)
moGongZhengDuoActController.showPrize(ePrizeType.eMoGongZhengDuo,{},{len=1})
UIManager:invokeUIMethod('UIMoGongZhengDuoAct_SettlementWin','refreshAll')
end



function moGongZhengDuoActController.recv_35_123(mgLen,moGongDatas,buffLen,buffDatas)
if mgLen>0 then
for index=1,mgLen do
local data=moGongDatas[index]
local buildId=data.buildId
moGongZhengDuoActModel:setArenaBuildDataByArenaId(buildId,data)

UIManager:invokeUIMethod("UIMoGongZhengDuoAct_infoWin","refresh",true)
end
moGongZhengDuoActController:resetAllArenaHud()
elseif buffLen>0 then
for index=1,buffLen do
local data=buffDatas[index]
xianjieModel:setMGZDBuildServerData(data)

UIManager:invokeUIMethod("UIMoGongZhengDuoAct_buffInfoWin","refresh",true)
end
end
end




function moGongZhengDuoActController.recv_35_124(args)
moGongZhengDuoActModel:setArenaRewardGotFlag(args[1])
moGongZhengDuoActModel:setArenaRewardWinShowFlag(args[2])
moGongZhengDuoActModel:setActSceneEnterFlag(args[3])
moGongZhengDuoActModel:setActInSceneFlag(args[4])
moGongZhengDuoActModel:setMoveZongMenCD(args[5])
moGongZhengDuoActModel:setServerUpdated(args[6])
moGongZhengDuoActModel:setLastExitTime(args[7])





end




function moGongZhengDuoActController.recv_35_125(len,list,len2,list2)
moGongZhengDuoActModel:setAllArenaMassDataList(len,list,len2,list2)

UIManager:invokeUIMethod("UIMoGongZhengDuoAct_ovTeamWin","refresh")
end



function moGongZhengDuoActController.recv_35_127(inSceneFlag,lastExitTime)
moGongZhengDuoActModel:setActInSceneFlag(inSceneFlag)
moGongZhengDuoActModel:setLastExitTime(lastExitTime)

if moGongZhengDuoActController.updateActStateCallback then
moGongZhengDuoActController.updateActStateCallback()
end

end



function moGongZhengDuoActController.recv_35_128()
local showCallBack=function()
msgWinControl:addMsgWin(msgWinType.eMGZDSettlement,nil,nil,true)
end

local returnCallBack=function()
timeEventController.delayDo(1,function()
local type=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(type,{isSkipChangeSceneCheck=true},showCallBack)
end,true)
end
local callBack=function()
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eXianJie then
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
UIManager:showWindow("UIMoGongZhengDuoAct_FinishLeftWin",{callback=returnCallBack})
elseif xianjienSceneIndexType:isMoJie(sceneIdx)then
showCallBack()
end
end
end

local endLeftShowTime=moGongZhengDuoActModel:getBaseConfig("emdLeftShowTime")
timeEventController.delayDo(endLeftShowTime,callBack,true)
end

function moGongZhengDuoActController.recv_35_129(flag)
moGongZhengDuoActModel:setServerUpdated(flag)
end


function moGongZhengDuoActController:stopLimitActTimer()
if self.limitActTimer then
self.limitActTimer:cancel()
self.limitActTimer=nil
end
end

function moGongZhengDuoActController:initLimitAct()
moGongZhengDuoActController:stopLimitActTimer()
local isOpenedAct=moGongZhengDuoActModel:checkIsXJArenaActOpened()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()

if not(isOpenedAct and isOpen)then return end

local actHandle=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if actHandle==nil then return end

local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx==nil then return end
local isInMoGong=xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)
local isInMoJie=xianjienSceneIndexType:isMoJie(sceneIdx)
if not(isInMoGong or isInMoJie)then return end

if self.settlementTimer then return end

local curTime=timeHelper.getServerShortTime()
local entTime=actHandle.end_time

local endLeftShowTime=moGongZhengDuoActModel:getBaseConfig("emdLeftShowTime")
local leftTime=entTime-curTime-endLeftShowTime

local showCallBack=function()

msgWinControl:addMsgWin(msgWinType.eMGZDSettlement,nil,nil,true)
moGongZhengDuoActController:clearSettlementTimer()
end

local returnCallBack=function()
timeEventController.delayDo(1,function()
local type=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(type,{isSkipChangeSceneCheck=true},showCallBack)
end,true)
end

local callBack=function()
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eXianJie then
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
xianjieController:closeWin3()
UIManager:showWindow("UIMoGongZhengDuoAct_FinishLeftWin",{
settlementTime=entTime,
callback=returnCallBack
})
elseif xianjienSceneIndexType:isMoJie(sceneIdx)then
showCallBack()
end
end
end


if leftTime>0 then

self.settlementTimer=timeEventController.delayDo(leftTime,callBack,true)
else
callBack()
end
end

function moGongZhengDuoActController:clearSettlementTimer()
if self.settlementTimer then
self.settlementTimer:cancel()
self.settlementTimer=nil
end
end





function moGongZhengDuoActController.printLimitActCheckInfo()
local curTime=timeHelper.getServerShortTime()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if actInfo then
actInfo:printInfo()
logErr("活动开启 - ",actInfo:checkOpen())
logErr("活动待机 - ",actInfo:checkIdle())
logErr("活动预告 - ",actInfo:checkPreview())
logErr("活动进行 - ",actInfo:checkDoing())
logErr("活动结束 - ",actInfo:checkFinish())
local result,tips=actInfo:checkCondition()
logErr("活动条件 - ",result,tips)
local enterInfo=xianjieModel:getMoJieEnterData()
if enterInfo then
logErr("当前时间：",timeHelper.getFormatByShortStamp2(curTime))
logErr("赛季开启时间：",timeHelper.getFormatByShortStamp2(enterInfo.sTime))
logErr("时间间隔：",timeHelper.format_time_stamp4(curTime-enterInfo.sTime))
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterInfo.sId)
local seasonHandle=seasonModel:getHandle(cfg.csid)
if seasonHandle then
local stages=seasonHandle:getStages()
for index,stage in ipairs(stages)do
logErr("-------------------------------------")
logErr("索引-类型:",index,stage.type)
logErr("阶段开启时间：",timeHelper.getFormatByShortStamp2(stage.beginTime))
logErr("阶段结束时间：",timeHelper.getFormatByShortStamp2(stage.endTime))
logErr("时间间隔：",timeHelper.format_time_stamp4(curTime-enterInfo.beginTime))
end
else
logErr("缺少魔界赛季玩法数据",cfg.csid)
end
else
logErr("缺少魔界赛季入口数据")
end

else
logErr("活动未开启")
end
end

function moGongZhengDuoActController.printMoGongOcctemp()
local buildData=moGongZhengDuoActModel:getArenaBuildData(-31)
local nowTime=timeHelper.getServerShortTime()
logErr("当前占领仙盟：",buildData.xmName)
logErr("占领时间戳：",timeHelper.getFormatByShortStamp2(buildData.occupyStartTime))
local interval=nowTime-buildData.occupyStartTime
logErr("当前占领时长：",interval,timeHelper.format_time_stamp4(interval))
logErr("历史列表：")
for index,data in ipairs(buildData.occupyHis)do
logErr(data.xmName,data.occupyTime,timeHelper.format_time_stamp4(data.occupyTime))
end
end
