






local _MODULENAME="seasonController"

local _stageTypeBindLimitAct={
[seasonStageType.eMJHD]=LIMIT_ACT_TYPE.eMoJiang,
}

gameState.addListener(def_table(_MODULENAME))

seasonController.name=_MODULENAME

function seasonController:onAppStart()

seasonModel:onAppStart()







socketManager:register_receiver(39,1,self.recv_39_1)
socketManager:register_receiver(39,2,self.recv_39_2)
socketManager:register_receiver(39,3,self.recv_39_3)
socketManager:register_receiver(39,4,self.recv_39_4)
socketManager:register_receiver(39,5,self.recv_39_5)
socketManager:register_receiver(39,6,self.recv_39_6)
socketManager:register_receiver(39,9,self.recv_39_9)

socketManager:register_receiver(35,95,self.recv_35_95)
socketManager:register_receiver(35,96,self.recv_35_96)
socketManager:register_receiver(35,97,self.recv_35_97)

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function seasonController:onEnterState(isReconnect)
seasonModel:onEnterState()
end


function seasonController:onProtocolReq()
seasonModel:onProtocolReq()
self:checkMountainAllOpen()
timeEventController.addNormalTimerHandler(1,_MODULENAME,self)
end


function seasonController:onLeaveState(isReconnect)
if not isReconnect then
self.req_login_first_mojie_init_data=false
end
seasonModel:onLeaveState(isReconnect)
timeEventController.removeNormalTimerHandler(1,_MODULENAME)
end


function seasonController:onLostConnection()

end


function seasonController:onReConnection(isInitPro)

end

function seasonController:onNormalUpdate()
for season_id,handle in pairs(seasonModel.data)do
handle:onUpdate()
end
end



function seasonController:send_39_1()
socketManager:send_39_1()
end





function seasonController:send_39_2(season_id,chapter_idx,param1,param2,param3)
socketManager:send_39_2(season_id,chapter_idx,param1,param2 or 0,param3 or"")
end


function seasonController:send_39_4(season_id,chapter_idx)
socketManager:send_39_4(season_id,chapter_idx)
end

function seasonController:send_39_5(season_id,chapter_idx)
socketManager:send_39_5(season_id,chapter_idx)
end

function seasonController:send_39_6(season_id,chapter_idx)
socketManager:send_39_6(season_id,chapter_idx)
end

function seasonController:send_35_95()
socketManager:send_35_95()
end

function seasonController:send_39_96(taskId)
socketManager:send_35_96(taskId)
end

function seasonController:send_39_97(taskId)
socketManager:send_35_97(taskId)
end


function seasonController.recv_39_1(len,seasonInfos)
seasonModel:clearData()
for i=1,len do
local serverData=seasonInfos[i]
seasonModel:setHandle(serverData)
end
if initProControl:isDone()then
seasonController:checkMountainAllOpen()
end
notifySystem:postNotify(notifyConfig.onSeasonChange)
end





function seasonController.recv_39_2(season_id,chapter_idx,param1,param2,param3)
local stage=seasonModel:getStage(season_id,chapter_idx)
if stage and stage.on_39_2 then
stage.on_39_2(stage,param1,param2,param3)
end
seasonController:checkMountainOpen(season_id,chapter_idx)
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,season_id,chapter_idx)

seasonController:handleSeasonStageDataChange(season_id,chapter_idx)
end



function seasonController.recv_39_3(season_id,chapter_idx,score,end_time,param1)
local stage=seasonModel:getStage(season_id,chapter_idx)
if stage and stage.on_39_3 then
stage.on_39_3(stage,score,end_time,param1)
end
seasonController:checkMountainOpen(season_id,chapter_idx)
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,season_id,chapter_idx)

seasonController:handleSeasonStageDataChange(season_id,chapter_idx)






end


function seasonController.recv_39_4(season_id,chapterData)
local handle=seasonModel:getHandle(season_id)
local chapter_idx=chapterData.chapter_idx
if handle then
handle:setStage(chapterData)
notifySystem:postNotify(notifyConfig.onSeasonStageChange,season_id,chapter_idx)

seasonController:handleSeasonStageDataChange(season_id,chapter_idx)



end
end

function seasonController.recv_39_5(args)
local season_id=args[1]
local chapter_idx=args[2]
local rank=args[3]
local score=args[4]
local len=args[5]
local rankList=args[6]
seasonModel:setMyRank(season_id,chapter_idx,eSeasonRankType.ePlayer,rank,score)
seasonModel:setRankList(season_id,chapter_idx,eSeasonRankType.ePlayer,rankList or{})
notifySystem:postNotify(notifyConfig.onSeasonRankChange,season_id,chapter_idx,eSeasonRankType.ePlayer)
end

function seasonController.recv_39_6(args)
local season_id=args[1]
local chapter_idx=args[2]
local rank=args[3]
local score=args[4]
local len=args[5]
local rankList=args[6]
seasonModel:setMyRank(season_id,chapter_idx,eSeasonRankType.eGuild,rank,score)
seasonModel:setRankList(season_id,chapter_idx,eSeasonRankType.eGuild,rankList or{})
notifySystem:postNotify(notifyConfig.onSeasonRankChange,season_id,chapter_idx,eSeasonRankType.eGuild)
end

function seasonController.recv_35_95(len,taskList)
if not seasonModel:isInitTaskData()then
taskController:registerTaskCount(seasonController.listenerTaskProgress)
end

for i=1,len do
local taskData=taskList[i]
seasonModel:setTaskData(taskData.param_1,taskData.param_2,taskData.param_3)
end
local stages=seasonModel:findTaskStages()
for i,v in ipairs(stages)do
seasonController:checkMountainOpen(v.handle.id,v.index)
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,v.handle.id,v.index)

seasonController:handleSeasonStageDataChange(v.handle.id,v.index)
end
end

function seasonController.recv_35_96(taskId)
seasonModel:setTaskFlag(taskId)

local stages=seasonModel:findTaskStages(taskId)
for i,v in ipairs(stages)do
seasonController:checkMountainOpen(v.handle.id,v.index)
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,v.handle.id,v.index)

seasonController:handleSeasonStageDataChange(v.handle.id,v.index)
end
end

function seasonController.recv_35_97(taskData)
seasonModel:setTaskData(taskData.param_1,taskData.param_2,taskData.param_3)

local stages=seasonModel:findTaskStages(taskData.param_1)
for i,v in ipairs(stages)do
seasonController:checkMountainOpen(v.handle.id,v.index)
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,v.handle.id,v.index)

seasonController:handleSeasonStageDataChange(v.handle.id,v.index)
end
end

function seasonController.recv_39_9(season_id,chapter_idx,cbid,bufflistlen,bufflist)
local entityData=xianjieModel:getMoJiangEntity(season_id,chapter_idx,cbid)
if entityData then
if bufflistlen>0 and bufflist then
entityData.bufflistlen=bufflistlen
entityData.buffList=bufflist
entityData:refreshEntity()
end
end
end




function seasonController.listenerTaskProgress(list)
local change={}
for i,v in ipairs(list)do
local otherArgs=v.otherArgs
local taskId=otherArgs.taskid
if taskId then
local taskData=seasonModel:getTaskData(taskId)
if taskData and taskData.task_state~=taskModel.taskFinishState and v.current~=taskData.client_progress then
local current=v.current
local previous=taskData.client_progress
taskData.client_progress=current
if taskData.count_flag and not mathHelper.getBitValue(taskData.count_flag,2)then
local oState=taskData.task_state
local nState=current>=taskData.task_target and taskModel.taskRewardState or taskModel.taskDoingState
taskData.task_state=nState
change[taskId]=oState~=nState
end
end
end
end
notifySystem:postNotify(notifyConfig.onSeasonStageTaskChange,change)
end

function seasonController.onSeasonChange()
seasonController:refreshLimitActCondition()
end

function seasonController.onSeasonStageChange(season_id,chapter_idx)
local chapterCfg=seasonModel:getHandleConfig(season_id,"chapter_list",chapter_idx)
local stageType=chapterCfg[2]
local limitActType=_stageTypeBindLimitAct[stageType]
if limitActType then
local limitActInfo=limitActivitiesModel:getActInfo(limitActType)
local oldState=limitActInfo.isOpen
if limitActInfo then
limitActInfo:refreshCondition()
if oldState~=limitActInfo.isOpen then
UIManager:invokeUIMethod("UILimitActStorageWin","refreshView")
UIManager:invokeUIMethod("UIXianJieLimitActStorageWin","refreshView")
end
end
end
end

function seasonController.onNewDay()
for season_id,handle in pairs(seasonModel.data)do
handle:onNewDay()
end
end

function seasonController.onNewDay5am()
for season_id,handle in pairs(seasonModel.data)do
handle:onNewDay5am()
end
end


function seasonController.onTaskChange(taskId,taskstate)
if taskstate==taskModel.taskFinishState then
for season_id,handle in pairs(seasonModel.data)do
handle:onTaskFinish(taskId)
end
end
end

function seasonController:handleSeasonStageDataChange(season_id,chapter_idx)
local handle=seasonModel:getHandle(season_id)
if handle then
local relates=handle:relateHandle(season_id,chapter_idx)
for i,v in ipairs(relates)do
notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,season_id,v)
end
handle:handleEndTime(season_id)
end
end

function seasonController:getSeasonHandleStageProgress(season_id)
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stages=handle:getStages()
local count=0
for i,v in ipairs(stages)do
if v:checkOpen()and v:isOverEnd()then
count=count+1
end
end
return count
end
return 0
end

function seasonController:checkSeasonStageBegined(season_id,chapter_idx)
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:isOverBegin()and stage:checkOpen()or false
end
return false
end

function seasonController:checkSeasonStageBegined_NotCheckCondition(season_id,chapter_idx)
local handle=seasonModel:getHandle(season_id)
if handle then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:isOverBegin()and stage:checkOpen()or false
end
return false
end

function seasonController:checkSeasonStageOpenButNotBegined(season_id,chapter_idx)
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and not stage:isOverBegin()and stage:checkOpen()or false
end
return false
end

function seasonController:checkSeasonStageEnded(season_id,chapter_idx)
if season_id==nil then return false end
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:isOverEnd()and stage:checkOpen()or false
end
return false
end

function seasonController:checkSeasonStageEnded_NotCheckCondition(season_id,chapter_idx)
if season_id==nil then return false end
local handle=seasonModel:getHandle(season_id)
if handle then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:isOverEnd()and stage:checkOpen()or false
end
return false
end

function seasonController:checkSeasonStageBeginedButNotEnded(season_id,chapter_idx)
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:checkOpen()and stage:isOverBegin()and not stage:isOverEnd()or false
end
return false
end


function seasonController:checkSeasonStageEndedForce(season_id,chapter_idx)
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:isOverEnd()or false
end

function seasonController:checkSeasonStageOpen(season_id,chapter_idx)
local stage=seasonModel:getStage(season_id,chapter_idx)
return stage and stage:checkOpen()or false
end

function seasonController:checkSeasonHandleOpen(season_id)
local handle=seasonModel:getHandle(season_id)
return handle and handle:checkCondition()and handle:checkOpen()or false
end

function seasonController:checkSeasonHandleComplete(season_id)
local handle=seasonModel:getHandle(season_id)
return handle and handle:checkCondition()and handle:checkComplete()or false
end

function seasonController:checkSeasonHandleCompleteButNotOver(season_id)
local handle=seasonModel:getHandle(season_id)
return handle and handle:checkCondition()and handle:checkComplete()and not handle:isOver()or false
end

function seasonController:checkSeasonHandleStageAllEnd(season_id)
local handle=seasonModel:getHandle(season_id)
local nowTime=timeHelper.getServerShortTime()
if handle and handle.endTime>0 and nowTime>=handle.endTime then
local chapter_list=handle:getConfig("chapter_list")
for i,v in ipairs(chapter_list)do
local stage=handle:getStage(i)
if stage==nil or not stage:isOverEnd()then
return false
end
end
return true
end
return false
end

function seasonController:checkMountainOpen(season_id,chapter_idx)
local list=seasonModel:checkMountainOpen(season_id,chapter_idx)
if#list>0 then
for i,v in ipairs(list)do
zongmenControl:reqUnlockMountain(v,0,{})
end
end
end

function seasonController:checkMountainAllOpen()
local list=seasonModel:checkAllMountainOpen()
if#list>0 then
for i,v in ipairs(list)do
zongmenControl:reqUnlockMountain(v,0,{})
end
end
end

function seasonController:markOpenAnimRecord(season_id,chapter_idx,status)
seasonModel:markOpenAnimRecord(season_id,chapter_idx,status)
self:checkMountainOpen(season_id,chapter_idx)
end

function seasonController:mojie_login_first_req_init_data()
if not self.req_login_first_mojie_init_data then
self.req_login_first_mojie_init_data=true
seasonController:send_39_1()
end
end

function seasonController:jumpGate()
local minGate=xianjieModel:getMinHpMoJieGateIdWithSelfXMAttacking()

local jumpArgs={id=JUMP_TYPE.eMoJieGate,args={}}

if minGate then
jumpArgs.args.gateid=minGate
else
local gates=xianjieModel:getMoJieGateIdListWithSelfXianYu()
jumpArgs.args.gateid=gates[1]
end

jumpManager:jump(jumpArgs)
end

function seasonController:refreshLimitActCondition()
for i,v in pairs(_stageTypeBindLimitAct)do
local limitActInfo=limitActivitiesModel:getActInfo(v)
if limitActInfo then
limitActInfo:refreshCondition()
end
end
UIManager:invokeUIMethod("UILimitActStorageWin","refreshView")
UIManager:invokeUIMethod("UIXianJieLimitActStorageWin","refreshView")
end