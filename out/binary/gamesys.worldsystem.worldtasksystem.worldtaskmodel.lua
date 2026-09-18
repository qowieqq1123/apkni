






local _MODULENAME="worldTaskModel"




def_table(_MODULENAME)
worldTaskModel.name=_MODULENAME



worldTaskModel.dataLen=21
worldTaskModel.TimeEventKey="WorldTask"
worldTaskModel.maxDisciple=5


local serializeData=nil

local _tasks={}

local _cost_config={}

local _task_count=0

local _fake_count=0

local _invaild_key={}

local _seeZM={
[eWorldUnitTpye.MONSTER]=true,
[eWorldUnitTpye.RESPOINT]=true,
[eWorldUnitTpye.FAMILY]=true,
}
local _JumpDiscipleCorrect={
[eWorldUnitTpye.EXPERIENCE]=true,
[eWorldUnitTpye.SYSTEMZM]=true,
}
local _jumpNewTaskCheck={
[eWorldUnitTpye.TOURPOINT]=function(id,guid)
return true
end,
[eWorldUnitTpye.SYSTEMZM]=function(id,guid)
return id>0
end,
}

local cameraHeight


local function calculateCanFly(disciples)
local info=cfgHelper.get2(cfg_worldglobalconfig_get,"taskFlyRequirements","value")
local level=info[1]
local pos=info[2]
for i,v in ipairs(disciples)do
if v>int64.zero then
local discipleData=UIDiscipleModel:getDiscipleData(v)
local jjlv=discipleData.jingjielv
local zmPos=UIDiscipleModel:getDisciplePost(v)

if jjlv>=level and zmPos<=pos then
return true
end
end
end
return false
end


local function calculateSpeed(canFly)
return canFly and 4 or 2
end


local function calculateMoveType(unitType,canFly)
if unitType==worldModel.UNITTYPE.EXPERIENCE then
return 3+(canFly and 1 or 0)
end
if unitType==worldModel.UNITTYPE.MYSTERY then
return 1+(canFly and 1 or 0)
end
if unitType==worldModel.UNITTYPE.TOURPOINT then
return 7+(canFly and 1 or 0)
end
return 5+(canFly and 1 or 0)
end


local function registerTable(localTable,setKey,setValue)
localTable[setKey]=setValue
end


function worldTaskModel:onAppStart()
registerTable(_cost_config,worldModel.UNITTYPE.MYSTERY,{cfg_secretscenefubenconfig_get,"useResEnter"})
registerTable(_cost_config,worldModel.UNITTYPE.MONSTER,{cfg_worldmonstergroupconfig_get,"cost"})
registerTable(_cost_config,worldModel.UNITTYPE.RESPOINT,{cfg_worldresbattleconfig_get,"cost"})
end


function worldTaskModel:onEnterState()

end


function worldTaskModel:onLeaveState()

self.data={}
_tasks={}
_task_count=0
_fake_count=0
end


function worldTaskModel:onServerDataInitFinish()

end





function worldTaskModel:containTask(key)
return _tasks[key]~=nil
end




function worldTaskModel:getTask(key)
return _tasks[key]
end



function worldTaskModel:findNextKey()
for i=1,_task_count do
if self:getTask(i)==nil and not self:isInvalidKey(i)then
return i
end
end
return _task_count+1
end

function worldTaskModel:nextFakeKey()
for i=1,_fake_count do
if self:getTask(-i)==nil then
return-i
end
end
return-(_fake_count+1)
end

function worldTaskModel:getTaskMax()
return _task_count
end

function worldTaskModel:getTaskFake()
return _fake_count
end



function worldTaskModel:findTaskKey_ByTarget(targetKey)
for i,v in pairs(_tasks)do
if v.target_key==targetKey then
return i
end
end
end

function worldTaskModel:findTaskKey_ByTargetProgress(targetKey,progressState)
for i,v in pairs(_tasks)do
if v.target_key==targetKey and v.progress_state==progressState then
return i
end
end
end

function worldTaskModel:findLastTaskKey_ByTarget(targetKey)
local last=nil
for i,v in pairs(_tasks)do
if v.target_key==targetKey then
if not last then
last=i
else
local lastTask=self:getTask(last)
if v.progress_state<lastTask.progress_state then
last=i
elseif v.progress_state==lastTask.progress_state and v.progress_begin>lastTask.progress_begin then
last=i
end
end
end
end
return last
end

function worldTaskModel:findAllTaskKey_ByTarget(targetKey)
local list={}
for i,v in pairs(_tasks)do
if v.target_key==targetKey then
table.insert(list,i)
end
end
return list
end













function worldTaskModel:getAllTaskingRecord()
return _tasks or{}
end

function worldTaskModel:findAllFake()
local list={}
for i=1,_fake_count do
local v=self:getTask(-i)
if v then
table.insert(list,v.id)
end
end
return list
end

function worldTaskModel:findAllFake_UnitType(unitType)
local list={}
for i=1,_fake_count do
local v=self:getTask(-i)
if v then
if unitType==nil or unitType==v.target_type then
table.insert(list,v.id)
end
end
end
return list
end

function worldTaskModel:findAllFakeEx(check)
local list={}
for i=1,_fake_count do
local v=self:getTask(-i)
if v and(check==nil or check(v))then
table.insert(list,v.id)
end
end
return list
end

function worldTaskModel:getAllTaskSortList(sort,filter)
local list={}
for i,v in pairs(_tasks)do
if not filter or filter(v)then
table.insert(list,i)
end
end
if sort then
table.sort(list,sort)
end
return list
end

function worldTaskModel.sortTaskTime(a,b)
local taskA=worldTaskModel:getTask(a)
local taskB=worldTaskModel:getTask(b)
if taskA.progress_state~=taskB.progress_state then
return taskA.progress_state>taskB.progress_state
else
return taskA.progress_begin<taskB.progress_begin
end
end

function worldTaskModel:checkCorrect()

local noviciate=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
if worldExperienceModel:checkCurrent(noviciate[1],noviciate[2])then
local task=worldExperienceModel:getTask()
if task then
local discipleDatas=UIDiscipleModel:getAllPlotDisciple()
local addList={}
for i,guidinfo in ipairs(discipleDatas)do
if not table.containsValueEx(task.disciples,guidinfo.discipleguid,function(value)return tostring(value)end)then
table.insert(addList,guidinfo.discipleguid)
end
end
if#addList>0 then
task:appendDisciples(addList)
end
end
end

for i,v in pairs(_tasks)do

v:correct()

self:checkTaskDiscipleCount(i)
end
end




function worldTaskModel:convertTaskUnitKey(key,index)
return FMT.fmt("{0}_{1}_{2}",eWorldUnitTpye.MISSION,key,index)
end



function worldTaskModel:restartWorldTask(world)

local serverTime=timeHelper.getServerShortTime()
for i,v in pairs(_tasks)do

if world==v.world and v.state==eWorldTripState.Running and not v.show then

v:start(serverTime)
end
end
end



function worldTaskModel:quitWorldTask(world)
for i,v in pairs(_tasks)do
if world==v.world then
v:quit()
end
end
end



function worldTaskModel:onQuickUpdate(delta)
local serverTime=timeHelper.getServerShortTime()
for i,v in pairs(_tasks)do
if v.state==eWorldTripState.Running then
v:update(serverTime)
end
end
end

function worldTaskModel:setTask(data)
_tasks[data.id]=data
_task_count=math.max(_task_count,data.id)

_fake_count=math.max(_fake_count,-data.id)
end



function worldTaskModel:removeTask(key)
local task=self:getTask(key)
if task then
task:quit()
_tasks[key]=nil
else

end
end

function worldTaskModel:appendTaskDisciple(taskKey,disciples)
local task=self:getTask(taskKey)
if task then
if task:appendDisciples(disciples)then

return true
end
end
return false
end

function worldTaskModel:subtractTaskDisciple(taskKey,disciples)
local task=self:getTask(taskKey)
if task and not worldTaskModel:isJumpNewTaskCheck(task.target_type,task.target_id,task.target_guid)then
if task:subtractDisciples(disciples)then

return true
end
end
return false
end

function worldTaskModel:checkTaskDiscipleCount(taskKey)
local task=self:getTask(taskKey)
if task and not _JumpDiscipleCorrect[task.target_type]and#task.disciples<=0 then
task:back()
task:cancel()
end
end

function worldTaskModel:checkTarget(targetKey,ingore)
local list={}
for key,task in pairs(_tasks)do
if ingore~=key then
if task.target_key==targetKey and task.state==eWorldTripState.Unplayed then
table.insert(list,key)
end
end
end
return list
end

function worldTaskModel:isJumpNewTaskCheck(unitType,id,guid)
local check=_jumpNewTaskCheck[unitType]
return check and check(id,guid)or false
end

function worldTaskModel:checkNewTaskDisciple(taskKey)
local task=self:getTask(taskKey)
if worldTaskModel:isJumpNewTaskCheck(task.target_type,task.target_id,task.target_guid)then return end
for key,data in pairs(_tasks)do
if taskKey~=key and data.state~=eWorldTripState.Unplayed and not worldTaskModel:isJumpNewTaskCheck(data.target_type,data.target_id,data.target_guid)then
for index,discipleguid in ipairs(task.disciples)do
if data:containDisciple(discipleguid)then
if data.progress_state>=eWorldTripProgress.Back then
data:subtractDisciples(task.disciples)
else
loggerUtil.logErrFMT("新任务存在弟子问题：{0}，{1}，{2}，{3}, {4}, {5}",taskKey,key,task.target_key,data.target_key,data.progress_state,UIDiscipleModel:getDiscipleName(discipleguid))
end
break
end
end
end
end
end





function worldTaskModel:getCostConfig(type,id)
local data=_cost_config[type]
return data and cfgHelper.get2(data[1],id,data[2])or nil
end





function worldTaskModel:checkStartCost(type,id)
local costCfg=self:getCostConfig(type,id)
if costCfg then
return moneyModel.checkEnoughMoneyX(costCfg)
end
end





function worldTaskModel:getTaskTargetPoint(unitType,targetGuid,unitId)
local tableId=unitId
if unitType==eWorldUnitTpye.EXPERIENCE then
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,unitId)
local world=fogCfg.world
local block=fogCfg.block
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
return mathHelper.convertArrayToVector(blockCfg.eTaskPos),world


elseif unitType==eWorldUnitTpye.RESPOINT then
local data=worldResPointDataModel:getPointData(targetGuid)
local position=worldResPointDataModel:getSubPointPos(targetGuid,unitId)
return mathHelper.convertArrayToVector(position),data.world
elseif unitType==eWorldUnitTpye.TOURPOINT then
local pointCfg=cfgHelper.get1(cfg_worldtravelconfig_get,tableId)
return mathHelper.convertArrayToVector(pointCfg.taskPoint),tableId
elseif unitType==eWorldUnitTpye.MONSTER then
local monster=worldMonsterModel:get_monster(targetGuid)
return mathHelper.convertArrayToVector(monster.posData),monster.worldId
elseif unitType==eWorldUnitTpye.FAMILY then
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(targetGuid)
return mathHelper.convertArrayToVector({data.x,data.z}),data.world
elseif unitType==eWorldUnitTpye.SYSTEMZM then
local data=systemZongMenModel:getInfoData(targetGuid)
return Vector2.New(data.position.x,data.position.z),data.worldId
elseif unitType==eWorldUnitTpye.MYSTERY then
local typo=MysteryModel:get_mystery_sence_type(tableId)
if typo==MysterySenceType.World then
local data=MysteryModel:get_mysteryFB_unit(tableId)
return Vector2.New(data[2],data[3]),data[1]
elseif typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(tableId)
local position=worldResPointDataModel:getSubPointPos(guid,subIdx)
return mathHelper.convertArrayToVector(position),data.world
elseif typo==MysterySenceType.ZiYuan then
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(tableId)
local data=mysteryZiYuanFuBenModel:get_mysteryFB_group_unit(group[1])
return Vector2.New(data[2],data[3]),data[1]
end
elseif unitType==eWorldUnitTpye.RESMYSTERY then
local data=mysteryZiYuanFuBenModel:get_mysteryFB_group_unit(tableId)
return Vector2.New(data[2],data[3]),data[1]
elseif unitType==eWorldUnitTpye.HUNTMONSTERTEAM then
local monsters=huntMonsterTeamModel:getSendData(tableId)
local lastMonster=monsters[#monsters]
local keys=worldModel:separateUnitKey(lastMonster)
local type=tonumber(keys[1])
if type==eWorldUnitTpye.MONSTER then
local monster=worldMonsterModel:get_monster(keys[2])
return mathHelper.convertArrayToVector(monster.posData),monster.worldId
elseif type==eWorldUnitTpye.RESPOINT then
local data=worldResPointDataModel:getPointData(keys[2])
local position=worldResPointDataModel:getSubPointPos(keys[2],tonumber(keys[3]))
return mathHelper.convertArrayToVector(position),data.world
end
end

local targetKey=worldModel:convertUnitKey({unitType,tableId})
local data=worldController:getUnit(targetKey)
return Vector2.New(data.Position.x,data.Position.z),worldModel.world
end

function worldTaskModel:getSeeZM(unitType)
return _seeZM[unitType]==true
end

function worldTaskModel:startUnitTaskHandle(unitType,unitGuid,unitId,endPoint)
if unitType==eWorldUnitTpye.MONSTER then
UIManager.info("队伍已经出发")
local unitKey=worldModel:convertUnitKey({unitType,tostring(unitGuid)})
worldMoveModel:stopGuardianMove(unitKey,unitKey,endPoint)
elseif unitType==eWorldUnitTpye.RESPOINT then
UIManager.info("队伍已经出发")
local unitKey=worldResPointBaseModel:convertUnitKey(unitGuid,unitId)
local moveKey=unitKey
if worldController:haveUnit(unitKey)then
worldMoveModel:stopGuardianMove(unitKey,moveKey,endPoint)
end
elseif unitType==eWorldUnitTpye.FAMILY then
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(unitGuid)
if data and data.world and data.block then
worldController:lookAtCity(data.world,data.block,cameraHeight)
end
elseif unitType==eWorldUnitTpye.EXPERIENCE then
if not worldExperienceModel:checkScene()then
worldExperienceController:enterExperience()
end
end

cameraHeight=nil
end

function worldTaskModel:findTaskKey_ByDiscipleGUID(discipleGUID)
for i,v in pairs(_tasks)do
for j,w in ipairs(v.disciples)do
if mathHelper.compareInt64(w,discipleGUID)then
return i
end
end
end
end

function worldTaskModel:changeTaskTargetDestination(targetKey)
local taskList=worldTaskModel:findAllTaskKey_ByTarget(targetKey)
for index,taskKey in ipairs(taskList)do
self:refreshTaskDestination(taskKey)
end
end

function worldTaskModel:refreshTaskDestination(taskKey)
local task=self:getTask(taskKey)
local destVec2,world=worldTaskModel:getTaskTargetPoint(task.target_type,task.target_guid,task.target_id)
task.x=math.floor(destVec2.x*100)
task.z=math.floor(destVec2.y*100)
task.destination=destVec2
task.corners=nil
if task.show then
task:quit()
local nowTime=timeHelper.getServerShortTime()
task:start(nowTime)
end
task:save()
end

function worldTaskModel:addInvalidKey(key)
_task_count=math.max(_task_count,key)
table.insert(_invaild_key,key)
end

function worldTaskModel:isInvalidKey(key)
return table.containsValue(_invaild_key,key)
end

function worldTaskModel:clearInvalidKey()
_invaild_key={}
end
