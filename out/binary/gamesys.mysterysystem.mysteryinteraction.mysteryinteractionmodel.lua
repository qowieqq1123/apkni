







mysteryInteractionModel=mysteryEntityBase.new(eMysteryEntityType.eInteraction,{})

mysteryInteractionModel.entityType=eMysteryEntityType.eInteraction

function mysteryInteractionModel:get_config(id)
local config=cfg_ssinteractconfig_get(id)
return config
end

function mysteryInteractionModel.get_interaction_config(id)
local config=cfg_ssinteractconfig_get(id)
return config
end



function mysteryInteractionModel:init_data()
end

