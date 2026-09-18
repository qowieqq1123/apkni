worldDispatchTask_Fly_ResPointMonster=simple_class(worldDispatchTask)
worldDispatchTask_Fly_ResPointMonster.name="worldDispatchTask_Fly_ResPointMonster"


function worldDispatchTask_Fly_ResPointMonster:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_FlyTo_Monster.New(self),
[eWorldTripProgress.Work]=worldTripProgress_ResPointMonster.New(self),
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_ResPointMonster:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin+self.trip_duration
end

function worldDispatchTask_Fly_ResPointMonster:onProgressChange(cState,oState)
if oState==nil or oState<=eWorldTripProgress.Work then
if cState>=eWorldTripProgress.Back then
if self.show then

else
worldResPointFightModel:clearFightResult(self.target_guid,self.target_id)
end
end
end
end