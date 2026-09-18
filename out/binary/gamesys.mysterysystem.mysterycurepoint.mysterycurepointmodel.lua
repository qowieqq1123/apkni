







mysteryCurePointModel=mysteryEntityBase.new(eMysteryEntityType.eCurePoint,{})

mysteryCurePointModel.entityType=eMysteryEntityType.eCurePoint

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject



mysteryCurePointType=
{
once=1,
last=2,
}

function mysteryCurePointModel:get_config(id)
local config=cfg_ssentityhuixieconfig_get(id)
return config
end

function mysteryCurePointModel:get_type(id)
local config=cfg_ssentityhuixieconfig_get(id)
return config and config.hxType
end



function mysteryCurePointModel:init_data()
self.hmStepData={}
end

function mysteryCurePointModel:set_cur_curePoint(entityData)
self.curEntityData=entityData
end

function mysteryCurePointModel:get_cur_curePoint()
return self.curEntityData
end

function mysteryCurePointModel:init_hmStep(entityData)
local config=self:get_config(entityData.id)
if config.hxType==2 then
self.hmStepData[entityData.guid]=0
end
return self.hmStepData[entityData.guid]
end


function mysteryCurePointModel:get_hmStep()
return self.hmStepData
end

function mysteryCurePointModel:is_hmStep_enough(entityData,extraStep)
extraStep=extraStep or self.hmStepData[entityData.guid]
local config=self:get_config(entityData.id)
if config.hxType==2 then
return(extraStep or 0)>=config.hmStep
end
return true
end
