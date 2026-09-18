









local xjEntityHud_XingYu={}


function xjEntityHud_XingYu:onInit()
self.needFollow=true



local data=self.data
self.xyId=data.xyId


end


function xjEntityHud_XingYu:onCreateWidget(widget)
local xyCfg=XingYuModel:getXingYuConfig(self.xyId)
local name=xyCfg.name
widget:SetChildText(0,name)
local xyCfg=XingYuModel:getXingYuConfig(self.xyId)
local modelCfg=xyCfg.modelCfg
local hudOffest=modelCfg.hudOffest
if hudOffest then



widget:SetChildAnchoredPos(1,hudOffest.x,hudOffest.y)
end
end


function xjEntityHud_XingYu:onRemoveWidget(widget)

end








return xjEntityHud_XingYu
