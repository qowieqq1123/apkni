cdnLogHelper={};
local cjson=require'cjson'
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool;
local GamePath=CS.GamePath.writablePath


function cdnLogHelper:log(str)

local isLog=_AppConfig_GetBool('isLogCDNFile',false);
if isLog==false then
return;
end
if deviceHelper.isRunWebGL()then
local path=_WXInterface.USER_DATA_PATH..'/cdnjson_'..os.date("%Y%m%d_%H%m%S")..'.json';
_WXInterface.WriteFileSync(path,str)
else
local path=GamePath..'cdnjson_'..os.date("%Y%m%d_%H%m%S")..'.json';
local fp=io.open(path,'w+b');
fp:write(str);
io.close(fp);
end
end
