

airBaWangQiangSkillAction=simple_class(airSkillAction)

function airBaWangQiangSkillAction:__init(...)

end

function airBaWangQiangSkillAction:initalize(args)
self:start()
end

function airBaWangQiangSkillAction:start()

self:executeBehavour()
end

function airBaWangQiangSkillAction:onDelete()
if self.casterVis==false and self.caster and not self.caster:isDeleteSelf()then
self.caster:setAssetActive(true)
end
self.casterVis=nil

self._base.onDelete(self)
end









function airBaWangQiangSkillAction:onUpdate()

if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:recycleSelf()
return
end
end
end

function airBaWangQiangSkillAction:onFastUpdate()
if self:isDeleteSelf()then return end


self.executeCnt=self.executeCnt-1
if self.damageTime and self.executeCnt<=0 and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
end

function airBaWangQiangSkillAction:executeSingleDamage(target)
local pos=target:getPosition()
local ret=self._base.executeSingleDamage(self,target)
if ret then
local scale=1
airEntitySystem:playEffect(self.behaviorValue[4][2],pos,false,Vector3.New(scale,scale,scale))
end
end

function airBaWangQiangSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue
local duration=behaviorValue[2]
local damageTime=behaviorValue[3]or 0
self.damageTime=damageTime+Time.realtimeSinceStartup
local caster=self.caster
local target=self.target
local args=self:getTargetArgs()
local ent=airEntitySystem:copyEntitySkill(caster,true,eAirSkillEntityType.eRoundTrip2,self.owner,self.caster,self.target,self.actionCfg,args)
if not ent.isDelete then
self.skillEnts[ent.handle]=ent
end
self.timeStamp=duration*2+Time.realtimeSinceStartup+0.2
end
