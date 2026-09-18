
webGLHelper={}


webGLHelper.skipDownLoadCheck=false
webGLHelper.enableABWriteFile=true
local _ResourceHelper=CS.ResourceHelper






webGLMGPlatform=
{
ios='ios',
android='android',
windows='windows',
mac='mac',
devtools='devtools'
}

local fileCacheIgnoreList={
'base.ab',
'binary.ab',
'config.ab',
'data.ab',
'shader.ab',
'assetbundle',
'localFileList',
'uidialouge.ab'
}

mgVisitEnterType={
zfbFirstVisit=1,
zfbReturnVisit=2,
dyNavigateToSidebar=3,
}


douyin_feed_game_channel_state=
{
revisitVN=1,
acquisitionVN=2,
}


function webGLHelper:init()

self.skipLogin=false

self.showAgreementInSetting=true
self.loadOutTime=15
self.allowHighFrameRate=true
self.useWXSetFrameFunc=false
self.clubButtonType='text'

local noAutoDownloadData={}

local cfgs=cfg_webglreplacewinconfig()
for k,v in pairs(cfgs)do
local wincfg=UIManager.get_window_config(v.name)
if wincfg then
wincfg.ab=v.dab
end
noAutoDownloadData[#noAutoDownloadData+1]=v.sab
end
self.replaceData={}
cfgs=cfg_webglreplaceresconfig()
for k,v in pairs(cfgs)do
noAutoDownloadData[#noAutoDownloadData+1]=v.sab
self.replaceData[v.name]=v.dab
end
_WXInterface.SetNoAutoDownloadData(noAutoDownloadData)

local ctime=self:getAssetGroupCacheTime()

CS.AppDataModel.SetOption("option.PoolSystem.CachedAssetGroupDynamic.m_MinStayTime",ctime)

CS.AppDataModel.SetOption("option.GameEffectMgr.SyncLoad",false)

UnityEngine.Shader.EnableKeyword("_USE_TRANSPARENT_CLIP")

UnityEngine.Shader.globalMaximumLOD=1500


resourceUtility.setReleasePoolTime(10)

if webGLHelper:isRunWeiXin()then

end

_WXInterface.OnMemoryWarning(function(level)
_WXInterface.TriggerGC()
end)

self.wxPinchScale=-0.125
if api_Available_OnWheel()and self:isRunMiniGame()then
_WXInterface.OnWheel(function(x,y,dx,dy,dz,dt)
inputSystem.onPinchDelegate(0,1,nil,dy*self.wxPinchScale,dt)
end)
end

self.keyDownRecord={}
if api_Available_OnKeyDown()and self:isRunWeiXin()then
_WXInterface.OnKeyDown(function(key,code,deltaTime)
self.keyDownRecord[key]=true

end)
_WXInterface.OnKeyUp(function(key,code)
self.keyDownRecord[key]=nil

end)
end


if self:isRunWebGLOnly()and not self.syncDBTimer then
self.syncDBTimer=Timer.New(function()
CS.WebGLSDKHelper.SyncDB()
end,10,-1)
self.syncDBTimer:Start()
end

self:initAutoDeleteFile()
end

function webGLHelper:initMG()
if self:isRunMiniGame()or self:isRunMGNative()then
local launchOptions=self:GetLaunchOptionsSync()
if launchOptions then
if self:isRunHuaWeiMiniGame()then
if launchOptions.referrerInfo then
self.lastOpenScene=launchOptions.referrerInfo.type
else
self.lastOpenScene=nil
end
else
self.lastOpenScene=launchOptions.scene
end
self:setLastQueryArgs(launchOptions.query)

if self:isRunDouYin()or self:isRunDouYinNative()then
if string.endsWith(launchOptions.scene,'3041')then
autoLoginHelper.autoLogin=true
self.needReportScene=true
self.DouYinpStraightlay=true
self.feed_game_channel=launchOptions.query.feed_game_channel
platformSDK.printSDK('直玩场景值',launchOptions.query.feed_game_scene,launchOptions.query.feed_game_channel)
end
end
else
self.lastOpenScene=-1
end

if not self.lastQueryArgs then
local queryStr=userGlobalSetting.get('MG_QUERY_ARGS')
if queryStr then
self.lastQueryArgs=jsonHelper.decode(queryStr)
else
self.lastQueryArgs={}
end
end

if api_Available_OnShow()then
_WXInterface.OnShow(function(result)
local info=jsonHelper.decode(result)
if self:isRunHuaWeiMiniGame()then
if info.referrerInfo then
self.lastOpenScene=info.referrerInfo.type
else
self.lastOpenScene=nil
end
else
self.lastOpenScene=info.scene
end
self:setLastQueryArgs(info.query)
if self:isRunAlipayMiniGame()then
platformSDK.printSDK('OnShow 首访入口检测')
webGLHelper:checkAndShowVisitIcon(function()
notifySystem:postNotify(notifyConfig.on_minigame_show,info.scene)
end)
else
notifySystem:postNotify(notifyConfig.on_minigame_show,info.scene)
end
end)
end
end
end

function webGLHelper:onEnterState(isReconnect)
if isReconnect then return end
webGLHelper:listenNotify()
end

function webGLHelper:onLeaveState(isReconnect)
if isReconnect then return end
self.visitIconGuid=nil
self.addRewardIconGuid=nil
webGLHelper:removeNotify()
end

function webGLHelper:onEnterHome()
self:checkAndShowMGEntryIcon()

self:reqLoginDays()
end

function webGLHelper:onProtocolReq()
self:reportDYSceneStatus()
self:checkDYClientTransferOpen()
end

function webGLHelper:onLeaveHome()

end

function webGLHelper:listenNotify()


if self:isRunDouYin()or self:isRunDouYinNative()then
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.onTravelChange,self.onTravelChange)
end
end

function webGLHelper:removeNotify()


if self:isRunDouYin()or self:isRunDouYinNative()then
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.onTravelChange,self.onTravelChange)
end
end

function webGLHelper.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtLingPai and val<lastVal then
webGLHelper:checkSubscribe(2)
end
end
function webGLHelper.onTravelChange(typo)
if typo==1 then
webGLHelper:checkSubscribe(1)
end
end

function webGLHelper:checkAndShowMGEntryIcon()
self:checkAndShowVisitIcon()
self:checkAndShowAddRewardIcon()
end

function webGLHelper:checkAndShowVisitIcon(callback)
if self:isRunAlipayMiniGame()then
self:checkFirstVisit(function(checkFirst)
platformSDK.printSDK('首访入口检测',checkFirst)
if checkFirst then
self:showVisitIcon(mgVisitEnterType.zfbFirstVisit)
if callback then
callback()
end
else
self:checkReturnVisit(function(checkReturn)
platformSDK.printSDK('复访入口检测',checkReturn)
if checkReturn then
self:showVisitIcon(mgVisitEnterType.zfbReturnVisit)
else
self:hideVisitIcon()
end
if callback then
callback()
end
end)
end
end)
end
end

function webGLHelper:showVisitIcon(vtype)
if self.currentVisitType~=vtype then
self.currentVisitType=vtype
if vtype==mgVisitEnterType.zfbFirstVisit then
webGLHelper:reportVisitEvent('center_setappc_icon_expo')
else
webGLHelper:reportVisitEvent('revisit_icon_expo')
end
end
if self.visitIconGuid then
enterManager:freshFuncByGUID(self.visitIconGuid,'changeVisitType',vtype)
return
end
platformSDK.printSDK('显示首访入口')
self.visitIconGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eVisitGameCenter,getReddotFun=function()
return false
end})
end

function webGLHelper:hideVisitIcon()
if not self.visitIconGuid then
return
end
self.currentVisitType=nil
platformSDK.printSDK('隐藏首访入口')
enterManager:removeEnter(self.visitIconGuid)
self.visitIconGuid=nil
end

function webGLHelper:checkAndShowAddRewardIcon()
if not(self:isRunDouYin()or self:isRunDouYinNative())then
return
end

if welfareController:checkWXAddRewardTabOpen(true)then
self:showAddRewardIcon()
else
self:hideAddRewardIcon()
end
end

function webGLHelper:showAddRewardIcon()
if self:isRunDouYin()or self:isRunDouYinNative()then
if self.addRewardIconGuid then
return
end
local vtype=mgVisitEnterType.dyNavigateToSidebar
self.addRewardIconGuid=enterManager:freshEnter({id=1,vtype=vtype,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eVisitGameCenter,getReddotFun=function()
return false
end})
end
end

function webGLHelper:hideAddRewardIcon()
if not self.addRewardIconGuid then
return
end
enterManager:removeEnter(self.addRewardIconGuid)
self.addRewardIconGuid=nil
end

function webGLHelper:isKeyDown(key)
return self.keyDownRecord[key]==true
end

function webGLHelper:getLastOpenScene()
return self.lastOpenScene
end

function webGLHelper:setLastQueryArgs(query)
self.queryArgs=query
if not query then
return
end
if type(query)~='table'then
return
end
if not next(query)then
return
end
self.lastQueryArgs=query
local queryStr=jsonHelper.encode(query)
userGlobalSetting.record('MG_QUERY_ARGS',queryStr)
end

function webGLHelper:getLastQueryArgs()
return self.lastQueryArgs
end

function webGLHelper:getQueryArgs()
return self.queryArgs
end

function webGLHelper:isSkipLogin()
if not self:isRunWebGL()then
return false
end
if verifyManager:isOpen()and(not webGLHelper:isRunWeiXinTwo())then
return false
end
if deviceHelper.isRunNonePlatform()then
return false
end
return self.skipLogin
end

function webGLHelper:isShowAgreementInSetting()
if not self:isRunWebGL()then
return false
end
return self.showAgreementInSetting
end

function webGLHelper:getLoadOutTime()
return self.loadOutTime
end

function webGLHelper:isAllowHighFrameRate()
if not self:isRunWebGL()then
return false
end
return self.allowHighFrameRate
end

function webGLHelper:getAllowMaxFrameRate()
if not self.allowHighFrameRate then
return FRAME_LEVEL.eLow
end
if self:isRunMiniGame()then
local platform=self:getPlatformName()
if platform==webGLMGPlatform.android or platform==webGLMGPlatform.windows then
return FRAME_LEVEL.eMedium
else
return FRAME_LEVEL.eMedium40
end
end
return FRAME_LEVEL.eMedium
end

function webGLHelper:getAssetGroupCacheTime()
local platform=self:getPlatformName()
if platform==webGLMGPlatform.android or platform==webGLMGPlatform.windows then
return 300
else
return 10
end
end


function webGLHelper:isUseMGSetFrameFunc()
return self.useWXSetFrameFunc
end



function webGLHelper:setClubButtonType(type)
self.clubButtonType=type
end

function webGLHelper:setWXPinchScale(value)
self.wxPinchScale=value
end

function webGLHelper:setFileCacheOption(checkSize,clearSize,clearLimit)
checkSize=checkSize*1048576
clearSize=clearSize*1048576
_WXInterface.SetFileCacheOption(checkSize,clearSize,fileCacheIgnoreList,true,clearLimit)
end

function webGLHelper:getReplaceResourceAB(key)
return self.replaceData[key]
end

function webGLHelper:checkSkipAPICheck(apiLevel)
if not(self:isRunWebGL()or self:isRunMGNative())then
return false
end
if self:isRunWeiXin()then
if apiLevel<=63 then
return true
end
elseif self:isRunDouYin()or self:isRunDouYinNative()then
if apiLevel<=120 then
return true
end
elseif self:isRunHuaWeiMiniGame()then
if apiLevel<=160 then
return true
end
elseif self:isRunAlipayMiniGame()then
if apiLevel<=230 then
return true
end
end
return false
end


local DouYin_HeTu=
{
["dxzd"]=true,
["dxmjios"]=true,
}


local WeiXin_ZuShiTwo=
{
["zsyfk"]=true,
}


local pfadvid=
{
["zsyfk"]=67,
}

function webGLHelper:getPfAdvid()
local pfname=loginModel:getPfname()
return pfadvid[pfname]
end

local isMiniGame


function webGLHelper:is_MiniGame()
if isMiniGame==nil then
isMiniGame=webGLHelper:isRunWeiXin()or webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()or webGLHelper:isRunWeiXinTwo()or webGLHelper:isDouYin_HeTu()
end
return isMiniGame
end

local isDouYin


function webGLHelper:is_DouYinGame()
if isDouYin==nil then
isDouYin=webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()or webGLHelper:isDouYin_HeTu()
end
return isDouYin
end


function webGLHelper:isRunWeiXin()
if deviceHelper.isRunWeiXin then
return deviceHelper.isRunWeiXin()
else
return false
end
end


function webGLHelper:isRunWeiXinTwo()
local pfname=loginModel:getPfname()
return WeiXin_ZuShiTwo[pfname]
end


function webGLHelper:isRunMeiTuan()
if deviceHelper.isRunMeiTuan then
return deviceHelper.isRunMeiTuan()
else
return false
end
end


function webGLHelper:isRunDouYin()
if deviceHelper.isRunDouYin then
return deviceHelper.isRunDouYin()
else
return false
end
end




function webGLHelper:isDouYin_HeTu()
local pfname=loginModel:getPfname()
return DouYin_HeTu[pfname]
end




function webGLHelper:isRunDouYinNative()
if deviceHelper.isRunDouYinNative then
return deviceHelper.isRunDouYinNative()
else
return false
end
end


function webGLHelper:isRunWebGLOnly()
if deviceHelper.isRunWebGLOnly then
return deviceHelper.isRunWebGLOnly()
else
return false
end
end


function webGLHelper:isRunHuaWeiMiniGame()
if deviceHelper.isRunHuaWeiMiniGame then
return deviceHelper.isRunHuaWeiMiniGame()
else
return false
end
end


function webGLHelper:isRunAlipayMiniGame()
if deviceHelper.isRunAlipayMiniGame then
return deviceHelper.isRunAlipayMiniGame()
else
return false
end
end


function webGLHelper:isRunKuaiShouMiniGame()
if deviceHelper.isRunKuaiShouMiniGame then
return deviceHelper.isRunKuaiShouMiniGame()
else
return false
end
end


function webGLHelper:isRunWebGL()
return deviceHelper.isRunWebGL()
end


function webGLHelper:isRunBzhan()
if deviceHelper.isRunBzhan then
return deviceHelper.isRunDouYin()
else
return false
end
end

function webGLHelper:setShowOptimization(bShow)
self.showOptimization=bShow
end







function webGLHelper:isRunMiniGame()
if deviceHelper.isRunMiniGame then
return deviceHelper.isRunMiniGame()
else
return false
end
end



function webGLHelper:isWebGLOptimization()
return self:isRunMiniGame()or self.showOptimization
end


function webGLHelper:isRunMGNative()
if deviceHelper.isRunMGNative then
return deviceHelper.isRunMGNative()
else
return false
end
end

function webGLHelper:uiWindowCloseCamera(bgComponent)
if webGLHelper:isWebGLOptimization()and cameraControl.isSpecialCamera()then
cameraControl.setCameraActive(false)
if bgComponent then
bgComponent:setCSImageSprite("ui/windows/common/sharedtextures/image_tyuibg_2.ab","image_tyuibg_2")
end
end
end

function webGLHelper:uiWindowShowCamera()
if webGLHelper:isWebGLOptimization()then
cameraControl.setCameraActive(true)
end
end


function webGLHelper:skipDownLoadResGroup()
if not self:isRunWebGL()then
return false
end

if self:isRunAlipayMiniGame()then
return true
end

return self.skipDownLoadCheck
end

function webGLHelper:isSkipAutoDownload()
return self:isRunWebGL()or self:isRunMGNative()
end


function webGLHelper:isEnableABWriteFile()
return self.enableABWriteFile
end

function webGLHelper:isShowCustomerServiceButton()


return self:isRunWeiXin()or self:isRunDouYin()or self:isRunDouYinNative()
end

function webGLHelper:isShowCleanButton()


return self:isRunWeiXin()or self:isRunDouYin()or self:isRunDouYinNative()
end


function webGLHelper:enableAutoSetDPR(bEnable)
_WXInterface.EnableAutoSetDPR(bEnable)
end

function webGLHelper:setDPI(dpi)
_WXInterface.SetDPI(dpi)
end

function webGLHelper:getDPI()
return _WXInterface.GetDPI()
end

function webGLHelper:setDPR(dpr)
_WXInterface.SetDPR(dpr)
end

function webGLHelper:getDPR()
return _WXInterface.GetDPR()
end

function webGLHelper:getFPS()
return _WXInterface.GetFPS()
end

function webGLHelper:getSafeArea()
local dataStr=_WXInterface.GetSafeArea()
if dataStr~=''then
local data=jsonHelper.decode(dataStr)
return data
end
end


function webGLHelper:getSystemInfoSync(refresh)
if not self.systemInfo or refresh then
local dataStr=_WXInterface.GetSystemInfoSync()
if dataStr~=''then
self.systemInfo=jsonHelper.decode(dataStr)
end
end
return self.systemInfo
end

function webGLHelper:getAccountInfoSync()
if api_Available_GetAccountInfoSync()then
if not self.accountInfo then
local dataStr=_WXInterface.GetAccountInfoSync()
if dataStr~=''then
self.accountInfo=jsonHelper.decode(dataStr)
end
end
return self.accountInfo
end
end

function webGLHelper:getAppBaseInfo()
if api_Available_GetAppBaseInfo()then
if not self.appBaseInfo then
local dataStr=_WXInterface.GetAppBaseInfo()
if dataStr~=''then
self.appBaseInfo=jsonHelper.decode(dataStr)
end
end
return self.appBaseInfo
end
end

function webGLHelper:getDeviceInfo()
if api_Available_GetDeviceInfo()then
if not self.deviceInfo then
local dataStr=_WXInterface.GetDeviceInfo()
if dataStr~=''then
self.deviceInfo=jsonHelper.decode(dataStr)
end
end
return self.deviceInfo
end
end

function webGLHelper:GetLaunchOptionsSync()
if api_Available_GetLaunchOptionsSync()then
if not self.launchOptions then
local dataStr=_WXInterface.GetLaunchOptionsSync()
if dataStr~=''then
self.launchOptions=jsonHelper.decode(dataStr)
end
end
return self.launchOptions
end
end

function webGLHelper:getPlatformName()
local info=self:getSystemInfoSync()
if info then
local platform=info.platform

if platform=='ANDROIDOS'or platform=='Android'then
platform=webGLMGPlatform.android
elseif platform=='iOS'then
platform=webGLMGPlatform.ios
end
return platform
end
return''
end

function webGLHelper:checkPlatform(pfName)
local platform=self:getPlatformName()
return platform==pfName
end

function webGLHelper:isNeedAdaption()





if self:isRunMiniGame()then
local platform=self:getPlatformName()
if platform~=webGLMGPlatform.windows and platform~=webGLMGPlatform.mac then
return true
end
elseif self:isRunDouYinNative()then
return true
end
return false
end

function webGLHelper:isShowFPSSetting()
if webGLHelper:isRunHuaWeiMiniGame()then
return false
end
if webGLHelper:getAllowMaxFrameRate()<60 then
return false
end
return true
end

function webGLHelper:setEnableDebug(enable)
_WXInterface.SetEnableDebug(enable)
end

function webGLHelper:getBaseInfo()
local dataStr=CS.WebGLSDKHelper.CallSDKFuncSync('get_base_info','')
local data=jsonHelper.decode(dataStr)
return data
end

function webGLHelper:reportCustomEvent(etype)
local data={}
data.eventType=etype
local info=jsonHelper.encode(data)
CS.WebGLSDKHelper.CallSDKFuncSync('report_custom_event',info)
end

function webGLHelper:checkNetProtocolType(ptype)
local netType=CS.AppDataModel.AppConfig_GetInt("NetProtocolType",0)
return netType==ptype
end

function webGLHelper:getVersionString()
local version=CS.AppDataModel.GetResourceVersion()
local apiLevel=deviceHelper.getAPILevel()
local vstr=FMT.fmt('游戏版本：{0}_{1}',version,apiLevel)
local appVersion=platformSDK:getAppVersion()
if appVersion and appVersion~=''then
vstr=FMT.fmt('{0}_{1}',vstr,appVersion)
end
local verifyid=CS.AppDataModel.AppConfig_GetString('verifyid','')
if verifyid and verifyid~=''then
vstr=FMT.fmt('{0}_{1}',vstr,verifyid)
end
return vstr
end

function webGLHelper:setShareData()
if deviceHelper.getAPILevel()<73 then
return
end

if not self.shareConfig then
return
end

local share_key=welfareModel:getSelfInvitationString()
if not share_key then
return
end

local data=table.deepCopy(self.shareConfig)
data.query=FMT.fmt('shareKey={0}',share_key)
local dataStr=jsonHelper.encode(data)
CS.WebGLSDKHelper.CallSDKFuncSync('set_share_data',dataStr)
end

function webGLHelper:setShareConfig(data)
self.shareConfig=data
end


function webGLHelper:navigateToMiniProgram(appId,paramKey,param,callback)
if deviceHelper.getAPILevel()>=241 then
local paramJson=jsonHelper.encode(param)
_WXInterface.NavigateToMiniProgram(appId,paramKey,paramJson,callback)
end
end


function webGLHelper:openURL(url,callback)
if deviceHelper.getAPILevel()>=241 then
_WXInterface.OpenURL(url,callback)
end
end


function webGLHelper:GetLaunchOptions(callback)
if deviceHelper.getAPILevel()>=241 then
_WXInterface.GetLaunchOptions(callback)
end
end

function webGLHelper:downLoadBaseGroup()
_WXInterface.SetCheckLoadGroupVersion(false)
downAssetManager:downGroup(ASSET_GROUP_TYPE.eBaseRes,'')
_WXInterface.SetCheckLoadGroupVersion(true)
end


function webGLHelper:clearFileCache(targetSize)
if self:isRunWeiXin()then
targetSize=targetSize*1048576
local path=CS.GamePath.writableAssetBundlePath
_WXInterface.ClearFileCache(path,targetSize)
end
end

function webGLHelper:clearAssetBundleAndRestartGame()
_WXInterface.RmdirSync(CS.GamePath.writableAssetBundlePath,true)
_WXInterface.UnlinkSync(CS.GamePath.writablePath..'/version.json')
_WXInterface.RestartMiniProgram(nil,nil,nil)
end

function webGLHelper:checkFileCacheMode(mode)
if api_Available_GetFileCacheMode()then
local fcm=_WXInterface.GetFileCacheMode()
return fcm==mode
end
return false
end

function webGLHelper:initAutoDeleteFile()
if not self:isRunMiniGame()then
return
end

self:handleAutoDeleteFile(1)

if api_Available_SetFileWriteErrorHandleFunction()then
_WXInterface.SetFileWriteErrorHandleFunction(function(fstype,arg1,arg2,arg3)
self:handleAutoDeleteFile(2)
end)
end
end

function webGLHelper:handleAutoDeleteFile(mode)
local rootPath=_WXInterface.USER_DATA_PATH
local abPath=CS.GamePath.writableAssetBundlePath
local cfgs=cfg_webglautodeleteconfig()
for k,v in pairs(cfgs)do
if(mode==2 and v.del_on_error)or(mode==1 and v.del_on_load)then
local path=(v.type==1 and rootPath or abPath)..'/'..v.path
if _WXInterface.IsExists(path)then
if v.is_file then
_WXInterface.UnlinkSync(path)
else
_WXInterface.RmdirSync(path,true)
end
end
end
end
end









function webGLHelper:createClubButton(uiRT,data)
if deviceHelper.getAPILevel()<66 then
return
end
data=data or{}
local size=uiRT.sizeDelta
local lpos=uiRT.localPosition
local scale=uiRT.localScale
local scaleR=data.scale or 1
local hw=size.x*scale.x*0.5*scaleR
local hh=size.y*scale.y*0.5*scaleR
local ltLP=Vector3.New(lpos.x-hw,lpos.y+hh,0)
local rbLP=Vector3.New(lpos.x+hw,lpos.y-hh,0)
local parent=uiRT.parent
local ltWP=parent:TransformPoint(ltLP)
local rbWP=parent:TransformPoint(rbLP)
local ltSP=CS.CSGUIManager.Instance:WorldToScreenPoint(ltWP)
local rbSP=CS.CSGUIManager.Instance:WorldToScreenPoint(rbWP)
local sw=UnityEngine.Screen.width
local sh=UnityEngine.Screen.height
local rx=ltSP.x/sw
local ry=(sh-ltSP.y)/sh
local rw=(rbSP.x-ltSP.x)/sw
local rh=(ltSP.y-rbSP.y)/sh
local info=self:getSystemInfoSync()
local left
local top
local width
local height
if webGLHelper:isRunAlipayMiniGame()then
left=info.windowWidth*rx
top=info.windowHeight*ry
width=info.windowWidth*rw
height=info.windowHeight*rh
else
left=info.screenWidth*rx
top=info.screenHeight*ry
width=info.screenWidth*rw
height=info.screenHeight*rh
end
local type=data.type or self.clubButtonType
local text=data.text or'        '
local option={
style={
left=left,
top=top,
width=width,
height=height
},
type=type,
text=text
}
local id=platformSDK:reqCreateClubButton(option)
if webGLHelper:isRunAlipayMiniGame()then
self:showClubButton(id,true)
end
return id
end


function webGLHelper:destroyClubButton(id)
if deviceHelper.getAPILevel()<66 then
return
end
platformSDK:reqCallClubButtonFunc(id,'destroy')
end


function webGLHelper:showClubButton(id,bShow)
if deviceHelper.getAPILevel()<66 then
return
end
if bShow then
platformSDK:reqCallClubButtonFunc(id,'show')
else
platformSDK:reqCallClubButtonFunc(id,'hide')
end
end

function webGLHelper:handleLogin()
if deviceHelper.isRunEditor()then
elseif deviceHelper.isRunNonePlatform()then
else
logPoint.UploadLog(logPoint.logType.reqLoginGame_clickentergame)
local callback=function()
loginControl:requestLogin(function(flag)
end)
end
updateControl.checkUpdate(callback)
end
end

function webGLHelper:gameFirstVisit()
if self:isRunAlipayMiniGame()then
webGLHelper:reportVisitEvent('center_setappc_panel_click')
local param={chInfo='gamesetlattice'}
self:navigateToMiniProgram('2021003125685383','startParam',param,function(res)
platformSDK.printSDK(res)
end)
end
end

function webGLHelper:gameReturnVisit()
if self:isRunAlipayMiniGame()then
webGLHelper:reportVisitEvent('revisit_panel_click')
local url
if self:getPlatformName()==webGLMGPlatform.ios then
url='alipays://platformapi/startapp?appId=2060090000285522&url=https%3A%2F%2Frender.alipay.com%2Fp%2Fyuyan%2F180020010001210691%2Findex.html%3FcaprMode%3Dsync&sourceAppId=2021003125685383&sourceUrl=alipays%3A%2F%2Fplatformapi%2Fstartapp%3FappId%3D2021003125685383%26url%3Dhttps%253A%252F%252Frender.alipay.com%252Fp%252Fyuyan%252F180020010001206617%252Findex.html%253FcaprMode%253Dsync%26chInfo%3Dreturnvisit%26sms%3DYES%26appClearTop%3Dfalse%26startMultApp%3DYES'
else
url='alipays://platformapi/startapp?appId=2060090000285522&url=https%3A%2F%2Frender.alipay.com%2Fp%2Fyuyan%2F180020010001210691%2Findex.html%3FcaprMode%3Dsync&sourceAppId=2021003125685383&sourceUrl=alipays%3A%2F%2Fplatformapi%2Fstartapp%3FappId%3D2021003125685383%26url%3Dhttps%253A%252F%252Frender.alipay.com%252Fp%252Fyuyan%252F180020010001206617%252Findex.html%253FcaprMode%253Dsync%26chInfo%3Dreturnvisit%26sms%3DYES%26appClearTop%3Dfalse'
end
_WXInterface.OpenURL(url,function(res)
platformSDK.printSDK(res)
end)
end
end

function webGLHelper:getVisitResult()
return self.visitResult
end

function webGLHelper:checkFirstVisit(callback)
if not self:isRunAlipayMiniGame()then
callback(false)
return
end

if not welfareController:checkWXAddRewardOpen()then
callback(false)
return
end

local gameCenterBackFlow=self.queryArgs.gameCenterBackFlow
if gameCenterBackFlow==false then
callback(false)
return
end

local url=FMT.fmt('https://logpyzqzs.xw66.top/{0}/api/addHomePageConsult?account={1}',gameInfo:getPfname(),loginModel.userid)
CS.ResourceHelper.HttpGetRequest(url,function(message,error)
platformSDK.printSDK('首访数据',message,error)
local data=jsonHelper.decode_josn(message)
self.visitResult=data
if data then
if data.code==0 then
if data.data.consult_result=='N'then
callback(true)
return
elseif data.data.consult_result=='Y'then
if welfareController:checkAlipayFirstRewardCanReceive()then
callback(true)
return
end
end
end
end
callback(false)
end)
end

function webGLHelper:checkReturnVisit(callback)
if not self:isRunAlipayMiniGame()then
callback(false)
return
end

if not welfareController:checkWXAddRewardOpen()then
callback(false)
return
end

local info=self:getSystemInfoSync()
local cv=self:compareVersion(info.version,'10.5.60')
if cv<0 then
callback(false)
return
end

local gameCenterBackFlow=self.queryArgs.gameCenterBackFlow
if gameCenterBackFlow==false then
callback(false)
return
end

callback(true)
end


function webGLHelper:gameBehaviorReport(action_code)
if not self:isRunAlipayMiniGame()then
return
end

local channel=self.queryArgs.channel
if not channel then
channel='other'
end

local urlstr='https://reportzqzs.xw66.top/report?counter={0}&pfid={1}&account={2}&action_code={3}&action_finish_channel={4}&timestamp={5}'
local url=FMT.fmt(urlstr,'alipay_report',gameInfo:getPfid(),loginModel.userid,action_code,channel,tostring(os.time()))
CS.ResourceHelper.HttpGetRequest(url,function(message,error)
platformSDK.printSDK('行为上报',message,error)
end)
end

function webGLHelper:compareVersion(v1,v2)
local splitVersion=function(version)
local parts={}
for part in string.gmatch(version,'%d+')do
table.insert(parts,part)
end
return parts
end

local parts1=splitVersion(v1)
local parts2=splitVersion(v2)

local len=math.max(#parts1,#parts2)
for i=1,len do
local num1=tonumber(parts1[i])or 0
local num2=tonumber(parts2[i])or 0

if num1<num2 then
return-1
elseif num1>num2 then
return 1
end
end

return 0
end

function webGLHelper:getCreateRoleDay()
local shortCreateTime=gameUtilityModel.getPlayerCreateTime()
local currentTime=gameUtilityModel.getServerShortTime()
local stamp=currentTime-shortCreateTime
local day=math.floor(stamp/86400)+1
return day
end

function webGLHelper:reportVisitEvent(rtype,param)
local data={
rtype,
param or{}
}
platformSDK:reqReportGameEvent('reportCustomEvent',data)
end

function webGLHelper:reportByCreateRole()
if self:isRunAlipayMiniGame()then
local isNew=loginModel.newflag==1
if isNew then
platformSDK:reqReportGameEvent('reportAuthorized')
end
platformSDK:reqReportGameEvent('reportGameCharacterCreated',isNew)
end
end

function webGLHelper:checkCanUse(funcName)
return platformSDK:reqCheckCanUse(funcName)
end

function webGLHelper:isUnionGroupFuncCanUse()
return self:checkCanUse('GetUnionGroupInfo')
end

function webGLHelper:handleUnionGroupFunc(ftype,guid,callback)
platformSDK:reqUnionGroupFunc(ftype,guid,callback)
end


function webGLHelper:reportSceneStatus(args)
if not(self:isRunDouYin()or self:isRunDouYinNative())then
return
end
local info=''
for i,v in ipairs(args)do
info=FMT.fmt('{0}|{1}-{2}',info,v[1],v[2])
end
info=string.sub(info,2)
local urlstr='https://reportzqzs.xw66.top/report?counter=scene_status&pfid={0}&account={1}&scene_info={2}'
local url=FMT.fmt(urlstr,gameInfo:getPfid(),loginModel.userid,info)
platformSDK.printSDK('场景状态上报',url)
CS.ResourceHelper.HttpGetRequest(url,function(message,error)
platformSDK.printSDK('场景状态上报结果',message,error)
end)
end

function webGLHelper:reportDYSceneStatus()
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<341 then
return
end

if self.bReportSceneStatus then
return
end
self.bReportSceneStatus=true

if self:isRunDouYin()or self:isRunDouYinNative()then
local lt=timeHelper.getServerLongTime()
local st1=lt+12*3600
local st2=lt+8*3600
local st4=lt+8*3600
self:reportSceneStatus({{1,st1},{2,st2},{4,st4}})
end
end


function webGLHelper:CheckFeedfunc(i,contentIDs)
platformSDK.printSDK('检测直玩订阅状态',i,contentIDs)
platformSDK:reqCheckFeedSubscribeStatus(i,function(success,result)
platformSDK.printSDK('检测直玩订阅状态结果',i,success,result)
if success then
local rdata=jsonHelper.decode_josn(result)
if rdata.status==false then
platformSDK:reqRequestFeedSubscribe(i,contentIDs,function(success2,result2)
platformSDK.printSDK('直玩订阅结果',i,success2,result2)
end)
end
else
platformSDK.printSDK('检测直玩订阅失败',result)
end
end)

end

function webGLHelper:reportDYToMini()
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<390 then
return
end

if self:isRunDouYin()or self:isRunDouYinNative()then
local appId="ttc9e5bf5856eff54001"
local path='pages/circle/index?appId=tt59002fbdc63134ad07'
platformSDK:navigateToMiniProgram(appId,path,function(success,result)
if not success then
platformSDK.printSDK('跳转抖音小游戏圈失败',result)

local data=jsonHelper.decode_josn(result,{})
if data.ErrorCode==10401 or data.ErrorCode==21000 then
UIManager.info('请更新抖音版本')
end
end
end)
end
end

function webGLHelper:reqLoginDays()
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<360 then
return
end

if self.loginDays then
return
end
self.loginDays={}
if self:isRunDouYin()or self:isRunDouYinNative()then

platformSDK:requestLoginTime('021001',function(sucess,result)
if sucess then
local data=jsonHelper.decode_josn(result)
if data then
self.loginDays['021001']=data.result.first_days
end
end
end)

platformSDK:requestLoginTime('021020',function(sucess,result)
if sucess then
local data=jsonHelper.decode_josn(result)
if data then
self.loginDays['021020']=data.result.first_days
end
end
end)
end
end

function webGLHelper:isHidePunchAni()
return webGLHelper:isRunWeiXin()
end

function webGLHelper:getEnterLoginDay(enterIdStr)
if not self.loginDays then
return 0
end
return self.loginDays[enterIdStr]or 0
end

function webGLHelper:setEnterLoginDay(enterIdStr,day)
if not self.loginDays then
self.loginDays={}
end
self.loginDays[enterIdStr]=day
end


function webGLHelper:checkSubscribe(index)
if self:isRunDouYin()or self:isRunDouYinNative()then

if index==1 then
self:CheckFeedfunc(1,{'CONTENT576468226'})
end

if index==2 then
self:CheckFeedfunc(2,{'CONTENT556960258'})
end

if index==3 then
self:CheckFeedfunc(3,{'CONTENT522091778','CONTENT12491553026','CONTENT12478335490'})
end

if index==4 then
self:CheckFeedfunc(3,{'CONTENT522091778','CONTENT12491553026','CONTENT12478335490'})
end

if index==5 then
self:CheckFeedfunc(3,{'CONTENT522091778','CONTENT12491553026','CONTENT12478335490'})
end
end

end

local DouYinHandleFeedStatus=
{
FeedEnter=0,
FeedExit=1,
}


function webGLHelper:OnDouYinHandleFeedStatus(state)
self.DouYinHandleFeedStatus=state
platformSDK.printSDK('OnDouYinHandleFeedStatus',state)
if webGLHelper:checkDouYinAcquisitionVN()and state==DouYinHandleFeedStatus.FeedEnter then
UIManager:closeWindow("UIDouYinMiniGameWin")
platformSDK:reqLogin()
end
end

local DouYinAcquisitionVN_local


function webGLHelper:checkDouYinAcquisitionVN()
if DouYinAcquisitionVN_local==nil then
DouYinAcquisitionVN_local=CS.AppDataModel.AppConfig_GetBool("DouYinAcquisitionVN_local",false)
end
if DouYinAcquisitionVN_local then
return true
end
if(webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative())and self.feed_game_channel and self.feed_game_channel==douyin_feed_game_channel_state.acquisitionVN then
return true
end
return false
end

function webGLHelper:PlayDouYinPv()
UIManager:showWindow("UIDouYinMiniGameWin")
end


function webGLHelper:checkDYClientTransferOpen()
local isOpen=houtaiModel:getDYClientTransferOpen()
platformSDK.printSDK('checkDYClientTransferOpen',isOpen)
if isOpen then
platformSDK:invoke("checkIsTurn")
end
end


function webGLHelper:weiXinTwoMiniGameOpen()
return verifyManager:isOpen()and webGLHelper:isRunWeiXinTwo()
end

function webGLHelper:showMiniGame()
if webGLHelper:checkDouYinAcquisitionVN()or webGLHelper:weiXinTwoMiniGameOpen()then
webGLHelper:PlayDouYinPv()
end
end

