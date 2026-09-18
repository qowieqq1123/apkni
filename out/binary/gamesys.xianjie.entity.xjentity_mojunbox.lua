









local xjEntity_MoJunBox={}


function xjEntity_MoJunBox:onInit()
local data=xianjieModel:getMoJunBoxEntityData(self.data.seasonType,self.data.stageIndex,self.data.boxId)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
end


function xjEntity_MoJunBox:onCreateWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
local data=xianjieModel:getMoJunBoxEntityData(self.data.seasonType,self.data.stageIndex,self.data.boxId)
local body,componets,scale,flip,offset,slotInfo,mount,effect=data:getModelData()

local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',3,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)

widget:SetChildLocalPosition(1,offset)
if slotInfo then
widget:SetChildSceneEntitySetSlotIcon(0,slotInfo[1],slotInfo[2])
end
if effect then
local eOffset=effect.offset and mathHelper.convertArrayToVector(effect.offset)or Vector3.zero
local eScale=effect.scale or 1
if effect.hangPoint then
self.effectHandle=widget:SetChildSceneEntityPlayEffectOnActor(0,effect.id,effect.hangPoint,eOffset,Vector3.one*eScale)
self.effectHang=true
else
self.effectHandle=widget:SetChildSceneEntityPlayEffect(0,effect.id,eOffset,Vector3.one*eScale,effect.attach==1)
self.effectHang=false
end
end
end


function xjEntity_MoJunBox:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntity_MoJunBox:onDelete()

end

function xjEntity_MoJunBox:onMyClick(boxParams)
xianjieController:openMoJunBoxWin(self.data.boxId)
end


function xjEntity_MoJunBox:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

return xjEntity_MoJunBox