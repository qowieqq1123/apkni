







UIHaveRoleInRadiusNode=simple_class(baseNode)

function UIHaveRoleInRadiusNode:update(interval)
local data=self.data
if data and data.radius and data.center then
local center
if type(data.center)=='string'then
center=self:getSharedVar(data.center)
elseif type(data.center)=='table'then
center=Vector3(data.center[1],data.center[2],0)
end
if center then
local have=UIRoleStateManager:haveRoleInRadius(center,data.radius)
if have then
return nodeState.success
end
end
end
return nodeState.failure
end

function UIHaveRoleInRadiusNode:skip()
return self:update()
end