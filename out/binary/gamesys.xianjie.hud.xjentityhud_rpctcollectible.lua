









local xjEntityHud_RPCtCollectible={}
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

function xjEntityHud_RPCtCollectible:onInit()
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


function xjEntityHud_RPCtCollectible:onCreateWidget(widget)
self:refreshInfo()
widget:SetChildButtonClick(2,function()
self:onClick()
end)
widget:SetChildButtonClick(4,function()
self:onClick()
end)
end


function xjEntityHud_RPCtCollectible:onRemoveWidget(widget)

end


function xjEntityHud_RPCtCollectible:refreshInfo()
local widget=self:getWidget()
if widget then
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
widget:SetChildIcon(6,cfg.headimage,false)
widget:SetChildText(1,cfg.name)
end
end

function xjEntityHud_RPCtCollectible:onClick()
if not self:checkWidget()then return end
xianjieController:onClickResPoint(self.dataGuid)
end


function xjEntityHud_RPCtCollectible:onDelete()

end

return xjEntityHud_RPCtCollectible