







local _countCache={}
local _listeners={}
local _tempTask={
cfg={
tasktype=-1,
aimnum=0,
params={},
}
}
local _emptyParam="————"

function taskController:clearCountCache()
_listeners={}
_countCache={}
end

function taskController:registerTaskCount(func)

if not table.containsValue(_listeners,func)then
table.insert(_listeners,func)
end
end

function taskController:unregisterTaskCount(func)
local index=table.findValue(_listeners,func)
if index then
table.remove(_listeners,index)
end
end

function taskController:listenTaskCount(taskType,taskParam,otherArgs,taskAim)
local check=taskModel:checkClientCheckTask(taskType)
if not check then return end

local paramKey=self:getTaskParamKey(taskParam)

if _countCache[taskType]and _countCache[taskType][paramKey]then
local cache=_countCache[taskType][paramKey]
cache.order=cache.order+1
cache.listenner[cache.order]={otherArgs,taskAim}
return cache.order
else
table.checkCreateSubTable(_countCache,{taskType,paramKey})
local cache=_countCache[taskType][paramKey]
local num=taskController:calculateTaskCount(taskType,taskParam)
cache.listenner={{otherArgs,taskAim}}
cache.current=num
cache.order=1
cache.param=taskParam
return cache.order
end
end

function taskController:unlistenTaskCount(taskType,taskParam,guid)
local paramKey=self:getTaskParamKey(taskParam)
if _countCache[taskType]and _countCache[taskType][paramKey]then
local cache=_countCache[taskType][paramKey]
cache.listenner[guid]=nil
end
end

function taskController:calculateTaskCount(taskType,taskParam)
local handle=taskModel:getClientCheckHandle(taskType)
_tempTask.cfg.tasktype=taskType
if type(taskParam)=="table"then
_tempTask.cfg.params=table.weakCopy(taskParam)
else
table.clear(_tempTask.cfg.params)
_tempTask.cfg.params[1]=taskParam and tonumber(taskParam)or taskParam
end
local state,progress,aim=handle(_tempTask)
return progress
end

function taskController:getTaskCount(taskType,taskParam)
local paramKey=self:getTaskParamKey(taskParam)
if _countCache[taskType]and _countCache[taskType][paramKey]then
return _countCache[taskType][paramKey].current
end
end

function taskController:getTaskParamKey(taskParam)
local paramKey
if not taskParam then
paramKey=_emptyParam
else
if type(taskParam)=="table"then
if not next(taskParam)then
paramKey=_emptyParam
else
paramKey=table.concat(taskParam,"—")
end
else
paramKey=taskParam
end
end
return paramKey
end

function taskController:triggerRecalculateTaskCount(eventType)
local tasktypes=taskModel:findTaskTypeByTaskEvent(eventType)
local list={}
for index,tasktype in ipairs(tasktypes)do
local temp=_countCache[tasktype]
if temp then
for paramKey,cache in pairs(temp)do
local taskparam=cache.param
local oNum=cache.current
local nNum=taskController:calculateTaskCount(tasktype,taskparam)
cache.current=nNum
for index,funcInfo in pairs(cache.listenner)do
local otherArgs=funcInfo[1]
local taskAim=funcInfo[2]
if taskAim then
if oNum<taskAim and nNum>=taskAim then
taskController:pushTempStorage(tasktype,taskparam,nNum)
end
end

table.insert(list,{tasktype=tasktype,tasktype=taskparam,otherArgs=otherArgs,taskAim=taskAim,current=nNum,previous=oNum})
end
end
end
end

for i,v in ipairs(_listeners)do

xpcall(v,function(err)
logErr('RecalculateTaskCount Callback err:',err)
end,list)
end
end