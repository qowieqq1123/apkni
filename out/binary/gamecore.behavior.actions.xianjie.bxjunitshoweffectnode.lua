






bXJUnitShowEffectNode=simple_class(baseNode)

function bXJUnitShowEffectNode:init()
self.deltaTime=0
self.duration=nil
end

function bXJUnitShowEffectNode:update(interval)
if self.duration and self.duration>0 then
self.deltaTime=self.deltaTime+interval
if self.deltaTime>=self.duration then
self.ent:stopEffect()
return nodeState.success
end
return nodeState.running
end

self.unitKey=self:getData('unitKey')
self.effect=self:getData('effectId')
local offset=self:getData('offset')or{0,0,0}
local scale=self:getData('scale')or{1,1,1}
self.show=self:getData('show')or true
self.duration=self:getData('duration')or 0

if self.unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

if self.effect==nil then
logErr("仙界 行为树 创建实体 参数检测失败，effectId 为空")
return nodeState.failure
end

local entKey=xianjieModel:getStoryUnit(self.unitKey)
if entKey then
self.ent=xianjieController:getEntity(entKey)
if self.ent==nil then
return nodeState.failure
end
else
return nodeState.failure
end



if self.show then
self.ent:showEffect(self.effect,nil,nil,self.show,offset,scale)
if self.duration>0 then
return nodeState.running
end
else
self.ent:stopEffect()
return nodeState.success
end


return nodeState.success
end

function bXJUnitShowEffectNode:broke()
if self.show and self.unitKey~=nil and self.effect~=nil and self.duration>0 then
self.ent:stopEffect()
end
end