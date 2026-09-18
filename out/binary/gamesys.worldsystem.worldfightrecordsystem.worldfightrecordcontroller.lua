






local _MODULENAME="worldFightRecordController"





gameState.addListener(def_table(_MODULENAME))

worldFightRecordController.name=_MODULENAME


worldFightRecordController.data={}

local _addRecord_handle={
[eBattleLaunch.resPoint]="addRecord_ResPoint",
[eBattleLaunch.worldMonster]="addRecord_WorldMonster",
[eBattleLaunch.family]="addRecord_Family",
}


function worldFightRecordController:onAppStart()

worldFightRecordModel:onAppStart()








notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)


end


function worldFightRecordController:onEnterState()
worldFightRecordModel:onEnterState()
end


function worldFightRecordController:onServerDataInitFinish()
worldFightRecordModel:onServerDataInitFinish()
end

function worldFightRecordController:onProtocolReq()
worldFightRecordModel:onProtocolReq()
end


function worldFightRecordController:onLeaveState()
worldFightRecordModel:onLeaveState()

self.data={}
end


function worldFightRecordController:onLostConnection()

end










function worldFightRecordController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eDispatchRecord then

end
end

function worldFightRecordController.enoughOpenDialogueConditon()
if systemModel.isOpen(SYSTEM_DEFINE.eDispatchRecord)and
mainViewsControl.isOpen()and
worldController:checkNoticiateBlockOpen()and
fightController.curBattle==nil then
if mainControl:isInScene(eSceneType.eZongmen)then
return not shiLianTaModel.data.isFighting
elseif mainControl:isInScene(eSceneType.eWorld)then
return not worldExperienceModel:checkScene()and not MysteryModel:is_enter_Mystery()
end
end
return false
end

function worldFightRecordController:checkAndOpenDialogue()
if self:enoughOpenDialogueConditon()then
UIManager:showWindow("UIWorldFightRecordDialogueWin")
end
end

function worldFightRecordController:addRecord(eFight,result,logStr,prize,data)
if not systemModel.isOpen(SYSTEM_DEFINE.eDispatchRecord)then return end

local handle=_addRecord_handle[eFight]
if handle then
for i,v in ipairs(prize)do
if not v.itemcount then
v.itemcount=v.num
end
end
local reportId=fightController:saveServerReport(logStr)
self[handle](self,result,reportId,prize,data)
return reportId
end
end



function worldFightRecordController:addRecord_ResPoint(result,report,prize,data)
local guid=data.guid
local dataIdx=data.op_idx

local pointData=worldResPointDataModel:getPointData(guid)
local world=pointData.world
local block=pointData.block
local subPointData=pointData.datas[dataIdx]
local subId=subPointData[2]
local battleCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,battleCfg.groupid)


local areaId=worldBlockModel:findBlockArea(world,block)
local areaName=cfgHelper.get2(cfg_worldareaconfig_get,areaId,'name')

local taskTarget=worldResPointBaseModel:convertUnitKey(guid,dataIdx)
local huntWorld=huntMonsterTeamModel:findMonsterWorld(taskTarget)

if huntWorld then
local teamData=huntMonsterTeamModel:getTeamData(huntWorld)
local discipleLv=-1
local firstDisciple=nil
for i,v in ipairs(teamData.team)do
if mathHelper.validInt64(v)then
if firstDisciple then
local temp=UIDiscipleModel:getDiscipleJJLevel(v)
if temp>discipleLv then
firstDisciple=v
discipleLv=temp
end
else
firstDisciple=v
discipleLv=UIDiscipleModel:getDiscipleJJLevel(v)
end
end
end
local firstDiscipleName=UIDiscipleModel:getDiscipleName(firstDisciple)
local contentKey=result==fightResultType.Victory and"worldrespoint_fightrecord_victory"or"worldrespoint_fightrecord_lose"

local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,contentKey),firstDiscipleName,areaName,monsterCfg.name)
worldFightRecordModel:addRecord(result,prize,content,report,timeHelper.getServerShortTime(),0)
return
end

local taskKey=worldTaskModel:findLastTaskKey_ByTarget(taskTarget)
local task=worldTaskModel:getTask(taskKey)
if not task then return end
local firstDisciple=task.disciples[1]
local firstDiscipleName=UIDiscipleModel:getDiscipleName(firstDisciple)
local contentKey=result==fightResultType.Victory and"worldrespoint_fightrecord_victory"or"worldrespoint_fightrecord_lose"
local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,contentKey),firstDiscipleName,areaName,monsterCfg.name)
local delay=task.trip_duration+cfgHelper.get1(cfg_worldmonsterconfig_get,1).resultwaittime
worldFightRecordModel:addRecord(result,prize,content,report,task.progress_begin+delay,delay)
end

function worldFightRecordController:addRecord_WorldMonster(result,report,prize,data)
local areaId=data.areaid
local guidPos=data.guidPos

local monster=worldMonsterModel:get_monster(guidPos)
local areaName=cfgHelper.get2(cfg_worldareaconfig_get,areaId,'name')
local monsterConfig=worldMonsterModel.get_monster_group_config(monster.worldMonsterId)
local taskTarget=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,monster.posId})

local huntWorld=huntMonsterTeamModel:findMonsterWorld(taskTarget)

if huntWorld then
local teamData=huntMonsterTeamModel:getTeamData(huntWorld)
local discipleLv=-1
local firstDisciple=nil
for i,v in ipairs(teamData.team)do
if mathHelper.validInt64(v)then
if firstDisciple then
local temp=UIDiscipleModel:getDiscipleJJLevel(v)
if temp>discipleLv then
firstDisciple=v
discipleLv=temp
end
else
firstDisciple=v
discipleLv=UIDiscipleModel:getDiscipleJJLevel(v)
end
end
end
local firstDiscipleName=UIDiscipleModel:getDiscipleName(firstDisciple)
local contentKey=result==fightResultType.Victory and"worldmonster_fightrecord_victory"or"worldmonster_fightrecord_lose"

local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,contentKey),firstDiscipleName,areaName,monsterConfig.name)
worldFightRecordModel:addRecord(result,prize,content,report,timeHelper.getServerShortTime(),0)
return
end


local taskKey=worldTaskModel:findLastTaskKey_ByTarget(taskTarget)
local task=worldTaskModel:getTask(taskKey)
if not task then return end
local firstDisciple=task.disciples[1]
local firstDiscipleName=UIDiscipleModel:getDiscipleName(firstDisciple)

local contentKey=result==fightResultType.Victory and"worldmonster_fightrecord_victory"or"worldmonster_fightrecord_lose"
local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,contentKey),firstDiscipleName,areaName,monsterConfig.name)
local delay=task.trip_duration+cfgHelper.get1(cfg_worldmonsterconfig_get,1).resultwaittime

worldFightRecordModel:addRecord(result,prize,content,report,task.progress_begin+delay,delay)
end

function worldFightRecordController:addRecord_Family(result,report,prize,data)
local subType=data.subtype
local world=data.world_id
local guid=data.guid

local familyName=worldXiuZhenJiaZuModel:getFamilyName(guid,true)
local taskTarget=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(taskTarget)
local task=worldTaskModel:getTask(taskKey)
if not task then return end
local firstDisciple=task.disciples[1]
local firstDiscipleName=UIDiscipleModel:getDiscipleName(firstDisciple)
local contentKey=result==fightResultType.Victory and"family_fightrecord_victory"or"family_fightrecord_lose"
local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,contentKey),firstDiscipleName,familyName)
local delay=task.trip_duration+cfgHelper.get2(cfg_xiuzhenfamilybasicconfig_get,worldModel.world,'jinzhutime')

worldFightRecordModel:addRecord(result,prize,content,report,task.progress_begin+delay,delay)
end







