worldTripProgress_RunBack=simple_class(worldTripProgress_Base)
worldTripProgress_RunBack.name="worldTripProgress_RunBack"

function worldTripProgress_RunBack:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.duration=math.ceil(self.trip.trip_duration)
end

function worldTripProgress_RunBack:start(time)
if#self.trip.disciples<=0 then return end

for i,v in ipairs(self.trip.disciples)do


self:addMove(i)
end

self:addTrigger()

worldTripProgress_Base.start(self,time)
end

function worldTripProgress_RunBack:addTrigger()
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

function worldTripProgress_RunBack:addMove(index)
local startPos=self.trip.corners[#self.trip.corners]
local endPos=self.trip.corners[1]

self:showDisciple(index,index==1,false,startPos)

local obj=self.objects[index]

local moveList=worldTripMoveList.New()

moveList:addMove(worldTripMove_WaitHide.New(obj,startPos,index-1))

moveList:addMove(worldTripMove_GradientShow.New(obj,startPos,true,false))

moveList:addMove(worldTripMove_NavMove.New(obj,table.reverse(self.trip.corners),self.trip.speed,self.trip.move_duration))

moveList:addMove(worldTripMove_GradientShow.New(obj,endPos,false,true))

moveList:addMove(worldTripMove_WaitHide.New(obj,endPos,#self.trip.disciples-index))

self:addStepChange(moveList)

self.moves[index]=moveList
end

function worldTripProgress_RunBack:addStepChange(moveList)

end

function worldTripProgress_RunBack:onDiscipleChange()
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