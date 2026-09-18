worldDispatchTask_Run_ResMystery=simple_class(worldDispatchTask)
worldDispatchTask_Run_ResMystery.name="worldDispatchTask_Run_ResMystery"


function worldDispatchTask_Run_ResMystery:express()
local work=worldTripProgress_Empty.New(self)
local tagId=tonumber(self.target_id)
local data=mysteryZiYuanFuBenModel:getGroupFbData(tagId)
if data then



work=worldTripProgress_ResMystery.New(self)

end

self.expression={
[eWorldTripProgress.Work]=work,
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}
end


function worldDispatchTask_Run_ResMystery:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end
