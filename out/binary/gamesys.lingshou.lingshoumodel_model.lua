







function lingshouModel:getLingShouInsideModelInfo(lsGuid,args)
local lsData=lingshouModel:getLingShouData(lsGuid)
local lsId=lsData.id
return lingshouModel:getLingShouInsideModelInfoEx(lsId,args)
end

function lingshouModel:getLingShouInsideModelInfoEx(lsId,args)
local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsId)
if not lsCfg then
logErr(FMT.fmt("找不到灵兽id为{0}对应的配置",lsId))
return
end
local modelParams=lingshouModel.getModelParamsEx(lsCfg.model)
local scale=lsCfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lsCfg.model,true)
end

local offset=lsCfg.modelOffset or{0,-150}
return modelParams,scale,offset
end


function lingshouModel:getLingShouOutsideModelInfo(lsGuid,other)
local lsData=lingshouModel:getLingShouData(lsGuid)
local lsId=lsData.id
return lingshouModel:getLingShouOutsideModelInfoEx(lsId,other)
end

function lingshouModel:getLingShouOutsideModelInfoEx(lsId,scaleType,other)
local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsId)
if not lsCfg then
logErr(FMT.fmt("找不到灵兽id为{0}对应的配置",lsId))
return
end
local modelParams=lingshouModel.getModelParamsEx(lsCfg.model)
local scale=isometricMapSystem:getModelScale(modelParams.body)
local modelex=lsCfg.modelex
return modelParams,scale,modelex
end