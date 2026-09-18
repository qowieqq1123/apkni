











local _writablePath=CS.GamePath.writablePath
require'lua.platformSDK.pfHelper'
require'lua.platformSDK.platformSDK_None'
require'lua.platformSDK.platformHelper'
require'lua.platformSDK.platformIgnoreHelper'
require'lua.platformSDK.platformSDK_notify'
require'lua.platformSDK.platformSDK_Android'
require'lua.platformSDK.platformSDK_iOS'
require'lua.platformSDK.platformSDK_WeiXin'
require'lua.platformSDK.platformSDK_OpenHarmony'
require'lua.platformSDK.platformSDK_CSMG'
require'lua.platformSDK.platformSDK_AndroidHW'

platformSDK={}

local _platformInstance=nil
local _exitDialogue=nil
local _isClickExit=false
local _tConcat=table.concat
local _debugLog=Debugger.Log
local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local test

function platformSDK:init()
local platform_name=deviceHelper.getAppPlatform()
self.platform_name=platform_name
require('lua.platformSDK.'..platform_name)
_platformInstance=_G[platform_name]()
platformSDK_notify:requireNotifyClass(platform_name)
pfwindowslController:initLocalZone()
end


function platformSDK:invoke(func_name,...)
local func=_platformInstance[func_name]
if func and type(func)=="function"then
return func(_platformInstance,...)
else

end
end


function platformSDK:reqLogin(callback)
logPoint.UploadLog(logPoint.logType.comeinGame_showUpdateTips)
return _platformInstance:reqLogin(callback)
end


function platformSDK:reqSwitchLogin()
return _platformInstance:reqSwitchLogin()
end


function platformSDK:reqLogout(callback)
return _platformInstance:reqLogout(callback)
end


function platformSDK:reqPay(id,count,params,subscribe)
return _platformInstance:reqPay(id,count,params,subscribe)
end


function platformSDK:reqReport(typo,args)
return _platformInstance:reqReport(typo,args)
end


function platformSDK:reqQuit(callback,args)
return _platformInstance:reqQuit(callback,args)
end


function platformSDK:reqRestart(delay)
return _platformInstance:reqRestart(delay or 0)
end


function platformSDK:reqInit(callback)
_platformInstance:reqInit(callback)
end


function platformSDK:reqPlayAD(adid,attach,callback)
_platformInstance:reqPlayAD(adid,attach,callback)
end


function platformSDK:reqReviews()
_platformInstance:reqReviews()
end


function platformSDK:supportPlayAD()
if _platformInstance.supportPlayAD then
return _platformInstance:supportPlayAD()
end
return true
end


function platformSDK:reqShareUrl(url)
_platformInstance:reqShareUrl(url)
end





function platformSDK:reqShareImage(fileName,shareType,platform)
shareType=shareType or'PERSONAL'
platform=platform or'WX'
local path=FMT.fmt('{0}photo/{1}',_writablePath,fileName)
_platformInstance:reqShareImage(path,shareType,platform)
end


function platformSDK:reqShareVideo()
if _platformInstance.reqShareVideo then
_platformInstance:reqShareVideo()
end
end


function platformSDK:reqShowUserCenter()
if _platformInstance.reqShowUserCenter then
_platformInstance:reqShowUserCenter()
end
end


function platformSDK:reqSubscriptionStatus(id)
if _platformInstance.reqSubscriptionStatus then
_platformInstance:reqSubscriptionStatus(id)
end
end


function platformSDK:reqCustomerService()
if _platformInstance.reqCustomerService then
_platformInstance:reqCustomerService()
end
end


function platformSDK:reqCreateClubButton(option)
if _platformInstance.reqCreateClubButton then
return _platformInstance:reqCreateClubButton(option)
end
end


function platformSDK:reqCallClubButtonFunc(id,func)
if _platformInstance.reqCallClubButtonFunc then
_platformInstance:reqCallClubButtonFunc(id,func)
end
end


function platformSDK:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
if pfwindowslController:checkIsGameVersion_guofu()then
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
if _platformInstance.reqMsgSecCheck then
_platformInstance:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
else
callback(content)
end
elseif webGLHelper:isRunWeiXin()or webGLHelper:isRunAlipayMiniGame()then
if _platformInstance.reqMsgSecCheck then
_platformInstance:reqMsgSecCheck(scene,content,function(success)
if success then
callback(content)
else
callback()
end
end)
else
callback(content)
end
elseif webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()then
if _platformInstance.reqMsgSecCheck then
_platformInstance:reqMsgSecCheck(scene,content,function(success,reContent)
if success then
callback(reContent)
else
callback()
end
end)
else
callback(content)
end
else
callback(content)
end
else
if deviceHelper.isRunSDK()then
if _platformInstance.reqMsgSecCheck then
_platformInstance:reqMsgSecCheck(scene,content,callback,to_PrivatePlayerData)
else
callback(content)
end
else
callback(content)
end
end
end


function platformSDK:gongHuiReport()
if _platformInstance.gongHuiReport then
_platformInstance:gongHuiReport()
end
end

function platformSDK:reqPermission(permissions,code)
if permissions==nil or code==nil then return end
if _platformInstance.reqPermission then
_platformInstance:reqPermission(permissions,code)
end
end

function platformSDK:hasPermission(permissions)
if permissions==nil then return true end
if _platformInstance.hasPermission then
return _platformInstance:hasPermission(permissions)
end
return true
end

function platformSDK:getAppVersion()
if _platformInstance.getAppVersion then
return _platformInstance:getAppVersion()
end
end


function platformSDK:reqSidebarCheck(callback)
if _platformInstance.reqSidebarCheck then
return _platformInstance:reqSidebarCheck(callback)
end
end


function platformSDK:reqNavigateToSidebar()
if _platformInstance.reqNavigateToSidebar then
return _platformInstance:reqNavigateToSidebar()
end
end


function platformSDK:reqStartRecord(recordAudio,recordTime)
if _platformInstance.reqStartRecord then
return _platformInstance:reqStartRecord(recordAudio,recordTime)
end
end


function platformSDK:reqStopRecord()
if _platformInstance.reqStopRecord then
return _platformInstance:reqStopRecord()
end
end


function platformSDK:reqUnBingdingAccount()
if _platformInstance.reqUnBingdingAccount then
return _platformInstance:reqUnBingdingAccount()
end
end

function platformSDK:reqBingdingAccount()
if _platformInstance.reqBingdingAccount then
return _platformInstance:reqBingdingAccount()
end
end

function platformSDK:reqBingdingAccountState()
if _platformInstance.reqBingdingAccountState then
return _platformInstance:reqBingdingAccountState()
end
end


function platformSDK:reqPhoneBingdingState()
if _platformInstance.reqPhoneBingdingState then
return _platformInstance:reqPhoneBingdingState()
end
end

function platformSDK:reqReportGameEvent(name,param)
if _platformInstance.reqReportGameEvent then
return _platformInstance:reqReportGameEvent(name,param)
end
end


function platformSDK:uploadChatMsg(...)
if _platformInstance.uploadChatMsg then
return _platformInstance:uploadChatMsg(...)
end
end

function platformSDK:reqCheckCDKey(cdkey,callback)
if _platformInstance.reqCheckCDKey then
return _platformInstance:reqCheckCDKey(cdkey,callback)
end
end

function platformSDK:reqCheckCanUse(funcName)
if _platformInstance.reqCheckCanUse then
return _platformInstance:reqCheckCanUse(funcName)
end
return false
end

function platformSDK:reqUnionGroupFunc(ftype,guid,callback)
if _platformInstance.reqUnionGroupFunc then
return _platformInstance:reqUnionGroupFunc(ftype,guid,callback)
end
end

function platformSDK:reqAddCommonUse(callback)
if _platformInstance.reqAddCommonUse then
_platformInstance:reqAddCommonUse(callback)
end
end

function platformSDK:reqCheckCommonUse(callback)
if _platformInstance.reqCheckCommonUse then
_platformInstance:reqCheckCommonUse(callback)
end
end

function platformSDK:reqRequestFeedSubscribe(scene,callback)
if _platformInstance.reqRequestFeedSubscribe then
_platformInstance:reqRequestFeedSubscribe(scene,callback)
end
end

function platformSDK:reqCheckFeedSubscribeStatus(scene,callback)
if _platformInstance.reqCheckFeedSubscribeStatus then
_platformInstance:reqCheckFeedSubscribeStatus(scene,callback)
end
end

function platformSDK:reqReportScene(sceneId,costTime,callback)
if _platformInstance.reqReportScene then
_platformInstance:reqReportScene(sceneId,costTime,callback)
end
end

function platformSDK:requestLoginTime(scene,callback)
if _platformInstance.requestLoginTime then
_platformInstance:requestLoginTime(scene,callback)
end
end

function platformSDK:navigateToMiniProgram(appId,path,callback)
if _platformInstance.navigateToMiniProgram then
_platformInstance:navigateToMiniProgram(appId,path,callback)
end
end

function platformSDK:GetinitData(id)
if _platformInstance.GetinitData then
return _platformInstance:GetinitData(id)
end
end



function platformSDK:getBattery()
return _platformInstance:getBattery()
end




function platformSDK:getNetworkInfo(callback)
_platformInstance:getNetworkInfo(callback)
end


function platformSDK:get_permission(permissions)
if permissions==nil then return true end
if _platformInstance.get_permission then
return _platformInstance:get_permission(permissions)
end
return true
end

function platformSDK:request_permission(permissions,code)
if permissions==nil then return end
if _platformInstance.request_permission then
_platformInstance:request_permission(permissions,code)
end
end



function platformSDK:reqApplicationQuit_PC()
if _platformInstance.reqApplicationQuit_PC then
_platformInstance:reqApplicationQuit_PC()
end
end



function platformSDK:reqEfunShowPlatform()
if pfwindowslController:checkIsGameVersion_oumei()then
if _platformInstance.reqEfunShowPlatform then
_platformInstance:reqEfunShowPlatform()
end
end
end


function platformSDK:reqEfunDestoryPlatform()
if pfwindowslController:checkIsGameVersion_oumei()then
if _platformInstance.reqEfunDestoryPlatform then
_platformInstance:reqEfunDestoryPlatform()
end
end
end


function platformSDK:getEfunBindState()
if _platformInstance.getEfunBindState then
_platformInstance:getEfunBindState()
end
end


function platformSDK:getPhoneCaptcha(phoneNumber)
if _platformInstance.getPhoneCaptcha then
_platformInstance:getPhoneCaptcha(phoneNumber)
end
end


function platformSDK:reqPhoneBind(phoneNumber,captchaCode)
if _platformInstance.reqPhoneBind then
_platformInstance:reqPhoneBind(phoneNumber,captchaCode)
end
end


function platformSDK:showEfunOpenScan()
if _platformInstance.showEfunOpenScan then
_platformInstance:showEfunOpenScan()
end
end


function platformSDK:reqVerificationLogin(sdkParams)
if _platformInstance.reqVerificationLogin then
_platformInstance:reqVerificationLogin(sdkParams)
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_req_loginverification)
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_loginverification_success)
end
end


function platformSDK:reqEfunTrackEvent(eventName)
if _platformInstance.eEfunTrackEvent then
_platformInstance:eEfunTrackEvent(eventName)
end
end


function platformSDK:reqEfunCheckGoogleOAuth()
if _platformInstance.reqEfunCheckGoogleOAuth then
_platformInstance:reqEfunCheckGoogleOAuth()
end
end


function platformSDK:reqEfunGoogleOAuthBegin()
if _platformInstance.reqEfunGoogleOAuthBegin then
_platformInstance:reqEfunGoogleOAuthBegin()
end
end


function platformSDK:reqEfunGoogleReOAuthBegin()
if _platformInstance.reqEfunGoogleReOAuthBegin then
_platformInstance:reqEfunGoogleReOAuthBegin()
end
end


function platformSDK:reqGoogleOAuthCompleteState()
if _platformInstance.reqGoogleOAuthCompleteState then
_platformInstance:reqGoogleOAuthCompleteState()
end
end


function platformSDK:EfunGoogleVerifyOrder()
if _platformInstance.EfunGoogleVerifyOrder then
_platformInstance:EfunGoogleVerifyOrder()
end
end

function platformSDK:reqOpenCommunity(sceneId)
if _platformInstance.reqOpenCommunity then
_platformInstance:reqOpenCommunity(sceneId)
end
end

function platformSDK:reqOpenURL(url)
if _platformInstance.reqOpenURL then
_platformInstance:reqOpenURL(url)
end
end




function platformSDK:reqQQEvent(eventName)
if _platformInstance.executeCmd then
_platformInstance:executeCmd(eventName)
end
end




function platformSDK:reqReport(typo,args)
return _platformInstance:reqReport(typo,args)
end


function platformSDK.printSDK(...)
local printSDK=_appConfig_GetBool('printSDK',false)
local testPHP=_appConfig_GetBool('testPHP',false)
if not testPHP and(deviceHelper.isRunEditor()or not printSDK)then
return
end
local out={'[printSDK]：'}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
_debugLog(_tConcat(out,' '))
end

