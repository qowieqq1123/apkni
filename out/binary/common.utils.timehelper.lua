



timeHelper={}

local _format=string.format
local _floor=math.floor
local _remove=table.remove
local _dateStampLookup={}
local _dateStampList={}
local _openZeroStamp=nil
local _splitDataLookup={}
local _splitDataList={}

function timeHelper.clearData()
_dateStampLookup={}
_dateStampList={}
_openZeroStamp=nil
_splitDataLookup={}
_splitDataList={}
end







function timeHelper.getServerShortTime()
return gameUtilityModel.getServerShortTime()
end


function timeHelper.getServerLongTime()
return gameUtilityModel.getServerLongTime()
end


function timeHelper.getLoginPassTime()
return gameUtilityModel.getPassTime()
end


function timeHelper.getOpenServerShortTime()
return gameUtilityModel.getOpenServerShortTime()
end


function timeHelper.getOpenServerShortTime_kf()
return gameUtilityModel.getOpenServerShortTime_kf()
end


function timeHelper.getServerOpenLongTime()
return gameUtilityModel.getOpenServerLongTime()
end

function timeHelper.getServerOpenDayLongTime()

end


function timeHelper.convertLongStamp(shortTime)
return shortTime+gameUtilityModel.getBaseTime()
end

function timeHelper.convertShortStamp(longStamp)
return longStamp-gameUtilityModel.getBaseTime()
end

function timeHelper.isNotBefore(longstamp)
return longstamp>=timeHelper.getServerLongTime()
end

function timeHelper.isNotLater(longstamp)
return longstamp<=timeHelper.getServerLongTime()
end

function timeHelper.isLater(longstamp)
return longstamp>timeHelper.getServerLongTime()
end

function timeHelper.isBefore(longstamp)
return longstamp<timeHelper.getServerLongTime()
end

function timeHelper.isNotLaterShort(shortstamp)
return shortstamp<=timeHelper.getServerShortTime()
end







function timeHelper.isInServerResetTime(delaySec)
delaySec=delaySec or 600
local startStamp=timeHelper.getTodayZeroStamp()
local endStamp=startStamp+delaySec
local curStamp=timeHelper.getServerLongTime()
return curStamp>=startStamp and curStamp<endStamp
end


function timeHelper.getWeakDate(longServertime)
return timeHelper.dateServerStamp('*t',longServertime).wday-1
end



function timeHelper.getWeakDateEx()
local dIndex=tonumber(timeHelper.dateServer("%w"))
return dIndex
end


function timeHelper.getWeakDateEx2(longServertime)
return tonumber(timeHelper.dateServerStamp("%w",longServertime))
end


function timeHelper.getWeakDateEx3(longServertime)
local dIndex=tonumber(timeHelper.dateServerStamp("%w",longServertime))
if dIndex==0 then
return 7
else
return dIndex
end
end

function timeHelper.getWeekZeroStamp(longStamp)
local week=timeHelper.getWeakDateEx3(longStamp)
local todayZeroStamp=timeHelper.getServerZeroStamp(longStamp)
return todayZeroStamp-(week-1)*86400
end

function timeHelper.getWeekZeroTime(shortTime)
local longStamp=timeHelper.convertLongStamp(shortTime)
local weekZeroStamp=timeHelper.getWeekZeroStamp(longStamp)
return timeHelper.convertShortStamp(weekZeroStamp)
end


function timeHelper.getWeekTimeLeftStamp(targetWeek,hour,min,sec)
hour=hour or 0
min=min or 0
sec=sec or 0
local stamp=timeHelper.getNextWeekStamp(targetWeek,hour*3600+min*60+sec)
return stamp-timeHelper.getServerLongTime()
end


function timeHelper.getWeekTimeLeftStampEx(targetWeek,hour,min,sec)
hour=hour or 0
min=min or 0
sec=sec or 0
local stamp=timeHelper.getNextWeekStampEx(1,hour*3600+min*60+sec)
return stamp-timeHelper.getServerLongTime()
end




function timeHelper.getNextWeekStamp(targetWeek,leftTime)
leftTime=leftTime or 0
local week=timeHelper.getWeakDateEx()
local stamp=timeHelper.getServerLongTime()
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local nextStamp=nil
if week<=targetWeek then
nextStamp=zeroStamp+24*(targetWeek-week)*3600+leftTime
else
local difDay=(targetWeek+7)-week
nextStamp=zeroStamp+difDay*24*3600+leftTime
end
return nextStamp
end

function timeHelper.getNextWeekStampEx(targetWeek,leftTime)
leftTime=leftTime or 0
local week=timeHelper.getWeakDateEx()
local stamp=timeHelper.getServerLongTime()
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local nextStamp=nil
if week<targetWeek then
nextStamp=zeroStamp+24*(targetWeek-week)*3600+leftTime
elseif week==targetWeek then
if(stamp-zeroStamp)>=leftTime then
local difDay=(targetWeek+7)-week
nextStamp=zeroStamp+difDay*24*3600+leftTime
else
nextStamp=zeroStamp+24*(targetWeek-week)*3600+leftTime
end
else
local difDay=(targetWeek+7)-week
nextStamp=zeroStamp+difDay*24*3600+leftTime
end
return nextStamp
end




function timeHelper.getWeakDateStamp(divWeek,weekDay,hour,min,sec)
local todayWeakDay=timeHelper.getWeakDate(timeHelper.getServerLongTime())
weekDay=weekDay==0 and 7 or weekDay
todayWeakDay=todayWeakDay==0 and 7 or todayWeakDay
local divDay=weekDay-todayWeakDay
return timeHelper.getTodayZeroStamp()+divWeek*24*3600*7+divDay*24*3600+hour*3600+min*60+sec
end


function timeHelper.getNextMonthDateStamp(day,hour,min,sec)
local year=tonumber(timeHelper.dateServer('%Y'))
local month=tonumber(timeHelper.dateServer('%m'))
if month>11 then
year=year+1
month=1
else
month=month+1
end
local timeStamp=timeHelper.timeServer(year,month,day,hour,min,sec)
return timeStamp
end

function timeHelper.getNextMonthDateStamp2(day,hour,min,sec)
local year=tonumber(timeHelper.dateServer('%Y'))
local month=tonumber(timeHelper.dateServer('%m'))
local curTime=timeHelper.getServerLongTime()
local curMonthTimeStamp=timeHelper.timeServer(year,month,day,hour,min,sec)
if curMonthTimeStamp>curTime then
return curMonthTimeStamp
end

if month>11 then
year=year+1
month=1
else
month=month+1
end
local timeStamp=timeHelper.timeServer(year,month,day,hour,min,sec)
return timeStamp
end


function timeHelper.getNextMonthDateDisStamp(day,hour,min,sec)
local timeStamp=timeHelper.getNextMonthDateStamp(day,hour,min,sec)-timeHelper.getServerLongTime()
return timeStamp
end


function timeHelper.getNextMonthDateDisStamp2(day,hour,min,sec)

local curStamp=timeHelper.getServerLongTime()
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(curStamp)
syear=tonumber(syear)
smonth=tonumber(smonth)
sday=tonumber(sday)
shour=tonumber(shour)
smin=tonumber(smin)
ssec=tonumber(ssec)
if(sday*1000000+shour*10000+smin*100+ssec)-(day*1000000+hour*10000+min*100+sec)>0 then
return timeHelper.getNextMonthDateDisStamp(day,hour,min,sec)
else
local stamp=timeHelper.timeServer(syear,smonth,day,hour,min,sec)
return stamp-curStamp
end
end






function timeHelper.getTodayXXStamp(_hour,_min,_sec)
local y,m,d=timeHelper.getServerData()
return timeHelper.timeServer(y,m,d,_hour,_min,_sec)
end


function timeHelper.getDateNumber(longtime)
if longtime==0 then
return 0,0,0,0,0,0
end
return timeHelper.getServerStampData(longtime)
end


function timeHelper.getWeeklyByServerStamp(serverStamp)
local weekDay=timeHelper.getWeakDate(serverStamp)
local y,m,d=timeHelper.getServerStampData(serverStamp)
local stamp=timeHelper.timeServer(y,m,1)
local weekday1=timeHelper.getWeakDate(stamp)
weekday1=weekday1==0 and 7 or weekday1
local weekleft=8-weekday1
return math.ceil((d-weekleft)/7)+1,weekDay
end


function timeHelper.getWeeklyByCurServerStamp()
local serverStamp=timeHelper.getServerLongTime()
local week,weekday=timeHelper.getWeeklyByServerStamp(serverStamp)
return week,weekday
end



function timeHelper.getDayByTimeformat(y,month,weekly,weekDay)
local stamp=timeHelper.timeServer(y,month,1)
local weekday1=timeHelper.getWeakDate(stamp)
local left=weekDay-weekday1+1
local day=(weekly-1)*7+left
if day<=0 then
return 0,0
end
return day,stamp+(day-1)*86400
end

function timeHelper.format_week_chinese(week)
if week>0 then
if pfwindowslController:checkIsGameVersion_yuenan()then
return FMT.fmt("Thứ {0}",week+1)
end
return FMT.fmt("周{0}",mathHelper.numberToChinese(week))
else
return"周日"
end
end


function timeHelper.getMaxDayByMonth(y,m)
local curData={}
curData.year=y
curData.month=m+1
curData.day=0
return tonumber(os.date("%d",os.time(curData)))
end


function timeHelper.getWeekByMonth(y,m)
local stamp=timeHelper.timeServer(y,m,1)
local weekday1=timeHelper.getWeakDate(stamp)
local maxDay=timeHelper.getMaxDayByMonth(y,m)
local left=7-weekday1
local add=left>0 and 1 or 0
return math.ceil((maxDay-left)/7)+add
end


function timeHelper.getMonthDate(_year,_month)
return os.date('%d',os.time({year=_year,month=_month+1,day=0}))
end


function timeHelper.getSeconds(_year,_month,_date,_hour,_min,_second)
return timeHelper.timeServer(_year,_month,_date,_hour,_min,_second)
end


function timeHelper.getTodayZeroStamp()
local y,m,d=timeHelper.getServerData()
return timeHelper.timeServer(y,m,d)
end


function timeHelper.getTodayFiveStamp()
local nowTime=timeHelper.getServerLongTime()
local timeStamp
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,5,0,0)
local y2,m2,d2=timeHelper.getServerStampData(t1+86400)
local t2=timeHelper.timeServer(y2,m2,d2,5,0,0)
if nowTime>=t1 then
timeStamp=t2
else
timeStamp=t1
end
return timeStamp
end


function timeHelper.getServerZeroStamp(serverStamp)
serverStamp=serverStamp or gameUtilityModel.getServerLongTime()
local y,m,d=timeHelper.getServerStampData(serverStamp)
return timeHelper.timeServer(y,m,d)
end

function timeHelper.getServerZeroShortStamp(shortStamp)
local serverStamp=shortStamp and timeHelper.convertLongStamp(shortStamp)or gameUtilityModel.getServerLongTime()
local y,m,d=timeHelper.getServerStampData(serverStamp)
return timeHelper.convertShortStamp(timeHelper.timeServer(y,m,d))
end

function timeHelper.getServerZeroStampEx(stamp)
return stamp-(stamp%86400)
end


function timeHelper.getServerOpenDayByStamp(longStamp)
local zeroStamp=timeHelper.getServerZeroStamp(longStamp)
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp()
local left=zeroStamp-openZeroStamp
local day=math.floor(left/86400)+1
return day
end


function timeHelper.getServerOpenZeroLongStamp()
if _openZeroStamp then return _openZeroStamp end
local stamp=timeHelper.getServerOpenLongTime()
stamp=timeHelper.convertTimeStamp(stamp)
local y=os.date('%Y',stamp)
local m=os.date('%m',stamp)
local d=os.date('%d',stamp)
_openZeroStamp=timeHelper.timeServer(y,m,d)
return _openZeroStamp
end


function timeHelper.getServerOpenDayEndLongStamp(stamp)
stamp=timeHelper.convertTimeStamp(stamp)
local y=os.date('%Y',stamp)
local m=os.date('%m',stamp)
local d=os.date('%d',stamp)+1
return timeHelper.timeServer(y,m,d)-1
end


function timeHelper.getServerOpenZeroShortStamp(stamp)
return gameUtilityModel.getOpenServerLongTime()-gameUtilityModel.getBaseTime()
end


function timeHelper.getServerOpenZeroLeftTime(day)
if day<=1 then
return 0
end
local firstLeft=timeHelper.getServerOpenPassTimeInDay()
local onydaysec=86400
local curPassTime=timeHelper.getServerLongTime()-timeHelper.getServerOpenLongTime()
local oneDayPassTime=firstLeft+(day-2)*onydaysec
local left=oneDayPassTime-curPassTime
if left<=0 then
return 0
end
return left
end

function timeHelper.getServerNewDayFiveLeftTime()
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,5,0,0)
local y2,m2,d2=timeHelper.getServerStampData(t1+86400)
local t2=timeHelper.timeServer(y2,m2,d2,5,0,0)
local cur=gameUtilityModel.getServerLongTime()
local lerp=t1-cur
if lerp<0 then
lerp=t2-cur
end
return lerp
end


function timeHelper.getServerOpenPassTimeInDay()
local stamp=timeHelper.getOpenServerShortTime()
local onydaysec=86400
local firstPass=timeHelper.getServerStampPass(stamp)
local left=onydaysec-firstPass
return left
end


function timeHelper.getServerOpenDay()
return gameUtilityModel.getServerOpenDay()
end


function timeHelper.getServerOpenDay_Time(time,offset)
offset=offset or 2
local stamp=timeHelper.getOpenServerShortTime()-offset
time=timeHelper.convertShortStamp(time)
local left=time-stamp
left=left>0 and left or 0
local onydaysec=86400
local firstPass=timeHelper.getServerStampPass(stamp)
local firstLeft=onydaysec-firstPass
if left>0 then
if left<firstLeft then
return 1
elseif left>=firstLeft then
local dayLeft=left-firstLeft
return math.ceil(dayLeft/onydaysec)+1
end
end
return 0
end


function timeHelper.getServerOpenPassTimeInDay_kf()
local stamp=timeHelper.getOpenServerShortTime_kf()
local onydaysec=86400
local firstPass=timeHelper.getServerStampPass(stamp)
local left=onydaysec-firstPass
return left
end


function timeHelper.getServerOpenDay_kf(offset)
offset=offset or 2
local curStamp=timeHelper.getServerShortTime()
local stamp=timeHelper.getOpenServerShortTime_kf()-offset
local left=curStamp-stamp
left=left>0 and left or 0
local onydaysec=86400
local firstPass=timeHelper.getServerStampPass(stamp)
local firstLeft=onydaysec-firstPass
if left>0 then
if left<firstLeft then
return 1
elseif left>=firstLeft then
local dayLeft=left-firstLeft
return math.ceil(dayLeft/onydaysec)+1
end
end
return 0
end


function timeHelper.isTodayStamp(serverStamp)
local stamp=timeHelper.getServerLongTime()
local todayZeroStamp=stamp-timeHelper.getServerTodayPass()
local tomoZeroStamp=todayZeroStamp+86400
return serverStamp>=todayZeroStamp and serverStamp<tomoZeroStamp
end


function timeHelper.isOutFiveStamp(serverStamp)
local stamp=timeHelper.getServerLongTime()
local o_y,o_m,o_d=timeHelper.getDateNumber(serverStamp)
local o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local e_time=o_time_+29*3600
return stamp>=e_time
end

function timeHelper.isOutFiveStamp2(serverStamp)
local stamp=timeHelper.getServerLongTime()
local o_y,o_m,o_d,o_h=timeHelper.getDateNumber(serverStamp)
local o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local e_time=o_time_+29*3600
return stamp>=e_time or(o_h<5 and(stamp>=o_time_+5*3600))
end


function timeHelper.getPassDay(startStamp)
local curStamp=timeHelper.getServerLongTime()
local stamp=startStamp
local left=curStamp-stamp
left=left>0 and left or 0
local onydaysec=86400
local firstPass=timeHelper.getServerLongStampPass(stamp)
local firstLeft=onydaysec-firstPass
if left>0 then
if left<firstLeft then
return 1
elseif left>=firstLeft then
local dayLeft=left-firstLeft
return math.ceil(dayLeft/onydaysec)+1
end
end
return 0
end


function timeHelper.getLeftDataNumberTwo(endStamp)
local curStamp=timeHelper.getServerLongTime()
local left=endStamp-curStamp
left=left>0 and left or 0
local onydaysec=86400
local todayLeft=onydaysec-timeHelper.getServerTodayPass()
if left>0 then
if left<todayLeft then
return 1
elseif left>=todayLeft then
local dayLeft=left-todayLeft
return math.ceil(dayLeft/onydaysec)+1
end
end
return 0
end


function timeHelper.getRemainingTime(endStamp)
local curStamp=timeHelper.getServerShortTime()

local left=endStamp-curStamp
left=left>0 and left or 0
if left>0 then







return timeHelper.format_time_stamp7(left)
end
return nil
end


function timeHelper.getServerTodayPass()
local curseverSecond=timeHelper.getServerShortTime()
local daySecondPass=curseverSecond-_floor(curseverSecond/(24*3600))*24*3600

return daySecondPass
end


function timeHelper.getServerTodayLeft()
local curseverSecond=timeHelper.getServerShortTime()
local daySecondPass=curseverSecond-_floor(curseverSecond/(24*3600))*24*3600

return 86400-daySecondPass
end


function timeHelper.getServerTodayLeft2()
local leftSecond=timeHelper.getServerTodayLeft()
return(leftSecond+60)%86400
end


function timeHelper.getServerStampPass(shortstamp)
local daySecondPass=shortstamp-_floor(shortstamp/(86400))*86400

return daySecondPass
end


function timeHelper.getServerLongStampPass(longStamp)
local shortstamp=timeHelper.convertShortStamp(longStamp)
return timeHelper.getServerStampPass(shortstamp)
end

function timeHelper.checkInSameDay(longStamp1,longStamp2)
local y1,m1,d1=timeHelper.getDateNumber(longStamp1)
local y2,m2,d2=timeHelper.getDateNumber(longStamp2)
return y1==y2 and m1==m2 and d1==d2
end

function timeHelper.checkInSameDay2(shortstamp1,shortstamp2)
local longStamp1=gameUtilityModel.serverShortTimeToLong(shortstamp1)
local longStamp2=gameUtilityModel.serverShortTimeToLong(shortstamp2)
return timeHelper.checkInSameDay(longStamp1,longStamp2)
end

function timeHelper.checkInSameDay3(stamp1,stamp2)
return math.floor(stamp1/86400)==math.floor(stamp2/86400)
end














function timeHelper.checkInSameWeek3(longStamp)
local weekZero1=timeHelper.getWeekZeroStamp(longStamp)
local nowStamp=timeHelper.getServerLongTime()
local weekZero2=timeHelper.getWeekZeroStamp(nowStamp)
return weekZero1==weekZero2
end

function timeHelper.checkInSameWeek4(shortTime)
local weekZero1=timeHelper.getWeekZeroTime(shortTime)
local nowTime=timeHelper.getServerShortTime()
local weekZero2=timeHelper.getWeekZeroTime(nowTime)
return weekZero1==weekZero2
end



function timeHelper.getDate(format)
return string.match(format,"(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
end



function timeHelper.getDateStamp(format)
if _dateStampLookup[format]then return _dateStampLookup[format]end
_dateStampList[#_dateStampList+1]=format
if#_dateStampList>1000 then
local t=_dateStampList[1]
_remove(_dateStampList,1)
_dateStampLookup[t]=nil
end
local Y,m,d,H,M,S=timeHelper.getDate(format)
_dateStampLookup[format]=timeHelper.timeServer(Y,m,d,H,M,S)
return _dateStampLookup[format]
end



function timeHelper.getFormatByStamp(longstamp)
return timeHelper.dateServerStamp('%Y-%m-%d %H:%M:%S',longstamp)
end

function timeHelper.getFormatByStamp2(longstamp)
return timeHelper.dateServerStamp('%Y年%m月%d日%H:%M:%S',longstamp)
end



function timeHelper.getFourFormatByStamp(longstamp)
return timeHelper.dateServerStamp('%m月%d日 %H:%M',longstamp)
end

function timeHelper.getFiveFormatByStamp(longstamp)
return timeHelper.dateServerStamp('%Y年%m月%d日',longstamp)
end

function timeHelper.getSixFormatByStamp(longstamp)
return timeHelper.dateServerStamp('%Y%m%d%H%M%S',longstamp)
end



function timeHelper.getTwoFormatByStamp(longstamp)
return timeHelper.dateServerStamp('%H:%M',longstamp)
end



function timeHelper.getFormatByShortStamp(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
return timeHelper.dateServerStamp('%Y-%m-%d %H:%M:%S',longstamp)
end

function timeHelper.getFormatByShortStamp2(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
return timeHelper.dateServerStamp('%Y年%m月%d日 %H:%M:%S',longstamp)
end

function timeHelper.getFormatByShortStamp3(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
return timeHelper.dateServerStamp('%Y-%m-%d\n%H:%M:%S',longstamp)
end

function timeHelper.getFormatByShortStamp4(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
return timeHelper.dateServerStamp('%Y年-%m月-%d日\n%H:%M:%S',longstamp)
end

function timeHelper.getFormatByShortStamp5(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
return timeHelper.dateServerStamp('%Y年%m月%d日\n%H:%M:%S',longstamp)
end

function timeHelper.getFormatByShortStamp6(shortstamp)
local longstamp=timeHelper.convertLongStamp(shortstamp)
local date=timeHelper.dateServerStampData(longstamp)
return FMT.fmt('{0}年{1}月{2}日\n{3}:{4}:{5}',date.year,date.month,date.day,date.hour,date.min,date.sec)
end

function timeHelper.isOneDay(oldlongstamp,newlongstamp)
local Y1,m1,d1=timeHelper.getDate(timeHelper.getFormatByStamp(oldlongstamp))
local Y2,m2,d2=timeHelper.getDate(timeHelper.getFormatByStamp(newlongstamp))
return Y1==Y2 and m1==m2 and d1==d2 or false
end

function timeHelper.isOneDayShort(oldShortstamp,newShortstamp)
local oldlongstamp=timeHelper.convertLongStamp(oldShortstamp)
local newlongstamp=timeHelper.convertLongStamp(newShortstamp)
return timeHelper.isOneDay(oldlongstamp,newlongstamp)
end

function timeHelper.isTodayShort(oldShortstamp)
local oldlongstamp=timeHelper.convertLongStamp(oldShortstamp)
local newlongstamp=timeHelper.getServerLongTime()
return timeHelper.isOneDay(oldlongstamp,newlongstamp)
end

function timeHelper.isToWeekShort(oldShortstamp)
local oldlongstamp=timeHelper.convertLongStamp(oldShortstamp)
local startlongStamp=timeHelper.getWeakDateStamp(0,1,0,0,0)
local endlongStamp=timeHelper.getWeakDateStamp(0,0,0,0,0)
return oldlongstamp>=startlongStamp and startlongStamp<=endlongStamp
end



function timeHelper.getPassMonths(oldstamp,newtamp)
if newtamp>oldstamp then
local olddate=timeHelper.dateServerStamp('*t',oldstamp)
local newdate=timeHelper.dateServerStamp('*t',newtamp)
return(newdate.year-olddate.year)*12+newdate.month-olddate.month+1
else
local olddate=timeHelper.dateServerStamp('*t',newtamp)
local newdate=timeHelper.dateServerStamp('*t',oldstamp)
return(newdate.year-olddate.year)*12+newdate.month-olddate.month+1
end
end


function timeHelper.getChineseCalendarDateByDate(year,month,day)
local dateTable=CS.LuaHelper.ToChineseCalendar(year,month,day)
local date_year=dateTable[1]
local date_month=dateTable[2]
local date_day=dateTable[3]
local date_leapMonth=dateTable[4]
local isLeapMonth=date_leapMonth==date_month
if date_leapMonth>0 and date_month>=date_leapMonth then
date_month=date_month-1
end

return date_year,date_month,date_day,isLeapMonth
end


function timeHelper.getChineseCalendarDateStr(day)
local dateStr
if day>=1 and day<=31 then
dateStr=mathHelper.numberToChinese(day)
if day<10 then
dateStr=FMT.fmt("初{0}",dateStr)
elseif day>20 and day<30 then
dateStr=FMT.fmt("廿{0}",mathHelper.numberToChinese(day-20))
end
end
return dateStr
end








function timeHelper.format_time_stamp(inteval,isShort)
if inteval<0 then
inteval=0
end
local HH=_floor(inteval/3600)
local mm=_floor((inteval-HH*3600)/60)
local SS=(inteval-HH*3600-mm*60)%60



if(HH==0)then
HH='00'
end
if(string.len(HH)==1 and HH~=0)then
HH='0'..HH
end
if(mm==0)then
mm='00'
end
if(string.len(mm)==1 and mm~=0)then
mm='0'..mm
end
if(SS==0)then
SS='00'
end
if(string.len(SS)==1 and SS~=0)then
SS='0'..SS
end

if(isShort and HH=='00')then
return _format('%s:%s',mm,SS)
end

return _format('%s:%s:%s',HH,mm,SS)
end


function timeHelper.format_time_stamp_notsecond(inteval)
if inteval<0 then
inteval=0
end
local HH=_floor(inteval/3600)
local mm=_floor((inteval-HH*3600)/60)
local SS=(inteval-HH*3600-mm*60)%60



if(HH==0)then
HH='00'
end
if(string.len(HH)==1 and HH~=0)then
HH='0'..HH
end
if(mm==0)then
mm='00'
end
if(string.len(mm)==1 and mm~=0)then
mm='0'..mm
end
return _format('%s:%s',HH,mm)
end

function timeHelper.format_time1_stamp(inteval,ss)

local mm=inteval
if(string.len(mm)==1 and mm~=0)then
mm='0'..mm
end
if inteval<=0 then
mm='00'
end
local s=math.random(0,9)
return _format('%s:%s:%s',mm,ss,s)
end


function timeHelper.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分%s秒',DD,HH,mm,SS)
else
if HH>0 then
return _format('%s时%s分%s秒',HH,mm,SS)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end


function timeHelper.format_time_stamp3(time,force)
local day=86400
local hour=3600
local min=60
local str=nil
if time>day then
local v1=_floor(time/day)
local v2=time%day/hour
if math.floor(v2)~=0 or force then
str=_format('%d天%d时',v1,v2)
else
str=_format('%d天',v1)
end
elseif time>hour then
local v1=_floor(time/hour)
local v2=time%hour/min
if math.floor(v2)~=0 or force then
str=_format('%d时%d分',v1,v2)
else
str=_format('%d时',v1)
end
elseif time>min then
local v1=_floor(time/min)
local v2=time-v1*60
if math.floor(v2)~=0 or force then
str=_format('%d分%d秒',v1,v2)
else
str=_format('%d分',v1)
end
else
str=_format('%d秒',time)
end
return str
end



function timeHelper.format_time_stamp4(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

local str_DD=DD>0 and _format('%s天',DD)or''
local str_HH=HH>0 and _format('%s时',HH)or''
local str_mm=mm>0 and _format('%s分',mm)or''
local str_SS=SS>0 and _format('%s秒',SS)or''
return str_DD..str_HH..str_mm..str_SS
end


function timeHelper.format_time_stamp5(time)
local hour=_floor(time/3600)
local min=_floor((time-hour*3600)/60)
local str_time=""
if hour>0 then
str_time=hour.."小时"
end
if min>0 then
str_time=str_time..min.."分"
end
return str_time
end


function timeHelper.format_time_stamp6(inteval)
local SS=inteval%60
local cc=math.ceil(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>=1 then
return _format('%s天%s时',DD,HH)
elseif HH>0 then
return _format('%s时',HH)
else
return'1时'
end
end


function timeHelper.formatSimpleTime(time)
if time<=0 then
return''
elseif time<60 then
return time..'秒'
elseif time<3600 then
return _floor(time/60)..'分钟'
elseif time<86400 then
return _floor(time/3600)..'小时'
else
return _floor(time/86400)..'天'
end
end

function timeHelper.formatExpSimpleTime(time)
if time<=0 then
return''
elseif time<60 then
return time..'秒'
elseif time<3600 then
if _floor(time/60)==1 then
return'分钟'
else
return _floor(time/60)..'分钟'
end
elseif time<86400 then
if _floor(time/3600)==1 then
return'小时'
else
return _floor(time/3600)..'小时'
end
else
return _floor(time/86400)..'天'
end
end

function timeHelper.format_time_stamp7(time)
if time<=0 then
return''
elseif time<60 then
return'1分钟'
elseif time<3600 then
return _floor(time/60)..'分钟'
elseif time<86400 then
return _floor(time/3600)..'小时'
else
return _floor(time/86400+1)..'天'
end
end

function timeHelper.format_time_stamp8(inteval)
local SS=inteval%60
local cc=math.ceil(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc
if DD>=1 then
if HH==0 then
return _format('%s天',DD)
end
return _format('%s天%s小时',DD,HH)
elseif HH>0 then
return _format('%s小时',HH)
else
return'1小时'
end
end



function timeHelper.format_time_stamp9(inteval)
local day=_floor(inteval/86400)
local hour=_floor((inteval-day*86400)/3600)
local min=_floor((inteval-day*86400-hour*3600)/60)
local sec=inteval-day*86400-hour*3600-min*60
if day>=1 then
if hour==0 then
return _format('%d天',day)
end
return _format('%d天%d时',day,hour)
elseif hour>0 then
return _format('%s时',hour)
else
return _format('%d:%d',min,sec)
end
end


function timeHelper.format_time_stamp10(inteval,isShort)
if inteval<0 then
inteval=0
end
local HH=_floor(inteval/3600)
local mm=_floor((inteval-HH*3600)/60)
local SS=(inteval-HH*3600-mm*60)%60
if(HH==0)then
HH='00'
end
if(string.len(HH)==1 and HH~=0)then
HH='0'..HH
end
if(mm==0)then
mm='00'
end
if(string.len(mm)==1 and mm~=0)then
mm='0'..mm
end
if(SS==0)then
SS='00'
end
if(string.len(SS)==1 and SS~=0)then
SS='0'..SS
end

if(isShort and HH=='00')then
return _format('%s：%s',mm,SS)
end

return _format('%s：%s：%s',HH,mm,SS)
end


function timeHelper.format_time_stamp11(inteval,simplify)
if inteval<=0 then
return _format('%s秒',inteval)
end
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc
if simplify then
if DD>0 then
if HH>0 then
return _format('%s天%s时',DD,HH)
else
return _format('%s天',DD)
end
elseif HH>0 then
if mm>0 then
return _format('%s时%s分',HH,mm)
else
return _format('%s时',HH)
end
elseif mm>0 then
if SS>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s分',mm)
end
else
return _format('%s秒',SS)
end
else
return _format('%s%s%s%s',
DD>0 and _format('%s天',DD)or'',
HH>0 and _format('%s时',HH)or'',
mm>0 and _format('%s分',mm)or'',
SS>0 and _format('%s秒',SS)or''
)
end
end


function timeHelper.format_time_stamp12(time)
local day=86400
local hour=3600
local min=60
local str=nil
if time>day then
local v1=_floor(time/day)
local v2=time%day/hour
str=_format('%d天',v1)
elseif time>hour then
local v1=_floor(time/hour)
local v2=time%hour/min
str=_format('%d时',v1)
elseif time>min then
local v1=_floor(time/min)
local v2=time-v1*60
str=_format('%d分',v1)
else
str=_format('%d秒',time)
end
return str
end


function timeHelper.format_time_stamp13(time,isNotShowZeroHour)
local hour=3600
local min=60
local str=nil
if time<hour then
local v1=_floor(time/min)
local v2=time-v1*min
if v1>0 then
str=FMT.fmt('{0}分',v1)
else
str='1分'
end
else
local v1=_floor(time/hour)
local v2=_floor((time-v1*hour)/min)
local v3=time-v1*hour-v2*min
if v2>0 then
str=FMT.fmt('{0}时{1}分',v1,v2)
else
str=FMT.fmt('{0}时',v1)
end
end
return str
end






function timeHelper.format_time_stamp14(time)
if time<=0 then
return''
elseif time<60 then
return'刚刚'
elseif time<3600 then
local v=_floor(time/60)
return FMT.fmt('{0}分钟前',v)
elseif time<86400 then
local v=_floor(time/3600)
return FMT.fmt('{0}小时前',v)
elseif time<604800 then
local v=_floor(time/86400)
return FMT.fmt('{0}天前',v)
else
return'超过7天'
end
end


function timeHelper.format_time_stamp15(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分',DD,HH,mm)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分',mm)
else
return'1分'
end
end
end
end


function timeHelper.format_time_stamp16(time)
local day=86400
local hour=3600
local min=60
local str=nil
if time>day then
local v1=_floor(time/day)
local v2=time%day/hour
if math.floor(v2)>9 then
str=_format('%d天%d时',v1,v2)
else
str=_format('%d天0%d时',v1,v2)
end
elseif time>hour then
local v1=_floor(time/hour)
local v2=time%hour/min
if math.floor(v2)>9 then
str=_format('%d时%d分',v1,v2)
else
str=_format('%d时0%d分',v1,v2)
end
elseif time>min then
local v1=_floor(time/min)
local v2=time-v1*60
if math.floor(v2)>9 then
str=_format('%d分%d秒',v1,v2)
else
str=_format('%d分0%d秒',v1,v2)
end
else
local temp=time%min
if temp>9 then
str=_format('%d秒',time)
else
str=_format('0%d秒',time)
end
end
return str
end


function timeHelper.format_time_stamp17(time,isNotShowZeroHour)
local hour=3600
local min=60
local str=nil
local v1=_floor(time/hour)
local v2=_floor((time-v1*hour)/min)
if v2>0 then
str=FMT.fmt('{0}时{1}分',v1,v2)
else
str=FMT.fmt('{0}时',v1)
end
return str
end



function timeHelper.format_time_stamp18(inteval)
local day=_floor(inteval/86400)
local hour=_floor((inteval-day*86400)/3600)
local min=_floor((inteval-day*86400-hour*3600)/60)
if day>=1 then
if hour>9 then
return _format('%d天%d时',day,hour)
else
return _format('%d天0%d时',day,hour)
end
elseif hour>0 then
if min>9 then
return _format('%s时%d分',hour,min)
else
return _format('%s时0%d分',hour,min)
end
else
if min<=1 then
return _format('%d分',1)
else
return _format('%d分',min)
end
end
end


function timeHelper.format_time_stamp19(inteval,simplify)
if inteval<=0 then
return 0,0,0
end
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc
if DD>0 then
HH=HH+DD*24
end
return HH,mm,SS
end







function timeHelper.string2stamp(timeString)
local Y=string.sub(timeString,1,4)
local M=string.sub(timeString,5,6)
local D=string.sub(timeString,7,8)
local hh=string.sub(timeString,9,10)
local mm=string.sub(timeString,11,12)
local ss=string.sub(timeString,13,14)
return timeHelper.timeServer(Y,M,D,hh,mm,ss)
end




local strFlags={' ','-',':'}
local _temp={}
function timeHelper.date2stamp(date)


if _splitDataLookup[date]then return _splitDataLookup[date]end

table.clear(_temp)
date=string.trim(date)
for v in string.gmatch(date,"%d+")do
_temp[#_temp+1]=tonumber(v)
end

local stamp=timeHelper.timeServer(_temp[1],_temp[2],_temp[3],_temp[4],_temp[5],_temp[6])
if#_splitDataList>=500 then
local date_=_remove(_splitDataList,1)
_splitDataLookup[date_]=nil
end

_splitDataLookup[date]=stamp
_splitDataList[#_splitDataList+1]=date

return stamp
end





function timeHelper.isCurrentHourBetween(startHour,endHour)

local currentHour=tonumber(timeHelper.dateServer('%H'))


if startHour>endHour then

return(currentHour>=startHour and currentHour<=23)or
(currentHour>=0 and currentHour<=endHour)
else

return currentHour>=startHour and currentHour<=endHour
end
end






local _server_zone=8
local _client_zone
local _server_dst=false


function timeHelper.getClientZone()
if _client_zone==nil then
local now=os.time()
_client_zone=os.difftime(now,os.time(os.date("!*t",now)))/3600
end
return _client_zone
end

function timeHelper.getServerZone()
return _server_zone
end

function timeHelper.setServerZone(server_zone)
_server_zone=server_zone
end







function timeHelper.getLocalToServerIntervalTime()
local isDstOffset=timeHelper.isdst()and 1 or 0
return(timeHelper.getClientZone()+isDstOffset-_server_zone)*3600
end



function timeHelper.getLocalToServerIntervalZone()
return timeHelper.getClientZone()-_server_zone
end


function timeHelper.isdst()
return os.date('*t',os.time()).isdst
end


function timeHelper.dateServer(format)
local ret=os.date(format,timeHelper.convertTimeStamp(timeHelper.getServerLongTime()))
return ret
end


function timeHelper.dateServerStamp(format,serverStamp)
local ret=os.date(format,timeHelper.convertTimeStamp(serverStamp))
return ret
end

function timeHelper.dateServerStampData(serverStamp)
local ret=os.date('*t',timeHelper.convertTimeStamp(serverStamp))
return ret
end


function timeHelper.timeServer(_year,_month,_day,_hour,_min,_sec)
return timeHelper.time({year=_year,month=_month,day=_day,hour=_hour or 0,min=_min or 0,sec=_sec or 0})
end


function timeHelper.getServerData()
return timeHelper.getServerStampData(timeHelper.getServerLongTime())
end


function timeHelper.getServerStampData(serverStamp)
local timeInfo=timeHelper.dateServerStampData(serverStamp)
return timeInfo.year,timeInfo.month,timeInfo.day,timeInfo.hour,timeInfo.min,timeInfo.sec
end


function timeHelper.getConvertServerFormatTimeStamp(_year,_month,_day,_hour,_min,_sec)
return timeHelper.convertTimeStamp(timeHelper.timeServer(_year,_month,_day,_hour,_min,_sec))
end



function timeHelper.convertTimeStamp(stamp)
local st=stamp-timeHelper.getLocalToServerIntervalTime()
return st
end

function timeHelper.time(serverFormatTable)
if serverFormatTable==nil then
return os.time()
end

local stamp=os.time(serverFormatTable)
local interval=timeHelper.getLocalToServerIntervalTime()
return interval+stamp
end



function timeHelper.dataToTimeStam(dataStr)
if dataStr==nil then
logErr('参数不合规')
elseif type(dataStr)=='string'then
return timeHelper.date2stamp(dataStr)
elseif type(dataStr)=='table'then
return timeHelper.time({
day=dataStr[3],month=dataStr[2],year=dataStr[1],
hour=dataStr[4],min=dataStr[5],sec=dataStr[6],
})
end
end




