









worldHUDShadow=simple_class(worldHUDBase)
worldHUDShadow.name="worldHUDShadow"

function worldHUDShadow:onCreate()
local cloud=self.data[2]
local cloudCfg=cfgHelper.get1(cfg_worldfogconfig_get,cloud)
self.world=cloudCfg.world
self.block=cloudCfg.block
self.max=worldExperienceModel:calculateCount(self.world,self.block)
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end


function worldHUDShadow:onUpdate()
local cur=worldExperienceModel:getProgress()

self.cmp:SetChildActive(0,cur<=self.max)
self.cmp:SetChildText(1,FMT.fmt("{0}/{1}",cur,self.max))
end
