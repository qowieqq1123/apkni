











UIShakeNode=simple_class(baseNode)

function UIShakeNode:reset()
UIShakeNode._base.reset(self)
end

function UIShakeNode:broke()
if self.shakeDT then
self.shakeDT:Complete()
self.shakeDT:Kill()
self.shakeDT=nil
end
end


function UIShakeNode:update(interval)

local widget=self:getData('widget')
local target=self:getData('target')
local duration=self:getData('duration')
local strength=self:getData('strength')
local vibrato=self:getData('vibrato')

local roottransform=widget:GetChildGameObject(target).transform
self.shakeDT=_DOTweenProxy.DOShakePosition(roottransform,duration,Vector3.New(strength[1],strength[2],strength[3]),vibrato)
self.shakeDT:SetEase(_Ease.Linear)

return nodeState.success
end

function UIShakeNode:skip()
self:broke()
return nodeState.success
end