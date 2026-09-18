






bXJCameraLookAtNode=simple_class(baseNode)

function bXJCameraLookAtNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJCameraLookAtNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData("unitKey")
local position=self:getData("position")
local duration=self:getData("duration")or 0.2
local height=self:getData("height")or xianjieController:getCameraPosition().y
local ease=self:getData("ease")
local sceneidx=self:getData("sceneidx")

if unitKey and unitKey~=""then
local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
if ent.data.pos then
position=xianjieController:worldGridPos2WorldPos41(ent.data.pos[1],ent.data.pos[2],sceneidx or 0)
else
logErr("仙界 行为树 实体数据 缺少 pos 数据")
end
else
logErr("仙界 行为树 实体 unitKey 错误")
end
end

if position==nil then
return nodeState.failure
end

if sceneidx==nil then
return nodeState.failure
end

ease=ease and DG.Tweening.Ease.IntToEnum(ease)or DG.Tweening.Ease.InQuint

local callback=function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end

local pos=Vector3(position[1],position[2],position[3])

if duration>0 then
self.isplaying=true
self.bComplete=false
xianjieController:lookAtPositionChangeHeight(pos,height,duration,callback,ease)
return nodeState.running
else
xianjieController:lookAtPositionChangeHeight(pos,height,0,callback,ease)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end