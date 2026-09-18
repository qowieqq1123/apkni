






local _MODULENAME="CommonController"

gameState.addListener(def_table(_MODULENAME))
CommonController.name=_MODULENAME
CommonController.data={}

function CommonController:onAppStart()

CommonModel:onAppStart()









end


function CommonController:onEnterState(isReconnect)
CommonModel:onEnterState()
end


function CommonController:onProtocolReq()
CommonModel:onProtocolReq()
pfCommonHelper.openDayLoginPoint()
end


function CommonController:onLeaveState(isReconnect)
CommonModel:onLeaveState(isReconnect)

self.data={}
end


function CommonController:onLostConnection()

end


function CommonController:onReConnection(isInitPro)

end






local remianTimer
local _serverEndLongTime
local _serverAsyncLongTime
local _serverAsyncRealTime=math.floor(Time.realtimeSinceStartup)
local baseOffest=0




function CommonController.CountdownServerHandle()
local data=houtaiModel:getCountdownServerData()
platformSDK.printSDK("CountdownServerHandle",data and data.isOpen)
if data and data.isOpen then
CommonController.setCountdownServerTime(data)
if not CommonController.CheckGameIsReady()then
UIManager:showWindow('UICountdownServerWin')
end
else
UIManager:closeWindow('UICountdownServerWin')
end
end


function CommonController.getOpenTimeStr()
return timeHelper.dateServerStamp('%H:%M:%S %d/%m/%Y',_serverEndLongTime)
end


function timeHelper.dateServerStamp_PHP()
local ret=os.date('%H:%M:%S %d/%m/%Y',_serverEndLongTime)
return ret
end


function CommonController.remainTimeStr()
return timeHelper.format_time_stamp19(_serverEndLongTime-_serverAsyncLongTime,false)
end

function CommonController.JumpURL()
local data=houtaiModel:getCountdownServerData()
if data and data.jumpURL then
LuaApplication.GetApplication().OpenURL(data.jumpURL)
end
end


function CommonController.setCountdownServerTime(data)
_serverAsyncLongTime=data.cur_time
_serverEndLongTime=data.end_time+baseOffest
_serverAsyncRealTime=math.floor(Time.realtimeSinceStartup)

if _serverEndLongTime>_serverAsyncLongTime then
if remianTimer then return end
remianTimer=timer.new()
remianTimer:start(0.9,CommonController.update)
CommonController.update()
end
end

function CommonController.update()
local tempRealtimeSinceStartup=math.floor(Time.realtimeSinceStartup)
local _passTime=tempRealtimeSinceStartup-_serverAsyncRealTime
_serverAsyncLongTime=_serverAsyncLongTime+_passTime
_serverAsyncRealTime=tempRealtimeSinceStartup
if _serverAsyncLongTime>=_serverEndLongTime then
UIManager:closeWindow('UICountdownServerWin')
CommonController.stopTimer()
end
end

function CommonController.stopTimer()
if remianTimer~=nil then
remianTimer:Stop()
remianTimer=nil
end
end



function CommonController.CheckGameIsReady()
local data=houtaiModel:getCountdownServerData()
if not data or not data.isOpen then
return true
end
if _serverAsyncLongTime>=_serverEndLongTime then
return true
end
return false
end

function CommonController.CheckLoginClick()
if not CommonController.CheckGameIsReady()then
UIManager:showWindow('UICountdownServerWin')
return false
end
return true
end
