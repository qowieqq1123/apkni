









local xjEntity_MoGong={}


function xjEntity_MoGong:onInit()
local data=self.data
self.arenaId=data[1]
local arenaData=xianjieModel:getMoGongDataByMoGongId(self.arenaId)
self.pos=arenaData:getWorldPos_1()
self.size=arenaData:getWorldSize()
local cfg=arenaData:getCfg()


self.ent_name=cfg.name
self.xjicontype=1501

self.data.arenaId=self.arenaId
end


function xjEntity_MoGong:onCreateWidget(widget)

local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.arenaId)
local modelset=bdCfg.clientParam
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,510479,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)

local boxSizeParam=transformHelper.bodySize(modelset.model,1)
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.zero
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
local offset=modelset.offset
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end


function xjEntity_MoGong:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_MoGong:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


function xjEntity_MoGong:onMyClick(boxParams)
xianjieController:openMGZDMoGongInfoWin(self.arenaId)
end



return xjEntity_MoGong