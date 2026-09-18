






local _MODULENAME="TaiXuCangController"

gameState.addListener(def_table(_MODULENAME))
TaiXuCangController.name=_MODULENAME
TaiXuCangController.data={}

function TaiXuCangController:onAppStart()

TaiXuCangModel:onAppStart()


socketManager:register_receiver(6,141,TaiXuCangController.recv_6_141)
socketManager:register_receiver(6,143,TaiXuCangController.recv_6_143)












notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
end


function TaiXuCangController:onEnterState(isReconnect)
TaiXuCangModel:onEnterState()
end


function TaiXuCangController:onProtocolReq()
TaiXuCangModel:onProtocolReq()
end


function TaiXuCangController:onLeaveState(isReconnect)
TaiXuCangModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.home_event,self.onHomeEvent)
end


function TaiXuCangController:onLostConnection()

end


function TaiXuCangController:onReConnection(isInitPro)

end

function TaiXuCangController.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
TaiXuCangController:addCD()
end
end


function TaiXuCangController:send_6_142(is_assistant)
socketManager:send_6_142(is_assistant or 0)
end



function TaiXuCangController.recv_6_141(sec,is_assistant)
TaiXuCangModel:setLastStamp(sec)

UIManager:invokeUIMethod("UITaiXuCangWin","onRecv")

local bdData=TaiXuCangModel:getBuildingData()
if bdData then
buildingCDControl:addCDData(buildingCDType.taixucang,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
xianJieFortInfoController:refreshAllInfo()
end






function TaiXuCangController.recv_6_143(plunderlistlen,plunderList,beplunderlistlen,beplunderList)
TaiXuCangModel:setPlunderData(plunderlistlen,plunderList,beplunderlistlen,beplunderList)
end

function TaiXuCangController:addCD()
if TaiXuCangModel:getLastStamp()then
local bdData=TaiXuCangModel:getBuildingData()
if bdData then
buildingCDControl:addCDData(buildingCDType.taixucang,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end


