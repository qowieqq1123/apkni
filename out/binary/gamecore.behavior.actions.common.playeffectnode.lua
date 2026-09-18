








playEffectNode=simple_class(baseNode)

function playEffectNode:broke()
if self.isPlaying then
self:endPlay()
end
end

function playEffectNode:update(interval)
if self.isPlaying then
if Time.time>=self.endtime then
self:endPlay()
return nodeState.success
else
return nodeState.running
end
end

local effectId=self:getData('effectId')
local playTime=self:getData('playTime')
local attachTarget=self:getSharedVar(self:getData('attachTarget'))

self.id=_MapManager.PlayEffect(attachTarget,effectId,Vector3.New(0,0,0),true,true)
self.isPlaying=true
self.endtime=Time.time+playTime

return nodeState.running
end

function playEffectNode:endPlay()
_stopEffect(self.id)
self.isPlaying=false
end