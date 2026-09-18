









local xjEntityHud2_xingyu={}


function xjEntityHud2_xingyu:onInit()
self.needFollow=true
end

function xjEntityHud2_xingyu:getIconName()
local abname,iconname,desc,iconExtra

local entityType=self.entityType
local data=self.data
local xjicontype=data.xjicontype












local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
abname=globalABLookup.xjhud2icons
return abname,iconname,desc,iconExtra
end


function xjEntityHud2_xingyu:onCreateWidget(widget)

local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
widget:SetChildActive(-1,true)
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)
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
widget:SetChildButtonClick(0,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xjEntityHud2_xingyu:onRemoveWidget(widget)
self.isHideModel=nil
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xjEntityHud2_xingyu:onClick()
if not self:checkWidget()then return end

local data=self.data
local entityType=self.entityType
local xyId=data.xyId
XingYuController:openXYListWin(false,xyId)
end


return xjEntityHud2_xingyu
