

platformSDK_DouYin_XJ=simple_class(platformSDK_CSMG)

function platformSDK_DouYin_XJ:__init(...)
self:addCallFunc('eShareVideo','share_video',nil)
self:addCallFunc('eCustomerService','customer_service',nil)
self:addCallFunc('eSubscribeMessage','subscribe_message',nil)
self:addCallFunc('eSidebarCheck','sidebar_check','onSidebarCheck')
self:addCallFunc('eNavigateToSidebar','navigate_to_sidebar',nil)
self:addCallFunc('eStartRecord','start_record',nil)
self:addCallFunc('eStopRecord','stop_record',nil)
self:addCallFunc('eCheckCDKey','check_cdkey','onCheckCDKey')

self:addCallFunc('eGetUnionGroupInfo','get_union_group_info','onUnionGroupFunc')
self:addCallFunc('eBinUnionGroupInfo','bin_union_group','onUnionGroupFunc')
self:addCallFunc('eUnbinUnionGroupInfo','unbin_union_group','onUnionGroupFunc')
self:addCallFunc('eJoinUnionGroupInfo','join_union_group','onUnionGroupFunc')

self:addCallFunc('eRequestFeedSubscribe','request_feed_subscribe','onRequestFeedSubscribe')
self:addCallFunc('eCheckFeedSubscribeStatus','check_feed_subscribe_status','onCheckFeedSubscribeStatus')

self:addCallFunc('eReportScene','report_scene','onReportScene')

self:addCallFunc('eRequestLoginTime','request_login_time','onRequestLoginTime')

self:addCallFunc('eNavigateToMiniProgram','navigate_to_mini_program','onNavigateToMiniProgram')
self:addCallFunc('eIsTurn','IsTurn','onIsTurn')
self:addCallFunc('ePopupShow','PopupShow','onPopupShow')

self:addCallFunc('eShareAppMessage','ShareAppMessage','onShareAppMessage')
self:addCallFunc('eonShareAppMessage','onShareAppMessage','onOnShareAppMessage')
self:addCallFunc('eJoinGroup','JoinGroup','onJoinGroup')

local apiLevel=deviceHelper.getAPILevel()
if apiLevel>=161 then
self:addCallFunc('ePay','pay','onPayCallback')
end
end




function platformSDK_DouYin_XJ:reqLogin()
platformSDK.printSDK('调用登录',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
self:callSDKFunc(self.sdkCallType.eLogin,'')
self:callSDKFunc(self.sdkCallType.eonShareAppMessage,'')
end


function platformSDK_DouYin_XJ:reqLogout(callback)
self:onLogoutCallback()
end


function platformSDK_DouYin_XJ:reqQuit(finishCallback)

end


function platformSDK_DouYin_XJ:reqReport(typo,info)
platformSDK.printSDK('调用上报',typo)
if typo==sdkReportEnum.eCreateRoleReport
or typo==sdkReportEnum.eEnterMainSceneReport
or typo==sdkReportEnum.eLevelUpReport
or typo==sdkReportEnum.eExitGameReport then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
data.roleLevel=playerInfo.json_level
data.promotionId=''
data.roleTime=''
data.version='0'
data.rtype=typo
local info=jsonHelper.encode(data)
self:callSDKFuncSync(self.sdkCallType.eReport,info)
end
end


function platformSDK_DouYin_XJ:reqPay(id,count,params,subscribe)
platformSDK.printSDK('调用支付')
local cburl
if webGLHelper:isRunDouYinNative()or webGLHelper:checkPlatform(webGLMGPlatform.android)then
cburl='https://logpyzqzs.xw66.top/dyxcxzs/payment/index'
elseif webGLHelper:checkPlatform(webGLMGPlatform.ios)then
cburl='https://logpyzqzs.xw66.top/dyxcxzsios/payment/index'
end
if not cburl then
logErr('当前平台未定义充值回调')
return
end
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.vipLevel=playerInfo.json_viplevel
data.roleLevel=playerInfo.json_level
local cfg=cfg_rechargeconfig_get(id)
local amount=cfg.rmb*100*count
data.amount=tostring(amount)
local attach=platformHelper.getPayAttach(id,params)
data.attach=attach
data.productId=tostring(id)
data.productName=cfg.name
data.productDesc=cfg.desc
data.isTest='0'
data.cburl=cburl
local info=jsonHelper.encode(data)

if deviceHelper.getAPILevel()>=161 then
self:callSDKFunc(self.sdkCallType.ePay,info)
else
self:callSDKFuncSync(self.sdkCallType.ePay,info)
end
end


function platformSDK_DouYin_XJ:reqPlayAD(adid,attach,callback)
platformSDK.printSDK('开始播放广告',adid)
local data={}
data.adid=adid
data.attach=attach
local adData={info=data,callback=callback}
local sdata={advid='11'}
local info=jsonHelper.encode(sdata)
local id=self:callSDKFunc(self.sdkCallType.ePlayAD,info)
self:setCallbackArgs(id,adData)
end




function platformSDK_DouYin_XJ:reqShareImage(path,shareType,platform)
self:callSDKFuncSync(self.sdkCallType.eShare,'')
platformSDK.printSDK('分享游戏')
end

function platformSDK_DouYin_XJ:reqShareVideo()
self:callSDKFuncSync(self.sdkCallType.eShareVideo,'')
platformSDK.printSDK('分享视频')
end

function platformSDK_DouYin_XJ:reqMsgSecCheck(scene,content,callback)
local id=self:callSDKFunc(self.sdkCallType.eMsgSecCheck,content)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqCustomerService()
local data={}
data.type=3
local info=jsonHelper.encode(data)
self:callSDKFuncSync(self.sdkCallType.eCustomerService,info)
end

function platformSDK_DouYin_XJ:reqSidebarCheck(callback)
local id=self:callSDKFunc(self.sdkCallType.eSidebarCheck,'')
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqNavigateToSidebar()
self:callSDKFuncSync(self.sdkCallType.eNavigateToSidebar,'')
platformSDK.printSDK('打开侧边栏')
end

function platformSDK_DouYin_XJ:reqStartRecord(recordAudio,recordTime)
local data={}
data.isRecordAudio=recordAudio
data.maxRecordTime=recordTime
local info=jsonHelper.encode(data)
self:callSDKFuncSync(self.sdkCallType.eStartRecord,info)
end

function platformSDK_DouYin_XJ:reqStopRecord()
self:callSDKFuncSync(self.sdkCallType.eStopRecord,'')
end

function platformSDK_DouYin_XJ:reqCheckCDKey(cdkey,callback)
local data={}
data.cdkey=cdkey
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eCheckCDKey,info)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqCheckCanUse(funcName)
local data={}
data.funcName=funcName
local info=jsonHelper.encode(data)
local ret=self:callSDKFuncSync('check_can_use',info)
return ret=='true'
end

function platformSDK_DouYin_XJ:reqUnionGroupFunc(ftype,guid,callback)
local ctype
if ftype=='get'then
ctype=self.sdkCallType.eGetUnionGroupInfo
elseif ftype=='bin'then
ctype=self.sdkCallType.eBinUnionGroupInfo
elseif ftype=='unbin'then
ctype=self.sdkCallType.eUnbinUnionGroupInfo
elseif ftype=='join'then
ctype=self.sdkCallType.eJoinUnionGroupInfo
end
if not ctype then
return-1
end
local unionId=tostring(guid)
local id=self:callSDKFunc(ctype,unionId)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqRequestFeedSubscribe(scene,contentIDs,callback)
local data={}
data.type='play'
data.scene=scene
if scene~=0 then
data.contentIDs=contentIDs
else
data.allScene=true
end
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eRequestFeedSubscribe,info)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqCheckFeedSubscribeStatus(scene,callback)
local data={}
data.type='play'
data.scene=scene
if scene==0 then
data.allScene=true
end
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eCheckFeedSubscribeStatus,info)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:reqReportScene(sceneId,costTime,callback)
if deviceHelper.getAPILevel()<351 then
return-1
end
if sceneId==7001 then
if self.check_report_7001 then
return
end
self.check_report_7001=true
end
local data={}
data.sceneId=sceneId
data.costTime=costTime
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eReportScene,info)
self:setCallbackArgs(id,callback)
return id
end



function platformSDK_DouYin_XJ:requestLoginTime(scene,callback)
if deviceHelper.getAPILevel()<360 then
return-1
end
local data={}
data.scene=scene
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eRequestLoginTime,info)
self:setCallbackArgs(id,callback)
return id
end

function platformSDK_DouYin_XJ:navigateToMiniProgram(appId,path,callback)
if deviceHelper.getAPILevel()<390 then
return-1
end
local data={}
data.appId=appId
data.path=path
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eNavigateToMiniProgram,info)
self:setCallbackArgs(id,callback)
return id
end


function platformSDK_DouYin_XJ:checkIsTurn()
local data={}
local playerInfo=platformHelper:getPlayerInfo()
if playerInfo then
data.roleId=playerInfo.json_roleid
else
data.roleId=0
end
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eIsTurn,info)
return id
end


function platformSDK_DouYin_XJ:PopupShow()
local data={}
local playerInfo=platformHelper:getPlayerInfo()
if playerInfo then
data.roleId=playerInfo.json_roleid
else
data.roleId=0
end
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.ePopupShow,info)
return id
end



function platformSDK_DouYin_XJ:ShareAppMessage()
local data={}
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eShareAppMessage,info)
return id
end


function platformSDK_DouYin_XJ:reqOpenCommunity()
local data={}
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(self.sdkCallType.eJoinGroup,info)
return id
end


function platformSDK_DouYin_XJ:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.uid=data.uid
phpParams.sign=data.sign
phpParams.token=data.token



if loginModel.isLogin and data.username==loginModel.username then
loginModel:onfreshLoginInfo(data,phpParams,data.uid)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_WeiXin_XJ')
else
loginModel:onLogin(data,phpParams,data.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_WeiXin_XJ')
end
else
platformSDK.printSDK('登陆__失败',result)
end
end

function platformSDK_DouYin_XJ:onLogoutCallback(id,ftype,success,result)
local win=UIManager:findActiveWindow("UILogin")
if not win then
loginState:logout()
end
end

function platformSDK_DouYin_XJ:onPayCallback(id,ftype,success,result)
if success then
platformSDK.printSDK('发起支付成功',result)
else
platformSDK.printSDK('发起支付失败',result)
local data=jsonHelper.decode(result)
if data.errCode==-15002 or data.errCode==-17001 then
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content='支付金额为非常规金额，请点击下方按钮联系客服解决！',
oktext='联系客服',
okcb=function()
platformSDK:reqCustomerService()
end
})
dialogue:show()
end
end
end

function platformSDK_DouYin_XJ:onPlayADCallback(id,ftype,success,result)
local adData=self:getCallbackArgs(id,true)
if success then
local data=jsonHelper.decode(result)
if data.complete then
local func=adData.callback
if func then
local info=adData.info
func(true,info)
end
platformSDK.printSDK('播放广告__完成',result)
end
platformSDK.printSDK('播放广告__成功',result)
else
platformSDK.printSDK('播放广告__失败',result)
end
end

function platformSDK_DouYin_XJ:onMsgSecCheck(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onSidebarCheck(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)

if success and callback then
local data=jsonHelper.decode(result)
if data.isExist then
callback(data.isExist)
end
end
end

function platformSDK_DouYin_XJ:onCheckCDKey(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onUnionGroupFunc(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onRequestFeedSubscribe(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onCheckFeedSubscribeStatus(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onReportScene(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onRequestLoginTime(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end

function platformSDK_DouYin_XJ:onNavigateToMiniProgram(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end


function platformSDK_DouYin_XJ:get_MiniGame_ID()
return self:callSDKFuncSync(self.sdkCallType.eGetMiniGmaeID,"")
end

local iocnname="act_entericon_98"

function platformSDK_DouYin_XJ:onIsTurn(id,ftype,success,result)
if success then
local data=jsonHelper.decode(result)
local isShow=data.jsonStr.isShow
platformSDK.printSDK('checkDYClientTransferOpenX',isShow)
if isShow and isShow=="True"then
self.guid=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eDYClientTransfer,iconname=iocnname,
getReddotFun=function()
return true
end})
end
end
end


function platformSDK_DouYin_XJ:onPopupShow(id,ftype,success,result)

end


function platformSDK_DouYin_XJ:onShareAppMessage(id,ftype,success,result)
platformSDK.printSDK('DouYinonShareAppMessage',success,result)
end

function platformSDK_DouYin_XJ:onOnShareAppMessage(id,ftype,success,result)
platformSDK.printSDK('onOnShareAppMessage',success,result)
end

function platformSDK_DouYin_XJ:onJoinGroup(id,ftype,success,result)
platformSDK.printSDK('onJoinGroup',success,result)
end
