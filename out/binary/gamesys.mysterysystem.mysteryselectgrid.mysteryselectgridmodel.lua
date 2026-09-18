







mysterySelectGridModel=mysteryEntityBase.new(eMysteryEntityType.eSelectGrid,{})

mysterySelectGridModel.entityType=eMysteryEntityType.eSelectGrid


function mysterySelectGridModel:get_config(id)
local config=cfgHelper.get(cfg_ssentitychoiceconfig_get,id)
return config
end



function mysterySelectGridModel:init_data()

end



