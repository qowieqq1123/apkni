







mysteryYaranzoModel=mysteryEntityBase.new(eMysteryEntityType.eYaranzo,mysteryEntityBase)

mysteryYaranzoModel.entityType=eMysteryEntityType.eYaranzo




function mysteryYaranzoModel:get_config(id)
local config=cfgHelper.get(cfg_ssentitybaoxiangguaiconfig_get,id)
return config
end



function mysteryYaranzoModel:init_data()

end

