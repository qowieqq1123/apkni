











UIRunAnimatorNode=simple_class(baseNode)

function UIRunAnimatorNode:init()
self.isWaitting=false
self.bComplete=false
self.endTime=nil
end

function UIRunAnimatorNode:broke()
self.isWaitting=nil
self.bComplete=nil
self.endTime=nil
end

function UIRunAnimatorNode:update(interval)
if self.endTime then
if Time.time>self.endTime then
return nodeState.success
end
return nodeState.running
end

if self.isWaitting then
if self.bComplete then
return nodeState.success
end
return nodeState.running
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local animId=self:getData('animId')

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local func
local state=nodeState.success
local duration=self:getData('duration')
if duration then
if duration>0 then
self.endTime=Time.time+duration
state=nodeState.running
end
else
self.isWaitting=true
func=function()
self.bComplete=true
self:quicklyTick()
end
state=nodeState.running
end

local speed=self:getData('speed')or 1
widget:SetChildModelAnimationState(wIndex,animId,speed,func)

return state
end

function UIRunAnimatorNode:skip()
return self:update()
end