









worldHUDCloud=simple_class(worldHUDBase)
worldHUDCloud.name="worldHUDCloud"

function worldHUDCloud:onCreate()
local cloud=self.data[2]
local cloudCfg=cfgHelper.get1(cfg_worldfogconfig_get,cloud)
self.world=cloudCfg.world
self.block=cloudCfg.block
self.state=cloudCfg.state
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
if self.state==2 then
self.cmp:SetChildCanvasGroupAlpha(0,0)
self.cmp:SetChildCanvasGroupDOFade(0,1,1)
end
worldHUDBase.onCreate(self)
end

function worldHUDCloud:onUpdate()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,self.world,self.block)
if self.state==1 then
local show=worldBlockModel:isShowFogEffect(self.world,self.block)
self.cmp:SetChildActive(4,show)
if show then
local cost=blockCfg.consume and blockCfg.consume[1]or nil
self.cmp:SetChildActive(1,cost~=nil)
if cost then
self.cmp:SetChildIcon(2,iconHelper.getMoneyIconName(cost[1]),false)
self.cmp:SetChildText(3,cost[2])
end
end
else
local max=worldExperienceModel:getCount()
local cur=worldExperienceModel:getProgress()
self.cmp:SetChildText(1,FMT.fmt("{0}/{1}",cur,max))
end
end