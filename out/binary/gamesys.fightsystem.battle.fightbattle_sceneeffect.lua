





local getPos=function(self,isLeft)
if isLeft then
if self.teamCenterPosLeft then
return self.teamCenterPosLeft
else
local pos=Vector3.zero
for i=1,5 do
local info=fightModel:getPosInfoByTypo(stagePosType.TwoThree,i)
pos=pos+info.pos
end
pos=pos/5
self.teamCenterPosLeft=pos
return pos
end
else
if self.teamCenterPosRight then
return self.teamCenterPosRight
else
local pos=Vector3.zero
for i=6,10 do
local info=fightModel:getPosInfoByTypo(stagePosType.TwoThree,i)
pos=pos+info.pos
end
pos=pos/5
self.teamCenterPosRight=pos
return pos
end
end
end

local removeSceneEffect=function(self,buffGuid,isLeft)
if isLeft then
for i,v in ipairs(self.sceneEffectList_left)do
if v[1]==buffGuid then
table.remove(self.sceneEffectList_left,i)
break
end
end
else
for i,v in ipairs(self.sceneEffectList_right)do
if v[1]==buffGuid then
table.remove(self.sceneEffectList_right,i)
break
end
end
end
end

function fightBattle:initSceneEffect()
self.sceneEffectList_left={}
self.sceneEffectGuid_left=nil
if self.sceneEffectEnt_left then
fightManager.removeEntity(self.sceneEffectEnt_left.GUID)
end

if self.sceneEffectScene_left then
_stopEffect(self.sceneEffectScene_left)
end
self.sceneEffectScene_left=nil
self.sceneEffectEnt_left=nil
self.sceneEffectLastBody_left=nil
self.sceneEffectId_left=nil

self.sceneEffectList_right={}
self.sceneEffectGuid_right=nil
if self.sceneEffectEnt_right then
fightManager.removeEntity(self.sceneEffectEnt_right.GUID)
end
if self.sceneEffectScene_right then
_stopEffect(self.sceneEffectScene_right)
end
self.sceneEffectEnt_right=nil
self.sceneEffectLastBody_right=nil
self.sceneEffectScene_right=nil
self.sceneEffectId_right=nil
end

function fightBattle:onAddSceneEffect(ent,buffGuid,buffId)

local buffConfig=cfgHelper.get(cfg_buffconfig_get,buffId)
if buffConfig and not buffConfig.addScenebodyid then
return
end
local beHaveConfig=buffConfig.addScenebodyid[1]

local isLeft=ent:isLeft()

removeSceneEffect(self,buffGuid,isLeft)

if isLeft then
table.insert(self.sceneEffectList_left,{buffGuid,ent,beHaveConfig,buffConfig.addScenebodyid[3]})
if self.sceneEffectGuid_left~=buffGuid then
if buffConfig.addScenebodyid[2]and not ent.isRunBehavior then
ent:runBehavior(buffConfig.addScenebodyid[2],nil,function()
self:playSceneEffect(isLeft)
end)
else
self:playSceneEffect(isLeft)
end
end
self.sceneEffectGuid_left=buffGuid
else
table.insert(self.sceneEffectList_right,{buffGuid,ent,beHaveConfig,buffConfig.addScenebodyid[3]})
if self.sceneEffectGuid_right~=buffGuid then
if buffConfig.addScenebodyid[2]and not ent.isRunBehavior then
ent:runBehavior(buffConfig.addScenebodyid[2],nil,function()
self:playSceneEffect(isLeft)
end)
else
self:playSceneEffect(isLeft)
end
end
self.sceneEffectGuid_right=buffGuid
end
end

function fightBattle:onRemoveSceneEffect(buffGuid,isLeft)
removeSceneEffect(self,buffGuid,isLeft)
self:playSceneEffect(isLeft)
end

function fightBattle:getLatestSceneEffect(isLeft)
if isLeft then
return self.sceneEffectList_left[#self.sceneEffectList_left]
else
return self.sceneEffectList_right[#self.sceneEffectList_right]
end
end

function fightBattle:playSceneEffect(isLeft)

local sceneEffect=self:getLatestSceneEffect(isLeft)
if sceneEffect then
if isLeft then
local beHaveConfig=sceneEffect[3]
local pos=getPos(self,isLeft)

if self.sceneEffectEnt_left then
if self.sceneEffectLastBody_left~=beHaveConfig[1]then
self.sceneEffectEnt_left:ChangeBody(beHaveConfig[1],beHaveConfig[2],false,beHaveConfig[3])
self.sceneEffectLastBody_left=beHaveConfig[1]
end
else
local sceneEffectEnt=fightManager.addEntity(beHaveConfig[1],beHaveConfig[2],pos,isLeft,eAnimationID.stand,beHaveConfig[3])
self.sceneEffectEnt_left=sceneEffectEnt
self.sceneEffectLastBody_left=beHaveConfig[1]
end
local effectId=sceneEffect[4]

if self.sceneEffectScene_left and self.sceneEffectId_left~=effectId then
_stopEffect(self.sceneEffectScene_left)
self.sceneEffectScene_left=nil
end

if self.sceneEffectId_left~=effectId and effectId then
self.sceneEffectScene_left=fightManager.playEffect(effectId,pos,isLeft)
self.sceneEffectId_left=effectId

end
else
local beHaveConfig=sceneEffect[3]
local pos=getPos(self,isLeft)
if self.sceneEffectEnt_right then
if self.sceneEffectLastBody_right~=beHaveConfig[1]then
self.sceneEffectEnt_right:ChangeBody(beHaveConfig[1],beHaveConfig[2],false,beHaveConfig[3])
self.sceneEffectLastBody_right=beHaveConfig[1]
end
else
local sceneEffectEnt=fightManager.addEntity(beHaveConfig[1],beHaveConfig[2],pos,isLeft,eAnimationID.stand,beHaveConfig[3])
self.sceneEffectEnt_right=sceneEffectEnt
self.sceneEffectLastBody_right=beHaveConfig[1]
end
local effectId=sceneEffect[4]
if self.sceneEffectScene_right and self.sceneEffectId_right~=effectId then
_stopEffect(self.sceneEffectScene_right)
self.sceneEffectScene_right=nil
end

if self.sceneEffectId_right~=effectId and effectId then
self.sceneEffectScene_right=fightManager.playEffect(effectId,pos,isLeft)
self.sceneEffectId_right=effectId
end
end
else
self:removeSceneEffectEnt(isLeft)
end
end

function fightBattle:removeSceneEffectEnt(isLeft)
if isLeft then
if self.sceneEffectEnt_left then
fightManager.removeEntity(self.sceneEffectEnt_left.GUID)
self.sceneEffectEnt_left=nil
end

if self.sceneEffectScene_left then
_stopEffect(self.sceneEffectScene_left)
self.sceneEffectScene_left=nil
end
self.sceneEffectId_left=nil
else
if self.sceneEffectEnt_right then
fightManager.removeEntity(self.sceneEffectEnt_right.GUID)
self.sceneEffectEnt_right=nil
end
if self.sceneEffectScene_right then
_stopEffect(self.sceneEffectScene_right)
self.sceneEffectScene_right=nil
end
self.sceneEffectId_right=nil
end
end

function fightBattle:playSceneEffectAnim(ent,anim,speed,callback)
local isLeft=ent:isLeft()
local sceneEffectEnt=isLeft and self.sceneEffectEnt_left or self.sceneEffectEnt_right
if sceneEffectEnt then
local sceneEffect=self:getLatestSceneEffect(isLeft)
if ent.id~=sceneEffect[2].id then
return
end
sceneEffectEnt:RunAnimator(anim,speed or 1,callback or nil)
end
end
