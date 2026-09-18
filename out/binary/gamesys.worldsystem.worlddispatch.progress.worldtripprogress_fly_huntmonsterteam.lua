worldTripProgress_Fly_HuntMonsterTeam=simple_class(worldTripProgress_Base)
worldTripProgress_Fly_HuntMonsterTeam.name="worldTripProgress_Fly_HuntMonsterTeam"

local _minFightDuration=2

function worldTripProgress_Fly_HuntMonsterTeam:__init(trip)
worldTripProgress_Base.__init(self,trip)
end

function worldTripProgress_Fly_HuntMonsterTeam:start(time)
if#self.trip.disciples<=0 then return end


self.offset=worldDispatchFactory.flyTeamOffset[#self.trip.disciples]
self.flyHeight=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"maxAltitude")
self.horizontalLine=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"horizontalLine")
self.cloudHigher=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"cloudHigher")

for i,v in ipairs(self.trip.disciples)do
self:addMove(i)
end

if self.moves[1]then
local t=function(o,n,p)
self:onMoveStep(o,n,p)
end
self.moves[1]:addTrigger(t)
end

if huntMonsterTeamModel:getTeamData(self.trip.world)then
self:startNextPart()
end
end

function worldTripProgress_Fly_HuntMonsterTeam:quit()
self:hideTargetFightEffect()
worldTripProgress_Base.quit(self)
end

function worldTripProgress_Fly_HuntMonsterTeam:startNextPart(progress)
for i,v in ipairs(self.moves)do
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

self:hideTargetFightEffect()
self.targetObject=worldController:getUnit(currMonster)

self.corners={sPosition,tPosition}
self.flipX=tPosition.x<sPosition.x
local hNormal=tPosition-sPosition
hNormal.y=0
local pNormal=Vector3.Normalize(Vector3.Cross(hNormal,Vector3.up))
hNormal=Vector3.Normalize(hNormal)
local distance=worldDispatchFactory:getDistance(self.trip.mode,self.corners)
local otherDuration=#self.trip.disciples-1+worldDispatchFactory.flyJumpDuration+worldDispatchFactory.fadeDuration
local moveDuration=duration-otherDuration-_minFightDuration
local moveSpeed=distance/moveDuration
local minSpeed=worldDispatchFactory:getSpeed(self.trip.mode)
local effectDuration=_minFightDuration
if moveSpeed<minSpeed then
moveSpeed=minSpeed
moveDuration=distance/moveSpeed
effectDuration=duration-otherDuration-moveDuration
end
for i,v in ipairs(self.moves)do
local tPos=self.offset[i]*worldDispatchFactory.flyTeamOffsetUnit
local offset=pNormal*tPos.z+hNormal*tPos.x
local corners={sPosition+offset+Vector3.up*self.flyHeight,tPosition+offset}
local move=v:getMove(1)
move.position=sPosition
move=v:getMove(2)
move.position=sPosition
move.flipX=self.flipX
move=v:getMove(3)
move.corners=corners
move.duration=moveDuration
move.speed=moveSpeed
move=v:getMove(4)
move.position=tPosition
move=v:getMove(5)
move.position=tPosition
move=v:getMove(6)
move.position=tPosition
move.duration=effectDuration
v:start(fast)
end
end

function worldTripProgress_Fly_HuntMonsterTeam:addMove(index)
self:showDisciple(index,index==1,false,Vector3.zero)

local obj=self.objects[index]
local discipleGuid=self.trip.disciples[index]

local sInterval=math.ceil((index-1)/2)
local eInterval=math.floor(#self.trip.disciples/2)-sInterval

local moveList=worldTripMoveList.New()
local mount=worldDispatchFactory:getFlyMount(discipleGuid)
local flyAnim=worldDispatchFactory:getFlyAnim(discipleGuid)
local flyMountOffset=worldDispatchFactory:getFlyMountOffset(discipleGuid)
local mountSlot=mountHelper.getMountNode(discipleGuid)

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,sInterval))

moveList:addMove(worldTripMove_JumpShow.New(obj,Vector3.zero,self.flyHeight,nil,nil,nil,mount,flyAnim,flyMountOffset,mountSlot))

moveList:addMove(worldTripMove_FlyMove.New(obj,{},0,0,self.flyHeight,self.horizontalLine,self.cloudHigher,mount,flyAnim,flyMountOffset,mountSlot))

moveList:addMove(worldTripMove_GradientShow.New(obj,Vector3.zero,false,false))

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,eInterval))

moveList:addMove(worldTripMove_WaitHide.New(obj,Vector3.zero,0))

self.moves[index]=moveList
end

function worldTripProgress_Fly_HuntMonsterTeam:onMoveStep(o,n,p)
if n>=6 and n<7 then
self:showTargetFightEffect()
end



end

function worldTripProgress_Fly_HuntMonsterTeam:showTargetFightEffect()
if self.targetObject then
self.targetObject:StopModelEffect(worldDispatchFactory.fightEffect)
self.targetObject:ShowShadow(false)
self.targetObject:PlayModelEffect(worldDispatchFactory.fightEffect,Vector3.zero,Vector3.one)
self.targetObject:ChangeModelColor(Color.clear,0)
end
end

function worldTripProgress_Fly_HuntMonsterTeam:hideTargetFightEffect()
if self.targetObject then
self.targetObject:StopModelEffect(worldDispatchFactory.fightEffect)
self.targetObject:ShowShadow(true)
self.targetObject:ChangeModelColor(Color.white,0)
end
end

function worldTripProgress_Fly_HuntMonsterTeam:onDiscipleChange()
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
end

function worldTripProgress_Fly_HuntMonsterTeam:refreshDisclple(index)
worldTripProgress_Base.refreshDisclple(self,index)

local progress=self.moves[index].progress
if progress>=2 and progress<=3 then
local object=self.objects[index]
local cloudCfg=cfgHelper.get1(cfg_dbbodyconfig_get,worldDispatchFactory.flyMount)
local mountSlot=mountHelper.getMountNode(self.trip.disciples[index])or"root"
object:ChangeModelMount(worldDispatchFactory.flyMount,{},mountSlot,cloudCfg.scales and cloudCfg.scales[2]or 1,Vector3.zero)
end
end