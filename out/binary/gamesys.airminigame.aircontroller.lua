airController=gameState.addListener({})


local _isEnter=false

local _controls=
{
airMapSystem,airEntitySystem,airActorSystem,airLevelSystem,
airSkillSystem,airBuffSystem,airHUDSystem,airDropSystem
}
local _data={}
local _maxWaitingRecvStamp=300
local _cacheSceneId
local _reqFunc={
[2]=function(data)
return airController:reqEnterFb(unpack(data))
end,
[3]=function(data)
return airController:reqFbSettlement(unpack(data))
end,
[4]=function(data)
return airController:reqSaveFbProcessData(unpack(data))
end,
[5]=function(data)
return airController:reqRefreshSettlementData(unpack(data))
end,
[6]=function(data)
return airController:reqRestartGame(unpack(data))
end,
[13]=function(data)
return airController:reqReviveActor()
end,
}

function airController:onAppStart()
socketManager:register_receiver(36,1,airController.recv_36_1)
socketManager:register_receiver(36,2,airController.recv_36_2)
socketManager:register_receiver(36,3,airController.recv_36_3)
socketManager:register_receiver(36,4,airController.recv_36_4)
socketManager:register_receiver(36,5,airController.recv_36_5)
socketManager:register_receiver(36,6,airController.recv_36_6)
socketManager:register_receiver(36,12,airController.recv_36_12)
socketManager:register_receiver(36,13,airController.recv_36_13)

if not airController:api_Available()then return end

local sceneData={
enter=function(o,...)
airController:onEnterAirGame()
end,

leave=function(o,...)
airController:onLeaveAirGame()
end,
load=function(o,...)
airController:onLoadScene(...)
end,
}
mainControl:regSceneTypo(eSceneType.eAirGame,sceneData)

airController:postControl('onAppStart')
end

function airController:onEnterState(isReconnect)
self.waitingRecvStamp=nil
self.isOnlyRefreshWin=nil
self.isNeedRefreshData=nil
self.refreshDataType=nil
self.refreshIndex=nil
self.isShowFinishAnimWinFlag=nil
self.waitingReqList={}
self.runningDuration=0
self.startRunningTime=0
if not airController:api_Available()then return end
airController:postControl('onEnterState',isReconnect)

notifySystem:listenNotify(notifyConfig.onShowPrize,airController.onShowPrize)

if isReconnect then
if mainControl:isInScene(eSceneType.eAirGame)then

airController:onEnterAirGame(isReconnect)
if _cacheSceneId then
self.sceneId=_cacheSceneId
end
end
end
end

function airController:onLeaveState(isReconnect)
self.waitingRecvStamp=nil
self.isOnlyRefreshWin=nil
self.isNeedRefreshData=nil
self.refreshDataType=nil
self.refreshIndex=nil
self.isShowFinishAnimWinFlag=nil
self.waitingReqList={}
self.runningDuration=0
self.startRunningTime=0
if not airController:api_Available()then return end


UIFullAirMiniGameControl:closeActiveUI()
UIFullAirMiniGameControl:closeAllWindow()

airController:onLeaveAirGame(isReconnect)
airController:postControl('onLeaveState',isReconnect)
airModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.onShowPrize,airController.onShowPrize)
end

function airController:onProtocolReq(isReconnect)
if not airController:api_Available()then return end
airController:postControl('onProtocolReq',isReconnect)
end

function airController:onUpdate()
local nowTime=airController:getRealServerTime_short()
if not self.waitingRecvStamp or nowTime>self.waitingRecvStamp+_maxWaitingRecvStamp then

self:checkReqList()
end

if self.isPause then return end
self:checkRunningTime()
airController:postControl('onUpdate')
airSkillSystem:onUpdateDamage()
end

function airController:onFastUpdate()
if self.isPause then return end
airController:postControl('onFastUpdate')
end

function airController:onEnterAirGame(isReconnect)
if _isEnter then return end
_isEnter=true

shaderHelper.enableCurvedWorld(true)
shaderHelper.setCurveWorldBend(Vector4.New(-4,0,-6,0))
self.isPause=false





UIManager:showWindow('UIAirMiniGameHUDWin')
airController:postControl('enterAirGame')
if not isReconnect then
airActorSystem:createActor()
end
airController:addTimer()
mainViewsControl:changeMain(true)
sceneControl:closeLoading(1,function()

if _isEnter then
timer.pauseAll(true)
airController:startSelfTimerFunc()
end
end)

UIManager.disableAllTips()

buildlightController:setBLState(false)
end

function airController:onLeaveAirGame(isReconnect)
if not _isEnter then return end
self.isPause=nil
_isEnter=false
if isReconnect then
_cacheSceneId=self.sceneId
else
_cacheSceneId=nil
end
self.sceneId=nil
shaderHelper.enableCurvedWorld(false)
airController:removeTimer()
timer.pauseAll(false)
airController:postControl('leaveAirGame')
UIManager:closeWindow('UIAirMiniGameHUDWin')
self.mapWinlua=nil
UIManager.enableAllTips()
buildlightController:setBLState(true)
end

function airController:openMain()
UIManager:showWindow('UIAirMiniGameMainWin')
return true
end

function airController:closeMain()
UIManager:closeWindow('UIAirMiniGameMainWin')
end

function airController:onAppPause()

local isStart=airLevelSystem:isLevelDoing()
if isStart then
airController:pauseGame(true)
if not UIManager:isActive("UIAirMiniGame_pauseWin")and not UIManager:isActive("UIAirMiniGame_reviveWin")then

UIFullAirMiniGameControl:showPauseWin()
end
end
end

function airController:onLostConnection()

self:onAppPause()
end


function airController:onLoadScene(sceneId)
sceneControl:startLoading({sceneId=sceneId,closeLoading=false})
self.sceneId=sceneId
end


function airController:isEnterGame()
return _isEnter
end

function airController:api_Available()
return deviceHelper.getAPILevel()>=110
end

function airController:postControl(funcname,...)
for i,v in ipairs(_controls)do
if v[funcname]then
v[funcname](v,...)
end
end
end

function airController.getManagerInstance()
if not airController:api_Available()then return end
return AIR.AirEntityManager.GetInstance()
end

function airController.getManagerStatic()
if not airController:api_Available()then return end
return AIR.AirEntityManager
end

function airController.getManagerStaticAuto()
if not airController:api_Available()then return end
return AIR.AirEntityManagerEx
end

function airController.getMapManager()
if not airController:api_Available()then return end
return AIR.AirMapManager.GetInstance()
end

function airController.getDefineStatic()
if not airController:api_Available()then return end
return AIR.EntityDefines
end

function airController.getHUDManager()
if not airController:api_Available()then return end
return AIR.AirHUDManager.GetInstance()
end

function airController:addTimer()

local map=GameObject.Find('map')
self.mapWinlua=CS.UIHelper.GetWindowLua(map)

if self.tickTimer==nil then

local tick=function()
airController:onUpdate()
end

self.tickTimer=self.mapWinlua:StartTimer(0.1,0,tick)
end

if self.fastTickTimer==nil then
local tick1=function()
airController:onFastUpdate()
end

self.fastTickTimer=self.mapWinlua:StartTimer(0,0,tick1)
end
end

function airController:removeTimer()
if self.tickTimer then
self.mapWinlua:StopTimer(self.tickTimer)
self.tickTimer=nil
end

if self.fastTickTimer then
self.mapWinlua:StopTimer(self.fastTickTimer)
self.fastTickTimer=nil
end

airController:stopSelfTimerFunc()
end


function airController:pauseGame(flag)
self.isPause=flag








airEntitySystem:pauseAllEntitys(flag)

UIManager:callWindowFunc('UIAirMiniGameMainWin','onPause',flag)
end

function airController:isPauseGame()
return self.isPause
end

function airController:checkRunningTime()
local nowTime=Time.realtimeSinceStartup
self.lastRunningStamp=self.curRunningStamp or nowTime
self.curRunningStamp=nowTime
local deltaTime=self.curRunningStamp-self.lastRunningStamp
local lastDaltaTime=self.tmpDeltaRunningTime or 999
if lastDaltaTime then
if deltaTime-lastDaltaTime<=0.2 then

self.runningDuration=self.runningDuration+deltaTime
end
end
self.tmpDeltaRunningTime=deltaTime
end

function airController:resetRunningTime()
self.runningDuration=0
self.tmpDeltaRunningTime=nil
self.startRunningTime=Time.realtimeSinceStartup
end

function airController:getRunningDuration()
return self.runningDuration
end

function airController:getStartRunningTime()
return self.startRunningTime
end

function airController:addReqListItem(reqId,reqData)
table.insert(self.waitingReqList,{reqId,reqData})
end

function airController:checkReqList()
if self.isCheckingReqList then
return
end
self.isCheckingReqList=true
if self.waitingReqList and next(self.waitingReqList)then
local reqItem=table.remove(self.waitingReqList,1)
local reqId=reqItem[1]
local reqData=reqItem[2]
local reqFunc=_reqFunc[reqId]
if reqFunc then
reqFunc(reqData)
end
end
self.isCheckingReqList=nil
end

function airController:clearAllReqList()
self.waitingReqList={}
end



function airController:reqEnterFb(fbId)
socketManager:send_36_2(fbId)
end


function airController:reqFbSettlement(resultFlag,isHidePrize)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

airController:addReqListItem(3,{resultFlag,isHidePrize})
return
end

self.waitingRecvStamp=airController:getRealServerTime_short()

self.isOnlyRefreshWin=true
airController:reqSaveFbProcessData()

local paramsList={}
if resultFlag==1 then


local allDmg=airModel:getStatisticData_getAllDmg()
paramsList[1]={allDmg}

local killMonsterCount=airModel:getStatisticData_getKillMonsterCount()
paramsList[2]={killMonsterCount}

local killBossCount=airModel:getStatisticData_getKillBossCount()
paramsList[3]={killBossCount}

local gotExpCount=airModel:getStatisticData_getGotExpCount()
paramsList[4]={gotExpCount}


local equipList=airModel:getEquipList()
paramsList[5]=equipList
end

local paramsList_json=jsonHelper.encode(paramsList)
local hidePrizeFlag=isHidePrize and 1 or 0
socketManager:send_36_3(resultFlag,paramsList_json,hidePrizeFlag)
end


function airController:reqSaveFbProcessData(isDel)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

airController:addReqListItem(4,{isDel})
return
end

self.waitingRecvStamp=airController:getRealServerTime_short()
local processData=airModel:getActorProcessData(true)
local jsonData=airController:actorProcessData2Json(processData)
local ret=xpcall(function()
local jsonTable=jsonHelper.decode(jsonData)
end,function(err)
logErr(FMT.fmt('空战关卡json数据错误,jsonStr={0}\n processData={1}',jsonData,serializeHelper.serialize(processData)))
end)

if not ret then
return
end
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
if not curLevelIdx then
curLevelIdx=processData.curLevelIdx
end

local isDelFlag=isDel and 1 or 0
socketManager:send_36_4(curLevelIdx,jsonData,isDelFlag)
end


function airController:reqResetAndSaveFbProcessData()
airGameEnterModel:setCancelContinueFlag(true)
airController:clearActorDataAndProcessData()
end


function airController:reqRefreshSettlementData(flushType,isItemCostRefresh,flushIdx)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

airController:addReqListItem(5,{flushType,isItemCostRefresh,flushIdx})
return
end

self.waitingRecvStamp=airController:getRealServerTime_short()
local param
local extraList={}
local checkList={}
local equipTypeList={}
if flushType==1 then

param=flushIdx or 0

local processData=airModel:getActorProcessData()


extraList=airModel:getOverLimitGoodsList()

if not flushIdx then

local boxNumStrList=processData.gotBoxList
for boxIdStr,num in pairs(boxNumStrList)do
local boxId=tonumber(boxIdStr)
checkList[#checkList+1]={boxId,num}
end
end
elseif flushType==2 then

local actorLevel=airModel:getLevel()
param=actorLevel

extraList=airModel:getOverLimitLvUpRandAttrIdList()
elseif flushType==3 then

param=0


extraList=airModel:getOverLimitGoodsList()

local lockList=airModel:getShopLockGoodsList()
if lockList and next(lockList)then

checkList=lockList
end

local nowEquipTypeList=airModel:getNowEquipTypeList()
if nowEquipTypeList and next(nowEquipTypeList)then

equipTypeList=nowEquipTypeList
end
end
local extraList_json=jsonHelper.encode(extraList)

local jiyuan=airActorSystem:getActorAttrValByAttrId(aiAttributeType.eLucky)or 0
local isItemRefreshFlag=isItemCostRefresh and 1 or 0
socketManager:send_36_5(flushType,param,jiyuan,extraList_json,isItemRefreshFlag,#checkList,checkList,#equipTypeList,equipTypeList)
end

function airController:reqRestartGame(clearType)
airModel:clearStatisticData()
clearType=clearType or 2
socketManager:send_36_6(clearType)
end

function airController:reqSendPrepareGameInfo(dzguid,mount_dzguid,mount_itemguid)
socketManager:send_36_12(dzguid,mount_dzguid,mount_itemguid)
end

function airController:reqReviveActor()
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

airController:addReqListItem(13,{})
end

self.waitingRecvStamp=airController:getRealServerTime_short()
socketManager:send_36_13()
end


function airController.recv_36_1(args)
local dayCount=args[1]
local progressInfoLen=args[2]
local progressInfoList=args[3]
local nowFbNum=args[4]
local nowFbList=args[5]
local xbNum=args[6]
local xbList=args[7]
local levelFirst=args[8]
local cjNum=args[9]
local cjList=args[10]
local dzguid=args[11]
local mountguid=args[12]
local buyCount=args[13]

local curFbId=-1
if nowFbNum>0 then
curFbId=nowFbList[1].fbid
local processDataJsonStr=nowFbList[1].process
if processDataJsonStr and processDataJsonStr~=""then
local processData=airController:json2ActorProcessData(processDataJsonStr)
local isOnDead=processData.isOnDead
processData.isOnDead=nil
airModel:setActorProcessData(processData)

if isOnDead then

local resultFlag=0
processData.checkStep=3
airModel:setActorProcessData(processData)
airController:reqFbSettlement(resultFlag,true)
end
end
end



airGameEnterModel:recvInitServerData(dayCount,progressInfoLen,progressInfoList,curFbId,xbNum,xbList,cjNum,cjList,levelFirst,dzguid,mountguid,buyCount)

airGameEnterModel:setOpenSec(args[14])

airGameEnterController:checkTXZOpen()
end


function airController.recv_36_2(fbId)
local enterCallBack=function()
airController:setIsOnlyRefreshWinFlag(true)

airLevelSystem:start(fbId,1)
airController:reqSaveFbProcessData()
airBuffSystem:onLevelStart()
end


airModel:initActorProcessData()
local mapID=cfgHelper.get2(cfg_airfubenconfig_get,fbId,'mapID')
if mainControl:isInScene(eSceneType.eAirGame)and airController:getCurScenceId()==mapID then
local func=function()
UIFullAirGameEnterController:closeUI()
enterCallBack()
end
loadingControl.openCloud(func,nil,true)
else
local callback=function()
mainControl:enterAirGame({mapID},enterCallBack)
end
UIManager:invokeUIMethod('UIAirGamePrepareWin',"playEnterAnimation",callback)
end

airGameEnterModel:startGame(fbId)
end


function airController.recv_36_3(fbId,hidePrizeFlag)

airController:clearAllReqList()

airController:clearWaitingRecvStamp()
local resultFlag=0
if not hidePrizeFlag or hidePrizeFlag==0 then

resultFlag=airLevelSystem:getResultFlag()
UIFullAirMiniGameControl:showSettlementWin({resultFlag=resultFlag})
end

airGameEnterModel:endGame(fbId,resultFlag)
if not hidePrizeFlag or hidePrizeFlag==0 then
airGameEnterController:checkTXZOpen()
end
end


function airController.recv_36_4(scene_idx,jsonStr)
airController:clearWaitingRecvStamp()
local processData=airController:json2ActorProcessData(jsonStr)
local isNeedRefreshData=airController:getIsNeedRefreshDataFlag()
local isOnlyRefreshWin=airController:getIsOnlyRefreshWinFlag()
local refreshDataType=airController:getRefreshDataType()
local refreshIdx=airController:getRefreshIndex()
local isShowFinishAnimWinFlag=airController:getIsShowFinishAnimWinFlag()
local checkStep=processData.checkStep
processData.sceneIdx=scene_idx
airController:setIsOnlyRefreshWinFlag(nil)
airController:setIsNeedRefreshDataFlag(nil)
airController:setRefreshDataType(nil)
airController:setRefreshIndex(nil)
airController:setIsShowFinishAnimWinFlag(nil)
airModel:setActorProcessData(processData)

if isNeedRefreshData then

if checkStep==nil then
return airLevelSystem:onRoundSettlement(nil,false)
end

local isItemCostRefresh=refreshDataType==2
if checkStep<1 then

return airController:reqRefreshSettlementData(1,isItemCostRefresh,refreshIdx)
end

if checkStep<2 then

return airController:reqRefreshSettlementData(2)
end

if checkStep<3 then

return airController:reqRefreshSettlementData(3,isItemCostRefresh)
end
elseif isOnlyRefreshWin then

if checkStep then
if checkStep<1 then
return UIManager:invokeUIMethod("UIAirMiniGame_getRewardWin","sellOrGotRewardRecv")
elseif checkStep<2 then
return UIManager:invokeUIMethod("UIAirMiniGame_levelUpWin","refresh")
elseif checkStep<3 then
return UIManager:invokeUIMethod("UIAirMiniGame_shopWin","refresh",nil,true)
elseif checkStep>=3 then

end
end
else
if isShowFinishAnimWinFlag then

local func=function()
return airLevelSystem:onRoundSettlement(checkStep)
end

local resultFlag=airLevelSystem:getResultFlag()
UIFullAirMiniGameControl:showFinishAnimWin({resultFlag=resultFlag,callback=func})
else

airLevelSystem:onRoundSettlement(checkStep)
end
end
end


function airController.recv_36_5(args)
local flushType=args[1]
local param=args[2]
local jiyuan=args[3]
local extraList_json=args[4]
local len=args[5]
local randomList=args[6]
local isItemRefreshFlag=args[7]
airController:clearWaitingRecvStamp()
local processData=airModel:getActorProcessData()
local checkStep=processData.checkStep
local rewardItemRefreshCount=processData.settlementData.rewardItemRefreshCount
local lvUpAttrRefreshCount=processData.settlementData.lvUpAttrRefreshCount
local lvUpAttrRefreshCount_itemCost=processData.settlementData.lvUpAttrRefreshCount_itemCost
local shopGoodsRefreshCount=processData.settlementData.shopGoodsRefreshCount
local shopGoodsRefreshCount_itemCost=processData.settlementData.shopGoodsRefreshCount_itemCost
local goodsLockList=processData.settlementData.goodsLockList
local isNeedKeepSettlementData=processData.isNeedKeepSettlementData
if not isNeedKeepSettlementData then
processData.settlementData={}
else
processData.isNeedKeepSettlementData=nil
end
if flushType==1 then

processData.settlementData.rewardIdList=len>0 and randomList or{}
processData.settlementData.rewardItemRefreshCount=rewardItemRefreshCount
elseif flushType==2 then

processData.settlementData.attrRandIdList=len>0 and randomList or{}
processData.settlementData.lvUpAttrRefreshCount=lvUpAttrRefreshCount
processData.settlementData.lvUpAttrRefreshCount_itemCost=lvUpAttrRefreshCount_itemCost
elseif flushType==3 then

processData.settlementData.goodsList=len>0 and randomList or{}
processData.settlementData.shopGoodsRefreshCount=shopGoodsRefreshCount
processData.settlementData.shopGoodsRefreshCount_itemCost=shopGoodsRefreshCount_itemCost
end
processData.settlementData.goodsLockList=goodsLockList
processData.checkStep=checkStep
airModel:setActorProcessData(processData)


if flushType==1 then

local win=UIManager:findActiveWindow('UIAirMiniGame_getRewardWin')
if win then
win:refresh()
else

return UIFullAirMiniGameControl:showGetRewardWin()
end
elseif flushType==2 then

local win=UIManager:findActiveWindow('UIAirMiniGame_levelUpWin')
if win then
win:refresh()
else

return UIFullAirMiniGameControl:showLevelUpWin()
end
elseif flushType==3 then

local win=UIManager:findActiveWindow('UIAirMiniGame_shopWin')
if win then
win:refresh()
else

return UIFullAirMiniGameControl:showShopWin()
end
end
end

function airController.recv_36_6(fbid,clearType)
airGameEnterModel:setLevelFirstFlag(fbid,false)

if clearType==2 then


airLevelSystem:onStopNowLevel()

local fbCfg=cfgHelper.get1(cfg_airfubenconfig_get,fbid)
local group=fbCfg.groupid
local level=fbCfg.idx
local dzGuid=airGameEnterModel:getSelectDisciple()
airGameEnterController:enterGame(group,level,dzGuid)
elseif clearType==1 then
local cacheData=airGameEnterModel:getCachePrepareEnterInfo()
if cacheData then
airGameEnterController:enterGame(cacheData.group,cacheData.level,cacheData.dzGuid)
airGameEnterModel:clearCachePrepareEnterInfo()
end
end
end


function airController:recv_36_12(dzguid,mount_dzguid,mount_itemguid)

end

function airController:recv_36_13()
airController:clearWaitingRecvStamp()
UIManager:invokeUIMethod("UIAirMiniGame_reviveWin","onReviveRecv")
end

function airController:returnBackGame()
local args={}
args.isShowModelMove=airGameEnterModel:getLevelFirstFlag()
UIFullAirGameEnterController:showMainWindow(args)
end

function airController:nextLevelGame()

airLevelSystem:onClearNowLevel()

local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getPlayLevel()
local dzGuid=airGameEnterModel:getSelectDisciple()
airGameEnterController:enterGame(group,level,dzGuid)
end


function airController:enterGameAgain()
local fbId=airGameEnterModel:getCurFbId()
local enterCallBack=function()
airController:setIsOnlyRefreshWinFlag(true)

airLevelSystem:start(fbId,1)
airController:reqSaveFbProcessData()
airBuffSystem:onLevelStart()
end

airModel:initActorProcessData()
if mainControl:isInScene(eSceneType.eAirGame)then
enterCallBack()
else
local mapID=cfgHelper.get2(cfg_airfubenconfig_get,fbId,'mapID')
mainControl:enterAirGame({mapID},enterCallBack)
end
end


function airController:getIgnoreLayerCollision(layer1,layer2)
local static=airController.getManagerStatic()
return static.GetIgnoreLayerCollision(layer1,layer2)
end


function airController:setIgnoreLayerCollision(layer1,layer2,ignore)
local static=airController.getManagerStatic()
static.SetIgnoreLayerCollision(layer1,layer2,ignore)
end




function airController:setIgnoreColliderCollision(handle1,guid1,handle2,guid2,ignore)
local static=airController.getManagerStatic()
static.SetIgnoreColliderCollision(handle1,guid1,handle2,guid2,ignore)
end


function airController:actorProcessData2Json(processData)
local jsonTable=table.weakCopy(processData)
if jsonTable.curAttrs~=nil then
local tempList={}
for attrId,attrVal in pairs(jsonTable.curAttrs)do
local attrIdStr=tostring(attrId)
tempList[attrIdStr]=attrVal
end
jsonTable.curAttrs=tempList
end

if jsonTable.levelUpAttrs~=nil then
local tempList={}
for attrId,attrVal in pairs(jsonTable.levelUpAttrs)do
local attrIdStr=tostring(attrId)
tempList[attrIdStr]=attrVal
end
jsonTable.levelUpAttrs=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.boughtIndexList then
local boughtList=jsonTable.settlementData.boughtIndexList
local tempList={}
for index,v in pairs(boughtList)do
local indexStr=tostring(index)
tempList[indexStr]=v
end
jsonTable.settlementData.boughtIndexList=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.itemRewardIndex then
local itemRewardIndexList=jsonTable.settlementData.itemRewardIndex
local tempList={}
for index,v in pairs(itemRewardIndexList)do
local indexStr=tostring(index)
tempList[indexStr]=v
end
jsonTable.settlementData.itemRewardIndex=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.goodsLockList then
local goodsLockList=jsonTable.settlementData.goodsLockList
local tempList={}
for index,v in pairs(goodsLockList)do
local indexStr=tostring(index)
tempList[indexStr]=v
end
jsonTable.settlementData.goodsLockList=tempList
end

if jsonTable.attrTopLimit~=nil then
local tempList={}
for attrId,attrVal in pairs(jsonTable.attrTopLimit)do
local attrIdStr=tostring(attrId)
tempList[attrIdStr]=attrVal
end
jsonTable.attrTopLimit=tempList
end

if jsonTable.allBuff~=nil then
local lookup=jsonTable.allBuff
local templookup={}
for k,v in pairs(lookup)do
local kStr=tostring(k)
templookup[kStr]=v
end
jsonTable.allBuff=templookup
end

if jsonTable.buffSameConver~=nil then
local lookup=jsonTable.buffSameConver
local templist={}
for k,v in pairs(lookup)do
local kStr=tostring(k)
templist[kStr]=v
end
jsonTable.buffSameConver=templist
end

return jsonHelper.encode(jsonTable)
end

function airController:json2ActorProcessData(jsonStr)
local jsonTable=jsonHelper.decode(jsonStr)
if jsonTable.curAttrs~=nil then
local tempList={}
for attrIdStr,attrVal in pairs(jsonTable.curAttrs)do
local attrId=tonumber(attrIdStr)
tempList[attrId]=attrVal
end
jsonTable.curAttrs=tempList
end

if jsonTable.levelUpAttrs~=nil then
local tempList={}
for attrIdStr,attrVal in pairs(jsonTable.levelUpAttrs)do
local attrId=tonumber(attrIdStr)
tempList[attrId]=attrVal
end
jsonTable.levelUpAttrs=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.boughtIndexList then
local boughtList=jsonTable.settlementData.boughtIndexList
local tempList={}
for indexStr,v in pairs(boughtList)do
local index=tonumber(indexStr)
tempList[index]=v
end
jsonTable.settlementData.boughtIndexList=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.itemRewardIndex then
local itemRewardIndexList=jsonTable.settlementData.itemRewardIndex
local tempList={}
for indexStr,v in pairs(itemRewardIndexList)do
local index=tonumber(indexStr)
tempList[index]=v
end
jsonTable.settlementData.itemRewardIndex=tempList
end


if jsonTable.settlementData~=nil and jsonTable.settlementData.goodsLockList then
local goodsLockList=jsonTable.settlementData.goodsLockList
local tempList={}
for indexStr,v in pairs(goodsLockList)do
local index=tonumber(indexStr)
tempList[index]=v
end
jsonTable.settlementData.goodsLockList=tempList
end

if jsonTable.attrTopLimit~=nil then
local tempList={}
for attrIdStr,attrVal in pairs(jsonTable.attrTopLimit)do
local attrId=tonumber(attrIdStr)
tempList[attrId]=attrVal
end
jsonTable.attrTopLimit=tempList
end

if jsonTable.allBuff~=nil then
local lookup=jsonTable.allBuff
local templookup={}
for k,v in pairs(lookup)do
local kStr=tonumber(k)
templookup[kStr]=v
end
jsonTable.allBuff=templookup
end


if jsonTable.buffSameConver~=nil then
local lookup=jsonTable.buffSameConver
local templist={}
for kStr,v in pairs(lookup)do
local k=tonumber(kStr)
templist[k]=v
end
jsonTable.buffSameConver=templist
end

return jsonTable
end

function airController:buyItemByItemIdAndType(index,itemId,itemType)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end


airController:clearGoodsLockState(index)
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if not processData.settlementData.boughtIndexList then
processData.settlementData.boughtIndexList={}
end

processData.settlementData.boughtIndexList[index]=true

local price=airController:getItemBuyOrSellPrice(itemId,itemType,1,true)
self.isOnlyRefreshWin=true
if itemType==1 then

airModel:addEquip(itemId)
elseif itemType==2 then

airModel:addBagItem(itemId)
end
airModel:useMoney(price)
airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(false)
end

function airController:levelUpAddAttr(nowLevel,attrRandId)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end

local processData=airModel:getActorProcessData()
local ent=airActorSystem:getActor()
local exp=airModel:getExp()
local needExp=airActorSystem:getLevelUpNeedExpByLevel(nowLevel)
local newExp=exp-needExp
local newLevel=nowLevel+1
airModel:setLevel(newLevel)
airModel:setExp(newExp)

local attrRandCfg=cfgHelper.get(cfg_airrandattrconfig_get,attrRandId)
if attrRandCfg then
local attrId=attrRandCfg.attr_type
local attrVal=attrRandCfg.attrVal


ent:addLevelUpAttrs(attrId,attrVal)
if not processData.lvUpIdSelectCountList then
processData.lvUpIdSelectCountList={}
end

local attrRandIdStr=tostring(attrRandId)
if processData.lvUpIdSelectCountList[attrRandIdStr]then
processData.lvUpIdSelectCountList[attrRandIdStr]=processData.lvUpIdSelectCountList[attrRandIdStr]+1
else
processData.lvUpIdSelectCountList[attrRandIdStr]=1
end
end

local isCanLvUp=airActorSystem:checkActorCanLevelUp()
if isCanLvUp then

self.isNeedRefreshData=true
else
processData.checkStep=2
self.isNeedRefreshData=nil

UIManager:invokeUIMethod("UIAirMiniGame_levelUpWin","closeSelf")
end

airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(true)
end

function airController:getAttrStr(attrId,attrVal,isAddOne,ignorePercent)
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrValStr
if attrCfg.flag==1 then

attrValStr=mathHelper.formatNumber(math.floor(attrVal))
elseif attrCfg.flag==2 then

local percent=attrVal/100
if isAddOne then
percent=percent+100
end
percent=math.floor(percent)
if ignorePercent then
attrValStr=tostring(percent)
else
attrValStr=FMT.fmt("{0}%",percent)
end
elseif attrCfg.flag==3 then

local percent=attrVal*100
if isAddOne then
percent=percent+100
end
percent=math.floor(percent)
if ignorePercent then
attrValStr=tostring(percent)
else
attrValStr=FMT.fmt("{0}%",percent)
end
end

return attrValStr
end

function airController:getItemSortAttrList(itemId,itemType)
local itemCfg
local sortList={}
if itemType==1 then

itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
local attackAttrsCfg_lookup=itemCfg.attackAttrs or{}
local extraAttrsCfg_lookup=itemCfg.extraAttrs or{}

for attrId,attrVal in pairs(attackAttrsCfg_lookup)do
if attrId~=aiAttributeType.eAttckSpeed and attrId~=aiAttributeType.eAttckRange then

local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local weight=attrCfg.showSortId-1000
if attrId==aiAttributeType.eAttack then
weight=weight-100000
end

sortList[#sortList+1]={
attrId=attrId,
attrVal=attrVal,
weight=weight,
}
end
end


local atkRange=itemCfg.bounds[4]
local atkRange_attrAdd=0
local finalAtkRange=atkRange
if attackAttrsCfg_lookup[aiAttributeType.eAttckRange]then
atkRange_attrAdd=attackAttrsCfg_lookup[aiAttributeType.eAttckRange]
finalAtkRange=atkRange+atkRange*atkRange_attrAdd/10000
end
sortList[#sortList+1]={
attrName="攻击距离",
relevantAttrId=aiAttributeType.eAttckRange,
attrVal=atkRange,
finalAttrVal=finalAtkRange,
weight=1,
}


local equipSkillId=itemCfg.skillid
if equipSkillId then
local skillCfg=cfgHelper.get(cfg_airskillconfig_get,equipSkillId)
if skillCfg then
local atkSpeed=skillCfg.cd
local atkSpeed_attrAdd=0
local finalAtkSpeed=atkSpeed
if attackAttrsCfg_lookup[aiAttributeType.eAttckSpeed]then
atkSpeed_attrAdd=attackAttrsCfg_lookup[aiAttributeType.eAttckSpeed]
finalAtkSpeed=atkSpeed+atkSpeed*atkSpeed_attrAdd/10000
end
sortList[#sortList+1]={
attrName="攻击间隔",
relevantAttrId=aiAttributeType.eAttckSpeed,
attrVal=atkSpeed,
finalAttrVal=finalAtkSpeed,
weight=2,
}
end
end


for attrId,attrVal in pairs(extraAttrsCfg_lookup)do
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local weight=attrCfg.showSortId+1000
sortList[#sortList+1]={
attrId=attrId,
attrVal=attrVal,
weight=weight,
}
end
elseif itemType==2 then


local attrList_lookup=airModel:getItemAttrListLookup(itemId)
for attrId,v in pairs(attrList_lookup)do
local weight
if not v.cfgIdx then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
weight=attrCfg.showSortId
else
weight=v.cfgIdx
end
sortList[#sortList+1]={
attrId=attrId,
attrVal=v.val,
isPercent=v.isPercent,
weight=weight,
}
end
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

return sortList
end

function airController:isEquipCanHeCheng(itemId,equipIndex)
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if itemCfg and itemCfg.combine then
local sameEquipIndex=airActorSystem:getActorSameEquipIndex(itemId,equipIndex)
if sameEquipIndex then
return true
end
end

return false
end


function airController:setGoodsLockState(goodIndex,goodRandId,isLock)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if isLock then
if not processData.settlementData.goodsLockList then
processData.settlementData.goodsLockList={}
end
processData.settlementData.goodsLockList[goodIndex]=goodRandId
else
if processData.settlementData.goodsLockList[goodIndex]then
processData.settlementData.goodsLockList[goodIndex]=nil
end
end
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(false)
end


function airController:clearGoodsLockState(goodIndex)
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if processData.settlementData.goodsLockList and processData.settlementData.goodsLockList[goodIndex]then
processData.settlementData.goodsLockList[goodIndex]=nil
end
airModel:setActorProcessData(processData)
end


function airController:buyAndLevelUpEquipItem(goodIndex,itemId,equipIndex)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end

airController:clearGoodsLockState(goodIndex)
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if not processData.settlementData.boughtIndexList then
processData.settlementData.boughtIndexList={}
end

processData.settlementData.boughtIndexList[goodIndex]=true

local price=airController:getItemBuyOrSellPrice(itemId,1,1,true)
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
local changeItemId=itemCfg.combine
airModel:changeEquip(equipIndex,changeItemId)

airModel:useMoney(price)
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(false)


UIManager:invokeUIMethod("UIAirMiniGame_shopWin","onEquipLevelUp",equipIndex)
end


function airController:heChengEquipItem(itemId,equipIndex_a,equipIndex_b)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
local changeItemId=itemCfg.combine









airModel:setStatisticData_mergeWeaponDmg(equipIndex_a,equipIndex_b)

airModel:changeEquip(equipIndex_a,changeItemId)
airModel:removeEquip(equipIndex_b)

local processData=airModel:getActorProcessData()
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)


airController:reqSaveFbProcessData(false)

UIManager:invokeUIMethod("UIAirMiniGame_shopWin","onEquipLevelUp",equipIndex_a)
end


function airController:sellEquipItem(itemId,equipIndex)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
airModel:removeEquip(equipIndex)


airModel:setStatisticData_removeWeaponDmg(equipIndex)

local price=airController:getItemBuyOrSellPrice(itemId,1,2)

airModel:addMoney(price)

local processData=airModel:getActorProcessData()
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)


airController:reqSaveFbProcessData(false)
end


function airController:levelUpEquipItem(equipIndex)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return false
end

local equipList=airModel:getEquipList()
if not equipList or not equipList[equipIndex]then

return false
end

local isCanLevelUp=airModel:checkEquipIsCanLevelUp(equipIndex)
if not isCanLevelUp then

return false
end

local itemId=equipList[equipIndex]
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
local changeItemId=itemCfg.combine
airModel:changeEquip(equipIndex,changeItemId)

self.isOnlyRefreshWin=true

airController:reqSaveFbProcessData(false)
return true
end


function airController:sellItemReward(itemId,rewardIndex,rewardCount)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if not processData.settlementData.itemRewardIndex then
local list={}
for i=1,rewardCount do
list[i]=0
end
processData.settlementData.itemRewardIndex=list
end

processData.settlementData.itemRewardIndex[rewardIndex]=2

local price=airController:getItemBuyOrSellPrice(itemId,2,2)
airModel:addMoney(price)

local hasNotGotReward=airController:isHasNotGotRewardItem()
if hasNotGotReward then

processData.checkStep=1
airController:clearRewardItemData()

UIManager:invokeUIMethod("UIAirMiniGame_getRewardWin","closeSelf")
airModel:setActorProcessData(processData)
airController:reqSaveFbProcessData(true)
else
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)
airController:reqSaveFbProcessData()


end
end


function airController:getItemReward(itemId,rewardIndex,rewardCount)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if not processData.settlementData.itemRewardIndex then
local list={}
for i=1,rewardCount do
list[i]=0
end
processData.settlementData.itemRewardIndex=list
end

processData.settlementData.itemRewardIndex[rewardIndex]=1

airModel:addBagItem(itemId)

local hasNotGotReward=airController:isHasNotGotRewardItem()
if hasNotGotReward then

processData.checkStep=1
airController:clearRewardItemData()

UIManager:invokeUIMethod("UIAirMiniGame_getRewardWin","closeSelf")
airModel:setActorProcessData(processData)
airController:reqSaveFbProcessData(true)
else
self.isOnlyRefreshWin=true
airModel:setActorProcessData(processData)
airController:reqSaveFbProcessData()


end
end




function airController:getItemBuyOrSellPrice(itemId,itemType,buyType,isCheckInflation)
local price
if itemType==1 then

local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if buyType==1 then
price=itemCfg.sell
elseif buyType==2 then
price=itemCfg.reclaim
end
elseif itemType==2 then

local itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
if buyType==1 then
price=itemCfg.buyPrice
elseif buyType==2 then
price=itemCfg.dealPrice
end
end

if isCheckInflation then
local inflation=cfgHelper.get(cfg_aircommonconfig_get,1,"priceInflation")
if inflation and inflation~=0 then
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local roundNum=curLevelIdx

price=math.ceil(price*(1+inflation)^(roundNum-1))
end
end

price=airActorSystem:getShopPrice(price,buyType,itemId,itemType)

return price
end


function airController:getLevelUpAttrRefreshCost()
local processData=airModel:getActorProcessData()
local refreshNum=processData and processData.settlementData and processData.settlementData.lvUpAttrRefreshCount or 0
local refreshCostStep=cfgHelper.get(cfg_aircommonconfig_get,1,"refreshCostStep")
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local roundNum=curLevelIdx

local refreshCost=math.ceil(roundNum+roundNum/refreshCostStep*(refreshNum+1))

return refreshCost
end


function airController:getShopGoodsRefreshCost()
local processData=airModel:getActorProcessData()
local refreshNum=processData and processData.settlementData and processData.settlementData.shopGoodsRefreshCount or 0
local refreshCostStep=cfgHelper.get(cfg_aircommonconfig_get,1,"refreshCostStep")
local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()
local roundNum=curLevelIdx

local refreshCost=math.ceil(roundNum+roundNum/refreshCostStep*(refreshNum+1))


local addValue,addValue_P=airBuffSystem:onFreshShop()
if addValue>0 then
refreshCost=refreshCost-addValue
end
if addValue_P>0 then
refreshCost=math.ceil(refreshCost*(1-addValue_P/10000))
end

return refreshCost
end


function airController:isHasNotGotRewardItem()
local processData=airModel:getActorProcessData()
if processData and processData.settlementData and processData.settlementData.itemRewardIndex then
local list=processData.settlementData.itemRewardIndex
for i,v in pairs(list)do
if v==0 then
return false
end
end
return true
end

return false
end


function airController:isNeedReqRewardItemData()
local processData=airModel:getActorProcessData()
if processData and processData.settlementData and processData.settlementData.itemRewardIndex then
local list=processData.settlementData.itemRewardIndex
if next(list)then
return false
end
end
return true
end


function airController:clearRewardItemData()
local processData=airModel:getActorProcessData()
if processData and processData.settlementData and processData.settlementData.itemRewardIndex then
processData.settlementData.itemRewardIndex=nil
end
end


function airController:itemRefreshRewardData(index)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if not processData.settlementData.rewardItemRefreshCount then
processData.settlementData.rewardItemRefreshCount=1
else
processData.settlementData.rewardItemRefreshCount=processData.settlementData.rewardItemRefreshCount+1
end

self.isNeedRefreshData=true
self.refreshDataType=2
self.refreshIndex=index

airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(false)
end


function airController:refreshLevelUpAttrData(refreshCost,costType)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if costType==1 then

if not processData.settlementData.lvUpAttrRefreshCount then
processData.settlementData.lvUpAttrRefreshCount=1
else
processData.settlementData.lvUpAttrRefreshCount=processData.settlementData.lvUpAttrRefreshCount+1
end

airModel:useMoney(refreshCost)
elseif costType==2 then

if not processData.settlementData.lvUpAttrRefreshCount_itemCost then
processData.settlementData.lvUpAttrRefreshCount_itemCost=1
else
processData.settlementData.lvUpAttrRefreshCount_itemCost=processData.settlementData.lvUpAttrRefreshCount_itemCost+1
end
end
self.isNeedRefreshData=true
self.refreshDataType=costType

airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(true)
end


function airController:refreshShopGoodsData(refreshCost,costType)
local nowTime=airController:getRealServerTime_short()
if self.waitingRecvStamp and nowTime<=self.waitingRecvStamp+_maxWaitingRecvStamp then

return
end
local processData=airModel:getActorProcessData()
if not processData.settlementData then
processData.settlementData={}
end

if costType==1 then

if not processData.settlementData.shopGoodsRefreshCount then
processData.settlementData.shopGoodsRefreshCount=1
else
processData.settlementData.shopGoodsRefreshCount=processData.settlementData.shopGoodsRefreshCount+1
end
airBuffSystem:onFreshShop(true)
airModel:useMoney(refreshCost)
elseif costType==2 then

if not processData.settlementData.shopGoodsRefreshCount_itemCost then
processData.settlementData.shopGoodsRefreshCount_itemCost=1
else
processData.settlementData.shopGoodsRefreshCount_itemCost=processData.settlementData.shopGoodsRefreshCount_itemCost+1
end

self.refreshDataType=2
end

self.refreshDataType=costType
self.isNeedRefreshData=true

airModel:setActorProcessData(processData)

airController:reqSaveFbProcessData(true)
end

function airController:clearWaitingRecvStamp()
self.waitingRecvStamp=nil
end

function airController:continueEnterGame(fbId)
local processData=airModel:getActorProcessData(nil,true)
if not processData then

UIFullAirGameEnterController:closeUI()
return airController:enterGameAgain()
end

local enterCallBack=function()
return airLevelSystem:continueStart()
end
local mapID=cfgHelper.get2(cfg_airfubenconfig_get,fbId,'mapID')
if mainControl:isInScene(eSceneType.eAirGame)and airController:getCurScenceId()==mapID then
local func=function()
UIFullAirGameEnterController:closeUI()
enterCallBack()
end

loadingControl.openCloud(func,nil,true)
else
mainControl:enterAirGame({mapID},enterCallBack)
end
end


function airController:clearActorDataAndProcessData()
airModel:setActorProcessData(nil)
airModel:setActorData(nil)

airController:reqRestartGame(1)
end


function airController:setIsOnlyRefreshWinFlag(flag)
self.isOnlyRefreshWin=flag
end

function airController:getIsOnlyRefreshWinFlag()
return self.isOnlyRefreshWin
end

function airController:setIsNeedRefreshDataFlag(flag)
self.isNeedRefreshData=flag
end

function airController:getIsNeedRefreshDataFlag()
return self.isNeedRefreshData
end

function airController:setRefreshDataType(refreshType)
self.refreshDataType=refreshType
end

function airController:getRefreshDataType()
return self.refreshDataType
end

function airController:setRefreshIndex(idx)
self.refreshIndex=idx
end

function airController:getRefreshIndex()
return self.refreshIndex
end

function airController:setIsShowFinishAnimWinFlag(flag)
self.isShowFinishAnimWinFlag=flag
end

function airController:getIsShowFinishAnimWinFlag()
return self.isShowFinishAnimWinFlag
end



function airController:refreshAllWinRefreshCostShow()

UIManager:invokeUIMethod("UIAirMiniGame_getRewardWin","refreshItemRefreshCost")

UIManager:invokeUIMethod("UIAirMiniGame_levelUpWin","refreshBtnPanel")

UIManager:invokeUIMethod("UIAirMiniGame_shopWin","refreshBtnPanel")
end


function airController:refreshAllWinItemPriceShow()

UIManager:invokeUIMethod("UIAirMiniGame_getRewardWin","refreshItemSellPrice")

UIManager:invokeUIMethod("UIAirMiniGame_shopWin","refreshGoodsPrice")

UIManager:invokeUIMethod("UIAirMiniGame_itemTipsWin","refreshBtnPanel")
end

function airController:getCurScenceId()
return self.sceneId
end


function airController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eAirGeCaoSettlement then

table.sort(prizelist,function(a,b)
return a.sortWeight>b.sortWeight
end)
airModel:setSettlementRewardList(prizelist)
end
end



function airController:levelFinishPrint()






end


function airController:test_addMoney(addCount)
airModel:addMoney(addCount)
end


function airController:test_addExp(addCount)
airModel:addExp(addCount)
end


function airController:test_finishLevel(isVictory)
local resultFlag=isVictory and 1 or 0
airLevelSystem:setResultFlag(resultFlag)
airLevelSystem:onFinishLevel()
end


function airController:test_endAndClearLevelData()
airLevelSystem:test_endNowLevel()
airModel:setActorProcessData(nil)
airModel:setActorData(nil)
airModel:clearStatisticData()
end


function airController:test_addItemOrEquip(itemId,itemType)
self.isOnlyRefreshWin=true
if itemType==1 then

airModel:addEquip(itemId)
elseif itemType==2 then

airModel:addBagItem(itemId)
end

airController:reqSaveFbProcessData(false)
end


function airController:test_addDrop(dropId,num)
local ent=airActorSystem:getActor()
airDropSystem:addCollectDrop(dropId,num)
airDropSystem:onCollectDrop(ent,dropId,num)
end


function airController:test_playActorEffect(effectId,offset,scale)
local ent=airActorSystem:getActor()
local offset_v3=Vector3.zero
if offset then
offset_v3=Vector3.New(offset[1],offset[2],offset[3])
end
scale=scale or 1
ent:playEffectWithOrder(effectId,offset_v3,Vector3.New(scale,scale,scale),false,true)
end

function airController:test_playActorReviveEffect()
local ent=airActorSystem:getActor()
local effectId=2136
local scale=2
ent:playEffectWithOrder(effectId,Vector3.zero,Vector3.New(scale,scale,scale),false,true)
ent:showWuDiBehaiour()
end

function airController:test_printAttrByIndex(attrId)
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname
local attrVal=airActorSystem:getActorAttrValByAttrId(attrId)
local baseAttrVal=airActorSystem:getActorBaseAttrValByAttrId(attrId)

end

function airController:test_printNowFbIdAndCurLevelIdx()

local fbId,curLevel,curLevelIdx=airLevelSystem:getFbIdAndCurLevel()


end

function airController:test_killSelf()
local ent=airActorSystem:getActor()
local hp=ent:getHP()
ent:onDamage(hp)
end

function airController:startSelfTimerFunc()
if self.newbieTimer==nil then
local tick=function()
newbieControl.newbieDirtyFunc()
newbieControl.newbieFunc()
behaviorManager:tickFunc()
end
self.newbieTimer=self.mapWinlua:StartTimer(0,0,tick)
end
end

function airController:stopSelfTimerFunc()
if self.newbieTimer then
self.mapWinlua:StopTimer(self.newbieTimer)
self.newbieTimer=nil
end
end

function airController:getRealServerTime_short()
local shortTime=gameUtilityModel.getServerShortTime2()
local time_int=math.floor(shortTime)
return time_int
end

function airController:getRealServerTime_long()
local shortTime=gameUtilityModel.getServerShortTime2()
local longTime=timeHelper.convertLongStamp(shortTime)
local time_int=math.floor(longTime)
return time_int
end
