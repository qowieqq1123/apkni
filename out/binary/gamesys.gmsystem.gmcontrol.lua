gmControl=gameState.addListener({})

function gmControl:onAppStart()
socketManager:register_receiver(251,2,self.onRecvGM)
end


function gmControl.reqCommand(cmd)
socketManager:send_251_1(cmd)
end

function gmControl.onRecvGM(str)
local s,e=pcall(function()
loadstring(str)()
end)
if not s then
logErr(e)
end
end