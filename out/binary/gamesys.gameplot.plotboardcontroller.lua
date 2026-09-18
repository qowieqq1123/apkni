







local _MODULENAME="plotBoardController"
gameState.addListener(def_table(_MODULENAME))
plotBoardController.name=_MODULENAME

function plotBoardController:onAppStart()
end
function plotBoardController:onEnterState()
end
function plotBoardController:onLeaveState()
plotBoardController:clear()
end
function plotBoardController:onPlayerCreate(...)
end
function plotBoardController:onLostConnection()
end

function plotBoardController:createUpdateTimer()
self.updateTimer=timer.new()
local f=function(...)
plotBoardController:onTimerUpdata()
end
self.updateTimer:start(0.01,f,-1)
end

function plotBoardController:clearUpdateTimer()
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
end

function plotBoardController:onTimerUpdata()
if not self.isPlaying then return end

local curTime=Time.realtimeSinceStartup
local lerp=curTime-self.startTime


for i,v in ipairs(self.actionList)do
if v.flag==nil then
local sTime=v.sTime
if lerp>=sTime then
v.flag=true
self:doAction(v.effect)
end
end
end

if self.state==2 then
if self.plotBlackLeaveMark~=nil then
if lerp>=self.plotBlackLeaveMark then
self.plotBlackLeaveMark=nil
UIManager:showWindow('UIPlotBlackLoadWin',{callback=nil,initFunc=nil})
end
end
end

if lerp>=self.life then
local check=false
if self.state==1 then
local win=UIManager:findActiveWindow(self.winName)
check=win==nil
end
if not check then

plotBoardController:clearUpdateTimer()

local cb=self.timeOutBack
if cb~=nil then
cb()
end
self.timeOutBack=nil
end
end
end

function plotBoardController:play(params)
plotBoardController:closeStage()

local groupID=params.groupid
if self.groupID~=nil and self.groupID==groupID then return end
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,groupID)
if groupcfg==nil then



return
end

self.groupID=groupID
self.groupCfg=groupcfg
local skin=groupcfg.skin or 1
self.winName=UIFullStoryBoardControl:getPlotBoardWinName(skin)

local extraStage=params.extraStage
self.extraStage=extraStage
local stageId=groupcfg.screenid
if self.groupCfg.plotBlackInOut~=nil then
local initFunc=function()
plotBoardController:showStage(stageId)
end
local func=function()
plotBoardController:handleEnterAction(params)
end
UIManager:showWindow('UIPlotBlackLoadWin',{callback=func,initFunc=initFunc})
else
local func=function()
plotBoardController:handleEnterAction(params)
end
plotBoardController:showStage(stageId,func)
end
end

local loadIndex
function plotBoardController:showStage(stageId,callback)

loadIndex=0
local loadBack=function()
loadIndex=loadIndex+1
if loadIndex==2 then

plotActionController.hideScreen(plotBoardController.groupCfg.screenhide)
if callback then
callback()
end
end
end


local id=stageId or screenStageType.dialogueAction

self.stage=fightStage:create(id,loadBack)
if stageId then
UIManager:showWindow("UIFightPrepareLoading",{para=1})
timeEventController.delayDo(1,function()
fightManager.setCameraActive(true,fightCameraMode.fight)
end)
end

self.imagePoolList=plotActionController.initIamgePool(self.stage,self.groupCfg.imagePool or{},loadBack)
end

function plotBoardController:closeStage(groupID)
local needClear=false
if self.groupID~=nil and(groupID==nil or groupID==self.groupID)then
needClear=true
end
if needClear then

plotActionController.doShowScreen()
plotBoardController:clear()
end
end

function plotBoardController:handleEnterAction(params)
local isFullOpen=true
if params.isFullOpen~=nil then
isFullOpen=params.isFullOpen
end
if self.groupCfg.enterEffectList~=nil then

self.actionList=plotActionController.initActionList(self.groupCfg.enterEffectList)

self.isPlaying=true
self.startTime=Time.realtimeSinceStartup
local time=self.groupCfg.enterLife or 1000
self.life=time/1000

self.state=1
plotBoardController:createUpdateTimer()
self.timeOutBack=function()
self:onEnterBack()
end

params.isReady=false
UIFullStoryBoardControl:showPlotBoardWindow(params,isFullOpen)
else
params.isReady=true
UIFullStoryBoardControl:showPlotBoardWindow(params,isFullOpen)
end
end

function plotBoardController:onEnterBack()
self:init()
UIManager:invokeUIMethod(self.winName,'setReady',true)
end

function plotBoardController:handleLeaveAction()
if self.groupCfg==nil then
self:onLeaveBack()
return
end
if self.groupCfg.leaveEffectList~=nil then

self.actionList=plotActionController.initActionList(self.groupCfg.leaveEffectList)

self.isPlaying=true
self.startTime=Time.realtimeSinceStartup
local time=self.groupCfg.leaveLife or 1000
self.life=time/1000
if self.groupCfg.plotBlackInOut~=nil then
self.plotBlackLeaveMark=self.life
self.life=self.life+plotActionController.plotBlackInTime
end

self.state=2
plotBoardController:createUpdateTimer()
self.timeOutBack=function()
self:onLeaveBack()
end

UIManager:invokeUIMethod(self.winName,'setReady',false)
else
if self.groupCfg.plotBlackInOut~=nil then
local initFunc=function()
self:onLeaveBack()
end
UIManager:showWindow('UIPlotBlackLoadWin',{callback=nil,initFunc=initFunc})
else
self:onLeaveBack()
end
end
end

function plotBoardController:onLeaveBack()
self.plotBlackLeaveMark=nil
UIManager:invokeUIMethod(self.winName,'onLeave')
end

function plotBoardController:doAction(effect)
if self.imagePoolList==nil then return end
local imageData=self.imagePoolList[effect[1]]
local actionID=effect[2]
plotActionController.doAcitionComom(self.stage,imageData,actionID,effect[3],effect[4])
end

function plotBoardController:killAction(effect)
if self.imagePoolList==nil then return end
local imageData=self.imagePoolList[effect[1]]
local actionID=effect[2]
plotActionController.killAcitionComom(self.stage,imageData,actionID,effect[3],effect[4])
end

function plotBoardController:findPoolImage(index)
if self.imagePoolList==nil then return nil end
return self.imagePoolList[index]
end

function plotBoardController:init()
if self.isPlaying==true then
self.isPlaying=nil
self.actionList=nil
self.startTime=nil
self.life=nil
self.plotBlackLeaveMark=nil
end
end

function plotBoardController:clear()
if self.imagePoolList~=nil then
plotActionController.clearImagePool(self.imagePoolList)
self.imagePoolList=nil
end

if self.stage~=nil then
self.stage:close(self.extraStage)
self.stage=nil
end

plotBoardController:clearUpdateTimer()
self.groupID=nil
self.groupcfg=nil
self.timeOutBack=nil
self:init()
end
