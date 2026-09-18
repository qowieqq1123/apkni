







gameplotController=gameState.addListener({})








local _story_handle={
[eGameplotStoryType.eBoard]="showPlotBoard",
[eGameplotStoryType.eComic]="showManHua",
[eGameplotStoryType.eVideo]="showMovie",
[eGameplotStoryType.eBoard2]="showPlotBoard2",
[eGameplotStoryType.eAction]="showAction",
[eGameplotStoryType.eBoard3]="showPlotBoard3",
}

function gameplotController:onAppStart()
notifySystem:listenNotify(notifyConfig.onDiscipleAwake,self.onDiscipleAwake)
end

function gameplotController:onEnterState()

end

function gameplotController:onLeaveState()
gameplotModel:clearData()
gameplotModel:clearDiscipleChange()
end

function gameplotController:onPlayerCreate(...)

end

function gameplotController:onLostConnection()

end

function gameplotController:showGamePlot(plotType,params)
if _story_handle[plotType]then
self[_story_handle[plotType]](self,params)
end
end

function gameplotController.onDiscipleAwake(guid,oldData)
local newData=UIDiscipleModel:getDiscipleData(guid)
gameplotModel:pushDiscipleChange(guid,oldData,newData)
end












function gameplotController:showPlotBoard(params)
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,params.groupid)
if groupcfg==nil then



return
end

local isFullOpen=true
if params.isFullOpen~=nil then
isFullOpen=params.isFullOpen
end
if groupcfg.imagePool~=nil then

plotBoardController:play(params)
else
UIFullStoryBoardControl:showPlotBoardWindow(params,isFullOpen)
end
end







function gameplotController:showPlotBoard2(params,isFullOpen)
UIFullStoryBoardControl:showPlotBoardWindow2(params,isFullOpen)
end










function gameplotController:showPlotBoard3(params,isFullOpen)
UIFullStoryBoardControl:showPlotBoardWindow3(params,isFullOpen)
end







function gameplotController:showManHua(params)
UIFullStoryBoardControl:showManHuaWindow(params)
end










function gameplotController:showAction(params,isFullOpen)
if isFullOpen==nil then isFullOpen=true end
plotActionController:play(params,isFullOpen)
end











function gameplotController:showMovie(params)
UIFullStoryBoardControl:showMovieWindow(params)
end

function gameplotController:showPlotBlack(args)
UIManager:showWindow('UIPlotBlackWin',args or{})
end

function gameplotController:closePlotBlack()
UIManager:closeWindow('UIPlotBlackWin')
end

function gameplotController.doDialogueBroadcast(name,broadcast)
if broadcast==nil then return end
for i,v in ipairs(broadcast)do
local castType=v[1]
local param1=v[2]
notifySystem:postNotify(notifyConfig.onDialogueBroadcast,name,castType,param1)
end
end


function gameplotController.activePlot(params,notFullScreen)
local activeType=params[1]
local param1=params[2]
local sceneType=mainControl:getSceneType()


if not notFullScreen and fullScreenUI.isActiveFull()then

fullScreenUI.closeActiveUI()
end

if activeType==1 then

if sceneType==eSceneType.eZongmen then
local callback=params[3]
storyAIManager:startStoryBehavior(param1,nil,callback)
return true
end
elseif activeType==2 then

if sceneType==eSceneType.eZongmen then
UIFullStoryBoardControl:showPlotBoardWindow({groupid=param1},false)
return true
end
elseif activeType==3 then

if sceneType==eSceneType.eWorld then
local callback=params[3]
worldStoryAIManager:startStoryBehavior(param1,nil,callback)
return true
end
elseif activeType==4 then

if sceneType==eSceneType.eXianJie then
local callback=params[3]
xianjieStoryAIManager:startStoryBehavior(param1,nil,callback)
return true
end
elseif activeType==5 then

if sceneType==eSceneType.eXianJie then
UIFullStoryBoardControl:showPlotBoardWindow({groupid=param1},false)
return true
end
end
return false
end
