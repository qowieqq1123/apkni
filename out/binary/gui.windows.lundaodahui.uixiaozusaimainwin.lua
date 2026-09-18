







def_class("UIXiaoZuSaiMainWin",UIWindowBase)









function UIXiaoZuSaiMainWin:bindComponents()

self.esListPanel=UIObject.get(self,0)
self.groupGridList=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.itemPanel=UIObject.get(self,3)
self.jieShu=UIText.get(self,4)
self.left=UIButton.get(self,5)
self.min15Tips=UIObject.get(self,6)
self.min15TipsOtherPlayer=UIObject.get(self,7)
self.money1Btn=UIButton.get(self,8)
self.moneyRoot=UIObject.get(self,9)
self.myRank=UIText.get(self,10)
self.nothaveReward=UIText.get(self,11)
self.rewardButton=UIButton.get(self,12)
self.right=UIButton.get(self,13)
self.rongyuButton=UIButton.get(self,14)
self.RongYuReddot=UIObject.get(self,15)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,16)
self.setTeamRewardTips=UIObject.get(self,17)
self.shopButton=UIButton.get(self,18)
self.time=UIText.get(self,19)
self.title=UIText.get(self,20)
self.titleBg=UIObject.get(self,21)
self.zhenRongButton=UIButton.get(self,22)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.left:setButtonClick(function()self:onLeft()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)

self.right:setButtonClick(function()self:onRight()end)

self.rongyuButton:setButtonClick(function()self:onRongyuButton()end)

self.shopButton:setButtonClick(function()self:onShopButton()end)

self.zhenRongButton:setButtonClick(function()self:onZhenRongButton()end)



end


function UIXiaoZuSaiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.esListPanel);self.esListPanel=nil;
_UIObject_release(self.groupGridList);self.groupGridList=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jieShu);self.jieShu=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.min15Tips);self.min15Tips=nil;
_UIObject_release(self.min15TipsOtherPlayer);self.min15TipsOtherPlayer=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.nothaveReward);self.nothaveReward=nil;
_UIObject_release(self.rewardButton);self.rewardButton=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.rongyuButton);self.rongyuButton=nil;
_UIObject_release(self.RongYuReddot);self.RongYuReddot=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.setTeamRewardTips);self.setTeamRewardTips=nil;
_UIObject_release(self.shopButton);self.shopButton=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.zhenRongButton);self.zhenRongButton=nil;
end


















local UIEnScroller=simple_class(UIEnhancedScroller)
local _this
local matchList={eLDMatchType.top32,eLDMatchType.top16,eLDMatchType.top8}
local headIndexList={{0,1},{2,3},{7,8},{9,10},{4,5},{11,12},{6,13}}

function UIXiaoZuSaiMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.smooting=0.8
self.targetHor=0
self.groupList={
{1,2,3,4,5,6,7},
{9,10,11,12,13,14,15},
{17,18,19,20,21,22,23},
{25,26,27,28,29,30,31},
}
self.winlua:SetChildUIDragEvent(self.esListPanel:getID(),0,self.beginDragCallback,self.endDragCallback,nil)
notifySystem:listenNotify(notifyConfig.serverZoneFresh,self.onFreshServer)
self.enhancedscrollscript=UIEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

end


function UIXiaoZuSaiMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXiaoZuSaiMainWin:onShow(argtable,afterOnloaded)
if argtable then
self.selectPlayerIdx=argtable.selectPlayer
end
self.pageIndex=0
self:showTime()
self:showJieShu()
self:showMyRank()
self:freshMoney()
self:refreshRongYuReddot()
lundaodahuiController.req_17_28(0)
end


function UIXiaoZuSaiMainWin:onHide()

end

function UIXiaoZuSaiMainWin:onRecv()
self:showTime()
self:showMyRank()
self:refreshList()
end

function UIXiaoZuSaiMainWin:freshMoney()
local moneyRoot=self.moneyRoot:getChildWidgetBase()
local jcbNum=lundaodahuiModel:getJcbNum()

local hideResult=lundaodahuiModel:checkJueSaiTongJi()
moneyRoot:SetChildText(1,hideResult and"统计中"or jcbNum)
local iconname=iconHelper.getIconName(eMoneyType.mtJingCaiBi)
if not self.initMoneyIcon then
moneyRoot:SetChildIcon(0,iconname,false)
self.initMoneyIcon=true
end
end

function UIXiaoZuSaiMainWin:onMoney1Btn()
if lundaodahuiModel:checkJueSaiTongJi()then
return
end

local pos=Vector2.New(-70,-70)
local jcbNum=lundaodahuiModel:getJcbNum()
local exchFormula=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"exchFormula")
local mula=math.floor(jcbNum*(jcbNum/(jcbNum+exchFormula[1])*exchFormula[2])+exchFormula[3])
local cond_str=FMT.fmt("预计转化为<color=#f5dc92>{0}</color>弈仙币",mula)

UIManager:showWindow('UIConditionTipsTwo',{showType=eArrowDirectionType.eTopLeft,
descTable={cond_str},
posItem=self.moneyRoot,
pos=pos})
end

function UIXiaoZuSaiMainWin:getMatchType()
if not self.matchType then
local nowTime=timeHelper.getServerLongTime()
local matchType=eLDMatchType.top8

for i,v in ipairs(matchList)do
local matchTime=lundaodahuiModel:getMatchTime(v)
if matchTime and nowTime<matchTime then
matchType=v
break
end
end
self.matchType=matchType
end
return self.matchType
end


function UIXiaoZuSaiMainWin:refreshList()
local dataNum=#self.groupList
self.pageNum=dataNum
self.pageLenth=1/((dataNum-1)==1 and 1 or(dataNum-1))
self.enhancedscrollscript:initData(self.groupList,1130,dataNum)

self.groupGridList:setChildLayoutGroupCreateItems(dataNum)
local groupGrids=self.groupGridList:getChildLayoutGroupGridList()
local myIdx=0
for i=1,dataNum do
local item=groupGrids[i-1]
item:SetChildText(0,FMT.fmt("第{0}组",i))
item:SetChildButtonClick(1,function()
self:onJump(i-1)
end)
item:SetChildActive(2,i==self.pageIndex+1)
item:SetChildActive(3,self:checkGroupReddot(i))

if self.selectPlayerIdx then
local groupIndexList=self.groupList[i]
for _,v in ipairs(groupIndexList)do
if lundaodahuiModel:isPlayerFight(v)then
myIdx=i-1
break
end
end
end
end

if self.selectPlayerIdx then

self:onJump(myIdx)
self.selectPlayerIdx=nil
end

self.left:setActive(self.pageIndex~=0)
self.right:setActive(self.pageIndex~=self.pageNum-1)
end

function UIXiaoZuSaiMainWin:showJieShu()
self.jieShu:setText(FMT.fmt("第{0}届",lundaodahuiModel:getJieShu()))
end

function UIXiaoZuSaiMainWin:showTime()
lundaodahuiController:showTime(self.time,self.title,self.titleBg)
end

function UIXiaoZuSaiMainWin:showMyRank()
local myRank=lundaodahuiModel:getMyRank()or 0
if myRank==0 then
self.myRank:setText("我的名次：<color=#7d3b17>未获得参赛资格</color>")
self.zhenRongButton:setActive(false)
self.itemPanel:setActive(false)
self.nothaveReward:setActive(true)
else
if lundaodahuiModel:checkJueSaiTongJi()and(myRank==1 or myRank==2 or myRank==3)then
myRank=4
end
local reward
if myRank==1 then
local matchType=eLDMatchType.juesai
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,matchType,"reward")[1]
self.myRank:setText("我的名次：<color=#7d3b17>冠军</color>")
elseif myRank==2 then
local matchType=eLDMatchType.juesai
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,matchType,"reward")[2]
self.myRank:setText("我的名次：<color=#7d3b17>亚军</color>")
elseif myRank==3 then
local matchType=eLDMatchType.jijunsai
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,matchType,"reward")
self.myRank:setText("我的名次：<color=#7d3b17>季军</color>")
else
if myRank==96 then
self.myRank:setText("我的名次：<color=#7d3b17>暂无名次</color>")
else
self.myRank:setText(FMT.fmt("我的名次：<color=#7d3b17>{0}强</color>",myRank))
end
if myRank==32 then
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top32,"reward")
elseif myRank==16 then
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top16,"reward")
elseif myRank<=8 then
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top8,"reward")
end
end

self.zhenRongButton:setActive(true)
self.itemPanel:setActive(reward~=nil)
if reward then
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
self.nothaveReward:setActive(false)
else
self.nothaveReward:setActive(true)
end
end


self:refreshSetTeamButtonTips()

end

function UIXiaoZuSaiMainWin:refreshSetTeamButtonTips()
local playerInMatch=lundaodahuiModel:isPlayerInMatchMatchType()or false
local isShowSetTeamRewardFlag=lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.top8,eLDMatchType.top16,eLDMatchType.top32})

if isShowSetTeamRewardFlag then
playerInMatch=false
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

self.min15Tips:setActive(playerInMatch)
if playerInMatch then
local tween=self.min15Tips:setChildDOAnchorPosY(63,1)
tween:SetLoops(20,_LoopType.Yoyo)
if self.tipsTimer then self:stopTimerByID(self.tipsTimer)end
self.tipsTimer=self:setTimer(10,1,function()
self.min15Tips:setActive(false)
end)
end
end

function UIXiaoZuSaiMainWin.beginDragCallback()
_this.isDrag=true
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.esListPanel:getID(),true)
_this.dragPosX=posX
end


function UIXiaoZuSaiMainWin.endDragCallback()
_this.isDrag=false

local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.esListPanel:getID(),true)
local index=_this.pageIndex
local offset=posX-_this.dragPosX
if offset>0.05 then
index=_this.pageIndex+1
elseif offset<-0.05 then
index=_this.pageIndex-1
end
if index<0 then
index=0
end
if index>_this.pageNum-1 then
index=_this.pageNum-1
end
_this:refreshGroupGrid(index)
_this.pageIndex=index

_this.targetHor=_this.pageLenth*_this.pageIndex
_this.winlua:SetChildScrollRectNormalizedPosTo(_this.esListPanel:getID(),_this.targetHor,_this.smooting,0,0,nil)
end

function UIXiaoZuSaiMainWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
self:freshMoney()
self:refreshReddot()
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainReddot",2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshChildReddot",1)
end
function UIXiaoZuSaiMainWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIXiaoZuSaiMainWin.onFreshServer()
if not _this then end
_this:doRefreshActiveCellViews()
end




function UIXiaoZuSaiMainWin:onLeft()
if self.pageIndex>0 then
self:refreshGroupGrid(self.pageIndex-1)
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLenth*self.pageIndex
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,self.smooting,0,0,nil)
end
end



function UIXiaoZuSaiMainWin:onRight()
if self.pageIndex<self.pageNum-1 then
self:refreshGroupGrid(self.pageIndex+1)
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLenth*self.pageIndex
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,self.smooting,0,0,nil)
end
end

function UIXiaoZuSaiMainWin:refreshGroupGrid(index)
if index==self.pageIndex then
return
end
if self.pageIndex then
local groupGrid=self.groupGridList:getChildLayoutGroupGridItem(self.pageIndex)
if groupGrid then
groupGrid:SetChildActive(2,false)
end
end
local groupGrid=self.groupGridList:getChildLayoutGroupGridItem(index)
if groupGrid then
groupGrid:SetChildActive(2,true)
end
self.left:setActive(index~=0)
self.right:setActive(index~=self.pageNum-1)
end

function UIXiaoZuSaiMainWin:refreshReddot()
local groupGrids=self.groupGridList:getChildLayoutGroupGridList()
for i=1,groupGrids.Count do
local item=groupGrids[i-1]
item:SetChildActive(3,self:checkGroupReddot(i))
end
self:refreshRongYuReddot()
end

function UIXiaoZuSaiMainWin:checkGroupReddot(index)
local groupIndexList=self.groupList[index]
for i,v in ipairs(groupIndexList)do
local check=lundaodahuiModel:checkJingCai(v)
if check then
return true
end
end
return false
end

function UIXiaoZuSaiMainWin:refreshRongYuReddot()
self.RongYuReddot:setActive(lundaodahuiModel:checkRongYuTangReddot())
end

function UIXiaoZuSaiMainWin:onJump(index)
self:refreshGroupGrid(index)
self.pageIndex=index
self.targetHor=self.pageLenth*index
self.winlua:SetChildScrollRectNormalizedPosTo(self.esListPanel:getID(),self.targetHor,self.smooting,0,0,nil)
end



function UIXiaoZuSaiMainWin:onZhenRongButton()
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=1})
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=1})
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



function UIXiaoZuSaiMainWin:onShopButton()
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"shopId")
funcShopController:openShopWin({shopId=config})
end



function UIXiaoZuSaiMainWin:onRewardButton()
self:showWindow("UILDTTSRankWin")
end

function UIXiaoZuSaiMainWin:onRongyuButton()
self:showWindow("UILDRongYuTongWin",{ftype=1})
end

function UIXiaoZuSaiMainWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lddh_xzs_help_%s'})
end

function UIEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local groupIndexList=self.window.groupList[dataIndex]
for i,v in ipairs(groupIndexList)do
local widget1=cell:GetChildWidgetBase(headIndexList[i][1])
local widget2=cell:GetChildWidgetBase(headIndexList[i][2])
local groupInfo=lundaodahuiModel:getTTSGroupInfo(v)
local winFlag1=false
local winFlag2=false

if groupInfo then
local dzInfo=groupInfo
local listLen=dzInfo.listLen
local dzPlayer1,dzPlayer2
local isShowJingCai
local yingsheindex=lundaodahuiModel:Getgroupyingshe(dzInfo.fightId)
if listLen==0 then
isShowJingCai=false
elseif listLen==1 then
isShowJingCai=false
dzPlayer1=dzInfo.dzPalyerList[1]
if yingsheindex then

local groupInfo_ys=lundaodahuiModel:getTTSGroupInfo(yingsheindex[1])
if groupInfo_ys then
local YSLen=groupInfo_ys.listLen
local changeflag=false
if YSLen==0 then
changeflag=true

elseif YSLen>0 then
local YSdzPlayer1=groupInfo_ys.dzPalyerList[1]
local YSdzPlayer2=groupInfo_ys.dzPalyerList[2]
if YSdzPlayer1 and dzPlayer1.playerId==YSdzPlayer1.playerId then
elseif YSdzPlayer2 and dzPlayer1.playerId==YSdzPlayer2.playerId then
else
changeflag=true
end
end
if changeflag then
dzPlayer2=dzInfo.dzPalyerList[1]
dzPlayer1=nil
end
end
end
else
isShowJingCai=true
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
end
local xiazhu1=false
local xiazhu2=false
if dzPlayer1 then
local color="#ffffff"





local fightResult=dzPlayer1.fightResult

widget1:SetChildActive(1,true)




if dzPlayer1.name and dzPlayer1.name~=""and dzPlayer1.iconInfo then
widget1:SetChildActive(0,true)
widget1:SetChildActive(3,false)
playerController:setHeadIcon(widget1,0,{scale=0.55,iconInfo=dzPlayer1.iconInfo})
widget1:SetChildButtonClick(2,function()
if dzPlayer1.name and dzPlayer1.name~=""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer1.playerId,{dzPlayer1.serverId,dzPlayer1.iconInfo,dzPlayer1.name},true)
end)
else
widget1:SetChildActive(0,false)
widget1:SetChildActive(3,true)
end



winFlag1=fightResult and fightResult==1 or false

xiazhu1=dzPlayer1.xzFlag and dzPlayer1.xzFlag==1 or false

if winFlag1 then
color="#efb150"
else
color="#cacaca"
end
if dzPlayer1.playerId and dzPlayer1.serverId and myId==tostring(dzPlayer1.playerId)and mySId==dzPlayer1.serverId then
color="#aae252"
end
local serverName=loginModel:getServerName(dzPlayer1.serverId)

if not dzPlayer1.name or dzPlayer1.name==""then
local name=playerModel:getOtherActorName(dzPlayer1.name)
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
else
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer1.name,serverName))
end
else
widget1:SetChildText(4,not dzPlayer2 and"虚位以待"or"暂无对手")
widget1:SetChildActive(3,true)
widget1:SetChildActive(1,false)
widget1:SetChildActive(0,false)
end
widget1:SetChildActive(8,xiazhu1)
if dzPlayer2 then

local fightResult=dzPlayer2.fightResult

widget2:SetChildActive(1,true)
if dzPlayer2.name and dzPlayer2.name~=""and dzPlayer2.iconInfo then
widget2:SetChildActive(0,true)
playerController:setHeadIcon(widget2,0,{scale=0.55,iconInfo=dzPlayer2.iconInfo})
widget2:SetChildButtonClick(2,function()
if dzPlayer2.name and dzPlayer2.name~=""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer2.playerId,{dzPlayer2.serverId,dzPlayer2.iconInfo,dzPlayer2.name},true)
end)
else
widget2:SetChildActive(0,false)
end


winFlag2=fightResult and fightResult==1 or false
xiazhu2=dzPlayer2.xzFlag and dzPlayer2.xzFlag==1 or false

local color="#ffffff"
if winFlag2 then
color="#efb150"
else
color="#cacaca"
end
if dzPlayer2.serverId and dzPlayer2.playerId and myId==tostring(dzPlayer2.playerId)and mySId==dzPlayer2.serverId then
color="#aae252"
end
local serverName=loginModel:getServerName(dzPlayer2.serverId)
if not dzPlayer2.name or dzPlayer2.name==""then
local name=playerModel:getOtherActorName(dzPlayer2.name)
widget2:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget2:SetChildActive(3,true)
else
widget2:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer2.name,serverName))
widget2:SetChildActive(3,false)
end

else
widget2:SetChildText(4,not dzPlayer1 and"虚位以待"or"暂无对手")
widget2:SetChildActive(3,true)
widget2:SetChildActive(1,false)
widget2:SetChildActive(0,false)
end
widget2:SetChildActive(8,xiazhu2)


if isShowJingCai then
local func=function()
self.window:showWindow("UILDJingCaiWin",{fightId=dzInfo.fightId})
end
cell:SetChildButtonClick(13+i,func)
cell:SetChildButtonClick(20+i,func)
if i==#groupIndexList then
if(winFlag1 or winFlag2)and(not(xiazhu1 or xiazhu2))then
cell:SetChildColor(13+i,Color.New(1,1,1,0))
cell:SetChildAnchoredPosition(13+i,Vector3.New(0,25,0))
cell:SetChildScale(13+i,Vector3.New(1,1,1))
else
cell:SetChildColor(13+i,Color.New(1,1,1,1))
cell:SetChildAnchoredPosition(13+i,Vector3.New(0,-50,0))
cell:SetChildScale(13+i,Vector3.New(1,1,1))
end
else
if(winFlag1 or winFlag2)and(not(xiazhu1 or xiazhu2))then
cell:SetChildColor(13+i,Color.New(1,1,1,0))
else
cell:SetChildColor(13+i,Color.New(1,1,1,1))
end
end

end
self.tweener=self.tweener or{}
if isShowJingCai and(not xiazhu1 and not xiazhu2)and(not winFlag1 and not winFlag2)then
if not self.tweener[FMT.fmt("{0}-{1}",dataIndex,i)]then
cell:SetChildRotation(20+i,0,0,0)
local tweener=cell:SetChildDOPunchRotation(20+i,Vector3(0,0,15),2,5,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.tweener[FMT.fmt("{0}-{1}",dataIndex,i)]=tweener
end
cell:SetChildActive(13+i,false)
cell:SetChildActive(20+i,true)
else
if isShowJingCai then
cell:SetChildActive(13+i,true)
cell:SetChildActive(20+i,false)
else
cell:SetChildActive(13+i,false)
cell:SetChildActive(20+i,false)
end
if self.tweener[FMT.fmt("{0}-{1}",dataIndex,i)]then
self.tweener[FMT.fmt("{0}-{1}",dataIndex,i)]:Kill()
cell:SetChildRotation(20+i,0,0,0)
end
end

else
widget1:SetChildText(4,"虚位以待")
widget2:SetChildText(4,"虚位以待")
widget1:SetChildActive(3,true)
widget2:SetChildActive(3,true)
widget1:SetChildActive(1,false)
widget2:SetChildActive(1,false)
end
widget1:SetChildActive(5,winFlag1)
widget1:SetChildActive(7,winFlag1)
widget2:SetChildActive(5,winFlag2)
widget2:SetChildActive(7,winFlag2)
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
