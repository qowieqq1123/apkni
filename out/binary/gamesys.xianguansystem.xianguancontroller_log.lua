





function xianguanController:onAppStart_Log()
socketManager:register_receiver(35,78,self.recv_35_78)

notifySystem:listenNotify(notifyConfig.enterXianJie,self.enterXianJie)
end

function xianguanController:onEnterState_Log(isReconnect)
self.data.updateList={}
self.data.updateListLen=0

xianguanModel:onEnterState_Log(isReconnect)
end

function xianguanController:onLeaveState_Log(isReconnect)
self:clearUpdateList()

xianguanModel:onLeaveState_Log(isReconnect)
end



function xianguanController:req_tqUseRecord()
socketManager:send_35_78()
end

function xianguanController.recv_35_78(len,logList,src)
if src==1 then
xianguanModel:setServerLogList(len,logList)
elseif src==2 then
xianguanModel:addServerLogList(len,logList)
end
end


function xianguanController:updateLogShowSec()
local sec=timeHelper.getServerShortTime()
xianguanModel:writeLogShowSec(sec)
xianguanModel:updateNewFlag()
end

function xianguanController:checkHasNewLog()
local newLogList=xianguanModel:getLogList_New()
return newLogList and#newLogList>0
end


function xianguanController.enterXianJie()
xianguanController:checkShowMsg()
end

function xianguanController:checkShowMsg()
if xianguanController:checkHasNewLog()and xianguanHelper.checkClientCommonPlatformLimit()and self.isCanShowMsg then
msgWinControl:addMsgWin(msgWinType.eXianGuanTeQuanSketchyLog,{},{},true)
end
self.isCanShowMsg=false
end

function xianguanController:setPrepareShowMsg()
self.isCanShowMsg=true
end

