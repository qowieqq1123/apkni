autoLoginHelper={}

function autoLoginHelper:init()


self.autoLogin=webGLHelper:isRunWeiXin()
or webGLHelper:isRunHuaWeiMiniGame()
or webGLHelper:isRunAlipayMiniGame()
or(deviceHelper.isRunPC and deviceHelper.isRunPC())
self.cfgAutoLogin=CS.AppDataModel.AppConfig_GetBool("isAutoLogin",false)
self.forbidAutoLogin=CS.AppDataModel.AppConfig_GetBool("forbidAutoLogin",false)

self.autoLoginCount=0

self.autoShowGongGaoCount=0
end


function autoLoginHelper:isAutoLogin()
if self.forbidAutoLogin then
return false
end

if self.cfgAutoLogin then
return true
end

if verifyManager:isOpen()then
return false
end
if deviceHelper.isRunNonePlatform()then
return false
end
if(deviceHelper.isRunPC and deviceHelper.isRunPC())and(not pfwindowslController:checkIsGameVersion_guofu())then
return false
end
return self.autoLogin
end

function autoLoginHelper:hideLoginRule()
if webGLHelper:isRunAlipayMiniGame()then
return true
end

return false
end

function autoLoginHelper:addAutoLoginCount()
self.autoLoginCount=self.autoLoginCount+1
end

function autoLoginHelper:addAutoShowGGCount()
self.autoShowGongGaoCount=self.autoShowGongGaoCount+1
end

function autoLoginHelper:isInAllowAutoLoginCount()
return self.autoLoginCount<1
end

function autoLoginHelper:isInAllowAutoShowGGCount()
return self.autoShowGongGaoCount<1
end
