worldDispatchTask_Run_Family=simple_class(worldDispatchTask)
worldDispatchTask_Run_Family.name="worldDispatchTask_Run_Family"


function worldDispatchTask_Run_Family:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_RunTo.New(self),
[eWorldTripProgress.Work]=worldTripProgress_Family.New(self),
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}



end


function worldDispatchTask_Run_Family:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin+self.trip_duration
end

function worldDispatchTask_Run_Family:onProgressChange(cState,oState)
if oState<=eWorldTripProgress.Work and cState>=eWorldTripProgress.Back then
worldXiuZhenJiaZuModel:showFightResult(self.target_guid)

end
if cState~=oState then
worldXiuZhenJiaZuController:refreshFamilyLeftWin(self.target_guid)
worldXiuZhenJiaZuController:refreshFamilyRightWin(self.target_guid)
end
end