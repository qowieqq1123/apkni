







def_class("UIXuanBaSaiMainWin",UIWindowBase)









function UIXuanBaSaiMainWin:bindComponents()

self.esListPanel=UIObject.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.itemPanel=UIObject.get(self,2)
self.jieShu=UIText.get(self,3)
self.left=UIButton.get(self,4)
self.min15Tips=UIObject.get(self,5)
self.myRank=UIText.get(self,6)
self.myRankImg=UIImage.get(self,7)
self.nothaveReward=UIText.get(self,8)
self.paiMingButton=UIButton.get(self,9)
self.right=UIButton.get(self,10)
self.saiKuangButton=UIButton.get(self,11)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,12)
self.setTeamRewardTips=UIObject.get(self,13)
self.time=UIText.get(self,14)
self.zhenRongButton=UIButton.get(self,15)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.left:setButtonClick(function()self:onLeft()end)

self.paiMingButton:setButtonClick(function()self:onPaiMingButton()end)

self.right:setButtonClick(function()self:onRight()end)

self.saiKuangButton:setButtonClick(function()self:onSaiKuangButton()end)

self.zhenRongButton:setButtonClick(function()self:onZhenRongButton()end)



end


function UIXuanBaSaiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.esListPanel);self.esListPanel=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jieShu);self.jieShu=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.min15Tips);self.min15Tips=nil;
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.myRankImg);self.myRankImg=nil;
_UIObject_release(self.nothaveReward);self.nothaveReward=nil;
_UIObject_release(self.paiMingButton);self.paiMingButton=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.saiKuangButton);self.saiKuangButton=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.setTeamRewardTips);self.setTeamRewardTips=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.zhenRongButton);self.zhenRongButton=nil;
end



















local UIEnScroller=simple_class(UIEnhancedScroller)

local _this

function UIXuanBaSaiMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.smooting=0.8
self.targetHor=0
notifySystem:listenNotify(notifyConfig.serverZoneFresh,self.onFreshServer)
self.enhancedscrollscript=UIEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
self.winlua:SetChildUIDragEvent(self.esListPanel:getID(),0,self.beginDragCallback,self.endDragCallback,nil)
end


function UIXuanBaSaiMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXuanBaSaiMainWin:onShow(argtable,afterOnloaded)
self.pageIndex=0
self:refreshList()
self:showMyRank()
self:showTime()
self:showJieShu()
end

function UIXuanBaSaiMainWin:onRecv()
self:doRefreshActiveCellViews()
self:showMyRank()
self:showJieShu()
end


function UIXuanBaSaiMainWin:onHide()

end

function UIXuanBaSaiMainWin:refreshList()
self.groupList=lundaodahuiModel:getXBSGroupFilterGroup(8)
local dataNum=#self.groupList
self.pageNum=dataNum
self.pageLenth=1/((dataNum-1)==1 and 1 or(dataNum-1))
self.enhancedscrollscript:initData(self.groupList,1150,dataNum)
self:refreshLRBtn()

self:JumpToMyGroup()
end

function UIXuanBaSaiMainWin.beginDragCallback()
_this.isDrag=true
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.esListPanel:getID(),true)
_this.dragPosX=posX
end


function UIXuanBaSaiMainWin.endDragCallback()
_this.isDrag=false

local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.esListPanel:getID(),true)
local index=_this.pageIndex
local offset=posX-_this.dragPosX

if offset>0.02 then
index=_this.pageIndex+1
elseif offset<-0.02 then
index=_this.pageIndex-1
end
if index<0 then
index=0
end
if index>_this.pageNum-1 then
index=_this.pageNum-1
end
_this.pageIndex=index

_this.targetHor=_this.pageLenth*_this.pageIndex
_this.winlua:SetChildScrollRectNormalizedPosTo(_this.esListPanel:getID(),_this.targetHor,_this.smooting/_this.pageLenth,0,0,nil)
_this:refreshLRBtn()
end

function UIXuanBaSaiMainWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end

function UIXuanBaSaiMainWin:showMyRank()
local myRank=lundaodahuiModel:getMyRank()or 0
if myRank==0 then
self.myRank:setText("我的名次：<color=#7d3b17>未获得参赛资格</color>")
self.zhenRongButton:setActive(false)
self.itemPanel:setActive(false)
self.nothaveReward:setActive(true)
else
local myRank2=lundaodahuiModel:getMyRank2()or 0
local nowTime=timeHelper.getServerLongTime()
local stateStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,2)
local isTimeWorking=nowTime<stateStamp
if isTimeWorking then
myRank2=0
end
self.myRank:setText(FMT.fmt("我的名次：<color=#7d3b17>{0}</color>",myRank2==0 and"暂无名次"or FMT.fmt("{0}名",myRank2)))
local rewardList=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,1,"reward")
local reward=rewardList[myRank2]
self.zhenRongButton:setActive(true)
self.itemPanel:setActive(true)
if reward then
self.nothaveReward:setActive(false)
local rLen=#reward
self.itemPanel:setChildScrollViewCreateGrids(rLen,rLen)
local gridList=self.itemPanel:getChildScrollViewItemWidgets(1)
for i=1,rLen do
local grid=gridList[i-1]
if grid then
local r=reward[i]
local itemid=r[1]
local count=r[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(2,prop)
grid:SetBaseItemClickEvent(2,function(...)
self:onClickItem(...)
end)
end
end
else
self.itemPanel:setActive(false)
self.nothaveReward:setActive(true)
end
end

self:refreshSetTeamButtonTips()
end

function UIXuanBaSaiMainWin:refreshSetTeamButtonTips()
local playerInMatch=lundaodahuiModel:isPlayerInMatchMatchType()or false
local isShowSetTeamRewardFlag=lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.xuanBa})

if isShowSetTeamRewardFlag then
playerInMatch=false
end

self.min15Tips:setActive(playerInMatch)
if playerInMatch then
local tween=self.min15Tips:setChildDOAnchorPosY(63,1)
tween:SetLoops(20,_LoopType.Yoyo)
if self.tipsTimer then self:stopTimerByID(self.tipsTimer)end
self.tipsTimer=self:setTimer(10,1,function()
self.min15Tips:setActive(false)
end)
end

self.setTeamRewardTips:setActive(isShowSetTeamRewardFlag)
if isShowSetTeamRewardFlag then
if self.setTeamRewardTipTween then
self.setTeamRewardTipTween:Complete()
self.setTeamRewardTipTween:Kill()
self.setTeamRewardTipTween=nil
end

self.setTeamRewardTips:setRotation(0,0,0)
self.setTeamRewardTipTween=self.winlua:SetChildDOPunchRotation(self.setTeamRewardTips:getID(),Vector3(0,0,15),2,2,1)
self.setTeamRewardTipTween:SetEase(_Ease.Linear)
self.setTeamRewardTipTween:SetLoops(-1,_LoopType.Restart)
end
end

function UIXuanBaSaiMainWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIXuanBaSaiMainWin:showTime()
local state,stamp=lundaodahuiModel:checkXuanBaSaiState()
if state==1 then
self.time:setText(FMT.fmt("{0}开启",timeHelper.getFourFormatByStamp(stamp)))
elseif state==2 then
if not self.resultTimer then
local now=timeHelper.getServerLongTime()
self.time:setText(FMT.fmt("选拔赛结束：{0}",timeHelper.format_time_stamp2(stamp-now)))
self.resultTimer=self:setTimer(1,stamp-now,function()
local now=timeHelper.getServerLongTime()
if stamp-now<0 then
self.time:setText("选拔赛已结束")
if self.resultTimer then
self:stopTimerByID(self.resultTimer)
self.resultTimer=nil
end
else
self.time:setText(FMT.fmt("选拔赛结束：{0}",timeHelper.format_time_stamp2(stamp-now)))
end
end)
end
else
local nowTime=timeHelper.getServerLongTime()
local startTime=lundaodahuiModel:getLunDaoDaHuiTime()
if startTime and startTime>nowTime then
local y,m,d,h=timeHelper.getDateNumber(startTime)
self.time:setText(FMT.fmt("{0}月{1}日{2}点开启下届",m,d,h))
else
self.time:setText("选拔赛已结束")
end

end
end

function UIXuanBaSaiMainWin:showJieShu()
self.jieShu:setText(FMT.fmt("第{0}届",lundaodahuiModel:getJieShu()))
end

function UIXuanBaSaiMainWin:refreshLRBtn()
self.left:setActive(self.pageIndex~=0)
self.right:setActive(self.pageIndex~=self.pageNum-1)
end

function UIXuanBaSaiMainWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lddh_xbs_help_%s'})
end




function UIXuanBaSaiMainWin:onLeft()
if self.pageIndex>0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLenth*self.pageIndex
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,self.smooting/self.pageLenth,0,0,nil)
self:refreshLRBtn()
end

end



function UIXuanBaSaiMainWin:onRight()
if self.pageIndex<self.pageNum-1 then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLenth*self.pageIndex
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,self.smooting/self.pageLenth,0,0,nil)
self:refreshLRBtn()
end
end



function UIXuanBaSaiMainWin:onZhenRongButton()
local teamList=lundaodahuiModel:getMyTeam()or{}
local list={}
if next(teamList)then
for i,v in ipairs(teamList)do
list[i]=v.unitId
end
end

local enterCallBack=function(guidList)
if lundaodahuiController:checkShowSetTeamFlag()then
lundaodahuiController.reqReceiveFirstSetTeamReward()
end

local lockTime=lundaodahuiModel:checkMatchTimeBefore15Min()
if lockTime then
UIManager.error("战斗阵容已锁定，不可调整")
return
end
lundaodahuiController.req_17_23(guidList)
fightController:closeSelectStage()
UIFullLunDaoDaHuiControl:showLunDaoDaHui()
end
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="论道大会",
teamList=list,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()
fightController:closeSelectStage()
UIFullLunDaoDaHuiControl:showLunDaoDaHui()
end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
extraWin="UILunDaoDaHuiPrePareWin",
}
fightController.showPrepareWin(eFightPreSelectType.lundaodahui,winArgs,function()
end)
end



function UIXuanBaSaiMainWin:onSaiKuangButton()
self:showWindow("UILDGroupInfoWin")
end



function UIXuanBaSaiMainWin:onPaiMingButton()
self:showWindow("UILDGroupRankWin")
end

function UIXuanBaSaiMainWin:JumpToMyGroup()
local groupList=self.groupList
local myGroup=lundaodahuiModel:getPlayerGroup()
local gindex=1
for i,v in ipairs(groupList)do
local dataGroup=v
local groupId=nil
for i=0,7 do
local index=i+1
local data=dataGroup[index]
if data then
if data.groupId==myGroup then
groupId=data.groupId
break
end
end
end
if groupId then
gindex=i
break
end
end
self:onJump(gindex-1,true)
end

function UIXuanBaSaiMainWin:onJump(index,isfast)
self.pageIndex=index
self.targetHor=self.pageLenth*index
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,isfast and 10 or self.smooting,0,0,nil)
self:refreshLRBtn()
end

function UIXuanBaSaiMainWin.onFreshServer()
if not _this then end
_this:doRefreshActiveCellViews()
end


function UIEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local dataGroup=self.window.groupList[dataIndex]
local myGroup=lundaodahuiModel:getPlayerGroup()
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local nowTime=timeHelper.getServerLongTime()
local stateStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,2)
local isTimeWorking=nowTime<stateStamp
for i=0,7 do
local childWidget=cell:GetChildWidgetBase(i)
if childWidget then
local index=i+1
local data=dataGroup[index]
if data then
childWidget:SetChildActive(0,true)
childWidget:SetChildButtonClick(0,function()
self.window:showWindow("UILDGroupRankWin",data.groupId)
end)
childWidget:SetChildText(5,FMT.fmt("第{0}组",data.groupId))
childWidget:SetChildActive(6,data.groupId==myGroup)

local listLen=data.listLen
if listLen then
local rankData=lundaodahuiModel:getXBSMainRankData(data.groupId)
if(not isTimeWorking)and rankData then
local rank1=rankData[1]
local rank2=rankData[2]
if rank1 then
local grid=childWidget:GetChildWidgetBase(3)
local serverName=loginModel:getServerName(rank1.serverId)
if not rank1.name or rank1.name==""then

local name=playerModel:getOtherActorName(rank1.name)
childWidget:SetChildText(1,FMT.fmt("{1}\n{0}","未知区服",name))
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
playerController:setHeadIcon(childWidget,3,nil)
else
if myId==tostring(rank1.playerId)and mySId==rank1.serverId then
childWidget:SetChildText(1,FMT.fmt("<color=#549327>{1}\n{0}</color>",serverName,rank1.name))
else
childWidget:SetChildText(1,FMT.fmt("{1}\n{0}",serverName,rank1.name))
end
playerController:setHeadIcon(childWidget,3,{scale=0.55,iconInfo=rank1.iconInfo})



grid:SetChildButtonClick(2,function()
if not rank1.name or rank1.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(rank1.playerId,{rank1.serverId,rank1.iconInfo,rank1.name},true)
end)
grid:SetChildActive(0,true)
grid:SetChildActive(1,true)
grid:SetChildActive(3,false)
end

else
childWidget:SetChildText(1,"虚位以待")
local grid=childWidget:GetChildWidgetBase(3)
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
playerController:setHeadIcon(childWidget,3,nil)
end

if rank2 then
local grid=childWidget:GetChildWidgetBase(4)
local serverName=loginModel:getServerName(rank2.serverId)
if not rank2.name or rank2.name==""then
local name=playerModel:getOtherActorName(rank2.name)
childWidget:SetChildText(2,FMT.fmt("{1}\n{0}","未知区服",name))
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
playerController:setHeadIcon(childWidget,4,nil)
else
if myId==tostring(rank2.playerId)and mySId==rank2.serverId then
childWidget:SetChildText(2,FMT.fmt("<color=#549327>{1}\n{0}</color>",serverName,rank2.name))
else
childWidget:SetChildText(2,FMT.fmt("{1}\n{0}",serverName,rank2.name))
end

playerController:setHeadIcon(childWidget,4,{scale=0.55,iconInfo=rank2.iconInfo})
grid:SetChildButtonClick(2,function()
if not rank2.name or rank2.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(rank2.playerId,{rank2.serverId,rank2.iconInfo,rank2.name},true)
end)
grid:SetChildActive(0,true)
grid:SetChildActive(1,true)
grid:SetChildActive(3,false)
end

else
childWidget:SetChildText(2,"虚位以待")
local grid=childWidget:GetChildWidgetBase(4)
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
playerController:setHeadIcon(childWidget,4,nil)
end
else
childWidget:SetChildText(1,"虚位以待")
childWidget:SetChildText(2,"虚位以待")
local grid=childWidget:GetChildWidgetBase(3)
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
grid=childWidget:GetChildWidgetBase(4)
grid:SetChildActive(0,false)
grid:SetChildActive(1,false)
grid:SetChildActive(3,true)
end
end
else
childWidget:SetChildActive(0,false)
end
end
end
end

function UIEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
self.window.beginDragCallback()
end

function UIEnScroller:onItemDrag(dataIndex,screenPos,cell)

end

function UIEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
self.window.endDragCallback()
end
