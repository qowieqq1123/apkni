








shequController=gameState.addListener({})



local _httpGetRequest=CS.ResourceHelper.HttpGetRequest

function shequController:onAppStart()

shequModel:onAppStart()









end


function shequController:onEnterState(isReconnect)
shequModel:onEnterState()
end


function shequController:onProtocolReq()
shequModel:onProtocolReq()


end


function shequController:onLeaveState(isReconnect)
shequModel:onLeaveState(isReconnect)

self.data={}
end


function shequController:onLostConnection()

end


function shequController:onReConnection(isInitPro)

end

































