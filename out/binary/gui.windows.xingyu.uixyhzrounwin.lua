







def_class("UIXYHZRounWin",UIWindowBase)









function UIXYHZRounWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.dropItem=UIObject.get(self,1)
self.noItemTips=UIText.get(self,2)
self.Scroller=UILoopListView.new(self,3)
self.teamCnt=UIText.get(self,4)
self.TipBtn=UIButton.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.TipBtn:setButtonClick(function()self:onTipBtn()end)



end


function UIXYHZRounWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
_UIObject_release(self.teamCnt);self.teamCnt=nil;
_UIObject_release(self.TipBtn);self.TipBtn=nil;
end















local cmpIndex={
itemSelf=0,
back=1,
roundTxt=2,
faightTime=3,
teamCnt=4,
winrewardList=5,
failrewardList=6,
}



function UIXYHZRounWin:onLoaded(...)
self:bindComponents()
end


function UIXYHZRounWin:__delete()
self:unbindComponents()
end




function UIXYHZRounWin:onShow(argtable,afterOnloaded)

self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level

self.argtable=argtable


self:refresh()

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end

end


function UIXYHZRounWin:onHide()

end

function UIXYHZRounWin:refresh()
local xyId=self.argtable.xyId
self.xyId=xyId


local hzTeamCnt=XingYuModel:getXingYuData_hzTeamCnt(xyId)
local noTeam=hzTeamCnt==0

if noTeam then
self.noItemTips:setActive(true)

else
self.noItemTips:setActive(false)
local sumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
local noRound=sumRound==0






sumRound=noRound and 1 or sumRound

local list={}

if sumRound and sumRound>0 then

for i=1,sumRound do
local teamp={}
teamp.roundTxtStr=noRound and"暂无轮次"or FMT.fmt("第{0}轮",i)
if noRound then
teamp.fightTimeStr="无"
else
local date=timeHelper.dateServerStampData(timeHelper.convertLongStamp(XingYuController.getHZRoundFightTime(i)))
local day,hour,min=date.day,date.hour,date.min
teamp.fightTimeStr=min>0 and FMT.fmt("{0}点{1}分",hour,min)or FMT.fmt("{0}点",hour)
end


teamp.teamCntStr=noRound and hzTeamCnt or XingYuController.getHZRoundTeamCnt(xyId,i)
teamp.winRwList=XingYuController.getHZRoundRwList(xyId,i,true,self.selectLevel)
teamp.failRwList=XingYuController.getHZRoundRwList(xyId,i,false,self.selectLevel)
list[i]=teamp
end
else
self.noItemTips:setActive(true)
self.teamCnt:setText("队伍数量")
end

self.Scroller:initData("scrollerItem",list)
end
end






function UIXYHZRounWin:onFreshAction(index,widget,data)

widget:SetChildText(cmpIndex.roundTxt,data.roundTxtStr)
widget:SetChildText(cmpIndex.faightTime,data.fightTimeStr)
widget:SetChildText(cmpIndex.teamCnt,data.teamCntStr)
local winRwList=data.winRwList
local winCnt=#winRwList>=3 and 3 or#winRwList
widget:SetChildLayoutGroupCreateItems(cmpIndex.winrewardList,winCnt,function(index)
local rewardItem=widget:GetChildLayoutGroupGridItem(cmpIndex.winrewardList,index-1)
local rewardData=winRwList[index]
widgetHelper.setNormalRewardItem(rewardItem,0,rewardData,true)
end)

local failRwList=data.failRwList
local failCnt=#failRwList>=3 and 3 or#failRwList
widget:SetChildLayoutGroupCreateItems(cmpIndex.failrewardList,failCnt,function(index)
local rewardItem=widget:GetChildLayoutGroupGridItem(cmpIndex.failrewardList,index-1)
local rewardData=failRwList[index]
widgetHelper.setNormalRewardItem(rewardItem,0,rewardData,true)
end)

end


function UIXYHZRounWin:onStartAction()
end

function UIXYHZRounWin:onChangeLevel(level)
self.selectLevel=level
self:refresh()
end





function UIXYHZRounWin:onCloseBtn()
self:closeSelf()
end



function UIXYHZRounWin:onTipBtn()
end

