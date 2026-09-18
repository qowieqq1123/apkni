









local xjEntityHud_RPNPC={}


function xjEntityHud_RPNPC:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
self.needFollow=true

local uiOffset=cfg.uiOffset
local tagOffset=cfg.tagOffset
if uiOffset then
self.uiOffset={}
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
end
if tagOffset then
self.tagOffset={}
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
end
end


function xjEntityHud_RPNPC:onCreateWidget(widget)
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
widget:SetChildActive(0,cfg.hudParam==1)
widget:SetChildButtonClick(0,function()
xianjieController:onClickResPoint(self.dataGuid)
end)
end


function xjEntityHud_RPNPC:onRemoveWidget(widget)

end


function xjEntityHud_RPNPC:onDelete()

end

return xjEntityHud_RPNPC