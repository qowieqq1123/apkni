tiandaoshuConfig={}

local _VocConfigs

function tiandaoshuConfig:initVocConfig()
_VocConfigs={}
local cfg=cfg_tiandaoshuconfig()
for voc,vocCfg in pairs(cfg)do
local tempStr1=FMT.fmt("cfg_{0}",vocCfg.configname)
local tempFunc1=_G[tempStr1]
local tempStr2=FMT.fmt("cfg_{0}_get",vocCfg.configname)
local tempFunc2=_G[tempStr2]
if tempFunc1 and tempFunc2 then
_VocConfigs[voc]={tempFunc1,tempFunc2}
else
loggerUtil.logErrFMT("缺失天道树职业配置, 职业id：",voc)
end
end
end

function tiandaoshuConfig:checkVocConfig(voc)
return _VocConfigs[voc]~=nil
end

function tiandaoshuConfig:getVocConfig(voc)
return self:getVocConfigImp(voc)
end

function tiandaoshuConfig:getStageConfig(voc,stage)
return self:getVocConfigImp(voc,stage)
end

function tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
return self:getVocConfigImp(voc,stage,fruit)
end

function tiandaoshuConfig:getVocConfigImp(voc,...)
local vocCfgData=_VocConfigs[voc]
if vocCfgData~=nil then
local params={...}
if#params>0 then
return cfgHelper.get(vocCfgData[2],...)
else
return vocCfgData[1]()
end

else
loggerUtil.logErrFMT("不存在天道树职业配置, 职业id：",voc)
end
end

function tiandaoshuConfig:getConfig(...)
local params={...}
if#params>0 then
return cfgHelper.get(cfg_tiandaoshuconfig_get,...)
else
return cfg_tiandaoshuconfig()
end
end

function tiandaoshuConfig:getBaseConfig(...)
return cfgHelper.get(cfg_tiandaoshubaseconfig_get,1,...)
end

function tiandaoshuConfig:getResetMaxCount()
local reset=tiandaoshuConfig:getBaseConfig('reset')
local consumeList=reset[1]or{}
return#consumeList
end