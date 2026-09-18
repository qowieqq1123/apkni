








bwUnitCreateNode=simple_class(baseNode)

function bwUnitCreateNode:update(interval)

local unitKey=self:getData('unitKey')
local position=self:getData('position')

if unitKey==nil or position==nil then
return nodeState.failure
end
position=worldPositionConfig:getPosition_CurrentWorld(position)

local luaData=self:getData('luaData')or{}

local unitType=self:getData('unitType')
local modelRes=self:getData('modelRes')
local modelSettings=modelRes and worldModel:getModelSettings(modelRes,unitType)or nil

local hudRes=self:getData('hudRes')
local hudSetting=hudRes and worldModel:getHUDSetting(hudRes)or nil

local symbolRes=self:getData('symbolRes')
local symbolSetting=symbolRes and worldModel:getSymbolSetting(symbolRes)or nil

local click=self:getData('click')or true

worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSetting,symbolSetting,click)

return nodeState.success
end