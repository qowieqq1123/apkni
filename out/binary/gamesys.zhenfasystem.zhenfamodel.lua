






local _MODULENAME="zhenfaModel"




def_table(_MODULENAME)
zhenfaModel.name=_MODULENAME






zhenfaModel.data={}








zhenfaModel.studying={}
zhenfaModel.isInit=false

local active_cost={}
local sort_order={}

function zhenfaModel:onAppStart()
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
table.insert(sort_order,i)
end
table.sort(sort_order)
end


function zhenfaModel:onEnterState()

end


function zhenfaModel:onLeaveState()

self.data={}
self.studying={}
self.isInit=false
end


function zhenfaModel:onServerDataInitFinish()

end










function zhenfaModel:setStudyingData(ubdId,sfId,zfId,times,accelerate)
local data=self:getStudyingData(ubdId)
if not data then
data={}
self.studying[ubdId]=data
end
data.ubdId=ubdId
data.sfId=sfId
data.zfId=zfId
data.times=times
data.accelerate=accelerate
data.pass=self.calculatePassTime(times)
data.duration=self:calculateZhenFaDuration_Building(zfId,ubdId)
data.running=math.fmod(#times,2)>0

end

function zhenfaModel:accelerateStudyingData(sfId,ubdId,accelerate)
local data=self:getStudyingData(ubdId)
data.accelerate=data.accelerate+accelerate
end




function zhenfaModel:getStudyingData(ubdId)
return self.studying[ubdId]
end

function zhenfaModel:getAllStudying()
return self.studying
end




function zhenfaModel:startStudying(ubdId,sfId,zfId)
local data=self:getStudyingData(ubdId)
if data then
local times={timeHelper.getServerShortTime()}
data.ubdId=ubdId
data.sfId=sfId
data.zfId=zfId
data.times=times
data.accelerate=0
data.pass=self.calculatePassTime(times)
data.duration=self:calculateZhenFaDuration_Building(zfId,ubdId)
data.running=true

else
self:setStudyingData(ubdId,sfId,zfId,{timeHelper.getServerShortTime()},0)
end
end



function zhenfaModel:stopStudying(ubdId)
local data=self:getStudyingData(ubdId)
if data and data.running then





table.insert(data.times,timeHelper.getServerShortTime())
data.running=false
end
end



function zhenfaModel:resumeStudying(ubdId)
local data=self:getStudyingData(ubdId)
if data and not data.running then
table.insert(data.times,timeHelper.getServerShortTime())
data.running=true





end
end



function zhenfaModel:clearStudyingData(ubdId)
self.studying[ubdId]=nil
end




function zhenfaModel:isStartStudying(ubdId)
return self:getStudyingData(ubdId)~=nil
end




function zhenfaModel:isStopStudying(ubdId)
local data=self:getStudyingData(ubdId)
if data then
return data.running

end
return true
end






function zhenfaModel:getLeastTime(ubdId)
local data=self:getStudyingData(ubdId)
if data then
return self.calculateLeastTime(data)
end
end

function zhenfaModel.calculateLeastTime(data)
local nowTime=timeHelper.getServerShortTime()
return(data.duration-data.pass)-(nowTime-data.times[#data.times])-data.accelerate
end

function zhenfaModel:refreshStudyingDuration_Building(ubdId)
local data=self:getStudyingData(ubdId)
if data then
data.duration=self:calculateZhenFaDuration_Building(zfId,ubdId)
end
end

function zhenfaModel:refreshStudyingDuration_Disciple(discipleguid)
local ubdId=zongmenModel:getDiscipleWorkroom(discipleguid)
if ubdId then
self:refreshStudyingDuration_Building(ubdId)
end
end

















function zhenfaModel:getStudyingTime(ubdId)
local data=self:getStudyingData(ubdId)
if data then
return data.duration
end
return 0
end

function zhenfaModel.calculateTotalTime(times,checkTime)
local count=0
local cnt=#times
for i=1,cnt,2 do
local bTime=times[i]
local eTime=times[i+1]or checkTime or timeHelper.getServerShortTime()
count=count+(eTime-bTime)
end
return count
end

function zhenfaModel.calculatePassTime(times)
local count=0
local cnt=#times
for i=2,cnt,2 do
local bTime=times[i-1]
local eTime=times[i]
count=count+(eTime-bTime)
end
return count
end




function zhenfaModel:isZhenFaStudying(zfId)
for i,v in pairs(self.studying)do
if v.zfId==zfId then
return true
end
end
return false
end




function zhenfaModel:setZhenFaData(zfId,level)
local o=self.data[zfId]or 0
self.data[zfId]=level
if o<=0 and level>0 then
self:eraseZhenFaActiveCost(zfId)
end
end




function zhenfaModel:getZhenFaData(zfId)
return self.data[zfId]or 0
end









function zhenfaModel:calculateZhenFaDuration_Building(zfId,ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
return self:calculateZhenFaDuration_Disciple(zfId,bdData.dizi_id)
end


function zhenfaModel:calculateZhenFaDuration_Disciple(zfId,discipleguid)
local level=self:getZhenFaData(zfId)
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
local levelInfo=zfCfg.level[level]
local total=levelInfo and levelInfo[2]or 0

local add=0
if discipleguid then
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local dzProSkillLv=UIDiscipleModel:getDiscipleJobLevelEx(netData,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local proSkillAdd=cfg.tiangongge_discount and cfg.tiangongge_discount[dzProSkillLv]or 0

local dzSpecialityAdd=dzSpecialityGrowEffectController:getZhenFaStudyRate(netData)
add=add+dzSpecialityAdd-proSkillAdd
end

local duration=math.ceil(total*(1+add/100))

return duration
end




function zhenfaModel:isBuilding_CanLevelUp(ubdData)
if not self.isInit then return false end
if not systemModel.isOpen(SYSTEM_DEFINE.eZhenFa)then return false end
if zhenfaModel:isStartStudying(ubdData.un_build_id)then
return false
end
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
local zfId=i
if not self:isZhenFaStudying(zfId)then
local level=self:getZhenFaData(zfId)
local levelCfg=v.level[level]
if levelCfg and ubdData.level>=levelCfg[3]then
local check=true
for j,w in ipairs(levelCfg[1])do
local costType=w[1]
local costNum=w[2]
local isMoney=itemsConfig.isMoney(costType)
local itemCount=isMoney and moneyModel.getMoney(costType)or bagModel.getItemCountById(costType)or 0
local enough=itemCount>=costNum
if not enough then
check=false
break
end
end
if check then
return true,zfId,level
end
end
end
end

return false
end





function zhenfaModel:canBuildingActive(ubdData,zfId)
if self:isStartStudying(ubdData.un_build_id)then
return false
end
local level=self:getZhenFaData(zfId)
if level<=0 then
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
local levelCfg=zfCfg.level[level]
if levelCfg and ubdData.level>=levelCfg[3]then
for i,v in ipairs(levelCfg[1])do
local costType=v[1]
local costNum=v[2]
local isMoney=itemsConfig.isMoney(costType)
local itemCount=isMoney and moneyModel.getMoney(costType)or bagModel.getItemCountById(costType)or 0
local enough=itemCount>=costNum
if not enough then
return false
end
end
return true
end
end
return false
end




function zhenfaModel:isBuilding_CanActive(ubdData)
if not self.isInit then return false end
if not systemModel.isOpen(SYSTEM_DEFINE.eZhenFa)then return false end
if zhenfaModel:isStartStudying(ubdData.un_build_id)then
return false
end

for i,v in pairs(sort_order)do
local zfId=v
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
if not self:isZhenFaStudying(zfId)then
local level=self:getZhenFaData(zfId)
if level<=0 then
local levelCfg=cfg.level[level]
if levelCfg and ubdData.level>=levelCfg[3]then
local check=true
for j,w in ipairs(levelCfg[1])do
local costType=w[1]
local costNum=w[2]
local isMoney=itemsConfig.isMoney(costType)
local itemCount=isMoney and moneyModel.getMoney(costType)or bagModel.getItemCountById(costType)or 0
local enough=itemCount>=costNum
if not enough then
check=false
break
end
end
if check then
return true,zfId
end
end
end
end
end

return false
end

function zhenfaModel:initZhenFaAtiveCost()
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
local level=self:getZhenFaData(i)
if level<=0 then
local activeCfg=v.level[0]
local cost=activeCfg[1]
for j,w in ipairs(cost)do
local index=w[1]
if not active_cost[index]then
active_cost[index]={}
end
if not table.containsValue(active_cost[index],i)then
table.insert(active_cost[index],i)
end
end
end
end
end

function zhenfaModel:eraseZhenFaActiveCost(zfId)
if not self.isInit then return end
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
local activeCfg=cfg.level[0]
local cost=activeCfg[1]
for j,w in ipairs(cost)do
local itemId=w[1]
local check=self:getZhenFaByActiveCost(itemId)
table.removeValue(check,zfId)
end
end

function zhenfaModel:getZhenFaByActiveCost(itemId)
return active_cost[itemId]
end