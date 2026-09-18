






local _MODULENAME="huntMonsterTeamController"

gameState.addListener(def_table(_MODULENAME))
huntMonsterTeamController.name=_MODULENAME


function huntMonsterTeamController:onAppStart()
huntMonsterTeamModel:onAppStart()

notifySystem:listenNotify(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)

notifySystem:listenNotify(notifyConfig.onMissionChangeStateInWorld,self.onMissionChangeStateInWorld)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)


end


function huntMonsterTeamController:onEnterState(isReconnect)
huntMonsterTeamModel:onEnterState()
end


function huntMonsterTeamController:onProtocolReq()
huntMonsterTeamModel:onProtocolReq()
end


function huntMonsterTeamController:onLeaveState(isReconnect)
huntMonsterTeamModel:onLeaveState(isReconnect)


end


function huntMonsterTeamController:onLostConnection()

end


function huntMonsterTeamController:onReConnection(isInitPro)

end



function huntMonsterTeamController:onToggleShowWin(world)
local show=self:isToggleShowWin()
if show then
UIManager:invokeUIMethod("UIWorldMonsterHurtTeamWin","doCloseAnim")
else
if huntMonsterTeamModel:getWorldMaxNum(world)<=0 then
local list=cfgHelper.get2(cfg_huntmonsterteamworldconfig_get,world,"maxnum")
local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
local worldName=cfgHelper.get2(cfg_worldconfig_get,world,"name")
for i=1,#worldCfg do
local num=list[i]
if num then
UIManager.info(FMT.fmt("解锁{0}{1}个区块后解锁猎妖队功能",worldName,i))
return
end
end
UIManager.info(FMT.fmt("{0}暂未能使用猎妖队功能",worldName))
return
end
self:setSelectWorld(world)
local win=UIManager:findActiveWindow("UIWorldMonsterListWin")
if win then
win:showWindow("UIWorldMonsterHurtTeamWin",{parentWin=win})
end
end
end


function huntMonsterTeamController:isToggleShowWin()
return UIManager:isActive("UIWorldMonsterHurtTeamWin",true)
end

function huntMonsterTeamController:isSelectedWorld()
local selectedWorld=huntMonsterTeamModel:getSelectWorld()
return selectedWorld~=nil and selectedWorld>0
end


function huntMonsterTeamController:refreshShowWin(world)
if huntMonsterTeamModel:getWorldMaxNum(world)<=0 then
UIManager:invokeUIMethod("UIWorldMonsterHurtTeamWin","doCloseAnim")
return
end
local show=self:isToggleShowWin()
if show then
self:setSelectWorld(world)
end
end

function huntMonsterTeamController:openShowWin(world)
if huntMonsterTeamModel:getWorldMaxNum(world)<=0 then
UIManager:invokeUIMethod("UIWorldMonsterHurtTeamWin","doCloseAnim")
return
end
self:setSelectWorld(world)
local show=self:isToggleShowWin()
if not show then
local win=UIManager:findActiveWindow("UIWorldMonsterListWin")
if win then
win:showWindow("UIWorldMonsterHurtTeamWin",{parentWin=win})
end
end
end


function huntMonsterTeamController:addSelectMonster(unitKey,world)
if not huntMonsterTeamModel:checkMonsterDataExist(unitKey)then
UIManager.info("怪物挑战中或已消失")
return
end

local cur=huntMonsterTeamModel:getSelectMonsterCount()
local max=huntMonsterTeamModel:getWorldMaxNum(world)
if cur<max then
local taskKey=worldTaskModel:findTaskKey_ByTarget(unitKey)
if not taskKey then
huntMonsterTeamModel:addSelectMonster(unitKey)
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,1,{unitKey})
return
else
local task=worldTaskModel:getTask(taskKey)
if task.progress_state>=eWorldTripProgress.Back then
huntMonsterTeamModel:addSelectMonster(unitKey)
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,1,{unitKey})
return
end
end
UIManager.info("已派遣队伍战斗")
else
UIManager.info("狩猎选择数量已满")
end
end


function huntMonsterTeamController:removeSelectMonster(unitKey)
huntMonsterTeamModel:removeSelectMonster(unitKey)
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,-1,{unitKey})
end

function huntMonsterTeamController:checkMonsterDataRefresh()
local keys=huntMonsterTeamModel:checkAndRefreshSelectMonsterList()
if#keys>0 then
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,-1,keys)
end
end


function huntMonsterTeamController:setSelectDisciple(selectList,zfid)
huntMonsterTeamModel:setSelectDisciple(selectList)
huntMonsterTeamModel:setSelectZhenFa(zfid)

notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectDiscipleChange)
end


function huntMonsterTeamController:clearAllSelect()
self:setSelectWorld(-1)
end


function huntMonsterTeamController:setSelectWorld(world)
if not huntMonsterTeamModel:checkSelectWorld(world)then
huntMonsterTeamModel:setSelectWorld(world)
end

notifySystem:postNotify(notifyConfig.onHuntMonsterTeamSelectWorldChange,world)
end


function huntMonsterTeamController:checkStartUpdate()
if huntMonsterTeamModel:existOneTeam()and not self.updating then
timeEventController.addNormalTimerHandler(1,self.name,self)
end
end


function huntMonsterTeamController:checkStopUpdate()
if not huntMonsterTeamModel:existOneTeam()and self.updating then
timeEventController.removeNormalTimerHandler(1,self.name)
end
end


function huntMonsterTeamController:onNormalUpdate(delay)
local teams=huntMonsterTeamModel:getAllTeams()
if next(teams)then
for world,data in pairs(teams)do
if not huntMonsterTeamModel:isTeamComplete(data)and huntMonsterTeamModel:checkFightMoment(data)then
if huntMonsterTeamModel:checkFightCondition(data)then

self:reqTeamFight(data)
else

self:passTeamFight(data)
end
self:nextTeamProgress(data)
end
end
else
self:checkStopUpdate()
end
end


function huntMonsterTeamController:reqTeamFight(data)
local unitKey=data.monsters[data.progress]
local mCfg=huntMonsterTeamModel:getMonsterGroupConfig(unitKey)
local fightType,param1,param2,param3=huntMonsterTeamModel:getMonsterDataFightParam(unitKey)
local teamList=fightPreSelectModel.convertDisciple2FightStruct(data.team)
fightLaunchController:sendFight(fightType,teamList,mCfg.mapId or 0,data.zfId,{param1,param2,param3})

end


function huntMonsterTeamController:recvTeamFightResult(result,log,world,unitKey)

if result==fightResultType.Victory then
local logPackage=fightResultModel:getPackageResutl(log)
local rewards=logPackage.prizeList or{}

huntMonsterTeamModel:addFightVictory(world,unitKey,rewards)
huntMonsterTeamModel:doAfterFightVictory(unitKey)

if(fullScreenUI.activeUI==nil or fullScreenUI.isActiveBaseFull())and MysteryModel:get_cur_fbid()==nil then
for i,v in ipairs(rewards)do
local iconName=itemsModel.getIconName(v)
local numStr=FMT.fmt('X{0}',v.num)
UIManager.rewardInfo(iconName,numStr)
end
end







end

huntMonsterTeamModel:deleteMonsterWorld(unitKey)




















notifySystem:postNotify(notifyConfig.onHuntMonsterTeamFight,result,world,unitKey)
end

function huntMonsterTeamController:nextTeamProgress(data)





huntMonsterTeamModel:setProgressPass(data.world)

self:triggerTaskExpression(data)






self:refreshMoneyPlan()

if huntMonsterTeamModel:isTeamComplete(data)then
self:reqEndTeam(data.world)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eWorldResPoint)

local world=data.world
local since=data.sinceTime

timeEventController.delayDo(10,function()
local teamData=huntMonsterTeamModel:getTeamData(world)

if not teamData then
return
end
if teamData.sinceTime~=since then
return
end

local winType=#teamData.victory>0 and msgWinType.eHuntMonsterTeamComplete or msgWinType.eHuntMonsterTeamLose
local winArgs=teamData
msgWinControl:addMsgWin(winType,winArgs,{},false)
end)
end
end


function huntMonsterTeamController:passTeamFight(data)

local unitKey=huntMonsterTeamModel:getCurrentMonster(data)
huntMonsterTeamController:recvTeamFightResult(fightResultType.Lose,nil,data.world,unitKey)
end


function huntMonsterTeamController:refreshMoneyPlan()
local teams=huntMonsterTeamModel:getAllTeams()
local num=0
for world,data in pairs(teams)do
local sIdx=data.running and data.progress or(data.progress+1)
local eIdx=huntMonsterTeamModel:isTeamStop(data)and data.progress or#data.monsters
for i=sIdx,eIdx do
num=num+data.cost[i]
end
end
moneyPlanModel:setPlanNumber(eMoneyType.mtLingPai,SYSTEM_DEFINE.eHuntMonsterTeam,num)
end


function huntMonsterTeamController:reqStartTeam()
local world=huntMonsterTeamModel:getSelectWorld()
local team=huntMonsterTeamModel:getSelectDisciple()
local zfId=huntMonsterTeamModel:getSelectZhenFa()
local monster=huntMonsterTeamModel:getSelectMonster()

if not huntMonsterTeamModel:existSendData(world)then



huntMonsterTeamModel:setSendData(world,monster)
worldTaskController:startMission(eWorldUnitTpye.HUNTMONSTERTEAM,int64.zero,world,team,zfId)
else

end
end

function huntMonsterTeamController:reqStopTeam(world)
local data=huntMonsterTeamModel:getTeamData(world)
huntMonsterTeamModel:setTeamStop(data)
huntMonsterTeamModel:pauseTeam(data)
self:reqEndTeam(world)



end


function huntMonsterTeamController:reqEndTeam(world)
local targetKey=worldModel:convertUnitKey({eWorldUnitTpye.HUNTMONSTERTEAM,world})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then
worldTaskController:returnMission(taskKey)
end
end


function huntMonsterTeamController.onStartMissionInWorld(id,target_type,target_id,team)
if target_type==eWorldUnitTpye.HUNTMONSTERTEAM then
local task=worldTaskModel:getTask(id)
local world=target_id
local monsters=huntMonsterTeamModel:getSendData(world)
monsters=huntMonsterTeamModel:checkMonsterDataList(monsters)
huntMonsterTeamModel:startTeam(world,team,monsters,task.zhenfa_id)
huntMonsterTeamModel:setSelectWorld(-1)
huntMonsterTeamModel:clearSendData(world)
huntMonsterTeamController:checkStartUpdate()
huntMonsterTeamController:refreshMoneyPlan()






huntMonsterTeamController:triggerTaskExpressionEx(task)

local count=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTaskNum,"HuntMonsterTeamStartCount",0)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eTaskNum,"HuntMonsterTeamStartCount",count+1,0)

notifySystem:postNotify(notifyConfig.onHuntMonsterTeamStartTeam,world)
end
end












function huntMonsterTeamController.onMissionChangeStateInWorld(taskKey,target_type,target_id,target_guid,newState,oldState)
if target_type==eWorldUnitTpye.HUNTMONSTERTEAM then
if newState>=eWorldTripProgress.Back then
local world=target_id
local data=huntMonsterTeamModel:getTeamData(world)
if data and huntMonsterTeamModel:isTeamStop(data)then
huntMonsterTeamController:cancelTeamData(data)
end
end
end
end

function huntMonsterTeamController.onTaskChange(taskid,taskstate)
local taskCfg=cfgHelper.get1(cfg_taskconfig_get,taskid)
local tasktype=taskCfg.tasktype
if tasktype==taskTypeClientCheckType.eHunrMonsterTeamStart and taskstate==taskModel.taskFinishState then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eTaskNum,"HuntMonsterTeamStartCount",0,0)
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamStartTeamClear)
end
end

function huntMonsterTeamController:cancelTeamData(data)
local unitKey=huntMonsterTeamModel:getCurrentMonster(data)

huntMonsterTeamModel:deleteTeamData(data.world)
huntMonsterTeamController:refreshMoneyPlan()
notifySystem:postNotify(notifyConfig.onHuntMonsterTeamEndTeam,data.world)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eWorldResPoint)
end

function huntMonsterTeamController:showUnitFighting(unitKey)
if unitKey and worldController:isInWorld()then
local obj=worldController:getUnit(unitKey)
if obj then
obj:StopModelEffect(worldDispatchFactory.fightEffect)
obj:ShowShadow(false)
obj:PlayModelEffect(worldDispatchFactory.fightEffect,Vector3.zero,Vector3.one)
obj:ChangeModelColor(Color.clear,0)
end
end
end

function huntMonsterTeamController:hideUnitFighting(unitKey)
if unitKey and worldController:isInWorld()then
local obj=worldController:getUnit(unitKey)
if obj then
obj:ShowShadow(true)
obj:StopModelEffect(worldDispatchFactory.fightEffect)
obj:ChangeModelColor(Color.white,0)
end
end
end

function huntMonsterTeamController:triggerTaskExpression(data)
if worldController:isInWorld()then
local targetKey=worldDispatchFactory:getUnitKey(eWorldUnitTpye.HUNTMONSTERTEAM,int64.zero,data.world)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
self:triggerTaskExpressionEx(task)
end
end
end

function huntMonsterTeamController:triggerTaskExpressionEx(task)

if task and task.show and task.progress_state==eWorldTripProgress.Work then
local tripProgress=task.expression[task.progress_state]
if tripProgress.startNextPart then
tripProgress:startNextPart()
end
end
end










