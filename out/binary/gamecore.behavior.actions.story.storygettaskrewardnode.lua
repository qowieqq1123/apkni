





storyGetTaskRewardNode=simple_class(baseNode)

function storyGetTaskRewardNode:update(interval)
local taskid=self:getData('taskid')

taskController:doGetTaskReward(taskid)
return nodeState.success
end
