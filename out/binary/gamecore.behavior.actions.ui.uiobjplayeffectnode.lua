UIObjPlayEffectNode=simple_class(baseNode)

function UIObjPlayEffectNode:broke()
local transform=self.transform
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return end
CS.GameInterface.PlayEffect(transform,0)
end

function UIObjPlayEffectNode:update(interval)
local effectId=self:getData('effect')
local objKey=self:getData('objTransform')
local transform=self:getSharedVar(objKey)
if objectHelper.isNil(transform)or objectHelper.isNil(transform.gameObject)then return nodeState.success end
self.transform=transform
CS.GameInterface.PlayEffect(transform,effectId)
return nodeState.success
end

function UIObjPlayEffectNode:skip()
return self:update()
end
