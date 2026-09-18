

platformSDK_CSMG=simple_class()

local sdkHelper=CS.CSSDKHelper


function platformSDK_CSMG:__init(...)
self.sdkCallType={
eLogin='login',
eReport='report',
ePay='pay',
ePlayAD='play_ad',
eShare='share',
eMsgSecCheck='msg_sec_check',
eGetMiniGmaeID='minigame_id',
}
self.sdkCallBack={
[self.sdkCallType.eLogin]='onLoginCallback',
[self.sdkCallType.ePlayAD]='onPlayADCallback',
[self.sdkCallType.eMsgSecCheck]='onMsgSecCheck'
}
self.cbArgs={}
sdkHelper.SetSDKCallback(function(id,ftype,success,result)
platformSDK.printSDK('SDK回调',id,ftype,success,result)
self:callCBFunc(id,ftype,success,result)
end)
end

function platformSDK_CSMG:callCBFunc(id,ftype,success,result)
local func=self[self.sdkCallBack[ftype]]
if func then
func(self,id,ftype,success,result)
end
end

function platformSDK_CSMG:callSDKFunc(ftype,info)
local id=sdkHelper.CallSDKFunc(ftype,info)
platformSDK.printSDK('SDK调用',id,ftype,info)
return id
end

function platformSDK_CSMG:callSDKFuncSync(ftype,info)
platformSDK.printSDK('SDK同步调用',ftype,info)
return sdkHelper.CallSDKFuncSync(ftype,info)
end


function platformSDK_CSMG:addCallFunc(key,kName,cbName)
self.sdkCallType[key]=kName
self.sdkCallBack[kName]=cbName
end


function platformSDK_CSMG:setCallbackArgs(id,args)
self.cbArgs[id]=args
end

function platformSDK_CSMG:getCallbackArgs(id,blank)
local args=self.cbArgs[id]
if blank then
self.cbArgs[id]=nil
end
return args
end




function platformSDK_CSMG:reqLogin()

end


function platformSDK_CSMG:reqLogout(callback)

end


function platformSDK_CSMG:reqQuit(finishCallback)

end


function platformSDK_CSMG:reqRestart(delay)
_WXInterface.RestartMiniProgram(nil,nil,nil)
return 0
end


function platformSDK_CSMG:reqReport(typo,info)

end


function platformSDK_CSMG:reqPay(id,count,params,subscribe)

end


function platformSDK_CSMG:reqPlayAD(adid,attach,callback)

end


function platformSDK_CSMG:reqInit()

end

function platformSDK_CSMG:getBattery()
return 100,100,100;
end

function platformSDK_CSMG:getNetworkInfo(callback)
if callback then
_WXInterface.GetNetworkType(function(success,proxy,type,strength,error)
callback(type,strength)
end)
end
end

function platformSDK_CSMG:getAppVersion()
return''
end

function platformSDK_CSMG:reqReviews()

end




function platformSDK_CSMG:reqShareImage(path,shareType,platform)

end

function platformSDK_CSMG:reqShareVideo()

end

function platformSDK_CSMG:reqMsgSecCheck(scene,content,callback)
return 0
end

function platformSDK_CSMG:reqCustomerService()

end

function platformSDK_CSMG:reqSidebarCheck(callback)

end

function platformSDK_CSMG:reqNavigateToSidebar()

end

function platformSDK_CSMG:reqStartRecord(recordAudio,recordTime)

end

function platformSDK_CSMG:reqStopRecord()

end