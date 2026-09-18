mainViewsControl=gameState.addListener({})

local _lastMainType=nil
local _isOpened=nil
local _isOpen=nil
local _controls={}

function mainViewsControl:onAppStart()
end

function mainViewsControl:onEnterState(isReconnect)
if not isReconnet then
mainViewsControl.resetSceneData()
end
end

function mainViewsControl:onProtocolReq()

end

function mainViewsControl:onLeaveState(isReconnect)
_lastMainType=nil
_isOpen=false
if not isReconnect then
_isOpened=nil
mainViewsControl.resetSceneData()
end
end

function mainViewsControl:onLostConnection()

end

function mainViewsControl:onReConnection(isInitPro)

end

function mainViewsControl:onProtocolReq()

end

local check=function(viewConf,sceneType)
if not viewConf.gameplot then
if not gameplotModel:isFinish()then return false end
end
if viewConf.scene and#viewConf.scene>0 then
local isScene=false
for i,v in ipairs(viewConf.scene)do
local _sceneType=v.sceneType
local mapIds=v.mapIds

if _sceneType==sceneType then

isScene=true
if mapIds and#mapIds>0 then
local isMountid=false
for ii,vv in ipairs(mapIds)do
if zongmenControl:isMountid(vv)then
isMountid=true
end
end
if not isMountid then
return false
end
end
end
end
if not isScene then
return false
end
end
if viewConf.check then
if viewConf.check()==false then return false end
end
return true
end

local onOpen=function(sceneType)

for _,v in ipairs(mainViewsConfig.getSortOpenMap())do
local viewConf=v.cfg
local name=v.name
if check(viewConf,sceneType)then
local argstable=viewConf.args and viewConf.args()
UIManager:refresh(name,argstable)
else
UIManager:closeWindow(name)
end
end
end

local onClose=function()
for _,name in ipairs(mainViewsConfig.getCloseMap())do
UIManager:closeWindow(name)
end
for _,name in ipairs(mainViewsConfig.getHideMap())do
UIManager:hideWindow(name)
end
end

function mainViewsControl.isOpen()
return _isOpen
end


function mainViewsControl:changeMain(flag)
if UIManager.isCloseing then return end
if not socketManager.connecting then return end
if flag and fullScreenUI.isActiveFull()then
loggerUtil.log('没有关闭全屏，无法打开主界面')
return
end
local hasView=false
local mainCfg=nil
local mainType=nil
local enoughArray={}
for k,v in pairs(mainViewsConfig.getAllMainTypeCfg())do
if v.check()then
mainCfg=v
mainType=k
hasView=true
enoughArray[#enoughArray+1]=k
end



if hasView then
break
end
end






if mainCfg==nil then



if mainControl:isSceneType(eSceneType.eZongmen)then
mainType=MAIN_VIEW_TYPE.eZongMenZhuFeng
mainCfg=mainViewsConfig.getMainTypeCfg(mainType)
elseif mainControl:isSceneType(eSceneType.eWorld)then
mainType=MAIN_VIEW_TYPE.eWorld
mainCfg=mainViewsConfig.getMainTypeCfg(mainType)
elseif mainControl:isSceneType(eSceneType.eXianJie)then
mainType=MAIN_VIEW_TYPE.eXianJie
mainCfg=mainViewsConfig.getMainTypeCfg(mainType)
else
loggerUtil.logErrFMT('还是没有找到当前主界面配置')
end
end
local sceneType=mainControl:getSceneType()
mainViewsControl.onChangeMain(sceneType,flag)

local lastType=_lastMainType
if flag then
msgWinControl.markLock(false)
jumpManager:clearJump()
if lastType==mainType then return end
if lastType then
local mainCfg=mainViewsConfig.getMainTypeCfg(lastType)
mainCfg.close()
end
_lastMainType=mainType
mainCfg.open()
if not _isOpened then
gameState:onOpenView()
end


if deviceHelper.isRunWebGL()then
resourceUtility.clearDelayPoolCache(0.5)
end

_isOpened=true
else
if lastType and lastType~=mainType then
local oldmainCfg=mainViewsConfig.getMainTypeCfg(lastType)
oldmainCfg.close()
else
if mainCfg and lastType==mainType then
if mainCfg.hide then
mainCfg.hide()
else
mainCfg.close()
end
end
end
_lastMainType=nil
end
end

function mainViewsControl.checkLastMainType(value)
return _lastMainType==value
end

function mainViewsControl.onChangeMain(sceneType,flag)
_isOpen=flag
if flag then
onOpen(sceneType)
else
onClose()
end
end



function mainViewsControl.register(control)
_controls[#_controls+1]=control
end

mainViewsControl.register(enterManager)
mainViewsControl.register(limitActivityPreviewControl)

function mainViewsControl.resetSceneData()
for i,v in ipairs(_controls)do
v:resetSceneData()
end
end

function mainViewsControl.onChangeScene(sceneType)
for i,v in ipairs(_controls)do
v:onChangeScene(sceneType)
end
end

function mainViewsControl.onChangeSceneMap(sceneType,mapId)
for i,v in ipairs(_controls)do
v:onChangeSceneMap(sceneType,mapId)
end
end
