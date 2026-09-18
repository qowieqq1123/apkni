







def_class("UICJXYChapterContentWin3",UIWindowBase)









function UICJXYChapterContentWin3:bindComponents()

self.assecc=UIObject.get(self,0)
self.assetBtn=UIButton.get(self,1)
self.background=UIImage.get(self,2)
self.boxList=UIObject.get(self,3)
self.conditionTx=UIText.get(self,4)
self.contentBg=UIObject.get(self,5)
self.expired=UIObject.get(self,6)
self.funcRoot=UIButton.get(self,7)
self.progressBar=UIProgress.get(self,8)
self.progressValueName=UIText.get(self,9)
self.progressValueTx=UIText.get(self,10)
self.scroller=UIEnhancedScrollerLua.get(self,11)
self.tab_1=UIButton.get(self,12)
self.tab_2=UIButton.get(self,13)
self.tipsBg=UIObject.get(self,14)
self.tipsTx=UIText.get(self,15)

self.assetBtn:setButtonClick(function()self:onAssetBtn()end)

self.funcRoot:setButtonClick(function()self:onFuncRoot()end)

self.tab_1:setButtonClick(function()self:onTab_1()end)

self.tab_2:setButtonClick(function()self:onTab_2()end)
self.tab={
self.tab_1,
self.tab_2,
}



end


function UICJXYChapterContentWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.assecc);self.assecc=nil;
_UIObject_release(self.assetBtn);self.assetBtn=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.boxList);self.boxList=nil;
_UIObject_release(self.conditionTx);self.conditionTx=nil;
_UIObject_release(self.contentBg);self.contentBg=nil;
_UIObject_release(self.expired);self.expired=nil;
_UIObject_release(self.funcRoot);self.funcRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressValueName);self.progressValueName=nil;
_UIObject_release(self.progressValueTx);self.progressValueTx=nil;
_UIObject_release(self.scroller);self.scroller=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
self.tab=nil;
end















local _this=nil
local _taskCmp={
progressBar=0,
nameTx=1,
rewardBtn=2,
jumpBtn=3,
getted=4,
rewards=5,
icon1=6,
icon2=7,
expired=8,
}
local _tabReddotFunc={
"getDailyTaskReddot",
"getChapterTaskReddot",
}
local _funcCmp={
widget=-1,
model=0,
tips=1,
name=2,
}
local _boxCmp={
widget=-1,
box=0,
num=1,
reddot=2,
tick=3,
}
local _taskSortWeigth={
[taskModel.taskDoingState]=2,
[taskModel.taskRewardState]=3,
[taskModel.taskFinishState]=1,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UICJXYChapterContentWin3:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)

self:addProNotify(35,95,self.on_35_95)
self:addProNotify(35,96,self.on_35_96)
self:addProNotify(35,97,self.on_35_97)

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageTaskChange,self.onSeasonStageTaskChange)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)

self.scrollerScript=UIPrepareEnScroller(self.scroller:getGameObject(),self.scroller:getCSharpObject(),nil,nil)
self.scrollerScript.window=self
end


function UICJXYChapterContentWin3:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterContentWin3:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=self.showParams.handleType
self.stageIdx=self.showParams.stageIdx
self.showParams.funcIdx2=self.showParams.funcIdx2 or 1
self.stage=seasonModel:getStage(self.handleType,self.stageIdx)


if self.stage and self.stage:checkOpen()and self.stage:isOverBegin()then
if not seasonModel:isInitTaskData()then
seasonController:send_35_95()
end
end

self:initView()
end


function UICJXYChapterContentWin3:onHide()

end




function UICJXYChapterContentWin3:onAssetBtn()
if self.stage==nil or not self.stage:isOverBegin()or not self.stage:checkOpen()then return end
if self.stage.access==0 then
seasonController:send_39_2(self.handleType,self.stageIdx,3)
end
end


function UICJXYChapterContentWin3:onFuncRoot()
local open_func=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","open_func")
local args={
configs=open_func,
parentWin=self,
}
self:showWindow("UICJXYChapterOpenSystemWin",args)
end


function UICJXYChapterContentWin3:onTab_1()
self:onClickTab(1)
end


function UICJXYChapterContentWin3:onTab_2()
self:onClickTab(2)
end

function UICJXYChapterContentWin3:onClickTab(index)


local selectIdx=self.showParams.funcIdx2
if selectIdx~=index then
self:refreshTabSelect(selectIdx,false)
self.showParams.funcIdx2=index
self:refreshTabSelect(index,true)
self:refreshTaskView()
self:refreshTips()
end
end

function UICJXYChapterContentWin3:onClickBox(index)
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local score_reward=config.score_reward[index]
local getted=self.stage and self.stage.flag>=index or false
local num=score_reward[1]
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
if reddot then
seasonController:send_39_2(self.handleType,self.stageIdx,2)
return
end

local itemlist={}
for i,v in ipairs(score_reward[2])do
table.insert(itemlist,{itemid=v[1],itemcount=v[2]})
end
local tipStr=config.winArgs.rewardTips
tipStr=FMT.fmt(tipStr,num)
local show_data={
type='UIDialougeBuyWithReward2',
title='提示',
oktext=getted and''or'确定',
itemlist=itemlist,
tip=tipStr,
showclosebtn=true,
bgClick=true,
gotFlag=getted,
canvasindex=9,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UICJXYChapterContentWin3:onClickJump(index)
if self.stage==nil or not self.stage:isOverBegin()or not self.stage:checkOpen()then return end

local taskId=self.taskList[index]
local taskCfg=cfgHelper.get1(cfg_fairylandseasontaskconfig_get,taskId)
if taskCfg.jump then
jumpManager:jump(taskCfg.jump)
end
end

function UICJXYChapterContentWin3:onClickReward(index)
if self.stage==nil or not self.stage:isOverBegin()or not self.stage:checkOpen()then return end
if not seasonModel:isInitTaskData()then return end

for index,taskId in pairs(self.taskList)do
local taskData=seasonModel:getTaskData(taskId)
if taskData.task_state==taskModel.taskRewardState then
seasonController:send_39_96(taskId)
end
end






end

function UICJXYChapterContentWin3:initView()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local winArgs=config.winArgs

local imageCfg=winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])

local open_func=winArgs.open_func[1]
local funcWidget=self.funcRoot:getChildWidgetBase()
funcWidget:SetChildActive(_funcCmp.widget,open_func~=nil)
if open_func then
local modelParams=open_func.model
local scale=winArgs.open_func_enter[1]or 1
funcWidget:SetChildUIModelShowTarget(_funcCmp.model,modelParams[1],scale,modelParams[2]or{},modelParams[4]or eAnimationID.stand,false,false,0)
local offset=winArgs.open_func_enter[2]
local offsetX=offset and offset[1]or 0
local offsetY=offset and offset[2]or 0
funcWidget:SetChildUIModelShowTargetOffset(_funcCmp.model,offsetX,offsetY)

local name=open_func.name
funcWidget:SetChildText(_funcCmp.name,name)

local tipStr=config.winArgs.open_func_tips or""
funcWidget:SetChildText(_funcCmp.tips,tipStr)
end

local conditionTx=winArgs.conditionTx
self.conditionTx:setText(conditionTx)

for i,v in ipairs(self.tab)do
local widget=v:getChildWidgetBase()
local select=self.showParams.funcIdx2==i
local reddotFunc=_tabReddotFunc[i]
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage[reddotFunc]and self.stage[reddotFunc](self.stage)
widget:SetChildActive(0,select)
widget:SetChildActive(2,reddot)
end

local score=self.stage and self.stage.score or 0
local score_reward=config.score_reward
local rewardCnt=#score_reward
self.progressValueName:setText(config.score_name)

self.boxList:setChildLayoutGroupCreateItems(rewardCnt,function(index)
local item=self.boxList:getChildLayoutGroupGridItem(index-1)
local box=config.winArgs.boxParam[index]
local info=score_reward[index]
local num=info[1]
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildText(_boxCmp.num,num)
item:SetChildActive(_boxCmp.reddot,reddot)
item:SetChildActive(_boxCmp.tick,getted)
item:SetChildCSImageSprite(_boxCmp.box,box[1],box[2])
item:SetChildScale(_boxCmp.box,Vector3.one*(box[3]or 1))
item:SetChildGraphicGray(_boxCmp.box,getted)
item:SetChildButtonClick(_boxCmp.box,function()
self:onClickBox(index)
end)
end)
self:refreshProgressValue()
self:refreshTaskView()
self:refreshTips()
end

function UICJXYChapterContentWin3:refreshTabSelect(index,select)
local widget=self.tab[index]:getChildWidgetBase()
widget:SetChildActive(0,select)
end

function UICJXYChapterContentWin3:refreshAllTabReddot()
for i,v in ipairs(self.tab)do
self:refreshTabReddot(i)
end
end

function UICJXYChapterContentWin3:refreshTabReddot(index)
local widget=self.tab[index]:getChildWidgetBase()
local reddotFunc=_tabReddotFunc[index]
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage[reddotFunc]and self.stage[reddotFunc](self.stage)
widget:SetChildActive(2,reddot)
end

function UICJXYChapterContentWin3:refreshTaskView()
self.expireFlag=self.stage and self.stage:isOverEnd()or false
local open=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()or false

if not seasonModel:isInitTaskData()then
self.assecc:setActive(false)
self.expired:setActive(open and self.expireFlag)
self.scroller:setActive(false)
self.contentBg:setActive(true)
self.invalid=true
return
end

local assecc=false
self.taskList={}
if self.showParams.funcIdx2==2 then
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
for i,v in pairs(config.task_conf)do
table.insert(self.taskList,i)
end
assecc=open
else
if self.stage then
for i,v in pairs(self.stage.daily)do
table.insert(self.taskList,v)
end
end
assecc=self.stage and self.stage.access==1 or false
end












self.assecc:setActive(open and not self.expireFlag and not assecc)
self.expired:setActive(open and self.expireFlag)
self.scroller:setActive(open and not self.expireFlag and assecc)
if open and not self.expireFlag and assecc then
self:sortTaskList()
self.scrollerScript:initData(self.taskList,100,#self.taskList)
self.contentBg:setActive(false)
else
self.taskList=nil
self.contentBg:setActive(true)
end
end

function UICJXYChapterContentWin3:sortTaskList()
table.sort(self.taskList,function(a,b)
local aData=seasonModel:getTaskData(a)
local bData=seasonModel:getTaskData(b)
local aWeidget=_taskSortWeigth[aData.task_state]
local bWeight=_taskSortWeigth[bData.task_state]
if aWeidget~=bWeight then
return aWeidget>bWeight
else
return a<b
end
end)
end

function UICJXYChapterContentWin3:refreshTips()
if self.stage then
if not self.stage:checkOpen()then
local taskId=self.stage:getConfig("main_task_id")
local taskCfg=taskModel:getTaskConfig(taskId)
local taskName=taskCfg and taskCfg.name or nil



self.tipsTx:setText(FMT.fmt("完成主线任务<color=#fd8950>【{0}】</color>后开启本章",taskName or""))
self.tipsBg:setActive(true)
elseif not self.stage:isOverBegin()then
self.tipsBg:setActive(true)
self.tipsContent="<color=#f36666>{0}</color>后开启本章"
self.tipsTime=self.stage.beginTime
self:startCDTick()
self:updateCDTick()
return
elseif self.stage.endTime>0 then
local nowTime=timeHelper.getServerShortTime()
if nowTime<self.stage.endTime then
self.tipsBg:setActive(true)
self.tipsContent=self.stage:getConfig("winArgs","cdStr")
self.tipsBg:setActive(self.tipsContent~=nil)
self.tipsTime=self.stage.endTime
self:startCDTick()
self:updateCDTick()
return
elseif self.expireFlag then
self.tipsBg:setActive(true)
local tispStr=FMT.fmt("已于{0}完成",timeHelper.getFormatByShortStamp2(self.stage.endTime))
self.tipsTx:setText(tispStr)
else
self.tipsBg:setActive(false)
end
else
self.tipsBg:setActive(false)
end
else
self.tipsBg:setActive(true)
if self.stageIdx>1 then
local preCfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx-1)
local tispStr=FMT.fmt("<color=#fd8950>完成第{0}章·{1}后解锁本章节</color>",mathHelper.numberToChinese(self.stageIdx-1),preCfg.name)
self.tipsTx:setText(tispStr)
else
self.tipsTx:setText("本章未开启")
end
end
self:stopCDTick()
end

function UICJXYChapterContentWin3:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICJXYChapterContentWin3:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICJXYChapterContentWin3:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.tipsTime
if nowTime<endTime then
if self.tipsContent then
local timeStr=FMT.fmt(self.tipsContent,timeHelper.format_time_stamp3(endTime-nowTime))
self.tipsTx:setText(timeStr)
end
else
self:refreshTaskView()
self:refreshTips()
self:refreshBoxReddot()
end
end

function UICJXYChapterContentWin3:refreshProgressValue()
local score=self.stage and self.stage.score or 0
local score_reward=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"score_reward")
local count=#score_reward
local per=10000/count
local progress=0
for i=1,count do
local preScore=score_reward[i-1]and score_reward[i-1][1]or 0
local tarScore=score_reward[i][1]
if score>=tarScore then
progress=progress+per
else
progress=progress+(score-preScore)/(tarScore-preScore)*per
break
end
end
self.progressBar:setProgressValue(progress,10000)
self.progressValueTx:setText(score)
end

function UICJXYChapterContentWin3:refreshBoxReddot(index)
local reddot=false
local item=self.boxList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,reddot)
end

function UICJXYChapterContentWin3:refreshBoxFlag()
local getted=false
local item=self.boxList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(3,getted)
item:SetChildGraphicGray(0,getted)
end

function UICJXYChapterContentWin3:refreshTaskItem(dataIndex,cell)
local taskId=self.taskList[dataIndex]
local taskData=seasonModel:getTaskData(taskId)
local taskCfg=cfgHelper.get1(cfg_fairylandseasontaskconfig_get,taskId)

local getted=taskData.task_state==taskModel.taskFinishState
local maxValue=taskData.task_target
local curValue=getted and maxValue or taskData.server_progress
if not getted and taskData.count_flag then
if mathHelper.getBitValue(taskData.count_flag,2)then
if taskData.server_progress<data.task_target then
curValue=taskData.client_progress
end
else
curValue=taskData.client_progress
end
end
curValue=Mathf.Clamp(curValue,0,maxValue)
local progressValue=math.floor(curValue/maxValue*10000)
local progressStr=FMT.fmt("{0}/{1}",curValue,maxValue)
cell:SetChildProgressValue(_taskCmp.progressBar,progressValue,10000)
cell:SetChildProgressText(_taskCmp.progressBar,progressStr)

local descStr=taskCfg.Desc
cell:SetChildText(_taskCmp.nameTx,descStr)

local expired=self.stage and self.stage:isOverEnd()or false
cell:SetChildActive(_taskCmp.rewardBtn,taskData.task_state==taskModel.taskRewardState)
cell:SetChildActive(_taskCmp.jumpBtn,not expired and taskData.task_state==taskModel.taskDoingState and taskCfg.jump~=nil)
cell:SetChildActive(_taskCmp.getted,taskData.task_state==taskModel.taskFinishState)
cell:SetChildActive(_taskCmp.expired,expired and taskData.task_state==taskModel.taskDoingState)
cell:SetChildActive(_taskCmp.icon1,taskData.task_state~=taskModel.taskFinishState)
cell:SetChildActive(_taskCmp.icon2,taskData.task_state==taskModel.taskFinishState)
cell:SetChildButtonClick(_taskCmp.jumpBtn,function()
self:onClickJump(dataIndex)
end)
cell:SetChildButtonClick(_taskCmp.rewardBtn,function()
self:onClickReward(dataIndex)
end)

local rewards=table.concatTableX(taskCfg.rewards2,taskCfg.rewards)
cell:SetChildLayoutGroupCreateItems(_taskCmp.rewards,#rewards,function(index)
local item=cell:GetChildLayoutGroupGridItem(_taskCmp.rewards,index-1)
local data=rewards[index]
local itemid=data[1]
local itemnum=data[2]
local showCountBG=itemnum>1
local countStr=showCountBG and mathHelper.formatNumber(itemnum)or""
local conf={itemid=itemid,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end

function UICJXYChapterContentWin3:refreshBoxReddot()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local boxItems=self.boxList:getChildLayoutGroupGridList()
for index=1,boxItems.Count do
local item=boxItems[index-1]
local box=config.winArgs.boxParam[index]
local info=config.score_reward[index]
local num=info[1]
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildActive(_boxCmp.reddot,reddot)
end
end

function UICJXYChapterContentWin3:refreshBoxFlag()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local boxItems=self.boxList:getChildLayoutGroupGridList()
for index=1,boxItems.Count do
local item=boxItems[index-1]
local box=config.winArgs.boxParam[index]
local info=config.score_reward[index]
local num=info[1]
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildActive(_boxCmp.reddot,reddot)
item:SetChildGraphicGray(_boxCmp.box,getted)
item:SetChildActive(_boxCmp.tick,getted)
end
end

function UICJXYChapterContentWin3:refreshView()
self:refreshProgressValue()
self:refreshBoxFlag()
self:refreshTaskView()
self:refreshTips()
self:refreshAllTabReddot()
end

function UICJXYChapterContentWin3:refresTaskList()
self:sortTaskList()
local beginIdx=self.scrollerScript:getStartCellViewIndex()
local endIdx=self.scrollerScript:getEndCellViewIndex()
for i=beginIdx,endIdx do
local cell=self.scrollerScript:GetCell(i)
self:refreshTaskItem(i+1,cell)
end
end

function UICJXYChapterContentWin3.onSeasonChange()
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end

function UICJXYChapterContentWin3.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then
if param1==2 then
_this:refreshBoxFlag()
elseif param1==3 then
_this:refreshTaskView()
_this:refreshAllTabReddot()
end
end
end

function UICJXYChapterContentWin3.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then
_this:refreshProgressValue()
_this:refreshBoxReddot()
end
end

function UICJXYChapterContentWin3.onSeasonStageChange(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx then
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end
end

function UICJXYChapterContentWin3.on_35_95(len,taskList)
if _this.invalid then
_this.invalid=nil
_this:refreshTaskView()
return
end
if _this.taskList then
_this:refresTaskList()
_this:refreshAllTabReddot()
end
end

function UICJXYChapterContentWin3.on_35_96(taskId)
if _this.taskList then
_this:refresTaskList()
_this:refreshAllTabReddot()
end
end

function UICJXYChapterContentWin3.on_35_97(taskData)
if _this.taskList then
_this:refresTaskList()
_this:refreshAllTabReddot()
end
end

function UICJXYChapterContentWin3.onSeasonStageTaskChange(change)
if _this.taskList then
for i,v in ipairs(_this.taskList)do
if change[v]~=nil then
_this:refresTaskList()
_this:refreshAllTabReddot()
return
end
end
end
end

function UICJXYChapterContentWin3.onNewDay()
_this:refreshTaskView()
_this:refreshAllTabReddot()
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
self.window:refreshTaskItem(dataIndex,cell)
end
