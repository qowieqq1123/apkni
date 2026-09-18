





ClothingTableCheck={}

function ClothingTableCheck.checkJobBody()
local clothingLookup=cfg_lookupdressconfig()
local jobImage=discipleLookup:getJobImageLookup()

local discipleConfig=cfg_discipleconfig()

for i,v in pairs(clothingLookup)do
for _,id in pairs(v)do
local clothingConfig=itemsConfig.getConfig(id)
if clothingConfig then
local type1=clothingConfig.type1
local disciple=clothingConfig.disciple

if not disciple then

if jobImage[type1]then
for sex,sexV in pairs(jobImage[type1])do
local body=sexV[3]

if body then
for _,bodyId in ipairs(body)do
local bodyCfg=cfgHelper.get(cfg_disciplebodyimageconfig_get,bodyId,"clothing_out_side")
if bodyCfg then
if not bodyCfg[id]then
logErr(FMT.fmt("找不到该形象（id:{0})的时装（id:{1}）配置,",bodyId,id))
end
else
logErr(FMT.fmt("找不到该形象{0}的时装{1}配置,",bodyId,id))
end
end
end
end
else
logErr(FMT.fmt("找不到该职业的随机形象库{0}",type1))
end

for _,vv in pairs(discipleConfig)do
if vv.voclib==type1 and vv.imagelib then
local bodyId=vv.imagelib[3]
local bodyCfg=cfgHelper.get(cfg_disciplebodyimageconfig_get,bodyId,"clothing_out_side")
if bodyCfg then
if not bodyCfg[id]then
logErr(FMT.fmt("找不到该形象{0}的时装{1}配置,",bodyId,id))
end
else
logErr(FMT.fmt("找不到该形象{0}的时装{1}配置,",bodyId,id))
end
end
end
else
local disCfg=discipleConfig[disciple]
if disCfg.voclib==type1 and disCfg.imagelib then
local bodyId=disCfg.imagelib[3]
local bodyCfg=cfgHelper.get(cfg_disciplebodyimageconfig_get,bodyId,"clothing_out_side")
if bodyCfg then
if not bodyCfg[id]then
logErr(FMT.fmt("找不到该形象{0}的时装{1}配置,",bodyId,id))
end
else
logErr(FMT.fmt("找不到该形象{0}的时装{1}配置,",bodyId,id))
end
end
end



end
end
end
end