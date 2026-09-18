
gmHelper={}
local config=nil

local _filepath=fileHelper.getFullPath('gm.json')
function gmHelper.initGM()
if deviceHelper.isRunEditor()then
local path=CS.GamePath.writablePath
path=string.gsub(path,'LocalFile','')
path=path..'Assets/Editor/gm.json'
_filepath=path
end

if deviceHelper.isRunWebGL()then
local path=CS.GamePath.streamingAssetsPath..'/'..'gm.json'
local cb=function(message,err)
if err==nil or err==''then
config=jsonHelper.decode_josn(message,{})
else
config={}
end
end
CS.ResourceHelper.HttpGetRequest(path,cb)
return
end

local e,s=pcall(function()config=jsonHelper.readPath(_filepath,{})end)
if not e then
config={}

end
end

if appUtils.enableDebug or deviceHelper.isRunEditor()then
gmHelper.initGM()
end

function gmHelper.getConfig()
if deviceHelper.isRunWebGL()and not config then
gmHelper.initGM()
return{}
end
if config.CommandGroupArray then
return config.CommandGroupArray.CommandGroup
end
end


