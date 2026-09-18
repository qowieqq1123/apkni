









local xjEntity_NPC={}


function xjEntity_NPC:onInit()
local data=self.data
self.npcid=data[1]
self:initData()
end

function xjEntity_NPC:initData()
local npcData=xianjieModel:getNPCData(self.npcid)
self.pos=npcData:getWorldPos_1()
self.size=npcData:getWorldSize()
end


function xjEntity_NPC:onCreateWidget(widget)

end


function xjEntity_NPC:onRemoveWidget(widget)

end


function xjEntity_NPC:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

return xjEntity_NPC