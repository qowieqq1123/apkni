







def_class("UIXianJieArenaAct_rankRewardListWin",UIWindowBase)









function UIXianJieArenaAct_rankRewardListWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rankScrollView=UILoopListView.new(self,2)
self.dropItem=UIObject.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXianJieArenaAct_rankRewardListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
end
















local rankItemCmpIndex={
bg=0,
rankText=1,
rewardScrollView=2,
}



function UIXianJieArenaAct_rankRewardListWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieArenaAct_rankRewardListWin:__delete()
local win=UIManager:findActiveWindow("UIXingYu_JYZFLevelDropDownWin")
if win and self.originalDropDownParent then
win.parent=self.originalDropDownParent
end
self:unbindComponents()
end




function UIXianJieArenaAct_rankRewardListWin:onShow(argtable,afterOnloaded)
self.rankType=argtable and argtable.rankType
self.rLevel=JiuYuZhengFengModel:getData_rank_level()or 0

local win=UIManager:findActiveWindow("UIXingYu_JYZFLevelDropDownWin")
if win then
self.selectRankLevel=win.levelSIndex
else
self.selectRankLevel=self.rLevel
end
self:refresh()
self:refreshDropItem()
end


function UIXianJieArenaAct_rankRewardListWin:onHide()

end

function UIXianJieArenaAct_rankRewardListWin:refresh()
local rankType=self.rankType
local rewardCfg_pf
if rankType==LTYW_Rank_Type.ePersonRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards1")
elseif rankType==LTYW_Rank_Type.eXianMengRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards3")
elseif rankType==LTYW_Rank_Type.eZhanYunRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards2")
end

self.rewardCfgList=pfwindowsModel:getVersionAndPfCfg_severPf(rewardCfg_pf)
local _slotName='item'
self.rankScrollView:initData(_slotName,self.rewardCfgList)
end

function UIXianJieArenaAct_rankRewardListWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end

function UIXianJieArenaAct_rankRewardListWin:onStartAction()

end

function UIXianJieArenaAct_rankRewardListWin:fillItem(widget,index)
local rewardCfg=self.rewardCfgList[index]

local minRank=rewardCfg[1]
local maxRank=rewardCfg[2]

local rankStr
if minRank==maxRank then
rankStr=FMT.fmt("第{0}名",minRank)
else
rankStr=FMT.fmt("第{0}-{1}名",minRank,maxRank)
end

widget:SetChildText(rankItemCmpIndex.rankText,rankStr)



local arenaRewards=rewardCfg[3]
local rewards=self:getRankReward(arenaRewards,index)
local len=rewards~=nil and#rewards or 0
widget:SetChildScrollViewCreateGrids(rankItemCmpIndex.rewardScrollView,len,len)
local grids=widget:GetChildScrollViewItemWidgets(rankItemCmpIndex.rewardScrollView)
local count=grids.Count
local data={}
for i=1,count do
table.clear(data)
local widget1=grids[i-1]
local reward=rewards[i]
data[1]=reward.itemId
data[2]=reward.itemCount
data.showStage=true
widgetHelper.setNormalRewardItem(widget1,0,data)
local isRankRw=reward.isRankRw or false
widget1:SetChildActive(1,isRankRw)
end
end

function UIXianJieArenaAct_rankRewardListWin:refreshDropItem()
if self.selectRankLevel>0 then

local win=UIManager:findActiveWindow("UIXingYu_JYZFLevelDropDownWin")
if win then
self.originalDropDownParent=win.parent
win.parent=self
else
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end
end

function UIXianJieArenaAct_rankRewardListWin:onChangeLevel(level)
self.selectRankLevel=level
self:refreshReward()
end

function UIXianJieArenaAct_rankRewardListWin:refreshReward()
self.rewardList=nil
self.rankScrollView:refreshAllItems()

self:refreshSelfRankItem()
end

function UIXianJieArenaAct_rankRewardListWin:getRankReward(arenaRewards,rankNum)
if not self.rewardList then
self.rewardList={}
end

if self.rewardList[rankNum]and next(self.rewardList[rankNum])then
return self.rewardList[rankNum]
end

local rewards={}

local rank=self.selectRankLevel
local rankCfg=cfgHelper.get(cfg_leitaiyanwuduanweiconfig_get,rank)
local rankRewardCfgList=rankCfg and rankCfg.rankItems1 or nil
local rankRewardCfg=rankRewardCfgList and pfwindowsModel:getVersionAndPfCfg_severPf(rankRewardCfgList)or nil
if rankRewardCfg then
for idx,v in ipairs(rankRewardCfg)do
local startRankNum=v[1]
local endRankNum=v[2]
if rankNum>=startRankNum and rankNum<=endRankNum then
local rewardList=v[3]
for _,v2 in ipairs(rewardList)do
local itemId=v2[1]
local itemCount=v2[2]
local weight=idx+10000
rewards[#rewards+1]={
itemId=itemId,
itemCount=itemCount,
weight=weight,
isRankRw=true,
}
end
end
end
end

if arenaRewards then
for idx,v in ipairs(arenaRewards)do
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
self.rewardList[rankNum]=rewards
return self.rewardList[rankNum]
end





function UIXianJieArenaAct_rankRewardListWin:onClickMask()
return self:onCloseBtn()
end



function UIXianJieArenaAct_rankRewardListWin:onCloseBtn()
self:closeSelf()
end

