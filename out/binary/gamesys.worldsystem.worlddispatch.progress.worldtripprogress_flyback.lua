worldTripProgress_FlyBack=simple_class(worldTripProgress_Base)
worldTripProgress_FlyBack.name="worldTripProgress_FlyBack"

function worldTripProgress_FlyBack:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.duration=math.ceil(self.trip.trip_duration)
end

function worldTripProgress_FlyBack:start(time)
self.flipX=self.trip.corners[#self.trip.corners].x<self.trip.corners[1].x
self.offset=worldDispatchFactory.flyTeamOffset[#self.trip.disciples]
self.flyHeight=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"maxAltitude")
self.horizontalLine=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"horizontalLine")
self.cloudHigher=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"cloudHigher")

self.hNormal=self.trip.corners[1]-self.trip.corners[#self.trip.corners]
self.hNormal.y=0
self.pNormal=Vector3.Normalize(Vector3.Cross(self.hNormal,Vector3.up))
self.hNormal=Vector3.Normalize(self.hNormal)

for i,v in ipairs(self.trip.disciples)do


self:addMove(i)
end

self:addTrigger()

worldTripProgress_Base.start(self,time)
end

function worldTripProgress_FlyBack:addStepChange(moveList)

end

function worldTripProgress_FlyBack:addTrigger()
if self.moves[1]then
local t=function(o,n)
if n<5 and o<=1 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if n>=5 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
end
self.moves[1]:addTrigger(t)
end
end

function worldTripProgress_FlyBack:addMove(index)
local tPos=self.offset[index]*worldDispatchFactory.flyTeamOffsetUnit
local sPos=self.trip.corners[#self.trip.corners]
local ePos=self.trip.corners[1]

local offset=self.pNormal*tPos.z+self.hNormal*tPos.x
local startPos=sPos+offset
local endPos=ePos+offset
local corners={startPos+Vector3.up*self.flyHeight,endPos}

self:showDisciple(index,index==1,false,startPos)

local obj=self.objects[index]
local discipleGuid=self.trip.disciples[index]

local sInterval=math.ceil((index-1)/2)
local eInterval=math.floor(#self.trip.disciples/2)-sInterval


local moveList=worldTripMoveList.New()
local mount=worldDispatchFactory:getFlyMount(discipleGuid)
local flyAnim=worldDispatchFactory:getFlyAnim(discipleGuid)
local flyMountOffset=worldDispatchFactory:getFlyMountOffset(discipleGuid)
local mountSlot=mountHelper.getMountNode(discipleGuid)

moveList:addMove(worldTripMove_WaitHide.New(obj,startPos,sInterval))

moveList:addMove(worldTripMove_JumpShow.New(obj,startPos,self.flyHeight,self.flipX,nil,nil,mount,flyAnim,flyMountOffset,mountSlot))

moveList:addMove(worldTripMove_FlyMove.New(obj,corners,self.trip.speed,self.trip.move_duration,self.flyHeight,self.horizontalLine,self.cloudHigher,mount,flyAnim,flyMountOffset,mountSlot))

moveList:addMove(worldTripMove_GradientShow.New(obj,endPos,false,false))

moveList:addMove(worldTripMove_WaitHide.New(obj,endPos,eInterval))

self:addStepChange(moveList)

self.moves[index]=moveList
end


function worldTripProgress_FlyBack:onDiscipleChange()
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

self.offset=worldDispatchFactory.flyTeamOffset[newCnt]
for i=#self.moves,#self.objects do
self:addMove(i)
end

for i=#self.objects+1,#self.moves do
local move=self.moves[i]
move:quit()
self.moves[i]=nil
end
end

function worldTripProgress_FlyBack:refreshDisclple(index)
worldTripProgress_Base.refreshDisclple(self,index)
local progress=self.moves[index].progress
if progress>=2 and progress<=3 then
local object=self.objects[index]
local cloudCfg=cfgHelper.get1(cfg_dbbodyconfig_get,worldDispatchFactory.flyMount)
local mountSlot=mountHelper.getMountNode(self.trip.disciples[index])or"root"
object:ChangeModelMount(worldDispatchFactory.flyMount,{},mountSlot,cloudCfg.scales and cloudCfg.scales[2]or 1,Vector3.zero)
end
end