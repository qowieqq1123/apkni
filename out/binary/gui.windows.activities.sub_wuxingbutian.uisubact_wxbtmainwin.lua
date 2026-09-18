







def_class("UISubAct_wxbtMainWin",UIWindowBase)









function UISubAct_wxbtMainWin:bindComponents()

self.ballAddBtn=UIButton.get(self,0)
self.ballNumTxt=UIText.get(self,1)
self.challengeBtn=UIButton.get(self,2)
self.dailyReddot=UIObject.get(self,3)
self.frameSp=UIObject.get(self,4)
self.turtleModel=UIObject.get(self,5)
self.levelGroup=UIObject.get(self,6)
self.levelScrollView=UIObject.get(self,7)
self.levelTxt=UIText.get(self,8)
self.rankBtn=UIButton.get(self,9)
self.rewadProgress=UIObject.get(self,10)
self.rewardContent=UIObject.get(self,11)
self.rewardItem=UIObject.get(self,12)
self.rewardProgressBar=UIObject.get(self,13)
self.rewardScrollView=UIObject.get(self,14)
self.root=UIObject.get(self,15)
self.ruleBtn=UIButton.get(self,16)
self.scoreTxt=UIText.get(self,17)
self.playerPos=UIObject.get(self,18)
self.infiniteChallengeBtn=UIButton.get(self,19)
self.playerModel=UIObject.get(self,20)
self.endlessLevelModel=UIObject.get(self,21)
self.turtleClick=UIButton.get(self,22)
self.timeText=UIText.get(self,23)

self.ballAddBtn:setButtonClick(function()self:onBallAddBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.infiniteChallengeBtn:setButtonClick(function()self:onInfiniteChallengeBtn()end)

self.turtleClick:setButtonClick(function()self:onTurtleClick()end)



end


function UISubAct_wxbtMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ballAddBtn);self.ballAddBtn=nil;
_UIObject_release(self.ballNumTxt);self.ballNumTxt=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.dailyReddot);self.dailyReddot=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.turtleModel);self.turtleModel=nil;
_UIObject_release(self.levelGroup);self.levelGroup=nil;
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.playerPos);self.playerPos=nil;
_UIObject_release(self.infiniteChallengeBtn);self.infiniteChallengeBtn=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.endlessLevelModel);self.endlessLevelModel=nil;
_UIObject_release(self.turtleClick);self.turtleClick=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end
















local _this=nil
local posLookup={
[1]=-150,
[2]=-50,
[3]=50,
[4]=150,
[5]=50,
[6]=-50,
}
local playerSpineID=6386
local turtleSpineID=6394
local bgSpineID=6385
local endLessModel=6387

local rewardItemCmpIdx={
bg=0,
openBg=1,
scoreText=2,
click=3,
reddot=4,
}

local levelItemCmpIdx={
pointRoot=0,
pointBg=1,
pointFinish=2,
levelText=3,
finalPointBg=4,
line=5,
}


function UISubAct_wxbtMainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onBubbleShooterResult,self.onBubbleShooterResult)
self.modelLookup={}
end


function UISubAct_wxbtMainWin:__delete()
self:clearTimer()
self:clearAllTweener()
_this=nil
self:unbindComponents()


UIManager:closeWindow("UIBubbleShooterWin")
end


function UISubAct_wxbtMainWin:onHide()
self:clearTimer()
self:clearAllTweener()
end

function UISubAct_wxbtMainWin.on_money_changed(mType,oldValue,newValue)
if _this==nil then return end
if _this.changeMoneyLookup[mType]==true then
if mType==_this.ballMoneyType and _this.waitPlayBallAnim then
_this:playGetBallAnim(oldValue,newValue)
else
_this:refreshBalls()
end
end
end

function UISubAct_wxbtMainWin.onBubbleShooterResult(result)
if _this==nil then return end
_this:excutePlayJump()
end




function UISubAct_wxbtMainWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.beginTime=self.sub_actInfo.start_time
self.endTime=self.sub_actInfo.end_time

self.changeMoneyLookup=self.sub_actInfo:getChangeMoneyLookup()
self.ballMoneyType=self.sub_actInfo:getBallMoneyType()
self.tweenerList={}
self.waitPlayBallAnim=nil

self:refreshTurtleModel()
self.frameSp:setChildUIModelShowTarget(bgSpineID,1,{},eAnimationID.stand,false,false,0,nil)
self:initRewardPanel(false,true)
self:refreshView(true)
self:refreshEndlessModel()


self:setRemainingTimeTimer()
end

function UISubAct_wxbtMainWin:refreshView(isInit)
self:refreshDailyReward()
self:refreshBalls()
self:refreshLevel()
self:refreshLevelItems()
self:initPlayerPos(isInit)
end

function UISubAct_wxbtMainWin:refreshTurtleModel(isTouch)
local flag=self.sub_actInfo:checkDailyReward()
local animId=flag and 3497 or eAnimationID.stand2
if isTouch then
animId=3498
end
if self.initTurtle==nil then
self.initTurtle=true
self.turtleModel:setChildUIModelShowTarget(turtleSpineID,1,{},animId,false,false,0,nil)
else
self.turtleModel:setChildModelAnimationState(animId,1)
end
end

function UISubAct_wxbtMainWin:refreshEndlessModel(fadeInTime)
local isShowEndlessModel=false
local level=self.sub_actInfo:getLevel()
local nlevel=self.sub_actInfo:getNextLevel()
local n=#self.levellist
local maxLevel=self.levellist[n].level
if nlevel>=maxLevel then
isShowEndlessModel=true
end

if isShowEndlessModel and self.initEndlessLevelModel==nil then
self.initEndlessLevelModel=true
self.endlessLevelModel:setChildUIModelShowTarget(endLessModel,1,{},eAnimationID.stand,nil,nil,fadeInTime)
end
end

function UISubAct_wxbtMainWin:refreshBalls()
local num=self.sub_actInfo:getBallNum()
self.lastBallVal=num
self.ballNumTxt:setText(tostring(num))
end

function UISubAct_wxbtMainWin:refreshLevel()
local lv=self.sub_actInfo:getNextLevel()
local groupid=self.sub_actcfg.groupid
local str

local isEndlessMode=false
local cfg=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,groupid,lv)
if cfg.blockid~=nil then
str=FMT.fmt('第{0}关',lv)
else
str="无尽深渊"
isEndlessMode=true

end
self.levelTxt:setText(str)
self.challengeBtn:setActive(not isEndlessMode)
self.infiniteChallengeBtn:setActive(isEndlessMode)
end

function UISubAct_wxbtMainWin:initRewardPanel(anim,isInit)
local speed=400

local target=self.sub_actcfg.target
local max=#target
local total=self.myData.totalScore or 0
local flag=self.myData.rewardFlag or 0
local curIndex=0
for i,d in ipairs(target)do
if total>=d[1]then
curIndex=i
end
end

self.rewardScrollView:setChildScrollViewCreateGrids(max,max)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local d=target[i]
if d then
local num=d[1]
local rewardList=d[2]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,i-1)

widget:SetChildActive(rewardItemCmpIdx.bg,not rewardFlag)
widget:SetChildActive(rewardItemCmpIdx.openBg,rewardFlag)
widget:SetChildActive(rewardItemCmpIdx.reddot,fix and not rewardFlag)
widget:SetChildText(rewardItemCmpIdx.scoreText,num)

widget:SetChildButtonClick(rewardItemCmpIdx.click,function()
return self:onClickRewardItem(i)
end,true)

widget:SetChildActive(-1,true)
else
widget:SetChildActive(-1,false)
end
end


local beforeWeight=335
local firstStepWidth=55
local itemWidth=62
local stepWidth=95
local max_width=beforeWeight+firstStepWidth+max*itemWidth+(max-1)*stepWidth-itemWidth/2

local cur_width
if curIndex>=max then
cur_width=max_width
elseif curIndex<=0 then
cur_width=0
else
cur_width=beforeWeight+firstStepWidth+curIndex*itemWidth+(curIndex-1)*stepWidth-itemWidth/2
end
if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,8),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,8)
end

self.scoreTxt:setText(total)

if isInit then
local jumpIdx=curIndex-2
self.rewardScrollView:setChildScrollViewSelectItem(jumpIdx,false,false,false)
end
end

function UISubAct_wxbtMainWin:onClickReward(index,subIndx)
local hasReward=self.sub_actInfo:checkFixRewardIndex(index)
if hasReward then
local list=self.sub_actInfo:getFixReward()
if list~=nil then
local json_str=jsonHelper.encode({5,list})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end
else
local target=self.sub_actcfg.target
local d=target[index]
local num=d[1]
local rewardList=d[2]
local itemid=rewardList[subIndx][1]
tipsManager.showTips({itemid=itemid,itemguid=nil})
end
end

function UISubAct_wxbtMainWin:onClickRewardItem(index)
local hasReward=self.sub_actInfo:checkFixRewardIndex(index)
if hasReward then
local list=self.sub_actInfo:getFixReward()
if list~=nil then
local json_str=jsonHelper.encode({5,list})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end
else
local widget=self.rewardScrollView:getChildScrollViewItemWidget(index-1)
local posWidget=widget
local offset={0,50}
local target=self.sub_actcfg.target
local d=target[index]
local flag=self.myData.rewardFlag or 0
if d then
local num=d[1]
local rewardList=d[2]
local rewardFlag=mathHelper.getBitValue(flag,index-1)
self:showWindow("UISubAct_wxbt_rewardTipsWin",{rewardList=rewardList,posWidget=posWidget,offset=offset,isGot=rewardFlag})
end
end
end

function UISubAct_wxbtMainWin:checkFinishLevel(lv,curlv)
curlv=curlv or self.sub_actInfo:getLevel()
return lv<=curlv
end

function UISubAct_wxbtMainWin:refreshLevelItems(isAnim)
local groupid=self.sub_actcfg.groupid
local level=self.sub_actInfo:getLevel()
local nlevel=self.sub_actInfo:getNextLevel()
self.levellist=cfgHelper.get1(cfg_bubbleshooterlevelconfig_get,groupid)
local n=#self.levellist
self.levelGroup:setChildLayoutGroupCreateItems(n,function(index)
local widget=self.levelGroup:getChildLayoutGroupGridItem(index-1)
local isShowLevel=index<=nlevel
local isNextLevel=index==nlevel
local levelCfg=self.levellist[index]
if levelCfg then
local pos=levelCfg.pointPos
widget:SetChildAnchoredPos(-1,pos[1],pos[2])
local isfinish=self:checkFinishLevel(index,level)


local isEndlessMode=levelCfg.blockid==nil
widget:SetChildActive(levelItemCmpIdx.pointBg,not isEndlessMode)
widget:SetChildActive(levelItemCmpIdx.finalPointBg,isEndlessMode)
if not isEndlessMode then
widget:SetChildText(levelItemCmpIdx.levelText,tostring(index))
self:refreshItemState(widget,index,isfinish)
end


local nextLevelCfg=self.levellist[index+1]
local isShowLine=isShowLevel and not isNextLevel
if isAnim then
if index==level then
isShowLine=false
end
end

if nextLevelCfg and isShowLine then
local nextLevelPos=nextLevelCfg.pointPos
local angle=mathHelper.getAngleByPos(pos[1],pos[2],nextLevelPos[1],nextLevelPos[2])
widget:SetChildRotation(levelItemCmpIdx.line,0,0,angle)
local distance=mathHelper.distance(pos[1],pos[2],nextLevelPos[1],nextLevelPos[2])
widget:SetChildSizeDelta(levelItemCmpIdx.line,distance,7)
widget:SetChildActive(levelItemCmpIdx.line,true)
else
widget:SetChildActive(levelItemCmpIdx.line,false)
end

widget:SetChildActive(-1,isShowLevel)
else
widget:SetChildActive(-1,false)
end
end)
self:moveItemIndex2Center(nlevel)
end

function UISubAct_wxbtMainWin:refreshItemState(widget,index,isfinish)
if widget==nil then
widget=self.levelGroup:getChildLayoutGroupGridItem(index-1)
end
if isfinish==nil then
isfinish=self:checkFinishLevel(index,nil)
end



widget:SetChildActive(levelItemCmpIdx.pointFinish,isfinish or false)
end



function UISubAct_wxbtMainWin:moveItemIndex2Center(index,isInit)
local groupid=self.sub_actcfg.groupid
local nowPos=self.levelGroup:getChildScreenPointToLocalPointRectangle()
local cfg=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,groupid,index)
local levelPos=cfg.pointPos
local itemPos=Vector2.New(levelPos[1],levelPos[2])
local showWidth=UnityEngine.Screen.width
if showWidth>1624 then
showWidth=1624
elseif showWidth<1334 then
showWidth=1334
end

local maxWidth=self.levelGroup:getChildRectWidth()
local halfWidth=showWidth/2
local targetPosX=-itemPos.x+halfWidth
local maxPosX=-maxWidth+showWidth
if targetPosX<maxPosX then
targetPosX=maxPosX
elseif targetPosX>0 then
targetPosX=0
end

local pos=self.levelGroup:getChildAnchoredPosition()
pos.x=targetPosX
self.levelGroup:setChildAnchoredPosition(pos)
end

function UISubAct_wxbtMainWin:initPlayerPos(isInit)
self.winlua:SetAsLastSibling(self.playerPos:getID())
local nextLevel=self.sub_actInfo:getNextLevel()
local groupid=self.sub_actcfg.groupid
local cfg=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,groupid,nextLevel)
local pos=cfg.pointPos
self.playerPos:setChildAnchoredPos(pos[1],pos[2])

if isInit then
self.playerModel:setChildUIModelShowTarget(playerSpineID,1,{},eAnimationID.stand)
end
end


function UISubAct_wxbtMainWin:playJump(old,new)
if self.isPlaying==true then return end
if old==new then return end
self.isPlaying=true


local groupid=self.sub_actcfg.groupid
local cfg_old=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,groupid,old)
local pos_old=cfg_old.pointPos
local cfg_new=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,groupid,new)
local pos_new=cfg_new.pointPos

local levelItem1=self.levelGroup:getChildLayoutGroupGridItem(old-1)
local levelItem2=self.levelGroup:getChildLayoutGroupGridItem(new-1)
self:refreshItemState(levelItem1,old,true)
self:refreshItemState(levelItem2,new,nil)


local angle=mathHelper.getAngleByPos(pos_old[1],pos_old[2],pos_new[1],pos_new[2])
levelItem1:SetChildRotation(levelItemCmpIdx.line,0,0,angle)
local distance=mathHelper.distance(pos_old[1],pos_old[2],pos_new[1],pos_new[2])
levelItem1:SetChildSizeDelta(levelItemCmpIdx.line,0,7)
levelItem1:SetChildActive(levelItemCmpIdx.line,true)


levelItem2:SetChildCanvasGroupAlpha(levelItemCmpIdx.pointRoot,0)
levelItem2:SetChildActive(-1,true)
local moveTime=2
local fadeInTime=1
self:refreshEndlessModel(fadeInTime)
self.tweenerList[1]=levelItem2:SetChildCanvasGroupDOFade(levelItemCmpIdx.pointRoot,1,fadeInTime,function()
self.tweenerList[2]=levelItem1:SetChildDOSizeDelta(levelItemCmpIdx.line,Vector2.New(distance,7),moveTime)
self.tweenerList[3]=self.playerPos:setChildDOAnchorPos(Vector2.New(pos_new[1],pos_new[2]),moveTime,function()
if not _this or not _this.isVisible then return end
_this.isPlaying=nil
end)
end)

end

function UISubAct_wxbtMainWin:playGetBallAnim(oldValue,newValue)
self.waitPlayBallAnim=nil

self:refreshTurtleModel(true)

self:clearBallNumTweener()
self:delayDo(1,function()
if _this==nil or not _this.isVisible then return end
_this.ballNumTweener=_DOTweenProxy.DoValueTo(function()
return oldValue
end,function(val)
oldValue=val
if _this==nil or not _this.isVisible then return end
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
_this.ballNumTxt:setText(moneyStr)
end,newValue,2)
end)

end

function UISubAct_wxbtMainWin:clearBallNumTweener()
if self.ballNumTweener then
self.ballNumTweener:Complete()
self.ballNumTweener:Kill()
self.ballNumTweener=nil
end
end



function UISubAct_wxbtMainWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_wxbtMainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UISubAct_wxbtMainWin:onBallAddBtn()

local costItemID=self.sub_actInfo.ballMoneyType
gainControl:showGainWin(costItemID)
end

function UISubAct_wxbtMainWin:onChallengeBtn()
if not bubbleShooterController:checkOpenMark()then
bubbleShooterController:checkOpenGameWin(self.sub_actInfo)
end
end

function UISubAct_wxbtMainWin:onInfiniteChallengeBtn()
return self:onChallengeBtn()
end

function UISubAct_wxbtMainWin:refreshDailyReward()

local flag=false
self.dailyReddot:setActive(flag)
end

function UISubAct_wxbtMainWin:onRankBtn()
local list=self.sub_actInfo:getSubRankAct()
if#list>0 then
local sub_actInfo=list[1]
activitiesController:jump(sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
else
UIManager.info('没有配置相应排行榜活动')
end
end

function UISubAct_wxbtMainWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='wuxingbutian_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_wxbtMainWin:clearAllTweener()
if self.tweenerList and next(self.tweenerList)~=nil then
for i,tweener in pairs(self.tweenerList)do
tweener:Complete()
tweener:Kill()
self.tweenerList[i]=nil
end
end


self:clearBallNumTweener()
end

function UISubAct_wxbtMainWin:onTurtleClick()
local flag=self.sub_actInfo:checkDailyReward()
if not flag then return end











self.waitPlayBallAnim=true
local json_str=jsonHelper.encode({7})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end



function UISubAct_wxbtMainWin:rec_tagReward(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
UIManager.info('领取奖励成功')
self:initRewardPanel()
end
end

function UISubAct_wxbtMainWin:rec_game(actID,subType,subid,changeScore,oldlv,curlv)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:refreshBalls()
changeScore=changeScore or false
self:initRewardPanel(changeScore,true)
if oldlv~=curlv then
local level=self.sub_actInfo:getLevel()
local nlevel=self.sub_actInfo:getNextLevel()
if UIManager:isActive('UIBubbleShooterWin')then
self.markPalyJump={level,nlevel}
else
self:doPlayJump(level,nlevel)
end
end
end
end

function UISubAct_wxbtMainWin:excutePlayJump()
local mark=self.markPalyJump
if mark~=nil then
local level=self.sub_actInfo:getLevel()
local nlevel=self.sub_actInfo:getNextLevel()
self.markPalyJump=nil
self:doPlayJump(level,nlevel)
end
end

function UISubAct_wxbtMainWin:doPlayJump(level,nlevel)
self:moveItemIndex2Center(nlevel)
self:playJump(level,nlevel)
self:refreshLevel()
end

function UISubAct_wxbtMainWin:rec_exchange(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
UIManager.info('兑换成功')
self:refreshBalls()
end
end

function UISubAct_wxbtMainWin:rec_score(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:initRewardPanel()
end
end

