









local xjEntity_sceneEffect2={}


function xjEntity_sceneEffect2:onInit()
local data=self.data
self.modelID=data.modelID
if data.lifeTime then
self.endTime=Time.realtimeSinceStartup+data.lifeTime
else
self.endTime=nil
end
self.scale=data.scale or 1
self.offset=data.offset or Vector3.zero
self.pos=data.pos
self.size=data.size or Vector2.one
self.show=false
end


function xjEntity_sceneEffect2:onCreateWidget(widget)
self:showEffect(widget)
end


function xjEntity_sceneEffect2:onRemoveWidget(widget)
widget:SetChildShowEffect(0,-1,false)
if self.endTime~=nil then
self:removeEffect()
end
end


function xjEntity_sceneEffect2:onUpdate()
if self.endTime~=nil then
local nowTime=Time.realtimeSinceStartup
if nowTime>=self.endTime then
self:removeEffect()
end
end
end

function xjEntity_sceneEffect2:showEffect(widget)
if not self.show then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,self.modelID,{},'Entity',entCfg.sortOrder,self.scale,nil,false)
widget:SetChildLocalPosition(0,self.offset)
self.show=true
end
end

function xjEntity_sceneEffect2:removeEffect()
local ent_key=self:getKey()
xianjieController:removeBatterEffect(xjBattleEffectType.eScene2,tostring(ent_key))
end

function xjEntity_sceneEffect2:onDelete()

end

return xjEntity_sceneEffect2