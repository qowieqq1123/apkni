

airShotSkillAction=simple_class(airSkillAction)

function airShotSkillAction:__init(...)

end

function airShotSkillAction:initalize()
self.shotNum=0
self:start()
end

function airShotSkillAction:start()
self:executeBehavour()
end

function airShotSkillAction:onDelete()
self._base:onDelete()
self.shotNum=nil
self.nextDeltaTime=nil
self.entityArgs_=nil
end

function airShotSkillAction:onPause()
self._base:onPause()
end

function airShotSkillAction:onContinue()
self._base:onContinue()
end

function airShotSkillAction:onUpdate()
self._base:onUpdate()
if self.isStart and not self:hasSkillEnts()then
self:recycleSelf()
end
end

function airShotSkillAction:onFastUpdate()
self._base:onFastUpdate()
if self.shotNum>0 then
local realtimeSinceStartup=Time.realtimeSinceStartup
if realtimeSinceStartup>self.nextDeltaTime then
self.shotNum=self.shotNum-1
self.nextDeltaTime=realtimeSinceStartup+self.shotInterval

if self.shotType==3 then
local index=self.circleIndex+1
if index>#self.circlePoint then index=1 end
self.circleIndex=index
local args_={}
local pos=self.caster:getPosition()
local pos1=pos+Vector3.New(self.circlePoint[index].x,0,self.circlePoint[index].z)
args_.angle=self.circlePoint[index].a
if args_.angle>=360 then
args_.angle=args_.angle-360
end
args_.pos=pos1
self:createEntity(args_)
elseif self.shotType==1 then
self:shootFan(self.target)

else
self:createEntity(self.entityArgs_)
end


end
end
end

function airShotSkillAction:isDeleteSelf()
return self.isDelete==true
end

function airShotSkillAction:executeBehavour()
if self.behavourType==1 then
if self.caster.entityType==eAirEntityType.TYPE_WEAPON then
self.caster:runSpineAnimator(1016)
end
local target=self.target
local behaviorValue=self.behaviorValue

local showArgs=behaviorValue[2]
if showArgs[1]==2 then
local effectId=showArgs[2][1]
if effectId>0 then
self.caster:playEffect(effectId)
end
end

local actionCfg=self.actionCfg
local shotArgs=behaviorValue[4]
local shotType=shotArgs[1]

if shotType==1 then
if target==nil then
self:recycleSelf()
return
end
local angle=self:getFanAngle(actionCfg,self.owner,self.caster,target)
local num=shotArgs[2]
local tAngle=shotArgs[3]
local times=shotArgs[4]or 1
local interval=shotArgs[5]or 0
local singleAngle=tAngle/(num-1)
local middle=(num-1)/2+1
for i=1,num do
local angle_=angle+(middle-i)*singleAngle
local args_={}
args_.angle=angle_
self:createEntity(args_)
end
if times>1 then
self.shotNum=times-1
self.shotArgs_=shotArgs
if interval==0 then interval=0.01 end
self.shotInterval=interval
self.nextDeltaTime=Time.realtimeSinceStartup+interval
end

elseif shotType==2 then
if target==nil then
self:recycleSelf()
return
end
local angle=self:getFanAngle(actionCfg,self.owner,self.caster,target)
local args_={}
args_.angle=angle
local num=shotArgs[2]
local interval=shotArgs[3]or 0
self:createEntity(args_)
if num>1 then
self.shotNum=num-1
if interval==0 then interval=0.01 end
self.shotInterval=interval
self.nextDeltaTime=Time.realtimeSinceStartup+interval
self.entityArgs_=args_
end
elseif shotType==3 then
local num=shotArgs[2]
local interval=shotArgs[3]or 0.01
local radius=shotArgs[4]
local intervalangle=shotArgs[5]
local circlePointNum=math.floor(360/intervalangle)
local path={}
local a

for i=1,circlePointNum do
a=i*Mathf.PI*2/circlePointNum
table.insert(path,{x=Mathf.Cos(a)*radius,z=Mathf.Sin(a)*radius,a=a/Mathf.Deg2Rad})
end

local args_={}
local pos=self.caster:getPosition()
local pos1=pos+Vector3.New(path[1].x,0,path[1].z)
args_.angle=path[1].a
if args_.angle>=360 then
args_.angle=args_.angle-360
end
args_.pos=pos1
self:createEntity(args_)

self.circlePoint=path
self.circleIndex=1
self.shotNum=num-1
self.shotInterval=interval
self.nextDeltaTime=Time.realtimeSinceStartup+interval
elseif shotType==4 then
local num=shotArgs[2]
local earlyWarnLookup=self.caster.earlyWarnLookup
local list={}
for k,v in pairs(earlyWarnLookup)do
local pos=self.centerPos
local distance=airEntitySystem:getDistance2D(v.handle,pos.x,pos.z)
list[#list+1]={distance,v}
end
table.sort(list,function(a,b)
return a[1]<b[1]
end)
local count=0
for i,v in ipairs(list)do
self:createEntity(nil,v[2])
count=count+1
if count>=num then
break
end
end
end

self.shotType=shotType
end
end

function airShotSkillAction:shootFan(target)
local angle=self:getFanAngle(self.actionCfg,self.owner,self.caster,target)
local shotArgs=self.shotArgs_
local num=shotArgs[2]
local tAngle=shotArgs[3]
local singleAngle=tAngle/(num-1)
local middle=(num-1)/2+1
for i=1,num do
local angle_=angle+(middle-i)*singleAngle
local args_={}
args_.angle=angle_
self:createEntity(args_)
end
end


function airShotSkillAction:executeSingleDamage(target)
return airSkillSystem:executeSingleDamage(self.owner,target,self.caster,self.skillCfg,self.actionCfg,self.acionValue,self.args)
end

function airShotSkillAction:createEntity(args,target)
self._base.createEntity(self,eAirSkillEntityType.eShot,nil,args,target)
end


function airShotSkillAction:onTriggerEnterMonster(entity)
if self.enemyEntitesNum>self.targetMaxCount then return end

if not self:checkCastEnity(entity)then return false end

local handle=entity.handle
if not self.enemyEntites[handle]then
self.enemyEntites[handle]=entity
self.enemyEntitesNum=self.enemyEntitesNum+1
end
self:executeSingleDamage(entity)
return true
end

function airShotSkillAction:onTriggerExitMonster(entity)
local handle=entity.handle
if self.enemyEntites[handle]==nil then return false end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
return true
end

function airShotSkillAction:getFanAngle(actionCfg,owner,caster,target)
local centerType=actionCfg.centerType
if centerType==eAirSkillCenterType.eTarget then
return 0
elseif centerType==eAirSkillCenterType.eSelf then
return airEntitySystem:getAoundYAngle(owner.handle,target.handle)
elseif centerType==eAirSkillCenterType.eWeapon then
return airEntitySystem:getAoundYAngle(caster.handle,target.handle)
end
end
