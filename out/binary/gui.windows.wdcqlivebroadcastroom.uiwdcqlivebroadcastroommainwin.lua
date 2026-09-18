







def_class("UIWDCQLiveBroadcastRoomMainWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomMainWin:bindComponents()

self.alpace=UIButton.get(self,0)
self.alpaceEffect=UIObject.get(self,1)
self.backButton=UIButton.get(self,2)
self.cdTips=UIText.get(self,3)
self.cdTx=UIText.get(self,4)
self.chatButton=UIButton.get(self,5)
self.danmuRoot=UIObject.get(self,6)
self.giftEffect=UIObject.get(self,7)
self.giftItem_1=UIObject.get(self,8)
self.giftItem_2=UIObject.get(self,9)
self.giftMask=UIObject.get(self,10)
self.guessBtn=UIButton.get(self,11)
self.helpBtn=UIButton.get(self,12)
self.hotNum=UIObject.get(self,13)
self.hotRankBtn=UIButton.get(self,14)
self.hotTx=UIText.get(self,15)
self.leftPlayer=UIObject.get(self,16)
self.orderTx=UIText.get(self,17)
self.pedlar=UIButton.get(self,18)
self.pedlarCDTx=UIText.get(self,19)
self.pedlarEffect=UIObject.get(self,20)
self.peopleTx=UIText.get(self,21)
self.playbackBtn=UIButton.get(self,22)
self.prepareBtn=UIButton.get(self,23)
self.prepareBtnTx=UIObject.get(self,24)
self.prepareTips=UIObject.get(self,25)
self.prepareTipsTx=UIText.get(self,26)
self.prizePoolBtn=UIButton.get(self,27)
self.prizePoolReddot=UIObject.get(self,28)
self.prizePoolTx=UIText.get(self,29)
self.rightPlayer=UIObject.get(self,30)
self.shopArrow=UIButton.get(self,31)
self.shopBtn=UIButton.get(self,32)
self.shopCDTx=UIText.get(self,33)
self.shopReddot=UIObject.get(self,34)
self.spectator_1=UIObject.get(self,35)
self.spectator_2=UIObject.get(self,36)
self.spectator_3=UIObject.get(self,37)
self.spectator_4=UIObject.get(self,38)
self.spectator_5=UIObject.get(self,39)
self.stateTx=UIText.get(self,40)
self.titleImage=UIImage.get(self,41)
self.watchBtn=UIButton.get(self,42)
self.titleImageEx=UIObject.get(self,43)

self.alpace:setButtonClick(function()self:onAlpace()end)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.chatButton:setButtonClick(function()self:onChatButton()end)

self.guessBtn:setButtonClick(function()self:onGuessBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.hotRankBtn:setButtonClick(function()self:onHotRankBtn()end)

self.pedlar:setButtonClick(function()self:onPedlar()end)

self.playbackBtn:setButtonClick(function()self:onPlaybackBtn()end)

self.prepareBtn:setButtonClick(function()self:onPrepareBtn()end)

self.prizePoolBtn:setButtonClick(function()self:onPrizePoolBtn()end)

self.shopArrow:setButtonClick(function()self:onShopArrow()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.watchBtn:setButtonClick(function()self:onWatchBtn()end)
self.giftItem={
self.giftItem_1,
self.giftItem_2,
}
self.spectator={
self.spectator_1,
self.spectator_2,
self.spectator_3,
self.spectator_4,
self.spectator_5,
}



end


function UIWDCQLiveBroadcastRoomMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.alpace);self.alpace=nil;
_UIObject_release(self.alpaceEffect);self.alpaceEffect=nil;
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.cdTips);self.cdTips=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.chatButton);self.chatButton=nil;
_UIObject_release(self.danmuRoot);self.danmuRoot=nil;
_UIObject_release(self.giftEffect);self.giftEffect=nil;
_UIObject_release(self.giftItem_1);self.giftItem_1=nil;
_UIObject_release(self.giftItem_2);self.giftItem_2=nil;
_UIObject_release(self.giftMask);self.giftMask=nil;
_UIObject_release(self.guessBtn);self.guessBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hotNum);self.hotNum=nil;
_UIObject_release(self.hotRankBtn);self.hotRankBtn=nil;
_UIObject_release(self.hotTx);self.hotTx=nil;
_UIObject_release(self.leftPlayer);self.leftPlayer=nil;
_UIObject_release(self.orderTx);self.orderTx=nil;
_UIObject_release(self.pedlar);self.pedlar=nil;
_UIObject_release(self.pedlarCDTx);self.pedlarCDTx=nil;
_UIObject_release(self.pedlarEffect);self.pedlarEffect=nil;
_UIObject_release(self.peopleTx);self.peopleTx=nil;
_UIObject_release(self.playbackBtn);self.playbackBtn=nil;
_UIObject_release(self.prepareBtn);self.prepareBtn=nil;
_UIObject_release(self.prepareBtnTx);self.prepareBtnTx=nil;
_UIObject_release(self.prepareTips);self.prepareTips=nil;
_UIObject_release(self.prepareTipsTx);self.prepareTipsTx=nil;
_UIObject_release(self.prizePoolBtn);self.prizePoolBtn=nil;
_UIObject_release(self.prizePoolReddot);self.prizePoolReddot=nil;
_UIObject_release(self.prizePoolTx);self.prizePoolTx=nil;
_UIObject_release(self.rightPlayer);self.rightPlayer=nil;
_UIObject_release(self.shopArrow);self.shopArrow=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.shopCDTx);self.shopCDTx=nil;
_UIObject_release(self.shopReddot);self.shopReddot=nil;
_UIObject_release(self.spectator_1);self.spectator_1=nil;
_UIObject_release(self.spectator_2);self.spectator_2=nil;
_UIObject_release(self.spectator_3);self.spectator_3=nil;
_UIObject_release(self.spectator_4);self.spectator_4=nil;
_UIObject_release(self.spectator_5);self.spectator_5=nil;
_UIObject_release(self.stateTx);self.stateTx=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
_UIObject_release(self.watchBtn);self.watchBtn=nil;
_UIObject_release(self.titleImageEx);self.titleImageEx=nil;
self.giftItem=nil;
self.spectator=nil;
end















local _this=nil
local _abName="ui/windows/wdcqlivebroadcastroom/wdcqlivebroadcastroom_atlas_pak.ab"
local _giftCmp={
widget=-1,
headBg=0,
head=1,
playerName=2,
serverName=3,
giftName=4,
giftItem=5,
giftNum=6,
root=7,
background=8,
giftIcon=9,
}
local _playerCmp={
widget=-1,
headBg=0,
head=1,
nameTx=2,
serverTx=3,
victory=4,
sameServer=5,
banList=6,
}
local _banCmp={
widget=-1,
head=0,
job=1,
}
local _showGiftItemPosY={
0,-120
}
local _showGiftItemOrginX=-625
local _showGiftItemInterval=0.35
local _showGiftItemDuration=4
local _converStageSubEmptyValue="#"
local _converStageHandle={
[WDCQCMatchStageEnum.ePreTheGame]={
[WDCQCPreGameStageEnum.eNone]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eWaitStrart,roundCfg.selectDzStartTime
end,
[WDCQCPreGameStageEnum.eSelectDz]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eSelectDisciple,roundCfg.selectDzEndTime
end,
[WDCQCPreGameStageEnum.eForbiddenDz]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eBanDisciple,roundCfg.banDzEndTime
end,
[WDCQCPreGameStageEnum.eAdjustTeam]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eAdjustTeam,roundCfg.preEndTime,roundCfg.teamUpTime[subIdx].teamUpEndTime
end,
},
[WDCQCMatchStageEnum.eTimeDown]={
[_converStageSubEmptyValue]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eWaitFight,roundCfg.startTime
end,
},
[WDCQCMatchStageEnum.eInTheGame]={
[_converStageSubEmptyValue]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eWatchFight,roundCfg.endTime
end,
},
[WDCQCMatchStageEnum.eEndTheGame]={
[_converStageSubEmptyValue]=function(roundCfg,seasonBegin,seasonEnd,subIdx)
return eWDCQLiveRoomMatchStageEnum.eFightFinish,seasonEnd
end,
},
}
local _competitionStageName={
[eWDCQLiveRoomMatchStageEnum.eWaitStrart]=function(matchInfo)
return"",29
end,
[eWDCQLiveRoomMatchStageEnum.eSelectDisciple]=function(matchInfo)
return"赛前阶段：选择对战弟子",29
end,
[eWDCQLiveRoomMatchStageEnum.eBanDisciple]=function(matchInfo)
return"赛前阶段：选择禁用弟子",29
end,
[eWDCQLiveRoomMatchStageEnum.eAdjustTeam]=function(matchInfo)
return"赛前阶段：调整对战队伍",29
end,
[eWDCQLiveRoomMatchStageEnum.eWaitFight]=function(matchInfo)
return"",29
end,
[eWDCQLiveRoomMatchStageEnum.eWatchFight]=function(matchInfo)
return"对决进行中",29
end,
[eWDCQLiveRoomMatchStageEnum.eFightFinish]=function(matchInfo)
local lNum=0
local rNum=0










for teamIndex=1,3 do
local teamWinwin_actor_id
local teamlWinNum=0
local teamRWinNum=0
for fightIndex=1,3 do
local index=(teamIndex-1)*3+fightIndex
local wdcqRoundInfo=matchInfo.roundList[index]
if wdcqRoundInfo then
if mathHelper.compareInt64(wdcqRoundInfo.win_actor_id,matchInfo.actor_id_1)then
teamlWinNum=teamlWinNum+1
end
if mathHelper.compareInt64(wdcqRoundInfo.win_actor_id,matchInfo.actor_id_2)then
teamRWinNum=teamRWinNum+1
end
end
end
if teamlWinNum>teamRWinNum then
teamWinwin_actor_id=matchInfo.actor_id_1
end
if teamlWinNum<teamRWinNum then
teamWinwin_actor_id=matchInfo.actor_id_2
end
if teamWinwin_actor_id then
if mathHelper.compareInt64(teamWinwin_actor_id,matchInfo.actor_id_1)then
lNum=lNum+1
end
if mathHelper.compareInt64(teamWinwin_actor_id,matchInfo.actor_id_2)then
rNum=rNum+1
end
end
end
return FMT.fmt("<size=48>{0} : {1}</size>",lNum,rNum),19
end,
}
local YList={-135,-135+50,-135+50*2,-135+50*3,-135+50*4}



function UIWDCQLiveBroadcastRoomMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,self.onWDCQLiveBroadcastRoomHotChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomPeopleChange,self.onWDCQLiveBroadcastRoomPeopleChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,self.onWDCQLiveBroadcastRoomDrawChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,self.onWDCQLiveBroadcastRoomTotalHotChange)
self:addNotify(notifyConfig.onRequestPhpServerNamesRecv,self.onRequestPhpServerNamesRecv)
self:addProNotify(38,26,self.on_38_26)
self:addProNotify(38,27,self.on_38_27)
self:addProNotify(38,31,self.on_38_31)
self:addProNotify(38,1,self.on_38_1)
self:addProNotify(38,8,self.on_38_8)
self:addProNotify(38,3,self.on_38_3)
self:addProNotify(38,4,self.on_38_4)
self:addProNotify(38,5,self.on_38_5)

self.danMuQueue=queue.New()
self.YListIndex={1,2,3,4,5}

self.showingGiftCache={
[0]={},
[1]={},
}
self.showingGiftIndex=0
self.showingGiftTweens={}
self.giftEffectCache={}

local baseCfg=cfgHelper.get1(cfg_wendingcangqiongzhibobasicconfig_get,1)
self.merchatSpeakCnt=#baseCfg.merchantSpeak
self.merchatSpeakLib={}
for i=1,self.merchatSpeakCnt do
table.insert(self.merchatSpeakLib,i)
end

self:initSpectatorSpeak()
end


function UIWDCQLiveBroadcastRoomMainWin:__delete()
self:unregChatHandle()
self:unbindComponents()
_this=nil

self:stopCDTick()
self:stopShowGiftTick()
self:stopCompetitionCDTick()
self:stopPedlarTick()
self:stopSpectatorTick()
self:killGiftTween()
end




function UIWDCQLiveBroadcastRoomMainWin:onShow(argtable,afterOnloaded)
self.group=argtable.group
self.phase=argtable.phase
self.order=argtable.order
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

if not WDCQController.checkInTheGame2()then
self:onBackButton()
return
end

self:initData()
self:updateData()
self:initView()

if wdcqLiveBroadcastRoomModel:isSameRoom(self.group,self.phase,self.order)then
self:refreshView()
self:startShowGiftTick()
end
end


function UIWDCQLiveBroadcastRoomMainWin:onHide()

end




function UIWDCQLiveBroadcastRoomMainWin:onBackButton()
local args={
parentWin=UIFullWenDingCangQiongControl,
enterFunc=function()
wdcqLiveBroadcastRoomController:send_38_27()
chatControl.clearChannelMesg(self.channelId)
WDCQController:removeBookWinWhenLiveRoomClose(self.group,self.phase,self.order)
self:doCloseWin()
end,
overTime=10,
checkFunc=function()
return true
end
}
UIFullWenDingCangQiongControl:showWindow("UIWDCQLiveBroadcastRoomTransitionWin",args)
end

function UIWDCQLiveBroadcastRoomMainWin:doCloseWin()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end


function UIWDCQLiveBroadcastRoomMainWin:onChatButton()
local args={
parentWin=self,
channelId=self.channelId,
}
self:showWindow("UIWDCQLiveBroadcastRoomChatWin",args)
end


function UIWDCQLiveBroadcastRoomMainWin:onGuessBtn()
self:showWindow("UIWDCQGuessWin",{groupId=self.group,stageId=self.phase,idx=self.order})
end


function UIWDCQLiveBroadcastRoomMainWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='wendingcangqiongzhibojian_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIWDCQLiveBroadcastRoomMainWin:onHotRankBtn()
if not wdcqLiveBroadcastRoomModel:isSameRoom(self.group,self.phase,self.order)then return end
if self.phase~=WDCQCGameStageEnum.eChampion then return end

wdcqLiveBroadcastRoomController:send_38_25()

local args={
parentWin=self,
}
self:showWindow("UIWDCQLiveBroadcastRoomHotRankWin",args)
end


function UIWDCQLiveBroadcastRoomMainWin:onPlaybackBtn()






self:showWindow("UIWDCQGuessWin",{groupId=self.group,stageId=self.phase,idx=self.order,tabIndex=2,showLiveWin=true})
end


function UIWDCQLiveBroadcastRoomMainWin:onPrepareBtn()
local group=self.group
local phase=self.phase
local order=self.order
local parentWin=self.parentWin
local closeFunc=self.closeFunc
local args={
closeCallBack=function()
local temp={
group=group,
phase=phase,
order=order,
parentWin=parentWin,
closeFunc=closeFunc,
}
UIFullWenDingCangQiongControl:showWindow("UIWDCQLiveBroadcastRoomMainWin",temp)
end
}
self:showWindow("UIWDCQPreGameWin",args)
end


function UIWDCQLiveBroadcastRoomMainWin:onPrizePoolBtn()
if not wdcqLiveBroadcastRoomModel:isSameRoom(self.group,self.phase,self.order)then return end
if self.phase~=WDCQCGameStageEnum.eChampion then return end

wdcqLiveBroadcastRoomController:send_38_30()

local args={
group=self.group,
phase=self.phase,
order=self.order,
parentWin=self,
}
self:showWindow("UIWDCQLiveBroadcastRoomLotteryWin",args)
end


function UIWDCQLiveBroadcastRoomMainWin:onShopBtn()
if not wdcqLiveBroadcastRoomModel:isSameRoom(self.group,self.phase,self.order)then return end

if not wdcqLiveBroadcastRoomModel:haveShopData(self.phase)then
wdcqLiveBroadcastRoomController:send_38_32()
end

wdcqLiveBroadcastRoomController:send_38_30()

local args={
group=self.group,
phase=self.phase,
order=self.order,
parentWin=self,
}
self:showWindow("UIWDCQLiveBroadcastRoomShopWin",args)
end


function UIWDCQLiveBroadcastRoomMainWin:onWatchBtn()
local group=self.group
local phase=self.phase
local order=self.order
WDCQController:Req_FightReplay(group,phase,order,true,nil,function()
wdcqLiveBroadcastRoomController:enterLiveRoom(group,phase,order)
end)
end

function UIWDCQLiveBroadcastRoomMainWin:onPedlar()
self:onShopBtn()
end

function UIWDCQLiveBroadcastRoomMainWin:onShopArrow()
self:onShopBtn()
end

function UIWDCQLiveBroadcastRoomMainWin:onAlpace()
self:onShopBtn()
end

function UIWDCQLiveBroadcastRoomMainWin.onWDCQLiveBroadcastRoomHotChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshHotNum()
end
end

function UIWDCQLiveBroadcastRoomMainWin.onWDCQLiveBroadcastRoomPeopleChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshPeopleNum()
end
end

function UIWDCQLiveBroadcastRoomMainWin.onWDCQLiveBroadcastRoomDrawChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshPrizePoolBtnTx()
end
end

function UIWDCQLiveBroadcastRoomMainWin.onWDCQLiveBroadcastRoomTotalHotChange()
_this:refreshPedlarReddot()
end

function UIWDCQLiveBroadcastRoomMainWin.onRequestPhpServerNamesRecv(secFlag)
if secFlag then
for indexId=1,2 do
local component=indexId==1 and _this.leftPlayer or _this.rightPlayer
local serverId=_this.matchInfo[FMT.fmt("server_id_{0}",indexId)]
local actorId=_this.matchInfo[FMT.fmt("actor_id_{0}",indexId)]
local widget=component:getChildWidgetBase()
local serverName=loginModel:getServerNameEx(serverId,"")
local isSelf=playerModel:checkActorId(actorId)
widget:SetChildText(_playerCmp.serverTx,isSelf and FMT.cfmt3('549327',serverName)or serverName)
end
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_26()
if wdcqLiveBroadcastRoomModel:isSameRoom(_this.group,_this.phase,_this.order)then
_this:refreshView()
_this:startShowGiftTick()
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_27()
if not wdcqLiveBroadcastRoomModel:isSameRoom(_this.group,_this.phase,_this.order)then
chatControl.clearChannelMesg(_this.channelId)
WDCQController:removeBookWinWhenLiveRoomClose(_this.group,_this.phase,_this.order)
_this:doCloseWin()
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_31()
if wdcqLiveBroadcastRoomModel:isSameRoom(_this.group,_this.phase,_this.order)then
_this:startShowGiftTick()
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_1()
if not WDCQController.checkInTheGame2()then
_this:onBackButton()
return
end

_this:updateData()
_this:refreshCompetition()
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_8(group,phase,order)
if wdcqLiveBroadcastRoomModel:isSameRoom(_this.group,_this.phase,_this.order)then
_this:updateData()
_this:refreshCompetition()
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_3(args)
if args[1]==_this.group and args[2]==_this.phase and args[3]==_this.order then
if _this.haveSelfActor then
_this:refreshPrepareTips()
end
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_4(args)
if args[1]==_this.group and args[2]==_this.phase and args[3]==_this.order then
if _this.haveSelfActor then
_this:refreshPrepareTips()
end
end
end

function UIWDCQLiveBroadcastRoomMainWin.on_38_5(group,phase,order)
if group==_this.group and phase==_this.phase and order==_this.order then
if _this.haveSelfActor then
_this:refreshPrepareTips()
end
end
end

function UIWDCQLiveBroadcastRoomMainWin:updateData()
self.matchInfo=WDCQController.getMacthInfo(self.group,self.phase,self.order)
local main,sub,idx=WDCQController.getMacthStage(self.group,self.phase,self.order)
local stage,time,subTime=_converStageHandle[main][sub or _converStageSubEmptyValue](self.roundCfg,self.roomOpen,self.roomClose,idx)
local oStage=self.stage
self.stage=stage
self.stageTime=time
self.subTime=subTime
self:startCDTick()

if oStage~=eWDCQLiveRoomMatchStageEnum.eWatchFight and stage==eWDCQLiveRoomMatchStageEnum.eWatchFight then
if not WDCQModel:haveFightRecord(self.group,self.phase,self.order)then
self:delayDo(1,function()
if self.stage==eWDCQLiveRoomMatchStageEnum.eWatchFight then
self:onWatchBtn()
end
end)
end
end
end

function UIWDCQLiveBroadcastRoomMainWin:initData()
self.roomClose=WDCQController.getGameEnterEndTime()
self.roomOpen=WDCQController.getGameStartTime()
self.matchCfg=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,self.group,self.phase)
self.roundCfg=WDCQController.getRoundCfg(self.group,self.phase,self.order)
self.pedlarSegment={}
if self.matchCfg.xiaofan_conf then
for i,v in ipairs(self.matchCfg.xiaofan_conf)do
local sTime=self.roomOpen+86400*v[1]+3600*v[2]+60*v[3]+v[4]
local eTime=sTime+v[5]
local timeConf={sTime,eTime}
table.insert(self.pedlarSegment,timeConf)
end
end
self.channelId=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"chatChannel",self.group)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshView()
self:refreshPedlarModel()
self:refreshPrepareBtn()
self:refreshPeopleNum()
self:refreshHotNum()
self:refreshPrizePoolBtnTx()

self:refreshCompetitionTitle()
self:refreshCompetitionOrder()
self:refreshCompetitionState()
self:refreshCompetitionGuess()
self:refreshCompetitionPlayback()
self:refreshCompetitionWatch()
self:refreshCompetitionLeastCD()
self:refreshCompetitionPlayer(true)
self:refreshCompetitionPlayer(false)
end

function UIWDCQLiveBroadcastRoomMainWin:initView()
self:initChatHandle()
self:initHotNum()
self:initPrizePoolBtn()
self:initHotRankBtn()

self:startSpectatorTick()
end

function UIWDCQLiveBroadcastRoomMainWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIWDCQLiveBroadcastRoomMainWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime>self.stageTime then
if self.stage==eWDCQLiveRoomMatchStageEnum.eBanDisciple then
WDCQController.req_38_8(self.group,self.phase,self.order)
end

if not WDCQController:checkInTheGame2()then

UIManager.info("全部比赛已结束, 房间关闭")
self:onBackButton()
else
self:updateData()
self:refreshCompetition()
self:refreshPrepareBtn()
end
elseif self.subTime and nowTime>self.subTime then
self:updateData()
self:refreshPrepareTips()
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshPedlarModel()
self.pedlarTime=nil
self.pedlarTime2=nil
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(self.pedlarSegment)do
if v[1]<=nowTime and nowTime<v[2]then
self.pedlarTime=v[2]
self.pedlarTime2=nil
break
elseif nowTime<v[1]then
self.pedlarTime2=self.pedlarTime2 and math.min(self.pedlarTime2,v[1])or v[1]
end
end

self.pedlar:setActive(self.pedlarTime~=nil)
self:refreshPedlarReddot()

if self.pedlarTime~=nil or self.pedlarTime2~=nil then
self:startPedlarTick()
else
self:stopPedlarTick()
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshPedlarReddot()
local reddot=wdcqLiveBroadcastRoomModel:getTotalHotReddot()
self.shopReddot:setActive(reddot)
end

function UIWDCQLiveBroadcastRoomMainWin:startPedlarTick()
if self.pedlarTime then
if not self.pedlarBT then
local enter=self.pedlarTick~=nil
self.pedlar:setChildCanvasGroupAlpha(enter and 0 or 1)
self.alpace:setChildCanvasGroupAlpha(enter and 0 or 1)
if enter then
local pos=self.pedlar:getChildAnchoredPosition()
self.pedlarEffect:setChildAnchoredPosition(pos)
local pos2=self.alpace:getChildAnchoredPosition()
self.alpaceEffect:setChildAnchoredPosition(pos+pos2)
end
local args={
widget=self.winlua,
pedlar=self.pedlar:getID(),
effect1=self.pedlarEffect:getID(),
effect2=self.alpaceEffect:getID(),
alpace=self.alpace:getID(),
arrow=self.shopArrow:getID(),
speak="",
flip=false,
enter=enter,
}
self.pedlarBT=behaviorManager:addBehaviorTree("bt_ui_wdcqzbj_pedlar",nil,true,args,true)
end
else
if self.pedlarBT then
behaviorManager:removeBehaviorTree(self.pedlarBT)
self.pedlarBT=nil
end
end
if not self.pedlarTick then
self:updatePedlarTick()
self.pedlarTick=self:setTimer(1,0,function()
self:updatePedlarTick()
end)
end
end

function UIWDCQLiveBroadcastRoomMainWin:stopPedlarTick()
if self.pedlarTick then
self:stopTimerByID(self.pedlarTick)
self.pedlarTick=nil
end
if self.pedlarBT then
behaviorManager:removeBehaviorTree(self.pedlarBT)
self.pedlarBT=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:updatePedlarTick()
local nowTime=timeHelper.getServerShortTime()
local time=self.pedlarTime or self.pedlarTime2
if time==nil or nowTime>=time then
self:refreshPedlarModel()
return
end
if self.pedlarTime then
self.pedlarCDTx:setText(timeHelper.format_time_stamp(self.pedlarTime-nowTime,true))
end
end

function UIWDCQLiveBroadcastRoomMainWin:randomModelSpeak(bt)
local r=math.random(1,#self.merchatSpeakLib)
local index=table.remove(self.merchatSpeakLib,r)
local speakStr=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"merchantSpeak")
bt:setSharedVar("speak",speakStr[index])

if#self.merchatSpeakLib<=0 then
for i=1,self.merchatSpeakCnt do
table.insert(self.merchatSpeakLib,i)
end
end
end

function UIWDCQLiveBroadcastRoomMainWin:randomModelPosition(bt)
local flip=bt:getSharedVar("flip")
local rPX=flip and math.random(-10,190)or math.random(-210,-10)
local rAX=flip and 90 or-90
bt:setSharedVar("pPos",{rPX,-135})
bt:setSharedVar("aPos",{rAX,0})
bt:setSharedVar("flip",not flip)
bt:setSharedVar("arrowPos",{flip and 100 or-100,75})
bt:setSharedVar("arrowRot",{0,flip and 0 or 180,0})
end

function UIWDCQLiveBroadcastRoomMainWin:refreshPrepareBtn()
local show=false
if self.stage<eWDCQLiveRoomMatchStageEnum.eWaitFight then
for i=1,2 do
local actorid=self.matchInfo[FMT.fmt("actor_id_{0}",i)]
show=show or playerModel:checkActorId(actorid)
end
end
self.prepareBtn:setActive(show)
self.haveSelfActor=show
if show then
self:refreshPrepareTips()
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshPrepareTips()
if eWDCQLiveRoomMatchStageEnum.eSelectDisciple<=self.stage and self.stage<=eWDCQLiveRoomMatchStageEnum.eAdjustTeam then
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.group,self.phase,self.order)
local isSelfPlayer1=playerModel:checkActorId(self.matchInfo.actor_id_1)
local selfActorId=isSelfPlayer1 and self.matchInfo.actor_id_1 or self.matchInfo.actor_id_2
local otherActorId=isSelfPlayer1 and self.matchInfo.actor_id_2 or self.matchInfo.actor_id_1
local finish,tipsStr=WDCQController.checkPreStageFlag(selfActorId,preStage,adjustStage,otherActorId)
local posCheck=true
if adjustStage then
posCheck=WDCQController.checkAdjustTeamPos(adjustStage,isSelfPlayer1 and WDCQCAdjustTeamPosEnum.eLeft or WDCQCAdjustTeamPosEnum.eRight)
end
self.prepareTips:setActive(not finish and posCheck)
self.prepareTipsTx:setText(tipsStr)
else
self.prepareTips:setActive(false)
self.prepareTipsTx:setText("")
end
end

function UIWDCQLiveBroadcastRoomMainWin:initHotRankBtn()
self.hotRankBtn:setActive(self.phase==WDCQCGameStageEnum.eChampion)
end

function UIWDCQLiveBroadcastRoomMainWin:initPrizePoolBtn()
local show=self.phase==WDCQCGameStageEnum.eChampion
self.prizePoolBtn:setActive(show)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshPrizePoolBtnTx()
if self.phase==WDCQCGameStageEnum.eChampion then
local draw=wdcqLiveBroadcastRoomModel:getRoomDraw()
self.prizePoolTx:setText(FMT.fmt("剩余{0}次",draw))
self.prizePoolReddot:setActive(draw>0)
end
end





































function UIWDCQLiveBroadcastRoomMainWin:refreshPeopleNum()
local num=wdcqLiveBroadcastRoomModel:getRoomPeople()
self.peopleTx:setText(mathHelper.formatNumber(num))
end

function UIWDCQLiveBroadcastRoomMainWin:initHotNum()
local show=self.phase==WDCQCGameStageEnum.eChampion
self.hotNum:setActive(show)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshHotNum()
if self.phase==WDCQCGameStageEnum.eChampion then
local num=wdcqLiveBroadcastRoomModel:getRoomHot()
self.hotTx:setText(mathHelper.formatNumber(num))
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetition()


self:refreshCompetitionState()
self:refreshCompetitionGuess()
self:refreshCompetitionPlayback()
self:refreshCompetitionWatch()
self:refreshCompetitionLeastCD()
self:refreshCompetitionPlayer(true)
self:refreshCompetitionPlayer(false)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionTitle()
local titleImage=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"matchname",self.phase)
if self.phase==WDCQCGameStageEnum.eChampion or self.phase==WDCQCGameStageEnum.eThird then
self.titleImageEx:setChildAnchoredPos(0,-52)
self.titleImage:setChildAnchoredPos(0,-101.7)
else
self.titleImageEx:setChildAnchoredPos(-56.8,-52)
self.titleImage:setChildAnchoredPos(72.2,-52)
end
self.titleImage:setSprite(_abName,titleImage)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionOrder()
local orderStr=""
if#self.matchCfg.time_conf>1 then
orderStr=FMT.fmt("第{0}场",self.order)
end
self.orderTx:setText(orderStr)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionState()
local stateStr,posY=_competitionStageName[self.stage](self.matchInfo)
self.stateTx:setText(stateStr)
self.stateTx:setChildAnchoredPos(0,posY)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionGuess()
local show=self.stage<eWDCQLiveRoomMatchStageEnum.eWatchFight
self.guessBtn:setActive(show)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionPlayback()
local show=self.stage>eWDCQLiveRoomMatchStageEnum.eWatchFight
self.playbackBtn:setActive(show)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionWatch()
local show=self.stage==eWDCQLiveRoomMatchStageEnum.eWatchFight
self.watchBtn:setActive(show)
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionLeastCD()
local show=self.stage~=eWDCQLiveRoomMatchStageEnum.eWatchFight
self.cdTx:setActive(show)
if show then
local tipsStr=""
self.timeline=nil
if self.stage<eWDCQLiveRoomMatchStageEnum.eWatchFight then
tipsStr="距离对决开始"
self.cdTx:setChildAnchoredPos(15,-47)
self.timeline=self.roundCfg.startTime

else
tipsStr="距离擂台关闭"
self.cdTx:setChildAnchoredPos(15,-60.5)
self.timeline=self.roomClose




end
self.cdTips:setText(tipsStr)

local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.timeline-nowTime
self.cdTx:setText(timeHelper.format_time_stamp3(math.max(deltaTime,0),true))
if deltaTime>=0 then
self:startCompetitionCDTick()
else
self:stopCompetitionCDTick()
end
else
self:stopCompetitionCDTick()
end
end

function UIWDCQLiveBroadcastRoomMainWin:startCompetitionCDTick()
if not self.leastTick then
self.leastTick=self:setTimer(1,0,function()
self:updateCompetitionLeastCD()
end)
end
end

function UIWDCQLiveBroadcastRoomMainWin:stopCompetitionCDTick()
if self.leastTick then
self:stopTimerByID(self.leastTick)
self.leastTick=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:updateCompetitionLeastCD()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.timeline-nowTime
if deltaTime>=0 then
self.cdTx:setText(timeHelper.format_time_stamp3(math.max(deltaTime,0),true))
else
self:refreshCompetitionLeastCD()
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshCompetitionPlayer(isLeft)
local component=isLeft and self.leftPlayer or self.rightPlayer
local indexId=isLeft and 1 or 2

local serverId=self.matchInfo[FMT.fmt("server_id_{0}",indexId)]
local iconInfo=self.matchInfo[FMT.fmt("iconInfo{0}",indexId)]
local actorName=self.matchInfo[FMT.fmt("name_{0}",indexId)]
local actorId=self.matchInfo[FMT.fmt("actor_id_{0}",indexId)]
local banList=self.matchInfo[FMT.fmt("banDiziList{0}",indexId)]or{}

local widget=component:getChildWidgetBase()
local attach={serverid=serverId}
local showBan=self.stage>eWDCQLiveRoomMatchStageEnum.eBanDisciple
local banCount=showBan and#banList or 0
local serverName=loginModel:getServerNameEx(serverId,"")
local isSelf=playerModel:checkActorId(actorId)
local showVictory=self.stage>eWDCQLiveRoomMatchStageEnum.eWatchFight and mathHelper.compareInt64(self.matchInfo.win_actor_id,actorId)
playerController:setHeadIcon(widget,_playerCmp.head,{iconInfo=iconInfo})
widget:SetChildText(_playerCmp.nameTx,isSelf and FMT.cfmt3('549327',actorName)or actorName)
widget:SetChildText(_playerCmp.serverTx,isSelf and FMT.cfmt3('549327',serverName)or serverName)
widget:SetChildActive(_playerCmp.sameServer,loginModel:isMySameServerZoneByServerID(serverId))
widget:SetChildActive(_playerCmp.victory,showVictory)
widget:SetChildActive(_playerCmp.banList,self.stage>eWDCQLiveRoomMatchStageEnum.eBanDisciple)

widget:SetChildLayoutGroupCreateItems(_playerCmp.banList,banCount,function(index)
local item=widget:GetChildLayoutGroupGridItem(_playerCmp.banList,index-1)
local data=banList[index]
local imageInfo=UIDiscipleModel.calculationDiscipleImage(data.param_3,data.param_1)
local color=0
local job=imageInfo.job
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
local jobicon=UIDiscipleModel:getJobIconName(job)
comHelper.setChildModelRawImageEx(_banCmp.head,item,modelParams,eHeadCenterType.eHead,1)
comHelper.setChildModelHeadIconBGByColor(item,_banCmp.widget,color)
item:SetChildCSImageSprite(_banCmp.job,globalABLookup.global,jobicon)



end)

widget:SetChildButtonClick(_playerCmp.headBg,function()

WDCQController:reqShowWDCQZRInfo(actorId)
end)
end

function UIWDCQLiveBroadcastRoomMainWin:onRecvMesg(mesg)
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

function UIWDCQLiveBroadcastRoomMainWin:regChatHandle()
local handler=self.handler
if handler then return end

local channelId=self.channelId

handler=chatMessageHandler.create(channelId,self)

self.handler=handler
chatControl.addHandler(channelId,handler)
end

function UIWDCQLiveBroadcastRoomMainWin:unregChatHandle()
local handler=self.handler
if not handler then return end
local channelId=self.channelId
self.handle=nil
chatControl.deleteHandler(channelId,handler)
end


function UIWDCQLiveBroadcastRoomMainWin:chatRegex(mesg)
return string.find(mesg,chatConfig.chatRegex)~=nil
end

function UIWDCQLiveBroadcastRoomMainWin:shareQieCuoInfo(mesg)
return string.find(mesg,chatConfig.shareQieCuoInfo)~=nil
end

function UIWDCQLiveBroadcastRoomMainWin:shareDiscipleInfo(mesg)
return(string.find(mesg,chatConfig.shareDiscipleInfo)or
string.find(mesg,chatConfig.shareDiscipleInfoFormat))~=nil
end

function UIWDCQLiveBroadcastRoomMainWin:voiceRegex(mesg)
return(string.find(mesg,chatConfig.voiceRegex)or
string.find(mesg,chatConfig.voiceString))~=nil
end

function UIWDCQLiveBroadcastRoomMainWin:linkRegex(mesg)
return(string.find(mesg,chatConfig.linkRegex)or
string.find(mesg,chatConfig.linkRegexFormat)or
string.find(mesg,chatConfig.linkRegexFormatEx))~=nil
end

function UIWDCQLiveBroadcastRoomMainWin:actRegex(mesg)
return string.find(mesg,chatConfig.actRegex)~=nil
end


function UIWDCQLiveBroadcastRoomMainWin:onRecvPublicMessage(channelId,chatInfo)
local isBigEmoji=chatEmotHelper.containsBigEmot(chatInfo.mesg)
local isVoiceRegex=self:voiceRegex(chatInfo.mesg)
local isLinkRegex=self:linkRegex(chatInfo.mesg)
local isActRegex=self:actRegex(chatInfo.mesg)
local isChatRegex=self:chatRegex(chatInfo.mesg)
local isShareQieCuoInfo=self:shareQieCuoInfo(chatInfo.mesg)
local isShareDiscipleInfo=self:shareDiscipleInfo(chatInfo.mesg)

if isBigEmoji or isActRegex or isLinkRegex or isVoiceRegex or isChatRegex or isShareQieCuoInfo or isShareDiscipleInfo then return end

local actorId=playerModel:getActorID()
local name=chatInfo.actorInfo.actorName
local serverId=string.format("[%s服]",chatInfo.actorInfo.serverId)
if actorId==chatInfo.actorInfo.actorId then
name="我"
serverId=""
end

local mesg=FMT.fmt("<color=#ffe699>{2}{0}</color>: {1}",name,chatInfo.mesg,serverId)

self:delayDo(2,function()
self:onRecvMesg(mesg)
end)
end

function UIWDCQLiveBroadcastRoomMainWin:initChatHandle()
local isChampion=self.phase==WDCQCGameStageEnum.eChampion
self.chatButton:setActive(isChampion)
if isChampion then
self:regChatHandle()
self.isRegisterChat=true
end
end

















function UIWDCQLiveBroadcastRoomMainWin:startShowGiftTick()
if not self.showGiftTick and self.phase==WDCQCGameStageEnum.eChampion then
self.showGiftTick=self:setTimer(_showGiftItemInterval,0,function()
self:updateShowGiftTick()
end)
end
end

function UIWDCQLiveBroadcastRoomMainWin:stopShowGiftTick()
if self.showGiftTick then
self:stopTimerByID(self.showGiftTick)
self.showGiftTick=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:updateShowGiftTick()
local oldList=self.showingGiftCache[self.showingGiftIndex]
local newIdx=bit.bxor(self.showingGiftIndex,1)
local maxCount=#_showGiftItemPosY
local newList=self.showingGiftCache[newIdx]
table.clear(newList)
table.clear(self.showingGiftTweens)
self.showingGiftIndex=newIdx

local move=false
if next(oldList)~=nil then
local check=false
for i=1,maxCount do
local info=oldList[i]
if info==nil then
check=true
else
info.cd=info.cd-1
table.insert(newList,info)
if check then
move=true
end
check=false
end
end
end
if move then
for i,v in ipairs(newList)do
local item=self.giftItem[v.item]
self:moveShowGiftAnim(item,i)
end
return
end


local exit={}
for i,v in ipairs(newList)do
if v.cd<=0 then
local item=self.giftItem[v.item]
self:exitShowGiftAnim(item)
table.insert(exit,i)
end
end

if#exit>0 then
for i,v in ipairs(exit)do
newList[v]=nil
end
return
end


local enter=false
for idx,item in ipairs(self.giftItem)do
local on=false
for i,v in ipairs(newList)do
if v.item==idx then
on=true
break
end
end

if not on then
local data=wdcqLiveBroadcastRoomModel:popGiftInfo()
if data then
local pos=#newList+1
self:refreshShowGiftItem(item,data)
self:enterShowGiftAnim(item,pos)
table.insert(newList,{item=idx,cd=_showGiftItemDuration})
self:showGiftEffect(data)
enter=true
end
end
end

if not enter and next(newList)==nil then
self:stopShowGiftTick()
return
end
end

function UIWDCQLiveBroadcastRoomMainWin:refreshShowGiftItem(item,giftData)
local widget=item:getChildWidgetBase()
local giftCfg=cfgHelper.get1(cfg_wendingcangqiongreduitemconfig_get,giftData.giftId)

playerController:setRawImageHeadIcon(widget,_giftCmp.head,{iconInfo=giftData.actorIcon})
widget:SetChildText(_giftCmp.playerName,giftData.actorName)
local serverName=loginModel:getServerNameEx(giftData.serverId,"")
widget:SetChildText(_giftCmp.serverName,serverName)
widget:SetChildText(_giftCmp.giftName,FMT.fmt("送出{0}",itemsConfig.getItemName(giftCfg.item)))
widget:SetChildText(_giftCmp.giftNum,FMT.fmt("X{0}",giftData.giftNum))

widget:SetChildCSImageIcon(_giftCmp.giftIcon,iconHelper.getIconName(giftCfg.item),true)






end

function UIWDCQLiveBroadcastRoomMainWin:enterShowGiftAnim(item,pos)




local widget=item:getChildWidgetBase()
widget:SetChildAnchoredPos(_giftCmp.widget,0,_showGiftItemPosY[pos])
widget:SetChildCanvasGroupAlpha(_giftCmp.widget,1)
widget:SetChildCanvasGroupAlpha(_giftCmp.root,0)
widget:SetChildModelAnimationState(_giftCmp.background,eAnimationID.enter,2)
local tweener=widget:SetChildCanvasGroupDOFade(_giftCmp.root,1,_showGiftItemInterval)
tweener:SetEase(DG.Tweening.Ease.Linear)
table.insert(self.showingGiftTweens,tweener)
end

function UIWDCQLiveBroadcastRoomMainWin:exitShowGiftAnim(item)
local tweener=item:setChildCanvasGroupDOFade(0,_showGiftItemInterval)
tweener:SetEase(DG.Tweening.Ease.Linear)
table.insert(self.showingGiftTweens,tweener)
end

function UIWDCQLiveBroadcastRoomMainWin:moveShowGiftAnim(item,pos)
local tweener=item:setChildDOAnchorPosY(_showGiftItemPosY[pos],_showGiftItemInterval)
tweener:SetEase(DG.Tweening.Ease.Linear)
table.insert(self.showingGiftTweens,tweener)
end

function UIWDCQLiveBroadcastRoomMainWin:showGiftEffect(giftData)
table.insert(self.giftEffectCache,giftData)
if not self.giftTween then
self:nextGiftEffect()
end
end

function UIWDCQLiveBroadcastRoomMainWin:nextGiftEffect()
if#self.giftEffectCache>0 then
local giftData=table.remove(self.giftEffectCache,1)
local effect=cfgHelper.get2(cfg_wendingcangqiongreduitemconfig_get,giftData.giftId,"effect")
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,effect)
local duration=effectCfg.lifetime/1000

self.giftEffect:setChildShowEffect(effect,true)
self.giftMask:setChildCanvasGroupAlpha(1)
self.giftTween=self.giftMask:setChildCanvasGroupDOFade(0,0.5,function()
self.giftTween=nil
self:nextGiftEffect()
end)
self.giftTween:SetDelay(duration-0.5)
end
end

function UIWDCQLiveBroadcastRoomMainWin:killGiftTween()
if self.giftTween and self.giftTween:IsActive()then
self.giftTween:Kill()
self.giftTween=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:initSpectatorSpeak()
self.spectatorWidget={}
for i,v in ipairs(self.spectator)do
local transform=v:getCommonComponent("Transform")
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,transform,function(id)
local widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
widget:SetChildCSImageSprite(1,abName,skinName)
widget:SetChildActive(2,false)
self.spectatorWidget[i]=widget
end)
end
self.spectatorCfg=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"spectatorSpeaking")
end

function UIWDCQLiveBroadcastRoomMainWin:startSpectatorTick()
if not self.spectatorTick then
self.spectatorSpeaking={}
local interval=self.spectatorCfg[1]
self.spectatorBT=self:setTimer(interval,0,function()
self:updateSpectatorTick()
end)
end
end

function UIWDCQLiveBroadcastRoomMainWin:stopSpectatorTick()
if self.spectatorTick then
self:stopTimerByID(self.spectatorTick)
self.spectatorTick=nil
end
end

function UIWDCQLiveBroadcastRoomMainWin:updateSpectatorTick()
if not self.spectatorCheck then
local check=true
for i,v in ipairs(self.spectator)do
if not self.spectatorWidget[i]then
check=false
break
end
end
self.spectatorCheck=check
end
if not self.spectatorCheck then return end

local count=#self.spectator
local r=math.random(1,count)
local duration=self.spectatorCfg[2]
for i=1,count do
local index=r+i-1
index=index>count and(index-count)or index
if self.spectatorSpeaking[index]==nil then
local widget=self.spectatorWidget[index]
local lib=self.spectatorCfg[3]
local content=lib[math.random(1,#lib)]
local txt=chatEmotHelper.decodeEmot(content)or''
widget:SetChildText(0,txt)
widget:SetChildActive(2,true)
self.spectatorSpeaking[index]=self:delayDo(duration,function()
widget:SetChildActive(2,false)
self.spectatorSpeaking[index]=nil
end)
return
end
end
end