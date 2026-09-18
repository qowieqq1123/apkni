







def_class("UIMingYuanZhuSha_DiffRewardWin",UIWindowBase)









function UIMingYuanZhuSha_DiffRewardWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.number=UIText.get(self,2)
self.packScrollerView=UIObject.get(self,3)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIMingYuanZhuSha_DiffRewardWin")end)



end


function UIMingYuanZhuSha_DiffRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.number);self.number=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
end
















local _this




function UIMingYuanZhuSha_DiffRewardWin:onLoaded(...)
self:bindComponents()

_this=self

myzsController.reqNewPassCount()

local _recv_13_36=function()
if _this==nil then return end
_this:onRefreshPanel()
end
self:addProNotify(13,36,_recv_13_36)
end


function UIMingYuanZhuSha_DiffRewardWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_DiffRewardWin:onShow(argtable,afterOnloaded)

local layer=argtable.layer
self.diffLevel=argtable.diffLevel

local levelInfo=myzsModel:getlevelConf(layer)

self.rewards=levelInfo.rewards
self.difficulty_rewards=levelInfo.difficulty_rewards

self.allCfg=cfg_mingyuanzhushadifficultyconfig()

self:onRefreshPanel()
end


function UIMingYuanZhuSha_DiffRewardWin:onHide()

end

function UIMingYuanZhuSha_DiffRewardWin:onRefreshPanel()


local len=#self.difficulty_rewards

self.packScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(2,FMT.fmt("{0}阶",i))

item:SetChildActive(4,self.diffLevel==i)

local exRewards=self.difficulty_rewards[i]or defaultT
local newRewards=exRewards


table.sort(newRewards,function(a,b)
local aVal=itemsConfig.getConfig(a[1]).color
local bVal=itemsConfig.getConfig(b[1]).color
return aVal>bVal
end)

item:SetChildScrollViewCreateGrids(3,#newRewards,#newRewards)
local grids=item:GetChildScrollViewItemWidgets(3)
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=newRewards[i+1]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
reward.showStage=true
widgetHelper.setNormalRewardItem(item,2,reward)
end
end
end

if self.diffLevel>=len then
self.number:setText("当前已是最高难度")
else
local number=myzsModel:getDiffPassCount()
local num=self.allCfg[self.diffLevel].max_level_actor_cnt-number
if num>0 then
self.number:setText(FMT.fmt("距离提升下一难度还需<color=#ca631d>{0}</color>人通关冥渊诛煞",self.allCfg[self.diffLevel].max_level_actor_cnt-number))
else
self.number:setText("已满足条件，下期将提升1阶难度")
end
end

end


