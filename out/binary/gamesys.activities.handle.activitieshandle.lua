







local activitiesHandleLookup={}
function new_activitiesHandle(name,base)
local newT={}
local mT={
__index=base,
}
setmetatable(newT,mT)
newT:__init(name)
activitiesHandleLookup[name]=newT
return newT
end

function get_activitiesHandle(name)
local handle=activitiesHandleLookup[name]
if handle==nil then
local filename=FMT.fmt('lua.gamesys.activities.handle.{0}',name)
require(filename)

handle=activitiesHandleLookup[name]





end

return handle
end

function get_activitiesHandle2(subActType)
local name=activitiesController:getHandleName(subActType)
if name~=nil then
return get_activitiesHandle(name)
end
return nil
end

function call_activitiesHandle_func(hname,fname,...)
local handle=get_activitiesHandle(hname)
if handle then
local f=handle[fname]
if f then
return f(handle,...)
end
end
end

function call_activitiesHandle_func2(hname,fname,...)
local handle=get_activitiesHandle(hname)
if handle then
local f=handle[fname]
if f then
return f(...)
end
end
end

function call_activitiesHandle_func3(subActType,fname,...)
local handle=get_activitiesHandle2(subActType)
if handle then
local f=handle[fname]
if f then
return f(handle,...)
end
end
end

function call_activitiesHandle_func4(subActType,fname,...)
local handle=get_activitiesHandle2(subActType)
if handle then
local f=handle[fname]
if f then
return f(...)
end
end
end

function release_all_activitiesHandle()
if next(activitiesHandleLookup)then
for name,handle in pairs(activitiesHandleLookup)do
handle:__delete()
end
end
end

activitiesHandle={}

function activitiesHandle:__init(name)
self.name=name
self:onInit()
end

function activitiesHandle:__delete()
self.name=nil
self:onDelete()
end

function activitiesHandle:getName()
return self.name or'activitiesHandle'
end


function activitiesHandle:onInit()



end


function activitiesHandle:onDelete()



end
