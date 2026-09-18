worldTripProgress_Experience=simple_class(worldTripProgress_Base)
worldTripProgress_Experience.name="worldTripProgress_Experience"

local speed=worldDispatchFactory.experienceSpeed

function worldTripProgress_Experience:__init(trip)
worldTripProgress_Base.__init(self,trip)
end

function worldTripProgress_Experience:start(time)
if#self.trip.disciples<=0 then return end

self:showDisciple(1,true)


local firstJob=UIDiscipleModel:getDiscipleJob(self.trip.disciples[1])
local id=tonumber(tostring(self.trip.target_id))
local moveList=worldTripMoveList_Experience.New(id,firstJob)

moveList:setRunMove(worldTripMove_NavMove.New(self.objects[1],{},speed,0))

moveList:setEffectMove(worldTripMove_EffectShow.New(self.objects[1],Vector3.zero,0,0,false))

moveList:setAnimationMove(worldTripMove_AnimationSitu.New(self.objects[1],Vector3.zero,0,0))

self.moves[1]=moveList

moveList.trigger=function(o,n)
if o==2 and n~=2 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if o~=2 and n==2 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
end

moveList:start()
end

function worldTripProgress_Experience:quit()
if self.objects[1]then
worldHUDModel:callHUDFunc(self.objects[1].Key,"showDragonBone",false)
end
worldTripProgress_Base.quit(self)
end

function worldTripProgress_Experience:onDiscipleChange(change)
local count=#self.trip.disciples

if count>0 and count-change<=0 then
local time=timeHelper.getServerShortTime()
self:start(time)
else
self:refreshDisclple(1)
end
end
