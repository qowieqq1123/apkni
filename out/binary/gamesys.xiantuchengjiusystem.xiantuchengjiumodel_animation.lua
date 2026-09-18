xiantuchengjiuModel.animation={}

local _clientAnimationKey="ZongMenXianTuAnimation"
local correct={}

function xiantuchengjiuModel:loadAnimationRecord()
self.animation=userActorSetting.get(_clientAnimationKey,{})
end

function xiantuchengjiuModel:saveAnimationRecord()
userActorSetting.set(_clientAnimationKey,self.animation)
userActorSetting.flush()
end

function xiantuchengjiuModel:markAnimationRecord(id)
local cfg=cfg_sectxiantuconfig()
for i,v in pairs(cfg)do
if i<=id then
self.animation[tostring(i)]=true
end
end

self:saveAnimationRecord()
end

function xiantuchengjiuModel:getAnimationRecord(id)
return self.animation[tostring(id)]or false
end

function xiantuchengjiuModel:checkAnimationReset(lookup)
table.clear(correct)
for i,v in pairs(self.animation)do
if not lookup[i]then
table.insert(correct,i)
end
end
for i,v in ipairs(correct)do
self.animation[v]=nil
end
if#correct>0 then
self:saveAnimationRecord()
end
end