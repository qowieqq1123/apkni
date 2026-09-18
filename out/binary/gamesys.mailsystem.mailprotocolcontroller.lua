







local _MODULENAME="mailProtocolController"
gameState.addListener(def_table(_MODULENAME))
mailProtocolController.name=_MODULENAME



function mailProtocolController:onAppStart()
socketManager:register_receiver(253,1,mailProtocolController.recv_253_1)
socketManager:register_receiver(253,2,mailProtocolController.recv_253_2)
end

function mailProtocolController:onEnterState()

end

function mailProtocolController:onLeaveState()
end




function mailProtocolController.req_mail_list()
socketManager:send_253_1()
end








function mailProtocolController.req_mail_oper(operType,operCount,mailIdList)
socketManager:send_253_2(operType,operCount,mailIdList)
end




function mailProtocolController.recv_253_1(operType,mailListLen,mailList)
if operType==eMailRecvOperType.eInit then
mailModel:clear_mail_list()
end

if not mailList then
return
end

local glableCfg=cfg_globalconfig_get(1)
local MaxCount=glableCfg.maxmail

for k,v in ipairs(mailList)do
if mailModel:get_eMailCount()<MaxCount then
mailModel:add_to_mail(v)
end
end


UIManager:invokeUIMethod("UIMailWin","refresh",{isInit=true,isSort=true})
notifySystem:postNotify(notifyConfig.on_mail_changed)
end








function mailProtocolController.recv_253_2(operType,operCount,mailIdList)
if not mailIdList then
return
end

if operType==eMailSendOperType.eRead then
mailModel:read_mail_list(mailIdList)
UIManager:invokeUIMethod("UIMailWin","updateMaildata",mailIdList)
elseif operType==eMailSendOperType.ePrize then
mailModel:read_mail_list(mailIdList)
mailModel:prize_mail_list(mailIdList)
UIManager:invokeUIMethod("UIMailWin","updateMaildata",mailIdList,true)

AudioManager.playAudio(503)
elseif operType==eMailSendOperType.eDelete then
mailModel:del_mail_list(mailIdList)
local args={}
args.isInit=true
args.reqData=true
args.index=1
UIManager:invokeUIMethod("UIMailWin","refresh",args)
end

notifySystem:postNotify(notifyConfig.on_mail_changed)
end

