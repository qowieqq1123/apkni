worldTripProgress_Run_HuntMonsterTeam=simple_class(worldTripProgress_Base)
worldTripProgress_Run_HuntMonsterTeam.name="worldTripProgress_Run_HuntMonsterTeam"

local _minFightDuration=2

function worldTripProgress_Run_HuntMonsterTeam:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.speMoves={}
end

function worldTripProgress_Run_HuntMonsterTeam:start(time)
if#self.trip.disciples<=0 then return end

for i,v in ipairs(self.trip.disciples)do
self:addMove(i)
end

if self.moves[1]then
local t=function(o,n,p)
self:onMoveStep(o,n,p)
end
self.moves[1]:addTrigger(t)
end

if self.speMoves[1]then
local t=function(o,n,p)
self:onSpeMoveStep(o,n,p)
end
self.speMoves[1]:addTrigger(t)
end

if huntMonsterTeamModel:getTeamData(self.trip.world)then
self:startNextPart()
end
end

function worldTripProgress_Run_HuntMonsterTeam:quit()
self:hideTargetFightEffect()
worldTripProgress_Base.quit(self)
for i,v in pairs(self.moves)do
v:quit()
end
self.speMoves={}
end

function worldTripProgress_Run_HuntMonsterTeam:addMove(index)
self:showDisciple(index,index==1,false,Vector3.zero)

local obj=self.objects[index]

local moveList=worldTripMoveList.New()

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,index-1))

moveList:addMove(worldTripMove_GradientShow.New(obj,Vector3.zero,true,true))

moveList:addMove(worldTripMove_NavMove.New(obj,{},0,0))

moveList:addMove(worldTripMove_GradientShow.New(obj,Vector3.zero,false,false))

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,#self.trip.disciples-index))

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,0))

self.moves[index]=moveList

moveList=worldTripMoveList.New()

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,0))

self.speMoves[index]=moveList
end

function worldTripProgress_Run_HuntMonsterTeam:startNextPart(progress)

for i,v in ipairs(self.moves)do
v:quit()
end
for i,v in ipairs(self.speMoves)do
v:quit()
end

local teamData=huntMonsterTeamModel:getTeamData(self.trip.world)
progress=progress or teamData.progress
if#teamData.times<progress then
return
end
local prevSegTime=teamData.times[progress-1]or 0
local duration=teamData.times[progress]-prevSegTime
local fast=timeHelper.getServerShortTime()-teamData.sinceTime-prevSegTime
local currMonster=teamData.monsters[teamData.progress]
local tPosition,tBlock,tWorld=huntMonsterTeamModel:getMonsterPosition(currMonster)
local sPosition=teamData.positions[teamData.progress-1]or worldController:getMainCityPosition(tWorld,tBlock)
local cslist=worldController:calculateNavPathEx(sPosition,tPosition)
self:hideTargetFightEffect()
self.targetObject=worldController:getUnit(currMonster)
if cslist==nil then
loggerUtil.logErrFMT("无效路径的起始点和终止点 {0}, {1}",tostring(sPosition),tostring(tPosition))
self:showTargetFightEffect()
for i,v in ipairs(self.speMoves)do
local move=v:getMove(1)
move.position=tPosition
move.duration=duration
v:start(fast)
end

return
end
self.corners={}
for i=0,cslist.Length-1 do
table.insert(self.corners,cslist[i])
end
local distance=worldDispatchFactory:getDistance(self.trip.mode,self.corners)
local otherDuration=#self.trip.disciples-1+worldDispatchFactory.fadeDuration*2
local moveDuration=duration-otherDuration-_minFightDuration
local moveSpeed=distance/moveDuration
local minSpeed=worldDispatchFactory:getSpeed(self.trip.mode)
local effectDuration=_minFightDuration
if moveSpeed<minSpeed then
moveSpeed=minSpeed
moveDuration=distance/moveSpeed
effectDuration=duration-otherDuration-moveDuration
end
local startPos=self.corners[1]
local endPos=self.corners[#self.corners]

for i,v in ipairs(self.moves)do
local move=v:getMove(1)
move.position=startPos
move=v:getMove(2)
move.position=startPos
move=v:getMove(3)
move.corners=self.corners
move.duration=moveDuration
move.speed=moveSpeed
move=v:getMove(4)
move.position=endPos
move=v:getMove(5)
move.position=endPos
move=v:getMove(6)
move.position=endPos
move.duration=effectDuration
v:start(fast)
end

end

function worldTripProgress_Run_HuntMonsterTeam:onMoveStep(o,n,p)
if n<5 and o<=1 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if n>=5 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if n>=6 and n<7 then
self:showTargetFightEffect()
end



end

function worldTripProgress_Run_HuntMonsterTeam:showTargetFightEffect()
if self.targetObject then
self.targetObject:StopModelEffect(worldDispatchFactory.fightEffect)
self.targetObject:ShowShadow(false)
self.targetObject:PlayModelEffect(worldDispatchFactory.fightEffect,Vector3.zero,Vector3.one)
self.targetObject:ChangeModelColor(Color.clear,0)
end
end

function worldTripProgress_Run_HuntMonsterTeam:hideTargetFightEffect()
if self.targetObject then
self.targetObject:StopModelEffect(worldDispatchFactory.fightEffect)
self.targetObject:ShowShadow(true)
self.targetObject:ChangeModelColor(Color.white,0)
end
end

function worldTripProgress_Run_HuntMonsterTeam:onSpeMoveStep(o,n,p)
if n>1 then
self:hideTargetFightEffect()
end
end

function worldTripProgress_Run_HuntMonsterTeam:onDiscipleChange()
local newCnt=#self.trip.disciples
local nowCnt=#self.objects
local delta=newCnt-nowCnt

if delta>0 then
for i=1,delta do
local index=nowCnt+1
self:showDisciple(index,index==1)
end
else
for i=-1,delta,-1 do
local index=nowCnt+i+1
self:hideDisciple(index)
end
end

for i,v in ipairs(self.objects)do
self:refreshDisclple(i)
end

for i=#self.moves,#self.objects do
self:addMove(i)
end

for i=#self.objects+1,#self.moves do
local move=self.moves[i]
move:quit()
self.moves[i]=nil
end

for i=#self.objects+1,#self.speMoves do
local move=self.speMoves[i]
move:quit()
self.speMoves[i]=nil
end
end
