airMonsterSystem={}


function airMonsterSystem:onAppStart()

end

function airMonsterSystem:onEnterState(isReconnect)

end


function airMonsterSystem:onLeaveState(isReconnect)
airMonsterSystem:leaveAirGame()
end

function airMonsterSystem:onProtocolReq(isReconnect)

end

function airMonsterSystem:enterAirGame()
self.neutralCnt=0
end

function airMonsterSystem:leaveAirGame()
self.neutralCnt=0
end


function airMonsterSystem:createAI(owner,aiId,args)
local aiType=cfgHelper.get2(cfg_airemonsteraiconfig_get,aiId,'type')
airMonsterSystem:preloadAI(aiType)
local ctor=airMonsterSystem:getAIInfo(aiType)
return ctor(owner,aiId,args)
end

function airMonsterSystem:randomDistancePoint(owner,target,distance)
local direction=airEntitySystem:getEntityDirection(owner,target)
local angle=airEntitySystem:getSignedAngle(Vector3.New(0,0,1),direction,Vector3.New(0,1,0))

angle=math.floor(angle)

local point=owner:getPosition()
local posX=point.x
local posZ=point.z
local posY=point.y

local list=mathHelper.randomNumArray(angle,angle+90)

for i=#list,1,-1 do
local angle2=list[i]
local x=posX+distance*Mathf.Cos(angle2)
local z=posZ+distance*Mathf.Sin(angle2)
if airMapSystem:isInMap(x,z)then
return Vector3.New(x,posY,z)
end
end

local list=mathHelper.randomNumArray(angle,angle-90)

for i=#list,1,-1 do
local angle2=list[i]
local x=posX+distance*Mathf.Cos(angle2)
local z=posZ+distance*Mathf.Sin(angle2)
if airMapSystem:isInMap(x,z)then
return Vector3.New(x,posY,z)
end
end

local point=airEntitySystem:getDistancePoint(target,owner,distance,true)
if airMapSystem:isInMap(point.x,point.z)then
return point
end


return Vector3.New(posX,posY,posZ)
end


function airMonsterSystem:randomCruisePoint(num,posY)
local leftX,topZ,rightX,bottomZ=airMapSystem:getBoundary()
local points={}
for i=1,num do
local randomX=math.random(leftX+1,rightX-1)
local randomZ=math.random(bottomZ+1,topZ-1)
points[#points+1]=Vector3.New(randomX,posY,randomZ)
end
return points
end

function airMonsterSystem:createMonster(monsterId,posX,posZ,count)
local action=function()
if not airLevelSystem:isLevelDoing()then

return
end
count=count or 1
if count==1 then
local ent=airEntitySystem:createMonsterEntity(monsterId,posX,posZ,true)
airMonsterSystem:addEnt(ent)
else
local offsetPos=airEntitySystem:getEntityOffsetPos(posX,posZ,count)
for i=1,count do
local pos=offsetPos[i]
local x=pos[1]
local z=pos[2]
local ent=airEntitySystem:createMonsterEntity(monsterId,x,z,true)
airMonsterSystem:addEnt(ent)
end
end
end
local bundle=globalABLookup.airmainicons
local asset=cfgHelper.get2(cfg_airemonsterconfig_get,monsterId,'warnIcon')
airEntitySystem:createMaskEntity(posX,posZ,bundle,asset,action)
end

function airMonsterSystem:getMonsterRadius(monsterId)
local monsterCfg=cfg_airemonsterconfig_get(monsterId)
local boundType=monsterCfg.boundType
local bounds=monsterCfg.bounds
if boundType==eAirEntityColliderType.eRect then
return math.max(bounds[4],bounds[5])
elseif boundType==eAirEntityColliderType.eCircle then
return bounds[4]
elseif boundType==eAirEntityColliderType.eCapsule then
return bounds[4]
end
return 0
end

function airMonsterSystem:onDead(monster,isCirtical)
local handle=monster.handle
airBuffSystem:onRoleKillEnemy(monster,isCirtical)
airHUDSystem:onDead(handle)
airMonsterSystem:removeEnt(monster)
end


function airMonsterSystem:createDropEntity(x,z,dropid)

if dropid==nil then return end
local entity=airEntitySystem:createDropEntity(x,z,dropid)
airBuffSystem:onEntityDeadDrop(entity)
end


function airMonsterSystem:getNeutralTime(neutralArgs,levelIdx,addTime,addTime_P)
local time=neutralArgs[1]
local step=neutralArgs[2]
if step==0 then
loggerUtil.debugErrFMT('中立生物刷新步长不能为0')
return 10000000
end
local ret=math.ceil(time-(levelIdx-1)/step)+addTime
ret=math.ceil(ret*(1+addTime_P/10000))
if ret<=0 then
loggerUtil.debugErrFMT('中立生物刷新时间不能为0')
return 10000000
end
return ret
end

function airMonsterSystem:onLevelStart(fbid,levelIdx)
local fubenCfg=cfg_airfubenconfig_get(fbid)
local neutralArgs=fubenCfg.neutralArgs
local levelId=fubenCfg.sceneList[levelIdx]
local levelCfg=cfg_airlevelconfig_get(levelId)
local neutral=levelCfg.neutral
if neutral==nil then return end
self.neutralCnt=0
self.neutralArgs=neutralArgs
self.monsterId=neutral[1]
local addTime,addTime_P=airBuffSystem:getAddSpeFreshTime(self.monsterId)
self.monsterMax=neutral[2]
self.levelIdx=levelIdx
self.levelCfg=levelCfg
self.refreshInterval=airMonsterSystem:getNeutralTime(self.neutralArgs,self.levelIdx,addTime,addTime_P)

airMonsterSystem:setNextSpwanStamp()
end

function airMonsterSystem:onLevelEnd()
self.neutralCnt=0
self.neutralArgs=nil
self.monsterId=nil
self.monsterMax=nil
self.levelIdx=nil
self.levelCfg=nil
self.refreshInterval=nil
end

function airMonsterSystem:setNextSpwanStamp()
self.refreshStamp=airController:getRealServerTime_short()+self.refreshInterval
end

function airMonsterSystem:spwanNeutral()
if not airMonsterSystem:canSpwanNeutral()then return end
airMonsterSystem:setNextSpwanStamp()
local x,z=airLevelSystem:randomPoint(self.levelCfg.neutralSpwanPointRange)
airLevelSystem:createMonster(self.monsterId,x,z)

end

function airMonsterSystem:canSpwanNeutral()
if self.monsterId==nil then return false end
if self.neutralCnt>=self.monsterMax then return false end
return airController:getRealServerTime_short()>=self.refreshStamp
end

function airMonsterSystem:addEnt(ent)
if ent.entityCfg.monsterType2==eAirMonsterType2.eNeutral then
self.neutralCnt=self.neutralCnt+1
end
airLevelSystem:addMonster(ent)
end

function airMonsterSystem:removeEnt(ent)
if ent.entityCfg.monsterType2==eAirMonsterType2.eNeutral then
self.neutralCnt=self.neutralCnt-1
end
airLevelSystem:onDeleteMonster(ent)
end


function airMonsterSystem:creatorSpeMonsterData(levelCfg,spwanTime)

local speSpwanArgs=levelCfg.speSpwanArgs
local speSpwan={}
if speSpwanArgs then
for i,v in ipairs(speSpwanArgs)do
local monsterId=v[1]
local time=v[2]
local addTime,addTime_P=airBuffSystem:getAddSpeFreshTime(monsterId)
time=time+addTime
time=math.ceil(time*(1+addTime_P/10000))
local round=math.ceil(time/spwanTime)
if speSpwan[round]==nil then speSpwan[round]={}end
local roundSpeSpwan=speSpwan[round]
roundSpeSpwan[#roundSpeSpwan+1]=monsterId
end
end


local cndSpwanArgs=levelCfg.cndSpwanArgs
if cndSpwanArgs then
for i,v in ipairs(cndSpwanArgs)do
local monsterId=v[1]
local time=v[2]
local cnd=v[3]
if airMonsterSystem:checkSpwanCnd(cnd)then
local addTime,addTime_P=airBuffSystem:getAddSpeFreshTime(monsterId)
time=time+addTime
time=math.ceil(time*(1+addTime_P/10000))
local round=math.ceil(time/spwanTime)
if speSpwan[round]==nil then speSpwan[round]={}end
local roundSpeSpwan=speSpwan[round]
roundSpeSpwan[#roundSpeSpwan+1]=monsterId
end
end
end

return speSpwan
end

function airMonsterSystem:checkSpwanCnd(cnd)
if cnd==nil then return true end
local cndType=cnd[1]
local cndArgs=cnd[2]
if cndType==1 then
local jiyuan=airActorSystem:getActorAttrValByAttrId(aiAttributeType.eLucky)or 0
local ratio=jiyuan*cndArgs
if ratio<0 then return false end
return mathHelper.randomLimit(0,10000,ratio)
end
loggerUtil.debugErrFMT('尚未支持怪物条件类型{0}刷新',cndType)
return false
end
