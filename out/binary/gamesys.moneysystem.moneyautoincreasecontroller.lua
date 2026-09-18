







moneyAutoIncreaseController=gameState.addListener({})

local isInit=false
local _tempList={}

function moneyAutoIncreaseController:onAppStart()
socketManager:register_receiver(254,8,moneyAutoIncreaseController.do_protocol_254_8)
socketManager:register_receiver(254,9,moneyAutoIncreaseController.do_protocol_254_9)
end

function moneyAutoIncreaseController:onEnterState()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
isInit=false
moneyAutoIncreaseModel:initConfig()
end

function moneyAutoIncreaseController:onLeaveState()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
moneyAutoIncreaseModel:clearData()
end

function moneyAutoIncreaseController:onProtocolReq()
timeEventController.addNormalTimerHandler(1,'moneyAutoIncreaseController',moneyAutoIncreaseController)
end

function moneyAutoIncreaseController:onPlayerCreate(...)

end

function moneyAutoIncreaseController:onLostConnection()

end

function moneyAutoIncreaseController.on_building_event(eventType,sfId,ubdId)
if eventType==buildingEvent.levelUpComplete then
local buildingData=zongmenModel:getBuildingData(ubdId)
moneyAutoIncreaseModel:initMax(buildingData.build_id)
end
end

function moneyAutoIncreaseController.on_money_changed(moneyType)
if moneyType==eMoneyType.mtHunPo then
moneyAutoIncreaseModel:initMax(SLG_SYSTEM_TYPE.eLunHuiDian)
end
end

function moneyAutoIncreaseController:onNormalUpdate(delay)
if not isInit then return end



if#_tempList>0 then
local moneytype=_remove(_tempList,1)
if moneyAutoIncreaseModel:isNotMax(moneytype)and
moneyAutoIncreaseModel:checkConditionImp(moneytype)then
moneyAutoIncreaseController:reqAuto(moneytype)
end
else
local checklist=moneyAutoIncreaseModel:getCheckList()
_tempList=table.weakCopy(checklist,_tempList)
end
end




function moneyAutoIncreaseController:reqInfos()
socketManager:send_254_8()
end


function moneyAutoIncreaseController:reqAuto(moneytype)

if socketManager.connecting==false then return end
socketManager:send_254_9(moneytype)
end






function moneyAutoIncreaseController.do_protocol_254_8(len,moneyList)





moneyAutoIncreaseModel:initData(moneyList)
isInit=true
end


function moneyAutoIncreaseController.do_protocol_254_9(moneytype,checktm)



moneyAutoIncreaseModel:setCheckTime(moneytype,checktm)
end

