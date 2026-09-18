airCreateMonAction=simple_class(airSkillAction)

function airCreateMonAction:__init(...)

end

function airCreateMonAction:initalize(args)
self.cacheEntity={}
self:start()
end

function airCreateMonAction:start()
self:executeBehavour()
end

function airCreateMonAction:onDelete()
self._base:onDelete()
self.damageTime=nil
self.cacheEntity=nil
end

function airCreateMonAction:onPause()
self._base:onPause()
end

function airCreateMonAction:onContinue()
self._base:onContinue()
end

function airCreateMonAction:onUpdate()
self._base:onUpdate()
end

function airCreateMonAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1




if self.destroyTime and self.destroyTime<Time.realtimeSinceStartup then
self:recycleSelf()
self.destroyTime=nil
end
end



function airCreateMonAction:executeBehavour()
local behaviorValue=self.behaviorValue
local monId=behaviorValue[1]
local num=behaviorValue[2]

local pos=airEntitySystem:getCenterPos(self.actionCfg,self.target,self.owner,self.caster)

local monCfg=cfgHelper.get(cfg_airemonsterconfig_get,monId)
local boundType=monCfg.boundType
local bounds=monCfg.bounds

local x,z
if boundType==eAirEntityColliderType.eRect then
x=bounds[4]
z=bounds[5]
elseif boundType==eAirEntityColliderType.eCircle then
x=bounds[4]
z=bounds[4]
elseif boundType==eAirEntityColliderType.eCapsule then
x=bounds[4]
z=bounds[4]
end

local step=math.ceil(math.sqrt(num))
local center=math.floor(step/2)
for i=1,num do
local i1=i%step
local i2=math.ceil(i/step)
i1=i1-center
i2=i2-center
airLevelSystem:createMonster(monId,pos.x+i1*x,pos.z+i2*z)
end

self.destroyTime=1+Time.realtimeSinceStartup
end




