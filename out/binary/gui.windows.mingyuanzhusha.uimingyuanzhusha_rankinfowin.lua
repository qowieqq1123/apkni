







def_class("UIMingYuanZhuSha_RankInfoWin",UIWindowBase)









function UIMingYuanZhuSha_RankInfoWin:bindComponents()

self.cd=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.flag=UIImage.get(self,2)
self.infoScrollView=UILoopListView.new(self,3)
self.infoTitle_1=UIText.get(self,4)
self.infoTitle_2=UIText.get(self,5)
self.infoTitle_3=UIText.get(self,6)
self.infoTitle_4=UIText.get(self,7)
self.infoTitle_5=UIText.get(self,8)
self.jfRuleBtn=UIButton.get(self,9)
self.myInfo=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.infoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.jfRuleBtn:setButtonClick(function()self:onJfRuleBtn()end)
self.infoTitle={
self.infoTitle_1,
self.infoTitle_2,
self.infoTitle_3,
self.infoTitle_4,
self.infoTitle_5,
}



end


function UIMingYuanZhuSha_RankInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.flag);self.flag=nil;
self.infoScrollView:deleteSelf();self.infoScrollView=nil;
_UIObject_release(self.infoTitle_1);self.infoTitle_1=nil;
_UIObject_release(self.infoTitle_2);self.infoTitle_2=nil;
_UIObject_release(self.infoTitle_3);self.infoTitle_3=nil;
_UIObject_release(self.infoTitle_4);self.infoTitle_4=nil;
_UIObject_release(self.infoTitle_5);self.infoTitle_5=nil;
_UIObject_release(self.jfRuleBtn);self.jfRuleBtn=nil;
_UIObject_release(self.myInfo);self.myInfo=nil;
self.infoTitle=nil;
end
















local _this

local _item_index=
{
rank=0,
server=1,
name=2,
score=3,
items={4,5,6,7,13},
info=8,
tips=9,
items_root=10,
rankIcon=11,
playerList=12,
scrollview=14,
content=15,
passval=16,
rtips=17,
}




function UIMingYuanZhuSha_RankInfoWin:onLoaded(...)
self:bindComponents()

_this=self

local seasonType=myzsModel:getSeasonType()
if seasonType==1 then
rankListController:req_rankList_data(eRankListType.eMingYuanZhuSha,true)
else
rankListController:req_rankList_data(eRankListType.eBigCrossMingYuanZhuSha,true)
end

self.requestServerNameCallBack=function(serverid)
if self and not self.isClose then
local item=_this.rankWidgetLookUp[serverid]
if item then
local sname=loginModel:getServerName(serverid)
item:SetChildText(_item_index.server,sname)
end
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestServer,self.requestServerNameCallBack)
end


function UIMingYuanZhuSha_RankInfoWin:__delete()

_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_RankInfoWin:onShow(argtable,afterOnloaded)

self:initData()

self:refreshAll()
end


function UIMingYuanZhuSha_RankInfoWin:onHide()

end

function UIMingYuanZhuSha_RankInfoWin:initData()
self.rankLookUp=myzsModel:getRankLookUp()
self.rankWidgetLookUp={}
end

function UIMingYuanZhuSha_RankInfoWin:refreshAll()
self:refreshRankScollView()
self:refreshMyRankInfo()
self:refreshSettlementTimer()
end

function UIMingYuanZhuSha_RankInfoWin:recvRefresh()
self:refreshRankScollView()
self:refreshMyRankInfo()
self:refreshSettlementTimer()
end

function UIMingYuanZhuSha_RankInfoWin:refreshRankScollView()
local rankMaxNum=#self.rankLookUp
self.infoScrollView:refreshAllItems()
self.infoScrollView:initData('item',self.rankLookUp,rankMaxNum)
end

function UIMingYuanZhuSha_RankInfoWin:onStartAction()

end

function UIMingYuanZhuSha_RankInfoWin:onFreshAction(index,item)

local data=self.rankLookUp[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if data==nil then return end


local showRIcon=index<=3
local isSingle=data.rangeInterval==1
local actorLen=#data.actorList
local isHasActor=actorLen>0


item:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
item:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..index)
end

local data=self.rankLookUp[index]

local rankStr=""


if isSingle then
rankStr=data.rangeUp
else
rankStr=string.format("%d~%d",data.rangeUp,data.rangeDown)
end

item:SetChildActive(_item_index.info,isSingle and isHasActor)
item:SetChildActive(_item_index.score,isSingle and isHasActor)
item:SetChildActive(_item_index.passval,isSingle and isHasActor)
item:SetChildActive(_item_index.playerList,isHasActor)
item:SetChildActive(_item_index.tips,not isHasActor)


item:SetChildText(_item_index.rank,rankStr)

if isHasActor then
if isSingle then
local rankData=data.actorList[1]
item:SetBaseItemClickEvent(_item_index.info,function()
local attach={
serverid=rankData.server_id
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actor_id,true,nil,attach)
end)
self.rankWidgetLookUp[rankData.server_id]=item
local sname=loginModel:getServerName(rankData.server_id)
item:SetChildText(_item_index.server,sname)
item:SetChildText(_item_index.name,rankData.name)
item:SetChildText(_item_index.score,rankData.score)

local levelConf=myzsModel:getlevelConf(rankData.level)
local passValStr=FMT.fmt("{0}重-{1}",levelConf.layer,levelConf.level)
item:SetChildText(_item_index.passval,passValStr)
end

actorLen=Mathf.Min(5,actorLen)
item:SetChildLayoutGroupCreateItems(_item_index.playerList,actorLen,function(index)
local item=item:GetChildLayoutGroupGridItem(_item_index.playerList,index-1)

local rankData=data.actorList[index]

playerController:setHeadIcon(item,0,{scale=0.75,iconInfo=rankData.iconInfo,updateRendererSize=true})
item:SetChildButtonClick(-1,function()
local attach={
serverid=rankData.server_id
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actor_id,true,nil,attach)
end,true)
end)
else
local tipsInfo=isHasActor and""or"虚位以待"

item:SetChildText(_item_index.tips,tipsInfo)
end

local rewards=data.rewardList
self:setRewards(item,rewards)
end


function UIMingYuanZhuSha_RankInfoWin:refreshMyRankInfo()
local myRank,myRankIndex=myzsModel:getMyRank()
local level=myzsModel:getPassIdx()
local totalScore=myzsModel:getChallengeScore()
local inRank=myRank>0

local widget=self.myInfo:getChildWidgetBase()


widget:SetChildText(_item_index.rank,inRank and myRank or'未上榜')
local showRIcon=inRank and myRank<=3
widget:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
widget:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..myRank)
end


widget:SetChildActive(_item_index.playerList,true)
widget:SetChildLayoutGroupCreateItems(_item_index.playerList,1,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item_index.playerList,index-1)

local iconInfo=playerModel:getActorIconInfo()

playerController:setHeadIcon(item,0,{scale=0.75,iconInfo=iconInfo,updateRendererSize=true})
item:SetChildButtonClick(-1,function()
otherPlayerController:openOtherPlayerInfoWin(playerModel:getActorID(),true,nil,nil)
end,true)
end)
widget:SetBaseItemClickEvent(_item_index.info,function()
otherPlayerController:openOtherPlayerInfoWin(playerModel:getActorID(),true,nil,nil)
end)


local sname=loginModel:getMyServerName()
widget:SetChildText(_item_index.server,sname)


widget:SetChildText(_item_index.name,playerModel:getActorName())

local passValStr="无"
if level>0 then
local levelConf=myzsModel:getlevelConf(level)
passValStr=FMT.fmt("{0}重-{1}",levelConf.layer,levelConf.level)
end
widget:SetChildText(_item_index.passval,passValStr)

widget:SetChildText(_item_index.score,totalScore)


local rewards
if myRankIndex>0 then
local rankData=self.rankLookUp[myRankIndex]
rewards=rankData.rewardList
else
rewards={}
end
self:setRewards(widget,rewards)

local isShowRTips=next(rewards)==nil
widget:SetChildActive(_item_index.rtips,isShowRTips)
widget:SetChildText(_item_index.rtips,"暂无奖励")

end

function UIMingYuanZhuSha_RankInfoWin:stopSettlementTimer()
if self.settlementTimer then
self:stopTimerByID(self.settlementTimer)
self.settlementTimer=nil
end
end

function UIMingYuanZhuSha_RankInfoWin:refreshSettlementTimer()
self:stopSettlementTimer()

local settlementEndStamp=myzsModel:getSettlementTime()
local curTime=timeHelper.getServerShortTime()

local isDoing=settlementEndStamp>curTime

if isDoing then
local left=settlementEndStamp-curTime

local func=function()
curTime=timeHelper.getServerShortTime()
left=settlementEndStamp-curTime
_this.cd:setText(FMT.fmt("结算时间：<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(left)))
if left<0 then
_this.cd:setText("已结算，排名奖励通过信件发放")
self:stopSettlementTimer()
end
end

self.settlementTimer=self:setTimer(1,0,func)
func()
else
_this.cd:setText("已结算，排名奖励通过信件发放")
end
end

function UIMingYuanZhuSha_RankInfoWin:setRewards(item,rewards)
local rwlist=_item_index.items
local rLen=#rewards
for ii=1,#rwlist do
local index=rwlist[ii]
local rw=rewards[ii]
item:SetChildActive(index,rw~=nil)

if rw then
widgetHelper.setNormalRewardItem(item,index,rw)
end
end

item:SetChildScrollRectEnable(_item_index.scrollview,rLen>4)
item:SetChildAnchoredPos(_item_index.content,0,0)
end





function UIMingYuanZhuSha_RankInfoWin:onCloseBtn()
self:closeSelf()
end



function UIMingYuanZhuSha_RankInfoWin:onJfRuleBtn()
local d={}
d.mode=3
d.title="说明"
d.name='myzs_rank_jf_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

