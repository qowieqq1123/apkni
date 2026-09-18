






local createFunc=
{
[eSummonType.eMonster]=function(self,id,x,z)
airLevelSystem:createMonster(id,x,z)
end,
[eSummonType.eTowner]=function(self,id,x,z)
airEntitySystem:createTower(self.owner,id,x,z)
end,
[eSummonType.eTrop]=function(self,id,x,z)
airEntitySystem:createTrap(self.owner,id,x,z)
end,
}

airCreateEntAction=simple_class(airSkillAction)

function airCreateEntAction:__init(...)

end

function airCreateEntAction:initalize(args)
self:start()
end

function airCreateEntAction:start()
self:executeBehavour()
end

function airCreateEntAction:onDelete()
self._base:onDelete()
end

function airCreateEntAction:onPause()
self._base:onPause()
end

function airCreateEntAction:onContinue()
self._base:onContinue()
end

function airCreateEntAction:onUpdate()
self._base:onUpdate()
end

function airCreateEntAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1




if self.destroyTime and self.destroyTime<Time.realtimeSinceStartup then
self:recycleSelf()
self.destroyTime=nil
end
end



function airCreateEntAction:executeBehavour()
local behaviorValue=self.behaviorValue
local entList=behaviorValue[1]
local minCircle=behaviorValue[2]
local maxCircle=behaviorValue[3]

local pos=airEntitySystem:getCenterPos(self.actionCfg,self.target,self.owner,self.caster)

local total=0

local eType,eId,num
for i,v in ipairs(entList)do
total=total+v[3]
end

local posList=airEntitySystem:getEntityRandomPos(pos.x,pos.z,minCircle,maxCircle,total)

local idx=1
for _,v in ipairs(entList)do
eType=v[1]
eId=v[2]
num=v[3]
for i=1,num do
createFunc[eType](self,eId,posList[idx][1],posList[idx][2])
idx=idx+1
end
end
self.destroyTime=1+Time.realtimeSinceStartup
end




