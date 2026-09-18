







local mark35_151=nil
local mojieLeave=nil

function xianjieController:onAppStart_mojie()
xianjieController:onAppStart_RankMoJie()
xianjieController:onAppStart_ForceMoJie()
socketManager:register_receiver(35,149,xianjieController.recv_protocol_35_149)
socketManager:register_receiver(35,150,xianjieController.recv_protocol_35_150)
socketManager:register_receiver(35,151,xianjieController.recv_protocol_35_151)
socketManager:register_receiver(35,152,xianjieController.recv_protocol_35_152)
socketManager:register_receiver(35,181,xianjieController.recv_protocol_35_181)
socketManager:register_receiver(35,182,xianjieController.recv_protocol_35_182)
socketManager:register_receiver(35,185,xianjieController.recv_protocol_35_185)
socketManager:register_receiver(35,186,xianjieController.recv_protocol_35_186)
socketManager:register_receiver(35,191,xianjieController.recv_protocol_35_191)

socketManager:register_receiver(35,196,xianjieController.recv_protocol_35_196)
socketManager:register_receiver(35,197,xianjieController.recv_protocol_35_197)
socketManager:register_receiver(35,198,xianjieController.recv_protocol_35_198)
socketManager:register_receiver(35,199,xianjieController.recv_protocol_35_199)

socketManager:register_receiver(35,192,xianjieController.recv_protocol_35_192)
end

function xianjieController:onEnterState_mojie(isReconnet)
xianjieController:onEnterState_RankMoJie(isReconnet)
xianjieController:onEnterState_ForceMoJie(isReconnet)
end

function xianjieController:onLeaveState_mojie(isReconnet)
xianjieController:onLeaveState_RankMoJie(isReconnet)
xianjieController:onLeaveState_ForceMoJie(isReconnet)
self.send_35_181_ing=nil
self.send_35_181_enterCall=nil
self.send_35_181_enterParam=nil
mark35_151=nil
mojieLeave=nil
end

function xianjieController:onProtocolReqKF_mojie(isReconnet)
if mark35_151 then
local args=mark35_151
mark35_151=nil
xianjieController.recv_protocol_35_151(args)
end
xianjieController:onProtocolReqKF_RankMoJie(isReconnet)
xianjieController:onProtocolReqKF_ForceMoJie(isReconnet)
end

function xianjieController:onEnterMap_mojie(ischange,enterParam)
xianjieController:onEnterMap_RankMoJie(ischange,enterParam)
xianjieController:onEnterMap_ForceMoJie(ischange,enterParam)

xianjieController:excuteAllPlotBehavior3()

xianjieModel:setAllDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao)
local simMixColor=cfgHelper.get(cfg_globalconfig_get,1,"simMixColor")
shaderHelper.setSimLight(true,simMixColor[1],simMixColor[2],simMixColor[3])
end

function xianjieController:onLeaveMap_mojie(ischange)
xianjieController:onLeaveMap_RankMoJie(ischange)
xianjieController:onLeaveMap_ForceMoJie(ischange)
xianjieModel:clearData_plotBehavior()
shaderHelper.setSimLight(false)
mojieLeave=nil

xianjieModel:setAllDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao)
end

function xianjieController:handleEnterParam_mojie(enterParam,ischange)
if enterParam.triggerMojieSeasonStageBehavier then
xianjieModel:checkTriggerSeasonStageBehaivour()
end
end

function xianjieController:onNormalUpdate_mojie(delay)
if not initProControl.isDoneLargeKFXJ()then return end
if mojieLeave then
loggerUtil.logErrFMT("重复进入魔界退出Update检查")
return
end
if fightModel:haveBattleShow()or sceneControl:isLoadingState()then
return
end
local sceneType=xianjieModel:getScenceType()
if sceneType and xianjienSceneType:isMoJie(sceneType)then
local data=xianjieModel:getMoJieEnterData()
if not data or not xianjieModel:checkMoJieEnterTime(sceneType)then
mojieLeave=true
xianjieController:jumpXianJie(nil,nil,function()mojieLeave=nil end)
UIManager.info("魔界已结束")
end
end
end



function xianjieController:reqInfo_mojie()
socketManager:send_35_152()
end


function xianjieController:reqCreateZMPos_mojie(enterCall,enterParam)
if not self.send_35_181_ing then
socketManager:send_35_181(mjZongMenPosRandType.eSeason)
self.send_35_181_ing=true
self.send_35_181_enterCall=enterCall
self.send_35_181_enterParam=enterParam
end
end


function xianjieController:reqMoveZMPos_mojie(sceneidx,x,y,way)



socketManager:send_35_182(sceneidx,x,y,way or 0)
end


function xianjieController:send_35_149()
socketManager:send_35_149()
end


function xianjieController:reqMoJieMassYBDMoneyAndSoldierSave(moneyNum)
socketManager:send_35_192(moneyNum)
end




function xianjieController.recv_protocol_35_151(args)

















if not initProControl.isDoneKF()then
mark35_151=args
return
end
local isInit=xianjieModel:initData_mojie(args[1])
if isInit then

end
local sceneidx=args[2]
if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieModel:initZongMenOutPos_mojie(args[2],args[3],args[4])
else
xianjieModel:initZongMenOutPos_mogongzhengduo(args[2],args[3],args[4])
end

xianjieModel:setCurCountToday_mojie(args[9],args[10])
xianjieModel:setXianMengMoveTimes(args[11])
xianjieModel:refreshMyZongMenMoJunAreaId(args[2])
xianjieController:setMoJiejieshuData(args[12],args[13])
xianjieModel:setMoJieHistorySeason(args[15])
end


function xianjieController.recv_protocol_35_152()

xianjieModel:initBaseData_mojie()


end


function xianjieController.recv_protocol_35_181(sceneidx,x,y,reason)



xianjieController.send_35_181_ing=nil
local enterCall=xianjieController.send_35_181_enterCall
local enterParam=xianjieController.send_35_181_enterParam
xianjieController.send_35_181_enterCall=nil
xianjieController.send_35_181_enterParam=nil
if xianjienSceneIndexType:isMoJie(sceneidx)then
if reason==0 then
xianjieModel:initZongMenOutPos_mojie(sceneidx,x,y)

xianjieModel:setJoin_mojie()

local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
xianjieController:jumpXianJie(sceneType,enterParam,enterCall)

else
xianjieModel:changeMyZongMenPos(sceneidx,x,y,reason)
end
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
if reason==0 then
xianjieModel:initZongMenOutPos_mogongzhengduo(sceneidx,x,y)
xianjieModel:setJoin_mogongzhengduo()

local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
xianjieController:jumpXianJie(sceneType,enterParam,enterCall)
else

xianjieModel:changeMyZongMenPos(sceneidx,x,y,0)
end
end
end


function xianjieController.recv_protocol_35_182(sceneidx,x,y,way,reason)






xianjieModel:changeMyZongMenPos(sceneidx,x,y,0)
if reason==0 then
if xianjienSceneIndexType:isMoJie(sceneidx)then
xianjieModel:addCurCountToday_mojie(way)
end
end
end


function xianjieController.recv_protocol_35_185(args)
local args_={args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[11],args[12],args[13],args[14],args[9],args[10]}
xianjieController.recv_protocol_35_35(args_)
end


function xianjieController.recv_protocol_35_186(marchguid,itemid)
xianjieController.recv_protocol_35_36(marchguid,itemid)
end


function xianjieController.recv_protocol_35_191(marchguid)
xianjieController.recv_protocol_35_41(marchguid)
end


function xianjieController.recv_protocol_35_150(seasonid,begintime,endtime)
xianjieModel:setMoJieEnterData(seasonid,begintime,endtime)
xianjieModel:clearMoJiRecordData()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieSaiJi,begintime,endtime)
MojiePreviewExtendController.checkPopWin()
local nowTime=timeHelper.getServerShortTime()

if nowTime>=endtime then
xianjieController:send_35_149()
end
seasonModel:checkTriggerShowPreview()

timeEventController.delayDo(1,function()
xianjieController:showMoJieYanShiShop()
end)
LunHuiDianModel:checkReqOpenHQT()
end


function xianjieController.recv_protocol_35_149(len,list)
xianjieModel:setMoJieRecordData(list)
timeEventController.delayDo(1,function()
xianjieController:showMoJieYanShiShop()
end)
end


function xianjieController.recv_protocol_35_196(len,massTeamList)
xianjieModel:setJiJieSimpleDataList(len,massTeamList)
xianjieModel:initJiJieDirtyDataList()


UIManager:invokeUIMethod("UIMoJie_JiJie_teamListMonsterWin","refreshView")



UIManager:invokeUIMethod("UIXianJie_JiJie_teamListBgWin","refreshAllMenuReddot")

UIManager:invokeUIMethod("UIXianJieMainWin","onMassTeamListInitRecv")


UIManager:invokeUIMethod("UIXianJieMainWin","callExtraFunc","onMassTeamListInitRecv")


UIManager:invokeUIMethod("UIMoJie_MoJunInfoWin","onShowArgRecv")
end


function xianjieController.recv_protocol_35_197(args)
local actorId=args[1]
local guid=args[2]
local infoguid=args[3]
local goSec=args[4]
local autoGo=args[5]
local len=args[6]
local list=args[7]
local max=args[8]
local endGo=args[9]
local isMoJieMass=true
xianjieModel:refreshJiJieTeamDetail(actorId,guid,goSec,autoGo,len,list,max,endGo,infoguid,isMoJieMass)


UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","refresh",true)

UIManager:invokeUIMethod("UIXianJie_JiJie_YBDListWin","initMemberActorIdLookup")
UIManager:invokeUIMethod("UIXianJie_JiJie_YBDListWin","refresh",nil,true)


if xianjieController.send_35_197_sendArgs then
if xianjieController.send_35_197_sendArgs.callback then
if list==nil then
UIManager.error("集结已结束")
else
xianjieController.send_35_197_sendArgs.callback(list)
end
end
xianjieController.send_35_197_sendArgs=nil
end
end


function xianjieController:reqMoJieMonsterTeamInfo(infoguid)
socketManager:send_35_198(infoguid)
end


function xianjieController.recv_protocol_35_198(infoguid,len,teamInfos)
xianjieModel:saveMonsterTeamInfo(infoguid,teamInfos or{})
end


function xianjieController.recv_protocol_35_199(actorId,massguid,guid,flag)
xianjieModel:setJiJieDirtyData(actorId,massguid,guid,flag)
local sceneidx=xianjieModel:getCurrentMoJieSceneIndex()
UIManager:invokeUIMethod("UIXianJie_JiJie_msgWin","onMassDetailDataChangeRecv",actorId,massguid,sceneidx)




UIManager:invokeUIMethod("UIXianJieMainWin","onMassDetailDataChangeRecv",actorId,massguid,flag)
UIManager:invokeUIMethod("UIXianJieMainWin","callExtraFunc","onMassDetailDataChangeRecv",actorId,massguid,flag)
end



function xianjieController.recv_protocol_35_192(moneyNum,reason)
local jjYBDData=xianjieModel:getJiJieYBDData()
local old=jjYBDData.molingCnt
xianjieModel:setJiJieYBDData_moling(moneyNum)

if reason==1 then
UIManager.info("设置成功")
end



UIManager:invokeUIMethod("UIMoJie_JiJie_YBDSetPVEWin","refreshStoredMoneyView")

end




function xianjieController.test_Check_MoJie_Open()
local enterData=xianjieModel:getMoJieEnterData()
if enterData==nil then
logErr('后端未下发协议 35_150 魔界未初始化开启')
return
end

logErr("魔界赛季信息-- ID——StartTime——EndTime",enterData.sId,timeHelper.getFormatByShortStamp2(enterData.sTime),timeHelper.getFormatByShortStamp2(enterData.eTime))

local enterConfig=xianjieModel:getMoJieEnterConfig()
local seasonID=enterConfig.csid
local seasonData=seasonModel:getHandle(seasonID)

if seasonData==nil then
logErr('魔界赛季 对应的赛季玩法 后端未填充数据（39_1）,赛季玩法ID：',seasonID)
return
end

logErr("魔界赛季玩法信息-- ID——StartTime——EndTime",seasonID,timeHelper.getFormatByShortStamp2(seasonData.beginTime),timeHelper.getFormatByShortStamp2(seasonData.endTime))















end
