









local xjEntityHud_cloud={}


function xjEntityHud_cloud:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),Vector2(0,0)}
local data=self.data
self.cloudid=data[1]
end


function xjEntityHud_cloud:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

self:refreshIcon(widget)




end

function xjEntityHud_cloud:refreshIcon(widget)
widget=widget or self:getWidget()
if widget==nil then return end







widget:SetChildActive(0,false)






end


function xjEntityHud_cloud:onRemoveWidget(widget)

end

function xjEntityHud_cloud:onClick()
if not self:checkWidget()then return end
xianjieController:handleClickCloud(self.cloudid)
end


function xjEntityHud_cloud:onDelete()

end

return xjEntityHud_cloud
