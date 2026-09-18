






local _MODULENAME="chuanSongZhenController"




gameState.addListener(def_table(_MODULENAME))
chuanSongZhenController.name=_MODULENAME



local _this=chuanSongZhenController
local _updateCheck=nil

function chuanSongZhenController:onAppStart()

chuanSongZhenModel:onAppStart()







socketManager:register_receiver(5,91,self.recv_5_91)
socketManager:register_receiver(5,92,self.recv_5_92)
socketManager:register_receiver(5,93,self.recv_5_93)
socketManager:register_receiver(5,94,self.recv_5_94)
socketManager:register_receiver(5,95,self.recv_5_95)

worldController:registerSceneState(1,1,function()
self:onEnterWorld(worldModel.world)
end)

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onZheXianLingProgressChange,self.onZheXianLingProgressChange)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.shilianta_change,self.on_shilianta_change)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)
end


function chuanSongZhenController:onEnterState(isReconnect)
chuanSongZhenModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)

eventTextNotifyControl.register(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziYouli},self.onRecvEventMesg)
end


function chuanSongZhenController:onLeaveState(isReconnect)
self.init=false
chuanSongZhenModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)

eventTextNotifyControl.unregister(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziYouli},self.onRecvEventMesg)


end


function chuanSongZhenController:onLostConnection()

end


function chuanSongZhenController:onReConnection(isInitPro)

end


function chuanSongZhenController:onProtocolReq()




worldTaskController:remakeAllFakeTask_Tour()

if not self.init then
self.init=true

notifySystem:postNotify(notifyConfig.onTravelInited)
end
end

function chuanSongZhenController:onNormalUpdate()
local temp=chuanSongZhenModel:checkReward()
if temp~=_updateCheck then
_updateCheck=temp
self:refreshAllBuildingHUD()
end
end

function chuanSongZhenController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
_updateCheck=nil
timeEventController.addNormalTimerHandler(2,_this.name,_this)
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(2,_this.name)
end
end

function chuanSongZhenController.on_money_changed(moneyType,lastVal,val)
if chuanSongZhenModel:checkMoneyListenXX(moneyType)then
for i,v in pairs(mapIdType)do
local datas=zongmenModel:getBuildingDataByBdType(v,SLG_SYSTEM_TYPE.eChuanSongZhen)
for i,v in ipairs(datas)do
if chuanSongZhenModel:checkMoneyListenXX(moneyType,v.level)then
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end
end
end

function chuanSongZhenController.on_building_event(etype,param1,param2)
if etype==buildingEvent.zongmenLevelUp then
chuanSongZhenController:refreshAllBuildingHUD()
elseif etype==buildingEvent.buildComplete then
chuanSongZhenController:refreshAllBuildingHUD()
end
end

function chuanSongZhenController.onZheXianLingProgressChange()
chuanSongZhenController:refreshAllBuildingHUD()
end

function chuanSongZhenController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskFinishState then
chuanSongZhenController:refreshAllBuildingHUD()
end
end

function chuanSongZhenController.on_shilianta_change()
chuanSongZhenController:refreshAllBuildingHUD()
end

function chuanSongZhenController.onRecvEventMesg(mesg,eventid,paramList,timeStamp)
chuanSongZhenModel:recordEvent(mesg,eventid,paramList,timeStamp)
UIManager:invokeUIMethod("UIChuanSongZhenWin","setChatContent")
end

function chuanSongZhenController.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local data,world,index=chuanSongZhenModel:findDiscipleData(discipleguid)
if data then
if cur then
local now=timeHelper.getServerShortTime()
data.dead=now

chuanSongZhenController:stopMission(world,discipleguid)
else
local now=timeHelper.getServerShortTime()
local dead=chuanSongZhenModel:getWorldDead(world)
if dead>0 then
local time=chuanSongZhenModel:getTimeData(world)
if time then
time=time+(now-dead)
else
time=timeHelper.getServerShortTime()
end
chuanSongZhenModel:setTimeData(world,time)
end

local temp=now-data.dead
data.money=data.money+temp
data.item=data.item+temp
data.dead=0


chuanSongZhenController:startMission(world,discipleguid)
end
end
end
end


function chuanSongZhenController:send_5_91()
socketManager:send_5_91()
end

function chuanSongZhenController:send_5_92(worldid,discipleguid)
socketManager:send_5_92(worldid,discipleguid)

chuanSongZhenController:startMission(worldid,discipleguid)
end

function chuanSongZhenController:send_5_93(worldid,discipleguid)
socketManager:send_5_93(worldid,discipleguid)

chuanSongZhenController:stopMission(worldid,discipleguid)
end

function chuanSongZhenController:send_5_94(worldid,assist)
socketManager:send_5_94(worldid,assist or 0)
end

function chuanSongZhenController:send_5_95(world,block)
socketManager:send_5_95(world,block)
end

function chuanSongZhenController:send_5_96()
socketManager:send_5_96()
end

function chuanSongZhenController.recv_5_91(len,list)
worldTaskController:cancelAllFakeTask(nil,eWorldUnitTpye.TOURPOINT)

chuanSongZhenModel:setDatas(list)

chuanSongZhenController:refreshAllBuildingHUD()

if initProControl.isDone()then
chuanSongZhenController.init=true
worldTaskController:remakeAllFakeTask_Tour()

notifySystem:postNotify(notifyConfig.onTravelInited)
end
end

function chuanSongZhenController.recv_5_92(worldid,discipleguid,beginTime)
local dead=chuanSongZhenModel:getWorldDead(worldid)
local index=chuanSongZhenModel:startData(worldid,discipleguid,beginTime)
if dead>0 then
chuanSongZhenModel:setTimeData(worldid,beginTime)
else
chuanSongZhenModel:addTimeData(worldid,beginTime)
end

chuanSongZhenController:refreshAllBuildingHUD()

notifySystem:postNotify(notifyConfig.onTravelChange,1,worldid,index,discipleguid)
end

function chuanSongZhenController.recv_5_93(worldid,discipleguid,moneyduration,itemduration)
local index=chuanSongZhenModel:findDiscipleSlot(worldid,discipleguid)
if index then
chuanSongZhenModel:endData(worldid,index,moneyduration,itemduration)
end
chuanSongZhenModel:delTimeData(worldid)

chuanSongZhenController:refreshAllBuildingHUD()

notifySystem:postNotify(notifyConfig.onTravelChange,0,worldid,index,discipleguid)
end

function chuanSongZhenController.recv_5_94(travelInfo)
local duration=chuanSongZhenModel:getMaxDuration(travelInfo.worldid)
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
if duration>=limit then
local disciples=chuanSongZhenModel:getDisciples(travelInfo.worldid)
local count=#disciples
local times=cfgHelper.get3(cfg_eventbaseconfig_get,1,'travelconf',7)
local add=times[count]
if add then
eventYouLiControl:addTime(travelInfo.worldid,timeHelper.getServerShortTime()+add)
end
end
chuanSongZhenModel:setData(travelInfo)
chuanSongZhenModel:resetTimeData(travelInfo.worldid)

chuanSongZhenController:refreshAllBuildingHUD()

notifySystem:postNotify(notifyConfig.onTravelReward,travelInfo.worldid)
end

function chuanSongZhenController.recv_5_95(world,block)
chuanSongZhenModel:setFlagBit(world,block)


local config=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
local args={
world=world,
block=block,
pos=config.pos,
model1=config.model_temp[1],
model2=config.model_temp[2],
effect=config.effect,
unitKey=chuanSongZhenModel:convertUnitKey(world,block),
}
worldStoryAIManager:startStoryBehavior("bw_chuansongzhen",args,function()
chuanSongZhenController:repairEntity(world,block)
chuanSongZhenController:resumePanel()
end)


notifySystem:postNotify(notifyConfig.onChuanSongZhenUnlock,world,block)
end




















function chuanSongZhenController:startMission(world,discipleguid)
local task=worldTaskModel:findTaskKey_ByDiscipleGUID(discipleguid)
if task==nil then
local dzList={discipleguid}
for i=1,4 do
table.insert(dzList,int64.zero)
end

worldTaskController:newFakeTask(eWorldUnitTpye.TOURPOINT,discipleguid,world,dzList)
end
end

function chuanSongZhenController:stopMission(world,discipleguid)
local targetKey=chuanSongZhenModel:getTaskTarget(world,discipleguid)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then

worldTaskController:backFakeTask(eWorldUnitTpye.TOURPOINT,discipleguid,world)
end
end

function chuanSongZhenController:refreshAllBuildingHUD()

for k,w in pairs(mapIdType)do
local datas=zongmenModel:getBuildingDataByBdType(w,SLG_SYSTEM_TYPE.eChuanSongZhen)
for i,v in ipairs(datas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end

function chuanSongZhenController.onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eChuanSongZhenAllReward then

local tipsid=effectData.tipsid
table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
local tips=showPrizeControl.getTips(tipsid)

if UIManager:isActive('UIChuanSongZhenWaitRewardWin',true)then
chuanSongZhenModel:setRewardInfo({temp,tips})
else
showPrizeControl.showWindow(temp,nil,{tips=tips})
end
end
end

function chuanSongZhenController.showPrize()
local showRewardInfo=chuanSongZhenModel:getRewardInfo()
if showRewardInfo then
local temp=showRewardInfo[1]
local tips=showRewardInfo[2]

showPrizeControl.showWindow(temp,nil,{tips=tips})
end
end

