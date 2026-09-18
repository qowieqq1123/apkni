







def_class("UIXianJieSeasonEnter_CJXY",UICloneObject)





UIXianJieSeasonEnter_CJXY.abName=""

UIXianJieSeasonEnter_CJXY.assetName="UIXianJieSeasonEnter_CJXY"


function UIXianJieSeasonEnter_CJXY:bindComponents()

self.icon=UIImage.get(self,0)
self.cdTx=UIText.get(self,1)
self.progressBar=UIProgress.get(self,2)
self.chapterTx=UIText.get(self,3)
self.reddot=UIObject.get(self,4)

end


function UIXianJieSeasonEnter_CJXY:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.chapterTx);self.chapterTx=nil;
_UIObject_release(self.reddot);self.reddot=nil;
end









function UIXianJieSeasonEnter_CJXY:onLoaded(...)
self:bindComponents()

self.widget:SetChildButtonClick(-1,function()
UIFullSeasonControl:openSeasonWindow(self.enterHandle.id)
end)
end


function UIXianJieSeasonEnter_CJXY:__delete()
self:stopSeasonTick()

self:unbindComponents()
end




function UIXianJieSeasonEnter_CJXY:onShow(argtable,afterOnloaded)
local seasonType=argtable.seasonType
self.enterHandle=seasonModel:getHandle(seasonType)

local handleCfg=self.enterHandle:getConfig()
self.icon:setCSImageSprite(handleCfg.icon[1],handleCfg.icon[2])
self:refreshSeasonReddot()
self:refreshSeasonStage()
end


function UIXianJieSeasonEnter_CJXY:onHide()

end




function UIXianJieSeasonEnter_CJXY:refreshSeasonReddot()
local reddot=self.enterHandle:getReddot()
self.reddot:setActive(reddot)
end

function UIXianJieSeasonEnter_CJXY:refreshSeasonStage()
local stages=self.enterHandle:getStages()
local stageNo=#stages
for i,v in ipairs(stages)do
if not v:checkOpen()or not v:isOverEnd()then
stageNo=i
break
end
end
local curStage=stages[stageNo]
local stageCfg=curStage:getConfig()
self.chapterTx:setText(FMT.fmt("第{0}章·{1}",mathHelper.numberToChinese(stageNo),stageCfg.name))

self:refreshSeasonTime(curStage)
end

function UIXianJieSeasonEnter_CJXY:refreshSeasonTime(stage)
if stage==nil then
local stages=self.enterHandle:getStages()
stage=stages[#stages]
for i,v in ipairs(stages)do
if not v:checkOpen()or not v:isOverEnd()then
stage=v
break
end
end
end
local isBegin=stage:isOverBegin()
if isBegin then
self.cdTx:setText("")
self.progressBar:setActive(true)
local progress=stage:getProgress()
self.progressBar:setProgressValue(progress,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}%",progress/100))

self:stopSeasonTick()
else
self.progressBar:setActive(false)
self:startSeasonTick(stage.beginTime)
end
end

function UIXianJieSeasonEnter_CJXY:startSeasonTick(time)
self.seasonTime=time

local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.seasonTime-nowTime

if deltaTime>0 then
self.cdTx:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp3(deltaTime)))
if not self.seasonTick then
self.seasonTick=self:setTimer(1,0,function()
self:updateSeasonTick()
end)
end
else
self.cdTx:setText("未开启")
self:stopSeasonTick()
end
end

function UIXianJieSeasonEnter_CJXY:stopSeasonTick()
self.seasonTime=nil
if self.seasonTick then
self:stopTimerByID(self.seasonTick)
self.seasonTick=nil
end
end

function UIXianJieSeasonEnter_CJXY:updateSeasonTick()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.seasonTime-nowTime
if deltaTime>0 then
self.cdTx:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp3(deltaTime)))
else
self:refreshSeasonTime()
end
end