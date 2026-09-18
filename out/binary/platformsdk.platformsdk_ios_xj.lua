

platformSDK_iOS_XJ=simple_class(platformSDK_iOS)

function platformSDK_iOS_XJ:__init(...)
self:addCallFunc('eToMicroCommunity','to_micro_community',nil)
end


function platformSDK_iOS_XJ:reqLogin()
platformSDK.printSDK('调用登录',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end


self.isReqLogin=stamp
self:callSDKFunc(iOSSDKCallType.eLogin,'')
end


function platformSDK_iOS_XJ:reqLogout(callback)
self:callSDKFunc(iOSSDKCallType.eLogout,'')
end

local reportTypeToSendType={
[sdkReportEnum.eCreateRoleReport]='1',
[sdkReportEnum.eEnterMainSceneReport]='2',
[sdkReportEnum.eLevelUpReport]='3',
}


function platformSDK_iOS_XJ:reqReport(typo,info)
if typo==sdkReportEnum.eCreateRoleReport or typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
local playerInfo=platformHelper:getPlayerInfo()
playerInfo=platformHelper.concat(info,playerInfo)
local data={}
data.rtype=reportTypeToSendType[typo]
data.server_id=playerInfo.json_sid
data.server_name=playerInfo.json_sname
data.role_id=playerInfo.json_roleid
data.role_name=playerInfo.json_rolename
data.party=playerInfo.json_xianmengname
data.party_id='0'
data.vip=playerInfo.json_viplevel
data.role_level=playerInfo.json_level
data.rebirth_time='0'
data.level_up_time=playerInfo.json_time
data.create_role_time=playerInfo.json_createtime
data.user_id=tostring(loginModel.userid)
data.user_name=loginModel.username
if typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
data.ingrained_balance=moneyModel.getMoney(eMoneyType.mtXianYu)
else
data.ingrained_balance=''
end
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReport,info)
end
end


function platformSDK_iOS_XJ:reqPay(id,count,params,subscribe)
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
data.amount=cfg.rmb*100
data.cp_order_no=platformHelper.getTradeId(id)
local attach=platformHelper.getPayAttach(id,params)
data.cp_ext=attach
data.product_id=self:getProductId(cfg.rmb)
data.product_name=cfg.name
data.product_num=count
data.product_desc=cfg.desc
data.product_price=cfg.rmb
data.ingrained_balance=moneyModel.getMoney(eMoneyType.mtXianYu)
data.game_callback=''

local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePay,info)
end


function platformSDK_iOS_XJ:reqPlayAD(adid,attach,callback)
local data={}
data.adid=adid
data.attach=attach
self.adData={info=data,callback=callback}
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePlayAD,info)
end

function platformSDK_iOS_XJ:reqOpenCommunity(sceneId)
local data={}
data.sceneId=sceneId
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eToMicroCommunity,info)
end

function platformSDK_iOS_XJ:reqOpenURL(url)
local data={}
data.url=url
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eOpenURL,info)
end



function platformSDK_iOS_XJ:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.uid=data.uid
phpParams.sign=data.sign


if loginModel.isLogin and data.username==loginModel.username then
loginModel:onfreshLoginInfo(data,phpParams,data.uid)
platformSDK.printSDK('登陆信息__刷新 LoginCallBack platformSDK_iOS_XJ')
else
loginModel:onLogin(data,phpParams,data.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_iOS_XJ')
end
else
platformSDK.printSDK('登陆__失败',result)
end
end

function platformSDK_iOS_XJ:onLogoutCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
loginState:logout()
end
end
end

function platformSDK_iOS_XJ:onPayCallback(id,ftype,success,result)

end

function platformSDK_iOS_XJ:onPlayADCallback(id,ftype,success,result)
if not self.adData then
return
end
local data=jsonHelper.decode(result)
platformSDK.printSDK(FMT.fmt('广告回调 type:{0} info:{1}',data.type,data.info))
if data.type==13 then
local func=self.adData.callback
if func then
local info=self.adData.info
func(true,info)
end
self.adData=nil
elseif data.type==57 then

local func=self.adData.callback
if func then
local info=self.adData.info
func(true,info)
end
self.adData=nil
elseif data.type==58 then
local func=self.adData.callback

if func and data.info then
local adInfo=jsonHelper.decode(data.info)
if adInfo.rewarded then
local info=self.adData.info
func(true,info)
end
end
self.adData=nil
end
end
