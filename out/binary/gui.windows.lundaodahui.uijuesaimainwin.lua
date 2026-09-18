







def_class("UIJueSaiMainWin",UIWindowBase)









function UIJueSaiMainWin:bindComponents()

self.fightFlag1=UIButton.get(self,0)
self.fightFlag2=UIButton.get(self,1)
self.groupGridList=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.iconHeadItem1=UIObject.get(self,4)
self.iconHeadItem2=UIObject.get(self,5)
self.iconHeadItem3=UIObject.get(self,6)
self.iconHeadItem4=UIObject.get(self,7)
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

self.fightFlag1:setButtonClick(function()self:onFightFlag1()end)

self.fightFlag2:setButtonClick(function()self:onFightFlag2()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jingcai1:setButtonClick(function()self:onJingcai1()end)

self.jingcai2:setButtonClick(function()self:onJingcai2()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)

self.rongyuButton:setButtonClick(function()self:onRongyuButton()end)

self.shopButton:setButtonClick(function()self:onShopButton()end)

self.zhenRongButton:setButtonClick(function()self:onZhenRongButton()end)



end


function UIJueSaiMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fightFlag1);self.fightFlag1=nil;
_UIObject_release(self.fightFlag2);self.fightFlag2=nil;
_UIObject_release(self.groupGridList);self.groupGridList=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.iconHeadItem3);self.iconHeadItem3=nil;
_UIObject_release(self.iconHeadItem4);self.iconHeadItem4=nil;
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

function UIJueSaiMainWin:onLoaded(...)
self:bindComponents()

_this=self

notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:refreshTopPanel()
end)

end


function UIJueSaiMainWin:__delete()
self:unbindComponents()

_this=nil
end




function UIJueSaiMainWin:onShow(argtable,afterOnloaded)
self:showTime()
self:showMyRank()
self:showJieShu()
self:refreshTopPanel()
self:freshMoney()
lundaodahuiController.req_17_28(0)
end


function UIJueSaiMainWin:onHide()

end


function UIJueSaiMainWin:freshMoney()
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

function UIJueSaiMainWin:onMoney1Btn()
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


function UIJueSaiMainWin:getMatchType()
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
function UIJueSaiMainWin:showTime()
lundaodahuiController:showTime(self.time,self.title,self.titleBg)
end

function UIJueSaiMainWin:showJieShu()
self.jieShu:setText(FMT.fmt("第{0}届",lundaodahuiModel:getJieShu()))
end

function UIJueSaiMainWin:showMyRank()
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
elseif myRank==4 then
reward=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.banjuesai,"reward")
else
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

function UIJueSaiMainWin:refreshSetTeamButtonTips()
local playerInMatch=lundaodahuiModel:isPlayerInMatchMatchType()or false
local isShowSetTeamRewardFlag=lundaodahuiController:checkShowSetTeamFlag()and lundaodahuiController:checkInMatchTypes({eLDMatchType.jijunsai,eLDMatchType.juesai})

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

function UIJueSaiMainWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end
function UIJueSaiMainWin:onRecv()
self:refreshTopPanel()
self:freshMoney()

UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainReddot",2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshChildReddot",3)
end
local winIcon="imge_lundaopm_{0}"
local abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab"
function UIJueSaiMainWin:refreshTopPanel()
local nowTime=timeHelper.getServerLongTime()
local matchTimeJiJun=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local jijunSaiState=matchTimeJiJun~=nil and nowTime<matchTimeJiJun

local group1=lundaodahuiModel:getTTSGroupInfo(32)
local widget1=self.iconHeadItem1:getChildWidgetBase()
local widget2=self.iconHeadItem2:getChildWidgetBase()
if group1 then
local isShowJingCai,isTween,haveResult=self:refreshGroup(group1,widget1,widget2,nil,1)
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
self.fightFlag1:setChildCanvasGroupAlpha(1)
else
self.jingcai1:setChildCanvasGroupAlpha(1)
self.fightFlag1:setChildCanvasGroupAlpha(0)
end
end
local showTime=self:checkJingCaiShowTime2()
self.jingcai1:setActive(isShowJingCai and(not jijunSaiState)and showTime)
self.fightFlag1:setActive(isShowJingCai and(not jijunSaiState)and showTime)
else
widget1:SetChildText(4,"虚位以待")
widget2:SetChildText(4,"虚位以待")
widget1:SetChildActive(3,true)
widget2:SetChildActive(3,true)
end

local group2=lundaodahuiModel:getTTSGroupInfo(24)
local widget4=self.iconHeadItem3:getChildWidgetBase()
local widget5=self.iconHeadItem4:getChildWidgetBase()
if group2 then
local isShowJingCai,isTween,haveResult=self:refreshGroup(group2,widget4,widget5)

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
self.fightFlag2:setChildCanvasGroupAlpha(1)
else
self.jingcai2:setChildCanvasGroupAlpha(1)
self.fightFlag2:setChildCanvasGroupAlpha(0)
end
end
local showTime=self:checkJingCaiShowTime1()
self.jingcai2:setActive(isShowJingCai and showTime)
self.fightFlag2:setActive(isShowJingCai and showTime)
else
widget4:SetChildText(4,"虚位以待")
widget5:SetChildText(4,"虚位以待")
widget4:SetChildActive(3,true)
widget5:SetChildActive(3,true)
end
end

function UIJueSaiMainWin:refreshGroup(groupInfo,widget1,widget2,widget3,mtype)
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local dzInfo=groupInfo
local listLen=dzInfo.listLen
local dzPlayer1,dzPlayer2
local isShowJingCai
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
local hideResult=lundaodahuiModel:checkJueSaiTongJi()
if hideResult then
isShowJingCai=false
end

local win1=false
local xiazhu1=false
local xiazhu2=false
if dzPlayer1 then
local fightResult=hideResult and 0 or dzPlayer1.fightResult
local color="#ffffff"
win1=fightResult and fightResult==1 or false
if fightResult==1 then
color="#efb150"
elseif fightResult==2 then
color="#cacaca"
end
if myId==tostring(dzPlayer1.playerId)and mySId==dzPlayer1.serverId then
color="#aae252"
end
xiazhu1=dzPlayer1.xzFlag==1
local serverName=loginModel:getServerName(dzPlayer1.serverId)
if not dzPlayer1.name or dzPlayer1.name==""then
local name=playerModel:getOtherActorName(dzPlayer1.name)
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget1:SetChildActive(3,true)
else
widget1:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer1.name,serverName))
widget1:SetChildActive(3,false)
end
self:refreshPlayer(dzPlayer1,widget1)

if mtype==1 then
if fightResult~=0 then
widget1:SetChildActive(5,true)
widget1:SetChildCSImageSprite(5,abName,FMT.fmt(winIcon,fightResult==1 and 1 or 2))
else
widget1:SetChildActive(5,false)
end
else
widget1:SetChildActive(5,win1)
end
widget1:SetChildActive(7,win1)


else
widget1:SetChildText(4,not dzPlayer2 and"虚位以待"or"暂无对手")
widget1:SetChildActive(5,false)
widget1:SetChildActive(3,true)
widget1:SetChildActive(7,false)
end
widget1:SetChildActive(8,xiazhu1)
local win2=false
if dzPlayer2 then
local fightResult=hideResult and 0 or dzPlayer2.fightResult
win2=fightResult and fightResult==1 or false
local color="#ffffff"
if fightResult==1 then
color="#efb150"
elseif fightResult==2 then
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
else
widget2:SetChildText(4,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer2.name,serverName))
widget2:SetChildActive(3,false)
end

self:refreshPlayer(dzPlayer2,widget2)
if mtype==1 then
if fightResult~=0 then
widget2:SetChildActive(5,true)
widget2:SetChildCSImageSprite(5,abName,FMT.fmt(winIcon,fightResult==1 and 1 or 2))
else
widget2:SetChildActive(5,false)
end
else
widget2:SetChildActive(5,win2)
end

widget2:SetChildActive(7,win2)
else
widget2:SetChildText(4,not dzPlayer1 and"虚位以待"or"暂无对手")
widget2:SetChildActive(3,true)
widget2:SetChildActive(5,false)
widget2:SetChildActive(7,false)
end
widget2:SetChildActive(8,xiazhu2)
return isShowJingCai,isShowJingCai and(not xiazhu1 and not xiazhu2)and(not win1 and not win2),(win1 or win2)and(not(xiazhu1 or xiazhu2))
end

function UIJueSaiMainWin:refreshPlayer(dzPlayer,widget)
if not dzPlayer.name or dzPlayer.name==""then
playerController:setHeadIcon(widget,0,nil)
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

function UIJueSaiMainWin:checkJingCaiShowTime1()




return true
end

function UIJueSaiMainWin:checkJingCaiShowTime2()
local match2=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
local nowTime=timeHelper.getServerLongTime()
return nowTime>=match2-1200
end

function UIJueSaiMainWin:onJingcai1()
if self.jingcai1ClickFunc then
self.jingcai1ClickFunc()
end
end

function UIJueSaiMainWin:onJingcai2()
if self.jingcai2ClickFunc then
self.jingcai2ClickFunc()
end
end

function UIJueSaiMainWin:onFightFlag1()
if self.jingcai1ClickFunc then
self.jingcai1ClickFunc()
end
end

function UIJueSaiMainWin:onFightFlag2()
if self.jingcai2ClickFunc then
self.jingcai2ClickFunc()
end
end




function UIJueSaiMainWin:onZhenRongButton()
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=3})
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
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=3})
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



function UIJueSaiMainWin:onRewardButton()
self:showWindow("UILDTTSRankWin")
end



function UIJueSaiMainWin:onShopButton()
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"shopId")
funcShopController:openShopWin({shopId=config})
end

function UIJueSaiMainWin:onRongyuButton()
self:showWindow("UILDRongYuTongWin",{ftype=1})
end

function UIJueSaiMainWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lddh_xzs_help_%s'})
end
