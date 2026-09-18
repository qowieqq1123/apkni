








bwUnitShowEffectNode=simple_class(baseNode)

function bwUnitShowEffectNode:init()
self.deltaTime=0
self.duration=nil
end

function bwUnitShowEffectNode:update(interval)
if self.duration then
self.deltaTime=self.deltaTime+interval
if self.deltaTime>=self.duration then
if self.autoRemove then
worldController:stopModelEffect(self.unitKey,self.effect)
end
return nodeState.success
end
return nodeState.running
end

self.unitKey=self:getData('unitKey')
self.effect=self:getData('effect')
self.duration=self:getData('duration')or 0
self.resetFlag=self:getData('reset')or false
local offset=self:getData("offset")or{0,0,0}
local scale=self:getData('scale')or{1,1,1}
local handPoint=self:getData('handPoint')
local attach=self:getData('attach')
self.autoRemove=self:getData('remove')
self.show=self:getData('show')or true
offset=mathHelper.convertArrayToVector(offset)
scale=mathHelper.convertArrayToVector(scale)
if self.unitKey==nil or self.effect==nil then
return nodeState.failure
end

if self.show then
worldController:playModelEffect(self.unitKey,self.effect,offset,scale,handPoint,attach)
return nodeState.running
else
worldController:stopModelEffect(self.unitKey,self.effect)
return nodeState.success
end
end

function bwUnitShowEffectNode:broke()
if self.show and self.unitKey~=nil and self.effect~=nil and self.resetFlag and self.duration>0 then
worldController:stopModelEffect(self.unitKey,self.effect)
end
end