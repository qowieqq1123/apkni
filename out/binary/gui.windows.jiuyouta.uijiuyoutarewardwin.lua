







def_class("UIJiuYouTaRewardWin",UIWindowBase)









function UIJiuYouTaRewardWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.number=UIText.get(self,2)
self.packScrollerView=UIObject.get(self,3)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIJiuYouTaRewardWin")end)



end


function UIJiuYouTaRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.number);self.number=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
end



















function UIJiuYouTaRewardWin:onLoaded(...)
self:bindComponents()
JiuYouTaController.req_rank_list()
local onRankListRefresh=function()
self:onRefreshDiff()
end
self:addNotify(notifyConfig.onRankListRefresh,onRankListRefresh)

local cfg=cfg_jiuyoutalayerconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
self.rankCfg=cfg[rankType]

end


function UIJiuYouTaRewardWin:__delete()
self:unbindComponents()
end




function UIJiuYouTaRewardWin:onShow(argtable,afterOnloaded)
local layer=argtable.layer
self.layerCfg=self.rankCfg[layer]

self:onRefreshPanel()
end


function UIJiuYouTaRewardWin:onHide()

end

function UIJiuYouTaRewardWin:onRefreshPanel()

local rewards={}
local rating=JiuYouTaModel:getJiuYouTaRating()



local number=JiuYouTaModel:getJiuYouTaClearNumber()
local cfg=cfg_jiuyoutalayelevelrconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local rankCfg=cfg[rankType]

self.packScrollerView:setChildScrollViewCreateGrids(#rankCfg,1)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rankCfg[i]
item:SetChildText(2,data.name)

item:SetChildActive(4,rating==i)

local exRewards=self.layerCfg.pass_ex_reward[i]or defaultT
local newRewards=attrListHelper.concatList(rewards,exRewards)

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

if rating>=#rankCfg then
self.number:setText("当前已是最高难度")
else
local num=rankCfg[rating+1].max_layer_actor_cnt-number
if num>0 then
self.number:setText(FMT.fmt("距离提升下一难度还需<color=#ca631d>{0}</color>人通关九幽塔",rankCfg[rating+1].max_layer_actor_cnt-number))
else
self.number:setText("已满足条件，下期将提升1级难度")
end
end

end

function UIJiuYouTaRewardWin:onRefreshDiff()

local rating=JiuYouTaModel:getJiuYouTaRating()
local number=JiuYouTaModel:getJiuYouTaClearNumber()
local cfg=cfg_jiuyoutalayelevelrconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local rankCfg=cfg[rankType]

local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(4,rating==i)
end

if rating>=#rankCfg then
self.number:setText("当前已是最高难度")
else
local num=rankCfg[rating+1].max_layer_actor_cnt-number
if num>0 then
self.number:setText(FMT.fmt("距离提升下一难度还需<color=#ca631d>{0}</color>人通关九幽塔",rankCfg[rating+1].max_layer_actor_cnt-number))
else
self.number:setText("已满足条件，下期将提升1级难度")
end
end

end


