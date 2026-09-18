






UIUnMountNode=simple_class(baseNode)

function UIUnMountNode:reset()
UIUnMountNode._base.reset(self)
self.bComplete=false
end

function UIUnMountNode:broke()

end

function UIUnMountNode:update(interval)
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local jd_args=self:getData('ju_args')
if widget==nil then return nodeState.success end

if type(jd_args)=='string'then
widget:SetChildUIModelUnMount(wIndex)
self:quicklyTick()
return nodeState.success
else
widget:SetChildUIModelUnMount(wIndex)
self.bComplete=true
self:quicklyTick()
return nodeState.running
end
end