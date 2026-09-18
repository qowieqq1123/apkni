






local _MODULENAME="xiantuchengjiuModel"


def_table(_MODULENAME)
xiantuchengjiuModel.name=_MODULENAME






xiantuchengjiuModel.data={}



xiantuchengjiuModel.subopen={}

local _checkOpen={
[eXianTuChengJiuTabType.ZongMenXianTu]=function(key)
return xiantuchengjiuModel:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,key)~=nil
end,
[eXianTuChengJiuTabType.XianTuChengJiu]=function(key)
local cfg=cfgHelper.get1(cfg_xiantuachieveconfig_get,key)
if cfg.unlock then
return xiantuchengjiuModel:checkConditions(cfg.unlock)
end
return true
end,
[eXianTuChengJiuTabType.FeiShengDaoTu]=function(key)
local current=xiantuchengjiuModel:getFSDTCurrent()
return current>=key
end,
}


function xiantuchengjiuModel:onAppStart()

end


function xiantuchengjiuModel:onEnterState(isReconnect)
self:loadAnimationRecord()
self:resetTaskData()
self:loadMarkRepeated()
end


function xiantuchengjiuModel:onLeaveState(isReconnect)

self.data={}
self:cleanTaskTips()
end

function xiantuchengjiuModel:onProtocolReq()
self:initTaskData()
self:initSubOpen()
end


function xiantuchengjiuModel:updateZMXTDataList(list)
local data={}
local type=eXianTuChengJiuTabType.ZongMenXianTu
local pass={}
list=list or{}
local animation={}
for i,v in ipairs(list)do
local discipleData={
name=v.disciplename,
data=v.discipledata,
image=v.discipleimage,
}
local temp={
key=v.key1,
opensec=v.opensec,
times=v.times,
disciple=discipleData,
}
data[v.key1]=temp
animation[tostring(v.key1)]=true
if v.len>0 then
for j,w in ipairs(v.list)do
local check,p=self:updateTaskData(type,v.key1,w.param_1,w.param_3,w.param_2)
if p then
table.insert(pass,{type,v.key1,w.param_1,p})
end
end
end
end
self.data[type]=data
self:checkAnimationReset(animation)
return pass
end

function xiantuchengjiuModel:updateZMXTSingleData(v)
local eType=eXianTuChengJiuTabType.ZongMenXianTu
table.checkCreateSubTable(self.data,{eType})

local pass={}

local discipleData={
name=v.disciplename,
data=v.discipledata,
image=v.discipleimage,
}
local temp={
key=v.key1,
opensec=v.opensec,
times=v.times,
disciple=discipleData,
}
self.data[eType][v.key1]=temp

if v.len>0 then
for j,w in ipairs(v.list)do
local check,p=self:updateTaskData(eType,v.key1,w.param_1,w.param_3,w.param_2)
if p then
table.insert(pass,{eType,v.key1,w.param_1,p})
end
end
end

return pass
end

function xiantuchengjiuModel:updateXTCJDataList(list)
local data={}
local eType=eXianTuChengJiuTabType.XianTuChengJiu
local pass={}
list=list or{}
for i,v in ipairs(list)do
local temp={
key=v.key1,

}
data[v.key1]=temp

if v.len>0 then
for j,w in ipairs(v.list)do
local check,p=self:updateTaskData(eType,v.key1,w.param_1,w.param_3,w.param_2)
if p then
table.insert(pass,{eType,v.key1,w.param_1,p})
end
end
end
end
self.data[eType]=data
return pass
end

function xiantuchengjiuModel:updateFSDTDataList(list)
local data={}
local eType=eXianTuChengJiuTabType.FeiShengDaoTu
local pass={}
list=list or{}
for i,v in ipairs(list)do
local temp={
key=v.key1,
}
data[v.key1]=temp

if v.len>0 then
for j,w in ipairs(v.list)do
local check,p=self:updateTaskData(eType,v.key1,w.param_1,w.param_3,w.param_2)
if p then
table.insert(pass,{eType,v.key1,w.param_1,p})
end
end
end
end
self.data[eType]=data
return pass
end

function xiantuchengjiuModel:updateFSDTSingleData(v)
local eType=eXianTuChengJiuTabType.FeiShengDaoTu
table.checkCreateSubTable(self.data,{eType})
local pass={}
local temp={
key=v.key1,
}
self.data[eType][v.key1]=temp

if v.len>0 then
for j,w in ipairs(v.list)do
local check,p=self:updateTaskData(eType,v.key1,w.param_1,w.param_3,w.param_2)
if p then
table.insert(pass,{eType,v.key1,w.param_1,p})
end
end
end

return pass
end








function xiantuchengjiuModel:updateZMXTTimes(eKey,times)
local data=self:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,eKey)
if data then
data.times=times
end
end

function xiantuchengjiuModel:getTabData(eType)
return self.data[eType]
end

function xiantuchengjiuModel:getInfoData(eType,eKey)
local data=self:getTabData(eType)
if data then
return data[eKey]
end
end

function xiantuchengjiuModel:getZMXTTimes(key)
local data=self:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,key)
if data then
return data.times
end
end








function xiantuchengjiuModel:getFSDTCurrent()
local lookup=cfg_lookupfeishengdaotuconfig()
local eType=eXianTuChengJiuTabType.FeiShengDaoTu
for i,v in ipairs(lookup)do
local key=v[1]
if self:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,key)then
local cfg=xiantuchengjiuModel:getTaskConfig(eType,key)
for j,w in pairs(cfg)do
local over=self:isTaskOver(eType,key,j)
if not over then
return key
end
end
else
return lookup[i-1]and lookup[i-1][1]or 0
end
end
return lookup[#lookup][1]
end

function xiantuchengjiuModel:checkOpen(eType,eKey)
return _checkOpen[eType](eKey)
end

function xiantuchengjiuModel:initSubOpen()
self.subopen={}
local cfg=cfg_xiantuachieveconfig()
for i,v in pairs(cfg)do
if v.unlock then
for j,w in ipairs(v.unlock)do
if not self:checkCondition(w)then
local type=w[1]
table.checkCreateSubTable(self.subopen,{i,type})
self.subopen[i][type]=j
end
end
end
end
end

function xiantuchengjiuModel:triggerSubOpens(oType)
local list={}
for tab,temp1 in pairs(self.subopen)do
local index=temp1[oType]
if index then
local cfg=cfgHelper.get1(cfg_xiantuachieveconfig_get,tab)
if self:checkCondition(cfg.unlock[index])then
temp1[oType]=nil
end
if not next(temp1)then
table.insert(list,tab)
end
end
end
return list
end

function xiantuchengjiuModel:getZMXTOpen()
local lookup=cfg_lookupsectxiantuconfig()
for i,v in ipairs(lookup)do
local key1=v[1]
local lastKey=lookup[i-1]and lookup[i-1][1]or nil
if lastKey and self:checkZMXTOpen(lastKey,key1)then
return key1
end
end
end

function xiantuchengjiuModel:getZMXTOpens()
local lookup=cfg_lookupsectxiantuconfig()
local keys={}
for i,v in ipairs(lookup)do
local key1=v[1]
local lastKey=lookup[i-1]and lookup[i-1][1]or nil
if lastKey then
if self:checkZMXTOpen(lastKey,key1)then
table.insert(keys,key1)
end
else
local eType=eXianTuChengJiuTabType.ZongMenXianTu
if not self:checkOpen(eType,key1)and UIDiscipleModel:getDiscipleJJCount(key1)>0 then
table.insert(keys,key1)
end
end
end
return keys
end

function xiantuchengjiuModel:checkZMXTOpen(currKey,nextKey)
if currKey and nextKey then
local eType=eXianTuChengJiuTabType.ZongMenXianTu
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,nextKey)
if cfg and not cfg.hideStageAnim and not self:checkOpen(eType,nextKey)and UIDiscipleModel:getDiscipleJJCount(nextKey)>0 then
local tasksCfg=xiantuchengjiuModel:getTaskConfig(eType,currKey)
local allOver=true
for key2,taskCfg in pairs(tasksCfg)do
if not self:isTaskOver(eType,currKey,key2)then
allOver=false
break
end
end
if allOver then
return true
end
end
end
return false
end


