

aiShutUpNode=simple_class(baseNode)

function aiShutUpNode:update(interval)
local args=self:getArgs()
aiManager:setDiscipleBTSharedVal(args.dzId,ai_stop_speak,true)
return nodeState.success
end