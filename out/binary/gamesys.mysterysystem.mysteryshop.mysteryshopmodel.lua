







mysteryShopModel=mysteryEntityBase.new(eMysteryEntityType.eShop,{})

mysteryShopModel.entityType=eMysteryEntityType.eShop

local _HexMapManager=CS.HexagonMapManagerInterface
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject



function mysteryShopModel:get_config(id)
local config=cfg_ssentitytraderconfig_get(id)
return config
end

function mysteryShopModel.get_tips_config()
local cfg=cfg_ssentitytradertipsconfig()
local index=math.random(1,#cfg)
return cfg[index]and cfg[index].text
end


function mysteryShopModel:init_data()
end

