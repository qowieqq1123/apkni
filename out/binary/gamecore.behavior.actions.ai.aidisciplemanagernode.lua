

aiDiscipleManagerNode=simple_class(baseNode)

function aiDiscipleManagerNode:update(interval)
local dzlist=aiManager:getDiscipleBTList()
for k,v in pairs(dzlist)do
v:tick(interval)
end

return nodeState.running
end