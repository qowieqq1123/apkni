







def_class("UIMoJieStageAimChapterContentWin3",UIWindowBase)









function UIMoJieStageAimChapterContentWin3:bindComponents()

self.background=UIImage.get(self,0)
self.closeMJZFReward=UIButton.get(self,1)
self.finishImg=UIObject.get(self,2)
self.gkFightCDPart=UIObject.get(self,3)
self.gkFightCDTxt=UIText.get(self,4)
self.gkHpPart=UIObject.get(self,5)
self.hpBar=UIObject.get(self,6)
self.hpTxt=UIText.get(self,7)
self.jumpBtn=UIButton.get(self,8)
self.mainTask=UIObject.get(self,9)
self.mainTaskTxt=UIText.get(self,10)
self.mjzfReddot=UIObject.get(self,11)
self.mjzfRewardBtn=UIButton.get(self,12)
self.mjzfRewardList=UIObject.get(self,13)
self.mjzfWinner=UIObject.get(self,14)
self.mjzfWinnerName=UIText.get(self,15)
self.mojiezhenfeng=UIObject.get(self,16)
self.progressBox=UIObject.get(self,17)
self.progressInfo=UIObject.get(self,18)
self.recvRewardBtn=UIButton.get(self,19)
self.stagePassLevelRewardList=UIObject.get(self,20)
self.storyBg=UIObject.get(self,21)
self.storyTx=UIText.get(self,22)
self.storyTx2=UIText.get(self,23)
self.tipsTx=UIText.get(self,24)

self.closeMJZFReward:setButtonClick(function()self:onCloseMJZFReward()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.mjzfRewardBtn:setButtonClick(function()self:onMjzfRewardBtn()end)

self.recvRewardBtn:setButtonClick(function()self:onRecvRewardBtn()end)



end


function UIMoJieStageAimChapterContentWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeMJZFReward);self.closeMJZFReward=nil;
_UIObject_release(self.finishImg);self.finishImg=nil;
_UIObject_release(self.gkFightCDPart);self.gkFightCDPart=nil;
_UIObject_release(self.gkFightCDTxt);self.gkFightCDTxt=nil;
_UIObject_release(self.gkHpPart);self.gkHpPart=nil;
_UIObject_release(self.hpBar);self.hpBar=nil;
_UIObject_release(self.hpTxt);self.hpTxt=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.mainTask);self.mainTask=nil;
_UIObject_release(self.mainTaskTxt);self.mainTaskTxt=nil;
_UIObject_release(self.mjzfReddot);self.mjzfReddot=nil;
_UIObject_release(self.mjzfRewardBtn);self.mjzfRewardBtn=nil;
_UIObject_release(self.mjzfRewardList);self.mjzfRewardList=nil;
_UIObject_release(self.mjzfWinner);self.mjzfWinner=nil;
_UIObject_release(self.mjzfWinnerName);self.mjzfWinnerName=nil;
_UIObject_release(self.mojiezhenfeng);self.mojiezhenfeng=nil;
_UIObject_release(self.progressBox);self.progressBox=nil;
_UIObject_release(self.progressInfo);self.progressInfo=nil;
_UIObject_release(self.recvRewardBtn);self.recvRewardBtn=nil;
_UIObject_release(self.stagePassLevelRewardList);self.stagePassLevelRewardList=nil;
_UIObject_release(self.storyBg);self.storyBg=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end


















local _this

local _stageRewardInfoIndex={
target=1,
rewardInfo=2
}

local _rewardInfoIndex={
id=1,
quantity=2
}




function UIMoJieStageAimChapterContentWin3:onLoaded(...)
self:bindComponents()

_this=self

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
end


function UIMoJieStageAimChapterContentWin3:__delete()
_this=nil

self:stopFightCD()

self:unbindComponents()
end




function UIMoJieStageAimChapterContentWin3:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=self.showParams.handleType
self.stageIdx=self.showParams.stageIdx
self.stageHandle=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
self.winArgs=self.stageCfg.winArgs

self.minHpGateId=xianjieModel:getMinHpMoJieGateIdWithSelfXMAttacking()
self.curDestoryGateCount=xianjieModel:getMoJieGateFinishAttackCount()

self:refreshAll()

self:freshMJZFRewardList()
end


function UIMoJieStageAimChapterContentWin3:onHide()

end





function UIMoJieStageAimChapterContentWin3:onJumpBtn()
if not self.stageHandle:isOverBegin()then
local beginTime=self.stageHandle.beginTime
local stageName=self.stageCfg.name
local serverTime=timeHelper.getServerShortTime()
local left=beginTime-serverTime
UIManager.info(FMT.fmt("{0}章节将于{1}后开启",stageName,timeHelper.format_time_stamp4(left)))
return
end

local jumpParams=self.winArgs.jumpBtn.jump
if jumpParams==nil then return end

local canPassGateID=xianjieModel:getMoJieGateSelfXMCanPassAnyGateId()

jumpParams.args={}
if canPassGateID~=nil then
jumpParams.args.gateid=canPassGateID
elseif self.minHpGateId then
jumpParams.args.gateid=self.minHpGateId
else
local gates=xianjieModel:getMoJieGateIdListWithSelfXianYu()
jumpParams.args.gateid=gates[1]
end

jumpManager:jump(jumpParams)
end

function UIMoJieStageAimChapterContentWin3:onCloseMJZFReward()
self.isShowMJZFReward=not self.isShowMJZFReward
self.mjzfRewardList:setActive(self.isShowMJZFReward)
self.closeMJZFReward:setActive(self.isShowMJZFReward)
end

function UIMoJieStageAimChapterContentWin3:onRecvRewardBtn()
local isFinish=self.stageHandle:isFinish()
local isReceived=self.stageHandle.pass_rw_flag==1
local isCanRecv=isFinish and(not isReceived)
if isCanRecv then
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,11)
end
end



function UIMoJieStageAimChapterContentWin3:refreshAll()
self:initActiveData()

self:freshBackGround()
self:freshProgressBox()
self:freshJumpBtn()
self:freshMidTips()
self:freshMainTask()
self:freshFinishImg()
self:freshProgressStateInfo()
self:refreshStagePassLevelRewardPart()

self:refreshMJZFInfo()

self:activeObjects()
end



function UIMoJieStageAimChapterContentWin3:initActiveData()

self.isShowProgressBox=true
self.isShowMidTips=true
self.isShowProgressInfo=false
self.isShowFightCD=false

self.isShowRecvRewardBtn=false


self.isShowBg=self.winArgs.backgroundImage~=nil
self.isShowJumpBtn=self.winArgs.jumpBtn~=nil
self.isShowMaintask=self.stageCfg.passLevelCondition~=nil


self.isShowFinishImg=self.stageHandle:isFinish()
end

function UIMoJieStageAimChapterContentWin3:activeObjects()
self.background:setActive(self.isShowBg)
self.progressBox:setActive(self.isShowProgressBox)
self.jumpBtn:setActive(self.isShowJumpBtn and(not self.isShowRecvRewardBtn))
self.tipsTx:setActive(self.isShowMidTips)
self.mainTask:setActive(self.isShowMaintask)
self.finishImg:setActive(self.isShowFinishImg and(not self.isShowJumpBtn))
self.progressInfo:setActive(self.isShowProgressInfo)
self.gkFightCDPart:setActive(self.isShowProgressInfo)

self.recvRewardBtn:setActive(self.isShowRecvRewardBtn)
end

function UIMoJieStageAimChapterContentWin3:freshBackGround()
if not self.isShowBg then return end

local imageCfg=self.winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])
end
function UIMoJieStageAimChapterContentWin3:freshProgressBox()
local wb=self.progressBox:getChildWidgetBase()

local tips=FMT.fmt("{0}：{1}",self.winArgs.stageScoreRewardTips,self.stageHandle.chapterScore)
wb:SetChildText(0,tips)


local stageScoreRewardList=self.stageCfg.stageScoreRewardList
local rewardBoxInfo=self.winArgs.boxParam
local rewardBoxLen=#rewardBoxInfo

local len=#stageScoreRewardList

local pval=seasonModel:getStageSegementProgressVal(self.showParams.handleType,self.showParams.stageIdx,self.stageHandle.chapterScore)
wb:SetChildProgressValue(1,pval*100,100)
wb:SetChildProgressText(1,"")

local serverWideScore=self.stageHandle.chapterScore
local personalScore=self.stageHandle.actor_stage_score or 0

local receive=self.stageHandle.stage_rw_idx

wb:SetChildLayoutGroupCreateItems(2,len,function(index)

























local idIndex=-1
local getWidgetId=function()
idIndex=idIndex+1
return idIndex
end

local rewardItemSubWidgetID={
base=getWidgetId(),
itemSmall=getWidgetId(),
locked=getWidgetId(),
claimed=getWidgetId(),
targetNumTex=getWidgetId(),
click=getWidgetId(),
canReceive=getWidgetId(),
redDot=getWidgetId()
}
local itemSmallSubWidgetID={
mask=7
}


self.enablePersonalConstraint=self.stageCfg.actorStageScoreCond~=nil and not xianjieModel:isBeginnerSeason()

local item=wb:GetChildLayoutGroupGridItem(2,index-1)
local stageScoreRewardInfo=stageScoreRewardList[index]
local serverWideTargetScore=stageScoreRewardInfo[_stageRewardInfoIndex.target]

local personalTargetScore=self.enablePersonalConstraint and self.stageCfg.actorStageScoreCond[index]or-1


local isCanReceive=serverWideScore>=serverWideTargetScore
if self.enablePersonalConstraint then
isCanReceive=isCanReceive and personalScore>=personalTargetScore
end

local isClaimed=receive>=index

local rewardList=stageScoreRewardInfo[_stageRewardInfoIndex.rewardInfo]
local itemId=rewardList[1][_rewardInfoIndex.id]
local itemQuantity=rewardList[1][_rewardInfoIndex.quantity]

local rewardItemCfg={
itemid=itemId,
itemcount=itemQuantity,
showCountBG=itemQuantity>1,
showStage=true,
showname=false,
gray=0
}
local propData=itemsComponentHelper.getCommonFillDataSmall(rewardItemCfg)
item:SetChildPropData(rewardItemSubWidgetID.itemSmall,propData)
local itemSmallWb=item:GetChildWidgetBase(rewardItemSubWidgetID.itemSmall)
itemSmallWb:SetChildActive(itemSmallSubWidgetID.mask,isClaimed)

item:SetChildActive(rewardItemSubWidgetID.locked,not isCanReceive)
item:SetChildActive(rewardItemSubWidgetID.claimed,isClaimed)
item:SetChildText(rewardItemSubWidgetID.targetNumTex,serverWideTargetScore)
item:SetChildActive(rewardItemSubWidgetID.canReceive,isCanReceive and not isClaimed)
item:SetChildActive(rewardItemSubWidgetID.redDot,isCanReceive and not isClaimed)


item:SetChildButtonClick(rewardItemSubWidgetID.click,function()
if isCanReceive and(not isClaimed)then
seasonController:send_39_2(_this.showParams.handleType,_this.showParams.stageIdx,22)
else
_this:onClickBox(index)
end
end)
end)

end

function UIMoJieStageAimChapterContentWin3:onClickBox(index)
local cfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local stageScoreRewardInfo=cfg.stageScoreRewardList[index]
local rewardList=stageScoreRewardInfo[_stageRewardInfoIndex.rewardInfo]


local rewardId=rewardList[1][_rewardInfoIndex.id]

local serverWideTargetScore=stageScoreRewardInfo[_stageRewardInfoIndex.target]
local serverWideCurrentScore=self.stageHandle.chapterScore


local personalTargetScore=self.enablePersonalConstraint and cfg.actorStageScoreCond[index]or-1
local personalCurrentScore=self.stageHandle.actor_stage_score or 0


local tipsContent={
serverWideCond=self.winArgs.stageScoreRewardTips,
personalCond=self.winArgs.actorScoreRewardTips
}

if UIManager:isActive("UIMoJieRewardClaimConditionTipsWin")then
UIManager:closeWindow("UIMoJieRewardClaimConditionTipsWin")
end

UIManager:showWindow("UIMoJieRewardClaimConditionTipsWin",{
tipsTextContent=tipsContent,
serverWideTargetScore=serverWideTargetScore,
serverWideCurrentScore=serverWideCurrentScore,
personalTargetScore=personalTargetScore,
personalCurrentScore=personalCurrentScore
})

tipsManager.showTips({
itemid=rewardId,
showModel=false,
closeCallback=function()
if UIManager:isActive("UIMoJieRewardClaimConditionTipsWin")then
UIManager:closeWindow("UIMoJieRewardClaimConditionTipsWin")
end
end
})

























end

function UIMoJieStageAimChapterContentWin3:freshJumpBtn()




local isGray=not self.stageHandle:isOverBegin()
self.jumpBtn:setGray(isGray)
end

local _attachmentArgsTips=function(args)
local type=args[1]
local tips=args[2]
if type==0 then return tips end

if type==1 then
return FMT.fmt(tips,_this.stageHandle.chapterScore)
end
end
function UIMoJieStageAimChapterContentWin3:freshMidTips()
if not xianmengModel:hasXM()then
self.tipsTx:setText('暂无仙盟')
return
end
local stageState=self.stageHandle:getState()



local tipStr
if stageState==eSeasonStageStateEnum.eUnLock then
self.isShowMidTips=true
self:startOpenTimer()
elseif stageState==eSeasonStageStateEnum.eDoing then
if self.minHpGateId==nil then
tipStr=_attachmentArgsTips(self.winArgs.recordStr)
else
self.isShowMidTips=false
end
elseif stageState==eSeasonStageStateEnum.eFinish then
self.isShowMidTips=true
tipStr=_attachmentArgsTips(self.winArgs.finishStr)
end

if tipStr then
self.tipsTx:setText(tipStr)
end
end

function UIMoJieStageAimChapterContentWin3:startOpenTimer()
self:stopOpenTimer()

local curTime=timeHelper.getServerShortTime()
local beginTime=self.stageHandle.beginTime

local strFmt=self.winArgs.openPreStr

local func=function()
curTime=timeHelper.getServerShortTime()
local left=beginTime-curTime
local timeStr=timeHelper.format_time_stamp4(left)
local infoStr=FMT.fmt(strFmt,timeStr)
_this.tipsTx:setText(infoStr)

if left<0 then
_this:stopOpenTimer()
_this:refreshAll()
end
end

self.openTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimChapterContentWin3:stopOpenTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end
function UIMoJieStageAimChapterContentWin3:freshMainTask()
local passLevelCondition=self.stageCfg.passLevelCondition

local limitVal=Mathf.Min(self.stageHandle.chapterScore,passLevelCondition.max)
local str=FMT.fmt("{0}  {1}/{2}",passLevelCondition.desc,limitVal,passLevelCondition.max)

self.mainTaskTxt:setText(str)
end

function UIMoJieStageAimChapterContentWin3:freshFinishImg()
end

function UIMoJieStageAimChapterContentWin3:refreshStagePassLevelRewardPart()
local passStageReward=self.stageCfg.passStageReward

local len=#passStageReward

local isFinish=self.stageHandle:isFinish()
local isReceived=self.stageHandle.pass_rw_flag==1
local isCanRecv=isFinish and(not isReceived)

self.isShowRecvRewardBtn=isCanRecv

local createFunc=function(index)
if _this==nil then return end

local item=_this.stagePassLevelRewardList:getChildLayoutGroupGridItem(index-1)
local data=passStageReward[index]

local itemid=data[1]
local itemnum=data[2]
local showCountBG=itemnum>1
local itemcount=showCountBG and itemnum or""
local graynum=isReceived and 1 or 0

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)

item:SetChildActive(1,isCanRecv)
item:SetChildActive(2,isReceived)

item:SetBaseItemClickEvent(0,function()
if isCanRecv then
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,11)
else
itemsComponentHelper.onItemClick(itemid)
end
end)
end

self.stagePassLevelRewardList:setChildLayoutGroupCreateItems(len,createFunc)

end

function UIMoJieStageAimChapterContentWin3:freshProgressStateInfo()
local state=self.stageHandle:getState()

local bestLastHpFightGKInfo=xianjieModel:getMoJieGateData(self.minHpGateId)

self.isShowProgressInfo=state==eSeasonStageStateEnum.eDoing and bestLastHpFightGKInfo~=nil

if not self.isShowProgressInfo then return end








local gateMaxHp=xianjieModel:getMoJieGateMaxHp(self.stageHandle.id,self.stageHandle.type)
self.hpBar:setChildIconFillAmount(bestLastHpFightGKInfo.data.hp/gateMaxHp)
self.hpTxt:setText(string.format("%d/%d",bestLastHpFightGKInfo.data.hp,gateMaxHp))

local fightState=xianjieModel:getMoJieGateAtkState(self.minHpGateId)
local isShowCD=fightState>0


if isShowCD then
self:startFightCD(fightState)
else

self.isShowProgressInfo=false
end
end

function UIMoJieStageAimChapterContentWin3:startFightCD(fightState)
self:stopFightCD()

local cdTime,startTime,endTime=xianjieModel:getMoJieGateStateTime(self.minHpGateId)

local fmt="关口要塞攻坚倒计时：{0}"
if fightState==2 then
fmt="关口要塞修复倒计时：{0}"
end

local leftTime,curTime
local func=function()
curTime=timeHelper.getServerShortTime()
leftTime=endTime-curTime
_this.gkFightCDTxt:setText(FMT.fmt(fmt,timeHelper.format_time_stamp9(leftTime)))
end

self.fightCDTimer=self:setTimer(1,0,func)
func()
end
function UIMoJieStageAimChapterContentWin3:stopFightCD()
if self.fightCDTimer then
self:stopTimerByID(self.fightCDTimer)
self.fightCDTimer=nil
end
end

function UIMoJieStageAimChapterContentWin3:refreshMJZFInfo()
local isShowReddot=self.stageHandle.spe_rw_flag==1
self.mjzfReddot:setActive(isShowReddot)

local isHasWinner=self.stageHandle.spe_rw_cross_id>0
self.mjzfWinner:setActive(isHasWinner)
if isHasWinner then

local xyName=loginModel:getCrossZoneName(self.stageHandle.spe_rw_cross_id,'未知仙域')
self.mjzfWinnerName:setText(xyName)
end
end

function UIMoJieStageAimChapterContentWin3:onMjzfRewardBtn()
if self.stageHandle.spe_rw_flag==1 then
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,33)
else
self.isShowMJZFReward=not self.isShowMJZFReward
self.mjzfRewardList:setActive(self.isShowMJZFReward)
self.closeMJZFReward:setActive(self.isShowMJZFReward)
end
end

function UIMoJieStageAimChapterContentWin3:freshMJZFRewardList()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local spePassReward=config.spePassReward

local len=#spePassReward

local isRecved=self.stageHandle.spe_rw_flag==2

self.mjzfRewardList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.mjzfRewardList:getChildLayoutGroupGridItem(index-1)
local data=spePassReward[index]

local itemid=data[1]
local itemcount=data[2]
local showCountBG=itemcount>1

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)
item:SetChildActive(1,isRecved)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)
end)
end


function UIMoJieStageAimChapterContentWin3.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin3.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin3.onSeasonChange()
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end

function UIMoJieStageAimChapterContentWin3.onSeasonStageChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end

function UIMoJieStageAimChapterContentWin3.onSeasonStageDataChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end



