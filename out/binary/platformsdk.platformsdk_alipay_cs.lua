

platformSDK_Alipay_CS=simple_class(platformSDK_WeiXin)

function platformSDK_Alipay_CS:__init(...)
self:addCallFunc('eReportLogin','report_login',nil)
self:addCallFunc('eCreateClubButton','create_game_club_button','onClubButtonClick')
self:addCallFunc('eCallClubButtonFunc','call_game_club_button_func','onCallClubButtonFunc')

self:reqReportGameEvent('reportLoadingCompleted')

self:callSDKFunc(webGLSDKCallType.eInit,'')
self.isSDKInit=true
end


function platformSDK_Alipay_CS:reqLogin()
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

function platformSDK_Alipay_CS:reqReportLogin()
platformSDK.printSDK('上报登录')
self:callSDKFunc(webGLSDKCallType.eReportLogin,'')
end


function platformSDK_Alipay_CS:reqLogout(callback)
self:onLogoutCallback()
end


function platformSDK_Alipay_CS:reqReport(typo,info)
if typo==sdkReportEnum.eCreateRoleReport
or typo==sdkReportEnum.eEnterMainSceneReport
or typo==sdkReportEnum.eLevelUpReport then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.action_type='CREATE_ROLE'
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.role_level=playerInfo.json_level
data.role_type=1
data.role_status=1
data.vip_level=1
data.gold=0
data.expand=''
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.eReport,info)
end

if typo==sdkReportEnum.eEnterMainSceneReport then
self:reqReportGameEvent('reportGamePlay')
end
end


function platformSDK_Alipay_CS:reqPay(id,count,params,subscribe)
if webGLHelper:getPlatformName()==webGLMGPlatform.ios then
UIManager.error('iOS充值服务正在接入中，当前暂不支持，敬请期待')
return
end
local playerInfo=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)
local cfg=cfg_rechargeconfig_get(id)
local data={}
data.role_id=playerInfo.json_roleid
data.server_id=playerInfo.json_sid
data.prop_id=''
data.sku_id=tostring(id)
data.buy_num=count
data.cp_order_id=platformHelper.getTradeId(id)
data.pay_amount=cfg.rmb*100*count
data.title=cfg.name
data.remark=cfg.desc
data.pay_callback_url='https://logpyzqzs.xw66.top/zfbxcxzs/payment/index'
data.expand=attach
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.ePay,info)
end


function platformSDK_Alipay_CS:reqMsgSecCheck(scene,content,callback)
local data={}
data.content=content
local info=jsonHelper.encode(data)
local id=self:callSDKFunc(webGLSDKCallType.eMsgSecCheck,info)
self:setCallbackArgs(id,callback)
return id
end


function platformSDK_Alipay_CS:reqPlayAD(adid,attach,callback)
local api='createRewardedAd'
if not self:isCanUse(api)then
logErr(FMT.fmt('{0}无法使用',api))
return
end
local data={}
data.adid=adid
data.attach=attach
self.adData={info=data,callback=callback}
local sdata={}
sdata.adUnitId='ad_tiny_2060170000359017_202411122200203871'
local info=jsonHelper.encode(sdata)
self:callSDKFunc(webGLSDKCallType.ePlayAD,info)
end

function platformSDK_Alipay_CS:isCanUse(schema)
local param={schema}
local res=self:callSDKAPISync('canIUse',param)
return res=='true'
end

function platformSDK_Alipay_CS:reqCreateClubButton(option)
local info=jsonHelper.encode(option)
local id=self:callSDKFunc(webGLSDKCallType.eCreateClubButton,info)
return id
end


function platformSDK_Alipay_CS:reqCallClubButtonFunc(id,func)
local data={}
data.id=id
data.func=func
local info=jsonHelper.encode(data)
self:callSDKFunc(webGLSDKCallType.eCallClubButtonFunc,info)
end

function platformSDK_Alipay_CS:reqReportGameEvent(name,param)
local data={}
data.name=name
data.param=param
local info=jsonHelper.encode(data)
local res=self:callSDKFuncSync('report_game_event',info)
return res
end



function platformSDK_Alipay_CS:onInitCallback(id,ftype,success,result)

self.initData=jsonHelper.decode(result)
end

function platformSDK_Alipay_CS:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.code=data.authCode
data.username=data.authCode
data.uid=data.uid or''


if loginModel.isLogin and data.username==loginModel.username then
loginModel:onfreshLoginInfo(data,phpParams,data.uid)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_Alipay_CS')
else
loginModel:onLogin(data,phpParams,data.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_Alipay_CS')
end


self:reqReportLogin()
else
platformSDK.printSDK('登陆__失败',result)
end
end

function platformSDK_Alipay_CS:onLogoutCallback(id,ftype,success,result)
local win=UIManager:findActiveWindow("UILogin")
if not win then
loginState:logout()
end
end

function platformSDK_Alipay_CS:onMsgSecCheck(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success)
end
end

function platformSDK_Alipay_CS:onPlayADCallback(id,ftype,success,result)
if success then
local data=jsonHelper.decode(result)
if data.isEnded then
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

function platformSDK_Alipay_CS:onClubButtonClick(id,ftype,success,result)
local data=jsonHelper.decode(result)
notifySystem:postNotify(notifyConfig.onWeiXinClubButtonClick,id,data)
end
