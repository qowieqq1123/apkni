
function welfareModel:onAppStart_WXAddReward()

end

function welfareModel:onEnterState_WXAddReward(isReconnet)

end

function welfareModel:onLeaveState_WXAddReward(isReconnet)
self.WXAddRewardData=nil
end

function welfareModel:onProtocolReq_WXAddReward(isReconnet)

end

function welfareModel:onServerDataInitFinish_WXAddReward()

end

function welfareModel:onLostConnection_WXAddReward()

end

function welfareModel:getWXEnterFlag(index)
welfareController.checkWXAddReward()
return self.WXAddRewardData and self.WXAddRewardData[index]==1 or false
end

function welfareModel:getWXEnterID()
return webGLHelper:getLastOpenScene()
end

function welfareModel:setWXAddRewardData(data)
self.WXAddRewardData=data or{}
end

function welfareModel:getWXAddRewardData()

return self.WXAddRewardData
end

