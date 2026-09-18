UISetTextNode=simple_class(baseNode)

function UISetTextNode:reset()
self._base.reset(self)
end

function UISetTextNode:update(interval)
local widget=self:getData('widget')
local wIndex=self:getData('target')
local content=self:getData('content')
widget:SetChildText(wIndex,content)
return nodeState.success
end


function UISetTextNode:skip()
return self:update()
end