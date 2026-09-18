







mysteryLittleGamePointModel=mysteryEntityBase.new(eMysteryEntityType.eLittleGamePoint,{})

mysteryLittleGamePointModel.entityType=eMysteryEntityType.eLittleGamePoint

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject



function mysteryLittleGamePointModel:get_config(id)
local config=cfg_ssentitysmallgameconfig_get(id)
return config
end



function mysteryLittleGamePointModel:init_data()

end

