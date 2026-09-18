worldTripMoveList_Experience=simple_class(worldTripMoveList)
worldTripMoveList_Experience.name="worldTripMoveList_Experience"

local moveType={
Move=1,
Effect=2,
Animation=3,
}

function worldTripMoveList_Experience:__init(fog,job)
worldTripMoveList.__init(self)
self.fog=fog

self.fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,fog)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,self.fogCfg.world,self.fogCfg.block)
self.pointList=blockCfg.eWanderPoints
self.aiCfg=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"experienceWeight")
self.aiWeight=0
for i,v in ipairs(self.aiCfg)do
self.aiWeight=self.aiWeight+v[3]
end
end

function worldTripMoveList_Experience:start(fast)
local random=math.random(0,1)
local index=math.random(1,#self.pointList)
if random>0 and#self.pointList>1 then
self:startRun(index)
else
self.startIdx=index
self.endIdx=index
self:startStay()
end
end

function worldTripMoveList_Experience:onStep(pass)
self:quit()
if self.progress>1 and#self.pointList>1 then
self:startRun(self.endIdx)
else
self:startStay()
end
end

function worldTripMoveList_Experience:setRunMove(move)
move.callback=function(pass)
self:onStep(pass)
end
self.list[moveType.Move]=move
end

function worldTripMoveList_Experience:setAnimationMove(move)
move.callback=function(pass)
self:onStep(pass)
end
self.list[moveType.Animation]=move
end

function worldTripMoveList_Experience:setEffectMove(move)
move.callback=function(pass)
self:onStep(pass)
end
self.list[moveType.Effect]=move
end

function worldTripMoveList_Experience:getRunMove()
return self.list[moveType.Move]
end

function worldTripMoveList_Experience:getEffectMove()
return self.list[moveType.Effect]
end

function worldTripMoveList_Experience:getAnimationMove()
return self.list[moveType.Animation]
end

function worldTripMoveList_Experience:startRun(index)

self:setProgress(moveType.Move)

self.startIdx=index
local bPoint=mathHelper.convertArrayToVector(self.pointList[self.startIdx])

local r=math.random(1,#self.pointList-1)
self.endIdx=r<self.startIdx and r or(r+1)
local ePoint=mathHelper.convertArrayToVector(self.pointList[self.endIdx])

local corners=worldDispatchFactory:getPathCorners(eWorldTripType.Run,ePoint,bPoint,self.fogCfg.world)
local duration=worldDispatchFactory:getDuration(eWorldTripType.Run,corners,worldDispatchFactory.experienceSpeed)

local runMove=self.list[moveType.Move]
runMove.corners=corners
runMove.duration=duration
runMove:start(0)
end

function worldTripMoveList_Experience:startStay()
local point=self.pointList[self.endIdx]
local position=worldPositionConfig:getPosition_CurrentWorld(point)

local stayCfg=self:randomStay()
if stayCfg[1]==1 then
self:startAnimtion(position,stayCfg[2])
else
self:startEffect(position,stayCfg[2])
end
end

function worldTripMoveList_Experience:randomStay()
local r=math.random(self.aiWeight)
local sum=0
for i,v in ipairs(self.aiCfg)do
sum=sum+v[3]
if r<=sum then
return v
end
end
return self.aiCfg[1]
end

function worldTripMoveList_Experience:startAnimtion(pos,info)


self:setProgress(moveType.Animation)

local animation=info[1]
local timeInfo=info[2]
local duration=#timeInfo==2 and math.random(timeInfo[1],timeInfo[2])or timeInfo[1]

local move=self.list[moveType.Animation]
move.position=pos
move.duration=duration
move.animation=animation
move:start(0)
end

function worldTripMoveList_Experience:startEffect(pos,info)

self:setProgress(moveType.Effect)

local effect=info[1]
local timeInfo=info[2]
local duration=#timeInfo==2 and math.random(timeInfo[1],timeInfo[2])or timeInfo[1]

local move=self.list[moveType.Effect]
move.position=pos
move.duration=duration
move.effect=effect
move:start(0)
end
