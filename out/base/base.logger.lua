
local _trace=debug.traceback
local _getinfo=debug.getinfo
local _t_concat=table.concat
local _s_upper=string.upper
local _s_format=string.format
local _huge=math.huge
local _logDebug=tonumber(DEBUG)or 0



local _l_print=print
local _string_upper=string.upper
local _string_format=string.format
local _string_find=string.find
local _table_concat=table.concat
local _print_track=_l_print
local _log_err=Debugger.LogError
local _log_warn=Debugger.LogWarning
local _log_log=Debugger.Log

LOG_FILTER={

}

_sys_log=_l_print

_l_print('_logDebug',_logDebug)
print_stack=_l_print

local _log=_l_print

function logErr(...)
local out={'[ERR]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
out[#out+1]=_trace("",2)
_log_err(_t_concat(out,' '))
end

function logInfo(...)
if _logDebug<2 then return end
local out={'[INFO]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_log_log(_t_concat(out,' '))
end

function logWarn(...)
if _logDebug<1 then return end
local out={'[WARN]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_log_warn(_t_concat(out,' '))
end

function logWarnTrace(...)
if _logDebug<2 then return end
local out={'[TRACE]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
out[#out+1]='\n'
out[#out+1]=_trace("",2)
_log_warn(_t_concat(out,' '))
end

function logTrace(...)
if _logDebug<2 then return end
local out={'[TRACE]'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
out[#out+1]='\n'
out[#out+1]=_trace("",2)
_log(_t_concat(out,' '))
end


print=function(...)
end


printf=function(...)

end

xprint=function(...)

end

print_stack=function(...)

end































function enable_print(flag)
if flag then
print=_l_print
else
print=function()end
end
end

function enable_protocol_data_print(flag)
if flag then
protocol_data_print=_l_print
else
protocol_data_print=function()end
end
end





