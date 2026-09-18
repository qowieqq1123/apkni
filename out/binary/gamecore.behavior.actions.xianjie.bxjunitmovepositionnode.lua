






bXJUnitMovePositionNode=simple_class(baseNode)

function bXJUnitMovePositionNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJUnitMovePositionNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData('unitKey')
local position=self:getData('position')
local duration=self:getData('duration')
local anim=self:getData('anim')or eAnimationID.run
local ease=self:getData('ease')

ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.Linear

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

if position==nil then
logErr("仙界 行为树 创建实体 参数检测失败，position 为空")
return nodeState.failure
end






local pos=Vector3(position[1],position[2],position[3])

local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
local isFlip=pos.x>ent.pos.x
ent:setModelFlipX(isFlip)

if ent then
if duration>0 then
self.isplaying=true
self.bComplete=false
local callback=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
ent:modelPlayAnimation(eAnimationID.stand)
end
ent:modelPlayAnimation(eAnimationID.run)
ent:doMovePosition(pos,duration,ease,callback)
return nodeState.running
else
ent:setPosition(pos)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end
else
logErr("仙界 行为树 unitKey 错误")
return nodeState.failure
end
end