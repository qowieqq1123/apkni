









local xjEntityHud_qiyu={}


function xjEntityHud_qiyu:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),Vector2(0,0)}
local data=self.data
self.cloudid=data[1]
self.idx=data[2]
end


function xjEntityHud_qiyu:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)
widget:SetChildWeakGuideComponentId(0,FMT.fmt('qiyuHudItem_{0}_{1}',self.cloudid,self.idx))

local cfg=cfgHelper.get2(cfg_fairylandcloudunlockconfig_get,self.cloudid,self.idx)
local scale,sizeX,sizeY,offsetX,offsetY
local size=cfg.size
if size then
scale=size[3]
sizeX=size[4]
sizeY=size[5]
offsetX=size[6]
offsetY=size[7]
end
scale=scale or 1
sizeX=sizeX or 50
sizeY=sizeY or 50
offsetX=offsetX or 0
offsetY=offsetY or 0
widget:SetChildUIModelShowTarget(1,cfg.spineID,scale,{},eAnimationID.stand,false,false,0)
widget:SetChildSizeDelta(0,sizeX,sizeY)
widget:SetChildAnchoredPos(1,offsetX,offsetY)
end


function xjEntityHud_qiyu:onRemoveWidget(widget)
widget:SetChildUIModelRemoveTarget(1)
end

function xjEntityHud_qiyu:onClick()
if not self:checkWidget()then return end
xianjieController:doCloudQiYu(self.cloudid,self.idx)
end


function xjEntityHud_qiyu:onDelete()

end

return xjEntityHud_qiyu