







def_class("UIMoGongZhengDuoAct_rankPersonWin",UIWindowBase)









function UIMoGongZhengDuoAct_rankPersonWin:bindComponents()

self.dropItem=UIObject.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.noRankTips=UIObject.get(self,2)
self.rankScrollView=UILoopListView.new(self,3)
self.root=UIObject.get(self,4)
self.selfRankItem=UIObject.get(self,5)
self.timeText=UIText.get(self,6)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoGongZhengDuoAct_rankPersonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selfRankItem);self.selfRankItem=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end


















local rankItemCmpIndex={
bg=0,
rank=1,
actorName=2,
xmName=3,
value=4,
rewardGroup=5,
}


function UIMoGongZhengDuoAct_rankPersonWin:onLoaded(...)
self:bindComponents()
end


function UIMoGongZhengDuoAct_rankPersonWin:__delete()
self:unbindComponents()
end




function UIMoGongZhengDuoAct_rankPersonWin:onShow(argtable,afterOnloaded)
self.level=argtable.level
self.selectLevel=self.level

self.rankType=MGZD_RANK_TYPE.ePersonRank

moGongZhengDuoActController:reqMoGongRankList(self.rankType)
self:refresh()








end


function UIMoGongZhengDuoAct_rankPersonWin:onHide()
self:clearTimer()
end


function UIMoGongZhengDuoAct_rankPersonWin:refresh(isReset)

self.rankList=self:getSortRankList(isReset)
local _slotName='item'
self.rankScrollView:initData(_slotName,self.rankList)
self.noRankTips:setActive(#self.rankList<=0)


self:refreshSelfRankItem()



end

function UIMoGongZhengDuoAct_rankPersonWin:getSortRankList(isReset)
if not isReset and self.sortRankList then
return self.sortRankList
end

self.selfRankData=nil
local rankList=moGongZhengDuoActModel:getArenaRankList(self.rankType)or{}
for i,rankData in ipairs(rankList)do
local actorId=rankData.actorid
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
self.selfRankData=rankData
break
end
end

local sortList=table.weakCopy(rankList)
table.sort(sortList,function(a,b)
return a.rank<b.rank
end)

self.sortRankList=sortList
return sortList
end

function UIMoGongZhengDuoAct_rankPersonWin:onFreshAction(i,widget)
self:fillItem(widget,i)
end

function UIMoGongZhengDuoAct_rankPersonWin:onStartAction()

end

function UIMoGongZhengDuoAct_rankPersonWin:fillItem(widget,index)
local rankData=self.rankList[index]
local actorId=rankData.actorid
local isSelf=playerModel:checkActorId(actorId)

local rankNum=rankData.rank
local rankStr=tostring(rankNum)


local actorName=rankData.name


local xmName=rankData.xmName
if not xmName or xmName==""then
xmName="无"
end


local value=mathHelper.int64_to_number(rankData.zhanji)
local valueStr=tostring(value)

if isSelf then
rankStr=FMT.cfmt(FONT_COLOR.eGreenColor,rankStr)
actorName=FMT.cfmt(FONT_COLOR.eGreenColor,actorName)
xmName=FMT.cfmt(FONT_COLOR.eGreenColor,xmName)
valueStr=FMT.cfmt(FONT_COLOR.eGreenColor,valueStr)
end

widget:SetChildText(rankItemCmpIndex.rank,rankStr)
widget:SetChildText(rankItemCmpIndex.actorName,actorName)
widget:SetChildText(rankItemCmpIndex.xmName,xmName)
widget:SetChildText(rankItemCmpIndex.value,valueStr)


local rewards=moGongZhengDuoActModel:getArenaRankReward(self.rankType,rankNum,self.selectLevel)
local len=rewards~=nil and#rewards or 0
widget:SetChildLayoutGroupCreateItems(rankItemCmpIndex.rewardGroup,len,function(i)
local data={}
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
data.duanwei=reward.duanwei
local widget1=widget:GetChildLayoutGroupGridItem(rankItemCmpIndex.rewardGroup,i-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
end)
end

function UIMoGongZhengDuoAct_rankPersonWin:refreshSelfRankItem()
local widget=self.selfRankItem:getWidgetBase()
local rankData=self.selfRankData or{}

local rankNum=rankData and rankData.rank or 0
local rankStr=rankNum>0 and tostring(rankNum)or"未上榜"


local actorName=playerModel:getActorName()


local hasXM=xianmengModel:hasXM()
local xmName="无"
if hasXM then
local xmData=xianmengModel:getMyXMDetialData()
xmName=xmData.guildname
end


local selfZhanJi=moGongZhengDuoActModel:getArenaSelfRankValue(self.rankType)or Int64_0
local value=mathHelper.int64_to_number(selfZhanJi)
local valueStr=tostring(value)

widget:SetChildText(rankItemCmpIndex.rank,rankStr)
widget:SetChildText(rankItemCmpIndex.actorName,actorName)
widget:SetChildText(rankItemCmpIndex.xmName,xmName)
widget:SetChildText(rankItemCmpIndex.value,valueStr)


local rewards=rankNum>0 and moGongZhengDuoActModel:getArenaRankReward(self.rankType,rankNum,self.selectLevel)or nil
local len=rewards~=nil and#rewards or 0
widget:SetChildLayoutGroupCreateItems(rankItemCmpIndex.rewardGroup,len,function(i)
local data={}
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
data.duanwei=reward.duanwei
local widget1=widget:GetChildLayoutGroupGridItem(rankItemCmpIndex.rewardGroup,i-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
end)
end


function UIMoGongZhengDuoAct_rankPersonWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerLongTime()
local endTime=moGongZhengDuoActModel:getArenaRankSettlementTime()
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


function UIMoGongZhengDuoAct_rankPersonWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIMoGongZhengDuoAct_rankPersonWin:onHelpBtn()
local ruleLangIdList=cfgHelper.get2(cfg_mogongzhengduobaseconfig_get,1,'ruleLangIdList')
local ruleType=self.rankType
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end


function UIMoGongZhengDuoAct_rankPersonWin:onChangeLevel(level)
self.selectLevel=level

self:refresh()
end