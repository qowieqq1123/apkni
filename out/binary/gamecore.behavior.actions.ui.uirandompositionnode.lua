







UIRandomPositionNode=simple_class(baseNode)

function UIRandomPositionNode:update(interval)
local dataMinPos=self:getData('minPos')
local dataMaxPos=self:getData('maxPos')
local outPos=self:getData('outPos')

if outPos and dataMinPos and dataMaxPos then
local minPos
if type(dataMinPos)=='string'then
minPos=self:getSharedVar(dataMinPos)
elseif type(dataMinPos)=='table'then
minPos=dataMinPos
end
local maxPos
if type(dataMaxPos)=='string'then
maxPos=self:getSharedVar(dataMaxPos)
elseif type(dataMaxPos)=='table'then
maxPos=dataMaxPos
end
if minPos and maxPos then
local x=math.random(minPos[1],maxPos[1])
local y=math.random(minPos[2],maxPos[2])
self:setSharedVar(outPos,{x,y})
return nodeState.success
end
end
return nodeState.failure
end

function UIRandomPositionNode:skip()
return self:update()
end
