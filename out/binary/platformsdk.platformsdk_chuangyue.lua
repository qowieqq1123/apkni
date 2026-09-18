platformSDK_ChuangYue=simple_class(platformSDK_Android)
local cjson=require'cjson'
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _writablePath=CS.GamePath.writablePath



function platformSDK_ChuangYue:reqInit()
local typeStr=androidReqType.eInit
androidTool.callFunc(typeStr)
end


function platformSDK_ChuangYue:reqLogin(callback)
local stamp=os.time()
if self.isReqLogin and(stamp-self.isReqLogin)<3 then return end
self.isReqLogin=stamp
local typeStr=androidReqType.eLogin
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_ChuangYue:reqSwitchLogin()
local typeStr=androidReqType.eSwitchLogin
androidTool.callFunc(typeStr)
end


function platformSDK_ChuangYue:reqLogout(callback)
local typeStr=androidReqType.eLogout
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr)
end


function platformSDK_ChuangYue:reqQuit(callback,args)
local typeStr=androidReqType.eReqExit
self:addFunc(typeStr,callback)
androidTool.callFunc(typeStr,args)
end


function platformSDK_ChuangYue:reqReport(typo,info)
local typeStr=androidReqType.eReport
local playerInfo=platformHelper:getPlayerInfo()
info=platformHelper.concat(info,playerInfo)
info.json_type=sdkReportStr[typo]
local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_ChuangYue:reqPay(id,count,params,subscribe)
local typeStr=androidReqType.ePay

local info=platformHelper:getPlayerInfo()
local attach=platformHelper.getPayAttach(id,params)

local cfg=cfg_rechargeconfig_get(id)
info.json_tradeId=platformHelper.getTradeId(id)
info.json_rmb=cfg.rmb
info.json_shop_desc=cfg.name
info.json_shop_name=cfg.name
info.json_shop_id=id
info.json_count=count
info.json_attach=attach

local jsonStr=jsonHelper.encode(info)
androidTool.callFunc(typeStr,jsonStr)
end


function platformSDK_ChuangYue:reqPlayAD(adid,attach,callback)
local typeStr=androidReqType.ePlayAD
local info=platformHelper:getPlayerInfo()
info.json_adid=adid
info.json_ext=attach
local jsonStr=jsonHelper.encode(info)
self:addArgsFunc(typeStr,attach,callback)
androidTool.callFunc(typeStr,jsonStr)
end





















function platformSDK_ChuangYue:reqReviews()

end


function platformSDK_ChuangYue:onInitCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
self.isInit=isSuccess
if not isSuccess then
self.isReqLogin=nil
end
end






function platformSDK_ChuangYue:onLoginCallBack(json,jsonStr)
platformSDK.printSDK('LoginCallBack platformSDK_ChuangYue,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
self.isReqLogin=nil
if isSuccess then
local info=cjson.decode(params)

local phpParams={}
phpParams.player_uid=info.uid
phpParams.session=info.token
phpParams.ext=info.ext

info.username=info.uid

if loginModel.isLogin then
if info.username~=loginModel.username then
loginControl:loginout()
logErr(string.format('账号异常登陆回调刷新 账号不匹配 旧账号：%s  刷新账号：%s',loginModel.username,info.username))
return
end
loginModel:setLoginSDKInfo(info)
platformSDK.printSDK('登陆__刷新 LoginCallBack platformSDK_ChuangYue')
else

loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('登陆__成功 LoginCallBack platformSDK_ChuangYue')
self:callFunc(androidReqType.eLogin)
end
end
self:clearFunc(androidReqType.eLogin)
end








function platformSDK_ChuangYue:onSwtichLoginCallBack(json,jsonStr)
platformSDK.printSDK('SwtichLoginCallBack platformSDK_ChuangYue,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
self.isReqLogin=nil
if isSuccess then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then

else
if not self:callFunc(androidReqType.eLogout,true)then
loginState:logout()
end
end


local phpParams={}
phpParams.player_uid=info.uid
phpParams.session=info.token
phpParams.ext=info.ext


info.username=info.uid

loginModel:onLogin(info,phpParams,info.uid)
platformSDK.printSDK('platformSDK_ChuangYue 切换登录成功')
self:callFunc(androidReqType.eLogin)

self:callFunc(androidReqType.eLogout)
else
platformSDK.printSDK('platformSDK_ChuangYue 切换登录失败:',info.errcode)
end
self:clearFunc(androidReqType.eLogin)
self:clearFunc(androidReqType.eLogout)
end


function platformSDK_ChuangYue:onLogoutCallBack(json,jsonStr)
local isSuccess=json.IsSuccess

self.isReqLogin=nil
if isSuccess then
loginModel:logout()
local win=UIManager:findActiveWindow("UILogin")
if win then
self:reqLogin()
else
if not self:callFunc(androidReqType.eLogout)then
loginState:logout()
end
end
end
self:clearFunc(androidReqType.eLogout)
platformSDK.printSDK('LogoutCallBack platformSDK_ChuangYue,param=%s,isShowLoginWindow=%s',tostring(jsonStr))
end


function platformSDK_ChuangYue:onPayCallBack(json,jsonStr)
platformSDK.printSDK(string.format('PayCallBack platformSDK_ChuangYue,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then

platformSDK.printSDK('支付成功')
else
platformSDK.printSDK('支付失败 返回信息=%s',tostring(jsonStr))
end
end


function platformSDK_ChuangYue:onReportCallBack(json,jsonStr)
local isSuccess=json.IsSuccess
if isSuccess then
platformSDK.printSDK('reportCallBack platformSDK_ChuangYue 成功')
else
platformSDK.printSDK(string.format('reportCallBack platformSDK_ChuangYue 失败：%s',jsonStr))
end
end


function platformSDK_ChuangYue:onExitCallBack(json,jsonStr)
platformSDK.printSDK(string.format('ExitCallBack platformSDK_ChuangYue,param=%s',tostring(jsonStr)))
self:callFunc(androidReqType.eReqExit,true)
androidTool.callFunc(androidReqType.eExit)
end



function platformSDK_ChuangYue:onKeyDownClick(json,jsonStr)
platformSDK.printSDK('OnKeyDown_NativeClick platformSDK_ChuangYue,num',json.JsonStr)
local hasExit=json.IsSuccess
local keycode='None'
if tonumber(json.JsonStr)==4 then
keycode='Escape'
if hasExit then
local data=platformHelper:getPlayerInfo()
local infoStr=jsonHelper.encode(data)
self:reqQuit(nil,infoStr)
return
end
end
platformHelper:onKeyDownClick(keycode)
end

function platformSDK_ChuangYue:onRealNameCallBack(json,jsonStr)

end




local _adType=
{
eErr=0,
eClick=1,
eLoaded=2,
eShow=3,
eSkipped=4,
eComplete=5,
eRewardVerify=6,
eReward=7,
eClose=8,
}


local handleAdErr=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
local errCode=info.errCode
local errMsg=info.errMsg
self:callArgsFunc(androidReqType.ePlayAD,attach,true,{false,info})
loggerUtil.logErrFMT('广告播放失败!adid:{0} errcode:{1} errMsg:{2}',adid,errCode,errMsg)
end

local handleAdClick=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('点击广告!adid:{0}',adid))
end

local handleAdLoaded=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('加载广告!adid:{0}',adid))
end

local handleAdShow=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('播放广告!adid:{0}',adid))
end

local handleAdSkiped=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('跳过广告!adid:{0}',adid))
end

local handleAdComplete=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('完成广告!adid:{0}',adid))
end

local handleAdRewardVerify=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
local rewardValid=info.rewardValid
local rewardAmount=info.rewardAmount
local rewardName=info.rewardName
local errCode=info.errCode
local errMsg=info.errMsg
loggerUtil.log(FMT.fmt('领取广告奖励确认!adid:{0} valid:{1} amount:{2} name:{3} errCode:{4} errMsg:{5}',
adid,tostring(rewardValid),rewardAmount,rewardName,errCode,errMsg))
end

local handleAdRewarded=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
local rewardValid=info.rewardValid
local rewardAmount=info.rewardAmount
local rewardName=info.rewardName
local rewardType=info.rewardType
local rewardPropose=info.rewardPropose
local errCode=info.errCode
local errMsg=info.errMsg

self:callArgsFunc(androidReqType.ePlayAD,attach,true,{rewardValid,info})

loggerUtil.log(FMT.fmt('领取广告奖励!adid:{0} valid:{1} amount:{2} name:{3} type:{4} propose:{5} errCode:{6} errMsg:{7}',
adid,tostring(rewardValid),rewardAmount,rewardName,rewardType,rewardPropose,errCode,errMsg))
end

local handleAdClose=function(self,info)
local adType=info.type
local adid=info.adid or'无'
local attach=info.attach
loggerUtil.log(FMT.fmt('关闭广告!adid:{0}',adid))
end

local _adfunc=
{
[_adType.eErr]=function(...)
handleAdErr(...)
end,
[_adType.eClick]=function(...)
handleAdClick(...)
end,
[_adType.eLoaded]=function(...)
handleAdLoaded(...)
end,
[_adType.eShow]=function(...)
handleAdShow(...)
end,
[_adType.eSkipped]=function(...)
handleAdSkiped(...)
end,
[_adType.eComplete]=function(...)
handleAdComplete(...)
end,
[_adType.eRewardVerify]=function(...)
handleAdRewardVerify(...)
end,
[_adType.eReward]=function(...)
handleAdRewarded(...)
end,
[_adType.eClose]=function(...)
handleAdClose(...)
end,
}


function platformSDK_ChuangYue:onPlayADCallBack(json,jsonStr)
platformSDK.printSDK('onPlayADCallBack platformSDK_ChuangYue,param=%s',tostring(jsonStr))
local isSuccess=json.IsSuccess
local params=json.JsonStr
local info=cjson.decode(params)
if isSuccess then
local adType=info.type
local func=_adfunc[adType]
if func then
func(self,info)
end
end
end

