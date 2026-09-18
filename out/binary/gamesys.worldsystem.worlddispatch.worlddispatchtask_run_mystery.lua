worldDispatchTask_Run_Mystery=simple_class(worldDispatchTask)
worldDispatchTask_Run_Mystery.name="worldDispatchTask_Run_Mystery"


function worldDispatchTask_Run_Mystery:express()
local work=worldTripProgress_Empty.New(self)
local typo=MysteryModel:get_mystery_sence_type(self.target_id)
if typo==MysterySenceType.World then
work=worldTripProgress_Mystery.New(self)
elseif typo==MysterySenceType.ResPoint then
work=worldTripProgress_ResPointMystery.New(self)
elseif typo==MysterySenceType.ZiYuan then
work=worldTripProgress_ResMystery.New(self)
end
self.expression={
[eWorldTripProgress.Work]=work,
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}
end


function worldDispatchTask_Run_Mystery:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end