
storyEnding=simple_class(baseNode)

function storyEnding:update(interval)
storyAICommonManager:executeFunctionEndCallBack()
storyAIManager:removeAllStoryEntity(true)
worldStoryAIManager:removeAllStoryEntity(true)
xianjieStoryAIManager:removeAllStoryEntity(true)
return nodeState.success
end