







def_class("UIJueSaiZhiBoWin",UIWindowBase)









function UIJueSaiZhiBoWin:bindComponents()

self.title=UIText.get(self,0)
self.rightText=UIText.get(self,1)
self.leftText=UIText.get(self,2)
self.zhizhen=UIObject.get(self,3)
self.Text=UIText.get(self,4)
self.money1Btn=UIButton.get(self,5)
self.replayImg=UIObject.get(self,6)
self.name=UIImage.get(self,7)
self.danmuRoot=UIObject.get(self,8)
self.titleBg=UIObject.get(self,9)
self.time=UIText.get(self,10)
self.helpBtn=UIButton.get(self,11)
self.jieShu=UIText.get(self,12)
self.chatButton=UIButton.get(self,13)
self.zhichilv=UIProgress.get(self,14)
self.leftNum=UIText.get(self,15)
self.jingCaiTips=UIText.get(self,16)
self.jingCaiButton=UIButton.get(self,17)
self.rightNum=UIText.get(self,18)
self.jingcaitime=UIText.get(self,19)
self.cantjingCai=UIText.get(self,20)
self.iconHeadItem1=UIObject.get(self,21)
self.iconHeadItem2=UIObject.get(self,22)
self.moneyRoot=UIObject.get(self,23)
self.replayButton=UIButton.get(self,24)
self.fightFlag=UIObject.get(self,25)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.chatButton:setButtonClick(function()self:onChatButton()end)

self.jingCaiButton:setButtonClick(function()self:onJingCaiButton()end)

self.replayButton:setButtonClick(function()self:onReplayButton()end)



end


function UIJueSaiZhiBoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rightText);self.rightText=nil;
_UIObject_release(self.leftText);self.leftText=nil;
_UIObject_release(self.zhizhen);self.zhizhen=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.replayImg);self.replayImg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.danmuRoot);self.danmuRoot=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jieShu);self.jieShu=nil;
_UIObject_release(self.chatButton);self.chatButton=nil;
_UIObject_release(self.zhichilv);self.zhichilv=nil;
_UIObject_release(self.leftNum);self.leftNum=nil;
_UIObject_release(self.jingCaiTips);self.jingCaiTips=nil;
_UIObject_release(self.jingCaiButton);self.jingCaiButton=nil;
_UIObject_release(self.rightNum);self.rightNum=nil;
_UIObject_release(self.jingcaitime);self.jingcaitime=nil;
_UIObject_release(self.cantjingCai);self.cantjingCai=nil;
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.replayButton);self.replayButton=nil;
_UIObject_release(self.fightFlag);self.fightFlag=nil;
end



















local YList={-135,-135+50,-135+50*2,-135+50*3,-135+50*4}

function UIJueSaiZhiBoWin:onLoaded(...)
self:bindComponents()
self.danMuQueue=queue.New()
self.YListIndex={1,2,3,4,5}
self.channelId=CHAT_CHANNNEL.eKuafu
end


function UIJueSaiZhiBoWin:__delete()
self:unbindComponents()
if self.refreshTimer then
self:stopTimerByID(self.refreshTimer)
self.refreshTimer=nil
end
self:unregChatHandle()
end




function UIJueSaiZhiBoWin:onShow(argtable,afterOnloaded)
self.zhiboFlag=nil
self.oldResult=nil
self.haveResult=nil
self.matchType=argtable.matchType

self:showTime()
self:showJieShu()
self:freshMoney()
self:refreshTopPanel()

if not self.refreshTimer then
self.refreshTimer=self:setTimer(20,0,function()
lundaodahuiController.req_17_28(0)
end)
end
self:startMsgTimer()
self:regChatHandle()
end


function UIJueSaiZhiBoWin:startMsgTimer()
if not self.msgTimer then
lundaodahuiController:send_17_32()
self.msgTimer=self:setTimer(10,1,function()
lundaodahuiController:send_17_32()
end)
end
end

function UIJueSaiZhiBoWin:stopMsgTimer()
if self.msgTimer then
self:stopTimerByID(self.msgTimer)
self.msgTimer=nil
end
end

function UIJueSaiZhiBoWin:stopRefreshTimer()
if self.refreshTimer then
self:stopTimerByID(self.refreshTimer)
self.refreshTimer=nil
end
end

function UIJueSaiZhiBoWin:onRecvMesg(mesg)
local danMu=self.danMuQueue:dequeue()
if not danMu then
self.danmuItemNum=self.danmuItemNum or 0
if self.danmuItemNum<5 then
self.danmuRoot:setChildLayoutGroupAddItem()
self.danmuItemNum=self.danmuItemNum+1
danMu=self.danmuRoot:getChildLayoutGroupGridItem(self.danmuItemNum-1)
end
end
if danMu then
local randomYIndex=math.random(1,#self.YListIndex)
local YIndex=self.YListIndex[randomYIndex]
table.remove(self.YListIndex,randomYIndex)
local x=0
danMu:SetChildCanvasGroupAlpha(-1,1)
danMu:SetChildLocalPosition(-1,Vector3(x,YList[YIndex],0))
local tween=danMu:SetChildDOLocalMoveX(-1,-2000,8,function()
danMu:SetChildCanvasGroupAlpha(-1,0)
self.danMuQueue:enqueue(danMu)
table.insert(self.YListIndex,YIndex)
end)
tween:SetEase(_Ease.Linear)
danMu:SetChildText(0,mesg)
else
self:delayDo(8,function()
self:onRecvMesg(mesg)
end)
end
end

function UIJueSaiZhiBoWin:onRecvMesgList(chatInfoList)
local time=timeHelper.getServerLongTime()
local jijunMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local juesaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
for i,chatInfo in ipairs(chatInfoList)do
if chatInfo.actorInfo.fightId==self.matchType then
if(self.matchType==eLDMatchType.jijunsai and time<=jijunMatchTime)or(self.matchType==eLDMatchType.juesai and time<=juesaiMatchTime)then
local mesg=FMT.fmt("<color=#ffe699>{0}</color>参与竞猜，支持<color=#ffe699>{1}</color>",chatInfo.actorInfo.name1,chatInfo.actorInfo.name2)
self:delayDo(1*i,function()
self:onRecvMesg(mesg)
end)
end
end

end

end


function UIJueSaiZhiBoWin:onHide()
self.zhiboFlag=nil
self:stopMsgTimer()
self:stopRefreshTimer()
end

function UIJueSaiZhiBoWin:getMatch()
return lundaodahuiModel:getCurMatchType()
end

function UIJueSaiZhiBoWin:showTime()
lundaodahuiController:showTime(self.time,self.title,self.titleBg)
end

function UIJueSaiZhiBoWin:showJieShu()
self.jieShu:setText(FMT.fmt("第{0}届",lundaodahuiModel:getJieShu()))
end

function UIJueSaiZhiBoWin:freshMoney()
if self.zhiboFlag then
return
end
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

function UIJueSaiZhiBoWin:onRecv()
self:refreshTopPanel()
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainReddot",2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshChildReddot",3)
end
local abName='ui/windows/lundaodahui/lundaodahuiyugao_atlas_pak.ab'
function UIJueSaiZhiBoWin:refreshTopPanel()


local nowTime=timeHelper.getServerLongTime()
local jijunMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local juesaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)

local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(self.matchType)
local hideResult=lundaodahuiModel:checkJueSaiAfterMatchTime(self.matchType)
local hideGuessResult=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.jijunsai)

local group
local matchName='image_saijiygbt_2'
local showJingCaiButton=false
local showJingCaiTips=false
local showCantJingCaiTips=false
local showJingCaiTime=false

if self.matchType==eLDMatchType.jijunsai then
group=lundaodahuiModel:getTTSGroupInfo(24)
showJingCaiTime=true
showJingCaiButton=true
self.leftNum:setActive(true)
self.rightNum:setActive(true)
local curType=lundaodahuiModel:getCurMatchType()
if curType==eLDMatchType.jijunsai then
showJingCaiTips=false
else
if nowTime<jijunMatchTime then
showJingCaiTips=false
showJingCaiButton=true
self.Text:setText("")
local jcRate=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.juesai,"jcRate")
self.jingCaiTips:setText(FMT.fmt("（该场次竞猜成功可获得{0}倍仙筹）",jcRate[1]))
else
showJingCaiTips=false
showJingCaiTime=false
end
end

else
group=lundaodahuiModel:getTTSGroupInfo(32)
matchName='image_saijiygbt_1'

if nowTime>jijunMatchTime then
showJingCaiTips=false
if not hideGuessResult then
showJingCaiButton=true
else
showJingCaiButton=false
end

self.leftNum:setActive(true)
self.rightNum:setActive(true)

if nowTime<juesaiMatchTime and not hideGuessResult then
showJingCaiTime=true
else
showJingCaiTime=false
end
else
showJingCaiTips=true
showJingCaiButton=false
self.Text:setText("季军赛结束10分钟后可参与竞猜")

self.jingCaiTips:setText('')
showJingCaiTime=true
end

end


local supportNum1=0
local supportNum2=0
local xiazhu1=false
local xiazhu2=false
local widget1=self.iconHeadItem1:getChildWidgetBase()
local widget2=self.iconHeadItem2:getChildWidgetBase()
if group then
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local dzInfo=group
self.dzInfo=dzInfo
local listLen=dzInfo.listLen
local dzPlayer1,dzPlayer2
local isShowJingCai



self.fightLogIdList=dzInfo.fightLogIdList

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
local win1=false



if not(dzPlayer1 and dzPlayer2)and showJingCaiButton then
showCantJingCaiTips=true
showJingCaiButton=false
end

if dzPlayer1 then
supportNum1=dzPlayer1.supportNum
local fightResult=hideResult and 0 or dzPlayer1.fightResult
local color="#ffffff"
win1=fightResult==1
if fightResult==1 then
color="#efb150"
elseif fightResult==2 then
color="#cacaca"
end

if myId==tostring(dzPlayer1.playerId)and mySId==dzPlayer1.serverId and dzPlayer1.name and dzPlayer1.name~=""then
color="#aae252"
end
xiazhu1=dzPlayer1.xzFlag==1

if not dzPlayer1.name or dzPlayer1.name==""then
local name=playerModel:getOtherActorName(dzPlayer1.name)
widget1:SetChildText(0,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget1:SetChildActive(5,false)
widget1:SetChildActive(1,false)
widget1:SetChildActive(2,true)
widget1:SetChildActive(6,true)
else
local serverName=loginModel:getServerName(dzPlayer1.serverId)
widget1:SetChildText(0,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer1.name,serverName))
widget1:SetChildActive(1,false)
widget1:SetChildActive(5,true)
widget1:SetChildActive(2,true)
widget1:SetChildActive(6,false)
end

if self.initPlayer1~=dzPlayer1.playerId then
self:refreshPlayer(dzPlayer1,widget1)
self.initPlayer1=dzPlayer1.playerId
end



else
widget1:SetChildText(0,not dzPlayer2 and"虚位以待"or"暂无对手")
widget1:SetChildActive(5,false)
widget1:SetChildActive(1,true)
widget1:SetChildActive(2,false)
widget1:SetChildActive(6,false)
end



local win2=false
if dzPlayer2 then
local fightResult=hideResult and 0 or dzPlayer2.fightResult
win2=fightResult==1
supportNum2=dzPlayer2.supportNum
local color="#ffffff"
if fightResult==1 then
color="#efb150"
elseif fightResult==2 then
color="#cacaca"
end
if myId==tostring(dzPlayer2.playerId)and mySId==dzPlayer2.serverId and dzPlayer2.name and dzPlayer2.name~=""then
color="#aae252"
end
xiazhu2=dzPlayer2.xzFlag==1
local serverName=loginModel:getServerName(dzPlayer2.serverId)
if not dzPlayer2.name or dzPlayer2.name==""then
local name=playerModel:getOtherActorName(dzPlayer2.name)
widget2:SetChildText(0,FMT.fmt("<color={0}>{1}\n{2}</color>",color,name,"未知区服"))
widget2:SetChildActive(1,false)
widget2:SetChildActive(5,false)
widget2:SetChildActive(2,true)
widget2:SetChildActive(6,true)
else
local serverName=loginModel:getServerName(dzPlayer2.serverId)
widget2:SetChildText(0,FMT.fmt("<color={0}>{1}\n{2}</color>",color,dzPlayer2.name,serverName))
widget2:SetChildActive(1,false)
widget2:SetChildActive(5,true)
widget2:SetChildActive(2,true)
widget2:SetChildActive(6,false)
end
if self.initPlayer2~=dzPlayer2.playerId then
self:refreshPlayer(dzPlayer2,widget2)
self.initPlayer2=dzPlayer2.playerId
end
else
widget2:SetChildText(0,not dzPlayer1 and"虚位以待"or"暂无对手")
widget2:SetChildActive(1,true)
widget2:SetChildActive(5,false)
widget2:SetChildActive(6,false)
widget2:SetChildActive(2,false)
end


self.leftText:setText(FMT.fmt("{0}%",(supportNum1+supportNum2)==0 and 0 or math.floor(supportNum1/(supportNum1+supportNum2)*100)))
self.rightText:setText(FMT.fmt("{0}%",(supportNum1+supportNum2)==0 and 0 or math.ceil(supportNum2/(supportNum1+supportNum2)*100)))
self.leftNum:setText(supportNum1)
self.rightNum:setText(supportNum2)

self.oldResult=self.haveResult
local haveResult=(dzPlayer1 and dzPlayer1.fightResult~=0)or(dzPlayer2 and dzPlayer2.fightResult~=0)
self.haveResult=haveResult
if self.oldResult~=nil and self.oldResult~=self.haveResult then

self:onReplayButton(true)
lundaodahuiModel:setZhiBoFlag(true)
self.zhiboFlag=true
widget1:SetChildActive(4,false)
widget2:SetChildActive(4,false)
else
widget1:SetChildActive(4,win1)
widget2:SetChildActive(4,win2)
end

self.replayButton:setActive((not showCantJingCaiTips)and haveResult)
self.fightFlag:setActive(showCantJingCaiTips or(not haveResult))

self.replayImg:setActive(not hideResult)
else
if showJingCaiButton then
showCantJingCaiTips=true
showJingCaiButton=false
end
widget1:SetChildText(0,"虚位以待")
widget2:SetChildText(0,"虚位以待")
widget1:SetChildActive(1,true)
widget2:SetChildActive(1,true)
end

if(supportNum1+supportNum2)==0 then
self.zhizhen:setChildAnchoredPosition(Vector3(333,0,0))
self.zhichilv:setProgressValue(50,100)
else
self.zhizhen:setChildAnchoredPosition(Vector3(666*(supportNum1/(supportNum1+supportNum2)),0,0))
self.zhichilv:setProgressValue(supportNum1,supportNum1+supportNum2)
end


if hideResult then
showJingCaiButton=false
end

self.jingCaiTips:setActive(showJingCaiTips)
self.jingCaiButton:setActive(showJingCaiButton)
self.jingcaitime:setActive(showJingCaiTime)
self.cantjingCai:setActive(showCantJingCaiTips)
if showCantJingCaiTips or((not xiazhu1)and(not xiazhu2)and(not self.haveResult))then
self.leftNum:setActive(false)
self.rightNum:setActive(false)
end

self.group=group
self:onRefreshTime()
self.name:setCSImageSprite(abName,matchName)
end


function UIJueSaiZhiBoWin:testPlay()
self:onReplayButton(true)
lundaodahuiModel:setZhiBoFlag(true)
end

function UIJueSaiZhiBoWin:refreshPlayer(dzPlayer,widget)
if not dzPlayer.name or dzPlayer.name==""then
widget:SetChildActive(5,false)
return
end
widget:SetChildActive(5,true)
playerController:setImage(widget,5,dzPlayer.sex,dzPlayer.iconInfo)

widget:SetChildButtonClick(5,function()
if not dzPlayer.name or dzPlayer.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer.playerId,{dzPlayer.serverId,dzPlayer.iconInfo,dzPlayer.name},true)
end)
end







function UIJueSaiZhiBoWin:onMoney1Btn()
local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(self.matchType)
local hideResult=lundaodahuiModel:checkJueSaiAfterMatchTime(self.matchType)
if hideResult then
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



function UIJueSaiZhiBoWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lddh_xzs_help_%s'})
end



function UIJueSaiZhiBoWin:onFightFlag()

end



function UIJueSaiZhiBoWin:onChatButton()
local unlockLv=chatConfig.getChannelUnlockLevel(CHAT_CHANNNEL.eKuafu)
local enoughlv=unlockLv<=playerModel:getActorLevel()
if not enoughlv then
UIManager.error(FMT.fmt("宗门等级需达到{0}级",unlockLv))
return
end
local channelConfig=chatConfig.getChannelConfig(CHAT_CHANNNEL.eKuafu)
if channelConfig.serverday then
local cfgserday=pfwindowsModel:getVersionAndPfCfg(channelConfig.serverday)
local serverday=cfgserday
local openDay=timeHelper.getServerOpenDay()
if serverday and openDay<serverday then
UIManager.error(FMT.fmt('开服第{0}天开启',serverday))
return
end
end

self:showWindow("UILunDaoChatWin")
end

function UIJueSaiZhiBoWin:onJingCaiButton()
if self.group then
self:showWindow("UILDJingCaiWin",{fightId=self.group.fightId})
end
end

function UIJueSaiZhiBoWin:onReplayButton(showBattle)
local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(self.matchType)
local hideResult=lundaodahuiModel:checkJueSaiAfterMatchTime(self.matchType)

if hideResult then
showBattle=true
end

if self.fightLogIdList then

local info=self.dzInfo.dzPalyerList


local fightResult1=info[1].fightResult
local fightResult2=info[2].fightResult

local serverName1=loginModel:getServerName(info[1].serverId)
local serverName2=loginModel:getServerName(info[2].serverId)

local nameStr1=FMT.fmt("[{0}]",serverName1)
local nameStr2=FMT.fmt("[{0}]",serverName2)

local player1={info[1].playerId,info[1].name,info[1].iconInfo,nameStr1}
local player2={info[2].playerId,info[2].name,info[2].iconInfo,nameStr2}

local args={}
args.player1={FMT.fmt("{0}{1}",nameStr1,info[1].name),info[1].iconInfo}
args.player2={FMT.fmt("{0}{1}",nameStr2,info[2].name),info[2].iconInfo}
fightModel:setSendExtraArgs(eBattleType.lundaodahuiJueSai,args)
local subPage=self.matchType==eLDMatchType.jijunsai==1 or 2
fightController:send_log_list(self.fightLogIdList,{info,self.fightLogIdList,eRePlayerType.lundaodahuiJueSai,page=3,subPage=subPage,eReplayType=eRePlayerType.lundaodahuiJueSai,showBattle=showBattle,hideResult=hideResult,showWinTimes=true,player1=player1,player2=player2},true)

local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(eLDMatchType.juesai)

lundaodahuiModel:addWatchJueSaiTimes(self.matchType,true)









end
end

function UIJueSaiZhiBoWin:onRefreshTime()

if self.matchType then
if self.matchTimer then
self:stopTimerByID(self.matchTimer)
self.matchTimer=nil
end
local matchTime=lundaodahuiModel:getMatchTime(self.matchType)
if matchTime then
local now=timeHelper.getServerLongTime()
if matchTime>now then
self.jingcaitime:setText(FMT.fmt("<color=#7d3b17>距离对决开始：</color>{0}",timeHelper.format_time_stamp3(matchTime-now)))
self.matchTimer=self:setTimer(1,0,function()
local now=timeHelper.getServerLongTime()
if matchTime<=now then
self.jingcaitime:setText("")
self:refreshTopPanel()
lundaodahuiController.req_17_28(0)
if self.matchTimer then
self:stopTimerByID(self.matchTimer)
self.matchTimer=nil
end
else
self.jingcaitime:setText(FMT.fmt("<color=#7d3b17>距离对决开始：</color>{0}",timeHelper.format_time_stamp3(matchTime-now)))
end
end)
end
end
end
end

function UIJueSaiZhiBoWin:regChatHandle()
local handler=self.handler
if handler then return end

local channelId=self.channelId

handler=chatMessageHandler.create(channelId,self)

self.handler=handler
chatControl.addHandler(channelId,handler)
end

function UIJueSaiZhiBoWin:unregChatHandle()
local handler=self.handler
if not handler then return end
local channelId=self.channelId
self.handle=nil
chatControl.deleteHandler(channelId,handler)
end

function UIJueSaiZhiBoWin:chatRegex(mesg)
return string.find(mesg,chatConfig.chatRegex)~=nil
end

function UIJueSaiZhiBoWin:shareQieCuoInfo(mesg)
return string.find(mesg,chatConfig.shareQieCuoInfo)~=nil
end

function UIJueSaiZhiBoWin:shareDiscipleInfo(mesg)
return(string.find(mesg,chatConfig.shareDiscipleInfo)or
string.find(mesg,chatConfig.shareDiscipleInfoFormat))~=nil
end

function UIJueSaiZhiBoWin:voiceRegex(mesg)
return(string.find(mesg,chatConfig.voiceRegex)or
string.find(mesg,chatConfig.voiceString))~=nil
end

function UIJueSaiZhiBoWin:linkRegex(mesg)
return(string.find(mesg,chatConfig.linkRegex)or
string.find(mesg,chatConfig.linkRegexFormat)or
string.find(mesg,chatConfig.linkRegexFormatEx))~=nil
end

function UIJueSaiZhiBoWin:actRegex(mesg)
return string.find(mesg,chatConfig.actRegex)~=nil
end


function UIJueSaiZhiBoWin:onRecvPublicMessage(channelId,chatInfo)
local isBigEmoji=chatEmotHelper.containsBigEmot(chatInfo.mesg)
local isVoiceRegex=self:voiceRegex(chatInfo.mesg)
local isLinkRegex=self:linkRegex(chatInfo.mesg)
local isActRegex=self:actRegex(chatInfo.mesg)
local isChatRegex=self:chatRegex(chatInfo.mesg)
local isShareQieCuoInfo=self:shareQieCuoInfo(chatInfo.mesg)
local isShareDiscipleInfo=self:shareDiscipleInfo(chatInfo.mesg)

if isBigEmoji or isActRegex or isLinkRegex or isVoiceRegex or isChatRegex or isShareQieCuoInfo or isShareDiscipleInfo then return end

if chatInfo.actorInfo then
local actorId=playerModel:getActorID()
local name=chatInfo.actorInfo.actorName
local serverId=string.format("[%s服]",chatInfo.actorInfo.serverId)
if actorId==chatInfo.actorInfo.actorId then
name="我"
serverId=""
end


local mesg=FMT.fmt("<color=#ffe699>{2}{0}</color>: {1}",
name,chatInfo.mesg,serverId)

self:delayDo(2,function()
self:onRecvMesg(mesg)
end)
end
end