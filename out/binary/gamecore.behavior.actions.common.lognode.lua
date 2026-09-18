






logNode=simple_class(baseNode)

function logNode:update(interval)
local logStr=self:getData('content')
local replace=self:getData('replace')
if replace then
logStr=self:replaceData(logStr)
end
local logType=self:getData('logType')
self:print(logType,logStr)
return nodeState.success
end