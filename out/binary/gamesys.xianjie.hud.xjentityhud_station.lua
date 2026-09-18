









local xjEntityHud_station={}


function xjEntityHud_station:onInit()
local data=self.data
self.infoguid=data[1]
self.needFollow=true

self.tagOffset={Vector3(0,2.5,0),}
end


function xjEntityHud_station:onCreateWidget(widget)

local abname=globalABLookup.xjhudicons
local iconname=FMT.fmt('image_xjbs_mowu{0}',1)
widget:SetChildCSImageSprite(0,abname,iconname)
widget:SetChildButtonClick(0,function()
self:onClick()
end)

local stage_str=FMT.fmt('{0}阶',1)
widget:SetChildText(1,stage_str)




end


function xjEntityHud_station:onRemoveWidget(widget)

end

function xjEntityHud_station:onClick()
if not self:checkWidget()then return end
local infoguid=self.infoguid
xianjieController:openStationInfoWin(infoguid)
end

return xjEntityHud_station