local _tempStorage={}
local _emptyParam="————"

function taskController:send_7_28(list)
if list and#list>0 then
socketManager:send_7_28(#list,list)
end
end

function taskController:pushTempStorage(tasktype,taskparam,taskprogress)
table.checkCreateSubTable(_tempStorage,{tasktype})
local pKey=taskController:getTaskParamKey(taskparam)
_tempStorage[tasktype][pKey]=math.max(_tempStorage[tasktype][pKey]or 0,taskprogress)
end

function taskController:triggerTempStorage()
local list={}
for tasktype,temp in pairs(_tempStorage)do
for pKey,taskprogress in pairs(temp)do
local taskparam=pKey~=_emptyParam and tostring(pKey)or"0"
table.insert(list,{tasktype,taskparam,mathHelper.number_to_int64(taskprogress)})
end
end
self:send_7_28(list)
_tempStorage={}
end

function taskController:haveTempStorage()
return next(_tempStorage)~=nil
end
