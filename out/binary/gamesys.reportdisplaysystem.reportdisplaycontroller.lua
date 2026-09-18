






local _MODULENAME="reportDisplayController"

gameState.addListener(def_table(_MODULENAME))
reportDisplayController.name=_MODULENAME
reportDisplayController.data={}


function reportDisplayController:onAppStart()
reportDisplayModel:onAppStart()
end


function reportDisplayController:onEnterState(isReconnect)
reportDisplayModel:onEnterState()
end


function reportDisplayController:onProtocolReq()
reportDisplayModel:onProtocolReq()
end


function reportDisplayController:onLeaveState(isReconnect)
reportDisplayModel:onLeaveState(isReconnect)

self.data={}
end


function reportDisplayController:onLostConnection()

end


function reportDisplayController:onReConnection(isInitPro)

end

function reportDisplayController:displayReport(eType,reportId,stageId,baseArgs,extraArgs)
if api_Available_SetChildFightRenderToImage()then
local handle=reportDisplayConfig:getHandle(eType)
local winParams={
baseParams=handle.baseParams(eType,reportId,stageId,baseArgs),
extraWin=handle.extraWin,
extraParams=handle.extraParams(eType,reportId,stageId,extraArgs),
}
UIManager:showWindow(handle.baseWin,winParams)
end
end