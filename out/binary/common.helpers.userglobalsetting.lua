






userGlobalSetting={}
local config={}

function userGlobalSetting.init()
local e,s=pcall(function()config=jsonHelper.readFile('userDefault.json',{})end)
if not e then

config={}
end
end

function userGlobalSetting.get(key,defaultValue)
local v=config[key]
if v==nil then
return defaultValue
end
return v
end

function userGlobalSetting.set(key,value)
config[key]=value;
end


function userGlobalSetting.record(key,value,defaultValue)
local restoreValue=config[key]
if restoreValue==nil then
restoreValue=defaultValue
end
if restoreValue~=value then
config[key]=value
userGlobalSetting.flush()
end
end

function userGlobalSetting.flush()
jsonHelper.writeFile('userDefault.json',config)
end
