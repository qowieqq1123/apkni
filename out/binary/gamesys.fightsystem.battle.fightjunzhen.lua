






def_class('fightJunZhen',fightEntity)



local effectEmitter=
{
[eJZEffectType.eFire1]=function(self,srcEnt,dstId)
local dstEnt=self.battle:getEntity(dstId)
local dstPos=dstEnt:getHitedPos()
self:playMoveEffect(20601,20602,srcEnt,dstPos,20)
end,
[eJZEffectType.eSword]=function(self,srcEnt,dstId)
local dstEnt=self.battle:getEntity(dstId)
local dstPos=dstEnt:getHitedPos()
local onComplete=function()
fightManager.playEffect(20604,dstPos,dstEnt.isInLeft,Vector3.one)
end
self:playMove3DEffect(20603,srcEnt,dstPos,15,onComplete,-10,10,0,0,0,0,Vector3.one)
end,
[eJZEffectType.eLightning]=function(self,srcEnt,dstId)
local dstEnt=self.battle:getEntity(dstId)
local dstPos=dstEnt:getHitedPos()
fightManager.playEffect(20605,dstPos,false,Vector3.one)
end,
[eJZEffectType.eIce1]=function(self,srcEnt,dstId)
local dstEnt=self.battle:getEntity(dstId)
local dstPos=dstEnt:getHitedPos()
self:playMoveEffect(20606,20607,srcEnt,dstPos,20)
end,
[eJZEffectType.eMagic]=function(self,srcEnt,dstId)
local dstEnt=self.battle:getEntity(dstId)
local dstPos=dstEnt:getHitedPos()
self:playMoveEffect(20608,20609,srcEnt,dstPos,20)
end,
}

function fightJunZhen:init(_battle,posType,id,baseInfo,outEffectOpen)
fightEntity.init(self,_battle,posType,id,baseInfo,outEffectOpen)

self.jzMaxNum=baseInfo.jzMaxNum

if self.baseInfo.jzData then
self:initJunZhenData(self.baseInfo.jzData)
end

end


function fightJunZhen:initJunZhenData(jzData)
self.jzData={}
local data
local jz=jzData[1]
local jzLv=jz and jz[1]or 1
for i,v in ipairs(jzData)do
data={v[1],v[2],v[3]or 0,v[4]or 0,v[5]or 0}
self.jzData[v[1]]=data
if v[1]>jzLv then
jzLv=v[1]
end
end
self.jzLv=jzLv

self:initAttribute()
end

function fightJunZhen:updateJunZhenData(jzData)
for i,v in ipairs(jzData)do
self.jzData[v[1]]=v
end
self:initAttribute(true)


end

function fightJunZhen:getJunZhenLv()
return self.jzLv or 1
end

function fightJunZhen:getJunZhenNum()
local num=0
for i,v in pairs(self.jzData)do
num=num+v[2]+v[3]+v[4]
end
return num
end

function fightJunZhen:getJunZhenShowNum(total)
local jzConfigId=1
if self.battle and self.battle.stageInfo[stageInfoTag.mapID]then
local mapId=self.battle.stageInfo[stageInfoTag.mapID]
if mapId then
local stageCfg=fightModel:getStage(mapId)
if stageCfg and stageCfg.jzConfig then
jzConfigId=stageCfg.jzConfig
end
end
end
local numcfg=cfgHelper.get(cfg_jzbaseconfig_get,jzConfigId,"shownum")
local num=0
for i=#numcfg,1,-1 do
if total>=numcfg[i][1]then
num=numcfg[i][2]
break
end
end
return num
end



function fightJunZhen:onShow()
local isLeft=self:isLeft()

local total=self:getJunZhenNum()
local num=self:getJunZhenShowNum(total)


self.maxTotal=total

self.showPercent=num

self.delayShow=0.18*(isLeft and self.id-401 or self.id-406)

end

function fightJunZhen:showDelay()
local isLeft=self:isLeft()
local enterPos
if not isLeft then
self.LeftPos=fightModel:getPosInfo(self.id-5).pos
self.RightPos=fightModel:getPosInfo(self.id).pos
self:setRotation(Vector3.New(0,180,0))
self:setScaleVec3(Vector3.New(1,1,-1))

enterPos=self.RightPos
else
self.isInLeft=true
self.LeftPos=fightModel:getPosInfo(self.id).pos
self.RightPos=fightModel:getPosInfo(self.id+5).pos

enterPos=self.LeftPos
end

self.isDead=false

local enterType=self.baseInfo.oriTypo>0 and 0 or 1


if enterType==1 then
enterPos=isLeft and fightModel:transToBattleWorld(Vector3.New(-20,3.5,-12))or fightModel:transToBattleWorld(Vector3.New(20,3.5,-12))
end

self:playEffect(101,Vector3.New(isLeft and-2 or 2,0,0),false,true,Vector3.one)

fightManager.setEntityTroops(self.guid,self.baseInfo.entModel,self.showPercent,enterType,enterPos)
end

function fightJunZhen:getHitedPos()
if self.isInLeft then
return self:getPosition()+Vector3.New(-2,0,0)
else
return self:getPosition()+Vector3.New(2,0,0)
end

end


function fightJunZhen:runBehavior(btName,targets,_onBahaviroEvent)

self:stopBehavior()
self.isRunBehavior=true

local onEventListen=function(eventTypo,args)
self:onBehaviorEvent(eventTypo,args)
end

self.onBahaviroEvent=_onBahaviroEvent

if self.skipMode then
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
else
if self.battle and self.battle.isShowWindow then
self.fBTree:setSharedValue('targets',targets)
self.fBTree:setSharedValue('battle',self.battle)
self.fBTree:start(self,btName,onEventListen)
else
self:createSimBehavior()
end
end
end

function fightJunZhen:onHide()


end

local deathTimeLine={1.5,0.5,0.2,0.2,0.25,0.25,0.25,0.25,0.25,}

function fightJunZhen:update(deltaTime)
self._base.update(self,deltaTime)

if self.deathTimes and self.deathTimes>0 then
if self.deathTime<=0 then
local index=#deathTimeLine-self.deathTimes+1
fightManager.setJunZhengLiveProgress(self.guid,self.deathCount[index])
self.deathTime=deathTimeLine[index]
self.deathTimes=self.deathTimes-1
end
self.deathTime=self.deathTime-deltaTime
end

if self.delayShow then
self.delayShow=self.delayShow-deltaTime
if self.delayShow<=0 then
self:showDelay()
self.delayShow=nil
end
end
end

function fightJunZhen:initAttribute(update)
local atkTotal=0
local defTotal=0
local hpMaxTotal=0
local numTotal=0
for i,v in pairs(self.jzData)do
local num=v[2]
local qingshangNum=v[3]or 0
local zhongshangNum=v[4]or 0
local deadNum=v[5]or 0

local config=cfgHelper.get(cfg_jzconfig_get,v[1])

local atk=config.attack
local def=config.def

atkTotal=atkTotal+atk*num
defTotal=defTotal+def*num
hpMaxTotal=hpMaxTotal+num+qingshangNum+zhongshangNum+deadNum


numTotal=numTotal+num
end

self:setAttribute(entityAttr.max_hp,hpMaxTotal)
self:setAttribute(entityAttr.hp,numTotal)
self:setAttribute(entityAttr.attack,atkTotal)
self:setAttribute(entityAttr.def,defTotal)

if self.hud then
self.hud:setHP(numTotal,hpMaxTotal)
end

local oldTotal=self.showTotal
if update then
local oldPrecent=oldTotal/self.maxTotal
local deadprecent=(oldTotal-numTotal)/self.maxTotal

self.deathTimes=#deathTimeLine
self.deathTime=0
self.deathCount={}
local per=deadprecent/self.deathTimes
for i=1,self.deathTimes do
self.deathCount[i]=oldPrecent-per*i
end

end

self.showTotal=numTotal

if numTotal<=0 then
self:onDead()
end
end


function fightJunZhen:calcDemage(srcEnt)
local fight_param=cfgHelper.getdef(cfg_jzconfig,"fight_param")

local srcAtk=srcEnt:getAttribute(entityAttr.attack)
local def=self:getAttribute(entityAttr.def)

return srcAtk*(srcAtk/(srcAtk+def*fight_param[1])*fight_param[2])
end

function fightJunZhen:onRecvDamage(srcEnt)

local demage=self:calcDemage(srcEnt)

self:flowText(flowObjTypo.hp,{change=math.floor(demage)})


end

function fightJunZhen:onDead()
self.fBTree:stop()

self.isDead=true


end









function fightJunZhen:playMove3DEffect(effectid,srcEnt,dstPos,speed,onComplete,offsetStartRadiu,offsetEndRadiu,offsetStartPersent,offsetEndPersent,offsetStartAngle,offsetEndAngle,scale)
local offsetRadiu=math.random(offsetStartRadiu*100,offsetEndRadiu*100)
local offsetPersent=math.random(offsetStartPersent*100,offsetEndPersent*100)

local offsetAngle=math.random(offsetStartAngle,offsetEndAngle)
if not srcEnt.isInLeft then
offsetAngle=offsetAngle-180
end


local paras={[1]=4,[2]=speed*100,[3]=0,[4]=1,[5]=0,[6]=offsetRadiu,[7]=offsetPersent,[8]=offsetAngle}
local srcPos=srcEnt:getLogicPosition()
return fightManager.playMoveEffect(effectid,paras,srcPos,dstPos,onComplete,scale)
end

local sleepEffect=CS.GameInterface.SleepEffect
function fightJunZhen:playMoveEffect(effectid,endEffectID,srcEnt,dstPos,speed)
local effectEnt=CS.EntityManager.Instance:Add3DEntity(0,nil)
local moveEffectHandle=effectEnt:PlayEffect(effectid,fBTHelper.posOffset,Vector3.one,true,true)

local pos=srcEnt:getHitedPos()

effectEnt.transform.position=pos
local moveEnt=effectEnt
local handle=moveEffectHandle


local onHit=function()
if endEffectID~=-1 and endEffectID~=0 then
fightManager.playEffect(endEffectID,dstPos,false,Vector3.one)
end
if handle~=nil then
sleepEffect(handle,true)
handle=nil
end

if moveEnt~=nil then
CS.EntityManager.Instance:RemoveEntity(moveEnt.GUID,0.2)
moveEnt=nil
end
end

effectEnt:MoveTo(dstPos,true,Vector3.Distance(pos,dstPos)/speed,1,onHit)
end

function fightJunZhen:playRandomEffect(dstId)
local idx=math.random(1,5)
local func=effectEmitter[idx]
if func then
func(self,self,dstId)
end
end


function fightJunZhen:moveTo(pos,faceTo,duration,ease,onComplete)
if self.entObj~=nil then
self.entObj:MoveTo(pos,faceTo,duration,ease,onComplete)
end
end
