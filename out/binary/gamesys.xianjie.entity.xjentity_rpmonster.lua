









local xjEntity_RPMonster={}


function xjEntity_RPMonster:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
self.cfg=cfg
self.fightEffect=cfg.fightEffect
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.xjicontype=cfg.xjFilterType
self.data.xjicontype=cfg.xjFilterType
self.stage=cfg.stage
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster_id)
self.ent_name=monsterCfg.name
self.canSelect=true
self.allowClickGrid=true
end


function xjEntity_RPMonster:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local monsterData=xianjieModel:getResPointData(self.dataGuid)
local effect=monsterData:getSelectEffect()
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


function xjEntity_RPMonster:onCreateWidget(widget)
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

local flipX=self.flipX_mark
if flipX then
self.flipX_mark=nil
self:modelFlipX(widget,flipX)
end


self:removeSoldiers()
end

function xjEntity_RPMonster:createSoldier()
if self.cfg.xjsoldier and(self.xjsoldier==nil or next(self.xjsoldier)==nil)then
self.xjsoldier={}
for i,v in ipairs(self.cfg.xjsoldier)do
local data={}
data.pos=Vector3(self.pos.x+v[2],self.pos.y,self.pos.z+v[3])
local width,height=xianjieController:gridSize2WorldSize(1,1)
data.size=Vector2(width,height)
data.cfg=v
local parent={}
parent.guid=self.infoguid
parent.entityType=self.entityType
data.parent=parent
local key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMonsterSoldier,data,true)
self.xjsoldier[#self.xjsoldier+1]=key
end
end
end

function xjEntity_RPMonster:removeSoldiers()
if self.xjsoldier then
local len=#self.xjsoldier
for i=len,1,-1 do
local key=self.xjsoldier[i]
xianjieController:removeEntity(key)
end
end
self.xjsoldier=nil
end


function xjEntity_RPMonster:onUpdate()
if self.fightAttactTime then
if Time.realtimeSinceStartup>=self.fightAttactTime then
local widget=self:getWidget()
if widget then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
widget:SetChildSceneEntityPlayAnimation(0,self.fightEffect[1])
end
end
end
end


function xjEntity_RPMonster:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)

self:removeSoldiers()
if self.dead then
xianjieController:removeEntity(self:getKey())
end
end

function xjEntity_RPMonster:onDelete()

end

function xjEntity_RPMonster:onMyClick(boxParams)
xianjieController:onClickResPoint(self.dataGuid)
end




















































function xjEntity_RPMonster:playDeadAnim()
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
local widget=self:getWidget()
local rewards=data.drops
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.dead)
local hud=self:getHud()
if hud and hud.doDropAnim and rewards and#rewards>0 then
widget:SetChildSceneEntityChangeColor(0,Color.clear,1)
hud:doDropAnim(rewards,afterAnim)
else
widget:SetChildSceneEntityChangeColor(0,Color.clear,1,afterAnim)
end
end


function xjEntity_RPMonster:hideModel()
local widget=self:getWidget()
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0.01)
end

function xjEntity_RPMonster:showEffect()
local widget=self:getWidget()
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0.01)
widget:SetChildSceneEntityPlayEffect(0,11001,Vector3.zero,Vector3.one,true)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),1.5)
end

function xjEntity_RPMonster:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end

function xjEntity_RPMonster:modelFlipX(widget,flipX)
widget=widget or self:getWidget()
if widget then
widget:SetChildSceneEntityFlipX(0,flipX)
else
self.flipX_mark=flipX
end
end

function xjEntity_RPMonster:checkLogicShow()
local data=xianjieModel:getResPointData(self.dataGuid)
if data.source.srctype==xjResPointSourceType.ePlot then
return not xianjieController:checkCloudUnlockAnim(data.source.cloudid)
end
return true
end


return xjEntity_RPMonster