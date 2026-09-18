









local xjEntity_arena={}


function xjEntity_arena:onInit()
local data=self.data
self.arenaId=data[1]
local arenaData=xianjieModel:getArenaDataByArenaId(self.arenaId)
self.pos=arenaData:getWorldPos_1()
self.size=arenaData:getWorldSize()
local cfg=arenaData:getCfg()

self.ent_name=cfg.name
self.xjicontype=501
end


function xjEntity_arena:onCreateWidget(widget)

local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.arenaId)
local modelset=bdCfg.clientParam
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,modelset.model,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)

local boxSizeParam=transformHelper.bodySize(modelset.model,1)
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.zero
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
local offset=modelset.offset
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end


function xjEntity_arena:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_arena:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


function xjEntity_arena:onMyClick(boxParams)



local arenaId=self.arenaId
xianjieController:openArenaInfoWin(arenaId)
end



return xjEntity_arena