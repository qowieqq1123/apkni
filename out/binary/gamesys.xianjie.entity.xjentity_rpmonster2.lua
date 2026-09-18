









local xjEntity_RPMonster2={}


function xjEntity_RPMonster2:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
self.fightEffect=cfg.fightEffect
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.xjicontype=cfg.xjFilterType
self.data.xjicontype=cfg.xjFilterType
self.allowClickGrid=true
self.ent_name=cfg.feign.name
end


function xjEntity_RPMonster2:onCreateWidget(widget)
local data=xianjieModel:getResPointData(self.dataGuid)
local body,componets,scale,flip,offset,slotInfo,mount,effect=data:getModelData()

local boxParams=self:handleBoxParams()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)

widget:SetChildLocalPosition(2,offset)
if data.source and data.source.srctype==xjResPointSourceType.eQiYu then
widget:SetChildShowEffectEx(4,11001,0,26,true)
end
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


function xjEntity_RPMonster2:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntity_RPMonster2:onDelete()

end

function xjEntity_RPMonster2:onMyClick(boxParams)
local data=xianjieModel:getResPointData(self.dataGuid)
if not data then return end

data.feign=false

local widget=self:getWidget()
if widget then
data:removeEntity(true)
end
end

function xjEntity_RPMonster2:playDeadAnim()
local data=xianjieModel:getResPointData(self.dataGuid)
if not data then
xianjieController:removeEntity(self:getKey())
return
end

local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),1,function()
xianjieController:removeEntity(self:getKey())
data:createEntity(true)
end)
else
xianjieController:removeEntity(self:getKey())
data:createEntity(true)
end
end

function xjEntity_RPMonster2:checkLogicShow()
local data=xianjieModel:getResPointData(self.dataGuid)
if data.source.srctype==xjResPointSourceType.ePlot then
return not xianjieController:checkCloudUnlockAnim(data.source.cloudid)
end
return true
end


return xjEntity_RPMonster2