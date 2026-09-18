









local xjEntity_ZhenTai={}


function xjEntity_ZhenTai:onInit()
local data=xianjieModel:getZhenTaiEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
self.xjicontype=1801
self.data.xjicontype=1801
end


function xjEntity_ZhenTai:onSelectHandle(widget,isSelect)
end


function xjEntity_ZhenTai:onCreateWidget(widget)
self:refreshZhenTaiModel(widget)
end


function xjEntity_ZhenTai:onRemoveWidget(widget)
end


function xjEntity_ZhenTai:onMyClick(boxParams)
xianjieController:openZhenTaiWin(self.data.seasonType,self.data.stageIndex,self.data.build_id)
end

function xjEntity_ZhenTai:onDelete()
end

function xjEntity_ZhenTai:refreshInfo()
self:refreshZhenTaiModel()

local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

function xjEntity_ZhenTai:refreshZhenTaiModel(widget)
local widget=widget or self:getWidget()
if widget then
local data=xianjieModel:getZhenTaiEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
local body,componets,scale,flip,offset,slotInfo,mount,effect=data:getModelData()
local boxParams=self:handleBoxParams()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)
widget:SetChildLocalPosition(2,offset)
if slotInfo then
widget:SetChildSceneEntitySetSlotIcon(0,slotInfo[1],slotInfo[2])
end
if effect then
local eOffset=effect.offset and mathHelper.convertArrayToVector(effect.offset)or Vector3.zero
local eScale=effect.scale or 1
if effect.hangPoint then
widget:SetChildSceneEntityPlayEffectOnActor(0,effect.id,effect.hangPoint,eOffset,Vector3.one*eScale)
else
widget:SetChildSceneEntityPlayEffect(0,effect.id,eOffset,Vector3.one*eScale,effect.attach==1)
end
end
if mount then
widget:SetChildSceneEntityMount(0,mount.model,mount.components,mount.handPoint,mount.scale,mathHelper.convertArrayToVector(mount.offset))
else
widget:SetChildSceneEntityUnMount(0)
end
end
end

return xjEntity_ZhenTai