local _cHandle={
[eXianTuChengJiuConditionType.ZongMenLevel]=function(param)
local need=param[2]
local have=zongmenModel:getLevel()
return have>=need
end,
[eXianTuChengJiuConditionType.ZongMenXianTu]=function(param)
local id=param[2]
local times=xiantuchengjiuModel:getZMXTTimes(id)
return times and times>0 or false
end,
[eXianTuChengJiuConditionType.ChengJiuTaskAim]=function(param)
local type=param[2]
local key1=param[3]
local key2=param[4]
local aimIdx=param[5]
local data=xiantuchengjiuModel:getTaskData(type,key1,key2)
return data.flag>=aimIdx
end,
}

local _cWarning={
[eXianTuChengJiuConditionType.ZongMenLevel]=function(param)
local need=param[2]
local str=FMT.fmt("宗门等级达到{0}级",need)
return str
end,
[eXianTuChengJiuConditionType.ZongMenXianTu]=function(param)
local need=param[2]
local str=FMT.fmt("领取{0}宗门奖励",UIDiscipleModel:getJJFloorNameEx(need))
return str
end,
[eXianTuChengJiuConditionType.ChengJiuTaskAim]=function(param)
local type=param[2]
local key1=param[3]
local key2=param[4]
local aimIdx=param[5]
local data=xiantuchengjiuModel:getTaskData(type,key1,key2)
local config=xiantuchengjiuModel:getTaskConfig(type,key1,key2)
return FMT.fmt("领取任务{0}奖励({1})",config.taskname,aimIdx)
end,
}

function xiantuchengjiuModel:checkConditions(conditions)
if conditions then
for i,v in ipairs(conditions)do
if not self:checkCondition(v)then
return false
end
end
end
return true
end

function xiantuchengjiuModel:checkCondition(param)
local type=param[1]
return _cHandle[type](param)
end

function xiantuchengjiuModel:getConditionWarning(conditions,sepStr,prevStr,posStr)
if conditions then
local str=nil
for i,v in ipairs(conditions)do
local type=v[1]
local temp=_cWarning[type](v)
if str then
str=FMT.fmt("{0}{1}{2}",str,sepStr or' ',temp)
else
str=temp
end
end
if str then
return FMT.fmt("{0}{1}{2}",prevStr or"",str,posStr or"")
end
end
end