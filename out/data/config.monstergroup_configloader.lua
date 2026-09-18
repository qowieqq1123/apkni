
local _monstergroup={}
local _monstergroup_load={}
local _allCfgLoadFlag=false
local _spliter=1000
local _format=string.format

local _loadCfg=function(cfgPath)
if not _monstergroup_load[cfgPath]then
local subTable=require(cfgPath)
for k,v in pairs(subTable)do
_monstergroup[v.id]=v
end
_monstergroup_load[cfgPath]=true
end
end

function cfg_monstergroup_get(k,show_msg)
if _monstergroup[k]==nil then _loadCfg(_format("data/config/monstergroup_%d",math.floor(k/_spliter)))end



return _monstergroup[k]
end

function cfg_monstergroup()
if _allCfgLoadFlag then return _monstergroup end
_allCfgLoadFlag=true
_loadCfg('data/config/monstergroup_0')
_loadCfg('data/config/monstergroup_100')
_loadCfg('data/config/monstergroup_101')
_loadCfg('data/config/monstergroup_102')
_loadCfg('data/config/monstergroup_105')
_loadCfg('data/config/monstergroup_110')
_loadCfg('data/config/monstergroup_111')
_loadCfg('data/config/monstergroup_112')
_loadCfg('data/config/monstergroup_120')
_loadCfg('data/config/monstergroup_121')
_loadCfg('data/config/monstergroup_122')
_loadCfg('data/config/monstergroup_130')
_loadCfg('data/config/monstergroup_131')
_loadCfg('data/config/monstergroup_134')
_loadCfg('data/config/monstergroup_138')
_loadCfg('data/config/monstergroup_140')
_loadCfg('data/config/monstergroup_141')
_loadCfg('data/config/monstergroup_145')
_loadCfg('data/config/monstergroup_150')
_loadCfg('data/config/monstergroup_151')
_loadCfg('data/config/monstergroup_152')
_loadCfg('data/config/monstergroup_153')
_loadCfg('data/config/monstergroup_154')
_loadCfg('data/config/monstergroup_155')
_loadCfg('data/config/monstergroup_160')
_loadCfg('data/config/monstergroup_170')
_loadCfg('data/config/monstergroup_175')
_loadCfg('data/config/monstergroup_180')
_loadCfg('data/config/monstergroup_185')
_loadCfg('data/config/monstergroup_190')
_loadCfg('data/config/monstergroup_194')
_loadCfg('data/config/monstergroup_195')
_loadCfg('data/config/monstergroup_196')
_loadCfg('data/config/monstergroup_200')
_loadCfg('data/config/monstergroup_210')
_loadCfg('data/config/monstergroup_211')
_loadCfg('data/config/monstergroup_220')
_loadCfg('data/config/monstergroup_221')
_loadCfg('data/config/monstergroup_230')
_loadCfg('data/config/monstergroup_240')
_loadCfg('data/config/monstergroup_250')
_loadCfg('data/config/monstergroup_251')
_loadCfg('data/config/monstergroup_260')
_loadCfg('data/config/monstergroup_261')
_loadCfg('data/config/monstergroup_270')
_loadCfg('data/config/monstergroup_271')
_loadCfg('data/config/monstergroup_280')
_loadCfg('data/config/monstergroup_281')
_loadCfg('data/config/monstergroup_290')
_loadCfg('data/config/monstergroup_291')
_loadCfg('data/config/monstergroup_292')
_loadCfg('data/config/monstergroup_295')
_loadCfg('data/config/monstergroup_300')
_loadCfg('data/config/monstergroup_310')
_loadCfg('data/config/monstergroup_320')
_loadCfg('data/config/monstergroup_330')
_loadCfg('data/config/monstergroup_335')
_loadCfg('data/config/monstergroup_340')
_loadCfg('data/config/monstergroup_341')
_loadCfg('data/config/monstergroup_350')
_loadCfg('data/config/monstergroup_400')
_loadCfg('data/config/monstergroup_402')
_loadCfg('data/config/monstergroup_403')
_loadCfg('data/config/monstergroup_404')
_loadCfg('data/config/monstergroup_405')
_loadCfg('data/config/monstergroup_406')
_loadCfg('data/config/monstergroup_407')
_loadCfg('data/config/monstergroup_408')
_loadCfg('data/config/monstergroup_420')
_loadCfg('data/config/monstergroup_430')
_loadCfg('data/config/monstergroup_450')
_loadCfg('data/config/monstergroup_451')
_loadCfg('data/config/monstergroup_500')
_loadCfg('data/config/monstergroup_501')
_loadCfg('data/config/monstergroup_502')
_loadCfg('data/config/monstergroup_503')
_loadCfg('data/config/monstergroup_504')
_loadCfg('data/config/monstergroup_505')
_loadCfg('data/config/monstergroup_510')
_loadCfg('data/config/monstergroup_520')
_loadCfg('data/config/monstergroup_525')
_loadCfg('data/config/monstergroup_530')
_loadCfg('data/config/monstergroup_600')
_loadCfg('data/config/monstergroup_610')
_loadCfg('data/config/monstergroup_611')
_loadCfg('data/config/monstergroup_620')
_loadCfg('data/config/monstergroup_630')
return _monstergroup
end

