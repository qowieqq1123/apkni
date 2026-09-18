

function worldExperienceController.onClickExperience(args)
if(args and args[1]==eWorldUnitTpye.EXPERIENCE)then
local point=worldExperienceModel:getCurrentPoint()
if point==args[2]then
_this:doContinue()
end
end
end

function worldExperienceController.onMissionDiscipleChanged(taskKey,changeNum)
local task=worldTaskModel:getTask(taskKey)
if task and task.target_type==eWorldUnitTpye.EXPERIENCE and worldModel:isSameWorld(task.world)then
worldExperienceController:refreshDisclpleUnit(task.disciples[1])
end
end

function worldExperienceController.onStartMissionInWorld(taskKey,targetType,targetId,Team)
local task=worldTaskModel:getTask(taskKey)
if task and task.target_type==eWorldUnitTpye.EXPERIENCE and worldModel:isSameWorld(task.world)then
worldExperienceController:refreshDisclpleUnit(task.disciples[1])
end
end

function worldExperienceController:onEnterWorldEvent(world)
local cWorld=worldExperienceModel:getCurrentWorld()

if world==cWorld then
self:showAllUnit()
end
end

function worldExperienceController:onExitWorldEvent(world)
local cWorld=worldExperienceModel:getCurrentWorld()
if world==cWorld then
self:hideAllUnit()
end
end

function worldExperienceController.onDiscipleCreate(discipleGuid)
local cfg=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
local check1=worldExperienceModel:checkCurrent(cfg[1],cfg[2])
if check1 then
local taskKey=worldExperienceModel:getTaskKey()
if taskKey and UIDiscipleModel:isPlotDisciple(discipleGuid)then
worldTaskModel:appendTaskDisciple(taskKey,{discipleGuid})
end
end
end

function worldExperienceController.onWorldBlockDataChanged(world,block,state,oState)
if state==eWorldBlockState.UNLOCK then
worldExperienceModel:setData()
worldExperienceController:onEnterWorldEvent(world)
elseif state==eWorldBlockState.OPEN then
if worldExperienceModel:checkCurrent(world,block)then
worldExperienceController:hideAllUnit()
local taskKey=worldExperienceModel:getTaskKey()
if taskKey then
worldTaskController:returnMission(taskKey)
end
worldExperienceModel:setData()
end
end
end
