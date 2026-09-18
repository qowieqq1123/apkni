





spriteAnimationsHelper={}
local writablePath=CS.GamePath.writablePath

local conf=nil

function spriteAnimationsHelper.has(name)
if conf==nil then
conf={}
local spriteanimationsconfig=require("data/config/spriteanimationsconfig")
for i,v in ipairs(spriteanimationsconfig)do
conf[v]=true
end
end
return conf[name]~=nil
end