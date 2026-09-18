









local xjEntity_sceneEffect={}


function xjEntity_sceneEffect:onInit()
local data=self.data
self.effectId=data.effect
self.startTime=data.startTime or timeHelper.getServerShortTime()
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,self.effectId)
local duration=effectCfg.lifetime and(effectCfg.lifetime/1000)or nil
self.endTime=data.endTime or(duration and self.startTime+duration or-1)or-1
self.scale=data.scale or Vector3.zero
self.offset=data.offset or Vector3.zero
self.sortingLayer=data.sortingLayer
self.sortingOrder=data.sortingOrder
self.pos=data.position
self.size=data.size or Vector2.one
self.show=false

end


function xjEntity_sceneEffect:onCreateWidget(widget)
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.startTime then
self:showEffect(widget)
end
end


function xjEntity_sceneEffect:onRemoveWidget(widget)
widget:SetChildShowEffect(0,-1,false)
self:removeEffect()
end


function xjEntity_sceneEffect:onUpdate()
local nowTime=timeHelper.getServerShortTime()

if nowTime>=self.endTime then
self:removeEffect()
elseif nowTime>=self.startTime and not self.show then
local widget=self:getWidget()
if widget then
self:showEffect(widget)
else
self:removeEffect()
end
end
end

function xjEntity_sceneEffect:showEffect(widget)
if not self.show then
if self.sortingLayer and self.sortingOrder then
widget:SetChildShowEffectEx(0,self.effectId,self.sortingLayer,self.sortingOrder,true)
else
widget:SetChildShowEffect(0,self.effectId,true)
end
widget:SetChildScale(0,self.scale)
widget:SetChildLocalPosition(0,self.offset)
self.show=true
end
end

function xjEntity_sceneEffect:removeEffect()
local ent_key=self:getKey()
xianjieController:removeBatterEffect(xjBattleEffectType.eScene,tostring(ent_key))
end

function xjEntity_sceneEffect:onDelete()

end

return xjEntity_sceneEffect