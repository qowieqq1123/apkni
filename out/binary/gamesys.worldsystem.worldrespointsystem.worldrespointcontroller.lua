






local _MODULENAME="worldResPointController"




gameState.addListener(def_table(_MODULENAME))
worldResPointController.name=_MODULENAME


worldResPointController.data={}

local _this=worldResPointController
local _updating=false

function worldResPointController:onAppStart()
worldResPointBaseModel:onAppStart()
worldResPointDataModel:onAppStart()
worldResPointRandomLibraryModel:onAppStart()
worldResPointFightModel:onAppStart()

socketManager:register_receiver(5,41,self.recv_5_41)
socketManager:register_receiver(5,42,self.recv_5_42)
socketManager:register_receiver(5,43,self.recv_5_43)
socketManager:register_receiver(5,44,self.recv_5_44)
socketManager:register_receiver(5,45,self.recv_5_45)
socketManager:register_receiver(5,46,self.recv_5_46)

notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickUnitEvent)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDayEvent)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpenEvent)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChangedEvent)
notifySystem:listenNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChangedEvent)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish_s,self.onQiYuEventFinish)
notifySystem:listenNotify(notifyConfig.on_mystery_event_break,self.onQiYuEventBreak)
notifySystem:listenNotify(notifyConfig.on_mystery_close,self.onMysteryClose)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)

worldController:registerSceneState(1,1,self.onEnterWorldSceneEvent)
end


function worldResPointController:onEnterState()
worldResPointBaseModel:onEnterState()
worldResPointDataModel:onEnterState()
worldResPointRandomLibraryModel:onEnterState()
worldResPointFightModel:onEnterState()
end


function worldResPointController:onServerDataInitFinish()
worldResPointBaseModel:onServerDataInitFinish()
worldResPointDataModel:onServerDataInitFinish()
worldResPointRandomLibraryModel:onServerDataInitFinish()
worldResPointFightModel:onServerDataInitFinish()
end


function worldResPointController:onLeaveState(isReconnet)
worldResPointBaseModel:onLeaveState(isReconnet)
worldResPointDataModel:onLeaveState(isReconnet)
worldResPointRandomLibraryModel:onLeaveState(isReconnet)
worldResPointFightModel:onLeaveState(isReconnet)

self:stopUpdate()
end


function worldResPointController:onLostConnection()
self:stopUpdate()
end

function worldResPointController:onReConnection()
self:checkUpdate()
end

function worldResPointController:onProtocolReq()
if self:checkSystemOpen()then
self.onInitDataEvent()
end
end



function worldResPointController:checkSystemOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eWorldResPoint)
end

function worldResPointController:onNormalUpdate(delay)
worldResPointBaseModel:checkTimeData()
if not worldResPointBaseModel:checkExistTime()then
timeEventController.removeNormalTimerHandler(1,self.name)
_updating=false
end
end

function worldResPointController:checkUpdate()
if worldResPointBaseModel:checkExistTime()then
timeEventController.addNormalTimerHandler(1,self.name,self)
_updating=true
end
end

function worldResPointController:stopUpdate()
timeEventController.removeNormalTimerHandler(1,self.name)
_updating=false
end



function worldResPointController.gm_ClearAllPoint()
for guidStr,data in pairs(worldResPointDataModel.data)do
worldResPointController:hideResPointAllUnit(data.guid)
worldResPointDataModel:clearPointData(data.guid,true)
end
for world,temp in pairs(worldResPointDataModel.lookup)do
worldResPointRandomLibraryModel:clearRefreshTimer(world)
end
worldResPointDataModel:onLeaveState()
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end


function worldResPointController.gm_RefreshRandomPoint()
_this:doRefreshRandom()
end