





local xjEntity_lingshou={}

function xjEntity_lingshou:onInit()
local data=self.data
self.infoguid=data[1]

local lsData=xianjieModel:getXJLingShouData(self.infoguid)
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


function xjEntity_lingshou:onSelectHandle(widget,isSelect)

end

function xjEntity_lingshou:onCreateWidget(widget)
local lsData=xianjieModel:getXJLingShouData(self.infoguid)

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


function xjEntity_lingshou:playDeadAnim()
local lsData=xianjieModel:getXJLingShouData(self.infoguid)

if lsData==nil then return end

local afterAnim=function()
xianjieController:removeEntity(self:getKey())
end

local widget=self:getWidget()
if not widget then
afterAnim()
return
end

self:removeHud()


if lsData.isExpire then
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.dead,1)
widget:SetChildSceneEntityChangeColor(0,Color.clear,1,afterAnim)
return
end

local time=5
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(5,6512,nil,'Entity',entCfg.sortOrder+1,1,nil,false)
widget:SetChildLocalPosition(5,{10,10})
widget:SetChildActive(5,true)

widget:SetChildDOLocalMove(0,Vector3(-1,1,1),time)
widget:SetChildDOScale(0,0.1,time,function()
self.dead=true
widget:SetChildSceneEntityRemoveModel(5)
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.dead,1)
widget:SetChildSceneEntityChangeColor(0,Color.clear,1,afterAnim)
end)
end

function xjEntity_lingshou:onRemoveWidget(widget)
if self.dead then
xianjieController:removeEntity(self:getKey())
end
end

function xjEntity_lingshou:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end


function xjEntity_lingshou:onMyClick(boxParams)
if self.dead then return end
local infoguid=self.infoguid
xianjieController:openLingShouInfoWin(infoguid)
end



return xjEntity_lingshou