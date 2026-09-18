
storyExcuteEndCallBackNode=simple_class(baseNode)

function storyExcuteEndCallBackNode:update(interval)
storyAICommonManager:executeEndCallBack()
return nodeState.success
end