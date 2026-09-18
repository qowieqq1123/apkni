







mysteryRelivePointModel=mysteryEntityBase.new(eMysteryEntityType.eRelivePoint,{})

mysteryRelivePointModel.entityType=eMysteryEntityType.eRelivePoint

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject



function mysteryRelivePointModel:get_config(id)
local config=cfg_ssentityreliveconfig_get(id)
return config
end



function mysteryRelivePointModel:init_data()
end

