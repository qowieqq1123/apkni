






storyActorExpressionNode=simple_class(baseNode)

function storyActorExpressionNode:update(interval)
local npcid=self:getData('npcid')
local expressid=self:getData('expressid')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
local image=npcModel:getImageInfoOutSide(npcid,1)
if spineHelper.enableChangeFace(image.body)then
if expressid>0 then
local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,expressid)
if cfg~=nil then
_MapManager.ChangeSlotDisplay(guid,"face","face",cfg.out_side)
end
else
_MapManager.ChangeSlotDisplay(guid,"face","face",0)
end
end
return nodeState.success
end
return nodeState.failure
end