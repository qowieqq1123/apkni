







setOtherBtVarNode=simple_class(baseNode)

local function _setBrokeVar(data,bt)
if data.brokeKey and data.brokeVal then

bt:setSharedVar(data.brokeKey,data.brokeVal)

end
end

local function _setOtherBtVar(data,bt,obt)
for k,v in pairs(data)do
local start=string.sub(k,1,3)
if start=='key'then
local index=tonumber(string.sub(k,4))
local value=data[string.format('val%d',index)]
obt:setSharedVar(v,value)
elseif start=='sha'then
local value=bt:getSharedVar(v)
obt:setSharedVar(v,value)
elseif start=='glo'then
local value=behaviorManager:getGlobalVar(v)
obt:setSharedVar(v,value)
end
end
end

function setOtherBtVarNode:update(interval)
local data=self.data
if data then
if data.btName then
local obt=self:getOtherBT(data.btName)
if obt then
_setOtherBtVar(data,self.owner,obt)
_setBrokeVar(data,obt)
return nodeState.success
end
elseif data.btList then
local obts=self:getSharedVar(data.btList)
if obts and#obts>0 then
for i,obt in ipairs(obts)do
_setOtherBtVar(data,self.owner,obt)
_setBrokeVar(data,obt)
end
return nodeState.success
end
end
end

return nodeState.failure
end