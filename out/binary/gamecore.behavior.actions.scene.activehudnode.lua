
activeHUDNode=simple_class(baseNode)

function activeHUDNode:init()

end

function activeHUDNode:broke()
local reset=self:getData("default")
if reset then
local hud=self:getData("hud")
local active=self:getData("active")
local widget=hudControl:getHUDWidget(hud)
widget:SetChildActive(-1,not active)
end
end

function activeHUDNode:update(interval)
local hud=self:getData("hud")
local active=self:getData("active")
local widget=hudControl:getHUDWidget(hud)
widget:SetChildActive(-1,active)
return nodeState.success
end