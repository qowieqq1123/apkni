


registry_pool_class(fBTNodeTypo.SkillPrepare,'fBTSkillPrepareNode',fBTBaseNode)

function fBTSkillPrepareNode:__init(guid)
self.typo=fBTNodeTypo.SkillPrepare
end

function fBTSkillPrepareNode:parser(rawData)
self.hideOtherEntity=rawData[1]
end



function fBTSkillPrepareNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.restore=false
end


function fBTSkillPrepareNode:start()

self:doAction()
self.restore=true
self.state=fBTNodeState.success
end

function fBTSkillPrepareNode:doAction()
local battle=self.entity:getBattle()
local entities=battle:getEntities()
local targets=self.behaviorTree:getSharedValue('targets')or{}

self.opEnt={}

for _,ent in pairs(entities)do
local id=ent.id
if id~=self.entity.id and targets[id]==nil then
self.opEnt[#self.opEnt+1]=ent
ent:fadeToColor(Color.clear,0.5)
if ent.hud then
ent.hud:fade(0.2,0)
end
end
end


end

function fBTSkillPrepareNode:restoreState()
if self.opEnt~=nil then
for _,ent in pairs(self.opEnt)do
ent:fadeToColor(Color.white,0.5)
if ent.hud then
ent.hud:fade(0.2,1)
end
end
end
end

function fBTSkillPrepareNode:update(delta)

return self.state
end


function fBTSkillPrepareNode:onDespawn()
if self.restore then
self:restoreState()
end
self.restore=false
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

