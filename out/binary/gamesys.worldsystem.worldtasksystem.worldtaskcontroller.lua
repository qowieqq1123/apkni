






local _MODULENAME="worldTaskController"




gameState.addListener(def_table(_MODULENAME))

worldTaskController.name=_MODULENAME


worldTaskController.data={}

local _this=worldTaskController
local _initSendData=nil

local _checkTarget={




[eWorldUnitTpye.MYSTERY]=function(world,id,guid)
local typo=MysteryModel:get_mystery_sence_type(id)
if typo==MysterySenceType.World then
local data=MysteryModel:get_mysteryFB_list_data_fbid(id)
return data~=nil
elseif typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(id)
if data then
for i,v in pairs(data.datas)do
if v[1]==eWorldResPointUnitType.Monster then
MysteryController.send_4_4(id)
end
end
return false
else
return true
end


end
return true
end,
[eWorldUnitTpye.EXPERIENCE]=function(world,id,guid)
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,id)
local check=worldBlockModel:checkBlockState(fogCfg.world,fogCfg.block,eWorldBlockState.UNLOCK)
return check
end,
[eWorldUnitTpye.TOURPOINT]=function(world,id,guid)
local slot=chuanSongZhenModel:findDiscipleSlot(world,guid)
return slot~=nil
end,
[eWorldUnitTpye.HUNTMONSTERTEAM]=function(world,id,guid)
return false
end,
}


function worldTaskController:onAppStart()
worldDispatchFactory:onAppStart()
worldTaskModel:onAppStart()





socketManager:register_receiver(5,81,self.recv_5_81)
socketManager:register_receiver(5,82,self.recv_5_82)
socketManager:register_receiver(5,83,self.recv_5_83)
socketManager:register_receiver(5,84,self.recv_5_84)


notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickTaskDisciple)

notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)

worldController:registerSceneState(1,2,function()
worldTaskModel:restartWorldTask(worldModel.world)
UIManager:invokeUIMethod("UIWorldWin","refreshTaskList")
end)
worldController:registerSceneState(2,2,function()
worldTaskModel:quitWorldTask(worldModel.world)

end)
end


function worldTaskController:onEnterState()
worldTaskModel:onEnterState()


end

function worldTaskController:onProtocolReq()
worldTaskModel:checkCorrect()
timeEventController.addQuickTimerHandler(_MODULENAME,_this)
if worldController:isInWorld()then
worldTaskModel:restartWorldTask(worldModel.world)
UIManager:invokeUIMethod("UIWorldWin","refreshTaskList")
end
end


function worldTaskController:onServerDataInitFinish()
worldTaskModel:onServerDataInitFinish()
end


function worldTaskController:onLeaveState(isReconnet)
if not isReconnet then
worldTaskModel:onLeaveState()
end
_initSendData=nil

if worldController:isInWorld()then
worldTaskModel:quitWorldTask(worldModel.world)
self:cancelAllFakeTask(worldModel.world)
end
self.data={}
timeEventController.removeQuickTimerHandler(_MODULENAME)
end


function worldTaskController:onLostConnection()
timeEventController.removeQuickTimerHandler(_MODULENAME)
end

function worldTaskController:onReConnection()
timeEventController.addQuickTimerHandler(_MODULENAME,_this)
end







function worldTaskController:send_5_3(unitType,tableId,len,array,zfId)
socketManager:send_5_3(unitType,tableId,len,array,zfId or 0)
end






function worldTaskController:send_5_4(key,isCompleted,len,array)
socketManager:send_5_4(key,isCompleted,len,array)
end

function worldTaskController:send_5_81()
socketManager:send_5_81()
end

function worldTaskController:send_5_82(task)
socketManager:send_5_82(worldDispatchFactory:unpackTask(task))
end

function worldTaskController:send_5_83(task)
socketManager:send_5_83(worldDispatchFactory:unpackTask(task))
end

function worldTaskController:send_5_84(taskKey)
socketManager:send_5_84(taskKey)
end







function worldTaskController.recv_5_3(args)























end




function worldTaskController.recv_5_4(key,isCompleted)







end

function worldTaskController.recv_5_81(len,taskList)
worldTaskModel:clearInvalidKey()
for taskKey,task in pairs(worldTaskModel:getAllTaskingRecord())do
worldTaskModel:removeTask(taskKey)

end

for index,taskData in ipairs(taskList or{})do
local task=worldDispatchFactory:packTask(taskData)
if not worldTaskController:checkFakeType(task.target_type)then
worldTaskModel:setTask(task)
else
worldTaskModel:addInvalidKey(task.id)
end
end
worldModel:finishInit(eWorldUnitTpye.MISSION)
if initProControl.isDone()and worldController:isInWorld()then
worldTaskModel:restartWorldTask(worldModel.world)
UIManager:invokeUIMethod("UIWorldWin","refreshTaskList")
end
end

function worldTaskController.recv_5_82(taskData,code)
local taskKey=taskData.key
local task=worldTaskModel:getTask(taskKey)

if task then
if task.state~=eWorldTripState.Unplayed then
loggerUtil.logErrFMT("大世界派遣队伍问题：接受到派遣开始下发，但前端派遣已出发,{0},{1},{2}",taskKey,task.state,serializeHelper.serialize(taskData.guidList))
end
if code~=0 and task.state==eWorldTripState.Unplayed then
worldTaskModel:removeTask(taskKey.key)
end
end

if code==1 then
return UIManager.error("派遣所需消耗不足")
elseif code>=11 and code<=15 then
local index=code-10
local discipleGuid=taskData.guidList[index]
return UIManager.error("弟子{0}忠诚度不足",UIDiscipleModel:getDiscipleName(discipleGuid)or index)
elseif code>=21 and code<=25 then
local index=code-10
local discipleGuid=taskData.guidList[index]
return UIManager.error("弟子{0}负伤值过高",UIDiscipleModel:getDiscipleName(discipleGuid)or index)
elseif code>=31 and code<=35 then
local index=code-10
local discipleGuid=taskData.guidList[index]
return UIManager.error("弟子{0}寿元不足",UIDiscipleModel:getDiscipleName(discipleGuid)or index)
elseif code>=41 and code<=45 then
local index=code-10
local discipleGuid=taskData.guidList[index]
return UIManager.error("弟子{0}状态冲突",UIDiscipleModel:getDiscipleName(discipleGuid)or index)
elseif code~=0 then
return UIManager.error(FMT.fmt("派遣失败，错误码：{0}",code))
end

if not task then

task=worldDispatchFactory:packTask(taskData)
worldTaskModel:setTask(task)
end
worldTaskModel:checkNewTaskDisciple(taskKey)

task.state=eWorldTripState.Running
if worldModel:isSameWorld(task.world)and worldController:isInWorld()and not task.show then
local serverTime=timeHelper.getServerShortTime()
task:start(serverTime)
worldTaskModel:startUnitTaskHandle(task.target_type,task.target_guid,task.target_id,task.destination)
end

notifySystem:postNotify(notifyConfig.onStartMissionInWorld,task.id,task.target_type,task.target_id,task.team)
end

function worldTaskController.recv_5_83(taskData)
local taskKey=taskData.key
local task=worldTaskModel:getTask(taskKey)
if not task then

task=worldDispatchFactory:packTask(taskData)
worldTaskModel:setTask(task)
elseif task.state==eWorldTripState.Unplayed then
loggerUtil.logErrFMT("大世界派遣队伍问题：接受到派遣改变下发，但前端派遣未出发,{0}",taskKey,serializeHelper.serialize(taskData.guidList))
end

task.state=eWorldTripState.Running
local oldState=task.progress_state
task.progress_state=taskData.dispatch_state
task.progress_begin=taskData.begin_time
task.progress_end=taskData.end_time
if oldState~=task.progress_state then

if task.show and task.expression then
local expression=task.expression[oldState]
if expression then
expression:quit()
end

local expression=task.expression[task.progress_state]

if expression then
local fast=timeHelper.getServerShortTime()-task.progress_begin

expression:start(fast)
end
end
end
notifySystem:postNotify(notifyConfig.onMissionChangeStateInWorld,taskKey,task.target_type,task.target_id,task.target_guid,task.progress_state,oldState)

if task.progress_state>=eWorldTripProgress.Back then

if UIManager:isActive("UIDiscipleRoleInfoWin")then
UIManager:invokeUIMethod('UIDiscipleRoleInfoWin','refreshPos')
end
if UIManager:isActive("UIDiscipleRoleInfo2Win")then
UIManager:invokeUIMethod('UIDiscipleRoleInfo2Win','refreshPos')
end
end

local check=task:checkTeam(taskData.guidList)
if check<0 then
task:changeTeamForce(taskData.guidList)
elseif check>0 then
task:changeTeamPos(taskData.guidList)
end
end

function worldTaskController.recv_5_84(taskKey)
local task=worldTaskModel:getTask(taskKey)
worldTaskModel:removeTask(taskKey)

notifySystem:postNotify(notifyConfig.onStopMissionInWorld,task.id,task.target_type,task.target_id)
end






function worldTaskController:activeWorldMission()
local serverTime=timeHelper.getServerShortTime()
for taskKey,task in ipairs(worldTaskModel:getAllTaskingRecord())do
if worldModel:isSameWorld(task.world)and not task.show then
task:start(serverTime)
end
end
end

function worldTaskController:unactiveWorldMission()
local serverTime=timeHelper.getServerShortTime()
for taskKey,task in ipairs(worldTaskModel:getAllTaskingRecord())do
if task.show then
task:quit()
end
end
end





function worldTaskController:startMission(targetType,targetGuid,targetId,lockDisciples,zfId)
local disciples=lockDisciples or{}
if#disciples<=0 then

return false
elseif#disciples~=5 then

return false
end





if targetType~=eWorldUnitTpye.MONSTER and targetType~=eWorldUnitTpye.RESPOINT
and targetType~=eWorldUnitTpye.TOURPOINT and targetType~=eWorldUnitTpye.MYSTERY then

local ret,moneyType=worldTaskModel:checkStartCost(targetType,targetId)
if ret==false then

UIManager.error("消耗不足")
gainControl:showGainWin(moneyType)
return false
end
end

local check=worldDispatchFactory:checkTargetData(targetType,targetGuid,targetId)
if not check then

return false
end

local task=worldDispatchFactory:createTask(targetType,targetGuid,targetId,lockDisciples,zfId)
worldTaskModel:setTask(task)
self:send_5_82(task)

return true
end
















function worldTaskController:returnMission(taskKey)
local task=worldTaskModel:getTask(taskKey)
if task~=nil then

task:back()
else

end
end






function worldTaskController.initTasking(len,array)
worldTaskModel:saveTempInitRecord(array or{})
worldModel:finishInit(worldModel.UNITTYPE.MISSION)
end











function worldTaskController:showTaskDisciple(taskKey,discipleGuid,needHUD,click)

local pos=worldPositionConfig:getPosition_CurrentWorld(
cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"mainCityPos"))
if not pos then return end

local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(discipleGuid)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelParams.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4

local mSetting=CS.WorldEntitySetting.New(
mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value")),
height*scale,nil,
modelParams.body,modelParams.componets,
"Entity",scale,Vector3.zero)

if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
local mHUDSetting=nil
if needHUD then
local hudData=cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleHUD","value")
mHUDSetting=worldModel:getHUDSetting(hudData[1])
end
worldController:pushUnit(worldTaskModel:convertMissionUnitKey(taskKey,discipleGuid),pos,
{worldModel.UNITTYPE.MISSION,taskKey,discipleGuid},mSetting,mHUDSetting,nil,click or false)
end




function worldTaskController:hideTaskDisciple(taskKey,discipleGuid)

local unitKey=worldTaskModel:convertMissionUnitKey(taskKey,discipleGuid)
worldController:popUnit(unitKey)
end



function worldTaskController:onQuickUpdate(delta)
worldTaskModel:onQuickUpdate(delta)
end

function worldTaskController.onClickTaskDisciple(args)
if args and args[1]==worldModel.UNITTYPE.MISSION then
local taskKey=args[2]
local task=worldTaskModel:getTask(taskKey)
if task then
if task.target_type==worldModel.UNITTYPE.TOURPOINT and task.progress_state==eWorldTripProgress.Work then
UIManager:showWindow("UIWorldTourRecallDialog",task.target_id)
end
end
end
end







function worldTaskController.onDiscipleRemove(reason,discipleGuid)
local taskKey=worldTaskModel:findTaskKey_ByDiscipleGUID(discipleGuid)
if taskKey then
worldTaskModel:subtractTaskDisciple(taskKey,{discipleGuid})
worldTaskModel:checkTaskDiscipleCount(taskKey)
end
end

function worldTaskController:fakeExperienceTask(world,block)
local targetKey=worldExperienceModel:convertTaskTargetKey(world,block)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then return end

local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local fakePosition=worldController:getMainCityPoint(world)
local array={int64.zero,int64.zero,int64.zero,int64.zero,int64.zero}
local discipleData=worldExperienceController:getFakeTaskAllDiscipleScr(world,block)
local count=0
for i,guidinfo in pairs(discipleData)do
local discipleguid=guidinfo.discipleguid
local job=UIDiscipleModel:getDiscipleJob(discipleguid)
local jobCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,job)
local pospriorty=jobCfg.pospriorty
if pospriorty then
for j,w in ipairs(pospriorty)do
if array[w]==int64.zero then
array[w]=discipleguid
count=count+1
break
end
end
else
for j,w in ipairs(array)do
if w==int64.zero then
array[w]=discipleguid
count=count+1
break
end
end
end
if count>=5 then
break
end
end
local task=worldDispatchFactory:createTask(eWorldUnitTpye.EXPERIENCE,int64.zero,blockCfg.fog2,array,0)
worldTaskModel:setTask(task)
self:send_5_82(task)
end

function worldTaskController.onSystemZMDiscipleChange(serial,newVal,oldVal)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
worldTaskController:backFakeTask(eWorldUnitTpye.SYSTEMZM,serial,0)
if worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)and mathHelper.compareInt64(newVal)then
local dzList={newVal}
for i=1,4 do
table.insert(dzList,int64.zero)
end
worldTaskController:newFakeTask(eWorldUnitTpye.SYSTEMZM,serial,0,dzList)
end
end
end

function worldTaskController:onHandleErrData()
local max=worldTaskModel:getTaskMax()
for i=1,max do
if worldTaskModel:containTask(i)then

local task=worldTaskModel:getTask(i)

local rList={}
for index,discipleguid in pairs(task.disciples)do
local disData=UIDiscipleModel:getDiscipleData(discipleguid)
if disData==nil then
table.insert(rList,discipleguid)
end
end
if#rList>0 then
loggerUtil.warn(FMT.fmt("初始化数据纠正<派遣>:队伍{0}移除不存在的弟子{1}",i,serializeHelper.serialize(rList)))
task:subtractDisciples(rList)
end

if#task.disciples>0 then

if not self:checkTargetExist(task.target_type,task.world,task.target_id,task.target_guid)then

if task.progress_state<=eWorldTripProgress.Work then
loggerUtil.warn(FMT.fmt("初始化数据纠正<派遣>:队伍{0}目标（{1}-{2}-{3}）已不存在，强制回程",i,task.target_type,task.target_id,tostring(task.target_guid)))
self:returnMission(i)
end
end
end
end
end
end

function worldTaskController:checkTargetExist(typo,world,id,guid)
local check=_checkTarget[typo]
if check then
return check(world,id,guid)
end
return true
end

function worldTaskController:handleErrData_ResPoint(world)
local max=worldTaskModel:getTaskMax()
for i=1,max do
if worldTaskModel:containTask(i)then
local task=worldTaskModel:getTask(i)
if task.world==world then
local check=true
if task.target_type==eWorldUnitTpye.RESPOINT then
local data=worldResPointDataModel:getSubPointData(task.target_guid,task.target_id)
check=data~=nil
elseif task.target_type==eWorldUnitTpye.MYSTERY then
local typo=MysteryModel:get_mystery_sence_type(task.target_id)
if typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(task.target_id)

check=data~=nil
end
end
if not check then
if task.progress_state<=eWorldTripProgress.Work then
loggerUtil.warn(FMT.fmt("初始化数据纠正<派遣>:队伍{0}目标（{1}-{2}-{3}）已不存在，强制回程",i,task.target_type,task.target_id,tostring(task.target_guid)))
self:returnMission(i)
end
end
end
end
end
end























function worldTaskController.gm_ClearAllTask()
for i,v in pairs(worldTaskModel:getAllTaskingRecord())do
_this:returnMission(v.id)

end

end
