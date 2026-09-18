



nodeState={
inactive=0,
failure=1,
success=2,
running=3,
}




baseNode=simple_class()

local _find=string.find
local _sub=string.sub





function _newData(d)
local newT={}
local mT={
__index=d,
__newindex=function(t,k,v)
if k~='state'then
return










end
rawset(t,k,v)
end
}
setmetatable(newT,mT)
return newT
end

function baseNode:__init(super,owner,parent,data,useSkip)

self._owner=owner
self._parent=parent
self._uid=owner:getID()
local nd={
getData=function(key)
return data[key]
end,
state=nodeState.inactive,



}
self._data=_newData(nd)
self:awake()
end

function baseNode:getPath()
local list={}
local nameStr=function(node)
return string.format('%s(%s)',node.name or'???',node.id or'?')
end
table.insert(list,nameStr(self))
local parent=self._parent
while(true)do
if parent then
table.insert(list,nameStr(parent))
parent=parent._parent
else
break
end
end
local str=''
for i=#list,1,-1 do
str=string.format('%s/%s',str,list[i])
end
return str
end

function baseNode:init()

end

function baseNode:awake()

end

function baseNode:start()
self:init()
end


function baseNode:quicklyTick()
self._owner:quicklyTick()
end



function baseNode:tick(interval)




if self._owner.isSkip then
self._data.state=self:skip()






self._owner.bRefresh=true
else
if self:canExecute()then
self._data.state=self:update(interval)
if self:isComplete()then
self._owner.bRefresh=true
end
end
end

return self._data.state
end


function baseNode:canExecute()
local state=self._data.state
return state==nodeState.running or state==nodeState.inactive
end


function baseNode:isComplete()
local state=self._data.state
return state==nodeState.success or state==nodeState.failure
end


function baseNode:isRuning()
return self._data.state==nodeState.running
end


function baseNode:isSuccess()
return self._data.state==nodeState.success
end


function baseNode:isFailure()
return self._data.state==nodeState.failure
end

function baseNode:broke()
end

function baseNode:remove()
end



function baseNode:update(interval)
return self._data.state
end

function baseNode:reset()
self._data.state=nodeState.inactive
self:init()
end

function baseNode:skip()

logErr('skip函数未实现',baseNode:getPath())
end

function baseNode:addChild(node)
end

function baseNode:getChildren()
end

function baseNode:maxChildren()
return 0
end

function baseNode:printError(...)
self:print('error',...)
end

function baseNode:print(logType,...)
if logType=='error'then
logErr(self:getPath(),...)
elseif logType=='wraning'then
logWarn(self:getPath(),...)
elseif logType=='info'then
logInfo(self:getPath(),...)
end
end





function baseNode:getOwner()
return self._owner
end


function baseNode:getParent()
return self._parent
end

function baseNode:getUID()
return self._uid
end

function baseNode:getArgs()
return self._owner.args
end

function baseNode:hasData(key)
return self._data.getData(key)~=nil
end


function baseNode:getData(key)
local val=self._data.getData(key)
if type(val)=='string'and _find(val,'@')==1 then
return self:getSharedVar(_sub(val,2))
end
return val
end

function baseNode:getDataValue(key)
return self._data.getData(key)
end

function baseNode:replaceData(content)
for key in string.gmatch(content,'@%w+')do
local val=self:getSharedVar(string.sub(key,2))
content=string.gsub(content,key,tostring(val))
end
return content
end

function baseNode:setState(state)
self._data.state=state
end

function baseNode:getState()
return self._data.state
end

function baseNode:setSharedVar(key,value)
self._owner:setSharedVar(key,value)
end

function baseNode:getSharedVar(key)
return self._owner:getSharedVar(key)
end

function baseNode:setGlobalVar(key,value)
behaviorManager:setGlobalVar(key,value)
end

function baseNode:getGlobalVar(key)
return behaviorManager:getGlobalVar(key)
end

function baseNode:isUseUnscaledTime()
return self._owner:isUseUnscaledTime()
end
