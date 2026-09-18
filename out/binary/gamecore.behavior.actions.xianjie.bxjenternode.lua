






bXJEnterNode=simple_class(baseNode)

function bXJEnterNode:init()
self.isJumping=true
self.isBroke=false

local sceneidx=self:getData('sceneidx')
local btName=self:getData('btName')

if sceneidx==nil then
logErr("进入仙界场景的索引为空")
self.isBroke=true
end

local enterCall=function()
self.isJumping=false
if btName then
xianjieStoryAIManager:startStoryBehavior(btName)
end
end
local isCanEnter=xianjieController:isSceneOpen(sceneidx,true)
if isCanEnter then
local enterParam={}
local result=xianjieController:enterXianJie(sceneidx,enterParam,enterCall)
if not result then
logErr("进入仙界失败")
self.isBroke=true
end
else
logErr("仙界不可进入")
self.isBroke=true
end
end

function bXJEnterNode:update(interval)

if self.isJumping then
return nodeState.running
end

if self.isBroke then
return nodeState.failure
end

return nodeState.success
end