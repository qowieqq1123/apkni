







storyActorFadeNode=simple_class(baseNode)

function storyActorFadeNode:start()
self.deltaTime=0
end

function storyActorFadeNode:reset()
storyActorFadeNode._base.reset(self)
self.deltaTime=0
self.isFadeing=false
end

function storyActorFadeNode:update(interval)
local npcid=self:getData('npcid')
local active=self:getData('active')
local duration=self:getData('duration')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
if duration==0 then
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,active),0,nil)
return nodeState.success
end

if self.deltaTime>=duration then
return nodeState.success
end
self.deltaTime=self.deltaTime+interval
if self.isFadeing then
return nodeState.running
end
self.isFadeing=true
self.state=nodeState.running
local func=function(...)
self.isFadeing=false
self.state=nodeState.success
end
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,active),duration,func)
return self.state
end
return nodeState.success
end

function storyActorFadeNode:skip()
local npcid=self:getData('npcid')
local active=self:getData('active')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid and active then
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,active),0,nil)
end
return nodeState.success
end