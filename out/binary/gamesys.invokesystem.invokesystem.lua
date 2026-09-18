




invokeSystem=gameState.addListener({})
local _GameInvokeInterface=CS.GameInvokeInterface


function invokeSystem:onAppStart()
_GameInvokeInterface.Instance:SetTable('invokeSystem')
end

function invokeSystem:onEnterState()

end

function invokeSystem:onLeaveState()

end


function invokeSystem.OnHRefClick(name,args)
chatLinkHelper.OnHRefClick(name,args)
end


function invokeSystem.OnMiniGmaeType(MiniGmaeType)
MiniGameController.OnMiniGmaeType(MiniGmaeType)
end


function invokeSystem.OnScreenResolutionChange(preWidht,preHeight,width,height)
notifySystem:postNotify(notifyConfig.screenSulotionChange,preWidht,preHeight,width,height)
end


function invokeSystem.OnLowMemory()
resourceUtility.releaseAll()
resourceUtility.clearAllCache(false)
resourceUtility.clearPoolCache()
end



function invokeSystem.OnDouYinHandleFeedStatus(state)
webGLHelper:OnDouYinHandleFeedStatus(state)
end



function invokeSystem.OnLoginMiniGmaeType(MiniGmaeType)
MiniGameController.OnLoginMiniGmaeType(MiniGmaeType)
end