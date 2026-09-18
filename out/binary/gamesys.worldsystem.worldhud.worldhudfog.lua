









worldHUDFog=simple_class(worldHUDBase)
worldHUDFog.name="worldHUDFog"

local cmpKid={
enoughBtn=0,
cost=1,
icon=2,
num=3,
enoughRoot=4,
notEnoughRoot=5,
notEnoughBtn=6,
nameImage1=7,
nameImage2=8,
effect=9,
root=10,
this=11,
}

function worldHUDFog:onCreate()
self.cloud=self.data[2]
self.cloudCfg=cfgHelper.get1(cfg_worldfogconfig_get,self.cloud)
self.world=self.cloudCfg.world
self.block=self.cloudCfg.block
self.blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,self.world,self.block)
self.cmp:SetChildButtonClick(cmpKid.enoughBtn,function()

UIManager:showWindow("UIWorldBlockUnlockWin",{world=self.world,block=self.block})
end)
self.cmp:SetChildButtonClick(cmpKid.notEnoughBtn,function()

UIManager:showWindow("UIWorldBlockUnlockWin",{world=self.world,block=self.block})
end)

self.cmp:SetChildCSImageSprite(cmpKid.nameImage1,"ui/windows/world/sharedtextures/dashijie_component_altas.ab",self.blockCfg.nameImage)
self.cmp:SetChildCSImageSprite(cmpKid.nameImage2,"ui/windows/world/sharedtextures/dashijie_component_altas.ab",self.blockCfg.nameImage)

self.cmp:SetChildWeakGuideComponentId(cmpKid.enoughRoot,FMT.fmt("UIWorldHUDWin.worldHUDFog_{0}.#Enough",self.cloud))

self.cmp:SetChildActive(cmpKid.effect,true)

local size=CS.CSGUIManager.Instance:GetUICanvas(1).sizeDelta
local size=size/2
local range=Vector4.New(-size.x,-size.y,size.x,size.y-75)
self.cmp:SetChildScreenRangeShow(cmpKid.this,range,function(check)
self.cmp:SetChildActive(cmpKid.root,check)

self.cmp:ForceLayoutRect(cmpKid.cost)
end)

worldHUDBase.onCreate(self)
end

function worldHUDFog:onVisible(visible)

self.cmp:SetChildActive(cmpKid.effect,visible)
end

function worldHUDFog:onUpdate()

local can,code=worldBlockModel:canUnlockBlock(self.world,self.block)
local enough=worldBlockModel:isUnLockEnoughCondition(self.world,self.block)
local show=can and enough

if show then
self:showUnlock()
self.cmp:SetChildActive(cmpKid.notEnoughRoot,false)
else
self:showLock(code)
end
self.cmp:SetChildActive(cmpKid.enoughRoot,show)

end

function worldHUDFog:showUnlock()
local cost=self.blockCfg.consume and self.blockCfg.consume[1]or nil
self.cmp:SetChildActive(cmpKid.cost,cost~=nil)
if cost then
self.cmp:SetChildIcon(cmpKid.icon,iconHelper.getMoneyIconName(cost[1]),false)
self.cmp:SetChildText(cmpKid.num,cost[2])

self.cmp:ForceLayoutRect(cmpKid.cost)
end
end

function worldHUDFog:showLock(code)

if code>0 then
local show=self.blockCfg.cloud==worldBlockModel:getSelectFog()
self.cmp:SetChildActive(cmpKid.notEnoughRoot,show)
else
self.cmp:SetChildActive(cmpKid.notEnoughRoot,true)
end









end