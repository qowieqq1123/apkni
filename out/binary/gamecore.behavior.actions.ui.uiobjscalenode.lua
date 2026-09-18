UIObjScaleNode=simple_class(baseNode)


function UIObjScaleNode:reset()
self._base.reset(self)
self.isPlaying=false
self.bComplete=false
end

function UIObjScaleNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local val=self:getData('value')
local duration=self:getData('duration')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
if duration>0 then
self.isPlaying=true
local tweener=Lua.DOTweenProxyExtensions.DOScale(transform,val,duration)
if tweener==nil then return nodeState.success end
tweener:OnComplete(function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end)
else
transform.localScale=Vector3(val,val,val)
self.bComplete=true
self.isPlaying=false
return nodeState.success
end

return nodeState.running
end

function UIObjScaleNode:skip()
if self.bComplete then
return nodeState.success
end

local val=self:getData('value')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
transform.localScale=Vector3(val,val,val)
self.bComplete=true
self.isPlaying=false
return nodeState.success
end
