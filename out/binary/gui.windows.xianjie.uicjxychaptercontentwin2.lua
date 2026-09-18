







def_class("UICJXYChapterContentWin2",UIWindowBase)









function UICJXYChapterContentWin2:bindComponents()

self.background=UIImage.get(self,0)
self.buildingTx=UIText.get(self,1)
self.conditionTx=UIText.get(self,2)
self.detailBtn=UIButton.get(self,3)
self.effectList=UIObject.get(self,4)
self.finish=UIObject.get(self,5)
self.funcRoot=UIButton.get(self,6)
self.jumpBtn=UIButton.get(self,7)
self.msgItem_1=UIText.get(self,8)
self.msgItem_2=UIText.get(self,9)
self.msgItem_3=UIText.get(self,10)
self.msgItem_4=UIText.get(self,11)
self.msgList=UIObject.get(self,12)
self.msgView=UIButton.get(self,13)
self.progressBar=UIProgress.get(self,14)
self.stageList=UIObject.get(self,15)
self.stageRewardBtn=UIButton.get(self,16)
self.stageRewardReddot=UIObject.get(self,17)
self.stageRewardReddotTx=UIText.get(self,18)
self.storyTx=UIText.get(self,19)
self.storyTx2=UIText.get(self,20)
self.tipsBg=UIObject.get(self,21)
self.tipsTx=UIText.get(self,22)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.funcRoot:setButtonClick(function()self:onFuncRoot()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.msgView:setButtonClick(function()self:onMsgView()end)

self.stageRewardBtn:setButtonClick(function()self:onStageRewardBtn()end)
self.msgItem={
self.msgItem_1,
self.msgItem_2,
self.msgItem_3,
self.msgItem_4,
}



end


function UICJXYChapterContentWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buildingTx);self.buildingTx=nil;
_UIObject_release(self.conditionTx);self.conditionTx=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.finish);self.finish=nil;
_UIObject_release(self.funcRoot);self.funcRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.msgItem_1);self.msgItem_1=nil;
_UIObject_release(self.msgItem_2);self.msgItem_2=nil;
_UIObject_release(self.msgItem_3);self.msgItem_3=nil;
_UIObject_release(self.msgItem_4);self.msgItem_4=nil;
_UIObject_release(self.msgList);self.msgList=nil;
_UIObject_release(self.msgView);self.msgView=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.stageRewardBtn);self.stageRewardBtn=nil;
_UIObject_release(self.stageRewardReddot);self.stageRewardReddot=nil;
_UIObject_release(self.stageRewardReddotTx);self.stageRewardReddotTx=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
self.msgItem=nil;
end















local _this=nil
local _msgCnt=4
local _funcCmp={
widget=-1,
model=0,
tips=1,
name=2,
}



function UICJXYChapterContentWin2:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)

self:addProNotify(35,90,self.on_35_90)
self:addProNotify(35,91,self.on_35_91)
self:addProNotify(35,92,self.on_35_92)
end


function UICJXYChapterContentWin2:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UICJXYChapterContentWin2:onShow(argtable,afterOnloaded)
self.handleType=argtable.handleType
self.stageIdx=argtable.stageIdx
self.stage=seasonModel:getStage(self.handleType,self.stageIdx)


if self.stage and self.stage:checkOpen()and self.stage:isOverBegin()then
if not xianjieModel:getLeyLineRepairData()then
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
xianjieController:send_35_91(entityID)
end
end

self:refreshMsgView()
self:initView()
end


function UICJXYChapterContentWin2:onHide()

end




function UICJXYChapterContentWin2:onDetailBtn()
local args={
parentWin=self,
}
self:showWindow("UIXianJie_LeyLineRepairDetailWin",args)
end


function UICJXYChapterContentWin2:onJumpBtn()
local jumpParam=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","jumpBtn")
if jumpParam then
jumpManager:jump(jumpParam.jump)
end
end


function UICJXYChapterContentWin2:onFuncRoot()
local open_func=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","open_func")
local args={
configs=open_func,
parentWin=self,
}
self:showWindow("UICJXYChapterOpenSystemWin",args)
end


function UICJXYChapterContentWin2:onStageRewardBtn()
local winName=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","stageWindow")
local args={
parentWin=self,
stage=self.stage and self.stage:getRepairStage()or nil,
}
self:showWindow(winName,args)
end

function UICJXYChapterContentWin2:refreshMsgView()
local msgDatas=xianjieModel:getLeyLineRepairLogs()
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,entityID)
local maxStage=#buildCfg.param.fixed_build_conf
local count=#msgDatas
local num=#self.msgItem
for i,v in ipairs(self.msgItem)do
local index=i
local data=msgDatas[index]
v:setActive(data~=nil)
if data then
local widget=v:getChildWidgetBase()
local langId=FMT.fmt("leyline_repair_log_{0}",data.log_type)
data.actor_name=data.log_type==2 and maxStage or data.actor_name
local descStr=FMT.fmt(cfgHelper.getlang(langId),data.name,data.actor_name,buildCfg.name,data.score)
local width=widget:GetChildSizeDeltaX(2)
local str=comHelper.getCheckLayoutStr(widget:GetChildGameObject(2),width,descStr)
widget:SetChildText(0,str)
widget:SetChildText(1,timeHelper.getFormatByShortStamp(data.times))
widget:ForceLayoutRect(0)
end
end
self.winlua:ForceLayoutRect(self.msgList:getID())
end

function UICJXYChapterContentWin2:initView()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local winArgs=config.winArgs
self.conditionTx:setText(winArgs.conditionTx)

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

local entityID=config.entityID
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,entityID)
self.buildingTx:setText(buildCfg.name)
local descs=buildCfg.clientParam.effectStr
self.effectList:setChildLayoutGroupCreateItems(#descs,function(index)
local item=self.effectList:getChildLayoutGroupGridItem(index-1)
local width=item:GetChildSizeDeltaX(1)
local str=comHelper.getCheckLayoutStr(item:GetChildGameObject(1),width,descs[index])
item:SetChildText(0,str)
end)

local fixed_build_conf=buildCfg.param.fixed_build_conf
local stage=self.stage and self.stage:getRepairStage()or 0
self.stageList:setChildLayoutGroupCreateItems(#fixed_build_conf,function(index)
local item=self.stageList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,index<=stage)
item:SetChildActive(1,index>1)
end)

local repaired=self.stage and self.stage:isRepairOver()or false
if repaired then
local maxValue=fixed_build_conf[#fixed_build_conf][1]
self.progressBar:setProgressValue(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",maxValue,maxValue))
else

local maxValue=fixed_build_conf[stage+1][1]
local curValue=self.stage and self.stage:getRepairScore()or 0
self.progressBar:setProgressValue(math.floor(curValue/maxValue*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",curValue,maxValue))
end

local flag=self.stage and self.stage:getRepairFlag()or 0
local open=self.stage and self.stage:checkOpen()and self.stage:isOverBegin()or false
local showReddot=stage>flag and open
self.stageRewardReddot:setActive(showReddot)
if showReddot then
self.stageRewardReddotTx:setText(stage-flag)
end

local width=self.storyTx2:getChildSizeDeltaX()
local obj=self.winlua:GetChildGameObject(self.storyTx2:getID())
local storyStr=comHelper.getCheckLayoutStr(obj,width,config.winArgs.storyStr2)
self.storyTx:setText(storyStr)

self:refreshTips()
self:refreshJump()
end

function UICJXYChapterContentWin2:refreshJump()
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local winArgs=config.winArgs
local repaired=self.stage and self.stage:isRepairOver()or false
local open=self.stage and self.stage:checkOpen()and self.stage:isOverBegin()or false
local jumpBtn=winArgs.jumpBtn
self.jumpBtn:setActive(jumpBtn~=nil and open and not repaired)
self.finish:setActive(repaired)
if jumpBtn then
local image=jumpBtn.image
self.winlua:SetChildCSImageSprite(self.jumpBtn:getID(),image[1],image[2])
end
end

function UICJXYChapterContentWin2:refreshTips()
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

function UICJXYChapterContentWin2:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICJXYChapterContentWin2:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICJXYChapterContentWin2:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.tipsTime
if nowTime<endTime then
if self.tipsContent then
local timeStr=FMT.fmt(self.tipsContent,timeHelper.format_time_stamp3(endTime-nowTime))
self.tipsTx:setText(timeStr)
end
else
self:refreshTips()
self:refreshJump()
self:refreshRewardReddot()
end
end

function UICJXYChapterContentWin2:refreshView()
self:refreshStageActive()
self:refreshProgressBar()
self:refreshButton()
self:refreshRewardReddot()
self:refreshTips()
self:refreshJump()
end

function UICJXYChapterContentWin2:refreshStageActive()
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
local stage=self.stage and self.stage:getRepairStage()or 0
local stageItems=self.stageList:getChildLayoutGroupGridList()
for index=1,stageItems.Count do
local item=stageItems[index-1]
item:SetChildActive(0,index<=stage)
end
end

function UICJXYChapterContentWin2:refreshProgressBar()
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,entityID)
local fixed_build_conf=buildCfg.param.fixed_build_conf
local repaired=self.stage and self.stage:isRepairOver()or false
if repaired then
local maxValue=fixed_build_conf[#fixed_build_conf][1]
self.progressBar:setProgressValue(10000,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",maxValue,maxValue))
else
local stage=self.stage and self.stage:getRepairStage()or 0
local maxValue=fixed_build_conf[stage+1][1]
local curValue=self.stage and self.stage:getRepairScore()or 0
self.progressBar:setProgressValue(math.floor(curValue/maxValue*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",curValue,maxValue))
end
end

function UICJXYChapterContentWin2:refreshButton()
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
local repaired=self.stage and self.stage:isRepairOver()or false
local jumpBtn=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","jumpBtn")
self.jumpBtn:setActive(jumpBtn~=nil and not repaired)
self.finish:setActive(repaired)
end

function UICJXYChapterContentWin2:refreshRewardReddot()
local entityID=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"entityID")
local flag=self.stage and self.stage:getRepairFlag()or 0
local stage=self.stage and self.stage:getRepairStage()or 0
local open=self.stage and self.stage:checkOpen()or self.stage:isOverBegin()or false
local showReddot=stage>flag and open
self.stageRewardReddot:setActive(showReddot)
if showReddot then
self.stageRewardReddotTx:setText(stage-flag)
end
end

function UICJXYChapterContentWin2:onMsgView()
self:onDetailBtn()
end

function UICJXYChapterContentWin2.onSeasonChange()
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end

function UICJXYChapterContentWin2.onSeasonStageChange(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx then
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end
end

function UICJXYChapterContentWin2.on_35_90()
_this:refreshView()
_this:refreshMsgView()
end

function UICJXYChapterContentWin2.on_35_91(fairylandFixBuild)
local entityID=seasonModel:getStageConfigEx(_this.handleType,_this.stageIdx,"entityID")
if entityID==fairylandFixBuild.fix_build_id then
_this:refreshView()
_this:refreshMsgView()
end
end

function UICJXYChapterContentWin2.on_35_92(fix_build_id,stage_rw_flag)
local entityID=seasonModel:getStageConfigEx(_this.handleType,_this.stageIdx,"entityID")
if entityID==fix_build_id then
_this:refreshRewardReddot()
end
end
