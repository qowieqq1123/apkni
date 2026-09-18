




local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
loggerUtil={}

local _log=Debugger.Log
local _warn=Debugger.LogWarning
local _t_concat=table.concat

local _logInfo=function(...)
local out={'[testLog]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_log(_t_concat(out,' '))
end

local _logWarn=function(...)
local out={'[testWarnLog]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_warn(_t_concat(out,' '))
end



function loggerUtil.logErrFMT(content,...)
logErr(FMT.fmt(content,...))
end


function loggerUtil.logFMT(content,...)
if loggerUtil.isEnable()then
_logInfo(FMT.fmt(content,...))
end
end


function loggerUtil.logWarnFMT(content,...)
if loggerUtil.isEnable()then
_logWarn(FMT.fmt(content,...))
end
end


function loggerUtil.debugErrFMT(content,...)
if loggerUtil.isEnable()then
logErr(FMT.fmt(content,...))
end
end


function loggerUtil.log(...)
if loggerUtil.isEnable()then
_logInfo(...)
end
end


function loggerUtil.warn(...)
if loggerUtil.isEnable()then
_logWarn(...)
end
end


function loggerUtil.isEnable()
return deviceHelper.isRunNoneOrEditor()or appUtils.enableDebug or false
end

function loggerUtil:printFMT(tag,content,...)

end
