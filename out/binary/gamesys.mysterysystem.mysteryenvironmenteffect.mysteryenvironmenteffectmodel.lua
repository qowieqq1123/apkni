







mysteryEnvironmentEffectModel={}


mysteryEnvironmentEffectModel.data={}

local _register_list={}

function mysteryEnvironmentEffectModel.getConfigById(ruleId)
return cfgHelper.getSSlawRule(ruleId)
end

function mysteryEnvironmentEffectModel.getRuleDesc(ruleId,level)
local ruleCfg=mysteryEnvironmentEffectModel.getConfigById(ruleId)
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
return desc
end

function mysteryEnvironmentEffectModel.getRuleIcon(ruleId)
return cfgHelper.getSSlawRule(ruleId,'image')
end




function mysteryEnvironmentEffectModel:init_data()
self.data={}
end

function mysteryEnvironmentEffectModel:set_environment(data)
local list={}
for i,v in ipairs(data)do
list[v]=i
end
self.data.environment=list
self.data.environmentList=data
end

function mysteryEnvironmentEffectModel:get_environment()
return self.data.environment or{}
end

function mysteryEnvironmentEffectModel:get_environmentList()
return self.data.environmentList or{}
end

function mysteryEnvironmentEffectModel.bindClass(class)
local environmentEffectType=class.environmentEffectType

if _register_list[environmentEffectType]then return end
_register_list[environmentEffectType]=class
end

function mysteryEnvironmentEffectModel.getClass(environmentEffectType)
return _register_list[environmentEffectType]
end




function mysteryEnvironmentEffectModel.haveType(environmentEffectType,ruleList)
local config=nil
for i,v in ipairs(ruleList)do
config=mysteryEnvironmentEffectModel.getConfigById(v.param_1)
if config then
if config.envType and config.envType==environmentEffectType then
return true
end
end
end
end
