







aiChangeSlotDisplay=simple_class(baseNode)

function aiChangeSlotDisplay:update(interval)
local args=self:getArgs()
local tarSlotName=self:getData('tarSlotName')
local slotName=self:getData('slotName')
local expressid=self:getData('expressid')

local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,expressid)
if cfg==nil then
_MapManager.ChangeSlotDisplay(args.stId,tarSlotName,slotName,0)
else
_MapManager.ChangeSlotDisplay(args.stId,tarSlotName,slotName,cfg.out_side)
end
return nodeState.success
end