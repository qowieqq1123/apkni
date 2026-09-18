appConfigHelper={}

local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool

local _appConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _appConfig_SetInt=CS.AppDataModel.SetAppConfigJsonKey

local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _appConfig_SetString=CS.AppDataModel.SetAppConfigJsonStringValue

local _keyValue={}

function appConfigHelper.getBool(key,default,force)
local curValue=_keyValue[key]
if curValue==nil or force==true then
curValue=_appConfig_GetBool(key,default or false)
_keyValue[key]=curValue
end
return curValue
end

function appConfigHelper.getInt(key,default,force)
local curValue=_keyValue[key]
if curValue==nil or force==true then
curValue=_appConfig_GetInt(key,default or-1)
_keyValue[key]=curValue
end
return curValue
end

function appConfigHelper.getString(key,default,force)
local curValue=_keyValue[key]
if curValue==nil or force==true then
curValue=_appConfig_GetString(key,default or'')
_keyValue[key]=curValue
end
return curValue
end


function appConfigHelper.setInt(key,value,force)
local curValue=_keyValue[key]
if value~=curValue or force==true then
_appConfig_SetInt(key,value)
_keyValue[key]=value
end
end

function appConfigHelper.setString(key,value,force)
local curValue=_keyValue[key]
if value~=curValue or force==true then
_appConfig_SetString(key,value)
_keyValue[key]=value
end
end