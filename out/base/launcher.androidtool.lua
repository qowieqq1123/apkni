
androidTool={}

local _toolClassName='com.wulin.zushi.ToolActivity'
local _proxy=CS.AndroidSDKProxy
local _execCmd=_proxy.ExecCmd
local _call=_proxy.Call
local _setCallbacks=_proxy.SetCallbacks
local _debugLog=Debugger.Log
local _tConcat=table.concat
local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool

local _print=function(...)
local printSDK=_appConfig_GetBool('printSDK',false)
if not printSDK then return end
local out={'[printSDK]：'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_debugLog(_tConcat(out,' '))
end


function androidTool.setCallbacks(callback)
_setCallbacks(callback)
end



function androidTool.callFunc(funcName,args)
args=args or''
_print('callFunc:',funcName,args)
return _execCmd(funcName,args)
end


function androidTool.callStaticFunc(funcName,args)
args=args or''
_print('callStaticFunc:',funcName,args)
return _call('Execute',_toolClassName,funcName,args)
end


function androidTool.getStaticField(fieldName,args)
args=args or''
_print('getStaticField:',fieldName,args)
return _call('ReadStaticField',_toolClassName,fieldName,args)
end