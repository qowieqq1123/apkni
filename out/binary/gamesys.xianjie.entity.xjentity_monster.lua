









local xjEntity_monster={}


function xjEntity_monster:onInit()
local data=self.data
self.infoguid=data[1]
self.isSpine_EYid=data[2]
if self.isSpine_EYid then
self.data.isHudSpine=self.isSpine_EYid
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
self.pos=monsterData:getWorldPos_1()
self.size=monsterData:getWorldSize()
local cfg=monsterData:getCfg()
self.cfg=cfg
self.xjicontype=cfg.xjFilterType
self.data.xjicontype=cfg.xjFilterType
self.stage=cfg.stage
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if cfg.monster then
local monsterGroupId=cfg.monster[1]
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
self.ent_name=groupCfg.name
else
self.ent_name=cfg.name or'宝箱'
end
self.canSelect=true
self.allowClickGrid=true
end


function xjEntity_monster:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local monsterData=xianjieModel:getMonsterData(self.infoguid)
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


function xjEntity_monster:onCreateWidget(widget)
local monsterData=xianjieModel:getMonsterData(self.infoguid)








local body,componets,scale,flip,offset,slotInfo,mount,effect=monsterData:getModelData()
local boxParams=self:handleBoxParams()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)
self:CreatSpineOnHide(widget)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)

if monsterData.entitytype==xjServerEnityType.eMoJieBox then
widget:SetChildSceneEntitySetOffset(0,offset)
else
widget:SetChildLocalPosition(2,offset)
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


local afterCall=function()
self:createSoldiers()

self:playCreatSpineEnd()
end

if self:isPlayCreatSpine()then
self:playCreatSpineStart(afterCall)
else
self:createSoldiers()

end


self:MoZong_playEffect()


self:SpeZhenYan_playEffect()
end

function xjEntity_monster:createSoldiers()
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


function xjEntity_monster:playDeadAnim()
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

function xjEntity_monster:removeSoldiers()
if self.xjsoldier then
local len=#self.xjsoldier
for i=len,1,-1 do
local key=self.xjsoldier[i]
xianjieController:removeEntity(key)
end
self.xjsoldier=nil
end
end


function xjEntity_monster:onRemoveWidget(widget)
self:SpeZhenYan_StopEffect()
self:stop_SpeZhenYan_Move()
widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityRemoveModel(5)
self.isSpine_EYid=nil
self:resertIsSpineData()
self:removeSoldiers()
if self.dead then
xianjieController:removeEntity(self:getKey())
end
end

function xjEntity_monster:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end

function xjEntity_monster:modelFlipX(widget,flipX)
widget=widget or self:getWidget()
if widget then
widget:SetChildSceneEntityFlipX(0,flipX)
else
self.flipX_mark=flipX
end
end


function xjEntity_monster:onMyClick(boxParams)
if self.dead then return end
local infoguid=self.infoguid
xianjieController:openMonsterInfoWin(infoguid)
end

function xjEntity_monster:onDelete()
self:SpeZhenYan_StopEffect()
self:stop_SpeZhenYan_Move()
self:removeSoldiers()
self.ZMMoving=nil
self.isSpine_EYid=nil
end


function xjEntity_monster:showEffect()
local widget=self:getWidget()

if widget then
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0.01)
widget:SetChildSceneEntityPlayEffect(0,11001,Vector3.zero,Vector3.one,true)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),1.5)
end
end


function xjEntity_monster:showMZAttackRange()
local widget=self:getWidget()
if not widget then
return
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if not self.ZMMoving or(monsterData.entitytype~=xjServerEnityType.eMoJieMoZong_Small and
monsterData.entitytype~=xjServerEnityType.eMoJieMoZong_Big)then



widget:SetChildActive(4,false)
return
end
local _sX=25
local _sY=25
local range=self.cfg.range
local w=range*2+monsterData.gridWidth
local h=range*2+monsterData.gridHeight


local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayerName='Entity'
local sortingOrder=entCfg.sortOrder


widget:SetChildActive(4,true)
widget:SetChildSpriteRendererSortingLayer(4,sortingLayerName,sortingOrder-1)
widget:SetChildScale(4,Vector3.New(_sX*w,_sY*h,0))






















end








function xjEntity_monster:onDelete()
self.isSpine_EYid=nil
xianjieModel:removeMoZongAttackRange(self.infoguid)
end


function xjEntity_monster:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small then
self:MoZong_playEffect()
elseif monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then
self:MoZong_playEffect()

end
self:SpeZhenYan_Move()
self:UpdateModel()
end


function xjEntity_monster:resertIsSpineData()
if self.data and self.data.isHudSpine then
self.data.isHudSpine=false
end
end

function xjEntity_monster:delayDo(time,func)
timeEventController.delayDo(time,function()
if self then
func()
end
end)
end

function xjEntity_monster:isPlayCreatSpine()
if self.isSpine_EYid then
return true
end
end

function xjEntity_monster:CreatSpineOnHide(widget)
if widget and self:isPlayCreatSpine()then
if self.isSpine_EYid==xjServerEnityType.eMoJieShangGuMoster then
widget:SetChildShowEffect(1,0,false)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)
elseif self.isSpine_EYid==xjServerEnityType.eMoJieBox then
widget:SetChildShowEffect(1,0,false)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)
end
end
end

function xjEntity_monster:playCreatSpineStart(afterCall)
if self.isSpine_EYid==xjServerEnityType.eMoJieShangGuMoster then
self:Start_playCreatSpine_SGMH(afterCall)
elseif self.isSpine_EYid==xjServerEnityType.eMoJieBox then
self:Start_playCreatSpine_SGBox(afterCall)
end
end

function xjEntity_monster:playCreatSpineEnd()
if self.isSpine_EYid==xjServerEnityType.eMoJieShangGuMoster then
self:End_playCreatSpine_SGMH()
end
end

function xjEntity_monster:Start_playCreatSpine_SGMH(afterCall)

local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,false)end

local widget=self:getWidget()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)

if widget then

widget:SetChildShowEffect(1,0,false)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)
widget:SetChildScale(0,Vector3.New(0,0,0))

local modelParam={6089,{0,0,0},1.5}
local spineId=modelParam[1]
local offset=modelParam[2]
local scale=modelParam[3]
widget:SetChildActive(5,true)
widget:SetChildSceneEntityCreateModel(5,spineId,{},'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityChangeColor(5,Color.New(1,1,1,0),0.01)
widget:SetChildLocalPosition(5,mathHelper.convertArrayToVector(offset))
widget:SetChildSceneEntityPlayAnimation(5,3201,1,nil)
widget:SetChildSceneEntityChangeColor(5,Color.New(1,1,1,1),1)

self:delayDo(0.2,function()
if not widget then
return
end

widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),3)
widget:SetChildDOScale(0,1,2.5,function()


hud=self:getHud()
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,true)end
self:resertIsSpineData()
widget:SetChildShowEffect(1,0,true)
if afterCall then
afterCall()
end
end)
end)
end
end

function xjEntity_monster:End_playCreatSpine_SGMH()
local monsterTypeName=xianjieModel:getSgMonsterTypeName()
UIManager.info(FMT.fmt('【{0}】破界而出，尽快诛灭',monsterTypeName))
end

function xjEntity_monster:Start_playCreatSpine_SGBox(afterCall)

local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,false)end

local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)

self:delayDo(2,function()
widget:SetChildSceneEntityPlayAnimation(0,3434,1,nil)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),1)
widget:SetChildShowEffect(1,0,true)
hud=self:getHud()
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,true)end
widget:SetChildShowEffect(1,0,true)
if afterCall then
afterCall()
end
if afterCall then
afterCall()
end
end)
end
end


function xjEntity_monster:MoZong_playEffect()
local widget=self:getWidget()
if widget then
widget:SetChildActive(6,false)
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small then

local shield=monsterData.shield
local const_def=monsterData:getConstDefCfg()
if const_def and const_def.shield and const_def.shield[1]then
local maxShield=const_def.shield[1]
local _shield=shield/maxShield
local hudunEffect=const_def.hudunEffect or 0
if _shield<=hudunEffect then
widget:SetChildActive(6,true)
widget:SetChildShowEffect(6,20525,true)


end
end
elseif monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then

local shield=monsterData.shield
local const_def=monsterData:getConstDefCfg()
if const_def and const_def.shield and const_def.shield[1]then
local maxShield=const_def.shield[1]
local _shield=shield/maxShield
local hudunEffect=const_def.hudunEffect or 0
if _shield<=hudunEffect then
widget:SetChildActive(6,true)
widget:SetChildShowEffect(6,20526,true)
widget:SetChildLocalPosition(6,Vector3(0,0.2,0))

end
end
end
end
end

function xjEntity_monster:SpeZhenYan_StopEffect()
if self.speZhenYanDefTimer then
self.speZhenYanDefTimer:cancel()
self.speZhenYanDefTimer=nil
else
return
end
local widget=self:getWidget()
if not widget then return end
widget:SetChildSceneEntityRemoveModel(8)
widget:SetChildLocalPosition(8,Vector3.zero)
widget:SetChildActive(7,false)
end

function xjEntity_monster:SpeZhenYan_playEffect()
self:SpeZhenYan_StopEffect()

local widget=self:getWidget()
if not widget then return end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe then
local sTime=monsterData.forbid_atk_sec
if sTime==nil or sTime==0 then
widget:SetChildActive(7,false)
return
end
local cTime=timeHelper.getServerShortTime()
local constDef=monsterData:getConstDefCfg()
local forbid_attack_time=constDef.forbid_attack_time or 0
local left=forbid_attack_time-(cTime-sTime)
local isShow=left>0

if not isShow then
widget:SetChildActive(7,false)
return
end

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)


widget:SetChildSceneEntityCreateModel(8,510612,nil,'Entity',entCfg.sortOrder+1,7,nil,false)
widget:SetChildLocalPosition(8,Vector3.New(0,3,0))

local func=function()
cTime=timeHelper.getServerShortTime()
left=forbid_attack_time-(cTime-sTime)
if left<0 then
self:SpeZhenYan_StopEffect()
end
end
self.speZhenYanDefTimer=timer.new()
self.speZhenYanDefTimer:start(1,func,-1)
func()
end
widget:SetChildActive(7,true)
end

function xjEntity_monster:stop_SpeZhenYan_Move()
local widget=self:getWidget()
if not widget then return end
widget:SetChildSceneEntityRemoveModel(8)
widget:SetChildLocalPosition(8,Vector3.zero)
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData==nil then return end
if not monsterData.isPlayEscape then return end
if self.m_key==nil then return end
self.pos=monsterData:getWorldPos_1()
xianjieController:resetEntityPos(self:getKey(),self.pos)
self:SpeZhenYan_playEffect()
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
end

function xjEntity_monster:SpeZhenYan_Move()
local widget=self:getWidget()
if not widget then return end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData.entitytype~=xjServerEnityType.eMoJieZhenYan_Spe then return end
if not monsterData.isPlayEscape then return end

local sTime=monsterData.forbid_atk_sec
local cTime=timeHelper.getServerShortTime()
local constDef=monsterData:getConstDefCfg()
local forbid_attack_time=constDef.forbid_attack_time or 0
local left=forbid_attack_time-(cTime-sTime)

if left>0 then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(8,510613,nil,'Entity',entCfg.sortOrder+1,7,nil,false)
local callback=function()
if self.m_key==nil then return end
self.pos=monsterData:getWorldPos_1()
xianjieController:resetEntityPos(self:getKey(),self.pos)
self:SpeZhenYan_playEffect()
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
end
widget:SetChildSceneEntityChangeColor(0,Color.clear,1.2,callback)
monsterData.isPlayEscape=false
end
end

function xjEntity_monster:UpdateModel()
local widget=self:getWidget()
if not widget then return end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if monsterData==nil then return end
if not monsterData.isNeedUpdateModel then return end
local cfg=monsterData:getCfg()
if cfg.mutipleModelSet==nil then return end

local body,componets,scale,flip,offset,slotInfo,mount,effect=monsterData:getModelData()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)


monsterData.isNeedUpdateModel=false
end


return xjEntity_monster
