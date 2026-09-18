







def_class("UIWDCQGuessWin",UIWindowBase)









function UIWDCQGuessWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.playerRoot1=UIObject.get(self,1)
self.playerRoot2=UIObject.get(self,2)
self.guessRoot=UIObject.get(self,3)
self.moneyIocn=UIImage.get(self,4)
self.moneyTxt=UIText.get(self,5)
self.player1supportInfo=UIObject.get(self,6)
self.player2supportInfo=UIObject.get(self,7)
self.cntericon=UIObject.get(self,8)
self.subtitle=UIText.get(self,9)
self.selectCntSlider=UIObject.get(self,10)
self.subBtn=UIButton.get(self,11)
self.addBtn=UIButton.get(self,12)
self.maxBtn=UIButton.get(self,13)
self.selectCntText=UIText.get(self,14)
self.timeTitle=UIText.get(self,15)
self.timeTxt=UIText.get(self,16)
self.tips=UIText.get(self,17)
self.surebtn=UIButton.get(self,18)
self.xiazhuIcon=UIImage.get(self,19)
self.resultImg=UIImage.get(self,20)
self.resultIcon=UIObject.get(self,21)
self.resultIMoney=UIText.get(self,22)
self.none=UIObject.get(self,23)
self.tab_1=UIObject.get(self,24)
self.tab_2=UIObject.get(self,25)
self.ZRRoot=UIObject.get(self,26)
self.SAndBRoot=UIObject.get(self,27)
self.tipsContent=UIText.get(self,28)
self.sAbtimeTxt=UIText.get(self,29)
self.adjustRoot=UIObject.get(self,30)
self.roundtitle_1=UIText.get(self,31)
self.roundtitle_2=UIText.get(self,32)
self.roundtitle_3=UIText.get(self,33)
self.fightbgList=UIObject.get(self,34)
self.fightbg_1=UIObject.get(self,35)
self.fightbg_2=UIObject.get(self,36)
self.fightbg_3=UIObject.get(self,37)
self.noneIconList=UIObject.get(self,38)
self.noneIcon_1=UIObject.get(self,39)
self.noneIcon_2=UIObject.get(self,40)
self.noneIcon_3=UIObject.get(self,41)
self.fightIcon_1=UIObject.get(self,42)
self.fightIcon_2=UIObject.get(self,43)
self.fightIcon_3=UIObject.get(self,44)
self.fightIconList=UIObject.get(self,45)
self.replayIconList=UIObject.get(self,46)
self.replayIcon_1=UIObject.get(self,47)
self.replayIcon_2=UIObject.get(self,48)
self.replayIcon_3=UIObject.get(self,49)
self.coolDownList=UIObject.get(self,50)
self.coolDownRoot_1=UIObject.get(self,51)
self.coolDownRoot_2=UIObject.get(self,52)
self.coolDownRoot_3=UIObject.get(self,53)
self.coolDownRoot_4=UIObject.get(self,54)
self.coolDownRoot_5=UIObject.get(self,55)
self.coolDownRoot_6=UIObject.get(self,56)
self.coolDown_1=UIText.get(self,57)
self.coolDown_2=UIText.get(self,58)
self.coolDown_3=UIText.get(self,59)
self.coolDown_4=UIText.get(self,60)
self.coolDown_5=UIText.get(self,61)
self.coolDown_6=UIText.get(self,62)
self.teaItemList=UIObject.get(self,63)
self.zrteamItem_1=UIObject.get(self,64)
self.zrteamItem_2=UIObject.get(self,65)
self.zrteamItem_3=UIObject.get(self,66)
self.zrteamItem_4=UIObject.get(self,67)
self.zrteamItem_5=UIObject.get(self,68)
self.zrteamItem_6=UIObject.get(self,69)
self.sureTxt=UIText.get(self,70)
self.xiazhuTxt=UIText.get(self,71)
self.handleImg=UIObject.get(self,72)
self.handleImgCenter=UIObject.get(self,73)
self.lastAdjustTipsRoot=UIObject.get(self,74)
self.lasttime=UIText.get(self,75)
self.scrollerView=UIObject.get(self,76)
self.hbIocn=UIImage.get(self,77)
self.fightIconEx=UIObject.get(self,78)
self.replayIconEx=UIButton.get(self,79)
self.Root=UIObject.get(self,80)
self.alphaMask=UIObject.get(self,81)
self.supportValueTxt1=UIText.get(self,82)
self.supportValueTxt2=UIText.get(self,83)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxBtn:setButtonClick(function()self:onMaxBtn()end)

self.surebtn:setButtonClick(function()self:onSurebtn()end)

self.replayIconEx:setButtonClick(function()self:onReplayIconEx()end)
self.tab={
self.tab_1,
self.tab_2,
}
self.roundtitle={
self.roundtitle_1,
self.roundtitle_2,
self.roundtitle_3,
}
self.fightbg={
self.fightbg_1,
self.fightbg_2,
self.fightbg_3,
}
self.noneIcon={
self.noneIcon_1,
self.noneIcon_2,
self.noneIcon_3,
}
self.fightIcon={
self.fightIcon_1,
self.fightIcon_2,
self.fightIcon_3,
}
self.replayIcon={
self.replayIcon_1,
self.replayIcon_2,
self.replayIcon_3,
}
self.coolDownRoot={
self.coolDownRoot_1,
self.coolDownRoot_2,
self.coolDownRoot_3,
self.coolDownRoot_4,
self.coolDownRoot_5,
self.coolDownRoot_6,
}
self.coolDown={
self.coolDown_1,
self.coolDown_2,
self.coolDown_3,
self.coolDown_4,
self.coolDown_5,
self.coolDown_6,
}
self.zrteamItem={
self.zrteamItem_1,
self.zrteamItem_2,
self.zrteamItem_3,
self.zrteamItem_4,
self.zrteamItem_5,
self.zrteamItem_6,
}



end


function UIWDCQGuessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.playerRoot1);self.playerRoot1=nil;
_UIObject_release(self.playerRoot2);self.playerRoot2=nil;
_UIObject_release(self.guessRoot);self.guessRoot=nil;
_UIObject_release(self.moneyIocn);self.moneyIocn=nil;
_UIObject_release(self.moneyTxt);self.moneyTxt=nil;
_UIObject_release(self.player1supportInfo);self.player1supportInfo=nil;
_UIObject_release(self.player2supportInfo);self.player2supportInfo=nil;
_UIObject_release(self.cntericon);self.cntericon=nil;
_UIObject_release(self.subtitle);self.subtitle=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.maxBtn);self.maxBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.surebtn);self.surebtn=nil;
_UIObject_release(self.xiazhuIcon);self.xiazhuIcon=nil;
_UIObject_release(self.resultImg);self.resultImg=nil;
_UIObject_release(self.resultIcon);self.resultIcon=nil;
_UIObject_release(self.resultIMoney);self.resultIMoney=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.ZRRoot);self.ZRRoot=nil;
_UIObject_release(self.SAndBRoot);self.SAndBRoot=nil;
_UIObject_release(self.tipsContent);self.tipsContent=nil;
_UIObject_release(self.sAbtimeTxt);self.sAbtimeTxt=nil;
_UIObject_release(self.adjustRoot);self.adjustRoot=nil;
_UIObject_release(self.roundtitle_1);self.roundtitle_1=nil;
_UIObject_release(self.roundtitle_2);self.roundtitle_2=nil;
_UIObject_release(self.roundtitle_3);self.roundtitle_3=nil;
_UIObject_release(self.fightbgList);self.fightbgList=nil;
_UIObject_release(self.fightbg_1);self.fightbg_1=nil;
_UIObject_release(self.fightbg_2);self.fightbg_2=nil;
_UIObject_release(self.fightbg_3);self.fightbg_3=nil;
_UIObject_release(self.noneIconList);self.noneIconList=nil;
_UIObject_release(self.noneIcon_1);self.noneIcon_1=nil;
_UIObject_release(self.noneIcon_2);self.noneIcon_2=nil;
_UIObject_release(self.noneIcon_3);self.noneIcon_3=nil;
_UIObject_release(self.fightIcon_1);self.fightIcon_1=nil;
_UIObject_release(self.fightIcon_2);self.fightIcon_2=nil;
_UIObject_release(self.fightIcon_3);self.fightIcon_3=nil;
_UIObject_release(self.fightIconList);self.fightIconList=nil;
_UIObject_release(self.replayIconList);self.replayIconList=nil;
_UIObject_release(self.replayIcon_1);self.replayIcon_1=nil;
_UIObject_release(self.replayIcon_2);self.replayIcon_2=nil;
_UIObject_release(self.replayIcon_3);self.replayIcon_3=nil;
_UIObject_release(self.coolDownList);self.coolDownList=nil;
_UIObject_release(self.coolDownRoot_1);self.coolDownRoot_1=nil;
_UIObject_release(self.coolDownRoot_2);self.coolDownRoot_2=nil;
_UIObject_release(self.coolDownRoot_3);self.coolDownRoot_3=nil;
_UIObject_release(self.coolDownRoot_4);self.coolDownRoot_4=nil;
_UIObject_release(self.coolDownRoot_5);self.coolDownRoot_5=nil;
_UIObject_release(self.coolDownRoot_6);self.coolDownRoot_6=nil;
_UIObject_release(self.coolDown_1);self.coolDown_1=nil;
_UIObject_release(self.coolDown_2);self.coolDown_2=nil;
_UIObject_release(self.coolDown_3);self.coolDown_3=nil;
_UIObject_release(self.coolDown_4);self.coolDown_4=nil;
_UIObject_release(self.coolDown_5);self.coolDown_5=nil;
_UIObject_release(self.coolDown_6);self.coolDown_6=nil;
_UIObject_release(self.teaItemList);self.teaItemList=nil;
_UIObject_release(self.zrteamItem_1);self.zrteamItem_1=nil;
_UIObject_release(self.zrteamItem_2);self.zrteamItem_2=nil;
_UIObject_release(self.zrteamItem_3);self.zrteamItem_3=nil;
_UIObject_release(self.zrteamItem_4);self.zrteamItem_4=nil;
_UIObject_release(self.zrteamItem_5);self.zrteamItem_5=nil;
_UIObject_release(self.zrteamItem_6);self.zrteamItem_6=nil;
_UIObject_release(self.sureTxt);self.sureTxt=nil;
_UIObject_release(self.xiazhuTxt);self.xiazhuTxt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImgCenter);self.handleImgCenter=nil;
_UIObject_release(self.lastAdjustTipsRoot);self.lastAdjustTipsRoot=nil;
_UIObject_release(self.lasttime);self.lasttime=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.hbIocn);self.hbIocn=nil;
_UIObject_release(self.fightIconEx);self.fightIconEx=nil;
_UIObject_release(self.replayIconEx);self.replayIconEx=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.alphaMask);self.alphaMask=nil;
_UIObject_release(self.supportValueTxt1);self.supportValueTxt1=nil;
_UIObject_release(self.supportValueTxt2);self.supportValueTxt2=nil;
self.tab=nil;
self.roundtitle=nil;
self.fightbg=nil;
self.noneIcon=nil;
self.fightIcon=nil;
self.replayIcon=nil;
self.coolDownRoot=nil;
self.coolDown=nil;
self.zrteamItem=nil;
end


















local tabCfg={
{
name="竞猜",
showFun=function(win)
win.guessRoot:setActive(true)
win.ZRRoot:setActive(false)
win:refreshGuessContent()
end,
closeFun=function(win)
win.guessRoot:setActive(false)
end,
refreshFun=function(win)
win:refreshGuessContent()
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
},
{
name="阵容",
showFun=function(win)
win.guessRoot:setActive(false)
win.ZRRoot:setActive(true)
win:refreshZRContent()
end,
closeFun=function(win)
win.ZRRoot:setActive(false)
end,
refreshFun=function(win)
win:refreshZRContent()
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
},
}

local tabCmp={
model=0,
name=1,
reddot=2,
click=3,
}
local _menu_slot_name='button_dytab'

local playerItemCmpIndex={
winFlag=0,
headIocn=1,
selfSerFlag=2,
name=3,
failFlag=4,
selfFlag=5,
noPeo=6,
severName=7,
zan=8,
headBg=9,
click=10
}

local supportInfoCmpIndex={
supportFlag=0,
supportBtn=1,
supportValueImg=2,
guessedIcon=3,
guessCnt=4,
}


local guessState={
guessIng=0,
guessEnd=1,
}

local teamShowState={
eNone=0,
eAjusting=1,
eWaiting=2,
eShowDz=3,
eNoDZ=4,
}

local teamListCfg={
{teamIndex=1,playerIndex=1},
{teamIndex=1,playerIndex=2},
{teamIndex=2,playerIndex=2},
{teamIndex=2,playerIndex=1},
{teamIndex=3,playerIndex=1},
{teamIndex=3,playerIndex=2},
}

local zrTeamItemCmp={
adjusting=0,
waiting=1,
hss=2,
headSlotList={3,4,5,6,7},
nodztips=8,
lastTips=9,
winFlag=10,
failFlag=11,
adjustingTxt=12,
effect=13,
layout=14,
houpailayout=15,
qianpailayout=16,
houpaioneBg=17,
houpaitwoBg=18,
qianpaipaioneBg=19,
qianpaitwoBg=20,
fightroot=21,
fight=22
}

local infoItemCmp={
roundTitle=0,
subBg=1,
replayIcon=2,
fightIcon=3,
noData=4,
teamItemL=5,
teamItemR=6,
InfoItem=7,

}

local teamCmp={
hss=0,
headSlotList={1,2,3,4,5},
nodzTip=6,
winFlag=7,
failFlag=8,
houpailayout=9,
qianpailayout=10,
houpaioneBg=11,
houpaitwoBg=12,
qianpaipaioneBg=13,
qianpaitwoBg=14,
fightroot=15,
fight=16
}


local abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab"


function UIWDCQGuessWin:onLoaded(...)
self:bindComponents()
self:initTabs()
local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)

end


function UIWDCQGuessWin:__delete()
self:stopAllTimer()
self:unbindComponents()
end




function UIWDCQGuessWin:onShow(argtable,afterOnloaded)
if argtable and argtable.showGuessWin then
loadingControl.closeCloud()
end
self.groupId=argtable.groupId
self.stageId=argtable.stageId
self.idx=argtable.idx
self.tabIndex=argtable.tabIndex
self.closeFunc=argtable.closeFunc or self.closeFunc
self.showLiveWin=argtable.showLiveWin or self.showLiveWin
self.selectSurActorId=WDCQController.getSuportActorId(self.groupId,self.stageId,self.idx)
self.roundCfgTemp=WDCQController.getRoundCfg(self.groupId,self.stageId,self.idx)

local playerData1=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,1)
local playerData2=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,2)

self.selfActorId=playerModel:getActorID()
self.reqList={}
if playerData1 and playerData2 then
self.actorId1=playerData1.actorId
self.actorId2=playerData2.actorId
WDCQController.req_38_2(playerData1.actorId)
WDCQController.req_38_2(playerData2.actorId)
self.reqList[mathHelper.int64_to_string(playerData1.actorId)]=true
self.reqList[mathHelper.int64_to_string(playerData2.actorId)]=true
if not mathHelper.compareInt64(self.selfActorId,playerData2.actorId)and not mathHelper.compareInt64(self.selfActorId,playerData1.actorId)then
WDCQController.req_38_2(self.selfActorId)
self.reqList[mathHelper.int64_to_string(self.selfActorId)]=true
end
else

return
end
end


function UIWDCQGuessWin:onHide()

end

function UIWDCQGuessWin:DataRecv_38_8(groupId,stageId,idx)
if self.groupId==groupId and self.stageId==stageId and self.idx==idx then
self:refresh()
end
end

function UIWDCQGuessWin:DataRecv_38_2(actor_id)
self.reqList[mathHelper.int64_to_string(actor_id)]=nil
if next(self.reqList)then
return
end




WDCQController.req_38_8(self.groupId,self.stageId,self.idx)
end


function UIWDCQGuessWin:refresh()
self.Root:setChildCanvasGroupAlpha(1)

self.Root:setChildCanvasGroupRaycast(true)


local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
local hasFight=WDCQController.checkRoundHasFight(self.groupId,self.stageId,self.idx)
if(macthStage==WDCQCMatchStageEnum.eInTheGame or macthStage==WDCQCMatchStageEnum.eEndTheGame)and hasFight then
self.replayIconEx:setActive(true)
self.fightIconEx:setActive(false)
else
self.replayIconEx:setActive(false)
self.fightIconEx:setActive(true)
end

self:refreshPlayerInfo()
self:onSelectTab(self.tabIndex or 1,true)
end

function UIWDCQGuessWin:refreshPlayerInfo()
local playerWidget1=self.playerRoot1:getWidgetBase()
local playerWidget2=self.playerRoot2:getWidgetBase()
local playerData1=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,1)
local playerData2=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,2)
self:setPlayerInfo(playerWidget1,playerData1)
self:setPlayerInfo(playerWidget2,playerData2)
end

function UIWDCQGuessWin:setPlayerInfo(playerWidget,playerData)
local isLose=mathHelper.validInt64(playerData.actorId)and playerData.name==''
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
local isSelfFlag=mathHelper.compareInt64(self.selfActorId,playerData.actorId)
if not isLose then
playerController:setHeadIcon(playerWidget,playerItemCmpIndex.headIocn,{iconInfo=playerData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
end
playerWidget:SetChildActive(playerItemCmpIndex.headBg,isLose)
playerWidget:SetChildActive(playerItemCmpIndex.noPeo,isLose)
playerWidget:SetChildActive(playerItemCmpIndex.headIocn,not isLose)
local name=FMT.fmt("<color=#{0}>{1}</color>",isSelfFlag and"379D04"or"59412D",playerModel:getOtherActorName(playerData.name))
playerWidget:SetChildText(playerItemCmpIndex.name,name)
local serverName=loginModel:getServerName(playerData.serverId)
serverName=FMT.fmt("<color=#{0}>[{1}]</color>",isSelfFlag and"379D04"or"59412D",serverName)
playerWidget:SetChildText(playerItemCmpIndex.severName,serverName)
local surportFlag=playerData.surportFlag
playerWidget:SetChildActive(playerItemCmpIndex.zan,mathHelper.compareInt64(self.selectSurActorId,playerData.actorId))
local winFlag=playerData.winFlag
playerWidget:SetChildActive(playerItemCmpIndex.winFlag,macthStage==WDCQCMatchStageEnum.eEndTheGame and winFlag)

playerWidget:SetChildButtonClick(playerItemCmpIndex.click,function()
WDCQController:reqShowWDCQZRInfo(playerData.actorId)
end)
end

function UIWDCQGuessWin:refreshGuessContent(timeFlag)
self:stopGuessTimer()
local state=self:getGuessState()
local guessFlag=WDCQController.checkGuessFlag(self.groupId,self.stageId,self.idx)
self:setSupportValue()
self:refreshSupportInfo()
local moneyType=eMoneyType.mtYunQian






local selfCnt=WDCQController.getMoneyCnt(playerModel:getActorID())
if self.changeMode then
selfCnt=selfCnt+WDCQController.getSuportMoneyCnt(self.groupId,self.stageId,self.idx)
end
local moneyStr=mathHelper.formatNumber(selfCnt,true)
self.moneyIocn:setChildIcon(iconHelper.getIconName(moneyType),false)
self.hbIocn:setChildIcon(iconHelper.getIconName(moneyType),false)
self.moneyTxt:setText(moneyStr)
local xiazhuCnt=WDCQController.getSuportMoneyCnt(self.groupId,self.stageId,self.idx)
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if state==guessState.guessIng then
self.tips:setChildAnchoredPos(0.7,-160.8)
self.subtitle:setText("下注云签")
self.timeTitle:setActive(true)
local func=function()
local curTime=timeHelper.getServerShortTime()
local left=self.roundCfgTemp.startTime-curTime
if left>0 then
self.timeTxt:setText(timeHelper.format_time_stamp3(left))
else
self.timeTitle:setActive(false)
if not timeFlag then
self:refreshGuessContent(true)
end
end
end
if not timeFlag then
self.guessTimerId=self:setTimer(1,0,func)
end
func()
self.none:setActive(false)
self.resultImg:setActive(false)
self.resultIcon:setActive(false)
self.surebtn:setGray(false)
self.winlua:SetChildImageRaycast(self.surebtn:getID(),true)
self.selectCnt=WDCQController.getSuportMoneyCnt(self.groupId,self.stageId,self.idx)
self.selectCnt=self.selectCnt==0 and 1 or self.selectCnt
if guessFlag and not self.changeMode then
self.xiazhuIcon:setActive(true)

self.xiazhuTxt:setText(FMT.fmt("已下注<color=#7D3B17>{0}</color>云签",xiazhuCnt))
self.selectCntSlider:setActive(false)

self.sureTxt:setText("更改下注")

else
self.xiazhuIcon:setActive(false)
self.selectCntSlider:setActive(true)


self.sureTxt:setText("确定")
local _maxCnt=WDCQController.getGuessMaxCnt(self.groupId,self.stageId)
if _maxCnt then
_maxCnt=_maxCnt>selfCnt and selfCnt or _maxCnt
else
_maxCnt=selfCnt
end
self.maxSelectCnt=_maxCnt

if self.maxSelectCnt==0 then
self.maxSelectCnt=1
self.selectCnt=0
end

self:initSlider()
end
elseif state==guessState.guessEnd then
self.selectCntSlider:setActive(false)
self.timeTitle:setActive(false)
self.surebtn:setGray(true)
self.winlua:SetChildImageRaycast(self.surebtn:getID(),false)
self.sureTxt:setText("已结束")
if macthStage==WDCQCMatchStageEnum.eInTheGame then
self.resultImg:setActive(false)
self.resultIcon:setActive(false)
self.tips:setChildAnchoredPos(0.7,-160.8)
self.subtitle:setText("下注云签")
if guessFlag then
self.xiazhuIcon:setActive(true)
self.none:setActive(false)
self.xiazhuTxt:setText(FMT.fmt("已下注<color=#7D3B17>{0}</color>云签",xiazhuCnt))
else
self.xiazhuIcon:setActive(false)
self.none:setActive(true)
end
else
self.tips:setChildAnchoredPos(0.7,-181)
self.subtitle:setText("竞猜结果")
self.xiazhuIcon:setActive(false)
if guessFlag then
self.none:setActive(false)
self.resultIcon:setActive(true)
self.resultIcon:setChildIcon(iconHelper.getIconName(moneyType),false)
self.resultImg:setActive(true)
local guessSec=WDCQController.checkGuessSecFlag(self.groupId,self.stageId,self.idx)
local matchData=WDCQController.getMacthInfo(self.groupId,self.stageId,self.idx)
local result,num=WDCQController.getGuessResult(matchData)
if guessSec then
self.resultImg:setCSImageSprite(abName,"imge_jingcaichenggong_1")
self.resultIMoney:setText(FMT.fmt("X{0}",num))
else

self.resultImg:setCSImageSprite(abName,"imge_jingcaishibai_1")
self.resultIMoney:setText(FMT.fmt("X{0}",xiazhuCnt+num))
end
else
self.none:setActive(true)
self.resultIcon:setActive(false)
self.resultImg:setActive(false)
end
end

end
end

function UIWDCQGuessWin:initSlider()
local maxCnt=self.maxSelectCnt
local minCount=maxCnt==1 and 0 or 1
local curSeclet=self.selectCnt

if curSeclet<minCount then
curSeclet=minCount
self.selectCnt=minCount
end
if curSeclet>maxCnt then
curSeclet=maxCnt
self.selectCnt=maxCnt
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.handleImgCenter:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),maxCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,minCount,maxCnt,function(value)
self.selectCnt=value
self.selectCntText:setText(value)
end)
end

function UIWDCQGuessWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxSelectCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIWDCQGuessWin:setSupportValue()
local playerData1=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,1)
local playerData2=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,2)

local surportCount1=playerData1.surportCount
local surportCount2=playerData2.surportCount
local valueRate
if surportCount1==0 and surportCount2==0 then
valueRate=0.5
else
valueRate=surportCount1/(surportCount1+surportCount2)
end

local value=valueRate*662
self.cntericon:setChildAnchoredPos(value,0)
end

function UIWDCQGuessWin:refreshSupportInfo()
local state=self:getGuessState()
local infowidget1=self.player1supportInfo:getWidgetBase()
local infowidget2=self.player2supportInfo:getWidgetBase()
local playerData1=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,1)
local playerData2=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,2)
self:setPlayerSupportInfo(infowidget1,playerData1,state,self.supportValueTxt1)
self:setPlayerSupportInfo(infowidget2,playerData2,state,self.supportValueTxt2)
end

function UIWDCQGuessWin:setPlayerSupportInfo(widget,playerData,state,obj)
local guessFlag=WDCQController.checkGuessFlag(self.groupId,self.stageId,self.idx)
local surportCount=playerData.surportCount
local allCnt=WDCQController.getHotCount(self.groupId,self.stageId,self.idx)
local valueRate
if allCnt<=0 then
valueRate=0.5
else
valueRate=surportCount/allCnt
end
valueRate=mathHelper.decimal(valueRate,2)
obj:setText(string.format("%s%%",valueRate*100))

widget:SetChildIconFillAmount(supportInfoCmpIndex.supportValueImg,valueRate)

if state==guessState.guessIng then
if guessFlag and not self.changeMode then
widget:SetChildActive(supportInfoCmpIndex.supportBtn,false)
widget:SetChildActive(supportInfoCmpIndex.supportFlag,false)
widget:SetChildActive(supportInfoCmpIndex.guessedIcon,true)
widget:SetChildText(supportInfoCmpIndex.guessCnt,surportCount)
else
local isSelcet=mathHelper.compareInt64(self.selectSurActorId,playerData.actorId)
widget:SetChildActive(supportInfoCmpIndex.supportBtn,not isSelcet)
widget:SetChildActive(supportInfoCmpIndex.supportFlag,isSelcet)
widget:SetChildActive(supportInfoCmpIndex.guessedIcon,false)
if not isSelcet then
widget:SetChildButtonClick(supportInfoCmpIndex.supportBtn,function()
self:onSutpportBtn(playerData.actorId)
end)
end
end
elseif state==guessState.guessEnd then

widget:SetChildActive(supportInfoCmpIndex.supportBtn,false)
widget:SetChildActive(supportInfoCmpIndex.supportFlag,false)
widget:SetChildActive(supportInfoCmpIndex.guessedIcon,true)
widget:SetChildText(supportInfoCmpIndex.guessCnt,surportCount)
end
end

function UIWDCQGuessWin:getGuessState()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if macthStage==WDCQCMatchStageEnum.ePreTheGame or macthStage==WDCQCMatchStageEnum.eTimeDown then
return guessState.guessIng
end




return guessState.guessEnd
end

function UIWDCQGuessWin:refreshZRContent(timeFlagId)
self:stopZRTimer()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
self.lastAdjustTipsRoot:setActive(false)
self.scrollerView:setActive(false)
if macthStage==WDCQCMatchStageEnum.ePreTheGame then
self.SAndBRoot:setActive(true)
self.adjustRoot:setActive(false)
if preStage==WDCQCPreGameStageEnum.eNone then
self.tipsContent:setText("双方等待开启选弟子")
local func=function()
local curTime=timeHelper.getServerShortTime()
local left=self.roundCfgTemp.selectDzStartTime-curTime
if left>0 then
self.sAbtimeTxt:setText(FMT.fmt("阶段结束：{0}",timeHelper.format_time_stamp3(left)))
else
self.sAbtimeTxt:setText("等待开启选弟子阶段已结束")
if timeFlagId~=1 then
self:refreshZRContent(1)
end
end
end
if timeFlagId~=1 then
self.zrTimerId=self:setTimer(1,0,func)
end
func()
elseif preStage==WDCQCPreGameStageEnum.eSelectDz then
self.tipsContent:setText("双方选择对战弟子")
local func=function()
local curTime=timeHelper.getServerShortTime()
local left=self.roundCfgTemp.selectDzEndTime-curTime
if left>0 then
self.sAbtimeTxt:setText(FMT.fmt("阶段结束：{0}",timeHelper.format_time_stamp3(left)))
else
self.sAbtimeTxt:setText("选择对战弟子阶段已结束")
if timeFlagId~=2 then
self:refreshZRContent(2)
end
end
end
if timeFlagId~=2 then
self.zrTimerId=self:setTimer(1,0,func)
end
func()
elseif preStage==WDCQCPreGameStageEnum.eForbiddenDz then
self.tipsContent:setText("双方选择禁用弟子")
local func=function()
local curTime=timeHelper.getServerShortTime()
local left=self.roundCfgTemp.banDzEndTime-curTime
if left>0 then
self.sAbtimeTxt:setText(FMT.fmt("阶段结束：{0}",timeHelper.format_time_stamp3(left)))
else
self.sAbtimeTxt:setText("禁用弟子阶段已结束")
if timeFlagId~=3 then
self:refreshZRContent(3)
end
end
end
if timeFlagId~=3 then
self.zrTimerId=self:setTimer(1,0,func)
end
func()
elseif preStage==WDCQCPreGameStageEnum.eAdjustTeam then
self.SAndBRoot:setActive(false)
self.adjustRoot:setActive(true)
self.replayIconList:setActive(false)
self.fightIconList:setActive(true)
self.noneIconList:setActive(true)
for i=1,3 do
local curAdjustIndex=WDCQController.getAdjustTeamIndex(adjustStage)
local showFightIcon=curAdjustIndex>=i
self.fightIcon[i]:setActive(showFightIcon)
self.noneIcon[i]:setActive(not showFightIcon)
end
if adjustStage==WDCQCAdjustTeamStageEnum.eFive then
self.fightIcon_3:setActive(false)
self.noneIcon_3:setActive(false)
self.coolDownList:setActive(false)
self.lastAdjustTipsRoot:setActive(true)
local func=function()
local roundCfgTemp=self.roundCfgTemp
local curTime=timeHelper.getServerShortTime()
local teamUpTime=roundCfgTemp.teamUpTime
local adjustTimeCfg=teamUpTime[adjustStage]
local lefTime=adjustTimeCfg.teamUpEndTime-curTime
if lefTime>0 then
self.lasttime:setText(FMT.fmt("调整结束:{0}",timeHelper.format_time_stamp3(lefTime)))
else
self.lasttime:setText("调整队伍阶段结束")
if timeFlagId~=4 then
self:refreshZRContent(4)
end
end
end
if timeFlagId~=4 then
self.zrTimerId=self:setTimer(1,0,func)
end
func()
else
self.coolDownList:setActive(true)
for i,v in ipairs(self.coolDownRoot)do
v:setActive(i==adjustStage)
end
local func=function()
local roundCfgTemp=self.roundCfgTemp
local curTime=timeHelper.getServerShortTime()
local teamUpTime=roundCfgTemp.teamUpTime
local adjustTimeCfg=teamUpTime[adjustStage]
local lefTime=adjustTimeCfg.teamUpEndTime-curTime
if lefTime>0 then
self.coolDown[adjustStage]:setText(FMT.fmt("调整结束:{0}",timeHelper.format_time_stamp3(lefTime)))
else
self.coolDown[adjustStage]:setText(FMT.fmt("调整队伍阶段{0}已结束",adjustStage))
if timeFlagId~=adjustStage*10 then
self:refreshZRContent(adjustStage*10)
end
end
end
if timeFlagId~=adjustStage*10 then
self.zrTimerId=self:setTimer(1,0,func)
end
func()
end
self:refreshZRTeamList()
end
elseif macthStage==WDCQCMatchStageEnum.eTimeDown or macthStage==WDCQCMatchStageEnum.eInTheGame then
self.SAndBRoot:setActive(false)
self.adjustRoot:setActive(true)
self.noneIconList:setActive(false)
self.replayIconList:setActive(false)
self.coolDownList:setActive(false)
self.fightIconList:setActive(true)
for i,v in ipairs(self.fightIcon)do
v:setActive(true)
end
self:refreshZRTeamList()
elseif macthStage==WDCQCMatchStageEnum.eEndTheGame then














self.SAndBRoot:setActive(false)
self.adjustRoot:setActive(false)
local fun=function(tempList,extraArgs)
if not self or self.isClose then
return
end
self.extraArgs=extraArgs
self.scrollerView:setActive(true)
self:refreshList(tempList)
end
local args=self:getshowMainArgs()
local fun1=function()
UIFullWenDingCangQiongControl:showMainWin(args)
end
WDCQController:Req_FightReplay(self.groupId,self.stageId,self.idx,false,fun,fun1,true)
else
self.SAndBRoot:setActive(false)
self.adjustRoot:setActive(false)
end
end

function UIWDCQGuessWin:refreshList(tempList)
if not tempList then
tempList={}
for i=1,3 do
table.insert(tempList,{})
end
end
self.scrollerView:setChildScrollViewCreateGrids(#tempList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local logInfo=tempList[i]
self:refreshLogItem(i,item,logInfo)
end
end

function UIWDCQGuessWin:refreshLogItem(i,item,logInfo)
local logId=logInfo.logId
item:SetChildActive(infoItemCmp.InfoItem,true)
local str=FMT.fmt("第{0}场",i)
local aFight=0
local dFight=0
if logId then
local lookupInfo=WDCQController:getFightLogIdLookupInfo(logId)
if lookupInfo then
str=FMT.fmt("{0}队-第{1}场",lookupInfo.teamIndex,lookupInfo.fightIndex)
aFight=mathHelper.int64_to_number(lookupInfo.aFight)
dFight=mathHelper.int64_to_number(lookupInfo.dFight)
end
end
item:SetChildText(infoItemCmp.roundTitle,str)
if not logInfo.aInfoImage and not logInfo.dInfoImage then
item:SetChildActive(infoItemCmp.noData,true)
item:SetChildActive(infoItemCmp.subBg,false)

item:SetChildActive(infoItemCmp.fightIcon,false)
else
item:SetChildActive(infoItemCmp.noData,false)
item:SetChildActive(infoItemCmp.subBg,true)
if logInfo.aInfoImage and logInfo.dInfoImage then

item:SetChildActive(infoItemCmp.replayIcon,true)
item:SetChildActive(infoItemCmp.fightIcon,false)
else

item:SetChildActive(infoItemCmp.fightIcon,true)
end
end

item:SetChildButtonClick(infoItemCmp.replayIcon,function()

self:openFight(logInfo.logId)
end)
local teamItemL=item:GetChildWidgetBase(infoItemCmp.teamItemL)
local stageInfo=logInfo and logInfo.stageInfo or{}
self:setTeamItem(teamItemL,logInfo.aInfoImage,stageInfo[stageInfoTag.leftActorId],aFight)
local teamItemR=item:GetChildWidgetBase(infoItemCmp.teamItemR)
self:setTeamItem(teamItemR,logInfo.dInfoImage,stageInfo[stageInfoTag.rightActorId],dFight)
end

function UIWDCQGuessWin:getTeamPosInfo_InfoImage(InfoImage)
local qianpaiCnt=0
local houpaiCnt=0
local tempImageList={}
for i,v in ipairs(InfoImage or{})do

tempImageList[v.pos]=v
if v.pos<=2 then
qianpaiCnt=qianpaiCnt+1
end
if v.pos>2 and v.pos<=5 then
houpaiCnt=houpaiCnt+1
end
end
local posInfo={}
posInfo.qianpaiCnt=qianpaiCnt
posInfo.houpaiCnt=houpaiCnt
posInfo.tempImageList=tempImageList
return posInfo
end

function UIWDCQGuessWin:setTeamItem(item,InfoImage,actorId,fight)
if InfoImage then
item:SetChildActive(-1,true)
item:SetChildActive(teamCmp.hss,true)
item:SetChildActive(teamCmp.nodzTip,false)
item:SetChildActive(teamCmp.winFlag,InfoImage.result)
item:SetChildActive(teamCmp.failFlag,false)

local posInfo=self:getTeamPosInfo_InfoImage(InfoImage)
local qianpaiCnt=posInfo.qianpaiCnt
local houpaiCnt=posInfo.houpaiCnt
local tempImageList=posInfo.tempImageList
item:SetChildActive(teamCmp.qianpailayout,qianpaiCnt>0)
item:SetChildActive(teamCmp.qianpaipaioneBg,qianpaiCnt==1)
item:SetChildActive(teamCmp.qianpaitwoBg,qianpaiCnt>1)
item:SetChildActive(teamCmp.houpailayout,houpaiCnt>0)
item:SetChildActive(teamCmp.houpaioneBg,houpaiCnt==1)
item:SetChildActive(teamCmp.houpaitwoBg,houpaiCnt>1)

for i,v in ipairs(teamCmp.headSlotList)do
local info=tempImageList[i]
if info then
item:SetChildActive(v,true)
local headWidget=item:GetChildWidgetBase(v)
local typo=info.typo
local hp=info.resultHp or 1
if typo==0 then
local image=info.image
local color=mathHelper.compareInt64(actorId,playerModel:getActorID())and image.color or 0
comHelper.setChildModelHeadIconBGByColor(headWidget,0,color)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headWidget:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
headWidget:SetChildGray(0,hp==0)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headWidget,modelParams,eHeadCenterType.eHead,nil,hp==0)
if mathHelper.compareInt64(actorId,playerModel:getActorID())then
UIDiscipleModel:setDiscipleXianMoHeadImage(headWidget,3,info)
headWidget:SetChildGray(3,hp==0)
end
else
local mCfg=cfgHelper.get(cfg_monsterconfig_get,typo)
if mCfg then
headWidget:SetChildActive(2,false)
headWidget:SetChildCSImageSprite(0,_abName,_bossKuang[mCfg.monType])
comHelper.setChildModelRawImage_monster(headWidget,typo,1,0,eHeadCenterType.eHead,nil,hp==0)
headWidget:SetChildGray(0,hp==0)
end
end
else
item:SetChildActive(v,false)
end
end
item:SetChildActive(teamCmp.fightroot,true)
item:SetChildText(teamCmp.fight,mathHelper.formatNumber3(fight))
else




item:SetChildActive(-1,false)
end

end

function UIWDCQGuessWin:openFight(logId,log)
local args=self.extraArgs or{}
args.showBattle=true
args.showWinTimes=false
fightModel:setSendExtraArgs(eBattleType.wengdingcangqiong,args)
fightController:send_log_list({logId},args,true,true,1)












































end




function UIWDCQGuessWin:refreshZRTeamList()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
for i,v in ipairs(self.zrteamItem)do
local cfg=teamListCfg[i]
local teamIndex=cfg.teamIndex
local playerIndex=cfg.playerIndex
local playerData=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,playerIndex)
local actorId=playerData.actorId
local showState=self:getTeamShowState(i,macthStage,adjustStage,actorId,teamIndex)
local widget=v:getWidgetBase()
if showState==teamShowState.eNone then
widget:SetChildActive(zrTeamItemCmp.adjusting,false)
widget:SetChildActive(zrTeamItemCmp.waiting,false)
widget:SetChildActive(zrTeamItemCmp.layout,false)
widget:SetChildActive(zrTeamItemCmp.nodztips,false)
widget:SetChildActive(zrTeamItemCmp.lastTips,false)
widget:SetChildActive(zrTeamItemCmp.winFlag,false)
widget:SetChildActive(zrTeamItemCmp.failFlag,false)
elseif showState==teamShowState.eAjusting then
widget:SetChildActive(zrTeamItemCmp.adjusting,true)
widget:SetChildActive(zrTeamItemCmp.waiting,false)
widget:SetChildActive(zrTeamItemCmp.layout,false)
widget:SetChildActive(zrTeamItemCmp.nodztips,false)
widget:SetChildActive(zrTeamItemCmp.lastTips,false)
widget:SetChildActive(zrTeamItemCmp.winFlag,false)
widget:SetChildActive(zrTeamItemCmp.failFlag,false)
elseif showState==teamShowState.eNoDZ then
widget:SetChildActive(zrTeamItemCmp.adjusting,false)
widget:SetChildActive(zrTeamItemCmp.waiting,false)
widget:SetChildActive(zrTeamItemCmp.layout,false)
widget:SetChildActive(zrTeamItemCmp.nodztips,true)
widget:SetChildActive(zrTeamItemCmp.lastTips,false)
widget:SetChildActive(zrTeamItemCmp.winFlag,false)
widget:SetChildActive(zrTeamItemCmp.failFlag,false)
elseif showState==teamShowState.eWaiting then
widget:SetChildActive(zrTeamItemCmp.adjusting,false)
widget:SetChildActive(zrTeamItemCmp.waiting,true)
widget:SetChildActive(zrTeamItemCmp.layout,false)
widget:SetChildActive(zrTeamItemCmp.nodztips,false)
widget:SetChildActive(zrTeamItemCmp.lastTips,false)
widget:SetChildActive(zrTeamItemCmp.winFlag,false)
widget:SetChildActive(zrTeamItemCmp.failFlag,false)
elseif showState==teamShowState.eShowDz then
widget:SetChildActive(zrTeamItemCmp.adjusting,false)
widget:SetChildActive(zrTeamItemCmp.waiting,false)
widget:SetChildActive(zrTeamItemCmp.layout,true)
widget:SetChildActive(zrTeamItemCmp.nodztips,false)
widget:SetChildActive(zrTeamItemCmp.lastTips,false)
self:setTeamInfoList(widget,actorId,teamIndex)
widget:SetChildActive(zrTeamItemCmp.winFlag,false)
widget:SetChildActive(zrTeamItemCmp.failFlag,false)









end
end
end

function UIWDCQGuessWin:getTeamPosInfo(TeamDZList)
local qianpaiCnt=0
local houpaiCnt=0
for i,v in ipairs(TeamDZList or{})do
if v and v~=0 then
if i<=2 then
qianpaiCnt=qianpaiCnt+1
end
if i>2 and i<=5 then
houpaiCnt=houpaiCnt+1
end
end
end
local posInfo={}
posInfo.qianpaiCnt=qianpaiCnt
posInfo.houpaiCnt=houpaiCnt
return posInfo
end

function UIWDCQGuessWin:setTeamInfoList(widget,actorId,teamIndex)

local dzlist=WDCQController.getTeamDZList_TeamIndex(actorId,teamIndex)

local posInfo=self:getTeamPosInfo(dzlist)
local qianpaiCnt=posInfo.qianpaiCnt
local houpaiCnt=posInfo.houpaiCnt
widget:SetChildActive(zrTeamItemCmp.qianpailayout,qianpaiCnt>0)
widget:SetChildActive(zrTeamItemCmp.qianpaipaioneBg,qianpaiCnt==1)
widget:SetChildActive(zrTeamItemCmp.qianpaitwoBg,qianpaiCnt>1)
widget:SetChildActive(zrTeamItemCmp.houpailayout,houpaiCnt>0)
widget:SetChildActive(zrTeamItemCmp.houpaioneBg,houpaiCnt==1)
widget:SetChildActive(zrTeamItemCmp.houpaitwoBg,houpaiCnt>1)
local fight=0
for i,v in ipairs(zrTeamItemCmp.headSlotList)do
if dzlist and dzlist[i]and dzlist[i]~=0 then
widget:SetChildActive(v,true)
local headshot=widget:GetChildWidgetBase(v)






local netdata=dzlist[i]

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=mathHelper.compareInt64(actorId,playerModel:getActorID())and image.color or 0
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)
fight=fight+mathHelper.int64_to_number(netdata.fightvalue)
if mathHelper.compareInt64(actorId,playerModel:getActorID())then
UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
end
else
widget:SetChildActive(v,false)
end
end
widget:SetChildActive(zrTeamItemCmp.fightroot,true)
widget:SetChildText(zrTeamItemCmp.fight,mathHelper.formatNumber3(fight))
end

function UIWDCQGuessWin:getTeamShowState(showIndex,macthStage,adjustStage,actorId,teamIndex)

if macthStage==WDCQCMatchStageEnum.ePreTheGame then
if showIndex<adjustStage then
local flag=WDCQController.checkTeamDZ(actorId,teamIndex)
if flag then
return teamShowState.eShowDz
else
return teamShowState.eNoDZ
end
elseif showIndex==adjustStage then

if adjustStage==WDCQCAdjustTeamStageEnum.eFive then
return teamShowState.eNone
end
return teamShowState.eAjusting
elseif showIndex>adjustStage then

if adjustStage==WDCQCAdjustTeamStageEnum.eFive then
return teamShowState.eNone
end
local curTeamIndex=WDCQController.getAdjustTeamIndex(adjustStage)
if teamIndex==curTeamIndex then
return teamShowState.eWaiting
end
end
else
local flag=WDCQController.checkTeamDZ(actorId,teamIndex)
if flag then
return teamShowState.eShowDz
else
return teamShowState.eNoDZ
end
end
return teamShowState.eNone
end



function UIWDCQGuessWin:initTabs()
for i,v in ipairs(self.tab)do
if tabCfg[i]and tabCfg[i].openfunc()then
v:setActive(true)
local widget=v:getChildWidgetBase()
local func=function()
widget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,self.tabIndex==i and'button_dytab_2'or'button_dytab_1')
end
widget:SetChildUIModelShowTarget(tabCmp.model,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
widget:SetChildText(tabCmp.name,tabCfg[i].name)
widget:SetChildActive(tabCmp.reddot,tabCfg[i].reddotfun())
widget:SetChildButtonClick(tabCmp.click,function()
self:onSelectTab(i)
end,true)
else
v:setActive(false)
end
end
end


function UIWDCQGuessWin:onSelectTab(tabIndex,flag)
if tabIndex==self.tabIndex and not flag then return end
if self.tabIndex then
local oldTab=self.tab[self.tabIndex]
local oldWidget=oldTab:getChildWidgetBase()
oldWidget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,'button_dytab_1')
tabCfg[self.tabIndex].closeFun(self)
end
self.tabIndex=tabIndex
local curTab=self.tab[tabIndex]
local curWidget=curTab:getChildWidgetBase()
curWidget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
curWidget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,'button_dytab_2')
tabCfg[self.tabIndex].showFun(self)
end


function UIWDCQGuessWin:onSutpportBtn(actorId)
if actorId==self.selectSurActorId then return end
self.selectSurActorId=actorId
self:refreshSupportInfo()
self:refreshPlayerInfo()
end

function UIWDCQGuessWin:stopAllTimer()
self:stopGuessTimer()
self:stopZRTimer()
end

function UIWDCQGuessWin:stopGuessTimer()
if self.guessTimerId then
self:stopTimerByID(self.guessTimerId)
self.guessTimerId=nil
end
end

function UIWDCQGuessWin:stopZRTimer()
if self.zrTimerId then
self:stopTimerByID(self.zrTimerId)
self.zrTimerId=nil
end
end





function UIWDCQGuessWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
end
self:closeSelf()
end



function UIWDCQGuessWin:onSubBtn()
end



function UIWDCQGuessWin:onAddBtn()
end



function UIWDCQGuessWin:onMaxBtn()
end



function UIWDCQGuessWin:onSurebtn()
if not self.changeMode and WDCQController.checkGuessFlag(self.groupId,self.stageId,self.idx)then
self.changeMode=true
self:refreshGuessContent()
return
end
self.changeMode=false
if self.selectSurActorId and not mathHelper.compareInt64(self.selectSurActorId,Int64_0)then

if self.selectCnt==0 then
UIManager.info("云签不足")
return
end










WDCQController.req_38_11(self.groupId,self.stageId,self.idx,self.selectSurActorId,int64.new(self.selectCnt))
else
UIManager.info("请选择支持的祖师")
end
end



function UIWDCQGuessWin:onFightIcon_1()
end



function UIWDCQGuessWin:onFightIcon_2()
end



function UIWDCQGuessWin:onFightIcon_3()
end



function UIWDCQGuessWin:onReplayIcon_1()
end



function UIWDCQGuessWin:onReplayIcon_2()
end



function UIWDCQGuessWin:onReplayIcon_3()
end


function UIWDCQGuessWin:onReplayIconEx()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if self.tabIndex==1 and macthStage==WDCQCMatchStageEnum.eEndTheGame then
self:onSelectTab(2)
return
end
local args=self:getshowMainArgs()
local fun=function()

end
local fun1=function()
UIFullWenDingCangQiongControl:showMainWin(args)
end

WDCQController:Req_FightReplay(self.groupId,self.stageId,self.idx,true,fun,fun1,true)
end

function UIWDCQGuessWin:getshowMainArgs()
local args={}
args.showGuessWin=true
args.groupId=self.groupId
args.stageId=self.stageId
args.subGoupId=math.ceil(self.idx/4)
args.idx=self.idx
args.tabIndex=self.tabIndex


args.closeFunc=self.closeFunc
args.showLiveWin=self.showLiveWin
return args
end


