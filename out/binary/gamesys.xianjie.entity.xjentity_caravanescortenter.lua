









local xjEntity_caravanEscortEnter={}


function xjEntity_caravanEscortEnter:onInit()
local data=self.data
local ceEnterData=xianjieModel:getCaravanEscortEnterData()
self.pos=ceEnterData:getWorldPos_1()
self.size=ceEnterData:getWorldSize()
local cfg=ceEnterData:getCfg()

self.ent_name=cfg.name
self.xjicontype=501
end


function xjEntity_caravanEscortEnter:onCreateWidget(widget)

local buildId=xjClientBuildType.flcbCaravanEscortEnter
local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildId)
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


function xjEntity_caravanEscortEnter:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_caravanEscortEnter:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


function xjEntity_caravanEscortEnter:onMyClick(boxParams)







UIFullXJCaravanEscortController:showMainWindow()
end



return xjEntity_caravanEscortEnter