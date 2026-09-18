








bwEnterWorldNode=simple_class(baseNode)

function bwEnterWorldNode:update(interval)
local world=self:getData("world")
local position=self:getData("position")
local lookAt=self:getData("lookAt")
local lookAtUnit=self:getData("lookAtUnit")
local block=self:getData("block")
local mystery=self:getData("mystery")
local storyBTName=self:getData("storyBTName")

local params={
position=position and Vector3.New(position[1],position[2],position[3])or nil,
position=lookAt and Vector3.New(lookAt[1],lookAt[2],lookAt[3])or nil,
lookAtUnit=lookAtUnit,
block=block,
mystery=mystery,
storyBTName=storyBTName,
}

local check=worldController:enterWorld(world,params)

return check and nodeState.success or nodeState.failure
end