









local xjEntity_caravanEscortHub={}


function xjEntity_caravanEscortHub:onInit()
local data=self.data
local hubSceneIdx=data.hubSceneIdx
local hubPosX=data.hubPosX
local hubPosY=data.hubPosY
self.hubType=data.hubType or 1
local hubKey=string.format("%s_%s_%s",hubSceneIdx,hubPosX,hubPosY)
local ceEnterData=xianjieModel:getCaravanEscortHubDataByHubKey(hubKey)
self.pos=ceEnterData:getWorldPos_1()
self.size=ceEnterData:getWorldSize()
local cfg=ceEnterData:getCfg()

self.ent_name=cfg.name
end


function xjEntity_caravanEscortHub:onCreateWidget(widget)

local buildId=xjClientBuildType.flcbCaravanEscortHub
local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildId)
local modelset=bdCfg.clientParam
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
local modelIdList=modelset.model
local modelId=modelIdList[self.hubType]
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)

local boxSizeParam=transformHelper.bodySize(modelId,1)
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.zero
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
local offset=modelset.offset
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end


function xjEntity_caravanEscortHub:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
end



return xjEntity_caravanEscortHub