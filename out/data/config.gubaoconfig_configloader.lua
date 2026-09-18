
local _gubaoconfig={}
local _gubaoconfig_load={}
local _allCfgLoadFlag=false
local _spliter=20
local _format=string.format

local _loadCfg=function(cfgPath)
if not _gubaoconfig_load[cfgPath]then
local subTable=require(cfgPath)
for k,v in pairs(subTable)do
_gubaoconfig[v.id]=v
end
_gubaoconfig_load[cfgPath]=true
end
end

function cfg_gubaoconfig_get(k,show_msg)
if _gubaoconfig[k]==nil then _loadCfg(_format("data/config/gubaoconfig_%d",math.floor(k/_spliter)))end



return _gubaoconfig[k]
end

function cfg_gubaoconfig()
if _allCfgLoadFlag then return _gubaoconfig end
_allCfgLoadFlag=true
_loadCfg('data/config/gubaoconfig_0')
_loadCfg('data/config/gubaoconfig_1')
_loadCfg('data/config/gubaoconfig_10')
_loadCfg('data/config/gubaoconfig_11')
_loadCfg('data/config/gubaoconfig_12')
_loadCfg('data/config/gubaoconfig_13')
_loadCfg('data/config/gubaoconfig_14')
_loadCfg('data/config/gubaoconfig_15')
_loadCfg('data/config/gubaoconfig_16')
_loadCfg('data/config/gubaoconfig_17')
_loadCfg('data/config/gubaoconfig_18')
_loadCfg('data/config/gubaoconfig_19')
_loadCfg('data/config/gubaoconfig_2')
_loadCfg('data/config/gubaoconfig_20')
_loadCfg('data/config/gubaoconfig_21')
_loadCfg('data/config/gubaoconfig_22')
_loadCfg('data/config/gubaoconfig_23')
_loadCfg('data/config/gubaoconfig_24')
_loadCfg('data/config/gubaoconfig_25')
_loadCfg('data/config/gubaoconfig_26')
_loadCfg('data/config/gubaoconfig_27')
_loadCfg('data/config/gubaoconfig_28')
_loadCfg('data/config/gubaoconfig_29')
_loadCfg('data/config/gubaoconfig_3')
_loadCfg('data/config/gubaoconfig_30')
_loadCfg('data/config/gubaoconfig_31')
_loadCfg('data/config/gubaoconfig_32')
_loadCfg('data/config/gubaoconfig_4')
_loadCfg('data/config/gubaoconfig_5')
_loadCfg('data/config/gubaoconfig_500')
_loadCfg('data/config/gubaoconfig_6')
_loadCfg('data/config/gubaoconfig_7')
_loadCfg('data/config/gubaoconfig_8')
_loadCfg('data/config/gubaoconfig_9')
return _gubaoconfig
end

