






local _MODULENAME="yunjiayingController"

gameState.addListener(def_table(_MODULENAME))
yunjiayingController.name=_MODULENAME
yunjiayingController.data={}

function yunjiayingController:onAppStart()

yunjiayingModel:onAppStart()



socketManager:register_receiver(6,121,self.recv_6_121)
socketManager:register_receiver(6,122,self.recv_6_122)
socketManager:register_receiver(6,123,self.recv_6_123)









end


function yunjiayingController:onEnterState(isReconnect)
yunjiayingModel:onEnterState()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end


function yunjiayingController:onProtocolReq()
yunjiayingModel:onProtocolReq()
end


function yunjiayingController:onLeaveState(isReconnect)
yunjiayingModel:onLeaveState(isReconnect)

self.data={}
end


function yunjiayingController:onLostConnection()

end


function yunjiayingController:onReConnection(isInitPro)

end

function yunjiayingController:onEnterHome()

local lastAddRate=yunjiayingModel:getTrainLastAddRate()
local nowAddRate=yunjiayingModel:getTrainAddRate()
if nowAddRate~=lastAddRate then

yunjiayingModel:initTrainListTime()
end
end

function yunjiayingController:onLeaveHome()

end



function yunjiayingController:reqGetYunJiaYingData()
socketManager:send_6_121()
end


function yunjiayingController:reqBuyExtraTrainCountByMoney(buyCount)
socketManager:send_6_122(buyCount)
end


function yunjiayingController:reqStartTrain(trainList)
socketManager:send_6_124(#trainList,trainList)
end


function yunjiayingController:reqCancelTrain(trainIdx)
socketManager:send_6_125(trainIdx)
end


function yunjiayingController:reqFinishTrain(over)
socketManager:send_6_126(over)
end


function yunjiayingController:reqFastFinishTrain(ubdId,startId,targetId,count,cost,needStart)
if needStart then
local trainList={{startId,targetId,count}}

yunjiayingController:reqStartTrain(trainList)
end


local baseCfg=cfgHelper.get(cfg_monijybasicconfig_get,1,'reduce_times')
local costParamList=baseCfg[speedUpMode.eMoneyBuilding]
local costParam=costParamList[SLG_SYSTEM_TYPE.eYunJiaYing]
local singleMoneyCount=costParam[2]
local allMoneyCount=cost[2]
local speedUpNum=math.ceil(allMoneyCount/singleMoneyCount)
zongmenControl:reqSpeedup(speedUpMode.eMoneyBuilding,0,0,speedUpType.eYunJiaYingTrain,mapIdType.fort,0,{{ubdId,speedUpNum,cost[1]}})
end


function yunjiayingController.recv_6_121(moneyNum,rechargeNum,beginTime,len,trainList)
local originalBeginTime=yunjiayingModel:getTrainBeginTime()or 0
yunjiayingModel:initYunJiaYingData(moneyNum,rechargeNum,beginTime,len,trainList)
if originalBeginTime>0 and beginTime~=originalBeginTime then
yunjiayingController:onTrainSpeedUpRecv()
else

UIManager:invokeUIMethod("UIYunJiaYingWin","refresh")

UIManager:invokeUIMethod("UIYunJiaYing_batchWin","refresh")
end

local isHasTrain=len>0
yunjiayingController:refreshYJYHUD(isHasTrain)
end


function yunjiayingController.recv_6_122(moneyNum)
yunjiayingModel:setMoneyNum(moneyNum)
UIManager.info("解锁成功")

UIManager:invokeUIMethod("UIYunJiaYing_batchWin","refresh")
yunjiayingController:refreshYJYHUD()
end


function yunjiayingController.recv_6_123(rechargeNum)
yunjiayingModel:setRechargeNum(rechargeNum)
UIManager.info("解锁成功")

UIManager:invokeUIMethod("UIYunJiaYing_batchWin","refresh")
yunjiayingController:refreshYJYHUD()
end


function yunjiayingController.recv_6_124(len,trainList)








end


function yunjiayingController.recv_6_125(idx)








end


function yunjiayingController.recv_6_126(over)








end




function yunjiayingController:tryToFinishTrain()

if yunjiayingModel:checkHasGotTrain()then

yunjiayingController:reqFinishTrain(0)
end
end


function yunjiayingController:onTrainSpeedUpRecv()

UIManager:invokeUIMethod("UIYunJiaYingWin","refresh")

UIManager:invokeUIMethod("UIYunJiaYing_batchWin","getSortSpeedUpItemList",true)
UIManager:invokeUIMethod("UIYunJiaYing_batchWin","refresh")


yunjiayingController:tryToFinishTrain()
end

function yunjiayingController:refreshYJYHUD(isHasTrain)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if bdData then
if isHasTrain==true then
buildingCDControl:addCDData(buildingCDType.xjtrain,bdData)
elseif isHasTrain==false then
buildingCDControl:removeCDData(buildingCDType.xjtrain,bdData.un_build_id)
end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)

end
end


function yunjiayingController.on_building_event(etype,sfId,bdId,oldLevel)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not bdData then
return
end

if bdData.un_build_id~=bdId then
return
end

if etype==buildingEvent.levelUpComplete then

local win=UIManager:findActiveWindow("UIYunJiaYingWin")
if win and win.isVisible then
win:checkUnlockSoldierShow(bdData.level)
else

oldLevel=oldLevel or bdData.level-1
if oldLevel<=0 then
oldLevel=1
end
local lastSaveOldLevel=userActorSetting.get("yunjiaying_unlock_oldLevel",nil)
if not lastSaveOldLevel then
userActorSetting.set("yunjiaying_unlock_oldLevel",oldLevel)
userActorSetting.flush()
end
end
end
end

function yunjiayingController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
yunjiayingController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
yunjiayingController:onLeaveHome()
end
end
