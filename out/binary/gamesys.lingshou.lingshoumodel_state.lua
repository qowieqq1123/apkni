






eLingShouStateType=
{
petFree=-1,
petBuild=0,
petBorn=1,
petEquip=2,
petBuildMix=3,
}

function lingshouModel:onStateChange(lsGuid,oldState,newState)
if oldState==newState then return end

local cfgs=cfg_petstateconfig()
for i,v in pairs(cfgs)do
local stateType=v.id
local o=mathHelper.getBitValue(oldState,stateType)
local c=mathHelper.getBitValue(newState,stateType)
if o~=c then
notifySystem:postNotify(notifyConfig.onLingShouStateChange,lsGuid,stateType,o,c)
end
end
end

function lingshouModel:getStateName(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
local stateType=self.getHighestStateTypeEx(lsData.pet_state)
return self:getStateNameEx(stateType)
end
end

function lingshouModel:getStateNameEx(stateType)

if type(stateType)~="nil"and stateType>=0 then
local cfg=cfgHelper.get1(cfg_petstateconfig_get,stateType)
return cfg.name
else
return"空闲中"
end
end

function lingshouModel:getStateDesc(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self:getStateDescEx(lsData.pet_state)
end
end

function lingshouModel:getStateDescEx(state)
local max=self.getHighestStateTypeEx(state)
if max>=0 then
local cfg=cfgHelper.get1(cfg_petstateconfig_get,max)
return cfg.desc
end
end

function lingshouModel:getHighestStateType(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self.getHighestStateTypeEx(lsData.pet_state)
end
end

function lingshouModel.getHighestStateTypeEx(state)
local cfgs=cfg_petstateconfig()
local max=nil
for k,v in pairs(cfgs)do
local stateType=v.id
if mathHelper.getBitValue(state,stateType)then
if not max then
max=v
elseif v.priority_weight>max.priority_weight then
max=v
elseif v.priority_weight==max.priority_weight and v.id<max.id then
max=v
end
end
end
if max then
return max.id
else
return eLingShouStateType.petFree
end
end

function lingshouModel:checkStateExist(lsGuid,stateType)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self.checkStateExistEx(lsData.pet_state,stateType)
end
end

function lingshouModel.checkStateExistEx(state,stateType)
return mathHelper.getBitValue(state,stateType)
end

function lingshouModel.checkStateExistEx2(lsData,stateType)
return mathHelper.getBitValue(lsData.pet_state,stateType)
end

function lingshouModel:isIdleState(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self.isEmptyStateEx(lsData.pet_state)
end
end

function lingshouModel.isIdleStateEx(state)
return state==0
end

function lingshouModel:canStateChange(lsGuid,stateType)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self:canStateChangeEx(lsData.pet_state,stateType)
end
end

function lingshouModel:canStateChangeEx(cState,tStateType)
local tCfg=cfgHelper.get1(cfg_petstateconfig_get,tStateType)
if tCfg.conflicts then
for i,v in ipairs(tCfg.conflicts)do
if self.checkStateExistEx(cState,v)then
return false
end
end
end
return true
end

function lingshouModel:findDatas_ByExistStateType(stateType)
local list={}
local datas=self:getLingShouDatas()

for i,v in pairs(datas)do

if self.checkStateExistEx(v.pet_state,stateType)then
table.insert(list,v)
end
end
return list
end


function lingshouModel:getStatePosStr(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self:getStatePosStrEx(lsData.pet_state)
end
end

function lingshouModel:getStatePosStrEx(state)
local max=self.getHighestStateTypeEx(state)
if max>=0 then
local cfg=cfgHelper.get1(cfg_petstateconfig_get,max)

local str=FMT.fmt("正在　{0}",cfg.name)
return str
else
return"空闲"
end
end


function lingshouModel:getState(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return lsData.pet_state
end
end