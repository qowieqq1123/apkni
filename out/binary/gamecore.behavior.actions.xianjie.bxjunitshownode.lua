






bXJUnitShowNode=simple_class(baseNode)

function bXJUnitShowNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJUnitShowNode:update(interval)

if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData('unitKey')
local show=self:getData('show')

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

xianjieController:showUnit(unitKey,show)

return nodeState.success
end