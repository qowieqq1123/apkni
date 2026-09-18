







def_class("UICJXYChapterContentWin1",UIWindowBase)









function UICJXYChapterContentWin1:bindComponents()

self.background=UIImage.get(self,0)
self.boxList=UIObject.get(self,1)
self.conditionTx=UIText.get(self,2)
self.funcRoot=UIButton.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.numTips=UIText.get(self,5)
self.numTx=UIText.get(self,6)
self.progressBar=UIProgress.get(self,7)
self.storyBg=UIObject.get(self,8)
self.storyTx=UIText.get(self,9)
self.storyTx2=UIText.get(self,10)
self.tipsBg=UIObject.get(self,11)
self.tipsTx=UIText.get(self,12)

self.funcRoot:setButtonClick(function()self:onFuncRoot()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UICJXYChapterContentWin1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.boxList);self.boxList=nil;
_UIObject_release(self.conditionTx);self.conditionTx=nil;
_UIObject_release(self.funcRoot);self.funcRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.numTips);self.numTips=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.storyBg);self.storyBg=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end















local _this=nil
local _boxCmp={
widget=-1,
box=0,
num=1,
reddot=2,
tick=3,
}
local _funcCmp={
widget=-1,
model=0,
tips=1,
name=2,
}



function UICJXYChapterContentWin1:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function UICJXYChapterContentWin1:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UICJXYChapterContentWin1:onShow(argtable,afterOnloaded)
self.handleType=argtable.handleType
self.stageIdx=argtable.stageIdx
self.stage=seasonModel:getStage(self.handleType,self.stageIdx)
self:initView()
end


function UICJXYChapterContentWin1:onHide()

end




function UICJXYChapterContentWin1:onJumpBtn()
local jumpParam=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","jumpBtn")
if jumpParam then
jumpManager:jump(jumpParam.jump)
end
end


function UICJXYChapterContentWin1:onFuncRoot()
local open_func=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","open_func")
local args={
configs=open_func,
parentWin=self,
}
self:showWindow("UICJXYChapterOpenSystemWin",args)
end

function UICJXYChapterContentWin1:onClickBox(index)
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
oktext=not getted and'确定'or nil,
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

function UICJXYChapterContentWin1:initView()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local winArgs=config.winArgs

local imageCfg=winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])

local score_reward=config.score_reward
local count=#score_reward
local width=self.progressBar:getChildSizeDeltaX()
local perX=width/(count-1)
self.boxList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.boxList:getChildLayoutGroupGridItem(index-1)
local box=config.winArgs.boxParam[index]
local info=score_reward[index]
local num=info[1]
local x=(index-1)*perX
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildAnchoredPos(_boxCmp.widget,x,5)
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

self.numTips:setText(config.score_name)

local conditionTx=winArgs.conditionTx
self.conditionTx:setText(conditionTx)

local width=self.storyTx2:getChildSizeDeltaX()
local obj=self.winlua:GetChildGameObject(self.storyTx2:getID())
local storyStr=comHelper.getCheckLayoutStr(obj,width,config.winArgs.storyStr2)
self.storyTx:setText(storyStr)

self:refreshScore()
self:refreshJump()
self:refreshTips()
end

function UICJXYChapterContentWin1:refreshJump()
local open=self.stage and self.stage:checkOpen()and self.stage:isOverBegin()or false
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local winArgs=config.winArgs
local jumpBtn=winArgs.jumpBtn
self.jumpBtn:setActive(jumpBtn~=nil and open)
if jumpBtn then
local image=jumpBtn.image
self.winlua:SetChildCSImageSprite(self.jumpBtn:getID(),image[1],image[2])
end
end

function UICJXYChapterContentWin1:refreshScore()
local score=self.stage and self.stage.score or 0
self.numTx:setText(score)

local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local score_reward=config.score_reward
local count=#score_reward
local per=10000/(count-1)
local progress=0
for i=2,count do
local preScore=score_reward[i-1][1]
local tarScore=score_reward[i][1]
if score>=tarScore then
progress=progress+per
else
progress=progress+(score-preScore)/(tarScore-preScore)*per
break
end
end
self.progressBar:setProgressValue(progress,10000)
end

function UICJXYChapterContentWin1:refreshBoxReddot()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local score_reward=config.score_reward
local boxItems=self.boxList:getChildLayoutGroupGridList()
for index=1,boxItems.Count do
local item=boxItems[index-1]
local info=score_reward[index]
local num=info[1]
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildActive(_boxCmp.reddot,reddot)
end
end

function UICJXYChapterContentWin1:refreshBoxFlag()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local score_reward=config.score_reward
local boxItems=self.boxList:getChildLayoutGroupGridList()
for index=1,boxItems.Count do
local item=boxItems[index-1]
local info=score_reward[index]
local num=info[1]
local getted=self.stage and self.stage.flag>=index or false
local reddot=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and self.stage.score>=num and not getted or false
item:SetChildActive(_boxCmp.reddot,reddot)
item:SetChildGraphicGray(_boxCmp.box,getted)
item:SetChildActive(_boxCmp.tick,getted)
end
end

function UICJXYChapterContentWin1:refreshTips()
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
self.tipsBg:setActive(true)
local nowTime=timeHelper.getServerShortTime()
if nowTime<self.stage.endTime then
self.tipsContent=self.stage:getConfig("winArgs","cdStr")
self.tipsBg:setActive(self.tipsContent~=nil)
self.tipsTime=self.stage.endTime
self:startCDTick()
self:updateCDTick()
return
else
self.tipsBg:setActive(true)
local tispStr=FMT.fmt("已于{0}完成",timeHelper.getFormatByShortStamp2(self.stage.endTime))
self.tipsTx:setText(tispStr)
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

function UICJXYChapterContentWin1:refreshView()
self:refreshScore()
self:refreshBoxFlag()
self:refreshTips()
self:refreshJump()
end

function UICJXYChapterContentWin1:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICJXYChapterContentWin1:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICJXYChapterContentWin1:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.tipsTime
if nowTime<endTime then
if self.tipsContent then
local timeStr=FMT.fmt(self.tipsContent,timeHelper.format_time_stamp3(endTime-nowTime))
self.tipsTx:setText(timeStr)
end
else
self:refreshTips()
self:refreshBoxReddot()
end
end

function UICJXYChapterContentWin1.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then
if param1==2 then
_this:refreshBoxFlag()
end
end
end

function UICJXYChapterContentWin1.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then
_this:refreshScore()
_this:refreshBoxReddot()
_this:refreshTips()
end
end

function UICJXYChapterContentWin1.onSeasonChange()
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end

function UICJXYChapterContentWin1.onSeasonStageChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end
end
