worldDispatchTask_Fly_Experience=simple_class(worldDispatchTask)
worldDispatchTask_Fly_Experience.name="worldDispatchTask_Fly_Experience"

function worldDispatchTask_Fly_Experience:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_Experience.New(self),
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_Experience:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end

function worldDispatchTask_Fly_Experience:back()
if self.progress_state>=eWorldTripProgress.Back then
return
end
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,self.target_id)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,fogCfg.world,fogCfg.block)
if blockCfg.eAutoReturn then
worldDispatchTask.back(self)
self:cancel()
else
if self.show then
local point=worldExperienceModel:getCurrentPoint()
local pos=blockCfg.eTaskPos
if point then
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
pos=pointCfg.disciplinePos
end
self.x=math.floor(pos[1]*100)
self.z=math.floor(pos[2]*100)
self.destination=mathHelper.convertArrayToVector(pos)
self:path()
self.expression[eWorldTripProgress.Back].duration=math.ceil(self.trip_duration)
end

worldDispatchTask.back(self)
end
end

function worldDispatchTask_Fly_Experience:correct()
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,self.target_id)
local check=worldBlockModel:checkBlockState(fogCfg.world,fogCfg.block,eWorldBlockState.UNLOCK)
if self.progress_state==eWorldTripProgress.Work and not check then
self:back()
end
end