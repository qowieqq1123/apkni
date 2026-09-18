





airRangeAreaAction=simple_class(airSkillAction)

function airRangeAreaAction:__init(...)

end

function airRangeAreaAction:initalize(args)
self.cacheEntity={}
self.demagedEntity={}
self.checkRangeEnt={}




self:start()
end

function airRangeAreaAction:start()
local behaviorValue=self.behaviorValue
if behaviorValue[10]and behaviorValue[10]>0 then
self.startBehaveTime=behaviorValue[10]+Time.realtimeSinceStartup
else
self:executeBehavour()
end
end

function airRangeAreaAction:onDelete()
self._base:onDelete()
if self.checkRangeEnt then
for i,ent in pairs(self.checkRangeEnt)do
ent:onDelete()
end
end
self.damageTime=nil
self.cacheEntity=nil
self.demagedEntity=nil
self.checkRangeEnt=nil
end

function airRangeAreaAction:onPause()
self._base:onPause()
end

function airRangeAreaAction:onContinue()
self._base:onContinue()
end

function airRangeAreaAction:onUpdate()
self._base:onUpdate()
end

function airRangeAreaAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1
local pauseTime=airLevelSystem:getPauseTime()
if self.startBehaveTime and self.startBehaveTime+pauseTime<=Time.realtimeSinceStartup then
self:executeBehavour()
self.startBehaveTime=nil
end

if self.executeCnt<=0 then
if self.demageType==1 then
for i,v in pairs(self.cacheEntity)do
if v.demageTime and v.demageTime+pauseTime<=Time.realtimeSinceStartup then
for _,entity in pairs(v.entList)do
self:executeSingleDamage(entity)
end
v.demageTime=nil
end
end
end
if self.demageType==2 and self.damageTime+self.damageCD+pauseTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=Time.realtimeSinceStartup
end
end

if self.destroyTime and self.destroyTime+pauseTime<Time.realtimeSinceStartup then
if self.behaviorValue[9]==1 then
if self.owner.aiBehaviour then
self.owner.aiBehaviour:remsumeStackTarget()
self.owner.aiBehaviour:onContinue()
end
end
self:recycleSelf()
end
end


function airRangeAreaAction:executeBehavour()
self:createCheckEntity()

end

function airRangeAreaAction:createCheckEntity()
local behaviorValue=self.behaviorValue

local skillEntityType=eAirSkillEntityType.eSkillRange

local centerPos

local haveTarget=self.target~=nil
if haveTarget then
centerPos=self.target:getPosition()
else
centerPos=self.owner:getPosition()
end

local pointNum=behaviorValue[3]

local n=behaviorValue[4]

local small=behaviorValue[5]

local kong=behaviorValue[6]

local demageArgs=behaviorValue[7]or{}

local centerIdx=math.ceil(n/2)
local cIdx2=n*(centerIdx-1)+centerIdx
local idxList={}
for i=1,n*n do
idxList[i]=i-cIdx2
end
table.remove(idxList,cIdx2)

local boundType,bounds=airSkillSystem:getBounds(eAirSkillRangeType.eCircle,{small})

local args=self:getTargetArgs()
args.pos=centerPos

args.effectArgs=behaviorValue[2]
args.boundType=boundType
args.bounds=bounds
local ent=airEntitySystem:createSkillEntity(skillEntityType,self.caster,self.caster,self.target,self.actionCfg,args)
if not ent.isDelete then
self.checkRangeEnt[ent.handle]=ent
self.cacheEntity[ent.handle]={entList={}}
if demageArgs[1]==1 then
self.cacheEntity[ent.handle].demageTime=Time.realtimeSinceStartup+demageArgs[2]+(args.startWait or 0)
end
end


local idx,val,pos,x,z,e
for i=1,pointNum-1 do
idx=math.random(1,#idxList)
val=idxList[idx]
table.remove(idxList,idx)

x=math.fmod(val,n)
z=val>0 and math.ceil(val/n)or math.floor(val/n)

pos=centerPos+Vector3.New(x*(small+kong)+math.random(-kong,kong),0,z*(small+kong)+math.random(-kong,kong))
local args=self:getTargetArgs()
args.pos=pos
args.startWait=(behaviorValue[8]or 0)*i
args.effectArgs=behaviorValue[2]
args.boundType=boundType
args.bounds=bounds
e=airEntitySystem:createSkillEntity(skillEntityType,self.caster,self.caster,self.target,self.actionCfg,args)
if not e.isDelete then
self.checkRangeEnt[e.handle]=e
self.cacheEntity[e.handle]={entList={}}
if demageArgs[1]==1 then
self.cacheEntity[ent.handle].demageTime=Time.realtimeSinceStartup+demageArgs[2]+(args.startWait or 0)
end
end
end









local checkTime=behaviorValue[1]or 0

if demageArgs[1]==2 then
self.damageTime=Time.realtimeSinceStartup-demageArgs[2]
self.damageCD=demageArgs[2]
end
self.demageType=demageArgs[1]


self.destroyTime=checkTime+Time.realtimeSinceStartup
end

function airRangeAreaAction:executeDamage()
if self.cacheEntity==nil then return end
if self.caster==nil or self.caster:isDeleteSelf()then return end

if self.demageType==2 then
for _,v in pairs(self.cacheEntity)do
for _,entity in pairs(v.entList)do
self:executeSingleDamage(entity)
end
end
end
end

function airRangeAreaAction:onTriggerEnterSkillCheck(entity,skillHandle)
if not self:checkCastEnity(entity)then return false end
if not self.cacheEntity then return false end
local handle=entity.handle

self.cacheEntity[skillHandle].entList[handle]=entity


self.demagedEntity[skillHandle]=self.demagedEntity[skillHandle]or{}
if self.demageType==3 and(self.demagedEntity and not self.demagedEntity[skillHandle][handle])then
self:executeSingleDamage(entity)
self.demagedEntity[skillHandle][handle]=entity
end
end

function airRangeAreaAction:onTriggerExitSkillCheck(entity,skillHandle)
if not self.cacheEntity then return false end
local handle=entity.handle

self.cacheEntity[skillHandle].entList[handle]=nil
end



