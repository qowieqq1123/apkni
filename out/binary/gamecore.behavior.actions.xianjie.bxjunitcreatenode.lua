






bXJUnitCreateNode=simple_class(baseNode)


function bXJUnitCreateNode:init()

end

function bXJUnitCreateNode:update(interval)
local unitKey=self:getData('unitKey')
local position=self:getData('position')
local sceneIdx=self:getData('sceneIdx')
local modelId=self:getData('modelId')
local anim=self:getData('anim')or eAnimationID.stand
local show=self:getData('show')

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

if position==nil then
logErr("仙界 行为树 创建实体 参数检测失败，position 为空")
return nodeState.failure
end

if sceneIdx==nil then
logErr("仙界 行为树 创建实体 参数检测失败，sceneIdx 为空")
return nodeState.failure
end

if modelId==nil then
logErr("仙界 行为树 创建实体 参数检测失败，modelId 为空")
return nodeState.failure
end


self.unitKey=unitKey

if show==nil then
show=true
end

local luaData=self:getData('luaData')or{}
local unitType=self:getData('unitType')
unitType=unitType or XJ_ENTITY_TYPE.eStoryPlot
local needRefreshAOI=self:getData('needRefreshAOI')
local scale=self:getData('scale')

luaData.pos=position
luaData.sceneidx=sceneIdx
luaData.modelId=modelId
luaData.unitType=unitType
luaData.anim=anim
luaData.unitKey=unitKey
luaData.show=show
luaData.scale=scale

local createResult=xianjieController:pushStoryUnit(unitKey,unitType,luaData,needRefreshAOI)
if not createResult then
logErr("仙界 行为树 创建实体 失败，unityKey =",unitKey)
end

return nodeState.success
end