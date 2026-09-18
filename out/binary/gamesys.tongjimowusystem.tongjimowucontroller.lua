






local _MODULENAME="TongJiMoWuController"

gameState.addListener(def_table(_MODULENAME))
TongJiMoWuController.name=_MODULENAME
TongJiMoWuController.data={}

function TongJiMoWuController:onAppStart()

TongJiMoWuModel:onAppStart()









end


function TongJiMoWuController:onEnterState(isReconnect)
TongJiMoWuModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function TongJiMoWuController:onProtocolReq()
TongJiMoWuModel:onProtocolReq()
TongJiMoWuController.checkAddAct()
end


function TongJiMoWuController:onLeaveState(isReconnect)
TongJiMoWuModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end


function TongJiMoWuController:onLostConnection()

end


function TongJiMoWuController:onReConnection(isInitPro)

end

function TongJiMoWuController.getTime()
local sTime=timeHelper.getServerShortTime()-10
local eTime=sTime+86400*100
return sTime,eTime
end

function TongJiMoWuController.checkAddAct()
if systemModel.isOpen(SYSTEM_DEFINE.eTongJiMoWu)then
local sTime,eTime=TongJiMoWuController.getTime()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eTongJiMoWu,sTime,eTime)
end
end

function TongJiMoWuController.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eTongJiMoWu then
local sTime,eTime=TongJiMoWuController.getTime()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eTongJiMoWu,sTime,eTime)
end
end






