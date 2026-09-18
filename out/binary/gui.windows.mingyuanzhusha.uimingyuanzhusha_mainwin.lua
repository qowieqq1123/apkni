







def_class("UIMingYuanZhuSha_MainWin",UIWindowBase)









function UIMingYuanZhuSha_MainWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.beforeEffect=UIObject.get(self,1)
self.bgSpine=UIObject.get(self,2)
self.bossMonsterIcon=UIObject.get(self,3)
self.bossMonsterPart=UIObject.get(self,4)
self.centerLayout=UIObject.get(self,5)
self.clickMonsterBtn=UIButton.get(self,6)
self.defeatRewardList=UIObject.get(self,7)
self.defeatRewardPart=UIObject.get(self,8)
self.difficultLevel=UIText.get(self,9)
self.difficultLevelPart=UIButton.get(self,10)
self.discipleItem_1=UIBaseItem.get(self,11)
self.discipleItem_2=UIBaseItem.get(self,12)
self.discipleItem_3=UIBaseItem.get(self,13)
self.discipleItem_4=UIBaseItem.get(self,14)
self.discipleItem_5=UIBaseItem.get(self,15)
self.discipleList=UIObject.get(self,16)
self.discipleListPart=UIObject.get(self,17)
self.discipleStateBtn=UIButton.get(self,18)
self.fightBgSpine=UIObject.get(self,19)
self.fightBtn=UIButton.get(self,20)
self.fightContent=UIObject.get(self,21)
self.fightModel=UIObject.get(self,22)
self.fightOperationPart=UIObject.get(self,23)
self.fightVal=UIText.get(self,24)
self.fightValPart=UIObject.get(self,25)
self.finishTip=UIObject.get(self,26)
self.groupTxt=UIText.get(self,27)
self.heightMask=UIButton.get(self,28)
self.killBtn=UIButton.get(self,29)
self.layer=UIText.get(self,30)
self.leaderDiscipleHud=UIObject.get(self,31)
self.leaderDiscipleModel=UIObject.get(self,32)
self.leftBtnsLayout=UIObject.get(self,33)
self.leftLayout=UIObject.get(self,34)
self.loseLingLi=UIObject.get(self,35)
self.loseLingLiVal=UIText.get(self,36)
self.moneyCount=UIText.get(self,37)
self.moneyIcon=UIObject.get(self,38)
self.moneyPart=UIButton.get(self,39)
self.monsterEffectBack=UIObject.get(self,40)
self.monsterEffectBefore=UIObject.get(self,41)
self.monsterHud=UIObject.get(self,42)
self.monsterModel=UIObject.get(self,43)
self.noFightPassTips=UIObject.get(self,44)
self.nofightPassTipsTxt=UIText.get(self,45)
self.openMerchantBtn=UIButton.get(self,46)
self.passBossMonster=UIObject.get(self,47)
self.passSmallGroup=UIObject.get(self,48)
self.rankBtn=UIButton.get(self,49)
self.remainSmallMonsterCount=UIText.get(self,50)
self.restartBtn=UIButton.get(self,51)
self.rewardBtn=UIButton.get(self,52)
self.rewardReddot=UIObject.get(self,53)
self.rightLayout=UIObject.get(self,54)
self.Root=UIObject.get(self,55)
self.ruleBtn=UIButton.get(self,56)
self.scoreCloseRule=UIObject.get(self,57)
self.scoreCount=UIText.get(self,58)
self.scoreDetailPart=UIObject.get(self,59)
self.scoreLogList=UIObject.get(self,60)
self.scoreOpenRule=UIObject.get(self,61)
self.scorePart=UIObject.get(self,62)
self.serverFlagBg=UIImage.get(self,63)
self.serverFlagName=UIText.get(self,64)
self.serverFlagPart=UIObject.get(self,65)
self.settlementLeftTimePart=UIObject.get(self,66)
self.settlementLeftTimeTxt=UIText.get(self,67)
self.showScoreDetailBtn=UIButton.get(self,68)
self.showSelectDiscipleBtn=UIButton.get(self,69)
self.smallMonsterIcon=UIObject.get(self,70)
self.smallMonsterPart=UIObject.get(self,71)
self.smallStageProgressPart=UIObject.get(self,72)
self.stagePart=UIObject.get(self,73)
self.targetEffect=UIObject.get(self,74)
self.targetObjectPart=UIObject.get(self,75)
self.uiRoot=UIObject.get(self,76)
self.xiuSaiBtn=UIButton.get(self,77)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.clickMonsterBtn:setButtonClick(function()self:onClickMonsterBtn()end)

self.difficultLevelPart:setButtonClick(function()self:onDifficultLevelPart()end)

self.discipleStateBtn:setButtonClick(function()self:onDiscipleStateBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.heightMask:setButtonClick(function()self:onHeightMask()end)

self.killBtn:setButtonClick(function()self:onKillBtn()end)

self.moneyPart:setButtonClick(function()self:onMoneyPart()end)

self.openMerchantBtn:setButtonClick(function()self:onOpenMerchantBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.restartBtn:setButtonClick(function()self:onRestartBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showScoreDetailBtn:setButtonClick(function()self:onShowScoreDetailBtn()end)

self.showSelectDiscipleBtn:setButtonClick(function()self:onShowSelectDiscipleBtn()end)

self.xiuSaiBtn:setButtonClick(function()self:onXiuSaiBtn()end)
self.discipleItem={
self.discipleItem_1,
self.discipleItem_2,
self.discipleItem_3,
self.discipleItem_4,
self.discipleItem_5,
}



end


function UIMingYuanZhuSha_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.beforeEffect);self.beforeEffect=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.bossMonsterIcon);self.bossMonsterIcon=nil;
_UIObject_release(self.bossMonsterPart);self.bossMonsterPart=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.clickMonsterBtn);self.clickMonsterBtn=nil;
_UIObject_release(self.defeatRewardList);self.defeatRewardList=nil;
_UIObject_release(self.defeatRewardPart);self.defeatRewardPart=nil;
_UIObject_release(self.difficultLevel);self.difficultLevel=nil;
_UIObject_release(self.difficultLevelPart);self.difficultLevelPart=nil;
_UIObject_release(self.discipleItem_1);self.discipleItem_1=nil;
_UIObject_release(self.discipleItem_2);self.discipleItem_2=nil;
_UIObject_release(self.discipleItem_3);self.discipleItem_3=nil;
_UIObject_release(self.discipleItem_4);self.discipleItem_4=nil;
_UIObject_release(self.discipleItem_5);self.discipleItem_5=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.discipleListPart);self.discipleListPart=nil;
_UIObject_release(self.discipleStateBtn);self.discipleStateBtn=nil;
_UIObject_release(self.fightBgSpine);self.fightBgSpine=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightContent);self.fightContent=nil;
_UIObject_release(self.fightModel);self.fightModel=nil;
_UIObject_release(self.fightOperationPart);self.fightOperationPart=nil;
_UIObject_release(self.fightVal);self.fightVal=nil;
_UIObject_release(self.fightValPart);self.fightValPart=nil;
_UIObject_release(self.finishTip);self.finishTip=nil;
_UIObject_release(self.groupTxt);self.groupTxt=nil;
_UIObject_release(self.heightMask);self.heightMask=nil;
_UIObject_release(self.killBtn);self.killBtn=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.leaderDiscipleHud);self.leaderDiscipleHud=nil;
_UIObject_release(self.leaderDiscipleModel);self.leaderDiscipleModel=nil;
_UIObject_release(self.leftBtnsLayout);self.leftBtnsLayout=nil;
_UIObject_release(self.leftLayout);self.leftLayout=nil;
_UIObject_release(self.loseLingLi);self.loseLingLi=nil;
_UIObject_release(self.loseLingLiVal);self.loseLingLiVal=nil;
_UIObject_release(self.moneyCount);self.moneyCount=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyPart);self.moneyPart=nil;
_UIObject_release(self.monsterEffectBack);self.monsterEffectBack=nil;
_UIObject_release(self.monsterEffectBefore);self.monsterEffectBefore=nil;
_UIObject_release(self.monsterHud);self.monsterHud=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.noFightPassTips);self.noFightPassTips=nil;
_UIObject_release(self.nofightPassTipsTxt);self.nofightPassTipsTxt=nil;
_UIObject_release(self.openMerchantBtn);self.openMerchantBtn=nil;
_UIObject_release(self.passBossMonster);self.passBossMonster=nil;
_UIObject_release(self.passSmallGroup);self.passSmallGroup=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.remainSmallMonsterCount);self.remainSmallMonsterCount=nil;
_UIObject_release(self.restartBtn);self.restartBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rightLayout);self.rightLayout=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.scoreCloseRule);self.scoreCloseRule=nil;
_UIObject_release(self.scoreCount);self.scoreCount=nil;
_UIObject_release(self.scoreDetailPart);self.scoreDetailPart=nil;
_UIObject_release(self.scoreLogList);self.scoreLogList=nil;
_UIObject_release(self.scoreOpenRule);self.scoreOpenRule=nil;
_UIObject_release(self.scorePart);self.scorePart=nil;
_UIObject_release(self.serverFlagBg);self.serverFlagBg=nil;
_UIObject_release(self.serverFlagName);self.serverFlagName=nil;
_UIObject_release(self.serverFlagPart);self.serverFlagPart=nil;
_UIObject_release(self.settlementLeftTimePart);self.settlementLeftTimePart=nil;
_UIObject_release(self.settlementLeftTimeTxt);self.settlementLeftTimeTxt=nil;
_UIObject_release(self.showScoreDetailBtn);self.showScoreDetailBtn=nil;
_UIObject_release(self.showSelectDiscipleBtn);self.showSelectDiscipleBtn=nil;
_UIObject_release(self.smallMonsterIcon);self.smallMonsterIcon=nil;
_UIObject_release(self.smallMonsterPart);self.smallMonsterPart=nil;
_UIObject_release(self.smallStageProgressPart);self.smallStageProgressPart=nil;
_UIObject_release(self.stagePart);self.stagePart=nil;
_UIObject_release(self.targetEffect);self.targetEffect=nil;
_UIObject_release(self.targetObjectPart);self.targetObjectPart=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.xiuSaiBtn);self.xiuSaiBtn=nil;
self.discipleItem=nil;
end
















local _this

local _btnClickStamp=0
local _btnClickInterval=3


local _enterDuration=1.68
local _obj_in_pos={440,60}
local _obj_out_pos={170,-40}
local _obj_in_scale=0.2

local _monster_scale=1
local _marchant_scale=0.7

local _stateEnum={
eStop=0,
eWait=1,
eIdle=2,
eFinish=3,
ePlayMoveBehavior=3,
ePlayFightResult=4,
ePalyKillResult=5,
}

local _targetObjectCmpIndex={
fzList=0,
fzDetailPart=1,
fzDetailList=2,
resultInfoPart=3,
resultInfo=4,
fzClick=5,
}

local _targetObjectInfo={
[MYZSStageType.eMonster]={
refreshTargetObjectModel=function()
_this:refreshMonsterModel()
end,
refreshTargetObjectHud=function(hubWB)
_this:refreshMonsterHud(hubWB)
end,
levelResult=function()
if _this.isFightBack then
_this.isFightBack=false
_this:startMerchantDisappearBehavior()
else
_this:startKillMonsterBehavior()
end

_this:changeLevel()
end,
levelStart=function()
_this:startTargetObjectEnterBehavior()
end,
},
[MYZSStageType.eMerchant]={
refreshTargetObjectModel=function()
_this:refreshMerchantModel()
end,
refreshTargetObjectHud=function(hubWB)
_this:refreshMerchantHud(hubWB)
end,
levelResult=function()
_this:startMerchantDisappearBehavior()
_this:changeLevel()
end,
levelStart=function()
_this:startTargetObjectEnterBehavior()
end,
},
[MYZSStageType.eTreasure]={
refreshTargetObjectModel=function()
end,
refreshTargetObjectHud=function(hubWB)
end,
levelResult=function()
_this:changeLevel()
_this:levelStart()
end,
levelStart=function()
_this:showWindow("UIMingYuanZhuSha_SelectBaoWuWin")
_this:changeBehaviorState(0)
end,
},
[MYZSStageType.eWait]={
refreshTargetObjectModel=function()
_this:refreshWaitTargetModel()
end,
refreshTargetObjectHud=function(hubWB)
_this:refreshWaitHud(hubWB)
end,
levelResult=function()
_this:changeLevel()
_this:startMerchantDisappearBehavior()
end,
levelStart=function()
_this:startTargetObjectEnterBehavior()
end,
},
[MYZSStageType.eFinish]={
refreshTargetObjectModel=function()
_this:refreshFinishTargetModel()
end,
refreshTargetObjectHud=function(hubWB)
_this:refreshFinishHud(hubWB)
end,
levelResult=function()
_this:changeLevel()
_this:startMerchantDisappearBehavior()
end,
levelStart=function()
_this:startTargetObjectEnterBehavior()
end,
},
}




function UIMingYuanZhuSha_MainWin:onLoaded(...)
self:bindComponents()


_this=self
self.isPlayingBehavior=false

_this.needChangeMoneyId=myzsModel:getBaseConfig('money_type')

local moneyIconName=iconHelper.getIconName(_this.needChangeMoneyId)
self.moneyIcon:setChildIcon(moneyIconName,false)

local loseVal=myzsModel:getBaseConfig('energy_dec')
self.loseLingLiVal:setText(string.format("%d%%",loseVal))


self:addProNotify(13,31,self.recv_13_31)
self:addProNotify(13,34,self.recv_13_34)
self:addProNotify(13,35,self.recv_13_35)

self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addReddotNotify(REDDIT_SUB_TYPE.sMYZSTXZ,function()
if _this==nil then return end
_this:refreshRightBtns()
end)
self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.onMingYuanZhuShaStateChange,self.onMingYuanZhuShaStateChange)

end


function UIMingYuanZhuSha_MainWin:__delete()

self:stopAllBehavior()
self:stopAllTimer()
self:stopShowKillMonsterLoseLingLi()




_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_MainWin:onShow(argtable,afterOnloaded)

self.isFull=argtable.isFull


self.isFightBack=argtable.isFightBack
self.fightCallBack=argtable.fightCallBack



self:initData()

self:freshCurrentState()

self:refreshAll()

self:checkContinue()

if self.curWinState==_stateEnum.eIdle then
if NEWBIE_LUA_FUNC_TYPE.myzs_main_doing~=nil and not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.myzs_main_doing)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.myzs_main_doing)
end
end
end


function UIMingYuanZhuSha_MainWin:onHide()

end

function UIMingYuanZhuSha_MainWin:checkContinue()
if self.curWinState==_stateEnum.eStop or self.curWinState==_stateEnum.eFinish then
return
end

if self.levelType==MYZSStageType.eTreasure then
self:showWindow("UIMingYuanZhuSha_SelectBaoWuWin")
end

if self.levelType==MYZSStageType.eMonster and self.isFightBack then
if self.fightCallBack then
self.fightCallBack()
end
self:levelResult()
end
end


function UIMingYuanZhuSha_MainWin:refreshAll()

self:refreshSpineBg()
self:refreshSettlementPart()
self:refreshMoney()
self:refreshChallengeScore()
self:refreshStagePart()
self:refreshDefeatRewardPart()
self:refreshRightBtns()
self:refreshFightOperationPart()
self:refreshFightContent()
self:refreshServerFlagPart()
self:refreshDiffLevel()
end

function UIMingYuanZhuSha_MainWin:refreshAllUI()

self:refreshSettlementPart()
self:refreshMoney()
self:refreshChallengeScore()
self:refreshStagePart()
self:refreshDefeatRewardPart()
self:refreshRightBtns()
self:refreshFightOperationPart()
self:refreshDiffLevel()
end


function UIMingYuanZhuSha_MainWin:resetData()
self.curWinState=nil
self.settlementState=nil
self.curLayer=nil
self.curLevel=nil
self.isShowChallengeScoreDetailPanel=nil
self.isShowFaZeDetailPanel=nil
self.levelType=nil
self.isCanShowMerchantSpeak=nil
end

function UIMingYuanZhuSha_MainWin:initData()
self:resetData()

self.curWinState=_stateEnum.eIdle
self.isShowChallengeScoreDetailPanel=false
self.isShowFaZeDetailPanel=false
self.isCanShowMerchantSpeak=false

self.isInXiuSai=myzsModel:checkInXiuSai()

self.diffLevel=myzsModel:getDiffLevel()

self:refreshData()
end

function UIMingYuanZhuSha_MainWin:refreshData()
self:refreshData_SettlementState()
self:refreshData_GroupStage()
self:refreshData_DiscipleTeamFightVal()
self:refreshData_LevelType()
end

function UIMingYuanZhuSha_MainWin:refreshData_SettlementState()
self.settlementState=myzsModel:getSettlementState()
end

function UIMingYuanZhuSha_MainWin:refreshData_GroupStage()
self.curLayer=myzsModel:getCurrentLayer()
self.curLevel=myzsModel:getCurrentLevel()
self.gameIdx=myzsModel:getGameIdx()
self.showGameIdx=myzsModel:getShowGameIdx()
end

function UIMingYuanZhuSha_MainWin:refreshData_DiscipleTeamFightVal()
self.discipleTeamFightVal=myzsModel:getDiscipleTeamFightVal()
end

function UIMingYuanZhuSha_MainWin:refreshData_LevelType()
self.levelType=myzsModel:getCurrentLevelType()
end

function UIMingYuanZhuSha_MainWin:freshCurrentState()
local settlementState=self.settlementState
if settlementState==MYZSSettlementStateEnum.eDoing then
self.curWinState=_stateEnum.eIdle
elseif settlementState==MYZSSettlementStateEnum.eWait then
self.curWinState=_stateEnum.eWait
elseif settlementState==MYZSSettlementStateEnum.eStop then
self.curWinState=_stateEnum.eStop
elseif settlementState==MYZSSettlementStateEnum.eFinish then
self.curWinState=_stateEnum.eFinish
end
end

function UIMingYuanZhuSha_MainWin:checkWinState(state)
return self.curWinState==state
end


function UIMingYuanZhuSha_MainWin:refreshSpineBg()
local levelConf=myzsModel:getlevelConf(self.showGameIdx)
self.fightBgSpine:setChildUIModelShowTarget(levelConf.bgSpineID,1,nil,eAnimationID.stand,true)

end

function UIMingYuanZhuSha_MainWin:setBgSpineAnim(speed)
speed=speed or 1
_this.winlua:SetChildUIModelAnimationSpeed(_this.fightBgSpine:getID(),speed)
end

function UIMingYuanZhuSha_MainWin:refreshSettlementPart()
self:refreshData_SettlementState()
self:stopSettlementTimer()
if self.settlementState==MYZSSettlementStateEnum.eFinish or self.settlementState==MYZSSettlementStateEnum.eWait or self.settlementState==MYZSSettlementStateEnum.eDoing then
local settlementFmt="结算剩余：{0}"
local endTimeStamp=myzsModel:getSettlementTime()
self:startSettlementTimer(settlementFmt,endTimeStamp,"结算中")





elseif self.settlementState==MYZSSettlementStateEnum.eStop then
local endTimeStamp=myzsModel:getNextSeasonOpenStamp()
local timeFmt="休战结束：{0}"
self:startSettlementTimer(timeFmt,endTimeStamp,"休战中")
end
end

function UIMingYuanZhuSha_MainWin:refreshMoney()
local count=myzsModel:getActMoneyCount()
self.moneyCount:setText(count)
end

function UIMingYuanZhuSha_MainWin:refreshChallengeScore()
local score=myzsModel:getChallengeScore()
local scoreStr=FMT.fmt("挑战积分：<color=#aae252>{0}</color>",score)
self.scoreCount:setText(scoreStr)

self:changeChallengeIcon()

self.scoreDetailPart:setActive(self.isShowChallengeScoreDetailPanel)
end

function UIMingYuanZhuSha_MainWin:refreshStagePart()
local levelConf=myzsModel:getlevelConf(self.showGameIdx)
local layer=levelConf.layer
local groupStr=FMT.fmt("第{0}重-{1}",layer,levelConf.level)
self.groupTxt:setText(groupStr)

local passLen=myzsModel:getLayerMonsterPassCount(layer)
local smallMosnterCount=myzsModel:getLayerTotalSmallMonsterCount(layer)
local leftCount=Mathf.Max(0,smallMosnterCount-passLen)
local isShowSmallCountPart=leftCount>0
self.smallStageProgressPart:setActive(isShowSmallCountPart)
if isShowSmallCountPart then
self.remainSmallMonsterCount:setText(string.format("x%d",leftCount))
end


local isPassSmallMonster=leftCount<=0
local isShowSmallMonster=myzsModel:checkLayerHasSmallMonster(layer)
self.smallMonsterIcon:setGray(isPassSmallMonster)
self.passSmallGroup:setActive(isPassSmallMonster)
self.smallMonsterPart:setActive(isShowSmallMonster)


local totalCount=myzsModel:getLayerTotalMonsterCount(layer)
local isPassBoss=passLen-totalCount>=0
local isShowBossMonster=myzsModel:checkLayerHasBossMonster(layer)
self.bossMonsterIcon:setGray(isPassBoss)
self.passBossMonster:setActive(isPassBoss)
self.bossMonsterPart:setActive(isShowBossMonster)
end

function UIMingYuanZhuSha_MainWin:refreshDefeatRewardPart()
local isPass,showIdx,rewards=myzsModel:willGetDefeatReward()

local levelConf=myzsModel:getlevelConf(showIdx)
local groupStageStr=FMT.fmt("{0}重-{1}",levelConf.layer,levelConf.level)
self.layer:setText(groupStageStr)

local gray=isPass and 1 or 0

local rewardLen=#rewards
self.defeatRewardList:setChildLayoutGroupCreateItems(rewardLen,function(index)
local item=self.defeatRewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]

local itemid=data[1]
local itemcount=data[2]
local showCountBG=itemcount>1
itemcount=showCountBG and itemcount or""

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,gray=gray}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)

item:SetChildActive(1,isPass)

local isDiff=data.isDiff and true or false
item:SetChildActive(2,isDiff)
end)
end

function UIMingYuanZhuSha_MainWin:refreshRightBtns()

self.rewardReddot:setActive(myzsModel:getTxzReddot())
end

function UIMingYuanZhuSha_MainWin:refreshFightOperationPart()
self:refreshData_DiscipleTeamFightVal()


self.fightVal:setText(mathHelper.formatNumber4(self.discipleTeamFightVal,2))


for index,discipleItemObj in ipairs(self.discipleItem)do
self:refreshDiscipleItem(discipleItemObj,index)
end


local killMonsterNeedFightVal=myzsModel:getKillMonsterFightVal()
local isShowKillFight=killMonsterNeedFightVal~=nil and self.settlementState==MYZSSettlementStateEnum.eDoing
self.noFightPassTips:setActive(isShowKillFight)
if isShowKillFight then
local killTips=FMT.fmt("{0}可直接斩灭",mathHelper.formatNumber4(killMonsterNeedFightVal,2))
self.nofightPassTipsTxt:setText(killTips)
end


local isFinish=self.curWinState==_stateEnum.eFinish or self.curWinState==_stateEnum.eWait
local isCanKill=isShowKillFight and self.discipleTeamFightVal>=killMonsterNeedFightVal or false
self.killBtn:setActive(self.levelType==MYZSStageType.eMonster and isCanKill and(not isFinish))
self.fightBtn:setActive(self.levelType==MYZSStageType.eMonster or isFinish and(self.curWinState~=_stateEnum.eStop))
self.openMerchantBtn:setActive(self.levelType==MYZSStageType.eMerchant or self.levelType==MYZSStageType.eTreasure and(not isFinish))

self.xiuSaiBtn:setActive(self.isInXiuSai)

self.winlua:SetChildButtonEnable(self.fightBtn:getID(),true,isFinish)

self.discipleListPart:setActive(not self.isInXiuSai)
end


local _discipleTeamItemCmpIndex={
emptyAdd=0,
hasDis=1,
discipleInfo=2,
kuangBg=3,
head=4,
voc=5,
lingli=6,
llicon=7,
llval=8,
}
function UIMingYuanZhuSha_MainWin:refreshDiscipleItem(obj,index)
local discipleItem=obj:getWidgetBase()

local discipleData=myzsModel:getTeamDiscipleDataByIndex(index)
local isHas=discipleData~=nil
discipleItem:SetChildActive(_discipleTeamItemCmpIndex.emptyAdd,not isHas)
discipleItem:SetChildActive(_discipleTeamItemCmpIndex.hasDis,isHas)

if isHas then
local discipleguid=discipleData.discipleGuid
comHelper.setChildModelHeadIconBG(discipleItem,_discipleTeamItemCmpIndex.kuangBg,discipleguid)

comHelper.setChildModelRawImage(discipleItem,discipleguid,_discipleTeamItemCmpIndex.head,0,eHeadCenterType.eHead)

local jobIcon=UIDiscipleModel:getJobIconNameX(discipleguid)
discipleItem:SetChildCSImageSprite(_discipleTeamItemCmpIndex.voc,globalABLookup.global,jobIcon)

local llvalPercent=string.format('<color=#f1ce78>灵</color>%d%%',discipleData.llPercent)
discipleItem:SetChildText(_discipleTeamItemCmpIndex.llval,llvalPercent)
end

end

function UIMingYuanZhuSha_MainWin:refreshFightContent()

self:refreshMainDiscipleModel()
self:refreshMainDiscipleHud()


self:refreshTargetObjectModel()
self:refreshTargetObjectHud()
end


function UIMingYuanZhuSha_MainWin:refreshMainDiscipleModel()

local discipleData
local discipleList=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
if next(discipleList)then
discipleData=discipleList[1]
else
local top5FightDiscipleGuidList=UIDiscipleModel:getFightTop5DiscipleGuidList()
local topInfo=top5FightDiscipleGuidList[1]
discipleData=UIDiscipleModel:getDiscipleData(topInfo.discipleguid)
end
if discipleData==nil then logErr("未找到掌门或者战力第一弟子")return end

local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(discipleData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
self.leaderDiscipleModel:setChildUIModelShowTarget(modelParams.body,0.9,modelParams.componets,eAnimationID.stand,false,false,0.5)
self.leaderDiscipleModel:setChildUIModelShowFlipX(true)
end


function UIMingYuanZhuSha_MainWin:refreshMainDiscipleHud()

end


function UIMingYuanZhuSha_MainWin:refreshTargetObjectModel()
self:resetTargetObjectModel()
local targetObjectInfo=_targetObjectInfo[self.levelType]
if targetObjectInfo.refreshTargetObjectModel then
targetObjectInfo.refreshTargetObjectModel()
end
end

function UIMingYuanZhuSha_MainWin:resetTargetObjectModel()
self.monsterModel:setChildUIModelRemoveTarget()
self.targetEffect:setChildShowEffect(0,false)
end

function UIMingYuanZhuSha_MainWin:resetTargetObjectModelHud()
self:stopTargetWaitTimer()

self.isShowFaZeDetailPanel=false

local hudWB=self.monsterHud:getWidgetBase()

self.fightModel:setActive(false)
self.fightModel:setChildUIModelRemoveTarget()

hudWB:SetChildActive(_targetObjectCmpIndex.fzList,false)
hudWB:SetChildActive(_targetObjectCmpIndex.resultInfoPart,false)
self.finishTip:setActive(false)

self.monsterEffectBefore:setChildShowEffect(0,false)
self.monsterEffectBack:setChildShowEffect(0,false)
self.monsterModel:setChildCanvasGroupAlpha(1)
end

function UIMingYuanZhuSha_MainWin:refreshMonsterModel()
local monsterGroupID=myzsModel:getCurrentMonsterGroupID()
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupID)
local scales2=comHelper.getModelScales2Config(modelParams.body,32)or defaultT
self.monsterModel:setChildUIModelShowTarget(modelParams.body,scales2[1]or 1,modelParams.componets,modelParams.anim,false,false,0)
self.monsterModel:setChildUIModelShowTargetOffset(scales2[2]or 0,scales2[3]or 0)
end

function UIMingYuanZhuSha_MainWin:refreshMerchantModel()
local monsterModelID=myzsModel:getBaseConfig('merchantModelId')

local scales2=comHelper.getModelScales2Config(monsterModelID,32)or defaultT
self.monsterModel:setChildUIModelShowTarget(monsterModelID,scales2[1]or 1,nil,3500,false,false,0)
self.monsterModel:setChildUIModelShowTargetOffset(scales2[2]or 0,scales2[3]or 0)
end

function UIMingYuanZhuSha_MainWin:refreshWaitTargetModel()
self.targetEffect:setChildAnchoredPos(0,115)
self.targetEffect:setChildShowEffect(10671,true)
end

function UIMingYuanZhuSha_MainWin:refreshFinishTargetModel()


local scales2=comHelper.getModelScales2Config(5684,32)or defaultT
self.monsterModel:setChildUIModelShowTarget(5684,scales2[1]or 1,nil,eAnimationID.enter)
self.monsterModel:setChildUIModelShowTargetOffset(scales2[2]or 0,scales2[3]or 0)
end

function UIMingYuanZhuSha_MainWin:refreshTargetObjectHud()
self:resetTargetObjectModelHud()

local hudWB=self.monsterHud:getWidgetBase()

local targetObjectInfo=_targetObjectInfo[self.levelType]
if targetObjectInfo.refreshTargetObjectHud then
targetObjectInfo.refreshTargetObjectHud(hudWB)
end
end

function UIMingYuanZhuSha_MainWin:refreshMonsterHud(hudWB)

local fzList=myzsModel:getCurrentFaZeList()
local len=#fzList

local isShowFz=len>0
hudWB:SetChildActive(_targetObjectCmpIndex.fzList,isShowFz)
if not isShowFz then return end

hudWB:SetChildLayoutGroupCreateItems(_targetObjectCmpIndex.fzList,len,function(index)
local item=hudWB:GetChildLayoutGroupGridItem(_targetObjectCmpIndex.fzList,index-1)

local fzData=fzList[index]
local fzid=fzData[1]

local fzIconName=cfgHelper.get2(cfg_sslawruleconfig_get,fzid,'image')
item:SetChildIcon(0,fzIconName,false)
end)

hudWB:SetChildButtonClick(_targetObjectCmpIndex.fzClick,function()
_this:showFaZeDetailPanel(hudWB,fzList,len)
end,true)


local monsterGroupID=myzsModel:getCurrentMonsterGroupID()
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupID)
local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'headPos')or{0,170}
local scales2=comHelper.getModelScales2Config(modelParams.body,32)or defaultT
local scale=scales2[1]or 1
self.fightModel:setActive(true)
self.fightModel:setChildUIModelRemoveTarget(4045,1,nil,eAnimationID.stand)
self.fightModel:setChildAnchoredPos(headPos[1]*scale*100,headPos[2]*scale*100,0)

end

function UIMingYuanZhuSha_MainWin:refreshMerchantHud(hudWB)
self:stopMerchantSpeakBehavior()
self.isCanShowMerchantSpeak=self.curWinState==_stateEnum.eWait
if self.isCanShowMerchantSpeak then
if not self.merchantSpeakBT then
self:startMerchantSpeakBehavior()
end
end
end

function UIMingYuanZhuSha_MainWin:refreshWaitHud(hudWB)
hudWB:SetChildActive(_targetObjectCmpIndex.resultInfoPart,true)
self:startTargetWaitTimer(hudWB)
end

function UIMingYuanZhuSha_MainWin:refreshFinishHud(hudWB)
self.finishTip:setActive(true)
end

function UIMingYuanZhuSha_MainWin:refreshTreasureHud(hudWB)
end

local _serverFlag={
[1]={name="跨服",bgName="image_myzs_ui32"},
[2]={name="超大跨服",bgName="image_myzs_ui31"}
}
function UIMingYuanZhuSha_MainWin:refreshServerFlagPart()
local type=myzsModel:getSeasonType()
local isShow=type~=nil
self.serverFlagPart:setActive(isShow)

if not isShow then return end

local info=_serverFlag[type]
self.serverFlagName:setText(info.name)
local ab='ui/windows/mingyuanzhusha/mingyuanzhusha_atlas_pak.ab'
self.serverFlagBg:setCSImageSprite(ab,info.bgName)
end

function UIMingYuanZhuSha_MainWin:refreshDiffLevel()
self.difficultLevel:setText(FMT.fmt("难度{0}阶",self.diffLevel))
end


function UIMingYuanZhuSha_MainWin:checkShowHeightMaskPanel()
local isShow=self.isShowChallengeScoreDetailPanel or self.isShowFaZeDetailPanel
self.heightMask:setActive(isShow)
end

function UIMingYuanZhuSha_MainWin:onHeightMask()
if self.isShowChallengeScoreDetailPanel then
self:hideChallengeDetailPanel()
end

if self.isShowFaZeDetailPanel then
self:hideFaZeDetailPanel()
end

self.heightMask:setActive(false)
end


function UIMingYuanZhuSha_MainWin:changeChallengeIcon()
self.scoreOpenRule:setActive(not self.isShowChallengeScoreDetailPanel)
self.scoreCloseRule:setActive(self.isShowChallengeScoreDetailPanel)
end

function UIMingYuanZhuSha_MainWin:showChallengeScoreDetailPanel()
local logList=myzsModel:getChallengeScoreLogList()
local logLen=#logList
if logLen<=0 then
UIManager.info("还没有挑战积分获取记录")
return
end


self.isShowChallengeScoreDetailPanel=not self.isShowChallengeScoreDetailPanel
self:checkShowHeightMaskPanel()
self.scoreDetailPart:setActive(self.isShowChallengeScoreDetailPanel)

self.scoreDetailPart:setChildScrollViewCreateGrids(logLen,1)
local grids=self.scoreDetailPart:getChildScrollViewItemWidgets()

for index=1,grids.Count do
local grid=grids[index-1]
local logData=logList[index]

local str=FMT.fmt("{0}重-{1}：<color=#aae252>{2}</color>",logData.layer,logData.level,logData.score)
grid:SetChildText(0,str)
grid:SetChildActive(1,index~=grids.Count)
end

self:changeChallengeIcon()


end

function UIMingYuanZhuSha_MainWin:hideChallengeDetailPanel()
self.isShowChallengeScoreDetailPanel=false
self.scoreDetailPart:setActive(false)

self:changeChallengeIcon()
end


function UIMingYuanZhuSha_MainWin:showFaZeDetailPanel(hudWB,fzList,len)
self.isShowFaZeDetailPanel=not self.isShowFaZeDetailPanel
self:checkShowHeightMaskPanel()
hudWB:SetChildActive(_targetObjectCmpIndex.fzDetailPart,self.isShowFaZeDetailPanel)

hudWB:SetChildLayoutGroupCreateItems(_targetObjectCmpIndex.fzDetailList,len,function(index)
local item=hudWB:GetChildLayoutGroupGridItem(_targetObjectCmpIndex.fzDetailList,index-1)
local fzData=fzList[index]
local fzid=fzData[1]
local fzlv=fzData[2]

local fzRuleCfg=cfgHelper.getSSlawRule(fzid)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
FMT.fmt(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
local fzIconName=fzRuleCfg.image
item:SetChildIcon(0,fzIconName,false)

item:SetChildText(1,fzdesc)
item:SetChildActive(2,index~=len)
end)
end

function UIMingYuanZhuSha_MainWin:hideFaZeDetailPanel()
self.isShowFaZeDetailPanel=false
local hudWB=self.monsterHud:getWidgetBase()
hudWB:SetChildActive(_targetObjectCmpIndex.fzDetailPart,false)
end


function UIMingYuanZhuSha_MainWin:changeLevel()
self:initData()

self:freshCurrentState()

if self.oldCurLayer==self.curLayer then
self:refreshAllUI()
end
end

function UIMingYuanZhuSha_MainWin:levelResult()
self.oldCurLayer=self.curLayer or-1

local info=_targetObjectInfo[_this.levelType]
if info==nil then return end

if info['levelResult']then
info.levelResult()
end

end

function UIMingYuanZhuSha_MainWin:levelStart()
if self.oldCurLayer~=self.curLayer then
local func=function()
_this.oldCurLayer=_this.curLayer
_this:refreshAllUI()
_this:refreshSpineBg()
_this:levelStart()
loadingControl.closeCloud()
end
loadingControl.openCloud(func,nil,true)
return
end

if self.curWinState==_stateEnum.eFinish or self.curWinState==_stateEnum.eWait then
_this:refreshAllUI()
_this:refreshFightContent()
return
end

local info=_targetObjectInfo[_this.levelType]
if info==nil then return end

if info['levelStart']then
info.levelStart()
end
end



function UIMingYuanZhuSha_MainWin:changeBehaviorState(state)
self.isPlayingBehavior=state==1
end

function UIMingYuanZhuSha_MainWin:stopAllBehavior()
self:stopMerchantSpeakBehavior()
self:stopTargetObjectEnterBehavior()
self:stopKillMonsterBehavior()
self:stopStartFightBehavior()
self:stopMerchantDisppearBehavior()
end



function UIMingYuanZhuSha_MainWin:stopMerchantSpeakBehavior()
if self.merchantSpeakBt then
behaviorManager:removeBehaviorTree(self.merchantSpeakBt)
self.merchantSpeakBt=nil
end
end

function UIMingYuanZhuSha_MainWin:startMerchantSpeakBehavior()
self:stopMerchantSpeakBehavior()

local speakParam=myzsModel:getBaseConfig('speakParam')

if not speakParam then
return
end

if speakParam.duration<=0 then
return
end

local initData={
winName='UIMingYuanZhuSha_MainWin',
winFunc='setMerchantSpeakContent',
widget=self.winlua,
target=self.monsterModel:getID(),
duration=speakParam[1],
skin=speakParam[2],
offset=speakParam[3],
interval=speakParam[4],

defaultAnim=eAnimationID.stand,

content="",
animState=0,
}
self.merchantSpeakBt=behaviorManager:addBehaviorTree('bt_ui_common_speak',nil,true,initData)
end

function UIMingYuanZhuSha_MainWin:setMerchantSpeakContent(bt)
local speakParam=myzsModel:getBaseConfig('speakParam')

if not speakParam then
self:stopMerchantSpeakBehavior()
return
end

local speakContentList=speakParam[5]
local randomIndex=Mathf.Random(1,#speakContentList)
local content=speakContentList[randomIndex][1]
local animId=speakContentList[randomIndex][2]
bt:setSharedVar('content',content)
if animId then
bt:setSharedVar('animState',1)
bt:setSharedVar('animId',animId)
end
end


function UIMingYuanZhuSha_MainWin:stopTargetObjectEnterBehavior()
if self.targetObjectEnterBT then
behaviorManager:removeBehaviorTree(self.targetObjectEnterBT)
self.targetObjectEnterBT=nil
end
end

function UIMingYuanZhuSha_MainWin:startTargetObjectEnterBehavior(val)
self:stopTargetObjectEnterBehavior()

self:changeBehaviorState(1)

local objModelID

local obj_out_scale
local runAnimID
local standAnimID



if self.levelType==MYZSStageType.eMonster then
local monsterGroupID=myzsModel:getCurrentMonsterGroupID()
local monsterGroupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupID)
objModelID=monsterGroupCfg.model[1]

obj_out_scale=_monster_scale
runAnimID=eAnimationID.run
standAnimID=eAnimationID.stand
elseif self.levelType==MYZSStageType.eMerchant then
objModelID=myzsModel:getBaseConfig('merchantModelId')
obj_out_scale=_marchant_scale
runAnimID=eAnimationID.walk
standAnimID=3499
end


local enterDuration=val or _enterDuration
_enterDuration=enterDuration


local initData={
widget=self.winlua,
targetObj=self.targetObjectPart:getID(),
monster=self.monsterModel:getID(),
disciple=self.leaderDiscipleModel:getID(),
bgSpine=self.bgSpine:getID(),
monster_transform_key='monster_transform',

objModelID=objModelID,
objStartPos=_obj_in_pos,
objEndPos=_obj_out_pos,
objStartScale=_obj_in_scale,
objEndScale=obj_out_scale,

objRunAnimID=runAnimID,
objStandAnimID=standAnimID,

enterDuration=enterDuration,

winName='UIMingYuanZhuSha_MainWin',
finishCallBackName="objectEnterCallBack"
}
self.targetObjectEnterBT=behaviorManager:addBehaviorTree('bt_ui_myzs_object_enter',nil,true,initData)
self.targetObjectEnterBT:setSharedVar('monster_transform',self.monsterModel:getTransform())
end

function UIMingYuanZhuSha_MainWin:MoveTargetModel()
self.moveDT=self.targetObjectPart:setChildDOAnchorPos(Vector2.New(170,-40),_enterDuration)
self.moveDT:SetEase(DG.Tweening.Ease.Linear)
self.moveDT:OnComplete(function()
_this:setBgSpineAnim(0)
end)
end

function UIMingYuanZhuSha_MainWin:objectEnterCallBack()
if self.levelType==MYZSStageType.eMerchant then
self:showWindow("UIMingYuanZhuSha_MerchantShopWin")
end
end


function UIMingYuanZhuSha_MainWin:stopKillMonsterBehavior()
if self.killMonsterBT then
behaviorManager:removeBehaviorTree(self.killMonsterBT)
self.killMonsterBT=nil
end
end

function UIMingYuanZhuSha_MainWin:startKillMonsterBehavior()
self:stopKillMonsterBehavior()

self:changeBehaviorState(1)

local initData={
widget=self.winlua,
monster=self.monsterModel:getID(),
monster_transform_key='monster_transform',


effect_back=self.monsterEffectBack:getID(),
effect_before=self.monsterEffectBefore:getID(),

effect_back_id=10670,
effect_before_id=10669,

monster_wait_fade=1,
hide_duration=1,
duration=2,
dead_duration=0.7,

winName='UIMingYuanZhuSha_MainWin',
finishCallBackName="levelStart",

shakeRoot=self.fightContent:getID(),
shakeWaitTime=0.75,
shakeDuration=1,
shakeStrength={30,15,0},
shakeVibrate=35,
}
self.killMonsterBT=behaviorManager:addBehaviorTree('bt_ui_myzs_kill_monster',nil,true,initData)
self.killMonsterBT:setSharedVar('monster_transform',self.monsterModel:getTransform())
end


function UIMingYuanZhuSha_MainWin:stopMerchantDisppearBehavior()
if self.merchantDisappearBT then
behaviorManager:removeBehaviorTree(self.merchantDisappearBT)
self.merchantDisappearBT=nil
end
end

function UIMingYuanZhuSha_MainWin:startMerchantDisappearBehavior()
self:stopMerchantDisppearBehavior()

self:changeBehaviorState(1)

local initData={
widget=self.winlua,
monster_transform_key='monster_transform',

duration=1,

winName='UIMingYuanZhuSha_MainWin',
finishCallBackName="levelStart"
}
self.merchantDisappearBT=behaviorManager:addBehaviorTree('bt_ui_myzs_merchant_disappear',nil,true,initData)
self.merchantDisappearBT:setSharedVar('monster_transform',self.monsterModel:getTransform())
end


function UIMingYuanZhuSha_MainWin:stopStartFightBehavior()
if self.startFightBT then
behaviorManager:removeBehaviorTree(self.startFightBT)
self.startFightBT=nil
end
end

function UIMingYuanZhuSha_MainWin:playStartFightBehavior()
self:stopStartFightBehavior()
local initData={}
self.startFightBT=behaviorManager:addBehaviorTree('bt_ui_myzs_start_fight',nil,true,initData)
end



function UIMingYuanZhuSha_MainWin:stopShowKillMonsterLoseLingLi()
if self.showKillMonsterLingLiMoveDT then
self.showKillMonsterLingLiMoveDT:Complete()
self.showKillMonsterLingLiMoveDT:Kill()
end

if self.showKillMonsterLingLiFadeDT then
self.showKillMonsterLingLiFadeDT:Complete()
self.showKillMonsterLingLiFadeDT:Kill()
end
end

function UIMingYuanZhuSha_MainWin:showKillMonsterLoseLingLi()
self:stopShowKillMonsterLoseLingLi()

local loseVal=myzsModel:getBaseConfig('energy_dec')
self.loseLingLiVal:setText(string.format("%d%%",loseVal))

self.loseLingLi:setChildAnchoredPos(-51.3,39.5)

self:delayDo(1.5,function()
self.loseLingLi:setActive(true)
self.showKillMonsterLingLiMoveDT=self.loseLingLi:setChildDOAnchorPosY(180,3)
self:delayDo(1.5,function()
self.showKillMonsterLingLiFadeDT=self.loseLingLi:setChildCanvasGroupDOFade(0,1.5,function()
if _this==nil then return end

_this.loseLingLi:setActive(false)
_this.loseLingLi:setChildCanvasGroupAlpha(1)
end)
end)
end)

end

function UIMingYuanZhuSha_MainWin:fightShakeAnim()

end


function UIMingYuanZhuSha_MainWin.recv_13_31()
local func=function()
_this:initData()
_this:checkWinState()
_this:refreshAll()
UIFullAirGameEnterController:closeUI()
end
loadingControl.openCloud(func,2)
end

function UIMingYuanZhuSha_MainWin.recv_13_34(interaction_type,idx,discipleDataListLen,discipleDataList)
if interaction_type==MYZSInteractionType.eBuyItem then
_this:refreshMoney()
_this:refreshFightOperationPart()
elseif interaction_type==MYZSInteractionType.eSelectBW then
_this:levelResult()
end
end

function UIMingYuanZhuSha_MainWin.recv_13_35(level,discipleListLen,discipleList,nextShopItemListLen,nextShopItemList)
_this:levelResult()
end

function UIMingYuanZhuSha_MainWin.on_money_changed(mtype)
if mtype==_this.needChangeMoneyId then
_this:refreshMoney()
end
end

function UIMingYuanZhuSha_MainWin.onShowPrize(prizeType,temp,effectData,temp2)

if prizeType==ePrizeType.eMingYuanZhuSha then
for i,v in ipairs(temp)do
local itemid=v.itemid
local num=v.num
local iconName=iconHelper.getIconName(itemid)
UIManager.rewardInfo(iconName,FMT.fmt('X{0}',num))
end
end
end

function UIMingYuanZhuSha_MainWin.onMingYuanZhuShaStateChange()
if _this==nil then return end







end



function UIMingYuanZhuSha_MainWin:stopAllTimer()
self:stopSettlementTimer()
end


function UIMingYuanZhuSha_MainWin:stopSettlementTimer()
if self.settlementTimer then
self:stopTimerByID(self.settlementTimer)
self.settlementTimer=nil
end
end

function UIMingYuanZhuSha_MainWin:startSettlementTimer(settlementFmt,endTimeStamp,defaultStr)
self:stopSettlementTimer()
if endTimeStamp==nil then logErr("no endTimeStamp")end

local curTimeStamp=timeHelper.getServerShortTime()
if endTimeStamp<curTimeStamp then

logErr("invalid endTimeStamp")

return
end

local left,str
local func=function()
curTimeStamp=timeHelper.getServerShortTime()
left=endTimeStamp-curTimeStamp
str=FMT.fmt(settlementFmt,timeHelper.format_time_stamp3(left))

if left<0 then
_this:stopSettlementTimer()
if _this:checkWinState(_stateEnum.eIdle)then
_this:refreshSettlementPart()
end
str=defaultStr
end
_this.settlementLeftTimeTxt:setText(str)
end

self.settlementTimer=self:setTimer(1,0,func)
func()
end

function UIMingYuanZhuSha_MainWin:stopTargetWaitTimer()
if self.targetWaitTimer then
self:stopTimerByID(self.targetWaitTimer)
self.targetWaitTimer=nil
end
end

function UIMingYuanZhuSha_MainWin:startTargetWaitTimer(hudWidget)
self:stopTargetWaitTimer()
local endTimeStamp=myzsModel:getNextLayerUnlockTime()
local nextLayer=myzsModel:getNextUnlockLayer()
if endTimeStamp==nil then logErr("no endTimeStamp")end

local curTimeStamp=timeHelper.getServerShortTime()
if endTimeStamp<curTimeStamp then logErr("invalid endTimeStamp")end

local left,str
local func=function()
curTimeStamp=timeHelper.getServerShortTime()
left=endTimeStamp-curTimeStamp
str=FMT.fmt("{0}后开启第{1}重",timeHelper.format_time_stamp12(left),nextLayer)
hudWidget:SetChildText(_targetObjectCmpIndex.resultInfo,str)
if left<=0 then
_this:stopTargetWaitTimer()



end
end

self.targetWaitTimer=self:setTimer(1,0,func)
func()
end





function UIMingYuanZhuSha_MainWin:onBackBtn()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end



function UIMingYuanZhuSha_MainWin:onDiscipleStateBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eMYZS_DisicpleState,{})
end



function UIMingYuanZhuSha_MainWin:onFightBtn()

if self.isPlayingBehavior then return end
if not self:checkCanClickBtn()then UIManager.info('弟子前进中')return end

if self.curWinState==_stateEnum.eFinish then
UIManager.info("已通关当期最高重数")
return
end

if self.curWinState==_stateEnum.eWait then
local nextStageIdx=myzsModel:getNextUnlockLayer()
local settlementFmt="<color=#7d3b17>{0}</color>后开启第"..nextStageIdx..'重'
local endTimeStamp=myzsModel:getNextLayerUnlockTime()
local curTimeStamp=timeHelper.getServerShortTime()
local left=endTimeStamp-curTimeStamp
local info=FMT.fmt(settlementFmt,timeHelper.formatSimpleTime(left))
UIManager.info(info)
return
end






myzsController:startFight()
end



function UIMingYuanZhuSha_MainWin:onKillBtn()
if self.isPlayingBehavior then UIManager.info('弟子前进中')return end
if not self:checkCanClickBtn()then return end





self:refreshData_DiscipleTeamFightVal()
local killMonsterNeedFightVal=myzsModel:getKillMonsterFightVal()
local isCanKill=self.discipleTeamFightVal>=killMonsterNeedFightVal
if isCanKill then
local guidList=myzsModel:getDiscipleTeamGuidList()
myzsController.reqGotoNextLevel(#guidList,guidList)
end
end



function UIMingYuanZhuSha_MainWin:onRankBtn()




self:showWindow("UIMingYuanZhuSha_RankInfoWin")
end



function UIMingYuanZhuSha_MainWin:onRestartBtn()
if self.isPlayingBehavior then UIManager.info('弟子前进中')return end
if not self:checkCanClickBtn()then return end

if myzsModel:checkInXiuSai()then
UIManager.info("休战期不可重新挑战")
return
end

if self.gameIdx<=1 then
UIManager.info("请先击败任意妖魔")
return
end


self:showWindow("UIMingYuanZhuSha_RestartWin")
end



function UIMingYuanZhuSha_MainWin:onRewardBtn()

if not myzsModel:checkOpenTxz()then



return
end



local func=function(args_)
myzsController:showFullWin()
end
fullScreenUI.setNextActiveUICallback(func)
UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eMingYuanZhuSha_Txz})
end



function UIMingYuanZhuSha_MainWin:onRuleBtn()

local d={}
d.mode=3
d.title="规则说明"
d.name='myzs_rule_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UIMingYuanZhuSha_MainWin:onShowSelectDiscipleBtn()
self:showWindow("UIMingYuanZhuSha_SelectDiscipleWin")
end

function UIMingYuanZhuSha_MainWin:onOpenMerchantBtn()
if not self:checkCanClickBtn()then return end
if self.isPlayingBehavior then return end
if self.levelType~=MYZSStageType.eMerchant then return end

self:showWindow("UIMingYuanZhuSha_MerchantShopWin")
end

function UIMingYuanZhuSha_MainWin:onShowScoreDetailBtn()
self:showChallengeScoreDetailPanel()
end

function UIMingYuanZhuSha_MainWin:onMoneyPart()
gainControl:showGainWin(_this.needChangeMoneyId)
end

function UIMingYuanZhuSha_MainWin:onXiuSaiBtn()
UIManager.info("休战期不可挑战")
end

function UIMingYuanZhuSha_MainWin:onClickMonsterBtn()
end

function UIMingYuanZhuSha_MainWin:onDifficultLevelPart()
self:showWindow('UIMingYuanZhuSha_DiffRewardWin',{
layer=self.curLayer,
diffLevel=myzsModel:getDiffLevel(),
})
end

function UIMingYuanZhuSha_MainWin:checkCanClickBtn()
local nowStamp=timeHelper.getServerShortTime()
local state=nowStamp-_btnClickStamp>_btnClickInterval
if state then
_btnClickStamp=nowStamp

end

return state
end

