





local xjEntity_lingshouGroup={}

function xjEntity_lingshouGroup:onInit()
local data=self.data
self.infoguid=data[1]

local lsData=xianjieModel:getXJLingShouGroupData(self.infoguid)
self.pos=lsData:getWorldPos_1()
self.size=lsData:getWorldSize()
local cfg=lsData:getCfg()
self.cfg=cfg
self.xjicontype=cfg.xjFilterType
self.data.xjicontype=cfg.xjFilterType

if cfg.monster then
local monsterGroupId=cfg.monster[1]
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
self.ent_name=groupCfg.name
end

self.canSelect=true
self.allowClickGrid=true
end


function xjEntity_lingshouGroup:onSelectHandle(widget,isSelect)

end

function xjEntity_lingshouGroup:onCreateWidget(widget)
local lsData=xianjieModel:getXJLingShouGroupData(self.infoguid)

local body,componets,scale,flip,offset,slotInfo,mount,effect=lsData:getModelData()
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


function xjEntity_lingshouGroup:playDeadAnim()
local afterAnim=function()
xianjieController:removeEntity(self:getKey())
end

local widget=self:getWidget()
if not widget then
afterAnim()
return
end

self.dead=true
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.dead,1)
widget:SetChildSceneEntityChangeColor(0,Color.clear,1,afterAnim)
end

function xjEntity_lingshouGroup:onRemoveWidget(widget)
if self.dead then
xianjieController:removeEntity(self:getKey())
end
end

function xjEntity_lingshouGroup:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end


function xjEntity_lingshouGroup:onMyClick(boxParams)
if self.dead then return end
local infoguid=self.infoguid
xianjieController:openLingShouGroupInfoWin(infoguid)
end



return xjEntity_lingshouGroup