









shareImageController=gameState.addListener({})



function shareImageController:onAppStart()

shareImageModel:onAppStart()



socketManager:register_receiver(32,7,shareImageController.recv_32_7)






end


function shareImageController:onEnterState(isReconnect)
shareImageModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function shareImageController:onProtocolReq()
shareImageModel:onProtocolReq()
end


function shareImageController:onLeaveState(isReconnect)
shareImageModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)

self.data={}
end


function shareImageController:onLostConnection()

end


function shareImageController:onReConnection(isInitPro)

end

function shareImageController.onNewDay()

shareImageModel:clearShareRewardGotNumByType()

shareImageController:refreshShowShareRewardWin()
end



function shareImageController:reqGetShareImageReward(shareType)
socketManager:send_32_7(shareType)
end


function shareImageController.recv_32_7(shareType,getNum)
shareImageModel:setShareRewardGotNumByType(shareType,getNum)

shareImageController:refreshShowShareRewardWin()
end




function shareImageController:showShareImageWin(shareShowType,param)


local cfg=cfgHelper.get(cfg_shareimagebaseconfig_get,shareShowType)
if not param then
param={}
end
param.cfgId=shareShowType
local sharePrefabName=cfg.sharePrefabName
local shareRewardType=cfg.shareType
local args={
extra=sharePrefabName,
param=param,
cfgId=shareShowType,

share=function()
shareImageController:reqGetShareImageReward(shareRewardType)
end,
}
UIManager:showWindow("UIShareImageFrameWin",args)

end


function shareImageController:refreshShowShareRewardWin()
local winCfgList=cfg_shareimagerewardwintypeconfig()
for i,v in ipairs(winCfgList)do
UIManager:invokeUIMethod(v.winName,'refreshShareRewardShow')
end
end