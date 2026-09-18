







def_class("UIBanJueSaiMainWin",UIWindowBase)









function UIBanJueSaiMainWin:bindComponents()

self.groupGridList=UIObject.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.iconHeadItem1=UIObject.get(self,2)
self.iconHeadItem2=UIObject.get(self,3)
self.iconHeadItem3=UIObject.get(self,4)
self.iconHeadItem4=UIObject.get(self,5)
self.iconHeadItem5=UIObject.get(self,6)
self.iconHeadItem6=UIObject.get(self,7)
self.itemPanel=UIObject.get(self,8)
self.jieShu=UIText.get(self,9)
self.jingcai1=UIButton.get(self,10)
self.jingcai2=UIButton.get(self,11)
self.min15Tips=UIObject.get(self,12)
self.min15TipsOtherPlayer=UIObject.get(self,13)
self.money1Btn=UIButton.get(self,14)
self.moneyRoot=UIObject.get(self,15)
self.myRank=UIText.get(self,16)
self.nothaveReward=UIText.get(self,17)
self.rewardButton=UIButton.get(self,18)
self.rongyuButton=UIButton.get(self,19)
self.setTeamRewardTips=UIObject.get(self,20)
self.shopButton=UIButton.get(self,21)
self.time=UIText.get(self,22)
self.title=UIText.get(self,23)
self.titleBg=UIObject.get(self,24)
self.zhenRongButton=UIButton.get(self,25)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jingcai1:setButtonClick(function()self:onJingcai1()end)

self.jingcai2:setButtonClick(function()self:onJingcai2()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)

self.rongyuButton:setButtonClick(function()self:onRongyuButton()end)

self.shopButton:setButtonClick(function()self:onShopButton()end)

self.zhenRongButton:setButtonClick(function()self:onZhenRongButton()end)



end


function UIBanJueSaiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.groupGridList);self.groupGridList=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.iconHeadItem3);self.iconHeadItem3=nil;
_UIObject_release(self.iconHeadItem4);self.iconHeadItem4=nil;
_UIObject_release(self.iconHeadItem5);self.iconHeadItem5=nil;
_UIObject_release(self.iconHeadItem6);self.iconHeadItem6=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jieShu);self.jieShu=nil;
_UIObject_release(self.jingcai1);self.jingcai1=nil;
_UIObject_release(self.jingcai2);self.jingcai2=nil;
_UIObject_release(self.min15Tips);self.min15Tips=nil;
_UIObject_release(self.min15TipsOtherPlayer);self.min15TipsOtherPlayer=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.nothaveReward);self.nothaveReward=nil;
_UIObject_release(self.rewardButton);self.rewardButton=nil;
_UIObject_release(self.rongyuButton);self.rongyuButton=nil;
_UIObject_release(self.setTeamRewardTips);self.setTeamRewardTips=nil;
_UIObject_release(self.shopButton);self.shopButton=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.zhenRongButton);self.zhenRongButton=nil;
end
















local _this



local matchList={eLDMatchType.top32,eLDMatchType.top16,eLDMatchType.top8}

function UIBanJueSaiMainWin:onLoaded(...)
self:bindComponents()

_this=self

notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:refreshTopPanel()
end)

end


function UIBanJueSaiMainWin:__delete()
self:unbindComponents()

_this=nil
end




function UIBanJueSaiMainWin:onShow(argtable,afterOnloaded)
self:showTime()
self:showMyRank()
self:showJieShu()
self:refreshTopPanel()
self:freshMoney()
lundaodahuiController.req_17_28(0)
end


function UIBanJueSaiMainWin:onHide()

end

function UIBanJueSaiMainWin:freshMoney()
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

function UIBanJueSaiMainWin:onMoney1Btn()
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


function UIBanJueSaiMainWin:getMatchType()
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
function UIBanJueSaiMainWin:showTime()
lundaodahuiController:showTime(self.time,self.title,self.titleBg)
end

function UIBanJueSaiMainWin:showJieShu()
self.jieShu:setText(FMT.fmt("第{0}届",lundaodahuiModel:getJieShu()))
end

function UIBanJueSaiMainWin:showMyRank()
local myRank=lundaodahuiModel:getMyRank()or 0
if myRank==0 then
self.myRank:setText("我的名次：<color=#7d3b17>未获得参赛资格</color>")
self.zhenRongButton:setActive(false)
self.itemPanel:setActive(false)
self.nothaveReward:setActive(true)
else
local reward
if lundaodahuiModel:checkJueSaiTongJi()and(myRank==1 or myRank==2 or myRank==3)then
myRank=4
end
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
self.nothaveReward:setActive(false)
if reward then
self.itemPanel:setActive(true)
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
self.itemPanel:setActive(false)
self.nothaveReward:setActive(true)
end
end

self:refreshSetTeamButtonTips()
end

function UIBanJueSaiMainWin:refreshSetTeamButtonTips()
local playerInMatch=lundaodahuiModel:isPlayerInMatchMatchType()or false
local isShowSetTeamRewardFlag=lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.banjuesai})

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

function UIBanJueSaiMainWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end
function UIBanJueSaiMainWin:onRecv()
self:refreshTopPanel()
self:freshMoney()
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainReddot",2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshChildReddot",2)
end


function UIBanJueSaiMainWin:refreshTopPanel()
local group1=lundaodahuiModel:getTTSGroupInfo(8)
local widget1=self.iconHeadItem1:getChildWidgetBase()
local widget2=self.iconHeadItem2:getChildWidgetBase()
local widget3=self.iconHeadItem3:getChildWidgetBase()
if group1 then
local isShowJingCai,isTween,haveResult=self:refreshGroup(group1,widget1,widget2,widget3)
if isShowJingCai then
self.jingcai1ClickFunc=function()
self:showWindow("UILDJingCaiWin",{fightId=group1.fightId})

end
if isTween then
if not self.jingcai1tweener then
self.jingcai1tweener=self.winid:SetChildDOPunchRotation(self.jingcai1:getID(),Vector3(0,0,15),2,5,1)
self.jingcai1tweener:SetEase(_Ease.Linear)
self.jingcai1tweener:SetLoops(-1,_LoopType.Restart)
end
else
if self.jingcai1tweener then
self.jingcai1tweener:Kill()
self.jingcai1tweener=nil
self.jingcai1:setRotation(0,0,0)
end
end
if haveResult then
self.jingcai1:setChildCanvasGroupAlpha(0)
else
self.jingcai1:setChildCanvasGroupAlpha(1)
end
end
self.jingcai1:setActive(isShowJingCai)
else
widget1:SetChildText(4,"虚位以待")
widget2:SetChildText(4,"虚位以待")
widget3:SetChildText(4,"虚位以待")
widget1:SetChildActive(3,true)
widget2:SetChildActive(3,true)
widget3:SetChildActive(3,true)
end

local group2=lundaodahuiModel:getTTSGroupInfo(16)
local widget4=self.iconHeadItem4:getChildWidgetBase()
local widget5=self.iconHeadItem5:getChildWidgetBase()
local widget6=self.iconHeadItem6:getChildWidgetBase()
if group2 then
local isShowJingCai,isTween,haveResult=self:refreshGroup(group2,widget4,widget5,widget6)
if isShowJingCai then
self.jingcai2ClickFunc=function()
self:showWindow("UILDJingCaiWin",{fightId=group2.fightId})
end
if isTween then
if not self.jingcai2tweener then
self.jingcai2tweener=self.winid:SetChildDOPunchRotation(self.jingcai2:getID(),Vector3(0,0,15),2,5,1)
self.jingcai2tweener:SetEase(_Ease.Linear)
self.jingcai2tweener:SetLoops(-1,_LoopType.Restart)
end
else
if self.jingcai2tweener then
self.jingcai2tweener:Kill()
self.jingcai2tweener=nil
self.jingcai2:setRotation(0,0,0)
end
end
if haveResult then
self.jingcai2:setChildCanvasGroupAlpha(0)
else
self.jingcai2:setChildCanvasGroupAlpha(1)
end
end
self.jingcai2:setActive(isShowJingCai)
else
widget4:SetChildText(4,"虚位以待")
widget5:SetChildText(4,"虚位以待")
widget6:SetChildText(4,"虚位以待")
widget4:SetChildActive(3,true)
widget5:SetChildActive(3,true)
widget6:SetChildActive(3,true)
end
end

function UIBanJueSaiMainWin:refreshGroup(groupInfo,widget1,widget2,widget3)
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local dzInfo=groupInfo
local listLen=dzInfo.listLen
local dzPlayer1,dzPlayer2
local isShowJingCai
local winFlag1=false
local winFlag2=false
if listLen==0 then
isShowJingCai=false
elseif listLen==1 then
isShowJingCai=false
dzPlayer1=dzInfo.dzPalyerList[1]
else
isShowJingCai=true
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
end
local victoryPlayer=nil
local xiazhu1=false
local xiazhu2=false
if dzPlayer1 then
local color="#ffffff"
if dzPlayer1.fightResult==1 then
color="#efb150"
winFlag1=true
else
color="#cacaca"
end
if myId==tostring(dzPlayer1.playerId)and mySId==dzPlayer1.serverId then
color="#aae252"
end
local serverName=loginModel:getServerName(dzPlayer1.serverId)
if not dzPlayer1.name or dzPlayer1.name==""then
local name=playerModel:getOtherActorName(dzPlayer1.name)
widget1:SetChildActive(3,true)
widget1:SetChildActive(0,false)
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
else
widget1:SetChildActive(0,true)
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer1.name,serverName))
widget1:SetChildActive(3,false)

end
widget1:SetChildActive(5,dzPlayer1.fightResult==1)
widget1:SetChildActive(7,dzPlayer1.fightResult==1)
self:refreshPlayer(dzPlayer1,widget1)
if dzPlayer1.fightResult==1 then
victoryPlayer=dzPlayer1
end
xiazhu1=dzPlayer1.xzFlag==1



else
widget1:SetChildText(4,not dzPlayer2 and"虚位以待"or"暂无对手")
widget1:SetChildActive(3,true)
widget1:SetChildActive(0,false)
end
widget1:SetChildActive(8,xiazhu1)
if dzPlayer2 then
local color="#ffffff"
if dzPlayer2.fightResult==1 then
color="#efb150"
winFlag2=true
else
color="#cacaca"
end
if myId==tostring(dzPlayer2.playerId)and mySId==dzPlayer2.serverId then
color="#aae252"
end
xiazhu2=dzPlayer2.xzFlag==1
local serverName=loginModel:getServerName(dzPlayer2.serverId)

if not dzPlayer2.name or dzPlayer2.name==""then
local name=playerModel:getOtherActorName(dzPlayer2.name)
widget2:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget2:SetChildActive(3,true)
widget2:SetChildActive(0,false)
else
widget2:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer2.name,serverName))
widget2:SetChildActive(3,false)
widget2:SetChildActive(0,true)

end
widget2:SetChildActive(5,dzPlayer2.fightResult==1)
widget2:SetChildActive(7,dzPlayer2.fightResult==1)

self:refreshPlayer(dzPlayer2,widget2)
if dzPlayer2.fightResult==1 then
victoryPlayer=dzPlayer2
end



else
widget2:SetChildText(4,not dzPlayer1 and"虚位以待"or"暂无对手")
widget2:SetChildActive(3,true)
widget2:SetChildActive(0,false)
end
widget2:SetChildActive(8,xiazhu2)
if victoryPlayer then
self:refreshPlayer(victoryPlayer,widget3)
local color="#ffffff"
if myId==tostring(victoryPlayer.playerId)and mySId==victoryPlayer.serverId then
color="#aae252"
end
local serverName=loginModel:getServerName(victoryPlayer.serverId)

if not victoryPlayer.name or victoryPlayer.name==""then
local name=playerModel:getOtherActorName(victoryPlayer.name)
widget3:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget3:SetChildActive(3,true)
widget3:SetChildActive(0,false)
else
widget3:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,victoryPlayer.name,serverName))
widget3:SetChildActive(3,false)
widget3:SetChildActive(0,true)
end
else
widget3:SetChildActive(3,true)
widget3:SetChildText(4,"虚位以待")
widget3:SetChildActive(0,false)
end

return isShowJingCai,isShowJingCai and(not xiazhu1 and not xiazhu2)and(not winFlag1 and not winFlag2),(winFlag1 or winFlag2)and(not(xiazhu1 or xiazhu2))
end

function UIBanJueSaiMainWin:refreshPlayer(dzPlayer,widget)
if not dzPlayer.name or dzPlayer.name==""then
widget:SetChildActive(0,false)
return
end
widget:SetChildActive(0,true)
playerController:setHeadIcon(widget,0,{scale=0.55,iconInfo=dzPlayer.iconInfo})
widget:SetChildButtonClick(2,function()
if not dzPlayer.name or dzPlayer.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer.playerId,{dzPlayer.serverId,dzPlayer.iconInfo,dzPlayer.name},true)
end)
end




function UIBanJueSaiMainWin:onZhenRongButton()
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=2})
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=2})
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

function UIBanJueSaiMainWin:onShopButton()
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"shopId")
funcShopController:openShopWin({shopId=config})
end

function UIBanJueSaiMainWin:onRewardButton()
self:showWindow("UILDTTSRankWin")
end

function UIBanJueSaiMainWin:onRongyuButton()
self:showWindow("UILDRongYuTongWin",{ftype=1})
end

function UIBanJueSaiMainWin:onJingcai1()
if self.jingcai1ClickFunc then
self.jingcai1ClickFunc()
end
end

function UIBanJueSaiMainWin:onJingcai2()
if self.jingcai2ClickFunc then
self.jingcai2ClickFunc()
end
end

function UIBanJueSaiMainWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lddh_xzs_help_%s'})
end
