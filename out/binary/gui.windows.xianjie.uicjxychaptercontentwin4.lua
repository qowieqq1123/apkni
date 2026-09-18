







def_class("UICJXYChapterContentWin4",UIWindowBase)









function UICJXYChapterContentWin4:bindComponents()

self.background=UIImage.get(self,0)
self.funcRoot=UIButton.get(self,1)
self.rewardList=UIObject.get(self,2)
self.rewardView=UIObject.get(self,3)
self.storyTx=UIText.get(self,4)
self.storyTx2=UIText.get(self,5)
self.tipsBg=UIObject.get(self,6)
self.tipsTx=UIText.get(self,7)

self.funcRoot:setButtonClick(function()self:onFuncRoot()end)



end


function UICJXYChapterContentWin4:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.funcRoot);self.funcRoot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end















local _this=nil
local _funcCmp={
widget=-1,
model=0,
tips=1,
name=2,
}



function UICJXYChapterContentWin4:onLoaded(...)
self:bindComponents()
_this=self

self._onClickItem=function(...)
self:onClickItem(...)
end

self:addProNotify(39,2,self.on_39_2)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function UICJXYChapterContentWin4:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterContentWin4:onShow(argtable,afterOnloaded)
self.handleType=argtable.handleType
self.stageIdx=argtable.stageIdx
self.stage=seasonModel:getStage(self.handleType,self.stageIdx)

self:initView()
end


function UICJXYChapterContentWin4:onHide()

end




function UICJXYChapterContentWin4:onFuncRoot()
local open_func=seasonModel:getStageConfigEx(self.handleType,self.stageIdx,"winArgs","open_func")
local args={
configs=open_func,
parentWin=self,
}
self:showWindow("UICJXYChapterOpenSystemWin",args)
end

function UICJXYChapterContentWin4:onClickItem(...)
if self.stage and self.stage:isOverEnd()and self.stage:checkOpen()and self.stage.flag==0 then
seasonController:send_39_2(self.handleType,self.stageIdx,2)
return
end

itemsComponentHelper.onItemClickEx(...)
end

function UICJXYChapterContentWin4:initView()
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

local rewards=config.reward
local getted=self.stage and self.stage.flag==1 or false
local reddot=self.stage and self.stage:isOverEnd()and self.stage:checkOpen()and self.stage.flag==0 or false

self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemid=data[1]
local itemnum=data[2]
local showCountBG=itemnum>1
local countStr=showCountBG and mathHelper.formatNumber(itemnum)or""
local conf={itemid=itemid,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,self._onClickItem)
item:SetChildActive(1,reddot)
item:SetChildActive(2,getted)
end)
self.rewardView:setChildScrollRectEnable(#rewards>4)

local descStr=winArgs.descStr
local width=self.storyTx2:getChildSizeDeltaX()
local job=self.storyTx2:getGameObject()
local str=comHelper.getCheckLayoutStr(job,width,descStr)
self.storyTx:setText(str)

self:refreshTips()
end

function UICJXYChapterContentWin4:refreshTips()
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
local tipsStr=self.stage:getConfig("winArgs","tipsStr")
self.tipsTx:setText(tipsStr)
self.tipsBg:setActive(true)
end
else
self.tipsBg:setActive(true)
if self.stageIdx>1 then
local preCfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx-1)
local tispStr=FMT.fmt("<color=#ca631d>完成第{0}章·{1}后解锁本章节</color>",mathHelper.numberToChinese(self.stageIdx-1),preCfg.name)
self.tipsTx:setText(tispStr)
else
self.tipsTx:setText("本章未开启")
end
end
self:stopCDTick()
end

function UICJXYChapterContentWin4:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICJXYChapterContentWin4:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICJXYChapterContentWin4:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local endTime=self.tipsTime
if nowTime<endTime then
if self.tipsContent then
local timeStr=FMT.fmt(self.tipsContent,timeHelper.format_time_stamp3(endTime-nowTime))
self.tipsTx:setText(timeStr)
end
else
self:refreshTips()
self:refreshRewardFlag()
end
end

function UICJXYChapterContentWin4:refreshRewardFlag()
local rewardItems=self.rewardList:getChildLayoutGroupGridList()
local getted=self.stage and self.stage.flag==1 or false
local reddot=self.stage and self.stage:isOverEnd()and self.stage:checkOpen()and self.stage.flag==0 or false
for i=1,rewardItems.Count do
local item=rewardItems[i-1]
item:SetChildActive(1,reddot)
item:SetChildActive(2,getted)
end
end

function UICJXYChapterContentWin4:refreshView()
self:refreshTips()
self:refreshRewardFlag()
end

function UICJXYChapterContentWin4.onSeasonChange()
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end

function UICJXYChapterContentWin4.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then
if param1==2 then
_this:refreshRewardFlag()
end
end
end

function UICJXYChapterContentWin4.onSeasonStageChange(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx then
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end
end

function UICJXYChapterContentWin4.onSeasonStageDataChange(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx then
_this.stage=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshView()
end
end
