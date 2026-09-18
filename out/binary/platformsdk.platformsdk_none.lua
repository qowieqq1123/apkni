







platformSDK_None=simple_class()


function platformSDK_None:__init(...)

end



function platformSDK_None:reqLogin()

end


function platformSDK_None:reqLogout(callback)

end


function platformSDK_None:reqQuit(finishCallback)

end


function platformSDK_None:reqRestart(delay)

end


function platformSDK_None:reqReport(typo,data)

end


function platformSDK_None:reqPay(data)
UIManager.error('非sdk模式无法请求支付')
end


function platformSDK_None:reqInit()

end


function platformSDK_None:getBattery()
return 100,100,1
end



function platformSDK_None:getNetworkInfo()
return"wifi",0
end

function platformSDK_None:reqPermission(permissions,code)

end

function platformSDK_None:hasPermission(permissions)
return true
end

function platformSDK_None:reqReviews()

end

function platformSDK_None:getAppVersion()
return''
end


function platformSDK_None:onKeyDownCallBack(keycode)
platformHelper:onKeyDownClick(keycode)
end