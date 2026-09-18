







mysteryChallengePointModel=mysteryEntityBase.new(eMysteryEntityType.eChallengePoint,{})

mysteryChallengePointModel.entityType=eMysteryEntityType.eChallengePoint

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject



function mysteryChallengePointModel:get_config(id)
local config=cfg_ssentitychallengeconfig_get(id)
return config
end



function mysteryChallengePointModel:init_data()

end

