







function xianjieController:onAppStart_HitCount()
socketManager:register_receiver(35,126,xianjieController.recv_protocol_35_126)
end

function xianjieController:onEnterState_HitCount(isReconnet)
end

function xianjieController:onLeaveState_HitCount(isReconnet)
end





function xianjieController.recv_protocol_35_126(sceneid,len,actorList)
if len<=0 then return end


for index,info in ipairs(actorList)do
local actorID=info.param_1
local hitCount=info.param_2
xianjieModel:setZongMenLianZhan(actorID,hitCount)

notifySystem:postNotify(notifyConfig.onHitCountChange,sceneid,actorID,hitCount)
end
end


function xianjieController:setSelfActorHitCount_GM(count)
local actorID=playerModel:getActorID()
xianjieModel:setZongMenLianZhan(actorID,count)
notifySystem:postNotify(notifyConfig.onHitCountChange,nil,actorID,count)
end