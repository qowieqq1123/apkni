







def_class("UIWuXingDianStarRewardsWin",UIWindowBase)









function UIWuXingDianStarRewardsWin:bindComponents()

self.Content=UIObject.get(self,0)
self.desc=UIText.get(self,1)



end


function UIWuXingDianStarRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.desc);self.desc=nil;
end


















function UIWuXingDianStarRewardsWin:onLoaded(...)
self:bindComponents()
self.cfgs=cfg_fiveelementstemplestarconfig()
end

function UIWuXingDianStarRewardsWin:__delete()
self:unbindComponents()
end

function UIWuXingDianStarRewardsWin:onShow(argtable,afterOnloaded)
self:freshInfo()
end

function UIWuXingDianStarRewardsWin:onHide()

end




function UIWuXingDianStarRewardsWin:freshInfo()

local cfgs=cfg_fiveelementstemplestarconfig()
cfgs=table.deepCopy(cfgs)
local sortTag={}
for i,v in ipairs(cfgs)do
local id=v.id
local canPrize=wuXingDianModel:isCanPrizeStar(id)
local isPrize=wuXingDianModel:isPrizeStar(id)
local canPrizeTag=canPrize and 10000 or 0
local isPrizeTag=isPrize and-10000 or 0
sortTag[id]=canPrizeTag+isPrizeTag-i
end
table.sort(cfgs,function(a,b)
return sortTag[a.id]>sortTag[b.id]
end)
self.cfgs=cfgs
local len=#cfgs
self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),len,function(index)
self:fillItem(index)
end)
local star=wuXingDianModel:getAllStar()
self.desc:setText(FMT.fmt('<color=#7d3b17>当前通关总星数</color>：{0}',star))
end

function UIWuXingDianStarRewardsWin:fillItem(index)
local rewardsCfgs=self.cfgs
local cfg=rewardsCfgs[index]
local id=cfg.id
local star=cfg.star
local rewards=cfg.rewards
local canPrize=wuXingDianModel:isCanPrizeStar(id)
local isPrize=wuXingDianModel:isPrizeStar(id)

local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
widget:SetChildText(0,star)

widget:SetChildLayoutGroupCreateItems(1,#rewards,function(i)
local data={}
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(1,i-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
widget1:SetChildActive(1,isPrize)
widget1:SetChildActive(2,false)
widget1:SetChildActive(3,isPrize)
end)
widget:SetChildActive(2,canPrize)
widget:SetChildButtonClick(2,function()
socketManager:send_25_20()
end)
widget:SetChildActive(3,isPrize)
widget:SetChildActive(4,not canPrize and not isPrize)
end
