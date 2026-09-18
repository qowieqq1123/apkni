









local xj2DEntity_xingyu={}

function xj2DEntity_xingyu:getIconName()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local abname,iconname,desc,iconExtra

local xjicontype=data.xjicontype

local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
abname=globalABLookup.xjhud2icons
return abname,iconname,desc,iconExtra
end


function xj2DEntity_xingyu:onCreateWidget(widget)
local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)

widget:SetChildActive(-1,true)
if desc then
if desc[1]then
widget:SetChildText(1,desc[1][1])
widget:SetChildAnchoredPos(1,desc[1][2],desc[1][3])
else
widget:SetChildText(1,'')
end
if desc[2]then
widget:SetChildActive(2,true)
widget:SetChildText(3,desc[2])
else
widget:SetChildActive(2,false)
end
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
widget:SetChildButtonClick(4,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xj2DEntity_xingyu:onRemoveWidget(widget)
self.isHideModel=nil
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xj2DEntity_xingyu:onMyClick()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local xyId=data.xyId
XingYuController:openXYListWin(false,xyId)

UIManager:invokeUIMethod('UIXianJie_mapWin','onCloseBtn2')

end


function xj2DEntity_xingyu:onDelete()

end

return xj2DEntity_xingyu
