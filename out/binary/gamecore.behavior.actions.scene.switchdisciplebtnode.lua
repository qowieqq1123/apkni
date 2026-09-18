







switchDiscipleBTNode=simple_class(baseNode)

local _format=string.format

local function _setBTSharedVar(bt,data)
if data then
for k,v in pairs(data)do
local start=string.sub(k,1,3)
if start=='key'then
local index=tonumber(string.sub(k,4))
local value=data[_format('val%d',index)]
bt:setSharedVar(v,value)
elseif start=='glo'then
local value=behaviorManager:getGlobalVar(v)
bt:setSharedVar(v,value)
end
end
end
end

local function _switchBT(bt,stateId,data)
if bt and stateId then
bt=discipleStateManager:addBehaviorTree(bt.args.dzId,bt.args,stateId)
if bt then
_setBTSharedVar(bt,data)
end
end
end

function switchDiscipleBTNode:start()






















end

function switchDiscipleBTNode:update(interval)
local stateId=self.data and self.data.stateId or self:getSharedVar(behaviorConfig.stateIdKey)

local btList=self.data and self.data.btList
if btList then
local obts=self:getSharedVar(btList)
if obts then
for i,obt in ipairs(obts)do
_switchBT(obt,stateId,self.data)
end
end
end

local bt
local btName=self.data and self.data.btName
if btName then
bt=self:getOtherBT(btName)
else
bt=self.owner
end
_switchBT(bt,stateId,self.data)
return nodeState.success
end