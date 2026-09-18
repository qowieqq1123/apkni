







local _MODULENAME="worldMonsterController"
gameState.addListener(def_table(_MODULENAME))
worldMonsterController.name=_MODULENAME


local monsterAddTimer



function worldMonsterController:onAppStart()

worldController:registerSceneState(1,1,self.enterWorld)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
end

function worldMonsterController:onEnterState(isReconnect)
if not isReconnect then
worldMonsterModel:init_data()
else
worldMonsterModel:init_fighting_list()
end

end

function worldMonsterController:onLeaveState()

end

function worldMonsterController:onProtocolReq()
if worldMonsterController.needRefresh then
worldMonsterProtocolController.req_fresh()
worldMonsterController.needRefresh=false
end
timeEventController.addNormalTimerHandler(2,self.name,self)
end










function worldMonsterController.show_all_monster_unit()
if worldController:isInWorld()then

local monsterList=worldMonsterModel:get_monster_list()
if monsterList then
for i,v in pairs(monsterList)do
for a,b in pairs(v)do

worldMonsterController:add_monster_unit(b.posId,b.posData,b.worldId,b.blockId,b.worldMonsterId)
end
end



end
end
end


function worldMonsterController.clear_all_monster_unit()
if worldController:isInWorld()then
local monsterList=worldMonsterModel:get_monster_sort_list()
if monsterList then
for i,v in ipairs(monsterList)do
worldMonsterController:remove_monster_unit(v.posId,v.posData)
end
end
end
end

function worldMonsterController.enterWorld()
worldMonsterModel:init_fighting_list()
worldMonsterController.show_all_monster_unit()
end


function worldMonsterController:add_monster_unit(posId,posData,world,block,worldMonsterId)

if not posData then
local monster=worldMonsterModel:get_monster_by_posId(posId)
posData=monster.posData
end
if worldModel:isSameWorld(world)and worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then

local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,tostring(posId)})
local cfg=cfgHelper.get1(cfg_worldmonstergroupconfig_get,worldMonsterId)
local modelSettings=worldModel:getModelSettings(cfg.modelRes,eWorldUnitTpye.Monster)
local hudSettings=worldModel:getHUDSetting(cfg.hudRes)
local luaData={eWorldUnitTpye.MONSTER,posId}
local position=worldPositionConfig:getPosition(world,posData)
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
worldUnitModel.speMonster(unitKey)
end
end


function worldMonsterController:remove_monster_unit(posId,posData)





local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,tostring(posId)})
worldController:popUnit(unitKey)

end




















function worldMonsterController.add_monster(areaId,worldMonsterId,level,posGuid)
local library=worldMonsterModel:findAreaLibrary(areaId)
local monster=worldMonsterModel:add_monster(areaId,worldMonsterId,nil,posGuid,level,library)

if monster then
if worldController:isInWorld()then
worldMonsterController:add_monster_unit(monster.posId,monster.posData,monster.worldId,monster.blockId,monster.worldMonsterId)
end
end
end






function worldMonsterController.remove_monster(areaId,posGuid,isFighting)
worldMonsterModel:remove_monster(areaId,posGuid,isFighting)

end



function worldMonsterController.onClickObjectInWorld(args)
if args and args[1]==worldModel.UNITTYPE.MONSTER then

AudioManager.playBtnClick()

local posId=args[2]
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
if huntMonsterTeamModel:findMonsterWorld(key)then
UIManager.info("猎妖队狩猎中")
return
end

local task_data=worldMonsterModel:get_task_result(posId)

if task_data and worldMonsterController:checkFightingState(posId)then
local task_data=worldMonsterModel:get_task_result(posId)
local areaId=task_data[5]
local Idx=task_data[6]
local posData=task_data[2]
local fightResult=task_data[3]
local logIdx=task_data[4]

worldMonsterController.fight(areaId,Idx,posId,posData,fightResult,logIdx)


else
local monster=worldMonsterModel:get_monster_by_posId(posId)
if monster then
local cPos=worldController:getCameraPosition()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit(key,minZoom,false,function()
worldMonsterController.showInfoWin(monster,cPos.y)
end)
end
end
end
end


function worldMonsterController.showInfoWin(monster,height,lookAt)

local guid=monster.guid
local worldMonsterId=monster.worldMonsterId
local areaId,idx=worldMonsterModel:get_idx(guid)
local posData=monster.posData
local config=worldMonsterModel.get_monster_group_config(worldMonsterId)
local mCfg=worldMonsterModel.get_monster_group(worldMonsterId)
if not mCfg then
error("找不到怪物组配置：",worldMonsterId)
return
end
local cost=type(config.cost[1])=="number"and config.cost or config.cost[1]




local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,monster.posId})
local lv=mCfg.levelUp and monster.level or mCfg.level or 1
local items,detail=worldFightModel:getMonsterShowAwards(mCfg.id,lv)
local actRewards=worldFightModel:getMonsterExtraDropActReward(mCfg.id)
local winParam={
groupId=mCfg.id,
name=config.name,
icon=mCfg.model,
level=lv,
skills=mCfg.showSkills,
desc=mCfg.desc,
items=items,
actRewards=actRewards,
title="妖怪信息",
highestType=mCfg.monType,


close=function()
worldController:resetRightView()
end,
cost=type(config.cost[1])=="number"and config.cost or config.cost[1],
detail=detail,
unitKey=unitKey,
returnHeight=height,
challenge=function()
local checkData=worldMonsterModel:get_monster(guid)
if not checkData then
UIManager.error("怪物已离开")
worldController:resetRightView()
return
end

local world=worldModel.world
local pos,block=worldPositionConfig:getPosition_CurrentWorld(posData)
local cState=worldBlockModel:getBlockState(world,block)
if cState~=worldBlockModel.BLOCKSTATE.OPEN then
UIManager.error("区块未解锁")
return
end

if cost and not moneyModel.checkEnoughMoney(cost[1],cost[2])then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(cost[1])))
gainControl:showGainWin(cost[1])
return
end

if cost then
local tipsStr=FMT.fmt("剩余{0}不足{1}，是否继续执行？",itemsConfig.getItemName(cost[1]),cost[2])
moneyPlanModel:checkHandle(cost[1],cost[2],function()
worldMonsterController:select_disciple(guid,idx,height)
end,tipsStr)
else
worldMonsterController:select_disciple(guid,idx,height)
end
end,
giveUp=function()
worldMonsterProtocolController.req_abandon(areaId,guid)
end
}

if lookAt then
local minZoom=worldController:getCameraZoomRange_Normal()[1]
local cb=function()
if UIManager:isActive("UIWorldBossWin")then
UIManager:showWindow("UIWorldBossWin",winParam)
else
worldController:changeRightView("UIWorldBossWin",winParam)
end
end
worldController:lookAtUnit(unitKey,minZoom,false,cb)
else
if UIManager:isActive("UIWorldBossWin")then
UIManager:showWindow("UIWorldBossWin",winParam)
else
worldController:changeRightView("UIWorldBossWin",winParam)
end
end
return true
end




function worldMonsterController:select_disciple(guid,idx,height)




local monster=worldMonsterModel:get_monster(guid)
local posId=monster.posId
local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
if not self:checkMission(guid)then
local worldMonsterId=monster.worldMonsterId
local monsterList,monsterGroupID=worldMonsterModel.get_monster_group_List(worldMonsterId)
local mCfg=worldMonsterModel.get_monster_group(worldMonsterId)
local fightMap=mCfg.mapId or 0
local monster=worldMonsterModel:get_monster_by_posId(posId)
local level=mCfg.levelUp and monster.level or mCfg.level or 1
fightController.showPrepareWin(fightPreSelectModel.fightType.worldMonster,{
enterTxt="妖怪",
isHomeBattle=false,
monsterList=monsterList,
groupId=monsterGroupID,
enterCallBack=function(selectList,zfid)
fightController:closeSelectStage(false)
UIFullFightPrepareControl:closeUI()

local checkData=worldMonsterModel:get_monster(guid)
if not checkData then
UIManager.error("怪物已离开")
return
end


worldMonsterController.startMission(guid,idx,selectList,zfid,fightMap)
worldController:resetLeftView()
worldController:resetRightView()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)

worldController:stopCameraControl()
if not height then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
height=worldCfg.cameraPos[2]
else
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
worldController:lookAtUnit(unitKey,height,false,function()
worldController:resumeCameraControl()
end)

end,
cancelCallBack=function()
worldController:resetLeftView()
worldController:resetRightView()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
end,
fightCompareJingJie=level,
fightCompareTips="敌人实力强大，是否确认？",
})
worldController:changeLeftView()
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
worldController:changeRightView()
else
local task_data=worldMonsterModel:get_task_result(posId)
if task_data then
local areaId=task_data[5]
local Idx=task_data[6]
local posData=task_data[2]
local fightResult=task_data[3]
local logIdx=task_data[4]
if task_data and worldMonsterController:checkFightingState(posId)then
worldMonsterController.fight(areaId,Idx,posId,posData,fightResult,logIdx)
end
end
end
end


function worldMonsterController.fight(areaId,Idx,posId,posData,fightResult,logIdx)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.worldMonster,fightResult,logIdx,posId,posData,{})
end



function worldMonsterController.startMission(guid,idx,teamList,zfId,fightMap)



local monster=worldMonsterModel:get_monster(guid)
local areaId=monster.areaId
local monsterId=monster.worldMonsterId
local posId=monster.posId

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if not taskKey then
local ret,moneyType=worldTaskModel:checkStartCost(worldModel.UNITTYPE.MONSTER,monsterId)
if not ret then

UIManager.error("消耗不足")
gainControl:showGainWin(moneyType)
return
end






else



local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
return UIManager.error("仍在大世界狂奔")
end
end

local disciples=fightPreSelectModel.convertFightStruct2Disciple(teamList)
worldTaskController:startMission(worldModel.UNITTYPE.MONSTER,guid,monster.worldMonsterId,disciples,zfId)

fightLaunchController:sendFight(eBattleLaunch.worldMonster,teamList,fightMap or 0,zfId or 0,{areaId,guid})
end


function worldMonsterController:checkMission(guid)

local monster=worldMonsterModel:get_monster(guid)
local posId=monster.posId

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
UIManager.error("已有队伍派遣")
worldController:lookAtUnit(targetKey)
return true
end
end

return false
end


function worldMonsterController:checkPassForward(posId)

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task then
return task.progress_state>=eWorldTripProgress.Work
end
end
return false
end

function worldMonsterController:checkFightingState(posId)
local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task then
return task.progress_state==eWorldTripProgress.Work
end
end
return false
end

function worldMonsterController:checkPassWait(posId)

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task then
return task.progress_state>eWorldTripProgress.Work
end
end
return false
end


function worldMonsterController:refreshTime()
local lastStamp=worldMonsterModel:get_last_stamp()
if not(self.isEnough()or lastStamp<=-1)then
local cd=lastStamp+worldMonsterModel.get_fresh_time_with_buff()-timeHelper.getServerShortTime()

if cd>0 then
if monsterAddTimer then
monsterAddTimer:cancel()
monsterAddTimer=nil
end
monsterAddTimer=timeEventController.delayDo(cd,function()
if not systemModel.isOpen(SYSTEM_DEFINE.eWorldMonster)then
return
end
worldMonsterProtocolController.req_fresh()


end)
else
if initProControl.isDone()then
if not systemModel.isOpen(SYSTEM_DEFINE.eWorldMonster)then
return false
end

worldMonsterProtocolController.req_fresh()
else
self.needRefresh=true
end
end
end
end



function worldMonsterController:onNormalUpdate(delay)
if not systemModel.isOpen(SYSTEM_DEFINE.eWorldMonster)then
return false
end
local lastStamp=worldMonsterModel:get_last_stamp()
if not(self.isEnough()or lastStamp<=-1)then
local cd=lastStamp+worldMonsterModel.get_fresh_time_with_buff()-timeHelper.getServerShortTime()
if cd<=0 then
if cd%5==0 then
worldMonsterProtocolController.req_fresh()
end
end
end
end

function worldMonsterController.isEnough()
local monsterList=worldMonsterModel:get_monster_sort_list()
if not monsterList then
return false
end
local maxnum=cfgHelper.get1(cfg_worldmonsterconfig_get,1).maxnum
local areaconfig=cfg_worldmonsterareaconfig()
if#monsterList>=maxnum then
return true
else
local areaList=worldMonsterModel:get_monster_list()
local max
local allMax=true
for areaId,monsterList in pairs(areaList)do
if areaconfig[areaId]then
max=areaconfig[areaId].max
local num=0
for i,v in pairs(monsterList)do
num=num+1
end
if num<max then
allMax=false
end
end
end
return allMax
end
end

function worldMonsterController.onWorldPositionReRandom(rData,aData)

if rData.unitType==eWorldUnitTpye.MONSTER then
local posId=rData.key
local monster=worldMonsterModel:get_monster_by_posId(posId)
if monster==nil then
worldPositionLibrary:eraseData(rData.guid)
return loggerUtil.logWarnFMT("顶替怪物 位置重新随机 失败 {0}",tostring(rData.guid))
end
local library=worldMonsterModel:findAreaLibrary(monster.areaId)
local check,temp=worldPositionLibrary:extract(library)

if check then
local posData=temp[1]
local worldId=posData.world
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,blockId=worldPositionConfig:getPosition(worldId,{x,z})
worldPositionLibrary:eraseData(monster.guid)

worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.MONSTER,monster.guid)
monster.worldId=worldId
monster.blockId=blockId
monster.posData={x,z}
monster.flipX=flip
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,tostring(monster.posId)})
worldTaskModel:changeTaskTargetDestination(unitKey)
if worldController:isInWorld()and worldModel:isSameWorld(worldId)then
worldController:setUnitFlipX(unitKey,flip)
worldController:setUnitPosition(unitKey,position)
end
else
loggerUtil.logWarnFMT("顶替怪物 位置重新随机 失败 {0}",tostring(rData.guid))
end
end
end

function worldMonsterController.onWorldBlockDataInited(reInit)
if initProControl.isDone()and worldController:isInWorld()then
worldMonsterController.clear_all_monster_unit()
worldMonsterController.show_all_monster_unit()
end
end
