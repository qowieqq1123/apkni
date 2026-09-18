







def_class("UIXianJieArenaAct_rankXMWin",UIWindowBase)









function UIXianJieArenaAct_rankXMWin:bindComponents()

self.root=UIObject.get(self,0)
self.timeText=UIText.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.rankScrollView=UILoopListView.new(self,3)
self.noRankTips=UIObject.get(self,4)
self.selfRankItem=UIObject.get(self,5)
self.rewardListBtn=UIButton.get(self,6)
self.dropItem=UIObject.get(self,7)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.rewardListBtn:setButtonClick(function()self:onRewardListBtn()end)



end


function UIXianJieArenaAct_rankXMWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.selfRankItem);self.selfRankItem=nil;
_UIObject_release(self.rewardListBtn);self.rewardListBtn=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
end
















local rankItemCmpIndex={
bg=0,
rank=1,
xmName=2,
value=3,
rewardScrollView=4,
}




function UIXianJieArenaAct_rankXMWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieArenaAct_rankXMWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UIXianJieArenaAct_rankXMWin:onShow(argtable,afterOnloaded)
self.rankType=LTYW_Rank_Type.eXianMengRank
self.rLevel=JiuYuZhengFengModel:getData_rank_level()or 0
local win=UIManager:findActiveWindow("UIXingYu_JYZFLevelDropDownWin")
if win then
self.selectRankLevel=win.levelSIndex
else
self.selectRankLevel=self.rLevel
end

xianJieArenaActController:reqGetXJArenaRankList(self.rankType)
self:refresh()
end


function UIXianJieArenaAct_rankXMWin:onHide()
self:clearTimer()
end

function UIXianJieArenaAct_rankXMWin:refresh(isReset)

self.rankList=self:getSortRankList(isReset)
local count=#self.rankList
if count<10 then
for rankIdx=count+1,10 do
self.rankList[rankIdx]={rank=rankIdx,isEmptyData=true}
end
end

local _slotName='item'
self.rankScrollView:initData(_slotName,self.rankList)
self.noRankTips:setActive(#self.rankList<=0)


self:refreshSelfRankItem()


self:setRemainingTimeTimer()

self:refreshDropItem()
end

function UIXianJieArenaAct_rankXMWin:getSortRankList(isReset)
if not isReset and self.sortRankList then
return self.sortRankList
end

self.selfRankData=nil
local rankList=xianJieArenaActModel:getArenaRankList(self.rankType)or{}
local sortList=table.weakCopy(rankList)
local hasXm=xianmengModel:hasXM()
if hasXm then
for i,rankData in ipairs(rankList)do
local guildId=rankData.xmGuid
local isSelfXM=xianmengModel:isMyXM(guildId)
if isSelfXM then
self.selfRankData=rankData
break
end
end
end
table.sort(sortList,function(a,b)
return a.rank<b.rank
end)

self.sortRankList=sortList
return sortList
end

function UIXianJieArenaAct_rankXMWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end

function UIXianJieArenaAct_rankXMWin:onStartAction()

end

function UIXianJieArenaAct_rankXMWin:fillItem(widget,index)
local rankData=self.rankList[index]

local rankNum=rankData.rank
local rankStr=tostring(rankNum)

local isEmptyData=rankData.isEmptyData
if isEmptyData then
widget:SetChildActive(rankItemCmpIndex.value,false)

widget:SetChildText(rankItemCmpIndex.rank,rankStr)
widget:SetChildText(rankItemCmpIndex.xmName,"虚位以待")
else
local guildId=rankData.xmGuid
local isSelfXM=xianmengModel:isMyXM(guildId)





local xmName=rankData.xmName
if not xmName or xmName==""then
xmName="无"
end


local value=mathHelper.int64_to_number(rankData.xmZhanJi)
local valueStr=tostring(value)

if isSelfXM then
rankStr=FMT.cfmt(FONT_COLOR.eGreenColor,rankStr)
xmName=FMT.cfmt(FONT_COLOR.eGreenColor,xmName)
valueStr=FMT.cfmt(FONT_COLOR.eGreenColor,valueStr)
end

widget:SetChildActive(rankItemCmpIndex.value,true)

widget:SetChildText(rankItemCmpIndex.rank,rankStr)
widget:SetChildText(rankItemCmpIndex.xmName,xmName)
widget:SetChildText(rankItemCmpIndex.value,valueStr)
end


local arenaRewards=xianJieArenaActModel:getArenaRankReward(self.rankType,rankNum)
local rewards=self:getRankReward(arenaRewards,rankNum)
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

function UIXianJieArenaAct_rankXMWin:refreshSelfRankItem()
local widget=self.selfRankItem:getWidgetBase()
local rankData=self.selfRankData or{}

local rankNum=rankData and rankData.rank or 0
local rankStr=rankNum>0 and tostring(rankNum)or"未上榜"


local hasXM=xianmengModel:hasXM()
local xmName="无"
if hasXM then
local xmData=xianmengModel:getMyXMDetialData()
xmName=xmData.guildname
end


local xmZhanJi=xianJieArenaActModel:getArenaSelfRankValue(self.rankType)or Int64_0
local value=mathHelper.int64_to_number(xmZhanJi)
local valueStr=tostring(value)

widget:SetChildText(rankItemCmpIndex.rank,rankStr)
widget:SetChildText(rankItemCmpIndex.xmName,xmName)
widget:SetChildText(rankItemCmpIndex.value,valueStr)


local arenaRewards=rankNum>0 and xianJieArenaActModel:getArenaRankReward(self.rankType,rankNum)or nil
local rewards=self:getRankReward(arenaRewards,rankNum)
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


function UIXianJieArenaAct_rankXMWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerLongTime()
local endTime=xianJieArenaActModel:getArenaRankSettlementTime()
local lerp=endTime-nowTime
if lerp>0 then

self.timeText:setText(FMT.fmt("<color=#7d3b17>结算倒计时：</color>{0}",timeHelper.format_time_stamp16(lerp)))
else
self.timeText:setText("已结算")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXianJieArenaAct_rankXMWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXianJieArenaAct_rankXMWin:refreshDropItem()
if self.selectRankLevel>0 then

self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end

function UIXianJieArenaAct_rankXMWin:onChangeLevel(level)
self.selectRankLevel=level
self:refreshReward()
end

function UIXianJieArenaAct_rankXMWin:refreshReward()
self.rewardList=nil
self.rankScrollView:refreshAllItems()

self:refreshSelfRankItem()
end

function UIXianJieArenaAct_rankXMWin:getRankReward(arenaRewards,rankNum)
if not self.rewardList then
self.rewardList={}
end

if self.rewardList[rankNum]and next(self.rewardList[rankNum])then
return self.rewardList[rankNum]
end

local rewards={}

local rank=self.selectRankLevel
local rankCfg=cfgHelper.get(cfg_leitaiyanwuduanweiconfig_get,rank)
local rankRewardCfgList=rankCfg and rankCfg.rankItems3 or nil
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




function UIXianJieArenaAct_rankXMWin:onHelpBtn()
local ruleLangIdList=cfgHelper.get2(cfg_leitaiyanwubaseconfig_get,1,'ruleLangIdList')
local ruleType=self.rankType
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end


function UIXianJieArenaAct_rankXMWin:onRewardListBtn()
local rankType=self.rankType
self:showWindow("UIXianJieArenaAct_rankRewardListWin",{rankType=rankType})
end

