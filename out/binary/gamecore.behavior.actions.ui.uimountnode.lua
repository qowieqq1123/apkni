











UIMountNode=simple_class(baseNode)

function UIMountNode:reset()
UIMountNode._base.reset(self)
self.bComplete=false
end

function UIMountNode:broke()

end

function UIMountNode:update(interval)
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local mountBodyID=self:getData('mountBodyID')
local slots=self:getData('mountSlots')
local mountSlots
if type(slots)=='string'then
mountSlots={}
else
mountSlots=slots
end
local mountHP=self:getData('mountHP')
local mountScale=self:getData('mountScale')
local offset=self:getData('mountOffset')
local mountOffset=Vector3.New(offset[1],offset[2],offset[3]or 0)
local ju_args=self:getData('ju_args')
if widget==nil then return nodeState.success end

if type(ju_args)=='string'then
widget:SetChildUIModelMount(wIndex,mountBodyID,mountSlots,mountHP,mountScale,mountOffset,function()
self.bComplete=true
self:quicklyTick()
end)
return nodeState.running
else
widget:SetChildUIModelMount(wIndex,mountBodyID,mountSlots,mountHP,mountScale,mountOffset,function()
self.bComplete=true
self:quicklyTick()
end)
return nodeState.running
end
end