itemsTablePool={}

local _pool={}

function itemsTablePool.getTable()
if#_pool>0 then
return table.remove(_pool,1)
end
local t={}
return t
end

function itemsTablePool.addTable(t)
if#_pool>0 then
return table.remove(_pool,1)
end
return{}
end