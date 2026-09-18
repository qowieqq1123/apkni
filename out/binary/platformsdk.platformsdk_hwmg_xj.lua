

platformSDK_HWMG_XJ=simple_class(platformSDK_CSMG)

function platformSDK_HWMG_XJ:__init(...)

end




function platformSDK_HWMG_XJ:reqLogin()
platformSDK.printSDK('调用登录',self.isReqLogin)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
self:callSDKFunc(self.sdkCallType.eLogin,'')
end


function platformSDK_HWMG_XJ:reqLogout(callback)
self:onLogoutCallback()
end


function platformSDK_HWMG_XJ:reqQuit(finishCallback)

end


function platformSDK_HWMG_XJ:reqReport(typo,info)
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


function platformSDK_HWMG_XJ:reqPay(id,count,params,subscribe)
platformSDK.printSDK('调用支付')
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
data.productDesc=cfg.desc or''
if subscribe then
data.productType='1'
else
data.productType='0'
end
data.isTest='0'
data.cburl=''
local info=jsonHelper.encode(data)
self:callSDKFuncSync(self.sdkCallType.ePay,info)
end


function platformSDK_HWMG_XJ:reqPlayAD(adid,attach,callback)
platformSDK.printSDK('开始播放广告')








end




function platformSDK_HWMG_XJ:reqShareImage(path,shareType,platform)

platformSDK.printSDK('分享游戏')
end

function platformSDK_HWMG_XJ:reqMsgSecCheck(scene,content,callback)



end

function platformSDK_HWMG_XJ:reqCustomerService()

end



function platformSDK_HWMG_XJ:onLoginCallback(id,ftype,success,result)
self.isReqLogin=nil
if success then
local data=jsonHelper.decode(result)
local phpParams={}
phpParams.uid=data.uid
phpParams.sign=data.sign


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

function platformSDK_HWMG_XJ:onLogoutCallback(id,ftype,success,result)
local win=UIManager:findActiveWindow("UILogin")
if not win then
loginState:logout()
end
end

function platformSDK_HWMG_XJ:onPlayADCallback(id,ftype,success,result)
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

function platformSDK_HWMG_XJ:onMsgSecCheck(id,ftype,success,result)
local callback=self:getCallbackArgs(id,true)
if callback then
callback(success,result)
end
end
