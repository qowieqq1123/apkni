UIObjActiveNode=simple_class(baseNode)
local GameObject=UnityEngine.GameObject
function UIObjActiveNode:reset()
self._base.reset(self)
end

function UIObjActiveNode:update(interval)
local val=self:getData('value')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
local isDestroy=self:getData('isDestroy')
if isDestroy then
GameObject.Destroy(transform.gameObject)
self:setSharedVar(objKey,nil)
else
transform.gameObject:SetActive(val)
end
return nodeState.success
end

function UIObjActiveNode:broke()
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return end
local isDestroy=self:getData('isDestroy')
if isDestroy then
GameObject.Destroy(transform.gameObject)
self:setSharedVar(objKey,nil)
else
transform.gameObject:SetActive(val)
end
end

function UIObjActiveNode:skip()
return self:broke()
end