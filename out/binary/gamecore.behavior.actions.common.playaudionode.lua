








playAudioNode=simple_class(baseNode)

function playAudioNode:update(interval)
local id=self:getData('id')
local filterType=self:getData('filterType')

local priority=self:getData('priority')
local volWeight=self:getData('volWeight')
AudioManager.playAudio(id,volWeight,priority)
return nodeState.success
end