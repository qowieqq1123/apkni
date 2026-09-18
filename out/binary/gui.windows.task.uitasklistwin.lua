







def_class("UITaskListWin",UIWindowBase)









function UITaskListWin:bindComponents()

self.awakeTask=UIButton.get(self,0)
self.dailyTaskRoot=UIObject.get(self,1)
self.dzchuiweizhiyinRoot=UIObject.get(self,2)
self.emailIcon=UIButton.get(self,3)
self.emailReddot=UIObject.get(self,4)
self.emailRoot=UIObject.get(self,5)
self.jiuChongRoot=UIObject.get(self,6)
self.layout=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.seasonRoot=UIGameobjectClone.new(self,9)
self.taskRoot=UIObject.get(self,10)
self.zeXianRoot=UIObject.get(self,11)
self.zongmenRoot=UIObject.get(self,12)

self.awakeTask:setButtonClick(function()self:onAwakeTask()end)

self.emailIcon:setButtonClick(function()self:onEmailIcon()end)



end


function UITaskListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.awakeTask);self.awakeTask=nil;
_UIObject_release(self.dailyTaskRoot);self.dailyTaskRoot=nil;
_UIObject_release(self.dzchuiweizhiyinRoot);self.dzchuiweizhiyinRoot=nil;
_UIObject_release(self.emailIcon);self.emailIcon=nil;
_UIObject_release(self.emailReddot);self.emailReddot=nil;
_UIObject_release(self.emailRoot);self.emailRoot=nil;
_UIObject_release(self.jiuChongRoot);self.jiuChongRoot=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.root);self.root=nil;
self.seasonRoot:deleteSelf();self.seasonRoot=nil;
_UIObject_release(self.taskRoot);self.taskRoot=nil;
_UIObject_release(self.zeXianRoot);self.zeXianRoot=nil;
_UIObject_release(self.zongmenRoot);self.zongmenRoot=nil;
end
















local _this=nil
local newbieTaskTipsTime=15
local newbieTaskTipsZMLv=11
local tipsShowTime=10
local refreshEffectID=10117
local rewardEffectID=10070
local maxShowTaskNum=2

local taskListHeight={
[0]=75,
[1]=75,
[2]=150,
[3]=225,
}

local signChangeType={
eZongmenExp=1,
}

local taskDoingCheckSingFunc={
[taskTypeClientCheckType.eZongMenLevel]={
changes={signChangeType.eZongmenExp,},
check=function(taskcfg)
local curExp=tonumber(tostring(zongmenModel:getExp()))
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg then
return curExp>=next_cfg.exp,'image_keshengji_1'
end
return false
end,
}
}
local _seasonCmp={
icon=0,
cdTx=1,
progressBar=2,
chapterTx=3,
reddot=4,
bg=5,
}

function UITaskListWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onTaskInit,self.onTaskInit)
self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onTaskRecommand,self.onTaskRecommand)
self:addNotify(notifyConfig.onTaskRemove,self.onTaskRemove)

self:addNotify(notifyConfig.on_money_changed,self.onMoneyChange)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.inNewbie,self.inNewbie)
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)

self:addReddotNotify(REDDIT_TYPE.eMail,self.freshEmailReddot)

self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)
self:addNotify(notifyConfig.onDailyTaskChange,self.onDailyTaskChange)
self:addNotify(notifyConfig.flyIconFinish,function(...)self:flyIconFinish(...)end)
self:addNotify(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)

self:initTaskView()
self:initZongmenView()
self:initDzChuiweiView()
self:initDailyTaskView()
self.zexianVis=false
self.isShowTaskList=true
self.zheXianReddot=false
self.zheXianWidget=self.zeXianRoot:getChildWidgetBase(-1)
self.jiuChongWidget=self.jiuChongRoot:getChildWidgetBase(-1)

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonEnterConditionChange,self.onSeasonEnterConditionChange)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)

self:addProNotify(35,90,self.on_35_90)
self:addProNotify(35,95,self.on_35_95)
end


function UITaskListWin:__delete()
self:unbindComponents()
self:clearMyTimer()
self:clearAllTaskTalk()
self:stopAwakeTick()
_this=nil
end


function UITaskListWin:onHide()
self:clearMyTimer()
self:hideSeasonAllEnterItem()
end

function UITaskListWin.inNewbie(newbieid,flag)
if _this==nil then return end
if flag then
_this.isinNewbie=true
else
_this.isinNewbie=false
end
_this:refreshAllTaskRewardEffect()
if _this.curZongmenHasReward==true then
_this:refreshZongmenBreakEffect()
end
end




function UITaskListWin:onShow(argtable,afterOnloaded)
if not afterOnloaded then
self:setAsLastSibling(-1)
end
self.isinNewbie=newbieControl.isInNewbie()
local posX=Vector2.New(0,0)
local screenType=mainControl:getSceneType()
if screenType==eSceneType.eWorld then
posX.x=7
posX.y=0
end
self.root:setChildAnchoredPosition(posX)
self:refreshSeasonEnter()
self:refreshTaskView()
self:refreshZongmenTaskView()
self:refreshDzChuiweiTaskView()
self:freshEmailReddot()
self:refreshZheXianLing()
self:refreshDailyTaskView()
if mainControl:isInScene(eSceneType.eWorld)then
self.winlua:SetChildLocalPosY(self.layout:getID(),0)

self.isShowTaskList=true
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.winlua:SetChildSizeDelta(self.root:getID(),500,320)
else

if zongmenControl:isMountid(mapIdType.fort)then
self.winlua:SetChildLocalPosY(self.layout:getID(),-225)
else
self.winlua:SetChildLocalPosY(self.layout:getID(),-165)
end
self:checkTaskListPanelShowOnZongmen()
self.winlua:SetChildSizeDelta(self.root:getID(),500,485)

end


if self.myTimer==nil then
local func=function()
self:refreshMyTimer()
end
self.myTimer=self:setTimer(1,0,func)
end
self.newbieTaskTipsTimeCount=0
end

function UITaskListWin:refreshMyTimer()
self.newbieTaskTipsTimeCount=self.newbieTaskTipsTimeCount+1
if self.newbieTaskTipsTimeCount>=newbieTaskTipsTime then
self.newbieTaskTipsTimeCount=0
local zmlv=zongmenModel:getLevel()
if zmlv<=newbieTaskTipsZMLv then
local taskdata=taskModel:getTaskByLine(taskModel.lineMain)
if taskdata~=nil then
local taskid=taskdata.taskid
if self:getTaskTalkingData(taskid)==nil then
self:showTalk(taskid,'点击继续任务')
end
end
end
end
end

function UITaskListWin:clearMyTimer()
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
end



function UITaskListWin.onTaskInit()
if _this==nil then return end
_this:refreshIcon()
_this:refreshTaskList()
_this:refreshDiscipleAwakeTask()
end

function UITaskListWin.onTaskRemove(taskid)
if _this==nil then return end
local item,taskIndex=_this:getTaskItem(taskid)
if item~=nil then
_this:refreshTaskList()
end
_this:refreshDiscipleAwakeTask()
_this:refreshIcon()
end

function UITaskListWin.onTaskChange(taskid,taskstate,cur_num,old_num)
if _this==nil then return end
local taskcfg=taskModel:getTaskConfig(taskid)
_this:refreshTaskList()
_this:refreshDiscipleAwakeTask()
_this:refreshIcon()
end

function UITaskListWin.onTaskRecommand()
if _this==nil then return end
_this:refreshTaskList()
end

function UITaskListWin:initTaskView()
self.taskRootWidget=self.taskRoot:getChildWidgetBase()
self.taskRootWidget:SetChildButtonClick(0,function()
self:onTaskIcon()
end)
local pos=self.taskRootWidget:GetChildCanvas(0)




self.taskRootWidget:SetChildScrollViewInit(3,0,true,nil,nil)
end

function UITaskListWin:refreshTaskView()
self:refreshIcon()
self:refreshTaskList()
self:refreshDiscipleAwakeTask()
end


function UITaskListWin:flyIconFinish(sysid,iconType)
if sysid==SYSTEM_DEFINE.eZeXianLing then

self.zheXianWidget:SetChildCanvasGroupAlpha(0,1)
self.zheXianWidget:SetChildLocalPosX(4,-350)
self.zheXianWidget:SetChildDOLocalMoveX(4,0,0.3)
self.zheXianWidget:SetChildShowEffect(7,10484,true)
self.delayMoveTimer=self:delayDo(0.3,function()
if self.delayMoveTimer then
self:stopTimerByID(self.delayMoveTimer)
end
self.delayMoveTimer=nil
self.zheXianWidget:SetChildCanvasGroupDOFade(5,1,0.3)
self:refreshZheXianLing()
end)
elseif sysid==SYSTEM_DEFINE.eTianJiePreview then
self:doJiuChongTianJieAni()
end
end


function UITaskListWin:doZheXianLingAni()
if not systemModel.isOpen(SYSTEM_DEFINE.eZeXianLing)then
return
end
self.zeXianRoot:setActive(true)
self.zheXianWidget:SetChildCanvasGroupAlpha(5,0)
self.zheXianWidget:SetChildLocalPosX(4,-350)
self.zheXianWidget:SetChildCanvasGroupAlpha(0,0)
end

function UITaskListWin:refreshZheXianLing()
if not systemModel.isOpen(SYSTEM_DEFINE.eZeXianLing)then
self.zeXianRoot:setActive(false)
return
end
local chapter_id=zheXianLingModel:getChapter()
if chapter_id==nil then
self.zeXianRoot:setActive(false)
return
end
self.zeXianRoot:setActive(true)
if self.delayMoveTimer then return end
local id=ICON_TYPE.mainZheXianLing
local active=systemIconModel.isUnlock(id)and
systemIconFlyControl.isFly(id)
if not active then
self.zheXianWidget:SetChildCanvasGroupAlpha(5,0)
self.zheXianWidget:SetChildLocalPosX(4,-350)
self.zheXianWidget:SetChildCanvasGroupAlpha(0,0)
return
end

self.zheXianWidget:SetChildCanvasGroupAlpha(0,1)
self.zheXianWidget:SetChildLocalPosX(4,0)
self.zheXianWidget:SetChildCanvasGroupAlpha(5,1)
self.zheXianObjWidget=self.zheXianWidget:GetChildWidgetBase(2)
self:showZheXianLingIcon()
if not self.zexianVis then
self.zexianVis=true








end

self.zheXianObjWidget:SetChildButtonClick(7,function()
local isWait,desc=zheXianLingController:isWaitNextOpen()
if isWait then
UIFullZheXianControl:showZheXianLingJiYuanWindow()
else
UIFullZheXianControl:showZheXianLingZhangJieWindow()
end
end,true)

if zheXianLingModel:isRewardCurrentBook()and not zheXianLingModel:hasNextBook()then
self:showZheXianLingMaxTitle()


self:refreshJiuChongTianJie()

return
end
local isWait,desc,args=zheXianLingController:isWaitNextOpen()

self:freshZheXianReward()
if isWait then
local locktype=args[1]
local cnd=args[2]
if locktype==2 and cnd[1]==1 then
local zmlv=cnd[2]
desc=FMT.fmt('{0}级开启新章节',zmlv)
end
self:showZheXianLingTitle(desc)
else
self:freshZheXianProgress()
end
end

function UITaskListWin:getZheXianLingIconPosition()
return self.zheXianWidget:GetChildPosition(0)
end

function UITaskListWin:showZheXianLingIcon()
local id=ICON_TYPE.mainZheXianLing
local active=systemIconModel.isUnlock(id)and
systemIconFlyControl.isFly(id)
self.zheXianWidget:SetChildActive(0,active)
if active then
self.zheXianWidget:SetChildButtonClick(0,function()
self:onZheXianLingBtn()
end)
end
end

function UITaskListWin:showZheXianLingTitle(desc)
self.zheXianObjWidget:SetChildText(0,'')
self.zheXianObjWidget:SetChildText(11,'全新卷章即将开启')
self.zheXianObjWidget:SetChildActive(5,false)
self.zheXianObjWidget:SetChildText(6,'')
self.zheXianObjWidget:SetChildText(8,desc)
self.zheXianObjWidget:SetChildActive(9,false)
end

function UITaskListWin:showZheXianLingMaxTitle()
self.zheXianObjWidget:SetChildText(0,'')
self.zheXianObjWidget:SetChildText(11,'全新卷章即将开启')
self.zheXianObjWidget:SetChildActive(5,false)
self.zheXianObjWidget:SetChildText(6,'')
self.zheXianObjWidget:SetChildText(8,'当前卷章已完成')
self.zheXianObjWidget:SetChildActive(9,false)
self:freshZheXianReward()
end


function UITaskListWin:freshZheXianReward()
local rlen,trlen=zheXianLingModel:getCurrentChapterTaskRewardCount()
local isReward=zheXianLingModel:isRewardCurrentBook()
local flag=rlen>0 or
systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan)and zheXianLingModel:hasJiYuanTimes()or
zheXianLingModel:isFinishCurrentChapter()

self.zheXianObjWidget:SetChildActive(1,not isReward and flag)

self.zheXianReddot=flag



end

function UITaskListWin:freshZheXianProgress()
local chapter_id=zheXianLingModel:getChapter()
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local bookid,index=zheXianLingConfig.getChapterIndex(chapter_id)
local chapterStr=mathHelper.numberToChinese(index)
local len,tlen=zheXianLingModel:getCurrentChapterTaskFinishCount()
local hasFinish=len>=tlen
self.zheXianObjWidget:SetChildText(0,FMT.fmt('第{0}章：{1}',chapterStr,chapterCfg.name))
self.zheXianObjWidget:SetChildActive(5,true)
self.zheXianObjWidget:SetChildActive(9,true)
self.zheXianObjWidget:SetChildActive(10,true)
self.zheXianObjWidget:SetChildText(8,'')
self.zheXianObjWidget:SetProgressBarAniWithThreeParams(5,len,tlen,0)
self.zheXianObjWidget:SetChildText(6,hasFinish and'已完成'or FMT.fmt('{0}/{1}',len,tlen))
self.zheXianObjWidget:SetChildText(11,'')
end

function UITaskListWin:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self.zheXianWidget:SetChildRotation(1,0,0,0)
local tweener=self.zheXianWidget:SetChildDOPunchRotation(1,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self.zheXianWidget:SetChildRotation(1,0,0,0)
end
end
end


function UITaskListWin:doJiuChongTianJieAni()
self.jiuChongWidget:SetChildModelAnimationState(3,eAnimationID.enter)
end

function UITaskListWin:refreshJiuChongTianJie()
self.zeXianRoot:setActive(false)

local isComplete=JiuChongTianJieEnterModel:isJiuChongTianJieComplete()
self.jiuChongRoot:setActive(not isComplete)
if isComplete then
return
end
self.jiuChongWidget:SetChildUIModelShowTarget(3,5365,1,{},eAnimationID.stand,false,false,0,nil)
if not self.jiuChongObj then
self.jiuChongObj=self.jiuChongWidget:GetChildWidgetBase(2)
end
local state=JiuChongTianJieEnterModel:getState()

if state==eJiuChongTianJieStateType.ePreview then


self.jiuChongObj:SetChildCanvasGroupAlpha(12,1)
self.jiuChongObj:SetChildCanvasGroupAlpha(13,1)
self.jiuChongObj:SetChildCanvasGroupAlpha(14,0)


self.jiuChongObj:SetChildActive(1,false)

self.jiuChongObj:SetChildActive(9,false)
self.jiuChongObj:SetChildActive(5,false)
self.jiuChongObj:SetChildText(8,"")
self.jiuChongObj:SetChildButtonClick(3,function()

local jiYuan=zheXianLingModel:hasJiYuanItems()
if jiYuan then

UIFullZheXianControl:showZheXianLingWindow({winType=UIFullZheXianControl.winType.eJiYuan})
else

local isOpen,ret=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eTianJieQianZou,true)
if ret and ret[1]==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then

UIManager:showWindow("UIJiuChongTianJieBeginWin")
else
UIManager.error("九重天劫即将开启，敬请期待")
end
end
end)
self.jiuChongObj:SetChildActive(1,zheXianLingModel:hasJiYuanTimes()and(zheXianLingModel:hasJiYuanItems()))

elseif state==eJiuChongTianJieStateType.eStart then
self.jiuChongObj:SetChildCanvasGroupAlpha(12,0)
self.jiuChongObj:SetChildCanvasGroupAlpha(13,0)
self.jiuChongObj:SetChildCanvasGroupAlpha(14,1)

self.jiuChongObj:SetChildActive(1,false)
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
local now=timeHelper.getServerShortTime()
local dur=JiuChongTianJieEnterModel:getOpenTianJieDur()
if math.ceil((sec+dur-now)/86400)<=1 then
self.jiuChongObj:SetChildText(8,"将于次日0点开启")
else
self.jiuChongObj:SetChildText(8,FMT.fmt("倒数时间：{0}天",math.floor((sec+dur-now)/86400)))
end


self.jiuChongObj:SetChildButtonClick(3,function()
UIManager:showWindow("UIJiuChongTianJieBeginWin")
end)
elseif state==eJiuChongTianJieStateType.eDoing then
if JiuChongTianJieEnterModel:isShowWeakNewbie()then
weakGuideController:beginGuide(1266,nil,false)
JiuChongTianJieEnterModel:setShowWeakNewbie()
end
self.jiuChongObj:SetChildCanvasGroupAlpha(12,1)
self.jiuChongObj:SetChildCanvasGroupAlpha(13,0)
self.jiuChongObj:SetChildCanvasGroupAlpha(14,0)

self.jiuChongObj:SetChildText(8,"")
local cur,max=JiuChongTianJieEnterModel:getAllProgress()
local open=userActorSetting.get('JiuChongTianJieOpen',false)
if open then
self.jiuChongObj:SetChildActive(5,true)
self.jiuChongObj:SetProgressBarAniWithTwoParams(5,cur,max)
self.jiuChongObj:SetChildText(6,max>0 and tostring(math.floor(cur/max*100)).."%"or"0%")
self.jiuChongObj:SetChildAnchoredPosition(12,Vector2(39,15.4))
else
self.jiuChongObj:SetChildActive(5,false)
self.jiuChongObj:SetChildAnchoredPosition(12,Vector2(39,-3))
end


self.jiuChongObj:SetChildActive(1,JiuChongTianJieEnterModel:getAllReddot())
self.jiuChongObj:SetChildButtonClick(3,function()

UIFullJiuChongTianJieControl:showFullWindow()
end)
end
end

function UITaskListWin:refreshJiuChongTianJieReddot()

end



function UITaskListWin:refreshIcon()
local num=taskModel:getHasRewardTaskNum()
local isshow=num>0
self.taskRootWidget:SetChildActive(1,isshow)
if isshow then
self.taskRootWidget:SetChildText(2,tostring(num))
end
end

function UITaskListWin:refreshTaskList()
local temp=taskModel:getTaskList_show2()
local list={}
local num=#temp
local isshow=num>0
if num>maxShowTaskNum then
num=maxShowTaskNum
end
if num>0 then
for i=1,num do
list[i]=temp[i]
end
end
self.taskDataList=list
self:clearTaskTalk()
self.taskRootWidget:SetChildActive(3,isshow)
self.taskRootWidget:SetChildScrollViewCreateGrids(3,num,1)
self.taskRootWidget:SetChildLayoutElementPreferredHeight(3,taskListHeight[num])
if isshow then
local grids=self.taskRootWidget:GetChildScrollViewItemWidgets(3)
for i=1,num do
local item=grids[i-1]
local taskdata=self.taskDataList[i]
local taskid=taskdata.taskid
local taskcfg=taskdata.cfg
local taskstateResult=taskModel:getTaskState(taskdata)
local t_taskstate=taskstateResult.state
local cur=taskstateResult.curnum
local max=taskstateResult.maxnum



local title_str=taskModel:getTaskPrefixAndName(taskcfg)
local desc_str=taskcfg.taskaimdesc
local islock=false
local showreward=false
if t_taskstate==taskModel.taskAcceptState then
islock=not taskModel:fitAcceptCondition(taskid)
if islock then
desc_str=FMT.fmt('{0}（未解锁）',desc_str)
else
desc_str=FMT.fmt('{0}（未接取）',desc_str)
end
elseif t_taskstate==taskModel.taskDoingState then
desc_str=FMT.fmt('{0}（{1}/{2}）',desc_str,mathHelper.formatBIGNumbereEx(cur),mathHelper.formatBIGNumbereEx(max))
elseif t_taskstate==taskModel.taskRewardState then
self.curTaskHasReward=true
desc_str=FMT.fmt('{0}',desc_str)
end



item:SetChildText(0,taskModel.getLineTitleColorStr(taskdata.taskline,title_str))
item:SetChildText(1,desc_str)
item:SetChildActive(4,islock)

local func=function(...)
self:onTaskItem(i)
end
item:SetChildButtonClick(-1,func,true)

local talkData=self:getTaskTalkingData(taskid)
local showTalk=talkData~=nil
item:SetChildActive(7,showTalk)
if showTalk then
item:SetChildText(8,talkData[2])
end

item:SetChildNewBieComponentId(-1,FMT.fmt('UITaskListWin.taskItem2_{0}',i))

self:refreshTaskRewardEffect(item,i)

self:refreshTaskDoingSign(item,i)

if webGLHelper:isHidePunchAni()then
item:SetChildDOTweenAnimation_DOPause(2)
item:SetChildActive(6,false)
end
end
end
end

function UITaskListWin:refreshTaskRewardEffect(item,idx)
if item==nil then
item=self.taskRootWidget:GetChildScrollViewItemWidget(3,idx-1)
end
local taskdata=self.taskDataList[idx]
local taskid=taskdata.taskid
local taskline=taskdata.taskline
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
local hasReward=t_taskstate==taskModel.taskRewardState

local showreward=hasReward and self.isinNewbie~=true
local showrewardIcon=showreward and self:getTaskTalkingData(taskid)==nil
item:SetChildActive(2,showrewardIcon)
item:SetChildActive(3,showreward)

item:SetChildActive(11,taskModel:isZhuiZongTask(taskline)and not showreward)

local showeffect=hasReward
item:SetChildShowEffect(6,rewardEffectID,showreward)
end

function UITaskListWin:refreshAllTaskRewardEffect()
if self.taskDataList and#self.taskDataList>0 then
for i,taskdata in ipairs(self.taskDataList)do
self:refreshTaskRewardEffect(nil,i)
end
end
end

function UITaskListWin:checkDoingSign(changeType)
for tType,v in pairs(taskDoingCheckSingFunc)do
local changes=v.changes
local flag=false
for i,cType in ipairs(changes)do
if cType==changeType then
flag=true
break
end
end
if flag then
for idx,taskdata in ipairs(self.taskDataList)do
if taskdata.cfg.tasktype==tType then
self:refreshTaskDoingSign(nil,idx)
end
end
end
end
end

function UITaskListWin:refreshTaskDoingSign(item,idx)
if item==nil then
item=self.taskRootWidget:GetChildScrollViewItemWidget(3,idx-1)
end
local taskdata=self.taskDataList[idx]
local taskcfg=taskdata.cfg
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
local showSign=false
local flag,signImg
if t_taskstate==taskModel.taskDoingState then
local lp=taskDoingCheckSingFunc[taskcfg.tasktype]
if lp then
flag,signImg=lp.check(taskcfg)
if flag then
showSign=true
end
end
end
item:SetChildActive(10,showSign)
if showSign then
item:SetChildCSImageSprite(10,globalABLookup.global,signImg)
end
end

function UITaskListWin:getTaskItem(taskid)
for i,taskdata in ipairs(self.taskDataList)do
if taskdata.taskid==taskid then
return self.taskRootWidget:GetChildScrollViewItemWidget(3,i-1),i
end
end
return nil,nil
end

function UITaskListWin:getTaskTalkingData(taskid)
if self.talkTimerList~=nil then
return self.talkTimerList[taskid]
end
return nil
end

function UITaskListWin:showTalk(taskid,talkStr)
self:clearTaskTalkByID(taskid)

local item,taskIndex=self:getTaskItem(taskid)
if item~=nil then
item:SetChildActive(7,true)
item:SetChildText(8,talkStr)
item:SetChildCanvasGroupAlpha(7,0)
item:SetChildCanvasGroupDOFade(7,1,0.1,nil)
item:SetChildScale(7,Vector3.New(0,0,0))
item:SetChildDOScale(7,1,0.2,nil)

local func=function()
if _this==nil then return end
_this:clearTaskTalkByID(taskid)
end
if self.talkTimerList==nil then self.talkTimerList={}end
local timerID=self:delayDo(tipsShowTime,func)
self.talkTimerList[taskid]={timerID,talkStr}
self:refreshTaskRewardEffect(item,taskIndex)
end
end

function UITaskListWin:clearTaskTalkByID(taskid)
if self.talkTimerList~=nil then
local talkData=self.talkTimerList[taskid]
if talkData~=nil then
local timerID=talkData[1]
self:stopTimerByID(timerID)
self.talkTimerList[taskid]=nil
local item,taskIndex=self:getTaskItem(taskid)
if item~=nil then
item:SetChildActive(7,false)
self:refreshTaskRewardEffect(item,taskIndex)
end
end
end
end

function UITaskListWin:clearTaskTalk()
if self.talkTimerList~=nil then
for taskid,talkData in pairs(self.talkTimerList)do
local timerID=talkData[1]
local f=false
for idx,taskdata in ipairs(self.taskDataList)do
if taskid==taskdata.taskid then
f=true
break
end
end
if not f then
self:stopTimerByID(timerID)
self.talkTimerList[taskid]=nil
end
end
end
end

function UITaskListWin:clearAllTaskTalk()
if self.talkTimerList~=nil then
for taskid,talkData in pairs(self.talkTimerList)do
local timerID=talkData[1]
self:stopTimerByID(timerID)
end
self.talkTimerList=nil
end
end

function UITaskListWin:onTaskIcon()
local show_list=taskModel:getTaskList_show()
if#show_list>0 then
UIFullTaskMainControl:showWindowTask()
else
UIManager.error('暂无任务')
end
end

function UITaskListWin:onTaskItem(idx)
local taskdata=self.taskDataList[idx]
local taskid=taskdata.taskid
local cickTask=logPoint.GetValue('onClickFirstTask',false)
if cickTask==false then
logPoint.SetValue('onClickFirstTask',true)
logPoint.UploadLog(logPoint.logType.clickFirstTask)
end
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate==taskModel.taskAcceptState then
local fit,w_str=taskModel:fitAcceptCondition(taskid)
if not fit then
UIManager.error(w_str)
return
end
taskController:doAcceptTask(taskid)
elseif t_taskstate==taskModel.taskDoingState then
taskController:doJump(taskid)
elseif t_taskstate==taskModel.taskRewardState then
taskController:doGetTaskReward_before(taskid)
end
self:startClickNewBie(taskid,t_taskstate,taskdata.taskline)
end

function UITaskListWin:startClickNewBie(taskid,t_taskstate,taskline)
local typo=t_taskstate==taskModel.taskAcceptState and NEW_BIE_CND_TYPE.eNotAcceptTask or
t_taskstate==taskModel.taskDoingState and NEW_BIE_CND_TYPE.eAcceptTask or
t_taskstate==taskModel.taskRewardState and NEW_BIE_CND_TYPE.eDoTask or
NEW_BIE_CND_TYPE.eFinshTask
newbieControl.startNewbie(typo,taskid,t_taskstate,1)
end




function UITaskListWin.onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtExp then
_this:refreshZongmenTaskView()
_this:checkDoingSign(signChangeType.eZongmenExp)
end
end

function UITaskListWin.on_building_event(etype,sfId,ubdId,arg1,arg2,arg3)
if etype~=buildingEvent.zongmenLevelUp then return end

_this:refreshZongmenTaskView()
end

function UITaskListWin:initZongmenView()
self.zongmenRootWidget=self.zongmenRoot:getChildWidgetBase()
self.zongmenRootWidget:SetChildButtonClick(0,function()
self:onZongmenIcon()
end)
self.zongmenRootWidget:SetChildButtonClick(1,function()
self:onZongmenIcon()
end)
end

function UITaskListWin:refreshZongmenTaskView()
local needBreak,cond=zongmenModel:checkCurLevelNeedBreak()
local isShow=needBreak and mainControl:isSceneLoaded(eSceneType.eZongmen)
self.zongmenRoot:setActive(isShow)
self.curZongmenHasReward=false
if isShow then
local taskWidget=self.zongmenRootWidget:GetChildWidgetBase(0)

taskWidget:SetChildText(0,'<color=#fd8950>【宗】等级突破</color>')
local jjlv=cond[1]
local jj_name=UIDiscipleModel.getJJNameCommon(jjlv,3)
local floor=UIDiscipleModel:getJJFloor(jjlv)
local cond_str
if floor<13 then
cond_str=FMT.fmt('拥有{0}名{1}弟子（{2}/{3}）',cond[3],jj_name,cond[2],cond[3])
else
cond_str=FMT.fmt('{0}名{1}弟子（{2}/{3}）',cond[3],jj_name,cond[2],cond[3])
end
taskWidget:SetChildText(1,cond_str)
self:refreshZongmenBreakEffect(taskWidget)

if webGLHelper:isHidePunchAni()then
taskWidget:SetChildDOTweenAnimation_DOPause(2)
taskWidget:SetChildActive(3,false)
end
end
end

function UITaskListWin:refreshZongmenBreakEffect(taskWidget)
if taskWidget==nil then
taskWidget=self.zongmenRootWidget:GetChildWidgetBase(0)
end
local canBreak=zongmenModel:checkLevelBreak()
taskWidget:SetChildActive(2,canBreak)
self.curZongmenHasReward=canBreak
local showreward=self.curZongmenHasReward and self.isinNewbie~=true
taskWidget:SetChildShowEffect(3,rewardEffectID,showreward)
end

function UITaskListWin:onZongmenIcon()
local canBreak=zongmenModel:checkLevelBreak()
if not canBreak then
local config=zongmenModel:getNextCondition()
local need_jingjie=config.condition[1][3]
jumpManager:jump({type=0,id=1302,args={jjlevel=need_jingjie}})
else
jumpManager:jump({type=0,id=1101})
end
end





function UITaskListWin:initDzChuiweiView()
local rootWidget=self.dzchuiweizhiyinRoot:getChildWidgetBase()
rootWidget:SetChildButtonClick(0,function()
self:onDzChuiweiIcon()
end)
rootWidget:SetChildButtonClick(1,function()
self:onDzChuiweiIcon()
end)
end

function UITaskListWin:refreshDzChuiweiTaskView()
local show=false
local times=onlineDataSetting:getData(onlineDataKeyType.eDiscipleChuiWei)
if times then
local cfg=cfgHelper.get2(cfg_diziprivatemoneyconfig_get,dzTriggerDoSomething.eChuiWei,times+1)
local guid=UIDiscipleController:getTriggerChuiweiDisciple()
if cfg~=nil and guid~='0'and mainControl:isSceneLoaded(eSceneType.eZongmen)then
show=true
end
end

show=false
self:showChuiweiState(show)
end

function UITaskListWin:showChuiweiState(flag)
self.dzchuiweizhiyinRoot:setActive(flag)
end

function UITaskListWin:onDzChuiweiIcon()
local guid=UIDiscipleController:getTriggerChuiweiDisciple()
if guid~='0'then
UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.eChuiWei,{int64.new(guid)})
end
end

function UITaskListWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local guid=UIDiscipleController:getTriggerChuiweiDisciple()
if old then
if tostring(discipleguid)==guid then
_this:showChuiweiState(false)
end
end
if cur and guid=='0'then
UIDiscipleController:setTriggerChuiweiDisciple(discipleguid)
_this:refreshDzChuiweiTaskView()
end
end
end


function UITaskListWin:onEmailIcon()
mailController:showMailUI()
end

function UITaskListWin.freshEmailReddot()
if _this and not _this.isClose then
local flag=mailController:hasReddot()
_this.emailReddot:setActive(flag)
_this:doPunchRotation_email(flag)
_this:doPunchRotationEmailIcon(flag)
end
end

function UITaskListWin:doPunchRotation_email(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener_email==nil then
self.emailReddot:setRotation(0,0,0)
local tweener=self.emailReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_email=tweener
end
else
if self.reddotTweener_email~=nil then
self.reddotTweener_email:Complete()
self.reddotTweener_email=nil
self.emailReddot:setRotation(0,0,0)
end
end
end

function UITaskListWin:doPunchRotationEmailIcon(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.emailtimer==nil then
self.emailtimer=self:setTimer(1,0,function()
local stamp=timeHelper.getServerShortTime()
local flag=self.emailPlayStamp==nil or(stamp-self.emailPlayStamp)>=7
if flag then
self.emailPlayStamp=stamp
self.winlua:SetChildDOTweenAnimation_DOPlay(self.emailIcon:getID(),'1',0,3)
end
end)
end
else
if self.emailtimer then
self:stopTimerByID(self.emailtimer)
end
self.emailtimer=nil
end
end




function UITaskListWin.onDailyTaskChange()
if _this==nil then return end
_this:refreshDailyTaskView()
end

function UITaskListWin:initDailyTaskView()
self.dailyTaskRootWidget=self.dailyTaskRoot:getChildWidgetBase()
self.dailyTaskRootWidget:SetChildButtonClick(0,function()
self:onDailyTaskBtn()
end)
end

function UITaskListWin:refreshDailyTaskView()
local cur,max
local isShow=false
if systemModel.isOpen(SYSTEM_DEFINE.eRiChang)then
cur=taskModel:getDailyTaskTargetNum()
local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
max=cfgHelper.get2(cfg_everydaytasktargetconfig_get,rewardIdx,'condition')
isShow=cur<max
end
self.dailyTaskRoot:setActive(isShow)
if isShow then
local title_str='<color=#a1ec58>【每日】日常任务</color>'
self.dailyTaskRootWidget:SetChildText(1,title_str)
local desc_str=FMT.fmt('达成每日目标 ({0}/{1})',cur,max)
self.dailyTaskRootWidget:SetChildText(2,desc_str)
end
end

function UITaskListWin:onDailyTaskBtn()
local jumpParam={id=JUMP_TYPE.eDailyTask}
jumpManager:jump(jumpParam)
end



function UITaskListWin:onZheXianLingBtn()
if zheXianLingModel:isRewardCurrentBook()and not zheXianLingModel:hasNextBook()then
UIManager.error('全新卷章暂未开启，请祖师静候')
else
UIFullZheXianControl:showZheXianLingZhangJieWindow()
end
end

function UITaskListWin.onSystemOpen(sysid)
if _this==nil then return end
if sysid==SYSTEM_DEFINE.eZeXianLing then
_this:doZheXianLingAni()
elseif sysid==SYSTEM_DEFINE.eRiChang then
_this:refreshDailyTaskView()
elseif sysid==SYSTEM_DEFINE.eJiuChongTianJieComplete then
_this:refreshSeasonEnter()
end
end

function UITaskListWin:showTaskListPanel(isInit)
if self.isShowTaskList then
return
end

self:clearShowPanelTweener()
local endVal=0
if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
else
self.winlua:SetChildLocalPosX(self.layout:getID(),-450)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end
self.isShowTaskList=true
end

function UITaskListWin:hideTaskListPanel(callBack)
if not self.isShowTaskList then
return
end

self:clearShowPanelTweener()
local endVal=-450
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,callBack)
self.isShowTaskList=false
end

function UITaskListWin:checkTaskListPanelShowOnZongmen()
local state=simpleModeControl:getLeftSimple()
local state2=simpleModeControl:getFortLeftSimple()
local isInFort=zongmenControl:isMountid(mapIdType.fort)
self.isShowTaskList=state==leftSimpleState.task and(not isInFort or state2==leftFortSimpleState.task)
local endVal=self.isShowTaskList and 0 or-450
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
end

function UITaskListWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end


function UITaskListWin:getAllTaskReddot()

if self.zheXianReddot then
return true
end



if self.taskDataList and next(self.taskDataList)then
for i=1,#self.taskDataList do
local taskdata=self.taskDataList[i]
local taskid=taskdata.taskid
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
local hasReward=t_taskstate==taskModel.taskRewardState

local taskReddot=hasReward and self.isinNewbie~=true

if taskReddot then
return true
end
end
end


local zmBreakReddot=self.curZongmenHasReward and self.isinNewbie~=true
if zmBreakReddot then
return true
end

return false
end

function UITaskListWin:refreshDiscipleAwakeTask()
self.awakeTaskData=taskModel:getDiscipleAwakeTask()
self.awakeTask:setActive(self.awakeTaskData~=nil)
self:stopAwakeTick()
if not self.awakeTaskData then return end
local item=self.awakeTask:getChildWidgetBase()
local taskdata=self.awakeTaskData
local taskid=taskdata.taskid
local taskcfg=taskdata.cfg
local taskstateResult=taskModel:getTaskState(taskdata)
local t_taskstate=taskstateResult.state
local cur=taskstateResult.curnum
local max=taskstateResult.maxnum


local desc_str=taskcfg.taskaimdesc
local islock=false
local showreward=false
self:stopAwakeTick()
if t_taskstate==taskModel.taskAcceptState then
islock=not taskModel:fitAcceptCondition(taskid)
if islock then
local cd=taskModel:getTaskLineCoolDown(taskdata.taskline)
if cd then
local duration=taskModel:getTaskWaitDuration(taskid)
local delta_time=cd+duration-timeHelper.getServerShortTime()
if delta_time>0 then
desc_str=FMT.fmt('{0}({1})',taskcfg.waitdesc or"",timeHelper.format_time_stamp3(delta_time))
self:startAwakeTick()
else
desc_str=FMT.fmt('{0}（未解锁）',taskcfg.waitdesc or"")
end
else
desc_str=FMT.fmt('{0}（未解锁）',taskcfg.waitdesc or"")
end
else
desc_str=FMT.fmt('{0}（未接取）',desc_str)
end
elseif t_taskstate==taskModel.taskDoingState then
desc_str=FMT.fmt('{0}（{1}/{2}）',desc_str,mathHelper.formatBIGNumbereEx(cur),mathHelper.formatBIGNumbereEx(max))
elseif t_taskstate==taskModel.taskRewardState then
self.curTaskHasReward=true
desc_str=FMT.fmt('{0}',desc_str)
end



item:SetChildText(0,FMT.fmt("<color=#BB8CF1>【觉】{0}</color>",taskcfg.name))
item:SetChildText(1,desc_str)
item:SetChildActive(4,islock)

local func=function(...)



local cickTask=logPoint.GetValue('onClickFirstTask',false)
if cickTask==false then
logPoint.SetValue('onClickFirstTask',true)
logPoint.UploadLog(logPoint.logType.clickFirstTask)
end
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)

if t_taskstate==taskModel.taskAcceptState then
local fit,w_str=taskModel:fitAcceptCondition(taskid)
if not fit then
UIManager.error(w_str)
return
end
taskController:doAcceptTask(taskid)
elseif t_taskstate==taskModel.taskDoingState then
taskController:doJump(taskid)
elseif t_taskstate==taskModel.taskRewardState then
taskController:doGetTaskReward_before(taskid)
end
self:startClickNewBie(taskid,t_taskstate,taskdata.taskline)
end
item:SetChildButtonClick(-1,func,true)

local talkData=self:getTaskTalkingData(taskid)
local showTalk=talkData~=nil
item:SetChildActive(7,showTalk)
if showTalk then
item:SetChildText(8,talkData[2])
end





local hasReward=t_taskstate==taskModel.taskRewardState
local showreward=hasReward and self.isinNewbie~=true
local showrewardIcon=showreward and self:getTaskTalkingData(taskid)==nil
item:SetChildActive(2,showrewardIcon)
item:SetChildActive(3,showreward)
item:SetChildShowEffect(6,rewardEffectID,hasReward)

local showSign=false
local flag,signImg
if t_taskstate==taskModel.taskDoingState then
local lp=taskDoingCheckSingFunc[taskcfg.tasktype]
if lp then
flag,signImg=lp.check(taskcfg)
if flag then
showSign=true
end
end
end
item:SetChildActive(10,showSign)
if showSign then
item:SetChildCSImageSprite(10,globalABLookup.global,signImg)
end

if webGLHelper:isHidePunchAni()then
item:SetChildDOTweenAnimation_DOPause(2)
item:SetChildActive(6,false)
end
end

function UITaskListWin:startAwakeTick()
if not self.awakeTick then
self.awakeTick=self:setTimer(1,0,function()
local taskdata=self.awakeTaskData
local item=self.awakeTask:getChildWidgetBase()
local cd=taskModel:getTaskLineCoolDown(taskdata.taskline)
local desc_str=nil
if cd then
local duration=taskModel:getTaskWaitDuration(taskdata.taskid)or 0
local delta_time=cd+duration-timeHelper.getServerShortTime()
if delta_time>0 then
desc_str=FMT.fmt('{0}({1})',taskdata.cfg.waitdesc or"",timeHelper.format_time_stamp3(delta_time))
else
desc_str=FMT.fmt('{0}（未解锁）',taskdata.cfg.waitdesc or"")
self:stopAwakeTick()
end
else
desc_str=FMT.fmt('{0}（未解锁）',taskdata.cfg.waitdesc or"")
self:stopAwakeTick()
end



item:SetChildText(1,desc_str)
end)
end
end

function UITaskListWin:stopAwakeTick()
if self.awakeTick then
self:stopTimerByID(self.awakeTick)
self.awakeTick=nil
end
end

function UITaskListWin.onSystemZMInfoChange(serial,type,oldVal,param)
if type==systemZongMenInfoUpdateType.eRelation then
if oldVal==systemZongMenRelationType.eDiDui or param==systemZongMenRelationType.eDiDui then
_this:refreshTaskList()
end
end
end


local _checkTableListSame=function(ta,tb)
if ta==nil or next(ta)==nil then return false end
if tb==nil or next(tb)==nil then return false end

if#ta~=#tb then return false end

for index,ainfo in ipairs(ta)do
local binfo=tb[index]
if binfo==nil then
return false
end
if ainfo[1]~=binfo[1]and ainfo[2]~=binfo[2]then
return false
end
end

return true
end
function UITaskListWin:refreshSeasonEnter()

local isInFort=zongmenControl:isMountid(mapIdType.fort)
self.seasonRoot:setActive(not isInFort)
if isInFort then
return
end

local seasonList=seasonModel:getSeasonEnterList()or defaultT
local isShowSeasonRoot=next(seasonList)~=nil
self.seasonRoot:setActive(isShowSeasonRoot)
if not isShowSeasonRoot then
self:clearSeasonEnterItem()
self.seasonList=defaultT
self.seasonRoot:recycleAll()
return
end

self.seasonList=self.seasonList or defaultT
local isDiff=not _checkTableListSame(self.seasonList,seasonList)
if isDiff then
self.seasonRoot:recycleAll()

self.seasonEnterLuaIdList={}

local parentIdx=self.seasonRoot:getID()

for index,seasonInfo in ipairs(seasonList)do
local prefabType=seasonInfo[1]
local seasonType=seasonInfo[2]
local enterPrefabName
if prefabType==1 then
enterPrefabName=seasonModel:getHandleConfig(seasonType,'enterPrefabName')
elseif prefabType==2 then
enterPrefabName=cfgHelper.get2(cfg_devildomseasonconfig_get,seasonType,'preEnterPrefabName')
end
local enterItemName=enterPrefabName[1]
local args={seasonType=seasonType}
local luaid=self.seasonRoot:createObject(enterItemName,parentIdx,index,args)
self.seasonEnterLuaIdList[seasonType]=luaid
end
else
self:refreshSeasonAllEnterItem()
end

self.seasonList=seasonList
end


function UITaskListWin:refreshSeasonAllEnterItem()
if self.seasonEnterLuaIdList==nil then return end
for seasonType,luaid in pairs(self.seasonEnterLuaIdList)do
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonType}
luaObject:onShow(args)
end
end
end

function UITaskListWin:hideSeasonAllEnterItem()
if self.seasonEnterLuaIdList==nil then return end
for seasonType,luaid in pairs(self.seasonEnterLuaIdList)do
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonType}
luaObject:onHide(args)
end
end
end

function UITaskListWin:refreshSeasonEnterItem(seasonId)
local luaid=self.seasonEnterLuaIdList and self.seasonEnterLuaIdList[seasonId]
if luaid then
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonId}
luaObject:onShow(args)
end
end
end

function UITaskListWin:callSeasonEnterFunc(seasonId,funcName)
local luaid=self.seasonEnterLuaIdList and self.seasonEnterLuaIdList[seasonId]
if luaid then
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject and luaObject[funcName]~=nil then
luaObject[funcName](luaObject)
end
end
end

function UITaskListWin:clearSeasonEnterItem()
if self.seasonEnterLuaIdList==nil then return end
if next(self.seasonEnterLuaIdList)==nil then return end
self.seasonRoot:recycleAll()
self.seasonEnterLuaIdList=nil
end

function UITaskListWin.onSeasonChange()
_this:refreshSeasonEnter()
end

function UITaskListWin.onSeasonEnterConditionChange()
_this:refreshSeasonEnter()
end

function UITaskListWin.onSeasonStageChange(season_id)

end

function UITaskListWin.onSeasonStageDataChange(season_id,chapter_idx)
_this:refreshSeasonEnter()
end
function UITaskListWin.onNewDay()
_this:refreshSeasonEnter()
end

function UITaskListWin.on_35_90()
if _this==nil then return end
_this:refreshSeasonEnter()
end

function UITaskListWin.on_35_95()
if _this==nil then return end
_this:refreshSeasonEnter()
end

function UITaskListWin.onLimitActStateChange(actID,state,isNew)
if actID==LIMIT_ACT_TYPE.eMoJieSaiJi then
_this:refreshSeasonEnter()
end
end
