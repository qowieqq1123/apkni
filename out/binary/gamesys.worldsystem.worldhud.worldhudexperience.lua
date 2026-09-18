









worldHUDExperience=simple_class(worldHUDBase)
worldHUDExperience.name="worldHUDExperience"








function worldHUDExperience:onCreate()
self.point=self.data[2]
self.pointCfg=cfgHelper.get1(cfg_experienceconfig_get,self.point)
local hudParam=self.pointCfg.hud[2]or{}
self.cmp:SetChildButtonClick(0,function()
worldExperienceController.onClickExperience(self.data)
end)
self.cmp:SetChildCSImageSprite(1,hudParam[1],hudParam[2])

worldHUDBase.onCreate(self)
end

function worldHUDExperience:onUpdate()
local point=worldExperienceModel:getCurrentPoint()
local state=worldExperienceModel:getCurrentState()
local isNext=point==self.point and state==eExperiencePonitState.Init
self.cmp:SetChildActive(0,isNext)
end