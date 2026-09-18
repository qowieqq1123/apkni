







def_class("UIMJMBChapterTargetWin",UIWindowBase)









function UIMJMBChapterTargetWin:bindComponents()

self.contentImg=UIImage.get(self,0)
self.openLeft=UIText.get(self,1)
self.openLeftRoot=UIObject.get(self,2)
self.remindJumpBtn=UIButton.get(self,3)
self.remindRoot=UIObject.get(self,4)
self.remindTxt=UILinkImageText.get(self,5)
self.startBtn=UIButton.get(self,6)
self.story=UIButton.get(self,7)

self.remindJumpBtn:setButtonClick(function()self:onRemindJumpBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.story:setButtonClick(function()self:onStory()end)



end


function UIMJMBChapterTargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentImg);self.contentImg=nil;
_UIObject_release(self.openLeft);self.openLeft=nil;
_UIObject_release(self.openLeftRoot);self.openLeftRoot=nil;
_UIObject_release(self.remindJumpBtn);self.remindJumpBtn=nil;
_UIObject_release(self.remindRoot);self.remindRoot=nil;
_UIObject_release(self.remindTxt);self.remindTxt=nil;
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



function UIMJMBChapterTargetWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self.storyWidget=self.story:getChildWidgetBase()
end


function UIMJMBChapterTargetWin:__delete()
self:unbindComponents()
_this=nil
self:killStoryTween()
self:stopCDTick()
end




function UIMJMBChapterTargetWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.childWinName=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"winArgs","content_window")
self:refreshView()
end


function UIMJMBChapterTargetWin:onHide()

end




function UIMJMBChapterTargetWin:onStartBtn()
if not self.stage:isOverBegin()then
local curTime=timeHelper.getServerShortTime()
local left=self.stage.beginTime-curTime
UIManager.info(FMT.fmt("{0}后开启",timeHelper.format_time_stamp4(left)))
return
end


local callback=function()
local stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
if stageCfg.storyTree then
seasonModel:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,2)

local storyTree=stageCfg.storyTree
local screenParams=storyTree[1]
local targetParams=storyTree[2]
local treeName=storyTree[3]
local callback=function()
if mainControl:isSceneLoaded(eSceneType.eXianJie)then
xianjieStoryAIManager:startStoryBehavior(treeName)
end
end

local isPlayed=not seasonModel:checkOtherAnim(treeName)
if isPlayed then
self:refreshView()
return
end
UIFullSeasonControl:closeUI(true,true)

seasonModel:markOtherAnim(treeName)
cameraMoveController:Begin(screenParams,targetParams,callback)

elseif stageCfg.winArgs and stageCfg.winArgs.storyStr then
seasonModel:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,1)
self:refreshView()
else
seasonModel:markOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx,2)
UIFullSeasonControl:closeUI(true,true)
end
end

UIManager:invokeUIMethod("UIMoJieStageAimMainWin","openFrameBg")
self.startBtn:setActive(false)
self:delayDo(3,function()
callback()
end)
end


function UIMJMBChapterTargetWin:onStory()
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

function UIMJMBChapterTargetWin:refreshView()
local state=self.stage and(self.stage:isOverBegin()or self.stage:isUnlock())and self.stage:checkOpen()and(not self.stage:isOverEnd())and seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)or-1
self:killStoryTween()
if state==0 then
self.contentImg:setActive(true)
self.startBtn:setActive(true)
self.story:setActive(false)
self:closeWindow(self.childWinName)
UIManager:invokeUIMethod("UIMoJieStageAimMainWin","refreshFrameBg")
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

local isShowLeft=state==0 and self.stage and not self.stage:isOverBegin()
self.openLeftRoot:setActive(isShowLeft)
if isShowLeft then
self:startCDTick(self.stage.beginTime)
else
self:stopCDTick()
end

local remindInfo=self.stage:getConfig("remindInfo")
local isShowRemind=isShowLeft and remindInfo~=nil
self.remindRoot:setActive(isShowRemind)
if isShowRemind then
self:refreshRemind()
end
end

function UIMJMBChapterTargetWin:showStory()
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

function UIMJMBChapterTargetWin:killStoryTween()
if self.storyTweener and self.storyTweener:IsActive()then
self.storyTweener:Kill(false)
self.storyTweener=nil
end
end

function UIMJMBChapterTargetWin:startCDTick(time)
if not self.cdTick then
self.cdTime=time
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
self:updateCDTick()
end
end

function UIMJMBChapterTargetWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIMJMBChapterTargetWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.cdTime then
self.openLeftRoot:setActive(false)
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self:refreshView()
else
local isShowLeft=self.stage and not self.stage:isOverBegin()
self.openLeftRoot:setActive(isShowLeft)
if isShowLeft then
local curTime=timeHelper.getServerShortTime()
local left=self.stage.beginTime-curTime
self.openLeft:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp4(left)))
end
end
end

function UIMJMBChapterTargetWin.onSeasonChange()
if _this.isVisible then
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshView()
end
end

function UIMJMBChapterTargetWin.onSeasonStageChange(season_id,chapter_idx)
if _this.isVisible and _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx then
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshView()
end
end

function UIMJMBChapterTargetWin:refreshRemind()
local remindInfo=self.stage:getConfig("remindInfo")

self.remindTxt:setText(FMT.fmt("推荐：<a;{0};1;1;21;/>",remindInfo.desc))
end

function UIMJMBChapterTargetWin:onRemindJumpBtn()
local remindInfo=self.stage:getConfig("remindInfo")
if remindInfo and remindInfo.jumpArgs then
jumpManager:jump(remindInfo.jumpArgs)
end

if remindInfo and remindInfo.ruleId then
local args={
ruleGroupID=remindInfo.ruleId
}
self:showWindow('UIRuleTipsImage2Win',args)
end
end
