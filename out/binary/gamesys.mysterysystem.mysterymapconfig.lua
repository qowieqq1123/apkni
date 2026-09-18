




mysteryMapConfig={}

local _mysteryMapConfig=nil

function mysteryMapConfig.get_mystery_map_config(mapName)
if _mysteryMapConfig==nil then
_mysteryMapConfig={}
end
if not _mysteryMapConfig[mapName]then
_mysteryMapConfig[mapName]=require(FMT.fmt("mjmap/map/{0}",mapName))
end
return _mysteryMapConfig[mapName]
end

local _mysteryTemplateConfig=nil

function mysteryMapConfig.get_mystery_template_config(templateName)
if _mysteryTemplateConfig==nil then
_mysteryTemplateConfig={}
end
if not _mysteryTemplateConfig[templateName]then
_mysteryTemplateConfig[templateName]=require(FMT.fmt("config/mjmap/templateLua/{0}",templateName))
end
return _mysteryTemplateConfig[templateName]
end