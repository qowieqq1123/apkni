







gameUtilityModel={}



local _BASE_TWO_SECOND=1609430400
local _BASE_TIME_ZONE=28800
local _DEFIN_GAME_YEAR=1440
local _ONE_DAY_SEC=86400

local _tickTimer=nil
local _onLinetickTimer=nil
local _frameCount2=nil
local _shortTime2=nil

local _serverAsyncTime=nil
local _playerCreateTime=0
local _serverAsyncLongTime=0
local _serverAsyncRealTime=0
local _openServerTime=0
local _openServerLongTime=0
local _openServerTime_kf=0
local _openServerLongTime_kf=0

local _passTime=0
local _shortTime=0
local _longTime=0
local _year=0
local _yearPass=0
local _openServerDay=0

local _OnlineTime=0
local _OnlineTimeStamp=0
local _lastReportTime=0

local REPORT_POINTS={30,60,180,360}
local _reportedPoints={}

function gameUtilityModel.initData(asyncTime,openServerTime)
gameUtilityModel.asyncServerTime(asyncTime)

_openServerTime=openServerTime
_openServerLongTime=_openServerTime+_BASE_TWO_SECOND

gameUtilityModel.startTimer()


notifySystem:postNotify(notifyConfig.on_servertime_init)
gameUtilityModel.checkTime()

fightReport.checkReportTime()
end

function gameUtilityModel.init_BASE_TWO_SECOND(Zone)
_BASE_TWO_SECOND=_BASE_TWO_SECOND+(8-Zone)*3600
end

function gameUtilityModel.asyncServerTime(asyncTime)
_serverAsyncTime=asyncTime
_serverAsyncLongTime=_serverAsyncTime+_BASE_TWO_SECOND
_serverAsyncRealTime=math.floor(Time.realtimeSinceStartup)
end

function gameUtilityModel.setKuaFuServerOpenTime(openTime)
_openServerTime_kf=openTime
_openServerLongTime_kf=_openServerTime_kf+_BASE_TWO_SECOND
end

function gameUtilityModel.initPlayerCreateTime(param_1)
platformSDK.printSDK('初始化时间 init 1：',param_1)
_playerCreateTime=param_1
end

function gameUtilityModel.clearData()
gameUtilityModel.stopTimer()
_serverAsyncTime=nil
_playerCreateTime=0
_serverAsyncRealTime=0
_openServerTime=0
_openServerLongTime=0
_openServerTime_kf=0
_openServerLongTime_kf=0
_passTime=0
_shortTime=0
_longTime=0
_openServerDay=0
_year=0
_yearPass=0
_BASE_TWO_SECOND=1609430400
end

function gameUtilityModel.checkTime()












end


function gameUtilityModel.checkInit()
return _serverAsyncTime~=nil
end


function gameUtilityModel.getPlayerCreateTime()
return _playerCreateTime
end

function gameUtilityModel.getBaseTime()
return _BASE_TWO_SECOND
end


function gameUtilityModel.getOpenServerShortTime()
return _openServerTime
end


function gameUtilityModel.getOpenServerLongTime()
return _openServerLongTime
end


function gameUtilityModel.getOpenServerShortTime_kf()
return _openServerTime_kf
end


function gameUtilityModel.getOpenServerLongTime_kf()
return _openServerLongTime_kf
end


function gameUtilityModel.getServerOpenDay()
return _openServerDay
end


function gameUtilityModel.getPassTime()
return _passTime
end


function gameUtilityModel.getServerShortInitTime()
return _serverAsyncTime
end


function gameUtilityModel.getServerLongInitTime()
return _serverAsyncLongTime
end

function gameUtilityModel.getServerShortTime()
return _shortTime
end

function gameUtilityModel.getServerShortTime2()
if _serverAsyncTime==nil then return 0 end
if Time.frameCount==_frameCount2 then return _shortTime2 end
_frameCount2=Time.frameCount
_shortTime2=_serverAsyncTime+Time.realtimeSinceStartup-_serverAsyncRealTime
return _shortTime2
end


function gameUtilityModel.getServerLongTime()
return _longTime
end

function gameUtilityModel.serverShortTimeToLong(shortStamp)
return shortStamp+_BASE_TWO_SECOND
end

function gameUtilityModel.serverLongTimeToShort(longStamp)
return longStamp-_BASE_TWO_SECOND
end

local _getGameYear=function()
return gameUtilityModel.calculateGameYearCeil(_shortTime-_playerCreateTime)
end


function gameUtilityModel.getGameYear()
return _year
end

function gameUtilityModel.calculateGameYearFloor(time)
return math.floor(time/_DEFIN_GAME_YEAR)
end

function gameUtilityModel.calculateGameYearCeil(time)
return math.ceil(time/_DEFIN_GAME_YEAR)
end

function gameUtilityModel.calculateGameYear(time)
return time/_DEFIN_GAME_YEAR
end

function gameUtilityModel.getGameYearSecond()
return _DEFIN_GAME_YEAR
end

local _getGameYearPass=function(shortStamp)
local a=_playerCreateTime
local b=shortStamp
return gameUtilityModel.calculateGameYearCeil(b-a)
end

function gameUtilityModel.getGameYearPass(shortStamp)
if shortStamp~=nil then return _getGameYearPass(shortStamp)end
return _yearPass
end

function gameUtilityModel.getGameYearPass2(shortStamp_s,shortStamp_e)
local a=shortStamp_s
local b=shortStamp_e or _shortTime
return gameUtilityModel.calculateGameYearCeil(b-a)
end

function gameUtilityModel.getGameYearPass3(shortStamp_s,shortStamp_e)
local a=shortStamp_s
local b=shortStamp_e or _shortTime
return gameUtilityModel.calculateGameYearFloor(b-a)
end

function gameUtilityModel.getGameYearPass4(shortStamp)
local a=_playerCreateTime
local b=shortStamp or _shortTime
return gameUtilityModel.calculateGameYearFloor(b-a)
end


function gameUtilityModel.getGameYearPassByLongStamp(longStamp)
local shortStamp=timeHelper.convertShortStamp(longStamp)
local year=gameUtilityModel.getGameYearPass(shortStamp)
if year<=0 then year=1 end
return year
end

local _getServerOpenDay=function()
local curStamp=_shortTime
local stamp=_openServerTime-2
local left=curStamp-stamp
left=left>0 and left or 0
local firstPass=timeHelper.getServerStampPass(stamp)
local firstLeft=_ONE_DAY_SEC-firstPass
local openServerDay=0
if left>0 then
if left<firstLeft then
openServerDay=1
elseif left>=firstLeft then
local dayLeft=left-firstLeft
openServerDay=math.ceil(dayLeft/_ONE_DAY_SEC)+1
end
end
return openServerDay
end


function gameUtilityModel.onDayChanged()

end

function gameUtilityModel.startTimer()
if _tickTimer then return end
_tickTimer=timer.new()
_tickTimer:start(0.49,gameUtilityModel.update)
gameUtilityModel.update()
end


function gameUtilityModel.stopTimer()
if _tickTimer~=nil then
_tickTimer:Stop()
_tickTimer=nil
end
end

function gameUtilityModel.update()
_passTime=math.floor(Time.realtimeSinceStartup)-_serverAsyncRealTime
_shortTime=_serverAsyncTime+_passTime
_longTime=_shortTime+_BASE_TWO_SECOND

_year=_getGameYear()
_yearPass=_getGameYearPass(_shortTime)


local openDay=_openServerDay
_openServerDay=_getServerOpenDay()
if openDay~=_openServerDay then
gameUtilityModel.onDayChanged(openDay,_openServerDay)
end
end


function gameUtilityModel.startOnlineTimer(OnlineTime)
_OnlineTimeStamp=gameUtilityModel.getServerShortTime()
_OnlineTime=OnlineTime or 0
_lastReportTime=_OnlineTime
_reportedPoints={}
if _onLinetickTimer then return end

_onLinetickTimer=timer.new()
_onLinetickTimer:start(30,gameUtilityModel.OnlineUpdate)
gameUtilityModel.OnlineUpdate()
end

function gameUtilityModel.stopOnlineTimer()
if _onLinetickTimer~=nil then
_onLinetickTimer:Stop()
_onLinetickTimer=nil
end
end


function gameUtilityModel.OnlineUpdate()

local currentTime=gameUtilityModel.getServerShortTime()
_OnlineTime=_OnlineTime+(currentTime-_OnlineTimeStamp)
_OnlineTimeStamp=currentTime


for _,point in ipairs(REPORT_POINTS)do
local pointSeconds=point*60
if _OnlineTime>=pointSeconds and not _reportedPoints[point]then
pfCommonHelper.reportOnlineTime(point,false)
_reportedPoints[point]=true
end
end


if _OnlineTime-_lastReportTime>=30*60 then
pfCommonHelper.reportOnlineTime(nil,true)
_lastReportTime=_OnlineTime
end
end

