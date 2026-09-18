







def_class("UIDouFaTaiWin",UIWindowBase)









function UIDouFaTaiWin:bindComponents()

self.rewardList=UIObject.get(self,0)
self.rewardReddot=UIObject.get(self,1)
self.fazeIcon=UIImage.get(self,2)
self.notHaveReward=UIText.get(self,3)
self.haveReward=UIObject.get(self,4)
self.shopBtn=UIButton.get(self,5)
self.rewardBtn=UIButton.get(self,6)
self.rankBtn=UIButton.get(self,7)
self.recordBtn=UIButton.get(self,8)
self.fazeIconBtn=UIButton.get(self,9)
self.selfRank=UIText.get(self,10)
self.selfRankTips=UIButton.get(self,11)
self.selfRankRedot=UIObject.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.timeText=UIText.get(self,14)
self.number_3=UIObject.get(self,15)
self.number_2=UIObject.get(self,16)
self.number_1=UIObject.get(self,17)
self.rewardTips=UIObject.get(self,18)
self.selfFight=UIText.get(self,19)
self.selfName=UIText.get(self,20)
self.selfHeadKuang=UIImage.get(self,21)
self.defendersBtn=UIButton.get(self,22)
self.challengeBtn=UIButton.get(self,23)
self.helpBtn=UIButton.get(self,24)
self.selfHeadIcon=UIImage.get(self,25)
self.selfDuanWeiValue=UIText.get(self,26)
self.selfDuanWeiIcon=UIImage.get(self,27)
self.selfScoreIcon=UIImage.get(self,28)
self.selfScoreValue=UIText.get(self,29)
self.truceBtn=UIButton.get(self,30)
self.credentialsListBtn=UIButton.get(self,31)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.fazeIconBtn:setButtonClick(function()self:onFazeIconBtn()end)

self.selfRankTips:setButtonClick(function()self:onSelfRankTips()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.defendersBtn:setButtonClick(function()self:onDefendersBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.truceBtn:setButtonClick(function()self:onTruceBtn()end)

self.credentialsListBtn:setButtonClick(function()self:onCredentialsListBtn()end)
self.number={
self.number_1,
self.number_2,
self.number_3,
}



end


function UIDouFaTaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.fazeIcon);self.fazeIcon=nil;
_UIObject_release(self.notHaveReward);self.notHaveReward=nil;
_UIObject_release(self.haveReward);self.haveReward=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.fazeIconBtn);self.fazeIconBtn=nil;
_UIObject_release(self.selfRank);self.selfRank=nil;
_UIObject_release(self.selfRankTips);self.selfRankTips=nil;
_UIObject_release(self.selfRankRedot);self.selfRankRedot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.number_3);self.number_3=nil;
_UIObject_release(self.number_2);self.number_2=nil;
_UIObject_release(self.number_1);self.number_1=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.selfFight);self.selfFight=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.selfHeadKuang);self.selfHeadKuang=nil;
_UIObject_release(self.defendersBtn);self.defendersBtn=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfDuanWeiValue);self.selfDuanWeiValue=nil;
_UIObject_release(self.selfDuanWeiIcon);self.selfDuanWeiIcon=nil;
_UIObject_release(self.selfScoreIcon);self.selfScoreIcon=nil;
_UIObject_release(self.selfScoreValue);self.selfScoreValue=nil;
_UIObject_release(self.truceBtn);self.truceBtn=nil;
_UIObject_release(self.credentialsListBtn);self.credentialsListBtn=nil;
self.number=nil;
end

















local item_index=
{
kuang=0,
head=1,
zmname=2,
playername=3,
duanweiIcon=4,
duanweiVal=5,
model=6,
have=7,
nothave=8,
}


function UIDouFaTaiWin:onLoaded(...)
self:bindComponents()
end


function UIDouFaTaiWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
if UIFullDouFaTaiControl.fightStage then
UIFullDouFaTaiControl.fightStage:close()
UIFullDouFaTaiControl.fightStage=nil
end
end




function UIDouFaTaiWin:onShow(argtable,afterOnloaded)
self:updataView()
self:refreshTime()


self:refreshRewardReddot()

local curIconName=iconHelper.getSkillIcon(1)
self.fazeIcon:setImageIcon(curIconName,false)
local config=douFaTaiModel:getDouFaTaiBasicConfig()
if not config.shopId then
self.shopBtn:setActive(false)
end

if argtable and argtable.args and argtable.args.openShop then
self:onShopBtn()
end
end

function UIDouFaTaiWin:onShowArgRecv()
self:updataView()
self:refreshRewardReddot()
end




function UIDouFaTaiWin:onHide()

end

function UIDouFaTaiWin:refreshRewardReddot()
local rewardRdot=douFaTaiModel:checkRewardReddot()
self.rewardReddot:setActive(rewardRdot)

end

function UIDouFaTaiWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.rewardReddot:setRotation(0,0,0)
local tweener=self.rewardReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self.rewardReddot:setRotation(0,0,0)
end
end
end

function UIDouFaTaiWin:updataView()
self.doufataiData=douFaTaiModel:get_doufatai_data()
if not self.doufataiData then
return
end
self:refreshSelfInfo()
self:refreshRankPlayerInfo()
end

function UIDouFaTaiWin:refreshSelfInfo()
if not self.doufataiData then
return
end
local rank=self.doufataiData.rank
local inRank=rank~=0
local zmName=UISettingModel:getZMName()
local playerName=playerModel:getActorName()
local fight=douFaTaiModel:getSelfFight()
local name=FMT.fmt('{0}·{1}',zmName,playerName)
self.selfName:setText(name)
self.selfFight:setText(fight)
local rankStr=''
if inRank then
rankStr=FMT.fmt('<color=#7d3b17>排名：</color>{0}名',rank)
else
rankStr='<color=#7d3b17>排名：</color>未上榜'
end
self.selfRank:setText(rankStr)
local showRedot=douFaTaiModel:checkDailyRewardChange(rank)
local redotFlag=douFaTaiModel:getDailyRewardFlag()
self.selfRankRedot:setActive(showRedot and redotFlag)

playerController:setHeadIcon(self.winid,self.selfHeadIcon:getID(),{scale=0.7})

local score=self.doufataiData.wendao
local iconName=douFaTaiModel:getWenDaoIconName()
self.selfScoreIcon:setImageIcon(iconName,false)
local scoreStr=FMT.fmt('<color=#7d3b17>问道：</color>{0}',score)
self.selfScoreValue:setText(scoreStr)
local duanweiName,duanweiIcon=douFaTaiModel:getDuanWeiName(score)
local duanweiIconName=iconHelper.getDouFaTaiIcon(duanweiIcon)
self.selfDuanWeiIcon:setImageIcon(duanweiIconName,false)
self.selfDuanWeiValue:setText(duanweiName)


local isTruce=douFaTaiModel:checkIsTruce()
self.challengeBtn:setActive(not isTruce)
self.truceBtn:setActive(isTruce)
self.credentialsListBtn:setActive(true)
end

function UIDouFaTaiWin:refreshRankPlayerInfo()
local rankList=douFaTaiModel:get_rank_data()
for i=1,3 do
local actorInfo=rankList[i]
local widget=self.number[i]:getChildWidgetBase()
widget:SetChildActive(item_index.have,actorInfo~=nil)
widget:SetChildActive(item_index.nothave,actorInfo==nil)
if actorInfo then
local isEmpty=actorInfo.name==''

if not isEmpty then
playerController:setHeadIcon(widget,item_index.head,{scale=0.7,iconInfo=actorInfo.iconInfo})
widget:SetChildButtonClick(-1,function()


douFaTaiController:req_actor_detail_new(actorInfo.actorId,nil,DOUFATAI_LOOK_TYPE.eMain,true)
end)
end
widget:SetChildActive(item_index.head,not isEmpty)
widget:SetChildActive(9,isEmpty)
local zmName=isEmpty and playerModel:getOtherZongMenName(actorInfo.zmName)or actorInfo.zmName
local playerName=playerModel:getOtherActorName(actorInfo.name)
widget:SetChildText(item_index.zmname,zmName)
widget:SetChildText(item_index.playername,playerName)
local score=actorInfo.wendao or 0
local iconName=douFaTaiModel:getWenDaoIconName()



widget:SetChildCSImageIcon(item_index.duanweiIcon,iconName,false)
widget:SetChildText(item_index.duanweiVal,score)

if tostring(actorInfo.discipledata)~='0'then
local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(actorInfo)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.7,modelParams.componets,eAnimationID.stand)
else

end



end
end
end

function UIDouFaTaiWin:refreshTime()
if not self.doufataiData then
return
end
local curTime=timeHelper.getServerShortTime()
local isTruce=douFaTaiModel:checkIsTruce()
local endTime
local timeStr
if isTruce then

endTime=douFaTaiModel:get_doufatai_truceEndTime()
timeStr=FMT.fmt('休战结束倒计时：{0}',timeHelper.format_time_stamp3(endTime-curTime))
else

endTime=self.doufataiData.settleTime
timeStr=FMT.fmt('赛季结束倒计时：{0}',timeHelper.format_time_stamp3(endTime-curTime))
end
self.timeText:setText(timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local timeStr
if isTruce then
timeStr=FMT.fmt('休战结束倒计时：{0}',timeHelper.format_time_stamp3(dtTime))
else
timeStr=FMT.fmt('赛季结束倒计时：{0}',timeHelper.format_time_stamp3(dtTime))
end
self.timeText:setText(timeStr)
if dtTime<=0 then
self:stopSelfTimer()

douFaTaiController:req_doufatai_data()
end
end
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=self:setTimer(1,0,func)
end

function UIDouFaTaiWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIDouFaTaiWin:refreshEveryDayReward()
if not self.doufataiData then
return
end
local rank=self.doufataiData.rank
local config=douFaTaiModel:getRankRewardConfig(rank)
self.haveReward:setActive(config~=nil)
self.notHaveReward:setActive(config==nil)
if config then
local rewards=config.daily_rewards
self.rewardList:setChildLayoutGroupCreateItems(#rewards)
local grids=self.rewardList:getChildLayoutGroupGridList()
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
end

function UIDouFaTaiWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end




function UIDouFaTaiWin:onChallengeBtn()
UIFullDouFaTaiControl:showChallengeWin()
end


function UIDouFaTaiWin:onRewardBtn()
UIFullDouFaTaiControl:showWindow('UIDouFaTaiRewardWin')
end


function UIDouFaTaiWin:onRankBtn()
UIFullDouFaTaiControl:showWindow('UIDouFaTaiRankWin')
end


function UIDouFaTaiWin:onRecordBtn()
UIFullDouFaTaiControl:showWindow('UIDouFaTaiRecordWin')
end


function UIDouFaTaiWin:onFazeIconBtn()
UIFullDouFaTaiControl:showWindow('UIDouFaTaiFaZeWin')
end


function UIDouFaTaiWin:onDefendersBtn()
if not self.doufataiData then
return
end
local teamList=self.doufataiData.defenseList or{}
local list={}
for i,v in ipairs(teamList)do
list[i]=v.unitId
end
local enterCallBack=function(guidList)
local speakStr=douFaTaiModel:getSelfChallengeSentence()
local win=UIManager:findActiveWindow('UIDouFaTaiFightExtraWin')
if win then
speakStr=win:getInputStr()
end
douFaTaiModel:setTemporaryData(guidList,speakStr)
local func=function(...)
local win2=UIManager:findActiveWindow('UIDouFaTaiFightExtraWin')
if win2 then
win2:onCheckStringLegal(...)
end
end
chatProtocolControl.sendCheckLegalStr(speakStr,func)
end
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="斗法台",
teamList=list,
skipDiscipleStateCheck=true,
statePriorityCheck=true,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()
fightController:closeSelectStage()
UIFullDouFaTaiControl:showDouFaTaiWindow()
UIManager:closeWindow('UIDouFaTaiFightExtraWin')
end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
}
UIFullDouFaTaiControl:closeUI(false)
fightController.showPrepareWin(eFightPreSelectType.doufataidefense,winArgs,function()
UIManager:showWindow('UIDouFaTaiFightExtraWin',{DOUFATAI_LOOK_TYPE.eSelf})
end)
end


function UIDouFaTaiWin:onSelfRankTips()
self.showEveryDay=not self.showEveryDay
self.rewardTips:setActive(self.showEveryDay)
self:refreshEveryDayReward()

local flag=douFaTaiModel:getDailyRewardFlag()
if flag then
douFaTaiModel:changeDilyRewardFlag(false)
self.selfRankRedot:setActive(false)
end
end

function UIDouFaTaiWin:onCloseBtn()
if UIFullDouFaTaiControl.fightStage then
UIFullDouFaTaiControl.fightStage:close()
UIFullDouFaTaiControl.fightStage=nil
end
UIFullDouFaTaiControl:closeUI(nil,true)
end

function UIDouFaTaiWin:onHelpBtn()
local d={}
d.title='斗法台规则'
d.mode=3
d.name='doufatai_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIDouFaTaiWin:onShopBtn()
local config=douFaTaiModel:getDouFaTaiBasicConfig()
if config.shopId then
funcShopController:openShopWin({shopId=config.shopId})
end
end


function UIDouFaTaiWin:onTruceBtn()
UIManager.error("休战期间无法挑战")
end


function UIDouFaTaiWin:onCredentialsListBtn()
local isTruce=douFaTaiModel:checkIsTruce()
if isTruce then

self:showWindow('UIDouFaTaiCredentialsListWin')
else

self:showWindow('UIDouFaTaiCredentialsListWin2')
end

end
