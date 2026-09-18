









UIAnimatorNode=simple_class(baseNode)

function UIAnimatorNode:reset()
UIUnMountNode._base.reset(self)
self.bComplete=false
end

function UIAnimatorNode:broke()

end

function UIAnimatorNode:update(interval)
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
if widget==nil then return nodeState.success end
local wIndex=self:getData('target')
local typo=self:getData('typo')
local paramName=self:getData('paramName')
local value=self:getData('value')
widget:SetChildAnimatorParameter(wIndex,typo,paramName,value)
return nodeState.success
end