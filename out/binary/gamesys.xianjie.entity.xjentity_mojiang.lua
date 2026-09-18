









local xjEntity_MoJiang={}


function xjEntity_MoJiang:onInit()
local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
self.xjicontype=1201
self.data.xjicontype=1201
end


function xjEntity_MoJiang:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
local effect=data:getSelectEffect()
if effect then
self.selectEffect=effect[1]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(1,self.selectEffect,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(1,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(1,Vector3(scale,scale,scale))
end
end
else
if self.selectEffect then
self.selectEffect=nil
widget:SetChildShowEffect(1,0,false)
end
end
end


function xjEntity_MoJiang:onCreateWidget(widget)
local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)

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





self:refreshState(widget)
end











function xjEntity_MoJiang:onRemoveWidget(widget)

end


function xjEntity_MoJiang:onMyClick(boxParams)
xianjieController:openMoJiangWin(self.data.seasonType,self.data.stageIndex,self.data.build_id)
end

function xjEntity_MoJiang:onDelete()

end

function xjEntity_MoJiang:refreshInfo()
self:refreshState()

local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

function xjEntity_MoJiang:refreshState(widget)
local widget=widget or self:getWidget()
if widget then
local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
local config=seasonModel:getStageConfigEx(self.data.seasonType,self.data.stageIndex,"mojiang",self.data.build_id)
local anim=config.anim
widget:SetChildSceneEntityPlayAnimation(0,data.killTime<=0 and anim[1]or anim[2],1,nil)
end
end

return xjEntity_MoJiang