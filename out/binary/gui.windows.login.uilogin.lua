







def_class("UILogin",UIWindowBase)









function UILogin:bindComponents()

self.logoTitle=UIImage.get(self,0)
self.userName=UIInputField.get(self,1)
self.serverObj=UIObject.get(self,2)
self.version=UIText.get(self,3)
self.bottomTips=UIText.get(self,4)
self.noticeBtn=UIButton.get(self,5)
self.ruleObj=UIObject.get(self,6)
self.ageTips=UIButton.get(self,7)
self.wxKeFuBtn=UIButton.get(self,8)
self.cleanBtn=UIButton.get(self,9)
self.sdkusercenter=UIButton.get(self,10)
self.pchelperBtn=UIButton.get(self,11)
self.FTSaoMaBtn=UIButton.get(self,12)
self.switchBtn=UIButton.get(self,13)
self.delBtn=UIButton.get(self,14)
self.switchZoneBtn=UIButton.get(self,15)

self.noticeBtn:setButtonClick(function()self:onNoticeBtn()end)

self.ageTips:setButtonClick(function()self:onAgeTips()end)

self.wxKeFuBtn:setButtonClick(function()self:onWxKeFuBtn()end)

self.cleanBtn:setButtonClick(function()self:onCleanBtn()end)

self.sdkusercenter:setButtonClick(function()self:onSdkusercenter()end)

self.pchelperBtn:setButtonClick(function()self:onPchelperBtn()end)

self.FTSaoMaBtn:setButtonClick(function()self:onFTSaoMaBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)

self.delBtn:setButtonClick(function()self:onDelBtn()end)

self.switchZoneBtn:setButtonClick(function()self:onSwitchZoneBtn()end)



end


function UILogin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.logoTitle);self.logoTitle=nil;
_UIObject_release(self.userName);self.userName=nil;
_UIObject_release(self.serverObj);self.serverObj=nil;
_UIObject_release(self.version);self.version=nil;
_UIObject_release(self.bottomTips);self.bottomTips=nil;
_UIObject_release(self.noticeBtn);self.noticeBtn=nil;
_UIObject_release(self.ruleObj);self.ruleObj=nil;
_UIObject_release(self.ageTips);self.ageTips=nil;
_UIObject_release(self.wxKeFuBtn);self.wxKeFuBtn=nil;
_UIObject_release(self.cleanBtn);self.cleanBtn=nil;
_UIObject_release(self.sdkusercenter);self.sdkusercenter=nil;
_UIObject_release(self.pchelperBtn);self.pchelperBtn=nil;
_UIObject_release(self.FTSaoMaBtn);self.FTSaoMaBtn=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.delBtn);self.delBtn=nil;
_UIObject_release(self.switchZoneBtn);self.switchZoneBtn=nil;
end
















local _reqLoadCDN=false
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _outTime=10
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool

local _serverInfoColorDefault={"#171311","#7D3B17","#171311"}



function UILogin:onLoaded(...)
self.showRule=true
logPoint.UploadLog(logPoint.logType.initComplete)
gameHelper:setFrameInLoginState()
self:bindComponents()
self._freshServerList=function(...)
self:freshServerList(...)
end
_reqLoadCDN=false
notifySystem:listenNotify(notifyConfig.serverListFresh,self._freshServerList)
self.connectTime=0
self:setTimer(1,0,function()
if socketManager.connecting then
self.connectTime=self.connectTime+1

if self.connectTime>_outTime then
self.connectTime=0
socketManager:Disconnect()
loginControl:leaveToLogin()
end
else
self.connectTime=0
end
end)

if autoLoginHelper:isAutoLogin()then
local tick=userGlobalSetting.get('loginRuleTick',false)
if not tick then
self:onRuleTickClick()
end
end


if loginModel:getPfid()==8245 then
injectAppConfig.createLogAppConfigEx(true)
end

self:PC_ShowHelperBtn()
self:checkPFWindowsShow()
self:ShowSwitchBtn()
self:ShowDelBtn()
self:ShowSwitchZoneBtn()
end

function UILogin:initData()
if deviceHelper.isRunSDK()then
if not loginModel.isLogin or loginModel:isLoginSDKInfoNull()then
loginModel.isLogin=false


if webGLHelper:checkDouYinAcquisitionVN()or webGLHelper:weiXinTwoMiniGameOpen()then
return
else
platformSDK:reqLogin()
end
end
else
loginLocal.set_server_list()
loginLocal.init_role_list()
end
end


function UILogin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.serverListFresh,self._freshServerList)
UIManager:closeWindow('UILoginServerListWin')
UIManager:closeWindow('UIGongGaoWin')
loginControl.fightStage:close()
UnityEngine.Shader.DisableKeyword("CUSTOM_GRAY")
if deviceHelper.getAPILevel()>=48 then
CS.AppDataModel.SetOption("option.CameraAdaptation.EnableAdaptation",false)
end
UIManager:closeWindow('UITopMaskWin')
end




function UILogin:onShow(argtable,afterOnloaded)
updateState.closeLoading()
loginControl:resetBuildConnectFlag()
socketManager:closeDialogue()
self:initData()
self:showLogoTitle()
self:showUserName()
self:showServerObj()
self:showVersion()
self:showBottomTips()
self:showRuleObj()
UIManager:callWindowFunc('UILoading','endAni')
sceneAudioController:playLoginBgMusic()
if loginControl.isnotice then
if not autoLoginHelper:isAutoLogin()then
self:onNoticeBtn(true)
end
end

self.wxKeFuBtn:setActive(webGLHelper:isShowCustomerServiceButton())
self.cleanBtn:setActive(webGLHelper:isShowCleanButton())

if pfCommonHelper:ShowSDKUserCenter()then
self.sdkusercenter:setActive(true)
end

if verifyManager:isOpen()then
self.noticeBtn:setActive(false)
end
if verifyManager:isHideRule()or autoLoginHelper:hideLoginRule()then
self.ruleObj:setActive(false)
self.showRule=false
end

if appUtils.testPHP and deviceHelper.isRunNoneOrEditor()then
loginModel:requestPHPCfg()
end

if webGLHelper:isRunWebGL()then
webGLHelper:downLoadBaseGroup()
end
if loginControl:getOpenServerListFlag()then
loginControl:setOpenServerListFlag(false)
self:onChangeServerClick()
end
end


function UILogin:OnEnable()

end


function UILogin:OnDisable()

end


local _zslogoBundle='ui/windows/login/sharedtextures/image_taptaplogo_4.ab'
local _zsAsset='image_taptaplogo_4'


function UILogin:showLogoTitle()
local offset={0,110}
local vis=_AppConfig_GetBool('enableLoginLogo',true)
self.logoTitle:setActive(vis)
if vis then
local CustomLogoCf=channelHelper.getCustomLogoCfg()
if CustomLogoCf then
self.logoTitle:setSprite(CustomLogoCf._xllogoBundle,CustomLogoCf._xllogoAsset)
else
local abName=_zslogoBundle
local imageName=_zsAsset
local loginParam
local specialParam=loginModel:getSpecialLoginWinParam()
local pfDefaultParam=loginModel:getPfDefaultLoginWinParam()
if specialParam then
loginParam=specialParam
elseif pfDefaultParam then
loginParam=pfDefaultParam
end

if loginParam then
if loginParam.logoAbName and loginParam.logoName then
abName=loginParam.logoAbName
imageName=loginParam.logoName
end
if loginParam.logoOffset then
offset=loginParam.logoOffset
end
end
self.logoTitle:setSprite(abName,imageName)
end

self.logoTitle:setChildAnchoredPos(offset[1],offset[2])
end
end

function UILogin:showUserName()
local active=deviceHelper.isRunNoneOrEditor()
self.userName:setActive(active)
if active then
local userid=userGlobalSetting.get('userid',loginModel.userid)
self.userName:setInputFieldValue(userid or'')
end
end

function UILogin:showServerObj()
local server_name=''
local server_sign='<切换>'
local statusType
local serverWidget=self.serverObj:getChildWidgetBase()
if deviceHelper.isRunNoneOrEditor()then
self.local_cur_serveStr=userGlobalSetting.get('server_ip',loginModel.server_ip_string)
local name,sid,ip,port,status=string.match(self.local_cur_serveStr or'',loginModel.matchStr)
if name then
server_name=FMT.fmt("{0}服 {1}",sid,name)
end
statusType=loginConfig.getStatusType(status or 0)
else
local curSeverStr=loginModel.server_ip_string
local name,sid,ip,port,status=string.match(curSeverStr or'',loginModel.matchStr)
server_name=name or''
statusType=loginConfig.getStatusType(status or 0)
end

local specialParam=loginModel:getSpecialLoginWinParam()
local serverInfoColor=_serverInfoColorDefault
if specialParam and specialParam.serverInfoColor then
serverInfoColor=specialParam.serverInfoColor
end

server_name=toColorStringX(serverInfoColor[1],server_name)
server_sign=toColorStringX(serverInfoColor[2],server_sign)

local isNomal=statusType~=2 and statusType~=3
serverWidget:SetChildActive(0,isNomal)
serverWidget:SetChildActive(2,statusType==2)
serverWidget:SetChildActive(3,statusType==3)

serverWidget:SetChildText(1,server_name)

serverWidget:SetChildText(5,server_sign)


if verifyManager:isOpen()then
serverWidget:SetChildActive(4,false)
serverWidget:SetChildActive(5,false)
end
end

function UILogin:showVersion()
if webGLHelper:isRunWebGL()or webGLHelper:isRunDouYinNative()then
local vstr=webGLHelper:getVersionString()
self.version:setText(vstr)
return
end
local vision_str=''
local version=_GetResourceVersion()
local apiLevel=deviceHelper.getAPILevel()
if deviceHelper.isRunNoneOrEditor()then
vision_str=FMT.fmt('游戏版本：{0}_{1}\n测试中项目不代表最终品质',version,apiLevel)
else
vision_str=FMT.fmt('游戏版本：{0}_{1}',version,apiLevel)
end
local specialParam=loginModel:getSpecialLoginWinParam()
local serverInfoColor=_serverInfoColorDefault
if specialParam and specialParam.serverInfoColor then
serverInfoColor=specialParam.serverInfoColor
end
vision_str=toColorStringX(serverInfoColor[3],vision_str)

if verifyManager:isHideVersion()then
vision_str=''
end
self.version:setText(vision_str)
end

function UILogin:showBottomTips()
if verifyManager:isCustomQualification()then
local str=verifyData:getCustomQualification()
self.bottomTips:setText(str)
return
end
local tips_str='健康游戏忠告：抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。'
local isshow=houtaiModel:showCopyRightInfo()
local contentInfo=houtaiModel:getContentInfo()
local line_str3
local strlist={}
platformSDK.printSDK("requestPHPCfg3",isshow)
if isshow then
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showZhuZuoQuanRen)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showZhuZuoQuanRen)
table.insert(strlist,args.name)
end
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showYunYingDanWei)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showYunYingDanWei)
table.insert(strlist,args.name)
end
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showChuBanDanWei)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showChuBanDanWei)
table.insert(strlist,args.name)
end
local line_str1
if#strlist>0 then
line_str1=table.concat(strlist,"　")
end

strlist={}
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showShenPiWenHao)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showShenPiWenHao)
table.insert(strlist,args.name)
end
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showISBM)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showISBM)
table.insert(strlist,args.name)
end
if functionMaskController:checkFuncMask_pt(FUNCTION_MASK_TYPE.showZhuZuoQuanDengJiHao)then
local args=functionMaskController:getFuncMaskArgs(FUNCTION_MASK_TYPE.showZhuZuoQuanDengJiHao)
table.insert(strlist,args.name)
end
local line_str2
if#strlist>0 then
line_str2=table.concat(strlist,"　")
end

strlist={}









if contentInfo and contentInfo.content1 then
table.insert(strlist,contentInfo.content1)
else
table.insert(strlist,tips_str)
end
if contentInfo and contentInfo.content2 then
table.insert(strlist,contentInfo.content2)
else
if line_str1~=nil then
table.insert(strlist,line_str1)
end
end
if contentInfo and contentInfo.content3 then
table.insert(strlist,contentInfo.content3)
else
if line_str2~=nil then
table.insert(strlist,line_str2)
end
end

line_str3=table.concat(strlist,"\n")
else
line_str3=tips_str
end
platformSDK.printSDK("requestPHPCfg4",line_str3)
self.bottomTips:setText(line_str3)
end

function UILogin:showRuleObj()
local ruleWidget=self.ruleObj:getChildWidgetBase()


if verifyManager:isHideRuleTick()then
ruleWidget:SetChildActive(0,false)
ruleWidget:SetChildActive(1,false)
local tick=true
userGlobalSetting.record('loginRuleTick',tick,false)
return
end

local tick=loginModel.roleRuleTick or false
local tick=userGlobalSetting.get('loginRuleTick',false)
ruleWidget:SetChildActive(0,tick)
end

function UILogin:freshServerList()
self:showServerObj()
if autoLoginHelper:isAutoLogin()and autoLoginHelper:isInAllowAutoLoginCount()then
self:onLoginClick()
autoLoginHelper:addAutoLoginCount()
end
end



function UILogin:onLoginClick()
if self.showRule then
local tick=userGlobalSetting.get('loginRuleTick',false)
if not tick then
UIManager.error('请勾选用户协议')
return
end
end


if self.lastReqTime then
local curTime=os.time()
local left=curTime-self.lastReqTime
if left>=7 then
if _reqLoadCDN then
_reqLoadCDN=false
end
socketManager:Disconnect()
end
end

if loginControl:isBuildConnect()or _reqLoadCDN then
UIManager.info("正在连接服务器")
return
end
self.lastReqTime=os.time()

if socketManager.connecting then return end

if deviceHelper.isRunEditor()then
self:doLocalLoginClick()
elseif deviceHelper.isRunNonePlatform()then
_reqLoadCDN=true
local callback=function()
_reqLoadCDN=false
self:doLocalLoginClick()
end
updateControl.checkUpdate(callback)
else
logPoint.UploadLog(logPoint.logType.reqLoginGame_clickentergame)
_reqLoadCDN=true
local callback=function()
loginControl:requestLogin(function(flag)
_reqLoadCDN=false
end)
end
updateControl.checkUpdate(callback)
end
end

function UILogin:resetReqStatus()
self.lastReqTime=nil
_reqLoadCDN=false
end

function UILogin:doLocalLoginClick()
local ip_text=self.local_cur_serveStr
if ip_text==nil or ip_text==''then
UIManager.error('请选择服务器')
return
end
if not CommonController.CheckLoginClick()then
return
end
local userid=self.userName:getInputFieldValue()
loginModel:setUserName(tostring(userid))
loginModel:setUserId(tostring(userid))
loginModel:setSelectServer_ip(ip_text)

loginLocal.connect_server()
end


function UILogin:onChangeServerClick()
if deviceHelper.isRunSDK()then
if not loginModel.isLogin or loginModel:isLoginSDKInfoNull()then
local stamp=os.time()
if self.oldReqStamp and(stamp-self.oldReqStamp)<3 then return end
self.oldReqStamp=stamp
loginModel.isLogin=false
platformSDK:reqLogin()
return
end
end
if loginControl:isBuildConnect()or socketManager.connecting then
UIManager.info("正在连接服务器")
return
end

UIManager:showWindow('UILoginServerListWin')
logPoint.UploadLog(logPoint.logType.reqLoginGame_clickChoiceServer)
end

function UILogin:onNoticeBtn(auto)
if verifyManager:isOpen()then
return
end
UIManager:showWindow('UIGongGaoWin')
if not auto then
logPoint.UploadLog(logPoint.logType.reqLoginGame_clickGongGao)
end
loginControl.isnotice=false
end

function UILogin:onUserClick()
UIManager:showWindow('UIAgreementWin',{userType=USER_TYPE.eUserProtocol})
end

function UILogin:onPrivateClick()
UIManager:showWindow('UIAgreementWin',{userType=USER_TYPE.ePrivateProtected})
end

function UILogin:onRuleTickClick()
local tick=userGlobalSetting.get('loginRuleTick',false)
tick=not tick
userGlobalSetting.record('loginRuleTick',tick,false)
self:showRuleObj()
end

function UILogin:onAgeTips()
UIManager:showWindow('UIAgeTipsWin')
end

function UILogin:onWxKeFuBtn()
if webGLHelper:isShowCustomerServiceButton()then
platformSDK:reqCustomerService()
end
end

function UILogin:onCleanBtn()
if webGLHelper:isShowCleanButton()then
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content='确定要清理缓存并重启游戏吗？',
okcb=function()
webGLHelper:clearAssetBundleAndRestartGame()
end
})
dialogue:show()
end
end



function UILogin:checkPFWindowsShow()
local ageImagestate=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hideageImageTips)
self.ageTips:setActive(ageImagestate)
local bottomTipsstate=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hidejiankangzhonggao)
self.bottomTips:setActive(bottomTipsstate)
local ruleObjState=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hidePrivacyAgreement)
self.ruleObj:setActive(ruleObjState)
local tick=userGlobalSetting.get('loginRuleTick',false)
if not tick and not ruleObjState then
tick=true
userGlobalSetting.record('loginRuleTick',tick,false)
end
self.showRule=ruleObjState
local saomapc=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.saomapc)
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
saomapc=false
end
self.FTSaoMaBtn:setActive(saomapc)
end


function UILogin:onSdkusercenter()
platformSDK:reqShowUserCenter()
end


function UILogin:onPchelperBtn()
if api_Available_pcCopyLogToDesktop()then
CS.GameInterface.pcCopyLogToDesktop()
end
end


function UILogin:PC_ShowHelperBtn()
if api_Available_pcCopyLogToDesktop()and pfCommonHelper:isRunPC()then
self.pchelperBtn:setActive(true)
end
end


function UILogin:PC_HideHelperBtn()
if api_Available_pcCopyLogToDesktop()and pfCommonHelper:isRunPC()then
self.pchelperBtn:setActive(false)
end
end


function UILogin:onFTSaoMaBtn()
platformSDK:showEfunOpenScan()
end


function UILogin:onSwitchBtn()
loginControl:loginout()
end

function UILogin:onDelBtn()
platformSDK:invoke("reqDelAccount")
end


function UILogin:ShowSwitchBtn()
local flag=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.switchAccount)
self.switchBtn:setActive(flag)
end


function UILogin:ShowDelBtn()
local data=houtaiModel:getZhanghaozhuxiaoData()
local ynIosTiShen=verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()and deviceHelper.isRunIOS()
local flag=data.isOpen or ynIosTiShen
self.delBtn:setActive(flag)
end



function UILogin:ShowSwitchZoneBtn()
if verifyManager:isHideBindAccount()then
self.switchZoneBtn:setActive(false)
return
end
local flag=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.switchZone)
self.switchZoneBtn:setActive(flag)
end


function UILogin:onSwitchZoneBtn()
local win=UIManager:findActiveWindow("UISwitchZoneWin")
if win then
UIManager:closeWindow('UISwitchZoneWin')
else
UIManager:showWindow('UISwitchZoneWin')
end
end
