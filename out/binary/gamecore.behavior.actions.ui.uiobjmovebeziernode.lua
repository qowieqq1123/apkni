UIObjMoveBezierNode=simple_class(baseNode)

function UIObjMoveBezierNode:reset()
self._base.reset(self)
self.isPlaying=false
self.bComplete=false
end

function UIObjMoveBezierNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local val=self:getData('value')
local duration=self:getData('duration')
local oSidler=self:getData('oSidler')
local eSidler=self:getData('eSidler')
local rate=self:getData('rate')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
if duration>0 then
self.isPlaying=true
local tweener=CS.UIBezierUtility.SetChildDoMovePathWithSlider(transform,val,oSidler,eSidler,duration,rate)
if tweener==nil then return nodeState.success end
tweener:OnComplete(function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end)
else
transform.position=val
self.bComplete=true
self.isPlaying=false
return nodeState.success
end

return nodeState.running
end

function UIObjMoveBezierNode:skip()
local val=self:getData('value')
local duration=0
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
transform.position=val
self.bComplete=true
self.isPlaying=false
return nodeState.success
end
