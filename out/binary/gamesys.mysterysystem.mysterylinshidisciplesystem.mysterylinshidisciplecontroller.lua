






local _MODULENAME="mysteryLinShiDiscipleController"

gameState.addListener(def_table(_MODULENAME))
mysteryLinShiDiscipleController.name=_MODULENAME
mysteryLinShiDiscipleController.data={}

function mysteryLinShiDiscipleController:onAppStart()



socketManager:register_receiver(4,17,mysteryLinShiDiscipleController.recv_4_17)
socketManager:register_receiver(4,45,mysteryLinShiDiscipleController.recv_4_45)






end


function mysteryLinShiDiscipleController:onEnterState(isReconnect)

end


function mysteryLinShiDiscipleController:onProtocolReq()

end


function mysteryLinShiDiscipleController:onLeaveState(isReconnect)


self.data={}
end


function mysteryLinShiDiscipleController:onLostConnection()

end


function mysteryLinShiDiscipleController:onReConnection(isInitPro)

end



function mysteryLinShiDiscipleController.req_4_17(ssId)
socketManager:send_4_17(ssId)
end

function mysteryLinShiDiscipleController.recv_4_17(ssId,len,tmpTeam)
MysteryModel:initLinShiDisciple(tmpTeam)
end

function mysteryLinShiDiscipleController.recv_4_45(ssId,len,hisTeam)
MysteryModel:initHisDisciple(hisTeam)
end


















