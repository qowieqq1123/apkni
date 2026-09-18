







def_class("UIMoJieStageAimChapterContentWin5",UIWindowBase)









function UIMoJieStageAimChapterContentWin5:bindComponents()

self.background=UIImage.get(self,0)
self.finishImg=UIObject.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.mainTask=UIObject.get(self,3)
self.mainTaskTxt=UIText.get(self,4)
self.progressBox=UIObject.get(self,5)
self.stagePassLevelRewardList=UIObject.get(self,6)
self.storyBg=UIObject.get(self,7)
self.storyTx=UIText.get(self,8)
self.storyTx2=UIText.get(self,9)
self.tipsTx=UIText.get(self,10)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIMoJieStageAimChapterContentWin5:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.finishImg);self.finishImg=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.mainTask);self.mainTask=nil;
_UIObject_release(self.mainTaskTxt);self.mainTaskTxt=nil;
_UIObject_release(self.progressBox);self.progressBox=nil;
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




function UIMoJieStageAimChapterContentWin5:onLoaded(...)
self:bindComponents()

_this=self

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
end


function UIMoJieStageAimChapterContentWin5:__delete()
_this=nil

self:stopOpenTimer()

self:unbindComponents()
end




function UIMoJieStageAimChapterContentWin5:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=self.showParams.handleType
self.stageIdx=self.showParams.stageIdx
self.stageHandle=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
self.winArgs=self.stageCfg.winArgs

self:refreshAll()
end


function UIMoJieStageAimChapterContentWin5:onHide()

end





function UIMoJieStageAimChapterContentWin5:onFinalBossHead()
end



function UIMoJieStageAimChapterContentWin5:onJumpBtn()
if not self.stageHandle:isOverBegin()then
local beginTime=self.stageHandle.beginTime
local stageName=self.stageCfg.name
local serverTime=timeHelper.getServerShortTime()
local left=beginTime-serverTime
UIManager.info(FMT.fmt("{0}章节将于{1}后开启",stageName,timeHelper.format_time_stamp4(left)))
return
end

local limitGK=self.winArgs.jumpBtn.limitGK
if limitGK then
local passGK=xianjieModel:getMoJieGateSelfXMCanPassAnyGateId()
if passGK==nil then
UIManager.info("所在仙域本阵的关口要塞未开放，无法前往")
seasonController:jumpGate()
return
end
end

local jumpParams=self.winArgs.jumpBtn.jump
if jumpParams==nil then return end
jumpManager:jump(jumpParams)
end


function UIMoJieStageAimChapterContentWin5:refreshAll()
self:initActiveData()

self:freshBackGround()
self:freshJumpBtn()
self:freshTips()
self:freshMainTask()
self:freshFinishImg()
self:freshProgressBox()
self:refreshStagePassLevelRewardPart()

self:activeObjects()
end

function UIMoJieStageAimChapterContentWin5:initActiveData()

self.isShowMidTips=true
self.isShowProgressInfo=false
self.isShowFightCD=false


self.isShowBg=self.winArgs.backgroundImage~=nil
self.isShowJumpBtn=self.winArgs.jumpBtn~=nil
self.isShowMaintask=self.stageCfg.passLevelCondition~=nil


self.isShowFinishImg=self.stageHandle:isFinish()
end

function UIMoJieStageAimChapterContentWin5:activeObjects()
self.background:setActive(self.isShowBg)
self.jumpBtn:setActive(self.isShowJumpBtn)
self.tipsTx:setActive(self.isShowMidTips)
self.mainTask:setActive(self.isShowMaintask)
self.finishImg:setActive(self.isShowFinishImg)
end

function UIMoJieStageAimChapterContentWin5:freshBackGround()
if not self.isShowBg then return end

local imageCfg=self.winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])
end

function UIMoJieStageAimChapterContentWin5:freshProgressBox()
local wb=self.progressBox:getChildWidgetBase()

local tips=FMT.fmt("{0}：{1}",self.winArgs.stageScoreRewardTips,self.stageHandle.yaomoDieNum)
wb:SetChildText(0,tips)


local stageScoreRewardList=self.stageCfg.stageScoreRewardList
local rewardBoxInfo=self.winArgs.boxParam
local rewardBoxLen=#rewardBoxInfo

local len=#stageScoreRewardList
local max=stageScoreRewardList[len][1]


local serverWideScore=self.stageHandle.yaomoDieNum
local personalScore=self.stageHandle.actor_stage_score or 0

local receive=self.stageHandle.stage_rw_idx

local pval=seasonModel:getStageSegementProgressVal(self.showParams.handleType,self.showParams.stageIdx,serverWideScore)
wb:SetChildProgressValue(1,pval*100,100)
wb:SetChildProgressText(1,"")

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
seasonController:send_39_2(_this.showParams.handleType,_this.showParams.stageIdx,2)
else
_this:onClickBox(index)
end
end)

end)

end

function UIMoJieStageAimChapterContentWin5:onClickBox(index)
local cfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local stageScoreRewardInfo=cfg.stageScoreRewardList[index]
local rewardList=stageScoreRewardInfo[_stageRewardInfoIndex.rewardInfo]


local rewardId=rewardList[1][_rewardInfoIndex.id]

local serverWideTargetScore=stageScoreRewardInfo[_stageRewardInfoIndex.target]
local serverWideCurrentScore=self.stageHandle.yaomoDieNum


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

function UIMoJieStageAimChapterContentWin5:freshJumpBtn()
self.isShowJumpBtn=not self.stageHandle:isFinish()

local isGray=not self.stageHandle:isOverBegin()
self.jumpBtn:setGray(isGray)
end

local _attachmentArgsTips=function(args)
local type=args[1]
local tips=args[2]
if type==0 then return tips end

local guildScroe=mathHelper.int64_to_number(_this.stageHandle.chapter_guild_scroe)
if type==1 then
return FMT.fmt(tips,mathHelper.formatNumber4(guildScroe,2))
end
end
function UIMoJieStageAimChapterContentWin5:freshTips()
if not xianmengModel:hasXM()then
self.tipsTx:setText('暂无仙盟')
return
end
local stageState=self.stageHandle:getState()

local tipStr
if stageState==eSeasonStageStateEnum.eUnLock then
self:startOpenTimer()
elseif stageState==eSeasonStageStateEnum.eDoing then
tipStr=_attachmentArgsTips(self.winArgs.recordStr)
elseif stageState==eSeasonStageStateEnum.eFinish then
tipStr=_attachmentArgsTips(self.winArgs.finishStr)
end

if tipStr then
self.tipsTx:setText(tipStr)
end
end

function UIMoJieStageAimChapterContentWin5:startOpenTimer()
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

function UIMoJieStageAimChapterContentWin5:stopOpenTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end

function UIMoJieStageAimChapterContentWin5:freshMainTask()
local passLevelCondition=self.stageCfg.passLevelCondition

local limitVal=Mathf.Min(self.stageHandle.chapter_scroe or 0,passLevelCondition.max)
local str=FMT.fmt("{0}  {1}/{2}",passLevelCondition.desc,limitVal,passLevelCondition.max)

self.mainTaskTxt:setText(str)
end

function UIMoJieStageAimChapterContentWin5:freshFinishImg()
end

function UIMoJieStageAimChapterContentWin5:refreshStagePassLevelRewardPart()
local passStageReward=self.stageCfg.passStageReward

local len=#passStageReward

local isFinish=self.stageHandle:isFinish()
local isReceived=self.stageHandle.pass_rw_flag==1
local isCanRecv=isFinish and(not isReceived)

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
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,1)
else
itemsComponentHelper.onItemClick(itemid)
end
end)
end

self.stagePassLevelRewardList:setChildLayoutGroupCreateItems(len,createFunc)

end


function UIMoJieStageAimChapterContentWin5.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin5.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin5.onSeasonChange()
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()

end

function UIMoJieStageAimChapterContentWin5.onSeasonStageChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end

function UIMoJieStageAimChapterContentWin5.onSeasonStageDataChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end



