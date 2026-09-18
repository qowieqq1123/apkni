

platformSDK_WeiXin_YZF=simple_class(platformSDK_WeiXin)

function platformSDK_WeiXin_YZF:__init(...)
self:addCallFunc('eEnterGame','enter_game','onReportCallback')
end


function platformSDK_WeiXin_YZF:reqLogin()
if self.isReqLogin then return end
self.isReqLogin=true
self:callSDKFunc(webGLSDKCallType.eLogin,'')
end


function platformSDK_WeiXin_YZF:reqReport(typo)
if typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.party=playerInfo.json_xianmengname
data.vip=playerInfo.json_viplevel
data.role_level=playerInfo.json_level
local info=jsonHelper.encode(data)
local funcName=typo==sdkReportEnum.eEnterMainSceneReport and webGLSDKCallType.eEnterGame or webGLSDKCallType.eReport
self:callSDKFunc(funcName,info)
end
end


function platformSDK_WeiXin_YZF:reqPay(id,count,params,subscribe)
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.party=playerInfo.json_xianmengname
data.vip=playerInfo.json_viplevel
data.role_level=playerInfo.json_level
local cfg=cfg_rechargeconfig_get(id)
data.amount=cfg.rmb*100*count
data.cp_order_no=platformHelper.getTradeId(id)
local attach=platformHelper.getPayAttach(id,params)
data.cp_ext=attach
data.product_id=tostring(id)
data.product_name=cfg.name
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.ePay,info)
end


function platformSDK_WeiXin_YZF:reqPlayAD(adid,attach,callback)
local data={AdType='RewardedVideoAd'}
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(webGLSDKCallType.eShowAD,info)
self:setCallbackArgs(id,{callback,attach})
end



function platformSDK_WeiXin_YZF:onLoginCallback(id,ftype,success,result)
logErr(ftype,success,result)
self.isReqLogin=false
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.player_uid=data.player_uid
phpParams.session=data.session
phpParams.ext=data.ext
data.username=data.player_uid
if loginModel.isLogin then
if info.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,data.username))
return
end
loginModel:setLoginSDKInfo(data)
platformSDK.printSDK('登陆__刷新',data.login_tip)
else
loginModel:onLogin(data,phpParams,data.player_uid)
platformSDK.printSDK('登陆__成功',data.login_tip)
end
else
platformSDK.printSDK('登陆__失败',result)
end
end

function platformSDK_WeiXin_YZF:onReportCallback(id,ftype,success,result)
logErr(ftype,success,result)
if success then
platformSDK.printSDK('游戏上报__成功',ftype,result)
else
platformSDK.printSDK('游戏上报__失败',ftype,result)
end
end

function platformSDK_WeiXin_YZF:onPayCallback(id,ftype,success,result)
logErr(ftype,success,result)
if success then
platformSDK.printSDK('支付__成功',result)
else
platformSDK.printSDK('支付__失败',result)
end
end

function platformSDK_WeiXin_YZF:onShowADCallback(id,ftype,success,result)
logErr(ftype,success,result)
if success then
platformSDK.printSDK('播放广告__成功',result)
else
platformSDK.printSDK('播放广告__失败',result)
end
local data=self:getCallbackArgs(id)
self:setCallbackArgs(id,nil)
data[1](success,{attach=data[2]})
end


function platformSDK_WeiXin_YZF:reqRestart(delay)
_WXInterface.RestartMiniProgram(nil,nil,nil)
return 0
end