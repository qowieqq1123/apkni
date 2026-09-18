function chatControl:onAppStart_share()
socketManager:register_receiver(254,76,self.recv_254_76)
end

function chatControl:onEnterState_share()

end

function chatControl:onLeaveState_share()

end


function chatControl.recv_254_76(typo)

end

function chatControl:reqShare(typo,params,channelIds,actorIds)
socketManager:send_254_76(typo,params,#channelIds,channelIds,#actorIds,actorIds)
end