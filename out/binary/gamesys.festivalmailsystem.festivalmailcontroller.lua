






local _MODULENAME="festivalMailController"
gameState.addListener(def_table(_MODULENAME))

festivalMailController.name=_MODULENAME
festivalMailController.data={}

function festivalMailController:onAppStart()

festivalMailModel:onAppStart()


socketManager:register_receiver(254,86,festivalMailController.recv_254_86)
socketManager:register_receiver(254,87,festivalMailController.recv_254_87)














end


function festivalMailController:onEnterState(isReconnect)
festivalMailModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
end


function festivalMailController:onProtocolReq()
festivalMailModel:onProtocolReq()
end


function festivalMailController:onLeaveState(isReconnect)
festivalMailModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)

self.data={}
end


function festivalMailController:onLostConnection()

end


function festivalMailController:onReConnection(isInitPro)

end





function festivalMailController.recv_254_86(len,list)
if len>0 then
festivalMailModel:set_received_mail_list(list)
end
festivalMailController.tryReceiveMail()
timeEventController.addMinuteTimerHandler(festivalMailController.name,festivalMailController)
end



function festivalMailController.recv_254_87(id)
festivalMailModel:add_id_received_mail_list(id)
end




function festivalMailController.checkMailValid(id)
local cfg=cfgHelper.get1(cfg_jierimailconfig_get,id)
if not cfg then return false end
if cfg.flag and cfg.flag==1 then return false end
if not cfg.date_conf or not cfg.level then return false end
local nowTime=timeHelper.getServerLongTime()
local s_time,e_time=timeHelper.date2stamp(cfg.date_conf[1]),timeHelper.date2stamp(cfg.date_conf[2])
local s_level,e_level=cfg.level[1],cfg.level[2]
local zmLevel=zongmenModel:getLevel()or 0
if nowTime>=s_time and nowTime<=e_time and zmLevel>=s_level and zmLevel<=e_level then
return true
end
return false
end

function festivalMailController.tryReceiveMail()
local cfg=cfg_jierimailconfig()
local pfid=loginModel:getPfid()
for i,v in pairs(cfg)do
local id=v.id
local maskPfList=v.pfs or{}
if not maskPfList[pfid]and not festivalMailModel:check_received_mail_by_id(id)then
if festivalMailController.checkMailValid(id)then
socketManager:send_254_87(id)
end
end
end
end

function festivalMailController.on_level_change(level,exp)
festivalMailController.tryReceiveMail()
end


function festivalMailController:onMinuteUpdate(delay)

festivalMailController.tryReceiveMail()
end