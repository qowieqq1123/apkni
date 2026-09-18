








dzSpecialityEffectHelper={}



function dzSpecialityEffectHelper.getAllEffectSpeList(netData,funcs,effect_name)
local effectlist={}
local speciallist=UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
if speciallist~=nil and#speciallist>0 then
for i1,data in ipairs(speciallist)do
local speType=data[1]
local spe=data[2]
local cfg=UIDiscipleModel:getSpecialityConfigCommon(netData,speType,spe)
if cfg~=nil and cfg[effect_name]~=nil then
local effects=cfg[effect_name]
for i2,v2 in ipairs(effects)do
local efflist=v2[1]
local conditionlist=v2[2]
local fit=true
if conditionlist then
for i3,v4 in ipairs(conditionlist)do
local condType=v4[1]
local condFunc=funcs[condType]
if condFunc then
local cond=condFunc.cond
if not cond(netData,v4)then
fit=false
break
end
else
fit=false




break
end
end
end
if fit then
for i5,v6 in ipairs(efflist)do
table.insert(effectlist,{v6,data})
end
end
end
end
end
end
return effectlist
end


function dzSpecialityEffectHelper.getEffectSpeList(netData,effectType,funcs,effect_name)
local growlist={}
local effectlist=dzSpecialityEffectHelper.getAllEffectSpeList(netData,funcs,effect_name)
for i,v in ipairs(effectlist)do
if v[1][1]==effectType then
table.insert(growlist,v[2])
end
end
return growlist
end
