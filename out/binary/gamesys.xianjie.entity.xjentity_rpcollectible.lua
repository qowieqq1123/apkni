









local xjEntity_RPCollectible={}


function xjEntity_RPCollectible:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
local cfg=data:getCfg()
self.ent_name=cfg.name
end


function xjEntity_RPCollectible:onCreateWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
local data=xianjieModel:getResPointData(self.dataGuid)
local body,componets,scale,flip,offset,slotInfo,mount,effect=data:getModelData()

local boxParams=self:handleBoxParams()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)

widget:SetChildLocalPosition(1,offset)
if data.source and data.source.srctype==xjResPointSourceType.eQiYu then
widget:SetChildShowEffectEx(2,11001,0,26,true)
end
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
if mount then
widget:SetChildSceneEntityMount(0,mount.model,mount.components,mount.handPoint,mount.scale,mathHelper.convertArrayToVector(mount.offset))
else
widget:SetChildSceneEntityUnMount(0)
end
end


function xjEntity_RPCollectible:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)

if self.dead then
xianjieController:removeEntity(self:getKey())
end
end

function xjEntity_RPCollectible:onMyClick(boxParams)
xianjieController:onClickResPoint(self.dataGuid)
end


function xjEntity_RPCollectible:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

function xjEntity_RPCollectible:playDeadAnim()
local afterAnim=function()
xianjieController:removeEntity(self:getKey())
end

local widget=self:getWidget()
if not widget then
afterAnim()
return
end

self.dead=true
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
local rewards=data.drops or cfg.reward
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.dead)
if self.effectHandle then
if self.effectHang then
widget:SetChildSceneEntityStopEffectOnActor(0,self.effectHandle)
else
CS.GameInterface.StopEffect(self.effectHandle)
end
end
local hud=self:getHud()
if hud and hud.doDropAnim and rewards and#rewards>0 then
widget:SetChildSceneEntityChangeColor(0,Color.clear,1)
hud:doDropAnim(rewards,afterAnim)
else
widget:SetChildSceneEntityChangeColor(0,Color.clear,1,afterAnim)
end
end


function xjEntity_RPCollectible:changeXBhud(flag)
local hud=self:getHud()
if hud then
hud:changeCollXianBangImg(flag)
end
end

function xjEntity_RPCollectible:checkLogicShow()
local data=xianjieModel:getResPointData(self.dataGuid)
if data.source.srctype==xjResPointSourceType.ePlot then
return not xianjieController:checkCloudUnlockAnim(data.source.cloudid)
end
return true
end


return xjEntity_RPCollectible