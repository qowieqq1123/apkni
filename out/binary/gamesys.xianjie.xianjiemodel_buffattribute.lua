function xianjieModel:clearData_attribute()
self.totalBuffAttributes=nil
self.buffAttributeLookup=nil

self.sceneBuffAttributes=nil
end





function xianjieModel:addBuffAttribute(buffid)
if self.totalBuffAttributes==nil then self.totalBuffAttributes={}end
if self.buffAttributeLookup==nil then self.buffAttributeLookup={}end
if self.sceneBuffAttributes==nil then self.sceneBuffAttributes={}end

local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local effects=buffCfg.effects
if self.buffAttributeLookup[buffid]then return end
self.buffAttributeLookup[buffid]=true
if buffCfg.scene and next(buffCfg.scene)~=nil then
for sceneIdx,v in pairs(buffCfg.scene)do
if self.sceneBuffAttributes[sceneIdx]==nil then self.sceneBuffAttributes[sceneIdx]={}end

for _,v in ipairs(effects)do
local attrtype=v[1]
if xianjieModel:CheckBuffAttribute(attrtype)then
local attrid=v[2]
local value=v[3]
if not self.sceneBuffAttributes[sceneIdx][attrtype]then
self.sceneBuffAttributes[sceneIdx][attrtype]={}
end
local old=self.sceneBuffAttributes[sceneIdx][attrtype][attrid]or 0
self.sceneBuffAttributes[sceneIdx][attrtype][attrid]=old+value
end
end
end
return
else
for _,v in ipairs(effects)do
local attrtype=v[1]
if xianjieModel:CheckBuffAttribute(attrtype)then
local attrid=v[2]
local value=v[3]
if not self.totalBuffAttributes[attrtype]then
self.totalBuffAttributes[attrtype]={}
end
local old=self.totalBuffAttributes[attrtype][attrid]or 0
self.totalBuffAttributes[attrtype][attrid]=old+value
end
end
end
end

function xianjieModel:removeBuffAttribute(buffid)
if self.buffAttributeLookup==nil then return end
if self.totalBuffAttributes==nil then self.totalBuffAttributes={}end

local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local effects=buffCfg.effects
if not self.buffAttributeLookup[buffid]then return end
self.buffAttributeLookup[buffid]=nil

if buffCfg.scene and next(buffCfg.scene)~=nil then
for sceneIdx,v in pairs(buffCfg.scene)do
if self.sceneBuffAttributes[sceneIdx]==nil then self.sceneBuffAttributes[sceneIdx]={}end

for _,v in ipairs(effects)do
local attrtype=v[1]
if xianjieModel:CheckBuffAttribute(attrtype)then
local attrid=v[2]
local value=v[3]
if not self.sceneBuffAttributes[sceneIdx][attrtype]then
self.sceneBuffAttributes[sceneIdx][attrtype]={}
end
local old=self.sceneBuffAttributes[sceneIdx][attrtype][attrid]or 0
self.sceneBuffAttributes[sceneIdx][attrtype][attrid]=old-value
end
end
end
return
else
for _,v in ipairs(effects)do
local attrtype=v[1]
if xianjieModel:CheckBuffAttribute(attrtype)then
local attrid=v[2]
local value=v[3]
if not self.totalBuffAttributes[attrtype]then
self.totalBuffAttributes[attrtype]={}
end
local old=self.totalBuffAttributes[attrtype][attrid]or 0
self.totalBuffAttributes[attrtype][attrid]=old-value
end
end
end
end

function xianjieModel:getBuffAttribute(attrtype,attrid,sceneIdx)
local totle=0
if self.totalBuffAttributes and self.totalBuffAttributes[attrtype]then
local val=self.totalBuffAttributes[attrtype][attrid]or 0
totle=totle+val
end
if self.sceneBuffAttributes and self.sceneBuffAttributes[sceneIdx]and self.sceneBuffAttributes[sceneIdx][attrtype]then
local val=self.sceneBuffAttributes[sceneIdx][attrtype][attrid]or 0
totle=totle+val
end
return totle





end

function xianjieModel:getBuffTotalAttribute(attrtype)
return self.totalBuffAttributes and self.totalBuffAttributes[attrtype]or nil
end

function xianjieModel:getBuffSceneAttribute(attrtype,sceneIdx)
if not self.sceneBuffAttributes or not self.sceneBuffAttributes[sceneIdx]then
return nil
end
return self.sceneBuffAttributes[sceneIdx][attrtype]
end
