







def_class("UIXianGongPingDingMainWin",UIWindowBase)









function UIXianGongPingDingMainWin:bindComponents()

self.titleName=UIText.get(self,0)
self.pdReadyRoot=UIObject.get(self,1)
self.pdDoingRoot=UIObject.get(self,2)
self.pingfenRoot=UIObject.get(self,3)
self.btnClose=UIButton.get(self,4)
self.cards_1=UIObject.get(self,5)
self.cards_2=UIObject.get(self,6)
self.cards_3=UIObject.get(self,7)
self.model=UIObject.get(self,8)
self.liShiBtn=UIButton.get(self,9)
self.talkRoot=UIObject.get(self,10)
self.btnPreview=UIButton.get(self,11)
self.wanfaHelp=UIButton.get(self,12)
self.talkTxt=UIText.get(self,13)
self.lsReddot=UIObject.get(self,14)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.liShiBtn:setButtonClick(function()self:onLiShiBtn()end)

self.btnPreview:setButtonClick(function()self:onBtnPreview()end)

self.wanfaHelp:setButtonClick(function()self:onWanfaHelp()end)
self.cards={
self.cards_1,
self.cards_2,
self.cards_3,
}



end


function UIXianGongPingDingMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.pdReadyRoot);self.pdReadyRoot=nil;
_UIObject_release(self.pdDoingRoot);self.pdDoingRoot=nil;
_UIObject_release(self.pingfenRoot);self.pingfenRoot=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.cards_1);self.cards_1=nil;
_UIObject_release(self.cards_2);self.cards_2=nil;
_UIObject_release(self.cards_3);self.cards_3=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.liShiBtn);self.liShiBtn=nil;
_UIObject_release(self.talkRoot);self.talkRoot=nil;
_UIObject_release(self.btnPreview);self.btnPreview=nil;
_UIObject_release(self.wanfaHelp);self.wanfaHelp=nil;
_UIObject_release(self.talkTxt);self.talkTxt=nil;
_UIObject_release(self.lsReddot);self.lsReddot=nil;
self.cards=nil;
end


















function UIXianGongPingDingMainWin:onLoaded(...)
self:bindComponents()
self.pingdingTimers={}
self.pdDotweens={}
end

function UIXianGongPingDingMainWin:__delete()
self:unbindComponents()
self:stopAllPingDingTimer()
if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill()
end
if xiangongpingdingModel:isFinish()and
xiangongpingdingModel:isPrize()and
xiangongpingdingModel:hasLjPrize()then
xiangongpingdingController:send_6_56()
end
end

function UIXianGongPingDingMainWin:onShow(argtable,afterOnloaded)
self:freshInfo()
end

function UIXianGongPingDingMainWin:onHide()

end





function UIXianGongPingDingMainWin:onPdBtn()
local limitTime=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'limitTime')
local qishu=xiangongpingdingModel:getQiShu()
local space=limitTime[qishu]or limitTime[0]
local str=timeHelper.format_time_stamp5(space)
local desc=FMT.fmt('即将开始仙宫评定限时挑战，是否开始？\n评定限时：{0}\n<color=#ca631d><size=20>（如果祖师觉得评定任务难以完成，可以先提升实力，本宫在祖师选择开始评定前都不会离开）</size></color>',str)
local func=function()
xiangongpingdingController:send_6_5()
end
UIDialogManager.getConfirmDialog3(nil,desc,func)
end

function UIXianGongPingDingMainWin:onWanfaHelp()
local descFMT='xgpd_wanfa_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})
end

function UIXianGongPingDingMainWin:onPrizeBtn()
xiangongpingdingController:send_6_7()
end

function UIXianGongPingDingMainWin:onLiShiBtn()
UIManager:showWindow('UIXianGongPingDingWin')
end

function UIXianGongPingDingMainWin:onBtnPreview()
UIManager:showWindow('UIXianGongPingDingRewardWin')
end


function UIXianGongPingDingMainWin:onBtnClose()
if xiangongpingdingModel:isFinish()and xiangongpingdingModel:isPrize()then
local ret=xiangongpingdingController:playCurStory(false)
if ret then return end
end
UIFullXianGongPingDingControl:closeUI(true,true)
end

function UIXianGongPingDingMainWin:freshInfo()
self:freshTask()
self:freshReady()
self:freshDoing()
self:freshPiDing()
self:freshSpeak()
self:freshLeft()
end

function UIXianGongPingDingMainWin:onPingDing()
self:stopAllPingDingTimer()
self:freshTask()
self:freshReady()
self:freshDoing()
self:freshPiDing(true)
self:freshSpeak()
self:freshLeft()

local tasklist=xiangongpingdingModel:getTaskList()
local delay=0
for i=1,3 do
local taskid=tasklist[i]
self.cards[i]:setActive(taskid~=nil)
if taskid then
local widget=self.cards[i]:getWidgetBase()
local cfg=cfg_xiangongpingdingtaskconfig_get(taskid)
local pingfen=cfg.pingfen
local cur=xiangongpingdingModel:getTaskProgress(taskid)
local taskCfg=taskModel:getTaskConfig(taskid)
local max=taskCfg.aimnum
if cur>max then cur=max end
widget:SetChildCanvasGroupAlpha(8,0)
self.pingdingTimers[i]=self:delayDo(delay,function()
if self and not self.isClose then

widget:SetChildRollNumText(5,math.floor(pingfen*cur/max))
self.pdDotweens[i]=widget:SetChildCanvasGroupDOFade(8,1,0.3,function()
self.pdDotweens[i]=nil
end)
self.pingdingTimers[i]=nil
end
end)
delay=delay+0.5
end
end

local pingfen=xiangongpingdingModel:getTotalPingFen()
local widget=self.pingfenRoot:getWidgetBase()
if pingfen>0 then
widget:SetChildText(0,1)
widget:SetChildCanvasGroupAlpha(0,0)
self.pfTimer=self:delayDo(delay,function()
if self and not self.isClose then
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildText(0,pingfen)
self.pfTimer=nil
end
end)
delay=delay+0.3

widget:SetChildCanvasGroupAlpha(0,0)
self.pfProgressTimer=self:delayDo(delay,function()
if self and not self.isClose then
widget:SetChildCanvasGroupAlpha(0,1)
self.pfProgressTimer=nil
end
end)
delay=delay+0.3
end


delay=delay+0.3
widget:SetChildScale(3,Vector3(0,0,0))
self.pjTimer=self:delayDo(delay,function()
if self and not self.isClose then
widget:SetChildScale(3,Vector3(1.5,1.5,1.5))
self.pjDotween=widget:SetChildDOScale(3,1,0.3,function()
self.pjDotween=nil
end)
self.pjDotween:SetEase(DG.Tweening.Ease.InOutBack)
self.pjTimer=nil
end
end)
delay=delay+0.5



widget:SetChildCanvasGroupAlpha(6,0)
self.rewardsTimer=self:delayDo(delay,function()
if self and not self.isClose then
self.rewardsDotween=widget:SetChildCanvasGroupDOFade(6,1,0.3,function()
self.rewardsDotween=nil
end)
self.rewardsTimer=nil
end
end)
end

function UIXianGongPingDingMainWin:freshTask(doAni)
local tasklist=xiangongpingdingModel:getTaskList()
for i=1,3 do
local taskid=tasklist[i]
self.cards[i]:setActive(taskid~=nil)
if taskid then
local widget=self.cards[i]:getWidgetBase()
self:fillTask(widget,i,taskid)
end
end
end

function UIXianGongPingDingMainWin:fillTask(widget,i,taskid)
local state=xiangongpingdingModel:getCurPingDingState()
local pdReady=state==XIANGONG_TASK_TYPE.eReady
local pdDoing=state==XIANGONG_TASK_TYPE.eDoing
local pdFinish=state==XIANGONG_TASK_TYPE.eFinish

local taskCfg=taskModel:getTaskConfig(taskid)
local cfg=cfg_xiangongpingdingtaskconfig_get(taskid)
local pingfen=cfg.pingfen

local isFinish=xiangongpingdingModel:isFinishTaskById(taskid)
local desc=''

local cur=xiangongpingdingModel:getTaskProgress(taskid)
local max=taskCfg.aimnum
if cur>max then cur=max end
desc=taskCfg.taskaimdesc
local finishTask=cur>=max
widget:SetProgressBarAniWithThreeParams(2,cur,max,0)
widget:SetChildText(3,FMT.fmt('{0}/{1}',cur,max))
if pdFinish then
widget:SetChildText(5,math.floor(pingfen*cur/max))
end

widget:SetChildActive(6,not pdFinish and finishTask)
widget:SetChildActive(8,pdFinish)
widget:SetChildCanvasGroupAlpha(8,1)
widget:SetChildText(0,'')
widget:SetChildText(1,desc)
widget:SetChildActive(4,pdDoing and not finishTask)
widget:SetChildActive(9,pdReady)
widget:SetChildButtonClick(4,function()
taskController:doJump(taskid)
end,true)
widget:SetChildCSImageSprite(7,globalABLookup.xdpdicons,cfg.taskflag)
end

function UIXianGongPingDingMainWin:freshReady()
local state=xiangongpingdingModel:getCurPingDingState()
local pdReady=state==XIANGONG_TASK_TYPE.eReady
self.pdReadyRoot:setActive(pdReady)
if not pdReady then return end
local widget=self.pdReadyRoot:getWidgetBase()
widget:SetChildButtonClick(1,self.onPdBtn,true)

local qishu=xiangongpingdingModel:getQiShu()
local tReward=cfgHelper.get2(cfg_xiangongpingdingtasklibconfig_get,qishu,'rwList')
local rewards=tReward[1]
local len=#rewards
widget:SetChildLayoutGroupCreateItems(0,len,function(index)
local widget1=widget:GetChildLayoutGroupGridItem(0,index-1)
widgetHelper.setNormalRewardItem(widget1,0,rewards[index])
end)
end

function UIXianGongPingDingMainWin:freshDoing()
local state=xiangongpingdingModel:getCurPingDingState()
local pdDoing=state==XIANGONG_TASK_TYPE.eDoing
self.pdDoingRoot:setActive(pdDoing)
if not pdDoing then return end
local widget=self.pdDoingRoot:getWidgetBase()

local qishu=xiangongpingdingModel:getQiShu()
local tReward=cfgHelper.get2(cfg_xiangongpingdingtasklibconfig_get,qishu,'rwList')
local rewards=tReward[1]
local len=#rewards
widget:SetChildLayoutGroupCreateItems(0,len,function(index)
local widget1=widget:GetChildLayoutGroupGridItem(0,index-1)
widgetHelper.setNormalRewardItem(widget1,0,rewards[index])
end)

local tickfunc=function()
local endTime=xiangongpingdingModel:getEndTime()
local endStamp=timeHelper.convertLongStamp(endTime)
local stamp=timeHelper.getServerLongTime()
local left=endStamp-stamp
local str=''
if left>0 then
local year=gameUtilityModel.calculateGameYearCeil(left)
local endStr=timeHelper.format_time_stamp3(left)
str=FMT.fmt('仙宫评定倒计时：宗门年历{0}年后({1})',year,endStr)
else
self:stopPingDingTimer()
end
widget:SetChildText(1,str)
end
self:stopPingDingTimer()
self.pdTimer=self:setTimer(1,0,tickfunc)
tickfunc()
end


function UIXianGongPingDingMainWin:freshPiDing(doAni)
local state=xiangongpingdingModel:getCurPingDingState()
local isFinish=state==XIANGONG_TASK_TYPE.eFinish
self.pingfenRoot:setActive(isFinish)

if not isFinish then return end
local widget=self.pingfenRoot:getWidgetBase()
local qishu=xiangongpingdingModel:getQiShu()
local rankinfo=xiangongpingdingModel:getRankInfo()
local minrank=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'minrank')
local rank=rankinfo.rank
local rankNum=rankinfo.rankNum
local overNum=rankNum-rank
local over=0
local top=100
if overNum==0 then
over=99
else
over=math.ceil(overNum/rankNum*100)
if over<minrank then over=minrank end
end
if over>=100 then over=99 end
top=100-over
local pingji=xiangongpingdingModel:getPingJi()



local pingfen=xiangongpingdingModel:getTotalPingFen()
local rewards=cfgHelper.get3(cfg_xiangongpingdingtasklibconfig_get,qishu,'rwList',pingji)or{}
local len=#rewards
self.rewards=rewards
local assetname=xiangongpingdingModel:getPJImage(pingji)
local overStr=pingfen==0 and''or
rank==0 and FMT.fmt('超越了<color=#c82c2c>{0}%</color>的祖师',over)or
FMT.fmt('超越了<color=#c82c2c>{0}%</color>的祖师，太强了',over)
local pfDesc=pingfen==0 and'很遗憾没有获得评分，下次再接再厉'or
FMT.fmt('累计评分排名：<color=#549327>前{0}%</color>',top)
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildText(0,doAni and 0 or pingfen)
widget:SetChildText(1,pfDesc)
widget:SetChildText(2,overStr)
widget:SetChildScale(3,Vector3(1,1,1))
widget:SetChildCSImageSprite(3,globalABLookup.xdpdicons,assetname)
widget:SetChildButtonClick(4,function()
self:onPrizeBtn()
end,true)
widget:SetChildActive(4,xiangongpingdingModel:isCanPrize())
widget:SetChildCanvasGroupAlpha(6,1)
widget:SetChildLayoutGroupCreateItems(5,len,function(index)
local widget=widget:GetChildLayoutGroupGridItem(5,index-1)
widgetHelper.setNormalRewardItem(widget,0,rewards[index])
end)

local total_progress=xiangongpingdingModel:getTaskTotalProgress()
widget:SetChildCanvasGroupAlpha(7,1)
widget:SetChildText(7,FMT.fmt('{0}%',total_progress))
end

function UIXianGongPingDingMainWin:stopPingDingTimer()
if self.pdTimer then
self:stopTimerByID(self.pdTimer)
self.pdTimer=nil
end
end

function UIXianGongPingDingMainWin:freshLeft()
self.lsReddot:setActive(xiangongpingdingModel:hasLjPrize())
end

function UIXianGongPingDingMainWin:freshSpeak()
local state=xiangongpingdingModel:getCurPingDingState()
if self.speakState==state then return end
self.speakState=state
local isReady=state==XIANGONG_TASK_TYPE.eReady
local isDoing=state==XIANGONG_TASK_TYPE.eDoing
local isFinish=state==XIANGONG_TASK_TYPE.eFinish
local qipao=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'qipao')
local qishu=xiangongpingdingModel:getQiShu()
if isReady then
local qipao_ready=qipao[1]
local desc=qipao_ready[math.random(1,#qipao_ready)]
self:speak(desc)
elseif isDoing then
local qipao_doing=qipao[2]
local desc=qipao_doing[math.random(1,#qipao_doing)]
self:speak(desc)
elseif isFinish then
local qishu=xiangongpingdingModel:getQiShu()
local pingji=xiangongpingdingModel:getPingJi()
local cfg=cfg_xiangongpingdinglevelconfig_get(qishu)[pingji]
if cfg==nil then return end
local qipao=cfg.qipao
local desc=qipao[math.random(1,#qipao)]
self:speak(desc)
end
end

function UIXianGongPingDingMainWin:speak(str,callback)
if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill(true)
end
self.talkTxt:setText("")
self.talkRoot:setChildCanvasGroupAlpha(0)
self.talkRoot:setScale(Vector3.zero)
self.talkTween=Lua.SequenceProxy.New()
local talkTxCmp=self.talkTxt:getGameObject():GetComponent("Text")
local tween0=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,'',0)
tween0:SetEase(DG.Tweening.Ease.Linear)
local tween1=self.talkRoot:setChildCanvasGroupDOFade(1,0.1)
local tween2=self.talkRoot:setChildDOScale(1.2,0.2)
local tween3=self.talkRoot:setChildDOScale(1,0.1)
local tween4=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,str,1)
local temp=Lua.SequenceProxy.New()
temp:Append(tween2)
temp:Append(tween3)
self.talkTween:Append(tween0)
self.talkTween:Append(temp)
self.talkTween:Join(tween1)
self.talkTween:Join(tween4)
if callback then
callback(self.talkTween)
end
end

function UIXianGongPingDingMainWin:stopAllPingDingTimer()
for i,v in ipairs(self.pingdingTimers)do
self:stopTimerByID(v)
end
self.pingdingTimers={}

for i,v in ipairs(self.pdDotweens)do
v:Kill(false)
end

if self.pfTimer then
self:stopTimerByID(self.pfTimer)
self.pfTimer=nil
end

if self.rewardsTimer then
self:stopTimerByID(self.rewardsTimer)
self.rewardsTimer=nil
end

if self.rewardsDotween then
self.rewardsDotween:Kill(false)
self.rewardsDotween=nil
end

if self.pjTimer then
self:stopTimerByID(self.pjTimer)
self.pjTimer=nil
end

if self.pjDotween then
self.pjDotween:Kill(false)
self.pjDotween=nil
end
if self.pfProgressTimer then
self:stopTimerByID(self.pfProgressTimer)
self.pfProgressTimer=nil
end
end
