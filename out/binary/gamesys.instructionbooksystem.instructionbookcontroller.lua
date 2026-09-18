






local _MODULENAME="instructionbookController"

gameState.addListener(def_table(_MODULENAME))
instructionbookController.name=_MODULENAME


function instructionbookController:onAppStart()

instructionbookModel:onAppStart()







notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
end


function instructionbookController:onEnterState(isReconnect)
instructionbookModel:onEnterState()
end


function instructionbookController:onProtocolReq()
instructionbookModel:onProtocolReq()
end


function instructionbookController:onLeaveState(isReconnect)
instructionbookModel:onLeaveState(isReconnect)


end


function instructionbookController:onLostConnection()

end


function instructionbookController:onReConnection(isInitPro)

end






function instructionbookController.on_building_event(eventType,param1,param2,param3)
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then
instructionbookModel:triggerUnlockBigEqual(instructionbookModel.eConditionType.eZongmenLv,param3)
end
end

function instructionbookController.on_system_open(sysId)
instructionbookModel:triggerUnlockEqual(instructionbookModel.eConditionType.eSystemOpen,sysId)
end

function instructionbookController.onZongMengLevelChange(level,exp)
instructionbookModel:initData()
end

function instructionbookController:jumpTo(eType)
local cfg=cfgHelper.get1(cfg_instructionbookjumpconfig_get,eType)
if cfg then
local jumpParam={
id=JUMP_TYPE.eInstructionBook,
args={
mainId=cfg.main,
subId=cfg.sub,
}
}
jumpManager:jump(jumpParam)
else
loggerUtil.logErrFMT("无效说明书跳转类型: {0}",eType)
end
end