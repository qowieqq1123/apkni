








loginControl={}



local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _AppConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;

local _RESULT_MESS_T={
[0]="登录成功",
"密码错误",
"没有这个账号",
"已经在线",
"服务器忙",
"服务器没有开放",
"session服务器有问题，比如db没有连接好",
"不存在这个服务器",
"账户纳入防沉迷",
"帐号被封禁",
"帐号托管中"
}
local _LOGIN_SUCESS_CODE=0


function loginControl:onAppStart()
local showdata=
{
type='UIDialougeHighest',
}
self.logindialog=UIDialogManager.newDialog(showdata)
socketManager:register_receiver(255,1,loginControl.recv_protocol_255_1)
socketManager:register_receiver(255,5,loginControl.recv_protocol_255_5)
socketManager:register_receiver(254,77,loginControl.recv_protocol_254_77)
socketManager:register_receiver(254,82,loginControl.recv_protocol_254_82)
socketManager:register_receiver(254,84,loginControl.recv_protocol_254_84)
socketManager:register_receiver(254,115,loginControl.recv_protocol_254_115)
socketManager:register_receiver(254,116,loginControl.recv_protocol_254_116)
self.isnotice=true
platformSDK:init()
loginModel:init()
end



function loginControl:connect_server(ip,port)
loggerUtil.log('开始连接服务器 ',ip,port)
loginControl.isBuildingConnect=true
socketManager:Connect(ip,port)
loginControl:startConnectTimer()
end

function loginControl:stopConnectTimer()
if self.connectTimer then
self.connectTimer:cancel()
end
self.connectTimer=nil
end


function loginControl:startConnectTimer()
loginControl:stopConnectTimer()
self.connectTimer=timer.new()
self.connectTimer:start(5,function()
self.connectTimer=nil
if not reconnectState.isReconneting then
loggerUtil.log('正在连接服务器：',socketManager.connecting)
if not socketManager.connecting then
socketManager:Disconnect()
UIManager.error('服务器连接超时')
end
end
end,1)
end


function loginControl:isBuildConnect()
if loginControl.isBuildingConnect then
return true
end
return false
end

function loginControl:resetBuildConnectFlag(flag)
loginControl.isBuildingConnect=false
if not flag then
UIManager:callWindowFunc('UILogin','resetReqStatus')
end
end


function loginControl.recv_protocol_255_1(result_code)

local message=_RESULT_MESS_T[result_code]or""
if result_code==_LOGIN_SUCESS_CODE then

loginControl.logined=true
userGlobalSetting.record('userid',loginModel.userid,'')
userGlobalSetting.record('server_ip',loginModel.server_ip_string,'')
loginLocal:set_last_ip(loginModel.server_ip_string)

UICreateRoleController:requreRoleList(loginModel.be_server_id or loginModel.server_id or 0)
logPoint.UploadLog(logPoint.logType.reqLoginGame)

else

if not loginControl.logined then
loginControl.logined=true
logPoint.UploadLog(logPoint.logExtType.connectServerFail,result_code)
end
socketManager:Disconnect()
UIManager.info(message)
if reconnectState.isReconneting then
if result_code==1 then

local errorDialog=socketManager.errorDialog
errorDialog.title='提示'
errorDialog.content='账号异常，返回登录界面'
errorDialog.allowclickBG=true
errorDialog.oktext='确定'
errorDialog.okcallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
errorDialog.canceltext=nil
errorDialog.closecallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
errorDialog:show()
else
local errorDialog=socketManager.errorDialog
errorDialog.title='提示'
errorDialog.allowclickBG=false
errorDialog.content='重新连接服务器失败，请检查网络环境'

errorDialog.oktext='重新连接'
errorDialog.checkOkCallBackRet=true
errorDialog.okcallback=function()
if not sceneControl:isLoadingState()then
reconnectState:tryAgain()
return true
end

return false
end

errorDialog.canceltext='返回登录'
errorDialog.cancelcallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end

errorDialog.closecallback=function()

if reconnectState.isReconneting then
reconnectState:giveupReconnect()
end
loginControl:doLoginOutByDisconnect()
end
errorDialog:show()
end
end
end
platformSDK.printSDK('进入服务器结果：',message)




end



function loginControl.recv_protocol_255_5(result_code)
if result_code==0 then
loginModel.isDelAccount=nil
if reconnectState.isReconneting then
reconnectState:reconnetEnd()
else
loginState:finish()
end
local info=UICreateRoleModel:getRoleInfo()
loginControl:reportLogin(info)
local userID=string.format("%s",tostring(info.id))
CS.GameInterface.SetBuglyUserID(userID)
else

if result_code==1 then
UIManager.error('亲爱的玩家，您的账号已被封禁，请联系客服处理')
reconnectState:stop()
socketManager:Disconnect()
elseif result_code==2 then
UIManager.error('当前账号正在其他设备登录')
reconnectState:stop()
socketManager:Disconnect()
elseif result_code==3 then
reconnectState:stop()
socketManager:Disconnect()
loginControl:showOtherLoginDialogue('尊敬的祖师，您的账号已在其他设备登录过,请重新登录')
elseif result_code==4 then
local switch_time_conf=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"switch_time_conf")
local endHour=switch_time_conf[3]
UIManager.error(string.format('正在转服，无法登陆游戏，请在%d：00后再次尝试',endHour))
reconnectState:stop()
socketManager:Disconnect()
else
if reconnectState.isReconneting then
self:showReconnectFailDialogue()
end
end
end
end


function loginControl.recv_protocol_254_77(id)
if id==1 then
loginModel:setOtherLogin(true)
reconnectState:stop()
socketManager:Disconnect()
loginControl:showOtherLoginDialogue()
elseif id==2 then
updateControl.showForceRestart()
elseif id==3 then
UIUpdateDialog.ShowDialogBox('提示','亲爱的祖师，游戏版本有更新，为避免出现显示异常，建议您退出游戏重新启动。很抱歉给您带来不便，感谢您的谅解。',nil,nil,false)
end
end

function loginControl.recv_protocol_254_82(args)
local cross_sid=args[1]
local len=args[2]
local array=args[3]
local crosslistlen=args[4]
local crossList=args[5]
local pfid=args[6]
loginModel:onRecvAllServerList(cross_sid,len,array)
xianjieModel:initServerData(crosslistlen,crossList)
if crosslistlen==0 then
loginModel:requestServerNames({cross_sid})
else
loginModel:requestServerNames(crossList)
end
gameUtilityModel.setServerPlatform_kf(pfid)
end

function loginControl.recv_protocol_254_84()
loginModel.isDelAccount=true
UIManager:callWindowFunc('UISettingWin','freshLogoutAccountBtn')
UIManager.info('已成功申请注销')


loginControl:doLoginOutByDisconnect()
end

function loginControl.recv_protocol_254_115(len,actlist)
loginModel:onRecvAllBigCrossActList(len,actlist)
notifySystem:postNotify(notifyConfig.onBigCrossActListRecv,len,actlist)
end

function loginControl.recv_protocol_254_116(len,crossIdList)
if len>0 then
local func=function(secFlag)
notifySystem:postNotify(notifyConfig.onRequestPhpServerNamesRecv,secFlag,crossIdList)
end
loginModel:requestServerNames(crossIdList,func)
end
end



function loginControl:loginServer()
loginControl:stopConnectTimer()
loginControl:resetBuildConnectFlag(true)
UIManager:closeWindow("UIWindowDownloadPopup")
loginControl.loginoutFlag=false
local reconnect=0
if reconnectState.isReconneting then
reconnect=1
end
socketManager:send_255_1(loginModel.server_id,loginModel.userid,loginModel.password,reconnect)
end


function loginControl:doLoginout()
local zdCallback=function()
loginState:logout()
end
platformSDK:reqLogout(zdCallback)
end

function loginControl:doLoginoutTimeOut()
local zdCallback=function()
loginState:logout()
end
local win=UIManager:findActiveWindow("UILogin")
if not win then
if deviceHelper.isRunNoneOrEditor()then
zdCallback()
else
reconnectState:leave()
platformSDK:reqLogout(zdCallback)
end
else
loginControl:leaveToLogin()
end
end



function loginControl:doLoginOutByDisconnect()
local zdCallback=function()
loginState:logout()
end
local win=UIManager:findActiveWindow("UILogin")
if not win then
if deviceHelper.isRunNoneOrEditor()then
zdCallback()
else
loginModel:logout(false)
reconnectState:leave()
zdCallback()
end
else
loginControl:leaveToLogin()
end
end

function loginControl:leaveToLogin()
if LuaApplication.state==loginState then
initProControl:onLeaveState()
gameUtilityControl:onLeaveState()
systemProtocolControl:onLeaveState()
serverSaveController:onLeaveState()
homeBuffControl:onLeaveState()
playerController:onLeaveState()
UIDailyPaperController:onLeaveState()
else
LuaApplication.changeState(loginState)
end
end

function loginControl:loginout()
loginControl.loginoutFlag=true
if not sceneControl:isLoadingState()then
loginControl:doLoginout()
end
end


function loginControl:checkSDKLogin(callback)
if deviceHelper.isRunSDK()then
if not loginModel.isLogin or loginModel:isLoginSDKInfoNull()then
loginModel.isLogin=false
platformSDK:reqLogin()
else
callback()
end
end
end


function loginControl:ReportVersion()
local _versionID=deviceHelper.getAPILevel()

socketManager:send_139_46(_versionID)
end

function loginControl:showLoginWin(argstable)
local callback=function(argstable)
if deviceHelper.getAPILevel()>=48 then
CS.AppDataModel.SetOption("option.CameraAdaptation.EnableAdaptation",true)
end
UIManager:showWindow("UILogin")
loginControl.fightStage=argstable.fightStage
loginControl:freshLoginGray()
UIManager:showWindow('UICommonLoadingWin')
UIManager:showWindow('UITopMaskWin')
end
UICreateRoleController:showBeginVideo()

local loginStageID=104

local specialParam=loginModel:getSpecialLoginWinParam()
local pfDefaultParam=loginModel:getPfDefaultLoginWinParam()


if webGLHelper:isWebGLOptimization()then
if specialParam and specialParam.staticStageId then
loginStageID=specialParam.staticStageId
else
if pfDefaultParam and pfDefaultParam.staticStageId then
loginStageID=pfDefaultParam.staticStageId
else
loginStageID=204
end
end
else
if specialParam and specialParam.stageId then
loginStageID=specialParam.stageId
elseif pfDefaultParam and pfDefaultParam.staticStageId then
loginStageID=pfDefaultParam.stageId
end
end


loginStageID=_AppConfig_GetInt("CustomLoginSceneBgID",loginStageID)

fightStage:create(loginStageID,callback,argstable)

end

function loginControl:freshLoginGray()
if houtaiModel:isLoginGray()then
UnityEngine.Shader.EnableKeyword("CUSTOM_GRAY")
else
UnityEngine.Shader.DisableKeyword("CUSTOM_GRAY")
end
end

function loginControl:onPlayFinishBeginVideo()
UICreateRoleController:createTempRole()
end

function loginControl:showOtherLoginDialogue(msg)
if self.logindialog==nil then
local showdata=
{
type='UIDialougeHighest',
}
self.logindialog=UIDialogManager.newDialog(showdata)
end
local dialog=self.logindialog
dialog.title='提示'
dialog.content=msg or'尊敬的祖师，您的账号正在其他设备登录'
dialog.oktext='确定'
dialog.canceltext=nil
dialog.allowclickBG=false
dialog.checkOkCallBackRet=false
dialog.okcallback=function()

if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
if pfwindowslController:checkIsGameVersion_guofu()then
platformSDK:reqApplicationQuit_PC()
else
loginControl:doLoginoutTimeOut()
end
else
loginControl:doLoginoutTimeOut()
end

end
dialog.closecallback=function()

if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
platformSDK:reqApplicationQuit_PC()
else
loginControl:doLoginoutTimeOut()
end
end
dialog:show()
end

function loginControl:showZhuXiaoDialogue()
socketManager:Disconnect()
reconnectState:leave()
loginControl:stopConnectTimer()
loginControl:resetBuildConnectFlag(false)

if self.logindialog==nil then
local showdata=
{
type='UIDialougeHighest',
}
self.logindialog=UIDialogManager.newDialog(showdata)
end
local dialog=self.logindialog
dialog.title='提示'
dialog.content='该角色已注销，如有疑问请联系客服'
dialog.oktext='确定'
dialog.canceltext=nil
dialog:show()
end

function loginControl:showReconnectFailDialogue()
local errorDialog=socketManager.errorDialog
errorDialog.title='提示'
errorDialog.content='重新连接服务器失败，返回登录'
errorDialog.oktext='确定'
errorDialog.checkOkCallBackRet=false
errorDialog.okcallback=function()

reconnectState:reconnectFail()
end
errorDialog.closecallback=function()

reconnectState:reconnectFail()
end
errorDialog:show()
end











function loginControl:setFirstLodingFlag(flag)
loginControl.firstloding=flag
end
function loginControl:getFirstLodingFlag()
return loginControl.firstloding or nil
end


function loginControl:setOpenServerListFlag(flag)
loginControl.OpenServerListFlag=flag
end
function loginControl:getOpenServerListFlag()
return loginControl.OpenServerListFlag or nil
end


function loginControl:reqProtocolContent()
local data=houtaiModel:getLoginAgreementData()
if data then
local userProtocolUrl=data['content1']
local proviteProtocolUrl=data['content2']

if userProtocolUrl and userProtocolUrl~='nil'then
_httpGetRequest(userProtocolUrl,function(content,err)

loggerUtil.log(FMT.fmt("loginControl reqProtocolContent userProtocolUrl",content,tostring(err)))
if err==""or err==nil then
content=content or""
local data={name="用户协议"}
loginControl.userProtocolContent=data
data.list=string.split(content,"\n")
else
logWarn(FMT.fmt("request userProtocol content ,php return message is error,content :: {0},error:{1},url:{2}",content,err,userProtocolUrl))
end
end)
end

if proviteProtocolUrl and proviteProtocolUrl~='nil'then
_httpGetRequest(proviteProtocolUrl,function(content,err)

loggerUtil.log(FMT.fmt("loginControl reqProtocolContent proviteProtocolUrl:{0} {1}",content,tostring(err)))
if err==""or err==nil then
content=content or""
local data={name="隐私协议"}
loginControl.proviteProtocolContent=data
data.list=string.split(content,"\n")
else
logWarn(FMT.fmt("request proviteProtocol content ,php return message is error,content :: {0},error:{1},url:{2}",content,err,proviteProtocolUrl))
end
end)
end
end
end
