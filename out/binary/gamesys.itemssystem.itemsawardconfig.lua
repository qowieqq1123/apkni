






itemsAwardConfig={}













































local _awardconfig={}
function cfg_awardconfig_get(k,show_msg)
local cfg=_awardconfig[k]
if cfg==nil then
local subCfg=require(FMT.fmt("data/config/awardconfig_{0}",math.floor(k/100)))
if subCfg~=nil then
for i,v in pairs(subCfg)do
_awardconfig[i]=v
end
end
cfg=_awardconfig[k]
end
return cfg
end


function itemsAwardConfig:getAwardInConfigByLevel(rwId,val)
local rcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
if not rcfg then
logErr('无法读取奖励配置，id：',rwId)
return nil
end
if not rcfg.groupInfo then
return rcfg
end
local gcfg=cfgHelper.get1(cfg_awardgroupconfig_get,rcfg.groupInfo[1])
if not gcfg then
logErr('无法读取自适应组配置，id：',rwId)
return nil
end
local tId
for i,v in ipairs(gcfg.groupInfo)do
if val>=v[1]and val<=v[2]then
tId=v[3]
break
end
end
local tcfg=cfgHelper.get1(cfg_awardconfig_get,tId)
if not tcfg then
logErr('无法读取奖励配置，id：',tcfg)
return nil
end
return tcfg
end