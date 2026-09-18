








invokeFunctionNode=simple_class(baseNode)

function invokeFunctionNode:update(interval)
local controlName=self:getData('control')
local funcName=self:getData('func')
local argsVal=self:getData('args')
local control=_G[controlName]
if control then
local func=control[funcName]
if func then
local args
if argsVal and argsVal=='table'then
args={}
for i,key in ipairs(argsVal)do
local value=self:getSharedVar(key)
if value then
table.insert(args,value)
end
end
end
if args then
func(control,unpack(args))
else
func(control)
end
return nodeState.success
end
end
return nodeState.failure
end
