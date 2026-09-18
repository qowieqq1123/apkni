

platformSDK_iOS_YZF=simple_class(platformSDK_iOS)


function platformSDK_iOS_YZF:reqLogin()
logErr('调用登录',self.isReqLogin)
if self.isReqLogin then return end
self.isReqLogin=true
self:callSDKFunc(iOSSDKCallType.eLogin,'')
end


function platformSDK_iOS_YZF:reqLogout(callback)
self:callSDKFunc(iOSSDKCallType.eLogout,'')

self:callCBFunc(0,iOSSDKCallType.eLogout,true,'true')
end


function platformSDK_iOS_YZF:reqReport(typo)
if typo==sdkReportEnum.eCreateRoleReport or typo==sdkReportEnum.eEnterServerReport
or typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.rtype=typo
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
if typo==sdkReportEnum.eEnterMainSceneReport or typo==sdkReportEnum.eLevelUpReport then
data.ingrained_balance=moneyModel.getMoney(eMoneyType.mtXianYu)
else
data.ingrained_balance=''
end
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.eReport,info)
end
end


function platformSDK_iOS_YZF:reqPay(id,count,params,subscribe)
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


function platformSDK_iOS_YZF:reqPlayAD(adid,attach,callback)
local playerInfo=platformHelper:getPlayerInfo()
local data={}
data.adid=adid
data.attach=attach
data.position=''
data.gift_id='AD'..platformHelper.getTradeId(adid)
data.server_id=playerInfo.json_sid
data.role_id=playerInfo.json_roleid
data.reward_name='观影礼包'
data.reward_num='1'
local info=jsonHelper.encode(data)
self:callSDKFunc(iOSSDKCallType.ePlayAD,info)
end



function platformSDK_iOS_YZF:onLoginCallback(id,ftype,success,result)
self.isReqLogin=false
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.player_uid=data.player_uid
phpParams.session=data.session
phpParams.ext=data.ext
data.username=data.player_uid
if loginModel.isLogin then
if data.username~=loginModel.username then
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

function platformSDK_iOS_YZF:onLogoutCallback(id,ftype,success,result)
self.isReqLogin=false
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
