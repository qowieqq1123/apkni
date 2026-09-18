







local cloudUnlockAnimMark

function xianjieController:onAppStart_plot()
socketManager:register_receiver(37,1,xianjieController.recv_protocol_37_1)
socketManager:register_receiver(37,2,xianjieController.recv_protocol_37_2)
socketManager:register_receiver(37,3,xianjieController.recv_protocol_37_3)
socketManager:register_receiver(37,4,xianjieController.recv_protocol_37_4)
socketManager:register_receiver(37,32,xianjieController.recv_protocol_37_32)
socketManager:register_receiver(37,33,xianjieController.recv_protocol_37_33)
socketManager:register_receiver(37,96,xianjieController.recv_protocol_37_96)
socketManager:register_receiver(37,99,xianjieController.recv_protocol_37_99)
end

function xianjieController:onEnterState_plot(isReconnet)
cloudUnlockAnimMark={}
end

function xianjieController:onLeaveState_plot(isReconnet)
cloudUnlockAnimMark=nil
xianjieModel:clearData_plot()
end

function xianjieController:onEnterMap_plot(ischange,enterParam)
xianjieModel:setEnterPlotMark(true)

local locklist=xianjieModel:getCloudLockList()
xianjieController:initFogLockList(locklist)

xianjieModel:createMyZongMenEnity()
xianjieModel:createAllCloudEntity()
xianjieModel:createCloudUnLockEntity()


xianjieController:excuteAllPlotBehavior()
end

function xianjieController:onLeaveMap_plot(ischange)
xianjieModel:setEnterPlotMark(nil)
xianjieModel:clearData_plotBehavior()
xianjieModel:removeMyZongMenEntity()
xianjieModel:removeAllCloudEntity()
xianjieModel:removeAllCloudPlotEntity()
xianjieModel:ClearCloudUnLockEntity()
end

function xianjieController:handleEnterParam_plot(enterParam,ischange)
if enterParam==nil then return end
local plotMonster=enterParam.plotMonster
if plotMonster then
xianjieController:openWin('UIXianJie_plotMonsterWin',{cloudid=plotMonster[1],plotIdx=plotMonster[2]})
end
end

function xianjieController:onNormalUpdate_plot(delay)

end

function xianjieController:checkInPlotScene()
return xianjieModel:checkSceneType(xianjienSceneType.eXianJie)and not xianjieModel:checkAllCloudUnlockEx()or not xianjieModel:checkJoin()
end

function xianjieController:checkInPlotScene2()
return not xianjieModel:checkAllCloudUnlockEx()or not xianjieModel:checkJoin()
end

function xianjieController:excuteAllPlotBehavior()
local cloudLookup_=xianjieModel:getCloudLookup()
if cloudLookup_ then
for cloudid,cloudData in pairs(cloudLookup_)do
xianjieController:createCloudSearchEx(cloudData,true)
cloudData:createQiYuEntity(true)
xianjieController:excuteAllCloudPlotBehavior(cloudData,true)
if cloudData:isUnlock()then
xianjieModel:createAllCloudPlotEntity(cloudData,true)
end
end
end
end

function xianjieController:excuteAllPlotBehavior2()
local cloudLookup_=xianjieModel:getCloudLookup()
if cloudLookup_ then
for cloudid,cloudData in pairs(cloudLookup_)do
xianjieController:excuteAllCloudPlotBehavior(cloudData,true)
if cloudData:isUnlock()then
xianjieModel:createAllCloudPlotEntity(cloudData,true)
end
end
end
end

function xianjieController:excuteAllPlotBehavior3()
local cloudLookup_=xianjieModel:getCloudLookup()
if cloudLookup_ then
for cloudid,cloudData in pairs(cloudLookup_)do
xianjieController:excuteAllCloudPlotBehavior(cloudData,true)
end
end
end



function xianjieController:createCloudSearch(cloudid,isStart)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
xianjieController:createCloudSearchEx(cloudData,isStart)
end
end

function xianjieController:createCloudSearchEx(cloudData,isStart)
local idx=cloudData.idx
local typo=cloudData:getCurType(idx)
if typo==xjCloudSearchType.eBegin then

local teamHandle=cloudData:getTeamHandle()
if teamHandle:checkMove(false)then
if xianjieController:checkInPlotScene()then
xianjieController:createCloudSearch_goto(cloudData,isStart)
end
else
xianjieController:reqSearchCloudIdx(cloudData.cloudid,idx+1)
end
elseif typo==xjCloudSearchType.eGoto or typo==xjCloudSearchType.eEvent then

if xianjieController:checkInPlotScene()then
xianjieController:createCloudSearch_search(cloudData,isStart)
end
else

local teamHandle=cloudData:getTeamHandle()
if cloudData.hasDZ and teamHandle:checkMove(true)then
if xianjieController:checkInPlotScene()then
xianjieController:createCloudSearch_goto(cloudData,isStart)
end
else
cloudData:clearBehaviorEx()
end
end
end


function xianjieController:CloudSearchProgressHandle(cloudid)

end

function xianjieController:createCloudSearch_goto(cloudData,isStart)
local cloudid=cloudData.cloudid
cloudData:initBehaviorData()
local initData=cloudData.behaviorData
local finishCB=function(tree)
xianjieModel:clearCloudBehavior(cloudid,tree)
xianjieController:createCloudSearch(cloudid,true)
end
cloudData.behaviorID=xjBehaviorManager:createTree('goto_search_cloud',initData,finishCB,isStart)
end

function xianjieController:createCloudSearch_search(cloudData,isStart)
local cloudid=cloudData.cloudid
cloudData:initBehaviorData()
local initData=cloudData.behaviorData
local finishCB=function(tree)
xianjieModel:clearCloudBehavior(cloudid,tree)
xianjieController:createCloudSearch(cloudid,true)
end
cloudData.behaviorID=xjBehaviorManager:createTree('search_cloud',initData,finishCB,isStart)
end

function xianjieController:jumpCloudQiYu(cloudid)

local cloudData=xianjieModel:getCloudData(cloudid)
local qyData=cloudData:getQiYuData()
if qyData then
local cloudPos=qyData:getWorldPos()
local height=xianjieController:getLampLookAtCameraheight(25,1)
xianjieController:lookAtPositionChangeHeight(cloudPos,height,0.2,nil,DG.Tweening.Ease.Linear)
end
end

function xianjieController:jumpOpenCloudQiYu(cloudid)

local cloudData=xianjieModel:getCloudData(cloudid)
local qyData=cloudData:getQiYuData()
if qyData then
local cloudPos=qyData:getWorldPos()
local _fun=function()

xianjieModel:CloudjumpqiyuZY(qyData.cloudid,qyData.idx,qyData,nil)
end
local height=xianjieController:getLampLookAtCameraheight(25,1)
xianjieController:lookAtPositionChangeHeight(cloudPos,height,0.2,_fun,DG.Tweening.Ease.Linear)

end
end

function xianjieController:doCloudQiYu(cloudid,idx)
local explore=cfgHelper.get3(cfg_fairylandcloudunlockconfig_get,cloudid,idx,'explore')
xianjieController:doCloudMysteryEvent(explore[2],1,cloudid,idx)
end

function xianjieController:doCloudQiYuEx(cloudid)
local cloudData=xianjieModel:getCloudData(cloudid)
local qyData=cloudData:getQiYuData()
if qyData then
xianjieController:doCloudQiYu(qyData.cloudid,qyData.idx)
end
end

function xianjieController:doCloudMysteryEvent(eventGroupId,eventtype,cloudid,idx)



local param={MysteryEventSendType.eXianJie,eventtype,cloudid,idx}


local guidList={}







MysteryEventSystem.event_start(SYSTEM_DEFINE.eJiuChongTianJieComplete,eventGroupId,guidList,param)

end

function xianjieController:checkClickCloud(sceneidx,gridX,gridZ,isValid)
local cloudid=nil
if isValid then
local cloudid_=xianjieModel:caculationCloudID(gridX,gridZ)
if cloudid_ then
local cloudEntData=xianjieModel:getCloudEntityData(cloudid_)
if cloudEntData and cloudEntData:checkSameScene(sceneidx)then
cloudid=cloudid_
end
end
end
if cloudid~=nil then
xianjieController:handleClickCloud(cloudid)
return true
end
return false
end

function xianjieController:handleClickCloud(cloudid)
xianjieController:closeWin3()
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then



local typo=cloudData:getCurType()
if typo==xjCloudSearchType.eBegin or typo==xjCloudSearchType.eGoto or typo==xjCloudSearchType.eEvent then
xianjieController:openSeardCloudInfoWin(cloudid)
else

if cloudData:canUnlock()then


local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local cloudPos=cloudEntData:getWorldPos()
local _fun=function()

xianjieModel:CloudjumpqiyuZY(cloudEntData.cloudid,cloudData.idx+1,nil)
end
xianjieController:lookAtPositionChangeHeight(cloudPos,25,0.2,_fun,DG.Tweening.Ease.Linear)
elseif not cloudData:isUnlock()then

xianjieController:jumpCloudQiYu(cloudid)
end
end
else

xianjieController:openSeardCloudInfoWin(cloudid)
end
end

function xianjieController:openSeardCloudInfoWin(cloudid)
UIManager:showWindow('UIXianJie_cloudInfoWin',{cloudid=cloudid})
end

function xianjieController:checkSeardCloudSelectDZ(cloudid,disguid,isWarning)
local cond=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'disciple')
if cond then
for i,cnd in ipairs(cond)do
if cnd[1]==1 then
local typo=cnd[2]
local v=eSpecialAttrFunc:getValue(typo,disguid)
local vv=cnd[3]
if v<vv then
if isWarning then
local str=FMT.fmt('仙界辽阔，需要{0}{1}以上弟子方能查探仙雾',eSpecialAttrName:getName(typo),eSpecialAttrFunc:getValueStr(typo,disguid,vv))
UIManager.error(str)
end
return false
end
end
end
end
return true
end

function xianjieController:checkSeardCloudOpen(cloudid,warning)
local cond=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'condition')
if cond then
for i,cnd in ipairs(cond)do
if cnd[1]==1 then
if not taskModel:checkTaskFinish(cnd[2])then
local taskCfg=taskModel:getTaskConfig(cnd[2])
if warning then
UIManager.info(FMT.fmt("完成主线·{0}后解锁",taskCfg.name))
end
return false,FMT.fmt("需完成主线·{0}",taskCfg.name)
end
end
end
end
return true
end

function xianjieController:openSeardCloudSelectDZ(cloudid)
local args={
openType=dzSelectWinOpenType.eXianJieSearch,
callback=function(guid)
return xianjieController:reqSearchCloud(cloudid,guid)
end,
select_dis=nil,
cloudid=cloudid,
}
discipleSelectController:openDiscipleSelect(args,"选择弟子")
end

function xianjieController:checkCloudUnlockAnim(cloudid)
return cloudUnlockAnimMark[cloudid]~=nil
end


function xianjieController:testLockCloud(cloudid)
cloudUnlockAnimMark[cloudid]=true
local unlockList=xianjieModel:getCloudLockList2(cloudid)
xianjieController:setFogState(unlockList,1,0,nil)
xianjieController:unLockCloudResPoint(cloudid)
end


function xianjieController:playUnlockCloud(cloudid)
cloudUnlockAnimMark[cloudid]=true
local cloudPos
local height
local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local unlockPos=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'unlockPos')
if unlockPos then
cloudPos=xianjieController:worldGridPos2WorldPos4(unlockPos[1][1],unlockPos[1][2])
height=unlockPos[2]
else
cloudPos=cloudEntData:getWorldPos()
local range=xianjieController:getCameraZoomRange()
height=range[2]
end
local func=function()
local unlockList=xianjieModel:getCloudLockList2(cloudid)
xianjieController:setFogState(unlockList,0,2,nil)
xianjieModel:removeCloudEntity(cloudid)

UIManager.info('解锁成功')
timeEventController.delayDo(2,function()
cloudUnlockAnimMark[cloudid]=nil
xianjieController:unLockCloudResPoint(cloudid)
notifySystem:postNotify(notifyConfig.onXianJieCloudUnlock,cloudid)
end)
end
xianjieController:lookAtPosition(cloudPos,height,0.2,func,DG.Tweening.Ease.Linear)
end

function xianjieController:unLockCloudResPoint(cloudid)
local scrtype=xjResPointSourceType.ePlot
local sceneidx=xianjieModel:getSceneIndex()
local resDatas=xianjieModel:findResPointsBySource(scrtype,sceneidx,{cloudid=cloudid})
local entkeys={}
local n=0
if resDatas then
for _,resData in ipairs(resDatas)do
local entkey=resData:getEntityKey()
if entkey~=nil then
n=n+1
entkeys[n]=entkey
end
end
end
if n>0 then
xianjieController:setEntitysLogicShow(entkeys)
end
end





function xianjieController:excuteAllCloudPlotBehavior(cloudData,isStart)
local cloudPlotlp=cloudData.cloudPlotlp
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
local state=cloudData:checkCloudPlotState(plotIdx)
if xjCloudPlotStateType:checkDoing(state)then
if state==xjCloudPlotStateType.eBattle then
xianjieController:createCloudPlotBehavior_battle(cloudPlotData,isStart)
elseif state==xjCloudPlotStateType.eRetract then
xianjieController:createCloudPlotBehavior_retract(cloudPlotData,isStart)
else
xianjieController:createCloudPlotBehavior_goto(cloudPlotData,isStart)
end
end
end
end
end

function xianjieController:createCloudPlotBehavior(cloudid,plotIdx,isStart)
local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
local state=cloudData:checkCloudPlotState(plotIdx)
if xjCloudPlotStateType:checkDoing(state)then
if cloudPlotData.behaviorID then
local winParams={cloudid=cloudid,plotIdx=plotIdx}
winParams.lookAtPos=cloudPlotData:getWorldPos()
xianjieController:openWin('UIXianJie_plotMonsterWin',winParams)
else
if state==xjCloudPlotStateType.eBattle then
xianjieController:createCloudPlotBehavior_battle(cloudPlotData,isStart)
elseif state==xjCloudPlotStateType.eRetract then
xianjieController:createCloudPlotBehavior_retract(cloudPlotData,isStart)
else
xianjieController:createCloudPlotBehavior_goto(cloudPlotData,isStart)
end
end
else
if state==xjCloudPlotStateType.eNone then
local winParams={cloudid=cloudid,plotIdx=plotIdx}
winParams.lookAtPos=cloudPlotData:getWorldPos()
xianjieController:openWin('UIXianJie_plotMonsterWin',winParams)
else
cloudPlotData:clearBehaviorEx()
cloudData:finishCloudPlotDataEx(plotIdx)
end
end
elseif typo==xjCloudPlotType.eQiYuEvent then
if not cloudData:checkCloudPlotFinish(plotIdx)then
if not cloudData:checkCloudPlotParam(plotIdx)then
local eventGroupId=cloudPlotData.cfg.data[2]
xianjieController:doCloudMysteryEvent(eventGroupId,2,cloudid,plotIdx)
else
xianjieController:reqFinishCloudPlot(cloudid,plotIdx,nil)
end
else
cloudData:finishCloudPlotDataEx(plotIdx)
end
elseif typo==xjCloudPlotType.eTask then
if not cloudData:checkCloudPlotFinish(plotIdx)then
xianjieController:reqFinishCloudPlot(cloudid,plotIdx,nil)
else
cloudData:finishCloudPlotDataEx(plotIdx)
end
end
end

function xianjieController:createCloudPlotBehavior_goto(cloudPlotData,isStart)
local cloudid=cloudPlotData.cloudid
local plotIdx=cloudPlotData.plotIdx
cloudPlotData:initBehaviorData()
local initData=cloudPlotData.behaviorData
local finishCB=function(tree)
xianjieModel:clearCloudPlotBehavior(cloudid,plotIdx,tree)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
local state=cloudData:checkCloudPlotState(plotIdx)
if state~=xjCloudPlotStateType.eNone then
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
end
end
end
cloudPlotData.behaviorID=xjBehaviorManager:createTree('plot_goto',initData,finishCB,isStart)
end

function xianjieController:createCloudPlotBehavior_battle(cloudPlotData,isStart)
local cloudid=cloudPlotData.cloudid
local plotIdx=cloudPlotData.plotIdx
cloudPlotData:initBehaviorData()
local initData=cloudPlotData.behaviorData
local finishCB=function(tree)
xianjieModel:clearCloudPlotBehavior(cloudid,plotIdx,tree)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
cloudData:finishCloudPlotDataEx(plotIdx)
end
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
end
cloudPlotData.behaviorID=xjBehaviorManager:createTree('plot_battle',initData,finishCB,isStart)
end

function xianjieController:createCloudPlotBehavior_retract(cloudPlotData,isStart)
local cloudid=cloudPlotData.cloudid
local plotIdx=cloudPlotData.plotIdx
cloudPlotData:initBehaviorData()
local initData=cloudPlotData.behaviorData
local finishCB=function(tree)
xianjieModel:clearCloudPlotBehavior(cloudid,plotIdx,tree)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
cloudData:retractCloudPlotData(plotIdx)
end
end
cloudPlotData.behaviorID=xjBehaviorManager:createTree('plot_retract',initData,finishCB,isStart)
end























function xianjieController:reqPlotInit()
socketManager:send_37_1()
end



function xianjieController:reqSearchCloud(cloudid,disguid)


if not xianjieController:checkSeardCloudSelectDZ(cloudid,disguid,true)then
return false
end
local discipleList={}
for i=1,5 do
if i==4 then
table.insert(discipleList,disguid)
else
table.insert(discipleList,int64.new('0'))
end
end
socketManager:send_37_2(cloudid,#discipleList,discipleList)


return true
end


function xianjieController:reqSearchCloudIdx(cloudid,idx)


socketManager:send_37_3(cloudid,idx)
end


function xianjieController:reqFinishCloudPlot(cloudid,plotIdx,dzlist)




local curTime=gameUtilityModel.getServerShortTime()
local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local plotParams=nil
local typo=cloudPlotData:getCurType()
local teamHandle
if typo==xjCloudPlotType.eMonster then
teamHandle=cloudPlotData:getTeamHandle()







local speedlist=cloudPlotData:getBaseSpeedList()
local zmData=xianjieModel:getMyZongMenData()
local zmpos={zmData.sceneidx,zmData.gridX,zmData.gridZ}
local wayTime1=teamHandle:getMoveWayTime(false)
local wayTime2=teamHandle:getMoveWayTime(true)
local costTime={wayTime1,wayTime2,cloudPlotData.battleTime}
plotParams={speedlist,zmpos,0,dzlist,costTime}
elseif typo==xjCloudPlotType.eQiYuEvent then


plotParams={curTime}
else

end
local march
if plotParams then
march=xianjieModel:encodeCloudPlotParams(cloudData,plotIdx,plotParams)
else
march=cloudData.march
end
socketManager:send_37_4(cloudid,plotIdx,march)
if teamHandle then
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end
end


function xianjieController:reqMoveZMPos_plot(sceneidx,x,y)



socketManager:send_37_32(sceneidx,x,y)
end


function xianjieController:reqCloudPlotSpeedUp(cloudid,plotIdx,itemid,isRetract)
local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle
local plotParams=cloudData:getCloudPlotParams(plotIdx)
local speedlist=plotParams[1]
if isRetract then
speedlist=plotParams[6][2]
teamHandle=cloudPlotData:getTeamHandle_retract()
else
speedlist=plotParams[1]
teamHandle=cloudPlotData:getTeamHandle()
end
local speed=speedlist[#speedlist]
local speed_={}
local accelerate=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'accelerate')
local speedRate=accelerate[itemid]/100
speed_.param_1=gameUtilityModel.getServerShortTime()
speed_.param_2=speed.param_2*(1+speedRate)
table.insert(speedlist,speed_)
teamHandle:onSpeedUp()
if isRetract then
local wayTime=teamHandle:calculateMoveWayTime()
plotParams[6][1]=wayTime
else
local wayTime1=teamHandle:calculateMoveWayTime(false)
local wayTime2=teamHandle:calculateMoveWayTime(true)
local costTime={wayTime1,wayTime2,cloudPlotData.battleTime}
plotParams[5]=costTime
end
local march=xianjieModel:encodeCloudPlotParams(cloudData,plotIdx,plotParams)
socketManager:send_37_33(itemid,cloudid,march)


local onSpeedUpFunc=cloudPlotData:getBehaviorData('onSpeedUp')
if onSpeedUpFunc then
onSpeedUpFunc()
end
UIManager.info('加速成功')
end


function xianjieController:reqCloudPlotRetract(cloudid,plotIdx)
local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle_retract()
teamHandle:onRetract()
local march=cloudData:retractCloudPlot(plotIdx)
socketManager:send_37_4(cloudid,plotIdx,march)

UIManager.info('召回成功')

cloudPlotData:clearBehaviorEx()

local teamHandleID=cloudPlotData.teamHandleID
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
if teamHandle then
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end
end


function xianjieController:reqGetCloudUnlockReward(recv_idx)
socketManager:send_37_97(recv_idx)
end


function xianjieController:reqGetCloudUnlockQueue()
socketManager:send_37_99()
end





function xianjieController.recv_protocol_37_1(args)
















xianjieModel:initData_plot(args[2],args[3],args[5])
xianjieModel:setFeiShengRank(args[6])
end


function xianjieController.recv_protocol_37_2(cloudid,disciplelistlen,discipleList)




xianjieModel:newCloudData(cloudid,discipleList)
xianjieController:createCloudSearch(cloudid,true)
UIManager:invokeUIMethod('UIXianJie_cloudInfoWin','refreshInfo')
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapInfoWin','refreshInfo')
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','refreshInfo')
end


function xianjieController.recv_protocol_37_3(cloudid,idx)



local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then

cloudData.idx=idx
local typo=cloudData:getCurType(idx)





if typo==xjCloudSearchType.eGoto then
if cloudData.behaviorID then
local isReqData=cloudData:getBehaviorData('isReqData')
if isReqData then
cloudData:setBehaviorData('isReqData',nil)
cloudData:setBehaviorData('isGotoOver',true)
xjBehaviorManager:triggerUpdate(cloudData.behaviorID)
end
else
xianjieController:createCloudSearchEx(cloudData,true)
end
elseif typo==xjCloudSearchType.eEvent then
if cloudData.behaviorID then
local isReqData=cloudData:getBehaviorData('isReqData')
local reqIndex=cloudData:getBehaviorData('reqDataIndex')
if isReqData and reqIndex==idx then
cloudData:setBehaviorData('isReqData',nil)
xjBehaviorManager:triggerUpdate(cloudData.behaviorID)
end
else
xianjieController:createCloudSearchEx(cloudData,true)
end
elseif typo==xjCloudSearchType.eBack then
cloudData:initQiYuEntity()
if cloudData.behaviorID then
cloudData:setBehaviorData('isSearchOver',true)
xjBehaviorManager:triggerUpdate(cloudData.behaviorID)
else
xianjieController:createCloudSearchEx(cloudData,true)
end
elseif typo==xjCloudSearchType.eQiYuEvent then
cloudData:initQiYuEntity()
elseif typo==xjCloudSearchType.eUnlock then
cloudData:initQiYuEntity()
cloudData:CloudUnLockEntityrunAnim()
xianjieModel:refreshAllCloudUnlock()
xianjieController:playUnlockCloud(cloudid)
end
cloudData:createCloudUnLockEntity()


if cloudData:isSearchBack()then
local teamHandleID=cloudData.teamHandleID
if teamHandleID then
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
end
end
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','refreshItem',cloudid)
notifySystem:postNotify(notifyConfig.onXianJieMsgChange,1)
end
end


function xianjieController.recv_protocol_37_4(cloudid,plotIdx,finish)




local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
if finish==1 then
cloudData:finishCloudPlotData(plotIdx)
end
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
if cloudPlotData.behaviorID then
local isReqData=cloudPlotData:getBehaviorData('isReqData')
if isReqData then
cloudPlotData:setBehaviorData('isReqData',nil)
cloudPlotData:setBehaviorData('isGotoOver',true)
xjBehaviorManager:triggerUpdate(cloudPlotData.behaviorID)
end
else
local state=cloudData:checkCloudPlotState(plotIdx)
if state==xjCloudPlotStateType.eGoto then
UIManager.info('派遣成功')
end
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
end
UIManager:invokeUIMethod('UIXianJie_plotMonsterWin','refreshView',cloudid,plotIdx)
elseif typo==xjCloudPlotType.eQiYuEvent then
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
elseif typo==xjCloudPlotType.eTask then
UIManager.info('任务接取成功')
xianjieController:createCloudPlotBehavior(cloudid,plotIdx,true)
end
UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','refreshItem',cloudid)
notifySystem:postNotify(notifyConfig.onXianJieMsgChange,1)
end


function xianjieController.recv_protocol_37_32(sceneidx,x,y)




xianjieModel:changeMyZongMenPos(sceneidx,x,y,0)
end


function xianjieController.recv_protocol_37_33(itemid,cloudid,march)





end


function xianjieController.recv_protocol_37_96(recv_idx,is_recv_queue)

xianjieModel:changeCloudRewardRecvIdx(recv_idx,is_recv_queue)

UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','initRewardPanel',true)
notifySystem:postNotify(notifyConfig.onXianJieMsgChange,1)
end


function xianjieController.recv_protocol_37_99()
xianjieModel:changeCloudRecvQueue()

UIManager:invokeUIMethod('UIXianJie_cloudUnlockMapWin','initRewardPanel',true)

UIManager:showWindow('UICommonShowPrizeXJAddTeamWin',{})
notifySystem:postNotify(notifyConfig.onXianJieCloudUnlockAddQueue)
notifySystem:postNotify(notifyConfig.onXianJieMsgChange,1)
end

