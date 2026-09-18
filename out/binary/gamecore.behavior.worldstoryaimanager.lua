
worldStoryAIManager=gameState.addListener({})


function worldStoryAIManager:onAppStart()

end

function worldStoryAIManager:onEnterState(isReconnect)
if isReconnect then
return
end
end

function worldStoryAIManager:onLeaveState(isReconnect)
if isReconnect then
return
end
worldStoryAIManager:removeAllStoryEntity()
worldController:leaveStoryMode()
end


function worldStoryAIManager:isPlayingStory()
return self.storyBT~=nil
end

function worldStoryAIManager:startStoryBehavior(fileName,initData,callback)
if not mainControl:isSceneLoaded(eSceneType.eWorld)then
return
end
initData=initData or{}
initData.stateId=1
storyAICommonManager:setBehaviorName(fileName)
if callback then
storyAICommonManager:setBehaviorFunctionEndCallBack(callback)
end
self.storyBT=behaviorManager:addBehaviorTree(fileName,nil,true,initData)
worldController:enterStoryMode()

storyAICommonManager:posStoryNotify(true)
end


function worldStoryAIManager:removeAllStoryEntity(changeMode)
if self.storyBT then
behaviorManager:removeBehaviorTree(self.storyBT)
self.storyBT=nil
end
if changeMode then
worldController:leaveStoryMode()
end
end
