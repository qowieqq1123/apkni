







local entityTaskPool=nil
local taskEntityLookup=nil


local entityTaskType={



[24]=true,
[25]=true,
}

function taskModel:clearTaskEntitysData(isReconnet)
if isReconnet then
if taskEntityLookup then
for k,taskEntity in pairs(taskEntityLookup)do
taskModel:removeTaskEnityHud(taskEntity)
end
end
end
entityTaskPool=nil
taskEntityLookup=nil
end

function taskModel:isEntityTaskType(tasktype)
return entityTaskType[tasktype]==true
end

function taskModel.getTaskEntityHudType(sType)
if sType==sundriseType.eStillSundrise then
return INSTANCE_TYPE.eTaskCollect
else
return INSTANCE_TYPE.eTaskEntity
end
end

function taskModel:findEnityTask(taskid)
if entityTaskPool~=nil then
for i,v in ipairs(entityTaskPool)do
if v.taskid==taskid then
return v,i
end
end
end
return nil,nil
end

function taskModel:findTaskEnity(ent_guid)
if taskEntityLookup~=nil then
for k,taskEntity in pairs(taskEntityLookup)do
if taskEntity.guid==ent_guid then
return taskEntity
end
end
end
return nil
end

function taskModel:initEntityTasks()
entityTaskPool={}
taskEntityLookup={}
local list=taskModel:getTaskList()
if list then
for i,v in ipairs(list)do
local cfg=v.cfg
if self:isEntityTaskType(cfg.tasktype)then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskDoingState then
local entityTask,idx=self:findEnityTask(cfg.id)
if entityTask==nil then
taskModel:initEntityTaskData(cfg)
end
end
end
end
end
if entityTaskPool~=nil then
for i,entityTask in ipairs(entityTaskPool)do
self:initTaskEnity(entityTask)
end
end
end

function taskModel:initEntityTaskData(taskcfg)
local taskid=taskcfg.id
local entityTask={}
entityTask.taskid=taskid
entityTask.cfg=taskcfg
local sundriseID=nil
local sundriseType=nil
local params=taskcfg.params
if params[5]~=nil then
sundriseType=params[5]
else
sundriseID=params[2]
end
entityTask.sundriseID=sundriseID
entityTask.sundriseType=sundriseType
local temp_sundriseID=params[2]
local sundriseCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,temp_sundriseID)
local sType=sundriseCfg.type
entityTask.sType=sType
entityTask.hudType=taskModel.getTaskEntityHudType(sType)
entityTask.offset=sundriseCfg.hudoffset or{0,0.5}
entityTask.entity=nil

table.insert(entityTaskPool,entityTask)
return entityTask
end

function taskModel:removeEnityTask(idx)
if entityTaskPool==nil then return end
local entityTask=entityTaskPool[idx]
if entityTask==nil then return end

table.remove(entityTaskPool,idx)
local taskid=entityTask.taskid
local taskEntity=entityTask.entity
if taskEntity~=nil then
self:removeTaskEntityTask(taskEntity,taskid)
entityTask.entity=nil
end
entityTask=nil
end

function taskModel:removeTaskEntityTask(taskEntity,taskid)
local f=nil
for i,tempEnityTask in ipairs(taskEntity.enityTaskList)do
if tempEnityTask.taskid==taskid then
f=i
break
end
end
if f~=nil then
table.remove(taskEntity.enityTaskList,f)
end
if#taskEntity.enityTaskList<=0 then

self:removeTaskEntity(taskEntity)
else
if f==1 then

self:removeTaskEnityHud(taskEntity)

self:refreshTaskEnityHud(taskEntity)
end
end
end

function taskModel:initTaskEnity(entityTask)
local taskEntity=entityTask.entity
if taskEntity~=nil then

local ent=isometricMapSystem:getSundriesData(taskEntity.guid)
if ent==nil then
entityTask.entity=nil
taskModel:removeTaskEntity(taskEntity)
taskEntity=nil
end
end
if taskEntity==nil then
if entityTask.sundriseID~=nil then

local ent=isometricMapSystem:findUnlockSundriesByID(mapIdType.zhufeng,entityTask.sundriseID)
if ent then
local ent_guid=ent.guid
taskModel:addTaskEnity(ent_guid,entityTask)
taskEntity=entityTask.entity
end
else

local entlist=isometricMapSystem:findUnlockSundriesBySType(mapIdType.zhufeng,entityTask.sundriseType)
if#entlist>0 then
local ent_guid=entlist[1].guid
taskModel:addTaskEnity(ent_guid,entityTask)
taskEntity=entityTask.entity
end
end
end
if taskEntity then
taskModel:refreshTaskEnityHud(taskEntity)
end
end

function taskModel:addTaskEnity(ent_guid,entityTask)
local taskEntity=taskEntityLookup[ent_guid]
if taskEntity==nil then
taskEntity={guid=ent_guid}
taskEntityLookup[ent_guid]=taskEntity
taskEntity.enityTaskList={}
table.insert(taskEntity.enityTaskList,entityTask)
entityTask.entity=taskEntity
else
local f=false
for i,v in ipairs(taskEntity.enityTaskList)do
if v.taskid==entityTask.taskid then
f=true
break
end
end
if not f then
table.insert(taskEntity.enityTaskList,entityTask)
entityTask.entity=taskEntity
end
end
end

function taskModel:addTaskEnityEx(sundriseID,ent_guid,sType)
if entityTaskPool==nil then return end
for i,entityTask in ipairs(entityTaskPool)do
local check=false
if entityTask.sundriseID~=nil then
if entityTask.sundriseID==sundriseID then
check=true
end
else
if entityTask.sundriseType==sType then
check=true
end
end
if check then
if entityTask.entity~=nil then
if entityTask.entity.guid==ent_guid then




local taskEntity=entityTask.entity
entityTask.entity=nil
self:removeTaskEntityTask(taskEntity,entityTask.taskid)
end
else
self:addTaskEnity(ent_guid,entityTask)
local taskEntity=entityTask.entity
self:refreshTaskEnityHud(taskEntity)
end
break
end
end
end

function taskModel:removeTaskEntity(taskEntity)
local ent_guid=taskEntity.guid
taskEntityLookup[ent_guid]=nil

self:removeTaskEnityHud(taskEntity)
end

function taskModel:removeTaskEntityEx(taskEntity)
self:removeTaskEntity(taskEntity)

if entityTaskPool==nil then return end
local ent_guid=taskEntity.guid
for i,entityTask in ipairs(entityTaskPool)do
if entityTask.entity~=nil and entityTask.entity.guid==ent_guid then
entityTask.entity=nil
end
end
end

function taskModel:refreshTaskEnityHud(taskEntity)
if taskEntity.hudID~=nil then return end

local ent_guid=taskEntity.guid
local entityTask=taskEntity.enityTaskList[1]
local hudType=entityTask.hudType

local sType=entityTask.sType

local hudID
if sType==sundriseType.eStillSundrise then
hudID=-1







else
local offset=_MapManager.GetObjectHeadOffset(ent_guid)
hudID=hudControl:addHUD(hudType,ent_guid,offset,false,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
isometricMapSystem:checkTouchSundrise(ent_guid,objectType.eStillSundrise)
end)
end)
end

taskEntity.hudID=hudID
end

function taskModel:removeTaskEnityHud(taskEntity)
if taskEntity.hudID~=nil then
if taskEntity.hudID>=0 then
hudControl:removeHUD(taskEntity.hudID)
end
taskEntity.hudID=nil
end
end

function taskModel:checkEntityTaskChange(taskid,taskstate)
local taskcfg=taskModel:getTaskConfig(taskid)
if self:isEntityTaskType(taskcfg.tasktype)then
local entityTask,idx=self:findEnityTask(taskid)
if taskstate==taskModel.taskDoingState then
if entityTask then
self:initTaskEnity(entityTask)
else
entityTask=self:initEntityTaskData(taskcfg)
self:initTaskEnity(entityTask)
end
else
if entityTask then
self:removeEnityTask(idx)
end
end
end

if entityTaskPool~=nil and#entityTaskPool>0 then
local removes={}
for i,v in ipairs(entityTaskPool)do
if not self:hasTask(v.taskid)then
table.insert(removes,i)
end
end
if#removes>0 then
for i,v in ipairs(removes)do
self:removeEnityTask(i)
end
end
end
end

function taskModel:onEntityCreate(id,guid,stype)
self:addTaskEnityEx(id,guid,stype)
end

function taskModel:onEntityRemove(guid)
local taskEntity=self:findTaskEnity(guid)
if taskEntity then
self:removeTaskEntityEx(taskEntity)
end
end

function taskModel:onSundriseAIRecord(guid,flag)
if flag then




end
end
