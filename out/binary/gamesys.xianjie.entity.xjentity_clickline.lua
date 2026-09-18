









local xjEntity_clickLine={}


function xjEntity_clickLine:onInit()
self:initData()
end

function xjEntity_clickLine:initData()
local data=self.data
local cpos=data[4]
self.pos=cpos
local width,height=xianjieController:gridSize2WorldSize(1,1)
self.size=Vector2(width,height)
end


function xjEntity_clickLine:onCreateWidget(widget)
local data=self.data
local clickEntKey=data[1]
local spos=data[2]
local epos=data[3]
local scale=2.5
local ent=xianjieController:getEntity(clickEntKey)
local teamHandle=ent:getTeamHandle()
local prefabType=teamHandle:getLineColor()
local abname=globalABLookup.xjhudicons
local icon
if prefabType==sceneLineType.eGreenArrow then
icon='image_xjbs_jt1'
elseif prefabType==sceneLineType.eBlueArrow then
icon='image_xjbs_jt2'
elseif prefabType==sceneLineType.eRedArrow then
icon='image_xjbs_jt3'
elseif prefabType==sceneLineType.eGrayArrow then
icon='image_xjbs_jt4'
end

widget:SetChildSpriteRendererWithBundle(0,globalABLookup.xjhudicons,icon,false)
widget:SetChildScale(0,Vector3(scale,scale,1))


local angle_deg=mathHelper.getAngleByPos(spos.x,spos.z,epos.x,epos.z)
widget:SetChildRotation(0,90,0,angle_deg)
end


function xjEntity_clickLine:onRemoveWidget(widget)

end

function xjEntity_clickLine:onDelete()

end

return xjEntity_clickLine