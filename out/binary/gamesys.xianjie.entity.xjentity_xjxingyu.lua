









local xjEntity_XJXingYu={}


function xjEntity_XJXingYu:onInit()
local xyId=self.data.xyId
local data=XingYuController:getEntityData(xyId)
if not data then
logErr("没有星域实体数据--》》",xyId)
return
end

self.xjicontype=801
self.data.xjicontype=self.xjicontype
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local modelCfg=xyCfg.modelCfg
local posOffestY=modelCfg.posOffestY or 0
self.pos=data:getWorldPos_1()
self.pos.y=self.pos.y+posOffestY
self.size=data:getWorldSize()
self.ent_name=FMT.fmt("xjEntity_XJXingYu{0}",xyId)
self.canSelect=true
self.allowClickGrid=true

end


function xjEntity_XJXingYu:onSelectHandle(widget,isSelect)

end


function xjEntity_XJXingYu:onCreateWidget(widget)


self.widget=widget

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local xyId=self.data.xyId
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local modelCfg=xyCfg.modelCfg
local animId=eAnimationID.idle

local modelId=modelCfg.modelId
widget:SetChildSceneEntityCreateObject(0,modelId)
local scale=modelCfg.scale
if scale then
widget:SetChildScale(0,Vector3.New(scale,scale,scale))
end
local rotCfg=modelCfg.rotCfg
if rotCfg then

widget:SetChildRotation(0,rotCfg.x,rotCfg.y,rotCfg.z)
end

local boxParams=self:handleBoxParams()


local clickBox=modelCfg.clickBox
if clickBox then
local boxSize=Vector2.New(clickBox.w,clickBox.h)
local boxOffset=Vector2.zero
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
end




end


function xjEntity_XJXingYu:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
self.widget=nil
end


function xjEntity_XJXingYu:onMyClick(boxParams)
XingYuController:openXYListWin(false,self.data.xyId)
end

function xjEntity_XJXingYu:onDelete()

end

return xjEntity_XJXingYu
