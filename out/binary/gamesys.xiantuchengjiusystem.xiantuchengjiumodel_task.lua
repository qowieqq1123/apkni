
















xiantuchengjiuModel.task={}





xiantuchengjiuModel.task_lookup={}



xiantuchengjiuModel.task_showlisten={}

local _config={
[eXianTuChengJiuTabType.ZongMenXianTu]={cfg_xiantutask1config,cfg_xiantutask1config_get},
[eXianTuChengJiuTabType.XianTuChengJiu]={cfg_xiantutask2config,cfg_xiantutask2config_get},
[eXianTuChengJiuTabType.FeiShengDaoTu]={cfg_xiantutask3config,cfg_xiantutask3config_get},
}

local _refreshProgressCheck={
[eXianTuChengJiuTabType.ZongMenXianTu]=function(data)
return xiantuchengjiuModel:checkOpen(data.type,data.key1)
end,
[eXianTuChengJiuTabType.FeiShengDaoTu]=function(data)
return xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,data.key1)
end,
}

local fakeTaskData={
cfg={
params={},
}
}

function xiantuchengjiuModel:resetTaskData()
self.task={}
self.task_lookup={}
self.task_showlisten={}
for typeName,typeValue in pairs(eXianTuChengJiuTabType)do
local typeCfg=xiantuchengjiuModel:getTaskWholeConfig(typeValue)
local typeData={}
for key1,key1Cfg in pairs(typeCfg)do
local key1Data={}
for key2,key2Cfg in pairs(key1Cfg)do
local aims={}
for i,v in ipairs(key2Cfg.taskaims)do
table.insert(aims,v[1])
end
local check=taskModel:checkClientCheckTask(key2Cfg.tasktype)
local key2Data={
type=typeValue,
key1=key1,
key2=key2,
flag=0,
server=0,
progress=0,


aims=aims,
show=true,
client=check~=nil,
storage=check and mathHelper.getBitValue(check,2)or false,
}
key1Data[key2]=key2Data

table.checkCreateSubTable(self.task_lookup,{key2Cfg.tasktype,key2Cfg.taskparam})
table.insert(self.task_lookup[key2Cfg.tasktype][key2Cfg.taskparam],{typeValue,key1,key2})
end
typeData[key1]=key1Data
end
self.task[typeValue]=typeData
end
end

function xiantuchengjiuModel:initTaskData()
for type,typeData in pairs(self.task)do
for key1,key1Data in pairs(typeData)do
for key2,key2Data in pairs(key1Data)do
local cfg=xiantuchengjiuModel:getTaskConfig(type,key1,key2)

local show=self:checkConditions(cfg.show)
key2Data.show=show
if not show then
for i,v in ipairs(cfg.show)do
local ctype=v[1]
if not self.task_showlisten[ctype]then
self.task_showlisten[ctype]={}
end
table.insert(self.task_showlisten[ctype],{type,key1,key2})
end
end
end
end
end
end

function xiantuchengjiuModel:getTasksByType(eType)
return self.task[eType]
end

function xiantuchengjiuModel:getTasksByTypeKey(eType,eKey1)
local list=self:getTasksByType(eType)
if list then
return list[eKey1]
end
end

function xiantuchengjiuModel:getTaskData(eType,eKey1,eKey2)
local list=self:getTasksByTypeKey(eType,eKey1)
if list then
return list[eKey2]
end
end

function xiantuchengjiuModel:findTaskKeyByType(taskType)
return self.task_lookup[taskType]
end

function xiantuchengjiuModel:findTaskKeyByTypeParam(taskType,taskParam)
local list=self:findTaskKeyByType(taskType)
if list then
return list[taskParam]
end
end

function xiantuchengjiuModel:getTaskProgressShowEx(data)
local index=data.flag+1
local aim=data.aims[index]
if aim then
if data.client then


if data.server<aim then
return math.min(data.progress,aim)
else
return aim
end



else
return math.min(data.server,aim)
end
else
return data.aims[#data.aims]
end
end

function xiantuchengjiuModel:getTaskProgressShow(eType,eKey1,eKey2)
local data=self:getTaskData(eType,eKey1,eKey2)
if data then
return self:getTaskProgressShowEx(data)
end
end

function xiantuchengjiuModel:getTaskAim(eType,eKey1,eKey2)
local data=self:getTaskData(eType,eKey1,eKey2)
if data then
local index=data.flag+1
local aim=data.aims[index]
return aim
end
return-1
end

function xiantuchengjiuModel:getTaskAimEx(data)
local index=xiantuchengjiuModel:getTaskAimIndexEx(data)
return data.aims[index]
end

function xiantuchengjiuModel:isTaskOver(eType,eKey1,eKey2)
local aim=self:getTaskAim(eType,eKey1,eKey2)
return aim==nil
end

function xiantuchengjiuModel:isTaskOverEx(data)
local aim=self:getTaskAimEx(data)
return aim==nil
end

function xiantuchengjiuModel:getTaskAimIndex(eType,eKey1,eKey2)
local data=self:getTaskData(eType,eKey1,eKey2)
if data then
return self:getTaskAimIndexEx(data)
end
end

function xiantuchengjiuModel:getTaskAimIndexEx(data)
return data.flag+1
end

function xiantuchengjiuModel:updateTaskData(eType,eKey1,eKey2,progress,flag)
local data=self:getTaskData(eType,eKey1,eKey2)
progress=progress and tonumber(tostring(progress))or 0
if data and(data.flag~=flag or data.server~=progress)then
local old=math.max(data.progress,data.server)
local new=math.max(data.progress,progress)
local index=flag+1
local aim=data.aims[index]
local pass=nil
if aim then
if data.flag==flag and old<aim and new>=aim then
pass=index
elseif data.flag~=flag and new>=aim then
pass=index
end
end
data.flag=flag
data.server=progress
return true,pass
end
return false
end

function xiantuchengjiuModel:updateTaskProgress(eType,eKey1,eKey2,progress)
local data=self:getTaskData(eType,eKey1,eKey2)
progress=progress and tonumber(tostring(progress))or 0
if data and data.server~=progress then

if not data.client then
local old=data.server
local new=progress
local index=data.flag+1
local aim=data.aims[index]
local pass=nil
if aim and old<aim and new>=aim then
pass=index
end
data.server=progress
return true,pass

else
data.server=progress
return true
end
end
return false
end

function xiantuchengjiuModel:refreshTaskProgress(eType,eKey1,eKey2)
local data=self:getTaskData(eType,eKey1,eKey2)
if data and data.client then

local check=_refreshProgressCheck[eType]
if check and not check(data)then
return false
end

local cfg=xiantuchengjiuModel:getTaskConfig(eType,eKey1,eKey2)
local tasktype=cfg.tasktype
local taskparam=tonumber(cfg.taskparam)or cfg.taskparam
local handle=taskModel:getClientCheckHandle(tasktype)
local index=data.flag+1
local aim=data.aims[index]or data.aims[#data.aims]
fakeTaskData.cfg['tasktype']=tasktype
fakeTaskData.cfg['aimnum']=aim
fakeTaskData.cfg.params[1]=taskparam
local state,progress,aim=handle(fakeTaskData)

local old=math.max(data.progress,data.server)
local new=progress
local pass={}
if old<new then
for i=index,#data.aims do
local a=data.aims[i]
if old<a and new>=a then
table.insert(pass,i)
end
end
end

data.progress=progress



return true,pass
end
return false
end

function xiantuchengjiuModel:updateTaskFlag(eType,eKey1,eKey2,flag)
local data=self:getTaskData(eType,eKey1,eKey2)
if data and data.flag~=flag then
data.flag=flag

local progress=math.max(data.progress,data.server)
local index=data.flag+1
local aim=data.aims[index]
local pass=nil
if aim and progress>=aim then
pass=index
end

return true,pass
end
end

function xiantuchengjiuModel:receiveTaskReward(eType,eKey1,eKey2,flag)
return xiantuchengjiuModel:updateTaskFlag(eType,eKey1,eKey2,flag)
end

function xiantuchengjiuModel:receiveTasksReward(list)
local temp={}
local fsdtKey1=nil
for i,v in ipairs(list or{})do
local check,pass=self:receiveTaskReward(v.keyInfo.xttype,v.keyInfo.key1,v.keyInfo.key2,v.aimidx)
if pass then
table.insert(temp,{v.keyInfo.xttype,v.keyInfo.key1,v.keyInfo.key2,pass})
end
if v.keyInfo.xttype==eXianTuChengJiuTabType.FeiShengDaoTu then
fsdtKey1=v.keyInfo.key1
end
end
if fsdtKey1 then
local current=self:getFSDTCurrent()
if current~=fsdtKey1 then
local datas=self:getTasksByTypeKey(eXianTuChengJiuTabType.FeiShengDaoTu,current)
for key2,data in pairs(datas)do
if self:getTaskReddotEx(data)then
local aimIdx=self:getTaskAimIndexEx(data)
table.insert(temp,{data.type,data.key1,data.key2,aimIdx})
end
end
end
end
return temp
end

function xiantuchengjiuModel:doTempStorage(eType,eKey1,eKey2,aimIdx)
local data=self:getTaskData(eType,eKey1,eKey2)
if data and data.storage then
local cfg=xiantuchengjiuModel:getTaskConfig(eType,eKey1,eKey2)
local aim=cfg.taskaims[aimIdx]
if aim then
taskController:pushTempStorage(cfg.tasktype,cfg.taskparam,aim[1])
end
end
end

function xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)
if not self:checkOpen(eType,eKey1)then
return false
end

local data=self:getTaskData(eType,eKey1,eKey2)
return data.show
end

function xiantuchengjiuModel:triggerTaskOpens(oType)
local list=self.task_showlisten[oType]
local temp={}
if list then
local rList={}
for i,v in ipairs(list)do
local cfg=xiantuchengjiuModel:getTaskConfig(v[1],v[2],v[3])
local check=self:checkConditions(cfg.show)
local data=self:getTaskData(v[1],v[2],v[3])
if check then
if not data.show then
data.show=check
table.insert(temp,v)
end
table.insert(rList,i)
end
end
for i=#rList,1,-1 do
table.remove(list,rList[i])
end
end
return temp
end

function xiantuchengjiuModel:checkTasksOver(eType,eKey1)
local cfg=xiantuchengjiuModel:getTaskConfig(eType,eKey1)
for index,info in pairs(cfg)do
local over=self:isTaskOver(eType,eKey1,index)
if not over then
return false
end
end
return true
end

function xiantuchengjiuModel:getTaskConfig(eType,...)
local config_get=_config[eType][2]
return cfgHelper.get(config_get,...)
end

function xiantuchengjiuModel:getTaskWholeConfig(eType)
local config_get=_config[eType][1]
return config_get()
end

function xiantuchengjiuModel:findTaskDesc(eType,eKey1,eKey2,aimIdx,change)
local config=xiantuchengjiuModel:getTaskConfig(eType,eKey1,eKey2)
return self:findTaskDescEx(conf,aimIdx,change)
end

function xiantuchengjiuModel:findTaskDescEx(config,aimIdx,change)
if config==nil or config.taskaims==nil or config.taskaims[aimIdx]==nil then
return""
end
local aimNum=config.taskaims[aimIdx][1]
if change then
aimNum=mathHelper.formatNumber5(aimNum,2)
end
for i=aimIdx,1,-1 do
local desc=config.taskdesc[i]
if desc then
return FMT.fmt(desc,aimNum)
end
end
return""
end
