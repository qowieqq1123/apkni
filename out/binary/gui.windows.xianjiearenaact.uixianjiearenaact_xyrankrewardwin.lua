







def_class("UIXianJieArenaAct_xyRankRewardWin",UIWindowBase)









function UIXianJieArenaAct_xyRankRewardWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.rewardsGroup=UIObject.get(self,4)
self.dropItem=UIObject.get(self,5)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJieArenaAct_xyRankRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardsGroup);self.rewardsGroup=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
end



















function UIXianJieArenaAct_xyRankRewardWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieArenaAct_xyRankRewardWin:__delete()
self:unbindComponents()
end




function UIXianJieArenaAct_xyRankRewardWin:onShow(argtable,afterOnloaded)
self.rLevel=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectRankLevel=self.rLevel
self:refresh()
end


function UIXianJieArenaAct_xyRankRewardWin:onHide()

end

function UIXianJieArenaAct_xyRankRewardWin:refresh()
self:refreshDropItem()
self:refreshReward()
end

function UIXianJieArenaAct_xyRankRewardWin:refreshDropItem()
if self.selectRankLevel>0 then

self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end

function UIXianJieArenaAct_xyRankRewardWin:refreshReward()
local rewards={}

local arenaRewardCfgList=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"settlementItems")
local arenaReward=arenaRewardCfgList and pfwindowsModel:getVersionAndPfCfg_severPf(arenaRewardCfgList)or nil

local rank=self.selectRankLevel
local rankCfg=cfgHelper.get(cfg_leitaiyanwuduanweiconfig_get,rank)
local rankRewardCfgList=rankCfg and rankCfg.jsItems or nil
local rankReward=rankRewardCfgList and pfwindowsModel:getVersionAndPfCfg_severPf(rankRewardCfgList)or nil
if rankReward then
for idx,v in ipairs(rankReward)do
local itemId=v[1]
local itemCount=v[2]
local weight=idx+10000
rewards[#rewards+1]={
itemId=itemId,
itemCount=itemCount,
weight=weight,
isRankRw=true,
}
end
end

if arenaReward then
for idx,v in ipairs(arenaReward)do
local itemId=v[1]
local itemCount=v[2]
local weight=idx
rewards[#rewards+1]={
itemId=itemId,
itemCount=itemCount,
weight=weight,
}
end
end







self.rewardsGroup:setChildLayoutGroupCreateItems(#rewards,function(index)
local widget=self.rewardsGroup:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
if reward then
widget:SetChildActive(-1,true)
local itemid=reward.itemId
local count=reward.itemCount
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

local isRankRw=reward.isRankRw or false
widget:SetChildActive(1,isRankRw)
else
widget:SetChildActive(-1,false)
end
end)
end


function UIXianJieArenaAct_xyRankRewardWin:onChangeLevel(level)
self.selectRankLevel=level
self:refreshReward()
end





function UIXianJieArenaAct_xyRankRewardWin:onClickMask()
self:onCloseBtn()
end



function UIXianJieArenaAct_xyRankRewardWin:onCloseBtn()
self:closeSelf()
end

function UIXianJieArenaAct_xyRankRewardWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end