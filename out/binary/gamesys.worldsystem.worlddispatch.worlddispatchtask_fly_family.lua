worldDispatchTask_Fly_Family=simple_class(worldDispatchTask)
worldDispatchTask_Fly_Family.name="worldDispatchTask_Fly_Family"


function worldDispatchTask_Fly_Family:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_FlyTo.New(self),
[eWorldTripProgress.Work]=worldTripProgress_Family.New(self),
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_Family:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin+self.trip_duration
end

function worldDispatchTask_Fly_Family:onProgressChange(cState,oState)
if oState<=eWorldTripProgress.Work and cState>=eWorldTripProgress.Back then
worldXiuZhenJiaZuModel:showFightResult(self.target_guid)

end
if cState~=oState then
worldXiuZhenJiaZuController:refreshFamilyLeftWin(self.target_guid)
worldXiuZhenJiaZuController:refreshFamilyRightWin(self.target_guid)
end
end