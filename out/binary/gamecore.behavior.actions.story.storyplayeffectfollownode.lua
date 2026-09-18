








storyPlayEffectFollowNode=simple_class(baseNode)

function storyPlayEffectFollowNode:start()
self.deltaTime=0
end

function storyPlayEffectFollowNode:reset()
storyPlayEffectFollowNode._base.reset(self)
self.deltaTime=0
end

function storyPlayEffectFollowNode:update(interval)
local duration=self:getData('duration')or 0

local state
if duration==0 then
state=self:playEffect()
return state
end
if self.deltaTime>=duration then
_stopEffect(self.effectId)
return nodeState.success
end
self.deltaTime=self.deltaTime+interval
if self.isPlaying then
return nodeState.running
end
self.isPlaying=true
state=self:playEffect(self.isPlaying)
return state
end

function storyPlayEffectFollowNode:playEffect(play)
local npcid=self:getData('npcid')
local effectid=self:getData('effectid')
local offset=self:getData('offset')or{0,0}
local follow=self:getData('follow')or 0

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
offset=Vector3(offset[1],offset[2],0)
self.effectId=_MapManager.PlayEffect(guid,effectid,offset,follow==0,true)
storyAIManager:setStoryBTBlackBoard(FMT.fmt('effect_{0}',npcid),self.effectId)
if play then
return nodeState.running
else
return nodeState.success
end
end
return nodeState.failure
end