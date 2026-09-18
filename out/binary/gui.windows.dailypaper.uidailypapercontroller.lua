







UIDailyPaperController=gameState.addListener({})

local _init
local tempData

function UIDailyPaperController:onAppStart()
socketManager:register_receiver(0,3,UIDailyPaperController.recv_0_3)

socketManager:register_receiver(254,33,UIDailyPaperController.recv_254_33)
end

function UIDailyPaperController:onEnterState()
UIDailyPaperModel:onEnterState()
end

function UIDailyPaperController:onLeaveState(isReconnect)
_init=nil
UIDailyPaperModel:onLeaveState()
end

function UIDailyPaperController:onLostConnection()
if UIManager:isActive('UIZongmenDailyWin')then
local actorid_str=playerModel:getActorIDStr()
if tempData==nil then
tempData={}
end
local list=UIDailyPaperModel:getData()
local offlineTime=UIDailyPaperModel:getOfflineTime()
local lp=tempData[actorid_str]
if lp==nil then
lp={}
tempData[actorid_str]=lp
end
lp.list=table.deepCopy(list)
lp.offlineTime=offlineTime or 0
end
end

function UIDailyPaperController:onProtocolReq(isReconnect)
if isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
UIDailyPaperController:openDailyPaperWin()
end
end
end


function UIDailyPaperController:onOpenView(isReconnect)

if not isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
UIDailyPaperController:openDailyPaperWin()
end
end
end

function UIDailyPaperController.checkNeedDataIsInit()
local dzInit=UIDiscipleController:checkInit()

local bsIsOpen=shanmenModel:checkHaveShanmen()
local bsIsinit=true
if bsIsOpen then
local bsData=shanmenModel:getBaiShanData()
bsIsinit=bsData.isInit
end

local optionIsOpen=bsIsOpen and systemModel.isOpen(SYSTEM_DEFINE.eSectDecision)
local optionEventInit=true
if optionIsOpen then
local option=eventOptionModel.getOption()
optionEventInit=option.isInit
end

local emergenciesIsOpen=systemModel.isOpen(SYSTEM_DEFINE.eTuFaEvent)
local emergenciesInit=true
if emergenciesIsOpen then
emergenciesInit=emergenciesControl.isInit
end
return _init and dzInit and optionEventInit and bsIsinit and emergenciesInit
end


function UIDailyPaperController.recv_0_3(offline_time)
UIDailyPaperModel:setOfflineTime(offline_time)
end

function UIDailyPaperController.recv_254_33(len,offlineRecordList)
local has=len>0
if has then
UIDailyPaperModel:setData(offlineRecordList)
end
local lp=tempData
if lp~=nil then
local actorid_str=playerModel:getActorIDStr()
local data=tempData[actorid_str]
tempData[actorid_str]=nil
if data~=nil and not has then
local list=table.deepCopy(data.list)
local offlineTime=UIDailyPaperModel:getOfflineTime()or 0
offlineTime=offlineTime+data.offlineTime
UIDailyPaperModel:setData(list)
UIDailyPaperModel:setOfflineTime(offlineTime)
end
end
_init=true
end


function UIDailyPaperController:openDailyPaperWin()
local datas=UIDailyPaperModel:getData()
if#datas>0 then
local offline=UIDailyPaperModel:getOfflineTime()or 0
local overYear=offline>=gameUtilityModel.getGameYearSecond()
if overYear and systemModel.isOpen(SYSTEM_DEFINE.eOfflineRecord)then
msgWinControl:addMsgWin(msgWinType.eZMDailyPaper)
end
end
end