









local xj2DEntity_mojieGate={}

function xj2DEntity_mojieGate:getIconName()
local sceneEnity=self:getSceneEnity()

local abname,iconname,desc,iconExtra


local xjicontype=sceneEnity:getXJIconType()
local cfg=cfgHelper.get(cfg_fairylandentityicontypeconfig2_get,xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
abname=globalABLookup.xjhud2icons
return abname,iconname,desc,iconExtra
end


function xj2DEntity_mojieGate:onCreateWidget(widget)
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
end


function xj2DEntity_mojieGate:onRemoveWidget(widget)
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xj2DEntity_mojieGate:onMyClick()
local sceneEnity=self:getSceneEnity()

local gateId=sceneEnity.gateId
xianjieController:jumpMoJieGateByGateId(gateId,true,nil,nil,true)
UIManager:invokeUIMethod('UIXianJie_mapWin','onCloseBtn2')
end


function xj2DEntity_mojieGate:onDelete()

end

return xj2DEntity_mojieGate