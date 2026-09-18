UIObjFadeNode=simple_class(baseNode)


function UIObjFadeNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UIObjFadeNode:update(interval)
if self.isplaying then
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
self.isplaying=true
local tweener=Lua.DOTweenProxyExtensions.DOTransformCanvasGroupFade(transform,val,duration)
if tweener==nil then return nodeState.success end
tweener:OnComplete(function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
else
CS.UIHelper.SetTransformAlpha(transform,val)
self.isplaying=false
self.bComplete=true
return nodeState.success
end

return nodeState.running
end

function UIObjFadeNode:skip()
if self.bComplete then
return nodeState.success
end
local val=self:getData('value')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
CS.UIHelper.SetTransformAlpha(transform,val)
self.isplaying=false
self.bComplete=true
return nodeState.success
end