







gameUtilityControl=gameState.addListener({})

local gameYear=nil

local serverTimeEeventType={
eNewDay=1,
eNewDay5am=2,
eNewWeek=3,
eNewWeek5am=4,
eNewMonth=5,
eNewMonth5am=6,
eNewGameYear=7,
eNewDay_login=100,
eNewDay5am_login=200,
eNewWeek_login=300,
eNewWeek5am_login=400,
eNewMonth_login=500,
eNewMonth5am_login=600,
eNewGameYear_login=700,
}
local serverTimeEeventFunc={
[serverTimeEeventType.eNewDay]=function(...)
notifySystem:postNotify(notifyConfig.onNewDay,...)
end,
[serverTimeEeventType.eNewDay5am]=function(...)
notifySystem:postNotify(notifyConfig.onNewDay5am,...)
end,
[serverTimeEeventType.eNewWeek]=function(...)
notifySystem:postNotify(notifyConfig.onNewWeek,...)
end,
[serverTimeEeventType.eNewWeek5am]=function(...)
notifySystem:postNotify(notifyConfig.onNewWeek5am,...)
end,
[serverTimeEeventType.eNewMonth]=function(...)
notifySystem:postNotify(notifyConfig.onNewMonth,...)
end,
[serverTimeEeventType.eNewMonth5am]=function(...)
notifySystem:postNotify(notifyConfig.onNewMonth5am,...)
end,
[serverTimeEeventType.eNewGameYear]=function(...)
notifySystem:postNotify(notifyConfig.onNewGameYear,...)
end,
[serverTimeEeventType.eNewDay_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewDay_login,...)
end,
[serverTimeEeventType.eNewDay5am_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewDay5am_login,...)
end,
[serverTimeEeventType.eNewWeek_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewWeek_login,...)
end,
[serverTimeEeventType.eNewWeek5am_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewWeek5am_login,...)
end,
[serverTimeEeventType.eNewMonth_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewMonth_login,...)
end,
[serverTimeEeventType.eNewMonth5am_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewMonth5am_login,...)
end,
[serverTimeEeventType.eNewGameYear_login]=function(...)
notifySystem:postNotify(notifyConfig.onNewGameYear_login,...)
end,
}

function gameUtilityControl:onAppStart()
socketManager:register_receiver(254,3,gameUtilityControl.do_protocol_254_3)
socketManager:register_receiver(254,4,gameUtilityControl.do_protocol_254_4)
socketManager:register_receiver(254,12,gameUtilityControl.do_protocol_254_12)
socketManager:register_receiver(254,20,gameUtilityControl.do_protocol_254_20)
gameUtilityControl:onAppStart_counter()
end

function gameUtilityControl:onEnterState(isReconnet)
onlineDataSetting.onEnter()
gameUtilityControl:onEnterState_counter(isReconnet)
gameUtilityControl.addNormalTimer()
end

function gameUtilityControl:onLeaveState(isReconnet)
if not isReconnet then
timeHelper.clearData()
gameUtilityModel.clearData()
end
onlineDataSetting.reset()
gameYear=nil
gameUtilityControl:onLeaveState_counter(isReconnet)
end

function gameUtilityControl:onLostConnection()

end

function gameUtilityControl:onNormalUpdate()
if gameUtilityModel.checkInit()then
local oldGameYear=gameYear
gameYear=gameUtilityModel.getGameYear()
if oldGameYear~=nil and gameYear>oldGameYear then

notifySystem:postNotify(notifyConfig.on_year_changed,gameYear,false)
end
end
end

function gameUtilityControl.setPlayerCreateTime(time_sec)

gameUtilityModel.initPlayerCreateTime(time_sec)

gameUtilityControl.addNormalTimer()
end




function gameUtilityControl:requireServerTime()

end


function gameUtilityControl:reqKFSeverOpenTime()

end



function gameUtilityControl:reqCheckPalayerOffline(checkType,actorid,guid,serverId)
socketManager:send_254_12(checkType,actorid,guid or 0,serverId)
end







function gameUtilityControl.do_protocol_254_3(now_sec,open_time)



gameUtilityModel.initData(now_sec,open_time)
end


function gameUtilityControl.do_protocol_254_4(min_open_time)

gameUtilityModel.setKuaFuServerOpenTime(min_open_time)
notifySystem:postNotify(notifyConfig.on_servertime_init_kf)
end



function gameUtilityControl.do_protocol_254_12(checkType,actorid,guid,ret,serverId)
if checkType==CHECK_OFFLINE_FORM_TYPE.ePrivateChat then
chatControl.onCheckPlayerOffline(actorid,ret,guid,serverId)
end
end


function gameUtilityControl.do_protocol_254_20(flag,islogin)



for k,v in pairs(serverTimeEeventType)do
if v<100 then
local f=mathHelper.getBitValue(flag,v-1)
if f then
local typo=v
if islogin==1 then
typo=v*100
else
typo=v
end
local func=serverTimeEeventFunc[typo]
if func then
func()
end
end
end
end
end

function gameUtilityControl.addNormalTimer()
if not gameState.isEnter()then return end
timeEventController.addNormalTimerHandler(1,'gameUtilityControl',gameUtilityControl)
local y=gameUtilityModel.getGameYear()
notifySystem:postNotify(notifyConfig.on_year_changed,y,true)
end