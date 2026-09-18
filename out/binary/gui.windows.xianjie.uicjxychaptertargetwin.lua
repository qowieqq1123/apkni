







def_class("UICJXYChapterTargetWin",UIWindowBase)









function UICJXYChapterTargetWin:bindComponents()

self.contentImg=UIImage.get(self,0)
self.startBtn=UIButton.get(self,1)
self.story=UIButton.get(self,2)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.story:setButtonClick(function()self:onStory()end)



end


function UICJXYChapterTargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentImg);self.contentImg=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.story);self.story=nil;
end















local _this=nil
local _storyCmp={
clickTips=0,
maskImg=1,
desc=2,
desc2=3,
mask=4,
}
local _speed=50



function UICJXYChapterTargetWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self.storyWidget=self.story:getChildWidgetBase()
end


function UICJXYChapterTargetWin:__delete()
self:unbindComponents()
_this=nil
self:killStoryTween()
self:stopCDTick()
end




function UICJXYChapterTargetWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.childWinName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winArgs","content_window")
self:refreshView()
end


function UICJXYChapterTargetWin:onHide()

end




function UICJXYChapterTargetWin:onStartBtn()
local stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
if stageCfg.storyTree then
seasonController:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,2)

UIFullSeasonControl:closeUI(true,true)

local storyTree=stageCfg.storyTree
local screenParams=storyTree[1]
local targetParams=storyTree[2]
local treeName=storyTree[3]
local callback=function()
storyAICommonManager:startStoryBehavior(treeName)
end
cameraMoveController:Begin(screenParams,targetParams,callback)

elseif stageCfg.winArgs and stageCfg.winArgs.storyStr then
seasonController:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,1)
self:refreshView()
else
seasonController:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,2)
UIFullSeasonControl:closeUI(true,true)
end
end


function UICJXYChapterTargetWin:onStory()
if self.storyTweener and self.storyTweener:IsActive()then
self.storyTweener:Kill(true)
return
end

seasonController:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,2)

if self.stage and self.stage.onStoryComplete then
self.stage:onStoryComplete()
end

self:refreshView()
end

function UICJXYChapterTargetWin:refreshView()
local state=self.stage and self.stage:isOverBegin()and self.stage:checkOpen()and seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)or-1
self:killStoryTween()
if state==0 then
self.contentImg:setActive(true)
self.startBtn:setActive(true)
self.story:setActive(false)
self:closeWindow(self.childWinName)
weakGuideController:beginGuide(1331)
elseif state==1 then
self.contentImg:setActive(true)
self.startBtn:setActive(false)
self.story:setActive(true)
self:closeWindow(self.childWinName)
self:showStory()
else
self.contentImg:setActive(false)
self.startBtn:setActive(false)
self.story:setActive(false)
self:showWindow(self.childWinName,self.showParams)
end

if state==-1 and self.stage and self.stage:checkOpen()then
self:startCDTick(self.stage.beginTime)
else
self:stopCDTick()
end
end

function UICJXYChapterTargetWin:showStory()
self.storyWidget:SetChildActive(_storyCmp.clickTips,false)

local storyStr=self.stage:getConfig("winArgs","storyStr")
local textWidth=self.storyWidget:GetChildSizeDeltaX(_storyCmp.desc2)
storyStr=comHelper.getCheckLayoutStr(self.storyWidget:GetChildGameObject(_storyCmp.desc2),textWidth,storyStr)
self.storyWidget:SetChildText(_storyCmp.desc,storyStr)
self.storyWidget:ForceLayoutRect(_storyCmp.desc)

local height=self.storyWidget:GetChildSizeDeltaY(_storyCmp.desc)
local w=self.storyWidget:GetChildSizeDeltaX(_storyCmp.mask)
local h=self.storyWidget:GetChildSizeDeltaY(_storyCmp.mask)
self.storyWidget:SetChildSizeDelta(_storyCmp.maskImg,w,h/2-height/2)
self.storyTweener=self.storyWidget:SetChildDOSizeDelta(_storyCmp.maskImg,Vector2.New(w,h/2+height/2+35),(height+35)/_speed,function()
self.storyWidget:SetChildActive(_storyCmp.clickTips,true)
end)
self.storyTweener:SetEase(DG.Tweening.Ease.Linear)
end

function UICJXYChapterTargetWin:killStoryTween()
if self.storyTweener and self.storyTweener:IsActive()then
self.storyTweener:Kill(false)
self.storyTweener=nil
end
end

function UICJXYChapterTargetWin:startCDTick(time)
if not self.cdTick then
self.cdTime=time
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICJXYChapterTargetWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICJXYChapterTargetWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.cdTime then
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self:refreshView()
end
end

function UICJXYChapterTargetWin.onSeasonChange()
if _this.isVisible then
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshView()
end
end

function UICJXYChapterTargetWin.onSeasonStageChange(season_id,chapter_idx)
if _this.isVisible and _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx then
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshView()
end
end