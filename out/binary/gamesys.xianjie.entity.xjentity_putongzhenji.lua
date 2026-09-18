









local xjEntity_puTongZhenJi={}


function xjEntity_puTongZhenJi:onInit()
local data=self.data
self.infoguid=data.infoguid
local entityData=xianjieModel:getPuTongZhenJiData(self.infoguid)
self.pos=entityData:getWorldPos_1()
self.size=entityData:getWorldSize()
local cfg=entityData:getCfg()

self.ent_name=cfg.name
self.xjicontype=1701
self.allowClickGrid=true
end


function xjEntity_puTongZhenJi:onCreateWidget(widget)

local entityData=xianjieModel:getPuTongZhenJiData(self.infoguid)
local modelId,offset=entityData:getModelData()
if self.infoModel~=modelId then
self.infoModel=modelId
widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityCreateObject(0,modelId)

local boxSizeParam={4,16}
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.New(0,8)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)

widget:SetChildSceneEntitySetOffset(0,mathHelper.convertArrayToVector(offset))
end
end


function xjEntity_puTongZhenJi:onSelectHandle(widget,isSelect)
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


function xjEntity_puTongZhenJi:onRemoveWidget(widget)

self.infoModel=nil
widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_puTongZhenJi:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


function xjEntity_puTongZhenJi:onMyClick(boxParams)
if self.dead then return end
local infoguid=self.infoguid
xianjieController:openPuTongZhenJiInfoWin(infoguid)
end



return xjEntity_puTongZhenJi