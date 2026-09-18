ClothingConfig={}

local _colorBgName={
[eQualityColor.ePurple]='image_daobingpz_01',
[eQualityColor.eOrange]='image_daobingpz_02',
[eQualityColor.eRed]='image_daobingpz_03',
}




function ClothingConfig.getCommonConfig()
return cfg_discipledressconfig_get(1)
end



function ClothingConfig.getCostBenTiNum(starlv)
local consume=ClothingConfig.getCommonConfig().consume
return consume[starlv]or 0
end


function ClothingConfig.getStarMaxLv(itemid)
if not itemsConfig.isClothing(itemid)then
return
end
local itemsCfg=itemsConfig.getConfig(itemid)
return itemsCfg and#(itemsCfg.star)or 5
end

function ClothingConfig.isStarMaxLv(itemid,starlv)
local maxlv=ClothingConfig.getStarMaxLv(itemid)
return starlv>=maxlv
end


function ClothingConfig.getColorBg(color)
return _colorBgName[color]
end


function ClothingConfig.getModelArgs(itemid,star,diziguid,switchidx)
if diziguid then
local modelInfo=UIDiscipleModel:getDiscipleOutsideModelInfo(diziguid,nil,nil,{clothingStar=star},switchidx)
return{model=modelInfo.body,component=modelInfo.componets}
else
star=star or 0
if ClothingConfig.isStarMaxLv(itemid,star)then
return itemsConfig.getConfig(itemid).model[2]
else
return itemsConfig.getConfig(itemid).model[1]
end
end

end