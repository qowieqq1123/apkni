CalendarActType={
nomarl=1,
baolingTree=2,
}
local onydaysec=86400
local onehoursec=3600
local oneminsec=60

function welfareModel:onAppStart_ActivityCalendar()

end

function welfareModel:onEnterState_ActivityCalendar(isReconnet)

end

function welfareModel:onLeaveState_ActivityCalendar(isReconnet)
self.showCalendarCfg={}
end

function welfareModel:onProtocolReq_ActivityCalendar(isReconnet)
self:initShowCalendarCfg()
end

function welfareModel:onServerDataInitFinish_ActivityCalendar()

end

function welfareModel:onLostConnection_ActivityCalendar()

end

function welfareModel:getShowCalendarCfg()
return self.showCalendarCfg
end

function welfareModel:initShowCalendarCfg()
self.showCalendarCfg={}



local calendaracttypeCfg=cfg_calendaractivitytypeconfig()
for k,v in pairs(calendaracttypeCfg)do
local temp={}
temp.type=v.id
temp.typeName=v.typeName
temp.sortWeight=v.sortWeight
temp.actList={}
self.showCalendarCfg[#self.showCalendarCfg+1]=temp
end
table.sort(self.showCalendarCfg,function(a,b)
return a.sortWeight>b.sortWeight
end)
local ativityCfg=cfg_activityconfig()
local crossactCfg=cfg_crossactconfig()

local baolingtreeconfig=cfg_baolingtreeconfig_get(1)

for k,v in pairs(ativityCfg)do

if v.calendarId then
local check,serverStamp,erro=welfareModel:checkCalendarRange(v)
if not check and(v.timecontrol[1]==4 or v.timecontrol[1]==8)then

end
if check then
local actCalendarCfg=cfgHelper.get1(cfg_activitycalendarconfig_get,v.calendarId)
if actCalendarCfg then
local actType=actCalendarCfg.activityType
for ii,vv in ipairs(self.showCalendarCfg)do
if actType==vv.type then
local arg={cfg=v}
local actTemp=welfareModel:getActTempStruct(actCalendarCfg,CalendarActType.nomarl,serverStamp,arg)
vv.actList[#vv.actList+1]=actTemp
end
end
else
logErr(FMT.fmt("日历表缺少日历配置,运营活动id--》》{0},日历id--》》 {1}",v.id,v.calendarId))
end
end
end
end

for k,v in pairs(crossactCfg)do

if v.calendarId then
local check,serverStamp=welfareModel:checkCalendarRange(v)
if check then
local actCalendarCfg=cfgHelper.get1(cfg_activitycalendarconfig_get,v.calendarId)
if actCalendarCfg then
local actType=actCalendarCfg.activityType
for ii,vv in ipairs(self.showCalendarCfg)do
if actType==vv.type then
local arg={cfg=v}
local actTemp=welfareModel:getActTempStruct(actCalendarCfg,CalendarActType.nomarl,serverStamp,arg)
vv.actList[#vv.actList+1]=actTemp
end
end
else
logErr(FMT.fmt("日历表缺少日历配置,跨服活动id--》》{0},日历id--》》 {1}",v.id,v.calendarId))
end
end
end
end

if baolingtreeconfig and baolingtreeconfig.calendarIdList and baolingtreeconfig.gubaoIndex then
local calendarIdCfgList=baolingtreeconfig.calendarIdList
local gubaoIndexCfg=baolingtreeconfig.gubaoIndex
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local ver=pfwindowslController:getGameVersion()
local pfid=gameUtilityModel.getServerPlatform()
local func=function(cfgList)
local outList
if cfgList[ver]then
if cfgList[ver][pfid]then
outList=cfgList[ver][pfid]
else

outList=cfgList[ver][defaultPfId]
end
else

if cfgList[defaultVersionId][pfid]then
outList=cfgList[defaultVersionId][pfid]
else
outList=cfgList[defaultVersionId][defaultPfId]
end
end
return outList
end
local calendarIdList=func(calendarIdCfgList)
local gubaoIndex=func(gubaoIndexCfg)
local gubaoList=baolingtreeconfig.gubaoList
for i=#calendarIdList,1,-1 do
local calendarId=calendarIdList[i]
local timeCtr=gubaoIndex[i]
if timeCtr then
local check,serverStamp=welfareModel:checkCalendarRange_BLTree(timeCtr)
if check then
local actCalendarCfg=cfgHelper.get1(cfg_activitycalendarconfig_get,calendarId)
if actCalendarCfg then
local actType=actCalendarCfg.activityType
for ii,vv in ipairs(self.showCalendarCfg)do
if actType==vv.type then
local arg={timeCtr=timeCtr,gubaoList=gubaoList}
local actTemp=welfareModel:getActTempStruct(actCalendarCfg,CalendarActType.baolingTree,serverStamp,arg)
local durationDay=timeCtr[4]
local durationTime=durationDay*onydaysec
local nextserverStamp=durationTime+serverStamp
local nextActTemp=welfareModel:getActTempStruct(actCalendarCfg,CalendarActType.baolingTree,nextserverStamp,arg)
vv.actList[#vv.actList+1]=actTemp

vv.actList[#vv.actList+1]=nextActTemp
end
end

else
logErr(FMT.fmt("日历表缺少日历配置,宝灵树活动 日历id-->>{0}",calendarId))
end

break
end
end
end
end



for i=#self.showCalendarCfg,1,-1 do
if not next(self.showCalendarCfg[i].actList)then
table.remove(self.showCalendarCfg,i)
end
end
for i,v in ipairs(self.showCalendarCfg)do
table.sort(v.actList,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
end


function welfareModel:checkCalendarRange(actCfg)


if not activitiesModel:checklangVerCondition(actCfg.langVer)then
return false,nil,6
end

if not self:checkActivityOpen_Serverlimit(actCfg.serverlimit)then
return false,nil,1
end







if not activitiesModel:checkOpenTime(actCfg.opentimelimit)then
return false,nil,3
end
if not activitiesModel:checkOpenParams(actCfg.condition)then
return false,nil,4
end

local fun=function(serverStamp)
return welfareModel:checkActivityOpen(actCfg,serverStamp)
end
local flag,calendartime=welfareModel:checkCalendarRangeTime(fun)
return flag,calendartime,5
end





























function welfareModel:checkActivityOpen(actCfg,time)







if not self:checkActivityOpen_Opendelaydays(actCfg.opendelaydays,time,actCfg)then
if actCfg.timecontrol[1]==4 then

end
return false
end
local flag,erro=self:checkActivityOpen_Timecontrol(actCfg.timecontrol,time,actCfg.opendaylimit,actCfg)
if not flag then
if actCfg.timecontrol[1]==4 or actCfg.timecontrol[1]==8 then

end
return false
end

return true
end



function welfareModel:checkActivityOpen_Timecontrol(timecontrol,time,opendaylimit,actCfg)
local type=timecontrol[1]
if type~=1 and type~=2 and type~=4 and type~=5 and type~=8 then
return false
end

if type==1 then

if not welfareModel:checkActivityOpen_Opendaylimit(opendaylimit,timecontrol,nil,actCfg)then
return false
end
local startStr=timecontrol[2]
local startTime=timeHelper.dataToTimeStam(startStr)
local endTimeStr=timecontrol[3]
local endTime=timeHelper.dataToTimeStam(endTimeStr)
if startTime<=time and time<endTime then
return true
else
return false
end
elseif type==2 then

if not welfareModel:checkActivityOpen_Opendaylimit(opendaylimit,timecontrol,nil,actCfg)then
return false
end
local startDay=timecontrol[2][1]
local endDay=timecontrol[3][1]
local timeOpenDay=timeHelper.getServerOpenDay_Time(time)
if startDay>timeOpenDay then
return false
end
if endDay<timeOpenDay then
return false
end

elseif type==4 then
local openday=timecontrol[4]
if openday then
local timeOpenDay=timeHelper.getServerOpenDay_Time(time)
if timeOpenDay<openday then
return false,1
end
end














local startStr=timecontrol[2]
local startTime
if _G.type(startStr)=='table'then
local openStamp=timeHelper.getServerOpenLongTime()
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
startTime=openZeroStamp+(startStr[1]-1)*86400+startStr[2]*3600+startStr[3]*60+startStr[4]
else
startTime=timeHelper.dataToTimeStam(startStr)
end

if time<startTime then
return false,2
end
local endStr=timecontrol[5]
if endStr then










local endTime=timeHelper.dataToTimeStam(endStr)
if time>endTime then
return false,3
end
end

local dayCount=timecontrol[3][1]
local weekInterval=timecontrol[3][2]+1


local intervalTime=time-startTime
local intervalDay=math.floor(intervalTime/onydaysec)
local allintervalDay=weekInterval*7
local result=intervalDay%allintervalDay

if result>=dayCount or result<0 then
return false,4
end


local curStartTime=time-result*onydaysec
if not welfareModel:checkActivityOpen_Opendaylimit(opendaylimit,timecontrol,curStartTime,actCfg)then
return false
end
elseif type==5 then



local openZeroStamp=timeHelper.getServerOpenZeroLongStamp()
local oepnstr=timecontrol[2][1]
local oepnTime=timeHelper.dataToTimeStam(oepnstr)
if openZeroStamp<oepnTime then
return false
end
local closestr=timecontrol[2][2]
if closestr~=0 then
local closeTime=timeHelper.dataToTimeStam(closestr)
if openZeroStamp>=closeTime then
return false
end
end

local kaifuDay=timecontrol[3]
local timeOpenDay=timeHelper.getServerOpenDay_Time(time)
if timeOpenDay<kaifuDay then
return false
end


local startStr=timecontrol[4][1]
local startTime=timeHelper.dataToTimeStam(startStr)
if time<startTime then
return false
end


if not welfareModel:checkActivityOpen_Opendaylimit(opendaylimit,timecontrol,time,actCfg)then
return false
end

elseif type==8 then
local Tstr=timecontrol[2]
if Tstr and Tstr[1]==8 or Tstr[1]==4 then
logErr("活动日历检查 checkActivityOpen_Timecontrol 8类型 参数1 首次开启时间 时间类型错误")
return false,1
end
local teampinfo=welfareModel:getTimeInfo(actCfg,time,Tstr)
if not teampinfo or not teampinfo.startTime then

return false,2
end
local starTime=teampinfo.startTime
if time<starTime then
return false,3
end

local firststarTime=teampinfo.startTime

local firstendTime=teampinfo.endTime

if firststarTime<=time and time<firstendTime then
return true
end

local loopStarTime=0
local openloopStarTime=0
local stype=timecontrol[3][1]
if stype==1 then
local dayarg=timecontrol[3][2]
loopStarTime=starTime+dayarg*onydaysec
openloopStarTime=loopStarTime
elseif stype==2 then
local weekarg=timecontrol[3][2]
local dayIndexarg=timecontrol[3][3]
local weekTime=starTime+weekarg*7*onydaysec
local dayIndex=timeHelper.getWeakDateEx3(weekTime)

if dayIndex<dayIndexarg then
loopStarTime=weekTime+(dayIndexarg-dayIndex)*onydaysec
elseif dayIndex==dayIndexarg then
loopStarTime=weekTime
else
loopStarTime=weekTime+(7-(dayIndex-dayIndexarg))*onydaysec
end
openloopStarTime=loopStarTime
elseif stype==3 then
local fixStarStr=timecontrol[3][2]
local invDay=timecontrol[3][3]
local fixStarTime=timeHelper.dataToTimeStam(fixStarStr)
local invStartime=starTime+invDay*onydaysec
if invStartime>fixStarTime then
openloopStarTime=invStartime
else
openloopStarTime=fixStarTime
end
loopStarTime=fixStarTime
end

if time<openloopStarTime then
return false,4
end

local endStr=timecontrol[5]
if endStr and endStr~=0 then
local endTime=timeHelper.dataToTimeStam(endStr)
if time>=endTime then
return false,5
end
end

local dayCount=timecontrol[4][1]
local weekInterval=timecontrol[4][2]+1
local intervalTime=time-loopStarTime
local intervalDay=math.floor(intervalTime/onydaysec)
local allintervalDay=weekInterval*7
local result=intervalDay%allintervalDay

if result>=dayCount or result<0 then

return false,6
end


end
return true
end

function welfareModel:checkActivityOpen_Opendelaydays(delayday,time,actCfg)
if not delayday then
return true
end
local _delayday
local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()






local _verCfg=delayday[_ver]or delayday[-1]
if not _verCfg then

return true
end






local _delayday=_verCfg[_pfId]or _verCfg[-1]
if not _delayday or _delayday<=0 then
return true
end
local timeOpenDay=timeHelper.getServerOpenDay_Time(time)
return timeOpenDay>_delayday
end


function welfareModel:checkActivityOpen_Opendaylimit(limit,timecontrol,time,actCfg)
if not limit then
return true
end
local _limit
local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()
local _verCfg=limit[_ver]or limit[-1]

if not _verCfg then

return true
end








local _limit=_verCfg[_pfId]or _verCfg[-1]
if not _limit then
return true
end

local limitStartDay=_limit[1]
local limitEndDay=_limit[2]


local startTime
local type=timecontrol[1]
local timeOpenDay
if type==1 then
local startStr=timecontrol[2]
local startTime=timeHelper.dataToTimeStam(startStr)
timeOpenDay=timeHelper.getServerOpenDay_Time(startTime)

elseif type==2 then

timeOpenDay=time and timeHelper.getServerOpenDay_Time(time)or timecontrol[2][1]
elseif type==3 then
timeOpenDay=nil
elseif type==4 then



timeOpenDay=timeHelper.getServerOpenDay_Time(time)
elseif type==5 then
timeOpenDay=timeHelper.getServerOpenDay_Time(time)
end
if not timeOpenDay then
return false
end

if limitStartDay~=0 and limitEndDay~=0 then
if timeOpenDay<limitStartDay or timeOpenDay>limitEndDay then
return false
end
else
if limitStartDay==0 then
if timeOpenDay>limitEndDay then
return false
end
end
if limitEndDay==0 then
if timeOpenDay<limitStartDay then
return false
end
end
end
return true
end

function welfareModel:checkActivityOpen_Opentimelimit(timelimit)
if not timelimit then
return true
end

local limitStartTime=timelimit[1]
if limitStartTime~=0 then
local year,month,day,hour,min,sec=welfareModel:getTime(timelimit[1])
limitStartTime=timeHelper.timeServer(year,month,day,hour,min,sec)
end
local limitEndTime=timelimit[2]
if limitEndTime~=0 then
local year,month,day,hour,min,sec=welfareModel:getTime(timelimit[2])
limitEndTime=timeHelper.timeServer(year,month,day,hour,min,sec)
end

local openTime=timeHelper.getServerOpenLongTime()

if limitStartTime~=0 and limitEndTime~=0 then
if openTime<limitStartTime or openTime>limitEndTime then
return false
end
else
if limitStartTime==0 then
if openTime>limitEndTime then
return false
end
end
if limitEndTime==0 then
if openTime<limitStartTime then
return false
end
end
end
return true
end

function welfareModel:checkActivityOpen_Serverlimit(serverlimit)
if not serverlimit then
return true
end
local type=serverlimit.type
local pf=serverlimit.pf
local serverPfid=gameUtilityModel.getServerPlatform()
local serverid=playerModel:getActorServerID()
local crossid=loginModel:getCrossServerId()
local cfg=pf[serverPfid]
if type==1 or type==3 then
local id=type==1 and serverid or crossid
if not cfg then
return false
end
if cfg==-1 then
return true
end
if type(cfg)~="table"then
return true
end
if not next(cfg)then
return false
end
for k,v in pairs(cfg)do
if type(v)~="table"then
if id>=v[1]and id<=v[2]then
return true
end
else
if id==v then
return true
end
end
end
return false
elseif type==2 or type==4 then
local id=type==2 and serverid or crossid
if not cfg then
return true
end
if cfg==-1 then
return false
end
if type(cfg)~="table"then
return true
end
if not next(cfg)then
return true
end

for k,v in pairs(cfg)do
if type(v)~="table"then
if id>=v[1]and id<=v[2]then
return false
end
else
if id==v then
return false
end
end
end
return true
end
return false
end







function welfareModel:getCalendarLen()
return welfareModel:getBaseCalendarCfg("calendarLen")
end


function welfareModel:getTodayPos()
return welfareModel:getBaseCalendarCfg("todayPos")
end


function welfareModel:getLimitCount()
return welfareModel:getBaseCalendarCfg("limitCount")
end


function welfareModel:getBaseCalendarCfg(key)
return cfgHelper.get2(cfg_activitycalendarbaseconfig_get,1,key)
end

function welfareModel:getTime(str)
local strList1=string.split(str," ")
local strList2=string.split(strList1[1],"-")
local strList3=string.split(strList1[2],":")
return tonumber(strList2[1]),tonumber(strList2[2]),tonumber(strList2[3]),tonumber(strList3[1]),tonumber(strList3[2]),tonumber(strList3[3])
end

function welfareModel:getTimeInfo(actCfg,serverStamp,argTimecontrol)
local timecontrol=argTimecontrol or actCfg.timecontrol
local type=timecontrol[1]
if type==3 or type==6 or type==7 then
return nil
end

local temp={}

local curStartTime,curEndTime
if type==1 then
local startStr=timecontrol[2]
curStartTime=timeHelper.dataToTimeStam(startStr)
local endTimeStr=timecontrol[3]
curEndTime=timeHelper.dataToTimeStam(endTimeStr)
elseif type==2 then
local openstartDay=timecontrol[2][1]
local s_hour,s_min,s_sec=timecontrol[2][2],timecontrol[2][3],timecontrol[2][4]
local openendDay=timecontrol[3][1]
local e_hour,e_min,e_sec=timecontrol[3][2],timecontrol[3][3],timecontrol[3][4]
local openStamp=timeHelper.getServerOpenLongTime()
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)

local openstartTime=openZeroStamp+(openstartDay-1)*onydaysec

local openendtTime=openZeroStamp+(openendDay-1)*onydaysec

curStartTime=openstartTime+s_hour*onehoursec+s_min*oneminsec+s_sec

curEndTime=openendtTime+e_hour*onehoursec+e_min*oneminsec+e_sec

elseif type==4 then
local startStr=timecontrol[2]
local startTime
if _G.type(startStr)=='table'then
local openStamp=timeHelper.getServerOpenLongTime()
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
startTime=openZeroStamp+(startStr[1]-1)*86400+startStr[2]*3600+startStr[3]*60+startStr[4]
else
local year_s,month_s,day_s,hour_s,min_s,sec_s=welfareModel:getTime(startStr)
startTime=timeHelper.timeServer(year_s,month_s,day_s,hour_s,min_s,sec_s)
end
local endStr=timecontrol[5]
local endTime
if endStr then
local year_e,month_e,day_e,hour_e,min_e,sec_e=welfareModel:getTime(endStr)
endTime=timeHelper.timeServer(year_e,month_e,day_e,hour_e,min_e,sec_e)
end

local intervalTime=serverStamp-startTime
local dayCount=timecontrol[3][1]
local weekInterval=timecontrol[3][2]+1
local intervalDay=math.floor(intervalTime/onydaysec)
local allintervalDay=weekInterval*7
local result=intervalDay%allintervalDay













curStartTime=serverStamp-result*onydaysec-1
curEndTime=curStartTime+dayCount*onydaysec-1
if endTime then
curEndTime=curEndTime>endTime and endTime or curEndTime
end

elseif type==5 then


local openZeroStamp=timeHelper.getServerOpenZeroLongStamp()
local oepnstr=timecontrol[2][1]
local oepnTime=timeHelper.dataToTimeStam(oepnstr)
local canOpenFlag=true
if openZeroStamp<oepnTime then
canOpenFlag=false
end
local closestr=timecontrol[2][2]
if closestr~=0 then
local closeTime=timeHelper.dataToTimeStam(closestr)
if openZeroStamp>=closeTime then
canOpenFlag=false
end
end

local kaifuDay=timecontrol[3]
local timeOpenDay=timeHelper.getServerOpenDay_Time(serverStamp)
if timeOpenDay<kaifuDay then
canOpenFlag=false
end


local startStr=timecontrol[4][1]

local startTime=timeHelper.dataToTimeStam(startStr)
if canOpenFlag and serverStamp>=startTime then
curStartTime=serverStamp
local day=timecontrol[4][2][1]
local h=timecontrol[4][2][2]
local m=timecontrol[4][2][3]
local s=timecontrol[4][2][4]
curEndTime=curStartTime+(day-1)*onydaysec+h*onehoursec+m*oneminsec+s
end
elseif type==8 then
local Tstr=timecontrol[2]
if Tstr and Tstr[1]==8 or Tstr[1]==4 then
logErr("活动日历检查 getTimeInfo 8类型 参数1 首次开启时间 时间类型错误")
return
end
local teampinfo=welfareModel:getTimeInfo(actCfg,serverStamp,Tstr)
if not teampinfo or not teampinfo.startTime then

return
end

local firststarTime=teampinfo.startTime

local firstendTime=teampinfo.endTime

if firststarTime<=serverStamp and serverStamp<firstendTime then
curStartTime=firststarTime
curEndTime=firstendTime
else
local loopStarTime=0
local stype=timecontrol[3][1]
if stype==1 then
local dayarg=timecontrol[3][2]
loopStarTime=firststarTime+dayarg*onydaysec
elseif stype==2 then
local weekarg=timecontrol[3][2]
local dayIndexarg=timecontrol[3][3]
local weekTime=firststarTime+weekarg*7*onydaysec
local dayIndex=timeHelper.getWeakDateEx3(weekTime)

if dayIndex<dayIndexarg then
loopStarTime=weekTime+(dayIndexarg-dayIndex)*onydaysec
elseif dayIndex==dayIndexarg then
loopStarTime=weekTime
else
loopStarTime=weekTime+(7-(dayIndex-dayIndexarg))*onydaysec
end
elseif stype==3 then
local fixStarStr=timecontrol[3][2]
local invDay=timecontrol[3][3]
local fixStarTime=timeHelper.dataToTimeStam(fixStarStr)
local invStartime=firststarTime+invDay*onydaysec
loopStarTime=fixStarTime
end

local dayCount=timecontrol[4][1]
local weekInterval=timecontrol[4][2]+1
local intervalTime=serverStamp-loopStarTime
local intervalDay=math.floor(intervalTime/onydaysec)
local allintervalDay=weekInterval*7
local result=intervalDay%allintervalDay

curStartTime=serverStamp-result*onydaysec-1
curEndTime=curStartTime+dayCount*onydaysec-1
local endStr=timecontrol[5]
if endStr and endStr~=0 then
local endTime=timeHelper.dataToTimeStam(endStr)
curEndTime=curEndTime>endTime and endTime or curEndTime
end
end

end

if curStartTime and curEndTime then
temp=welfareModel:getActTimeInfoStruct(curStartTime,curEndTime)
else
temp=nil
end
return temp
end


function welfareModel:checkCalendarRange_BLTree(timeCtr)
local openStamp=timeHelper.getServerOpenLongTime()
local minTime=timeHelper.dataToTimeStam(timeCtr[1])
local maxTime
if timeCtr[2]then
if timeCtr[2]~="0"then
maxTime=timeHelper.dataToTimeStam(timeCtr[2])
end
end
if openStamp<minTime then
return false
end
if maxTime and openStamp>maxTime then
return false
end

local openDayLimit=timeCtr[3]
local durationDay=timeCtr[4]
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
local first_s_time=openZeroStamp+(openDayLimit-1)*86400

local fun=function(serverStamp)
return serverStamp>first_s_time
end

local flag,calendartime=welfareModel:checkCalendarRangeTime(fun)

return flag,calendartime
end


function welfareModel:getCalendarReward_BLTree(timeCtr,gubaoList,serverStamp)
local loopId=timeCtr[5]
local rewardList=gubaoList[loopId]
local openStamp=timeHelper.getServerOpenLongTime()
local openDayLimit=timeCtr[3]
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
local first_s_time=openZeroStamp+(openDayLimit-1)*86400
local intervalTime=serverStamp-first_s_time
local durationDay=timeCtr[4]
local intervalDay=math.ceil(intervalTime/onydaysec)
local curLun=math.ceil(intervalDay/durationDay)

local curIndex=curLun%#rewardList
curIndex=curIndex==0 and#rewardList or curIndex
local rewards=rewardList[curIndex]
local temp={}
temp[1]=1
temp[2]={}
for i,v in ipairs(rewards)do
temp[2][#temp[2]+1]={v[1],1}
end

return temp
end

function welfareModel:getTimeInfo_BLTree(timeCtr,serverStamp)
local openStamp=timeHelper.getServerOpenLongTime()
local openDayLimit=timeCtr[3]
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
local durationDay=timeCtr[4]
local durationTime=durationDay*onydaysec
local first_s_time=openZeroStamp+(openDayLimit-1)*onydaysec


local intervalTime=serverStamp-first_s_time
local intervalDay=math.floor(intervalTime/onydaysec)
local round=math.floor(intervalDay/durationDay)


local cur_s_time=first_s_time+durationTime*round
local cur_e_time=cur_s_time+durationTime-1

local temp=welfareModel:getActTimeInfoStruct(cur_s_time,cur_e_time)





return temp
end




function welfareModel:getActTimeInfoStruct(startTime,endTime)

local startshowTime=welfareModel:getCalendarInfo()
local temp={}
temp.startTime=startTime
temp.endTime=endTime
temp.startTimeInfo=timeHelper.dateServerStampData(temp.startTime)
temp.endTimeInfo=timeHelper.dateServerStampData(temp.endTime)


if temp.startTime<startshowTime then
temp.actLen=math.ceil((temp.endTime-startshowTime)/onydaysec)
temp.posIndex=1
else
temp.actLen=math.ceil((temp.endTime-temp.startTime)/onydaysec)
local interval=temp.startTime-startshowTime
temp.posIndex=math.ceil(interval/onydaysec)+1
end
return temp
end




function welfareModel:checkCalendarRangeTime(fun)

local startshowTime,len,todayNum=welfareModel:getCalendarInfo()

local serverStamp

for i=todayNum,len do
serverStamp=startshowTime+onydaysec*(i-1)
if fun(serverStamp)then
return true,serverStamp
end
end
return false
end

function welfareModel:getCalendarInfo()
local len=welfareModel:getCalendarLen()
local curTime=timeHelper.getServerLongTime()
local curDayZeroStamp=timeHelper.getServerZeroStamp(curTime)
local todayPos=welfareModel:getTodayPos()
local beforeDay=todayPos-1

local startshowTime=curDayZeroStamp-beforeDay*onydaysec+1
return startshowTime,len,todayPos
end






function welfareModel:getActTempStruct(actCalendarCfg,actType,serverStamp,arg)
local actTemp={}
actTemp.name=actCalendarCfg.name
actTemp.desc=actCalendarCfg.desc
actTemp.sortWeight=actCalendarCfg.sortWeight
actTemp.iconCfg=actCalendarCfg.iconCfg
actTemp.actType=actType
if actType==CalendarActType.nomarl then
local cfg=arg.cfg
actTemp.actId=cfg.id
actTemp.timeInfo=welfareModel:getTimeInfo(cfg,serverStamp)
actTemp.rewards=actCalendarCfg.rewards
elseif actType==CalendarActType.baolingTree then
actTemp.actId=nil
actTemp.rewards=self:getCalendarReward_BLTree(arg.timeCtr,arg.gubaoList,serverStamp)
actTemp.timeInfo=self:getTimeInfo_BLTree(arg.timeCtr,serverStamp)
end
return actTemp
end
