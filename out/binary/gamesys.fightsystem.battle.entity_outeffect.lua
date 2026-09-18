







local stopEffect=CS.GameInterface.StopEffect

local outEffectFuncLookup={

[eEnityOutEffectType.eTianMing]=function(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local outeffect=cfgHelper.get2(cfg_discipletianmingfloorconfig_get,floor,'outeffect')
return outeffect
end,



}

function entity:activeOutEffect(flag,isRefresh)
if self.outEffectOpen==flag then return end
self.outEffectOpen=flag

if isRefresh then
if flag then
self:rebuildAllOutEffect()
else
self:removeAllOutEffect()
end
end
end

function entity:initOutEffect(baseInfo)
self:removeAllOutEffect()
self.outEffectMark={}
if baseInfo~=nil then

local tmlv=baseInfo.tmlv
if tmlv~=nil and tmlv>0 then
self.outEffectMark[eEnityOutEffectType.eTianMing]={tmlv}
end



end
end

function entity:addOutEffect(outEffectType,...)
if self.outEffectList==nil then return end

self.outEffectMark[outEffectType]={...}
local old=self.outEffectList[outEffectType]
if old~=nil then
stopEffect(old)
end
local func=outEffectFuncLookup[outEffectType]
if func then
local effectid=func(...)
if effectid then
local effectHandle=self:playEffect(effectid,Vector3.zero,true,true)
self.outEffectList[outEffectType]=effectHandle
end
end
end

function entity:removeOutEffect(outEffectType)
if self.outEffectList==nil then return end
local old=self.outEffectList[outEffectType]
if old~=nil then
stopEffect(old)
end
self.outEffectList[outEffectType]=nil
end

function entity:removeAllOutEffect()
if self.outEffectList~=nil then
for k,v in pairs(self.outEffectList)do
stopEffect(v)
end
end
self.outEffectList={}
end

function entity:rebuildAllOutEffect()
self:removeAllOutEffect()
if self.outEffectOpen and self.outEffectMark then
local mark=table.deepCopy(self.outEffectMark)
self.outEffectMark={}
for k,v in pairs(mark)do
self:addOutEffect(k,unpack(v))
end
end
end

function entity:clearAllOutEffect()
self:removeAllOutEffect()
self.outEffectList=nil
self.outEffectMark=nil
self.outEffectOpen=nil
end


function entity:showEntityEffect()
self:activeOutEffect(true,true)
end

function entity:stopEntityEffect()
self:activeOutEffect(false,true)
end