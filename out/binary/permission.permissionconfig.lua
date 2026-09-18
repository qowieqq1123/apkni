




permissionConfig={}

ANDROID_PERMISSION=
{
eVoice={
name={
"android.permission.MODIFY_AUDIO_SETTINGS",
"android.permission.RECORD_AUDIO",
},
requestCode=2,
}

}


function permissionConfig.getVoicePermissions()
if deviceHelper.isRunAndroid()then
return ANDROID_PERMISSION.eVoice.name,ANDROID_PERMISSION.eVoice.requestCode
end
end

function permissionConfig.encode(permissions,code)
if permissions==nil then return end
local data={}
local len=0
for i,v in ipairs(permissions)do
local keyStr=string.format('permission_%d',i)
data[keyStr]=v
len=len+1
end
data.length=len
if code then
data.code=code
end
return jsonHelper.encode(data)
end

function permissionConfig.hasPermission(jsonStr)
local ret=platformHelper:exec('hasPermission',jsonStr)
return tostring(ret)==""
end

function permissionConfig.requestPermission(permissions,code)
if permissions==nil then return true end
local jsonStr=permissionConfig.encode(permissions,code)
local ret=platformHelper:exec('requestPermission',jsonStr)
return tostring(ret)==""
end


function permissionConfig.checkVoicePermissions()
if deviceHelper.isRunAndroid()then
local permissions,code=permissionConfig.getVoicePermissions()
local jsonStr=permissionConfig.encode(permissions)
if jsonStr and not platformSDK:hasPermission(jsonStr)then
platformSDK:requestPermission(jsonStr,code)
return false
end
end
return true
end
