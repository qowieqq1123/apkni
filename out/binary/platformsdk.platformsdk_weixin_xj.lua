

platformSDK_WeiXin_XJ=simple_class(platformSDK_WeiXin)

function platformSDK_WeiXin_XJ:__init(...)
self.secCheckCBDict={}
self:addCallFunc('eCreateRole','create_role','onReportCallback')
self:addCallFunc('eEnterGame','enter_game','onReportCallback')
self:addCallFunc('eRoleLevelUp','role_level_up','onReportCallback')
self:addCallFunc('eExitGame','exit_game','onReportCallback')
self:addCallFunc('eTutorialFinish','tutorial_finish','onReportCallback')

self:addCallFunc('eCreateClubButton','create_game_club_button','onClubButtonClick')
self:addCallFunc('eCallClubButtonFunc','call_game_club_button_func','onCallClubButtonFunc')

self.reportFuncName=
{
[sdkReportEnum.eCreateRoleReport]=webGLSDKCallType.eCreateRole,
[sdkReportEnum.eEnterMainSceneReport]=webGLSDKCallType.eEnterGame,
[sdkReportEnum.eLevelUpReport]=webGLSDKCallType.eRoleLevelUp,
[sdkReportEnum.eExitGameReport]=webGLSDKCallType.eExitGame,
[sdkReportEnum.eTutorialFinish]=webGLSDKCallType.eTutorialFinish,
}

self:callSDKFunc(webGLSDKCallType.eInit,'')
end


function platformSDK_WeiXin_XJ:reqLogin()
platformSDK.printSDK('调用登录',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
if not self.isSDKInit then
platformSDK.printSDK('sdk未初始化')

self:callSDKFunc(webGLSDKCallType.eInit,'')
return
end
self:callSDKFunc(webGLSDKCallType.eLogin,'')
end


function platformSDK_WeiXin_XJ:reqLogout(callback)
self:onLogoutCallback()
end


function platformSDK_WeiXin_XJ:reqReport(typo,info)
if typo==sdkReportEnum.eCreateRoleReport
or typo==sdkReportEnum.eEnterMainSceneReport
or typo==sdkReportEnum.eLevelUpReport
or typo==sdkReportEnum.eExitGameReport
or typo==sdkReportEnum.eTutorialFinish then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
data.roleLevel=playerInfo.json_level
local info=jsonHelper.encode(data)
self:callSDKFunc(self.reportFuncName[typo],info)
end
end


function platformSDK_WeiXin_XJ:reqPay(id,count,params,subscribe)
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.vipLevel=playerInfo.json_viplevel
data.roleLevel=playerInfo.json_level
local cfg=cfg_rechargeconfig_get(id)
data.amount=cfg.rmb*100*count

local attach=platformHelper.getPayAttach(id,params)
data.attach=attach
data.productId=tostring(id)
data.productName=cfg.name
data.productDesc=cfg.desc
data.goodId=self:getPayGoodId(cfg.rmb)
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.ePay,info)
end

function platformSDK_WeiXin_XJ:getPayGoodId(rmb)
local cfg=cfgHelper.get1(cfg_weixinproductidconfig_get,rmb)
if cfg and cfg.enable then
return cfg.goodId
end
return nil
end


function platformSDK_WeiXin_XJ:reqPlayAD(adid,attach,callback)
local attachData=string.split(attach,'|')
local adcfg=cfgHelper.get1(cfg_advertconfig,attachData[1])
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.vipLevel=playerInfo.json_viplevel
data.roleLevel=playerInfo.json_level
data.amount=0

data.attach=attach
data.productId=tostring(adid)
data.productName=''
data.productDesc=''
data.adid=adid
data.advid=3
local customAdvid=webGLHelper:getPfAdvid()
if customAdvid then
data.advid=customAdvid
end
data.name=adcfg and adcfg.name or''
self.adData={info=data,callback=callback}
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.ePlayAD,info)
end

function platformSDK_WeiXin_XJ:reqShareImage(path,shareType,platform)
local data={}
local share_key=welfareModel:getSelfInvitationString()or''
data.query=FMT.fmt('shareKey={0}',share_key)
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.eShare,info)
end

function platformSDK_WeiXin_XJ:reqCustomerService()
self:callSDKFunc(webGLSDKCallType.eCustomerService,'')
end


function platformSDK_WeiXin_XJ:reqMsgSecCheck(scene,content,callback)
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.scene=scene
data.content=content or''
data.roleId=playerInfo.json_roleid
data.roleName=playerInfo.json_rolename
data.serverId=playerInfo.json_sid
data.serverName=playerInfo.json_sname
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(webGLSDKCallType.eMsgSecCheck,info)
self.secCheckCBDict[id]=callback
return id
end

function platformSDK_WeiXin_XJ:reqCreateClubButton(option)
local info=jsonHelper.encode(option)
local id=self:callSDKFunc(webGLSDKCallType.eCreateClubButton,info)
return id
end


function platformSDK_WeiXin_XJ:reqCallClubButtonFunc(id,func)
local data={}
data.id=id
data.func=func
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.eCallClubButtonFunc,info)
end

function platformSDK_WeiXin_XJ:getAppVersion()
local info=webGLHelper:getAccountInfoSync()
if info then
local version=info.miniProgram.version
return version
end
end



function platformSDK_WeiXin_XJ:onInitCallback(id,ftype,success,result)
if success then
self.isSDKInit=true
self.initData=jsonHelper.decode(result)


self:callSDKFunc(webGLSDKCallType.eGetShareConfig,'')

self:callSDKFunc(webGLSDKCallType.eOnShare,'')
else
logErr('SDK初始化失败',result)
end
end

function platformSDK_WeiXin_XJ:onShareConfigCallback(id,ftype,success,result)
local data=jsonHelper.decode(result)
webGLHelper:setShareConfig(data)
end

function platformSDK_WeiXin_XJ:onLoginCallback(id,ftype,success,result)
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

function platformSDK_WeiXin_XJ:onLogoutCallback(id,ftype,success,result)
local win=UIManager:findActiveWindow("UILogin")
if not win then
loginState:logout()
end
end

function platformSDK_WeiXin_XJ:onReportCallback(id,ftype,success,result)
if success then
platformSDK.printSDK('游戏上报__成功',ftype,result)
else
platformSDK.printSDK('游戏上报__失败',ftype,result)
end
end

function platformSDK_WeiXin_XJ:onPayCallback(id,ftype,success,result)
if success then
platformSDK.printSDK('支付__成功',result)
local rdata=jsonHelper.decode_josn(result)
if rdata and rdata.type=='qrcode'then
UIManager:showWindow('UIQRCodeWin',{url=rdata.url})
end
else
platformSDK.printSDK('支付__失败',result)
end
end

function platformSDK_WeiXin_XJ:onPlayADCallback(id,ftype,success,result)
if success then
local data=jsonHelper.decode(result)
if data.isEnded==1 then
local func=self.adData.callback
if func then
local info=self.adData.info
func(true,info)
end
self.adData=nil
platformSDK.printSDK('播放广告__完成',result)
end
platformSDK.printSDK('播放广告__成功',result)
else
platformSDK.printSDK('播放广告__失败',result)
end
end

function platformSDK_WeiXin_XJ:onShareCallback(id,ftype,success,result)

end

function platformSDK_WeiXin_XJ:onMsgSecCheck(id,ftype,success,result)
local callback=self.secCheckCBDict[id]
if not callback then
platformSDK.printSDK('内容安全监测返回找不到回调函数',id)
return
end
if success then
local data=jsonHelper.decode(result)
if data.pass==1 then
callback(true)
else
callback(false)
end
else
callback(false)
end
self.secCheckCBDict[id]=nil
end

function platformSDK_WeiXin_XJ:onClubButtonClick(id,ftype,success,result)
local data=jsonHelper.decode(result)
notifySystem:postNotify(notifyConfig.onWeiXinClubButtonClick,id,data)
end


function platformSDK_WeiXin_XJ:reqRestart(delay)
_WXInterface.RestartMiniProgram(nil,nil,nil)
return 0
end