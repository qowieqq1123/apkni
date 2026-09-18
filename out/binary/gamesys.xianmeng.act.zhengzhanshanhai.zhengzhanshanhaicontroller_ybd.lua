








function zhengzhanshanhaiController:onAppStart_yubeidui()
socketManager:register_receiver(20,246,self.recv_20_246)
socketManager:register_receiver(20,247,self.recv_20_247)
socketManager:register_receiver(20,248,self.recv_20_248)
socketManager:register_receiver(20,249,self.recv_20_249)
socketManager:register_receiver(20,251,self.recv_20_251)
socketManager:register_receiver(20,252,self.recv_20_252)


socketManager:register_receiver(44,246,self.recv_44_246)
socketManager:register_receiver(44,247,self.recv_44_247)
socketManager:register_receiver(44,248,self.recv_44_248)
socketManager:register_receiver(44,249,self.recv_44_249)
socketManager:register_receiver(44,251,self.recv_44_251)
socketManager:register_receiver(44,252,self.recv_44_252)
end


function zhengzhanshanhaiController:onEnterState_yubeidui(isReconnet)
zhengzhanshanhaiModel:onEnterStateModelYBD(isReconnet)
end


function zhengzhanshanhaiController:onLeaveState_yubeidui(isReconnet)
zhengzhanshanhaiModel:onLeaveStateModelYBD(isReconnet)
end



function zhengzhanshanhaiController:send_20_246(openflag)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_246(openflag)
else
socketManager:send_20_246(openflag)
end
end

function zhengzhanshanhaiController:send_20_247(ybdmoney)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_247(ybdmoney)
else
socketManager:send_20_247(ybdmoney)
end
end

function zhengzhanshanhaiController:send_20_248(ybdstage)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_248(ybdstage)
else
socketManager:send_20_248(ybdstage)
end
end

function zhengzhanshanhaiController:send_20_249(len,guildlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_249(len,guildlist)
else
socketManager:send_20_249(len,guildlist)
end
end

function zhengzhanshanhaiController:send_20_251(ybdstage,qbguid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_251(ybdstage,qbguid)
else
socketManager:send_20_251(ybdstage,qbguid)
end
end

function zhengzhanshanhaiController:send_20_252(guid,len,guildlist)



local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_252(guid,len,guildlist)
else
socketManager:send_20_252(guid,len,guildlist)
end
end




function zhengzhanshanhaiController.recv_20_246(openflag)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDOpenFlag(openflag)
end

function zhengzhanshanhaiController.recv_20_247(ybdmoney,reason)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDMoney(ybdmoney,reason)
end

function zhengzhanshanhaiController.recv_20_248(ybdstage)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDStage(ybdstage)
end

function zhengzhanshanhaiController.recv_20_249(len,guildlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDTeam(len,guildlist)
end

function zhengzhanshanhaiController.recv_20_251(len,allguildlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_getYBDAllList(len,allguildlist)
end

function zhengzhanshanhaiController.recv_20_252(guid,len,playerlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_inviteYBDTeam(guid,len,playerlist)
end



function zhengzhanshanhaiController.recv_44_246(openflag)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDOpenFlag(openflag)
end

function zhengzhanshanhaiController.recv_44_247(ybdmoney,reason)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDMoney(ybdmoney,reason)
end

function zhengzhanshanhaiController.recv_44_248(ybdstage)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDStage(ybdstage)
end

function zhengzhanshanhaiController.recv_44_249(len,guildlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeYBDTeam(len,guildlist)
end

function zhengzhanshanhaiController.recv_44_251(len,allguildlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getYBDAllList(len,allguildlist)
end

function zhengzhanshanhaiController.recv_44_252(guid,len,playerlist)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_inviteYBDTeam(guid,len,playerlist)
end



function zhengzhanshanhaiController.recv_changeYBDOpenFlag(openflag)
zhengzhanshanhaiModel:setybd_openflag(openflag)
end

function zhengzhanshanhaiController.recv_changeYBDMoney(ybdmoney,reason)
local old=zhengzhanshanhaiModel:getybd_ybdmoney()
zhengzhanshanhaiModel:setybd_ybdmoney(ybdmoney)
if reason==1 then
if old<ybdmoney then
UIManager.info("成功存入")
else
UIManager.info("成功取出")
end
end
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiSetWin","refreshshlnum")
notifySystem:postNotify(notifyConfig.onZZSHYBDMoneyChange,ybdmoney,old,reason)
end

function zhengzhanshanhaiController.recv_changeYBDStage(ybdstage)
zhengzhanshanhaiModel:setybd_ybdstage(ybdstage)
end

function zhengzhanshanhaiController.recv_changeYBDTeam(len,guildlist)
zhengzhanshanhaiModel:setybd_guildlist(len,guildlist)

UIManager:invokeUIMethod("UIXM_ZZSH_PvEMainWin","refreshSetbyd")
UIManager:invokeUIMethod("UIXM_ZZSH_PvPMainWin","refreshSetbyd")
end

function zhengzhanshanhaiController.recv_getYBDAllList(len,allguildlist)
zhengzhanshanhaiModel:setybd_Allguildlist(len,allguildlist)

if UIManager:isActive('UIXMZZSH_YuBeiDuiMainWin')then
UIManager.info("刷新成功")
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshDZlist")
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshtemnum")
else
UIManager:showWindow("UIXMZZSH_YuBeiDuiMainWin")
end
end

function zhengzhanshanhaiController.recv_inviteYBDTeam(guid,len,playerlist)





zhengzhanshanhaiModel:setybd_playerlist(guid,len,playerlist)
end
