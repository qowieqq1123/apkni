local _fakeType={
eWorldUnitTpye.TOURPOINT,
eWorldUnitTpye.SYSTEMZM,
}

function worldTaskController:checkFakeType(type)
return table.containsValue(_fakeType,type)
end






function worldTaskController:fakeZongMenMysteryTask(fbId,guidList,zhenfaId)
local task=worldDispatchTask_ZongMen_Mystery.New()
local targetKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,fbId})
local team=fightPreSelectModel.convertFightStruct2Disciple(guidList)
task.id=worldTaskModel:findNextKey()
task.world=0
task.target_type=eWorldUnitTpye.MYSTERY
task.target_guid=int64.zero
task.target_id=fbId
task.x=0
task.z=0
task.mode=eWorldTripType.Fake
task.team=team
task.zhenfa_id=zhenfaId
task.speed=worldDispatchFactory:getSpeed(eWorldTripType.Fake)
task.destination=Vector2.zero
task.target_key=targetKey
task.show=false
task:refreshDisclples()
task:path()
task:express()
task:init()
task.state=eWorldTripState.Unplayed
return task
end

function worldTaskController:fakeHuntMonsterTeamTask(world,teamList,zfId)
local task=worldDispatchTask_HuntMonsterTeam.New()
local targetKey=worldModel:convertUnitKey({eWorldUnitTpye.HUNTMONSTERTEAM,world})
task.id=worldTaskModel:findNextKey()
task.world=world
task.target_type=eWorldUnitTpye.HUNTMONSTERTEAM
task.target_guid=int64.zero
task.target_id=world
task.x=0
task.z=0
task.mode=eWorldTripType.Fake
task.team=teamList
task.zhenfa_id=zfId
task.speed=worldDispatchFactory:getSpeed(eWorldTripType.Fake)
task.destination=Vector2.zero
task.target_key=targetKey
task.show=false
task:refreshDisclples()
task:path()
task:express()
task:init()
task.state=eWorldTripState.Unplayed
return task
end

function worldTaskController:remakeFakeTask_SystemZongMen(world)
local unitType=eWorldUnitTpye.SYSTEMZM
local serverTime=timeHelper.getServerShortTime()

local infoList=systemZongMenModel:getInfoList()
for i,v in ipairs(infoList)do
if v.worldId==world and v.disciple_guid>int64.zero then
local dzList={v.disciple_guid,int64.zero,int64.zero,int64.zero,int64.zero}
local task=worldDispatchFactory:createTask(unitType,v.serial,0,dzList,0)
task.id=worldTaskModel:nextFakeKey()
task.progress_state=eWorldTripProgress.Work
task.state=eWorldTripState.Running
worldTaskModel:setTask(task)
if worldController:isInWorld()and worldModel:isSameWorld(world)and not task.show then
task:start(serverTime)
end
end
end

local waitList=systemZongMenModel:getAllBattleWaitResult()

for i,v in ipairs(waitList)do
if v.teamIndex>0 then
local infoData=systemZongMenModel:getInfoData(v.serial)
local dzList={int64.zero,int64.zero,int64.zero,int64.zero,int64.zero}
local task=worldDispatchFactory:createTask(unitType,v.serial,v.teamIndex,dzList,0)
task.id=worldTaskModel:nextFakeKey()
task.progress_state=eWorldTripProgress.Work
task.state=eWorldTripState.Running
worldTaskModel:setTask(task)

if world==infoData.worldId and worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)and not task.show then
task:start(serverTime)
end
end
end
end

function worldTaskController:remakeFakeTask_Tour(world)
local unitType=eWorldUnitTpye.TOURPOINT
local data=chuanSongZhenModel:getData(world)
local serverTime=timeHelper.getServerShortTime()
for i,v in ipairs(data.current)do
local check=UIDiscipleModel:checkDZStateToDoSomething(v.disciple,eCheckDiscipleStateOpType.eYouLi,false)
if check then
local dzList={v.disciple,int64.zero,int64.zero,int64.zero,int64.zero}
local task=worldDispatchFactory:createTask(unitType,v.disciple,world,dzList,0)
task.id=worldTaskModel:nextFakeKey()
task.progress_state=eWorldTripProgress.Work
task.state=eWorldTripState.Running
worldTaskModel:setTask(task)
if worldModel:isSameWorld(world)and worldController:isInWorld()and not task.show then
task:start(serverTime)
end
end
end
end

function worldTaskController:remakeAllFakeTask_Tour()
local datas=chuanSongZhenModel:getDatas()
local unitType=eWorldUnitTpye.TOURPOINT
local serverTime=timeHelper.getServerShortTime()
for world,data in pairs(datas)do
for i,v in ipairs(data.current)do
local check=UIDiscipleModel:checkDiscipleState2(v.disciple,DISCIPLE_STATE_TYPE.eChuiWei)

if not check then
local dzList={v.disciple,int64.zero,int64.zero,int64.zero,int64.zero}
local task=worldDispatchFactory:createTask(unitType,v.disciple,world,dzList,0)
task.id=worldTaskModel:nextFakeKey()
task.progress_state=eWorldTripProgress.Work
task.state=eWorldTripState.Running
worldTaskModel:setTask(task)
if worldModel:isSameWorld(world)and worldController:isInWorld()and not task.show then
task:start(serverTime)
end
end
end
end
end

function worldTaskController:newFakeTask(targetType,targetGuid,targetId,discipleList)
if not self:checkFakeType(targetType)then
loggerUtil.logErrFMT("尝试创建非伪造派遣类型数据 {0} {1} {2}",targetType,tostring(targetGuid),tostring(targetId))
return
end
local task=worldDispatchFactory:createTask(targetType,targetGuid,targetId,discipleList,0)
task.id=worldTaskModel:nextFakeKey()
task.state=eWorldTripState.Running
worldTaskModel:setTask(task)
worldTaskModel:checkNewTaskDisciple(task.id)
notifySystem:postNotify(notifyConfig.onStartMissionInWorld,task.id,task.target_type,task.target_id,task.team)
if worldModel:isSameWorld(task.world)and worldController:isInWorld()and not task.show then
local serverTime=timeHelper.getServerShortTime()
task:start(serverTime)
end
end

function worldTaskController:backFakeTask(targetType,targetGuid,targetId)

local list=worldTaskModel:findAllFake()
for i,v in ipairs(list)do
local task=worldTaskModel:getTask(v)
local target_key=worldDispatchFactory:getUnitKey(targetType,targetGuid,targetId)
if task.target_key==target_key then
task:back()
end
end
end

function worldTaskController:cancelAllFakeTask(world,unitType)
local list=worldTaskModel:findAllFake()
for i,v in ipairs(list)do
local task=worldTaskModel:getTask(v)
if world==nil or task.world==world then
if unitType==nil or task.target_type==unitType then
worldTaskModel:removeTask(v)
end
end
end
end