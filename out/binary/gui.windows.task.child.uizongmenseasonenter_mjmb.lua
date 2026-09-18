







def_class("UIZongMenSeasonEnter_MJMB",UICloneObject)





UIZongMenSeasonEnter_MJMB.abName="ui/windows/task/child/uizongmenseasonenter_mjmb.ab"

UIZongMenSeasonEnter_MJMB.assetName="UIZongMenSeasonEnter_MJMB"


function UIZongMenSeasonEnter_MJMB:bindComponents()

self.icon=UIImage.get(self,0)
self.cdTx=UIText.get(self,1)
self.progressBar=UIProgress.get(self,2)
self.chapterTx=UIText.get(self,3)
self.reddot=UIObject.get(self,4)
self.bg=UIImage.get(self,5)
self.progressInfo=UIText.get(self,6)
self.progressInfo2=UIText.get(self,7)

end


function UIZongMenSeasonEnter_MJMB:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.chapterTx);self.chapterTx=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.progressInfo);self.progressInfo=nil;
_UIObject_release(self.progressInfo2);self.progressInfo2=nil;
end







local _this=nil


function UIZongMenSeasonEnter_MJMB:onLoaded(...)
self:bindComponents()
_this=self




self.widget:SetChildButtonClick(-1,function()


local seasonType=xianjieModel:getMoJieEnterConfig("csid")
local stageIndex=_this.enterHandle:getCurStageIdx()
if seasonController:checkSeasonStageOpenButNotBegined(seasonType,stageIndex)then
if seasonController:checkSeasonStageEnded(seasonType,stageIndex-1)then
local behavier=seasonModel:getStageConfigEx(seasonType,stageIndex,"enterSceneGuide2")
if behavier and seasonModel:checkOtherAnim(behavier)then

local type=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(type,{triggerMojieSeasonStageBehavier=true})
return
end
end
end


local startCallback=function()

UIFullSeasonControl:openSeasonWindow(self.enterHandle.id)

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=nil})


end)

local _onXianMengChange=function()
self:refresh()
end
self:addNotify(notifyConfig.onXianMengChange,_onXianMengChange)

local _onXianJieMoJunHpChange=function()
self:refresh()
end
self:addNotify(notifyConfig.onXianJieMoJunHpChange,_onXianJieMoJunHpChange)
end


function UIZongMenSeasonEnter_MJMB:__delete()
self:stopSeasonTick()
_this=nil
self:unbindComponents()
end




function UIZongMenSeasonEnter_MJMB:onShow(argtable,afterOnloaded)
local seasonType=argtable.seasonType
self.enterHandle=seasonModel:getHandle(seasonType)
self.stageHandle=self.enterHandle:getCurStageHandle()

local stageCfg=self.stageHandle:getConfig()
self.icon:setCSImageSprite(stageCfg.icon[1],stageCfg.icon[2])
self.bg:setCSImageSprite(stageCfg.bg[1],stageCfg.bg[2])

self:refresh()
end


function UIZongMenSeasonEnter_MJMB:onHide()
self:stopSeasonTick()
end

function UIZongMenSeasonEnter_MJMB:refresh()
self:refreshSeasonReddot()
self:refreshSeasonStage()
end




function UIZongMenSeasonEnter_MJMB:refreshSeasonReddot()
local reddot=self.enterHandle:getReddot()
self.reddot:setActive(reddot)
end

function UIZongMenSeasonEnter_MJMB:refreshSeasonStage()
local stageNo=self.enterHandle:getCurStageIdx()
local stageCfg=self.stageHandle:getConfig()
self.chapterTx:setText(FMT.fmt("第{0}章·{1}",mathHelper.numberToChinese(stageNo),stageCfg.name))

self:refreshSeasonTime()
end

function UIZongMenSeasonEnter_MJMB:refreshSeasonTime()
local stage=self.enterHandle:getCurStageHandle()
local isBegin=stage:isOverBegin()
self:stopSeasonTick()
if isBegin then
self:showStageSpPart()
else
self.progressBar:setActive(false)
self.progressInfo:setActive(false)
self.progressInfo2:setActive(false)
self:showCountDownPart()
self:startSeasonTick(stage.beginTime)
end
end

function UIZongMenSeasonEnter_MJMB:showStageSpPart()
if not xianmengModel:hasXM()then
self.cdTx:setText('暂未加入仙盟')
self.progressBar:setActive(false)
self.cdTx:setActive(true)
return
end

local spProgressCur,spProgressMax=self.stageHandle:getProgress()

local isShowSp1=spProgressCur~=nil and spProgressMax~=nil

local spProgressDesc=self.stageHandle:getConfig('spProgressDesc')

local isShowProgressInfoType=0

local spProgressDescUnit=""

local mutipleEnterInfo=self.stageHandle:getConfig("mutipleEnterInfo")
if mutipleEnterInfo then
local state=self.stageHandle:getStageState()
if state>0 and mutipleEnterInfo[state]then
spProgressDesc=mutipleEnterInfo[state][1]or""
spProgressDescUnit=mutipleEnterInfo[state][2]or""
end
end

self.progressBar:setActive(isShowSp1)
self.cdTx:setActive(false)

local progressInfo
if isShowSp1 then
self.progressBar:setProgressValue(spProgressCur,spProgressMax)
local val=spProgressCur/spProgressMax
val=val>0 and val<=0.01 and 0.01 or mathHelper.safe_floor(val*10000)/100
self.progressBar:setChildProgressText(FMT.fmt("{0}%",val))
progressInfo=self.progressInfo
isShowProgressInfoType=1
else
if spProgressCur>=0 then
spProgressDesc=FMT.fmt("{0}：{1}{2}",spProgressDesc,spProgressCur,spProgressDescUnit)
else
spProgressDesc=self.stageHandle:getConfig('spProgressDefaultDesc')
end
progressInfo=self.progressInfo2
isShowProgressInfoType=2
end


local finishStageEnterDesc=self.stageHandle:getConfig('finishStageEnterDesc')
if self.stageHandle:isFinish()and finishStageEnterDesc~=nil then
spProgressDesc=finishStageEnterDesc

progressInfo=self.progressInfo2
isShowProgressInfoType=2
end

progressInfo:setText(spProgressDesc)

self.progressInfo:setActive(isShowProgressInfoType==1)
self.progressInfo2:setActive(isShowProgressInfoType==2)
end

function UIZongMenSeasonEnter_MJMB:showCountDownPart()
self.progressBar:setActive(false)
self.progressInfo:setActive(false)
end

function UIZongMenSeasonEnter_MJMB:startSeasonTick(time)
if time==0 then return end
self:stopSeasonTick()

self.seasonTime=time
self.seasonTick=self:setTimer(1,0,function()
self:updateSeasonTick()
end)


self:updateSeasonTick()
self.cdTx:setActive(true)
end

function UIZongMenSeasonEnter_MJMB:stopSeasonTick()
if self.seasonTick then
self.isStopping=true
self:stopTimerByID(self.seasonTick)
self.seasonTime=nil
self.seasonTick=nil
self.isStopping=false
end
end

function UIZongMenSeasonEnter_MJMB:updateSeasonTick()
if self.isStopping then return end

local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.seasonTime-nowTime
if deltaTime>0 then
self.cdTx:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp3(deltaTime)))
else
self:stopSeasonTick()
self:refreshSeasonTime()
end
end
