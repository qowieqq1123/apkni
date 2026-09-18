local _handleLoaded={}
local _stageLoaded={}

function seasonModel:getHandleClass(id)
local handleName=cfgHelper.get2(cfg_crossseasonconfig_get,id,"cSeasonHandle")
local class=_handleLoaded[handleName]
if not class then
local path=FMT.fmt("lua.gameSys.seasonSystem.handle.{0}",handleName)
class=require(path)
_handleLoaded[handleName]=class
end
return class
end

function seasonModel:getStageClass(chapterType)
local handleName=cfgHelper.get2(cfg_crossseasonchaptertypeconfig_get,chapterType,"cSeasonStage")
local class=_stageLoaded[handleName]
if not class then
local path=FMT.fmt("lua.gameSys.seasonSystem.stage.{0}",handleName)
class=require(path)
_stageLoaded[handleName]=class
end
return class
end