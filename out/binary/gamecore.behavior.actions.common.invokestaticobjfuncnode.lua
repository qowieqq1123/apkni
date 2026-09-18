














invokeStaticObjFuncNode=simple_class(baseNode)

local _find=string.find
local _sub=string.sub

function invokeStaticObjFuncNode:init()
local args=self:getData('args')
if not args or type(args)~='table'then
self.bReplace=false
return
end
self.bReplace=self:getData('replaceArgs')
if self.bReplace then
self.replaceList={}
for i,v in ipairs(args)do
if type(v)=='string'and _find(v,'@')==1 then
local key=_sub(v,2)
if key=='owner'then
table.insert(self.replaceList,{false,self:getOwner()})
else
table.insert(self.replaceList,{true,key})
end
else
table.insert(self.replaceList,{false,v})
end
end
end
end

function invokeStaticObjFuncNode:getReplaceArgs()
local args={}
for i,v in ipairs(self.replaceList)do
if v[1]then
args[i]=self:getSharedVar(v[2])
else
args[i]=v[2]
end
end
return args
end

function invokeStaticObjFuncNode:getClassObject()
local objName=self:getData('object')
local object=_G[objName]
return object
end

function invokeStaticObjFuncNode:update(interval)
local object=self:getClassObject()
if not object then
return nodeState.failure
end
local func=self:getData('func')
local args
if self.bReplace then
args=self:getReplaceArgs()
else
args=self:getData('args')
end
local ret
if args then
ret=object[func](object,unpack(args))
else
ret=object[func](object)
end

if ret==nil or ret then
return nodeState.success
else
return nodeState.failure
end
end