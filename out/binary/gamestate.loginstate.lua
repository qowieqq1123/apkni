






loginState=appLifecycle({name='loginState'})

local _ApplicationStateController=CS.ApplicationStateController


function loginState:enter(mode,...)
_ApplicationStateController.ChangeState(eApplicationState.eLogin)
loginControl.overrideUploadLogFunction()
luaBuildLightMap:init()
shaderHelper.init()
if webGLHelper:isSkipLogin()then
self:handleSkipLogin()
else
loginControl:showLoginWin()
end
systemTipsManager:showWindow()

local stats=GameObject.Find("Stats Monitor")
if stats and stats.activeSelf then
stats:SetActive(false)
end
downAssetManager:init()


loginState:clearCacheDirectory()
resourceUtility.releaseAll()
resourceUtility.releaseUIModelCache()
resourceUtility.clearAllCache(false)
resourceUtility.clearPoolCache()





if(appUtils.enableDebug or appUtils.showErrLog)
and not deviceHelper.isRunEditor()then
UIManager:showWindow('UIDownloadButtonWin')
end
end

function loginState:clearCacheDirectory()
fileHelper.deleteDirectory(fileHelper.getFullPath('photo'))
end

function loginState:handleSkipLogin()
gameHelper:setFrameInLoginState()

if webGLHelper:isRunWebGL()then
webGLHelper:downLoadBaseGroup()
end
end

































function loginState:leave()


end

function loginState:print(...)

end

function loginState:onAppStart()
loginControl:onAppStart()
end

function loginState:onAppQuit()




end

function loginState:finish()


UICreateRoleController:closeBeginVideo()
LuaApplication.changeState(gameState)
end

function loginState:closeLoginWin()
if not socketManager.connecting then return end
UIManager:closeWindow("UILogin")
end


function loginState:logout()
if UIManager:findActiveWindow('UIGameBeginVideoWin')and
UIManager:callWindowFunc('UIGameBeginVideoWin','isPlaying')then
UICreateRoleController:backToLogin()
elseif UIManager:findActiveWindow('UILogin')then

else
socketManager:Disconnect()
reconnectState:leave()
LuaApplication.changeState(loginState)
end
loginModel:setOtherLogin(false)
UIManager:closeWindow('UIDownloadLogWin')
end


function loginState:logout_pc()
if UIManager:findActiveWindow('UIGameBeginVideoWin')and
UIManager:callWindowFunc('UIGameBeginVideoWin','isPlaying')then
UICreateRoleController:backToLogin()
elseif UIManager:findActiveWindow('UILogin')then

else
socketManager:Disconnect()
reconnectState:leave()
LuaApplication.changeState(loginState)
end
UIManager:closeWindow('UIDownloadLogWin')
end
