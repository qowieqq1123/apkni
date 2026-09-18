airPlayEffectAction=simple_class(airSkillAction)

function airPlayEffectAction:__init(...)

end

function airPlayEffectAction:initalize(args)
self:start()
end

function airPlayEffectAction:start()
self:createBehavior()
end

function airPlayEffectAction:onDelete()
self._base:onDelete()
if self.effectHandle then
_stopEffect(self.effectHandle)
end
self.destroyTime=nil
self.damageTime=nil
self.effectHandle=nil
end

function airPlayEffectAction:onPause()
self._base:onPause()
end

function airPlayEffectAction:onContinue()
self._base:onContinue()
end

function airPlayEffectAction:onUpdate()
self._base:onUpdate()
end

function airPlayEffectAction:onFastUpdate()

if self:isDeleteSelf()then return end

if self.delayPlay and self.delayPlay<=Time.realtimeSinceStartup then
self:playEffect()
self.delayPlay=nil
end

if self.destroyTime and self.destroyTime<=Time.realtimeSinceStartup then

if self.effectHandle then
_stopEffect(self.effectHandle)
self.effectHandle=nil
end
self:recycleSelf()
end
end

function airPlayEffectAction:createBehavior()

local behaviorValue=self.behaviorValue
local effectId=behaviorValue[1]
local attach=behaviorValue[2]or 0
local scale=behaviorValue[3]or 1
local isFlipX=1
local checkFlip=behaviorValue[4]

local offsetX=behaviorValue[5]or 0
local offsetZ=behaviorValue[6]or 0

local delayPlay=behaviorValue[7]or 0

local lifetime=behaviorValue[8]

if checkFlip==1 then
local flip=self.caster:isFlipX()
if flip then
if offsetX==0 then
isFlipX=-1
end
offsetX=-offsetX
end
end
scale=isFlipX*scale
if not lifetime then
local effectLife=cfgHelper.get(cfg_effectconfig_get,effectId,"lifetime")
if effectLife then
lifetime=effectLife/1000
else
lifetime=5
end
end
self.destroyTime=delayPlay+lifetime+Time.realtimeSinceStartup

self.attach=attach
self.effectId=effectId
self.scale=scale
self.checkFlip=checkFlip
self.offsetX=offsetX
self.offsetZ=offsetZ

if delayPlay==0 then
self:playEffect()
else
self.delayPlay=delayPlay+Time.realtimeSinceStartup
end
end

function airPlayEffectAction:playEffect()
local scale=self.scale
if self.attach==0 then
local pos=self.caster:getPosition()
pos.x=pos.x+self.offsetX
pos.z=pos.z+self.offsetZ
self.effectHandle=airEntitySystem:playEffect(self.effectId,pos,self.checkFlip==1,Vector3.New(scale,scale,scale))
else
if self.caster then
local sortingLayer=self.caster:getSortingLayer()
self.effectHandle=self.caster.staticAuto.BaseEntity_PlayEffectWithOrder(self.caster.handle,self.effectId,Vector3.New(self.offsetX,0,self.offsetZ),Vector3.New(scale,scale,scale),true,true,sortingLayer,-1)
end
end
end