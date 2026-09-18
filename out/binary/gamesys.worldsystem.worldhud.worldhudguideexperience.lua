









worldHUDGuideExperience=simple_class(worldHUDBase)
worldHUDGuideExperience.name="worldHUDGuideExperience"

function worldHUDGuideExperience:onCreate()
self.point=self.data[2]
self.pointCfg=cfgHelper.get1(cfg_experienceconfig_get,self.point)
local hudParam=pointCfg.hud[2]
self.showTime=hudParam[2]
self.hideTime=hudParam[3]
self.cmp:SetChildText(0,hudParam[1])

worldHUDBase.onCreate(self)
end

function worldHUDGuideExperience:onUpdate()
local point=worldExperienceModel:getCurrentPoint()
local state=worldExperienceModel:getCurrentState()
local isNext=point==self.point and state==eExperiencePonitState.Init
self.cmp:SetChildActive(1,isNext)
if isNext then
self.timer=timer.new()
self.cd=math.random(-self.hideTime,self.showTime)
self.cmp:SetChildCanvasGroupAlpha(1,self.cd>=0 and 1 or 0)
self.timer:start(1,function()self:onTick()end,-1)
else
self:stopTick()
end
end

function worldHUDGuideExperience:onDestory()
self:stopTick()
end

function worldHUDGuideExperience:startTick()
end

function worldHUDGuideExperience:stopTick()
if self.timer then
self.timer:cancel()
self.timer=nil
end
end

function worldHUDGuideExperience:onTick()
local n=self.cd-1
if n<-self.hideTime then
self.cd=self.showTime
self.cmp:SetChildCanvasGroupDOFade(1,1,0.5,nil)
else
if n<0 and self.cd>=0 then
self.cmp:SetChildCanvasGroupDOFade(1,0,0.5,nil)
end
self.cd=n
end
end