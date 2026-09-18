worldDispatchTask_Fly_ResMystery=simple_class(worldDispatchTask)
worldDispatchTask_Fly_ResMystery.name="worldDispatchTask_Fly_ResMystery"


function worldDispatchTask_Fly_ResMystery:express()
local work=worldTripProgress_Empty.New(self)
local tagId=tonumber(self.target_id)
local data=mysteryZiYuanFuBenModel:getGroupFbData(tagId)
if data then



work=worldTripProgress_ResMystery.New(self)

end
self.expression={
[eWorldTripProgress.Work]=work,
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_ResMystery:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end
