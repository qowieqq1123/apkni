




systemTipsControl=gameState.addListener({})


function systemTipsControl:onAppStart()
socketManager:register_receiver(254,5,self.on_recv_mesg)
end




function systemTipsControl.on_recv_mesg(pos,msg)
if pos==1 then
UIManager.info(msg)
elseif pos==2 then
UIManager.error(msg)
elseif pos==4 then
UIManager.serverError(msg)
end
end
