






local _MODULENAME="MiniGameController"

gameState.addListener(def_table(_MODULENAME))
MiniGameController.name=_MODULENAME
MiniGameController.data={}

function MiniGameController:onAppStart()

MiniGameModel:onAppStart()







local sceneData={
enter=function(o,...)
MiniGameController:onEnterMiniGame()
end,

leave=function(o,...)
MiniGameController:onLeaveMiniGame()
end,
load=function(o,...)
MiniGameController:onLoadScene(...)
end,
}
mainControl:regSceneTypo(eSceneType.eMiniGame,sceneData)
end



MiniGameType=
{
close="0",
open="1",
}

local _isEnter=false
local gameid=1

local gameIcon=
{
[1]='button_hdrk_0098',
}


local sceneId_Mapping=
{
[1]=SCENE_TYPE.MiniGame,
}


local ReddotOne

function MiniGameController:onEnterState(isReconnect)
MiniGameModel:onEnterState()
end


function MiniGameController:onProtocolReq()
MiniGameModel:onProtocolReq()

if houtaiModel:isOpenMiniGame()then





MiniGameController:showMiniGameEnter()
end
end

function MiniGameController:showMiniGameEnter()
gameid=tonumber(gameid)
local _iconname=gameIcon[gameid]or gameIcon[1]
local cfg=cfg_faxingminiganmeconfig_get(gameid)
if cfg and cfg.icon then
_iconname=cfg.icon
end
platformSDK.printSDK("get_MiniGame_ID",gameid,_iconname)
MiniGameController:InitShowFinalFantasy()
self.guid=enterManager:freshEnter({id=gameid,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eMiniGame,iconname=_iconname,
getReddotFun=function()
return MiniGameController:checkGameOneFirstReddot()
end})
end


function MiniGameController:onLeaveState(isReconnect)
MiniGameModel:onLeaveState(isReconnect)

self.data={}
end


function MiniGameController:onLostConnection()

end


function MiniGameController:onReConnection(isInitPro)

if _isEnter then
mainControl:enterHome()
end
end






function MiniGameController:checkGameOneFirstReddot()
if ReddotOne==nil then
ReddotOne=userActorSetting.get('MiniGameOneReddot',true)
end
return ReddotOne
end


function MiniGameController:setGameOneFirstReddot()
if ReddotOne then
userActorSetting.set('MiniGameOneReddot',false)
userActorSetting.flush()
ReddotOne=false
end
end


function MiniGameController:removeEnterIcon()
if self.guid then
enterManager:removeEnter(self.guid)
self.guid=nil
end
end


function MiniGameController:onLoadScene(sceneId)
sceneControl:startLoading({sceneId=sceneId,closeLoading=false})
self.sceneId=sceneId
end


function MiniGameController:onEnterMiniGame(isReconnect)
if _isEnter then return end
_isEnter=true
MiniGameController:setGameOneFirstReddot()
mainViewsControl:changeMain(true)
sceneControl:closeLoading(1,function()

if _isEnter then
MiniGameController.setMiniGameVolume(0)
UIManager:showWindow('UI_MiniGame_BackWin')
end
end)

UIManager.disableAllTips()
buildlightController:setBLState(false)
end

function MiniGameController:onLeaveMiniGame(isReconnect)
if not _isEnter then return end
_isEnter=nil
MiniGameController.setMiniGameVolume(1)
UIManager.enableAllTips()
buildlightController:setBLState(true)
end




function MiniGameController:enterMiniGame(args,enterCall,preCheckRecord)
local sceneType=args[1]
local ret,errType=downAssetManager:needDownLoadScene(sceneType)
if ret then return false end
local preCheckResult=changeSceneConfig.changeScenePreCheck(preCheckRecord,eSceneType.eMiniGame,args,enterCall,MiniGameController.enterMiniGame)
if not preCheckResult then
return false
end
mainControl:reqEnterMap2(eSceneType.eMiniGame,args,enterCall)
return true
end



function MiniGameController:enterMiniGame_I(gameID)
local sceneId=sceneId_Mapping[gameID]or sceneId_Mapping[1]
local enterCallBack=function()

end
MiniGameController:enterMiniGame({sceneId},enterCallBack)
end



function MiniGameController:InitShowFinalFantasy()
if api_Available_InitShowFinalFantasy()then
local isWx=webGLHelper:isRunWeiXin()
local loginSDKParams=loginModel.loginSDKParams
local uid=loginSDKParams.uid
local token=loginSDKParams.token
local actID=playerModel:getActorID()or''
platformSDK.printSDK("InitShowFinalFantasy",isWx,gameid,uid,tostring(actID),token)
CS.GameInterface.InitShowFinalFantasy(self.onInitShowFinalFantasy,isWx,gameid,uid,tostring(actID),token,tostring(loginModel.server_id))
end
end



function MiniGameController.onInitShowFinalFantasy(name,gameid)

platformSDK.printSDK("onInitShowFinalFantasy",name,gameid)
end



function MiniGameController.OnMiniGmaeType(typeName)
platformSDK.printSDK("OnMiniGmaeType",typeName)
if typeName==MiniGameType.close then
UIManager:closeWindow('UI_MiniGame_BackWin')
else
UIManager:showWindow('UI_MiniGame_BackWin')
end
end

function MiniGameController.setMiniGameVolume(floatValue)
AudioManager.setSoundEffectVolume(floatValue)
AudioManager.setBgMusicVolume(floatValue)
end




function MiniGameController.OnLoginMiniGmaeType(typeName)
if typeName==MiniGameType.close then
UIManager:closeWindow("UIDouYinMiniGameWin")
platformSDK:reqLogin()
end
end
