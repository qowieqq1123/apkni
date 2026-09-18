






local _MODULENAME="FreeGiftModel"


def_table(_MODULENAME)
FreeGiftModel.name=_MODULENAME
FreeGiftModel.data={}

function FreeGiftModel:onAppStart()

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.onNewMonth,self.onNewMonth)
end


FreeGiftType=
{
system=1,
role=2,
yunyin=3,
kuafu=4,
special=5,
serverTransfer=7,
cbigkuafu=8,
}

FreeConditionType=
{
zhm=1,
}


FreeGiftResetType=
{
number0=0,
number1=1,
number2=2,
number3=3,
number4=4,
number5=5,
number6=6,
number7=7,
}


function FreeGiftModel:onEnterState(isReconnect)
FreeGiftModel:init()
end


function FreeGiftModel:onProtocolReq()

end


function FreeGiftModel:onLeaveState(isReconnect)

self.data={}
end



function FreeGiftModel.isTodayFiveClockStamp(serverStamp)
local stamp=timeHelper.getServerLongTime()
local todayZeroStamp5=stamp-timeHelper.getServerTodayPass()+18000
local tomoZeroStamp5=todayZeroStamp5+86400
return serverStamp>=todayZeroStamp5 and serverStamp<tomoZeroStamp5
end

function FreeGiftModel.isWeekStamp(serverStamp)
local nextweekZeroStamp=timeHelper.getNextWeekStamp(1,0)
local weekZeroStamp=nextweekZeroStamp-7*24*3600
return serverStamp>=weekZeroStamp and serverStamp<nextweekZeroStamp
end

function FreeGiftModel.isWeekFiveClockStamp(serverStamp)
local hourtime=5*3600
local nextweekZeroStamp5=timeHelper.getNextWeekStamp(1,hourtime)
local weekZeroStamp5=nextweekZeroStamp5-7*24*3600
return serverStamp>=weekZeroStamp5 and serverStamp<nextweekZeroStamp5
end

function FreeGiftModel.isMonthStamp(serverStamp)
local nextmonthZeroStamp=timeHelper.getNextMonthDateStamp(1,0,0,0)
local this_year=tonumber(timeHelper.dateServer('%Y'))
local this_month=tonumber(timeHelper.dateServer('%m'))
local monthZeroStamp=timeHelper.timeServer(this_year,this_month,1,0,0,0)
return serverStamp>=monthZeroStamp and serverStamp<nextmonthZeroStamp
end

function FreeGiftModel.isMonthFiveClockStamp(serverStamp)
local nextmonthZeroStamp5=timeHelper.getNextMonthDateStamp(1,5,0,0)
local this_year=tonumber(timeHelper.dateServer('%Y'))
local this_month=tonumber(timeHelper.dateServer('%m'))
local monthZeroStamp5=timeHelper.timeServer(this_year,this_month,1,5,0,0)
return serverStamp>=monthZeroStamp5 and serverStamp<nextmonthZeroStamp5
end

function FreeGiftModel:checkRestType(restType,lastsec,data,giftid)
if restType==FreeGiftResetType.number0 then

return false
elseif restType==FreeGiftResetType.number1 then

local isTodayData=FreeGiftModel.isTodayFiveClockStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number2 then

local isTodayData=FreeGiftModel.isWeekFiveClockStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number3 then

local isTodayData=FreeGiftModel.isMonthFiveClockStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number4 then

local isTodayData=timeHelper.isTodayStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number5 then

local isTodayData=FreeGiftModel.isWeekStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number6 then

local isTodayData=FreeGiftModel.isMonthStamp(timeHelper.convertLongStamp(lastsec))
if not isTodayData then
return true
else
return false
end
elseif restType==FreeGiftResetType.number7 then

if data and data[1]and data[2]and data[3]then
local conditions=cfg_freegiftconfig_get(giftid).conditions
if conditions[1]==FreeGiftType.special then
if conditions[2]and conditions[2]==FreeConditionType.zhm then
local sTimeStamp=timeHelper.getDateStamp(data[1])
if sTimeStamp and timeHelper.convertLongStamp(lastsec)<sTimeStamp then
return true
else
return false
end
end
else
local sub_actInfo=activitiesModel:getSubActInfo(data[1],data[2],data[3])
if sub_actInfo then
local start_time=sub_actInfo.start_time
if start_time and lastsec<start_time then
return true
else
return false
end
end
end
end
return false
else
return false
end
end



function FreeGiftModel:init()
self.data={}
self.data.allList={}
self.data.allLookup={}
self.data.newlist={}
self.data.systemlist={}
self.data.activitylist={}
self.data.speciallist={}
end




function FreeGiftModel:initDatas(len,array)
self.data.allList=array or{}
for k,v in ipairs(array or{})do
self.data.allLookup[v.giftid]=v
if v.datatype==FreeGiftType.system or v.datatype==FreeGiftType.serverTransfer then

local newdata=
{
giftid=v.giftid,
datatype=v.datatype,
actid=0,
subid=0,
lastsec=v.lastsec,
}
self.data.newlist[#self.data.newlist+1]=newdata
self.data.systemlist[v.giftid]=newdata
elseif v.datatype==FreeGiftType.role or v.datatype==FreeGiftType.yunyin or v.datatype==FreeGiftType.kuafu or v.datatype==FreeGiftType.cbigkuafu then

if v.len>0 then
for i,j in ipairs(v.list)do
local giftId=v.giftid
local actId=j.param_1
local subId=j.param_2

local ac_newdata=
{
giftid=giftId,
datatype=v.datatype,
actid=actId,
subid=subId,
lastsec=j.param_3,
}
self.data.newlist[#self.data.newlist+1]=ac_newdata
if self.data.activitylist[giftId]then
if self.data.activitylist[giftId][actId]then
self.data.activitylist[giftId][actId][subId]=ac_newdata
else
self.data.activitylist[giftId][actId]={}
self.data.activitylist[giftId][actId][subId]=ac_newdata
end
else
self.data.activitylist[giftId]={}
self.data.activitylist[giftId][actId]={}
self.data.activitylist[giftId][actId][subId]=ac_newdata
end
end
end
elseif v.datatype==FreeGiftType.special then

if v.len>0 then
for i,j in ipairs(v.list)do
local giftId=v.giftid
local specialTypeId=j.param_1
local lastsec=j.param_2
local newdata=
{
giftid=giftId,
datatype=v.datatype,
actid=0,
subid=0,
lastsec=lastsec,
}
if self.data.speciallist[v.giftid]then
self.data.speciallist[v.giftid][specialTypeId]=newdata
else
self.data.speciallist[v.giftid]={}
self.data.speciallist[v.giftid][specialTypeId]=newdata
end
end
end
end
end
end




function FreeGiftModel:IsCanGetGift(giftid,gifttype,data)
local iscanget=false
if gifttype then
if gifttype==FreeGiftType.system then
local conditions=cfg_freegiftconfig_get(giftid).conditions
if conditions[1]==gifttype and conditions[2]then
if systemModel.isOpen(conditions[2])==false then


return false
end
end
if self.data.systemlist[giftid]then
local giftdata=self.data.systemlist[giftid]
local resettype=cfg_freegiftconfig_get(giftid).resettype
iscanget=FreeGiftModel:checkRestType(resettype,giftdata.lastsec,data,giftid)
else
iscanget=true
end
elseif gifttype==FreeGiftType.role or gifttype==FreeGiftType.yunyin or gifttype==FreeGiftType.kuafu or gifttype==FreeGiftType.cbigkuafu then
if data and data[1]and data[2]and data[3]then
if self.data.activitylist[giftid]then
local actid=data[1]
local subtype=data[1]
local subid=data[3]
if self.data.activitylist[giftid][actid]then
if self.data.activitylist[giftid][actid][subid]then
local giftData=self.data.activitylist[giftid][actid][subid]
local resettype=cfg_freegiftconfig_get(giftid).resettype
iscanget=FreeGiftModel:checkRestType(resettype,giftData.lastsec,data,giftid)
else
iscanget=true
end
else
iscanget=true
end
else
iscanget=true
end
end
elseif gifttype==FreeGiftType.special then
local conditions=cfg_freegiftconfig_get(giftid).conditions
if conditions[2]and conditions[2]==FreeConditionType.zhm then
local specialTypeId=conditions[2]
if self.data.speciallist[giftid]and self.data.speciallist[giftid][specialTypeId]then
local giftdata=self.data.speciallist[giftid][specialTypeId]
local resettype=cfg_freegiftconfig_get(giftid).resettype
iscanget=FreeGiftModel:checkRestType(resettype,giftdata.lastsec,data,giftid)
else
iscanget=true
end
end
elseif gifttype==FreeGiftType.serverTransfer then
local conditions=cfg_freegiftconfig_get(giftid).conditions
if conditions[1]==gifttype then
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eSwitchServer)and ServerTransferController:checkServerTransferConditionOpen()and ServerTransferController:checkServerTransferTimeOpen()
if not isOpen then
return false
end
end
if self.data.systemlist[giftid]then
local giftdata=self.data.systemlist[giftid]
local resettype=cfg_freegiftconfig_get(giftid).resettype
iscanget=FreeGiftModel:checkRestType(resettype,giftdata.lastsec,data,giftid)
else
iscanget=true
end
end
end
return iscanget
end


function FreeGiftModel:RefreshGetGift(giftid,json,lastsec)



local conditions=cfg_freegiftconfig_get(giftid).conditions
if json then
if json==''then

local newdata=
{
giftid=giftid,
datatype=conditions[1],
actid=0,
subid=0,
lastsec=lastsec,
}
local gifttype=conditions[1]
if gifttype==FreeGiftType.system or gifttype==FreeGiftType.serverTransfer then
self.data.systemlist[giftid]=newdata
elseif gifttype==FreeGiftType.special then
local specialTypeId=conditions[2]
if self.data.speciallist[giftid]then
self.data.speciallist[giftid][specialTypeId]=newdata
else
self.data.speciallist[giftid]={}
self.data.speciallist[giftid][specialTypeId]=newdata
end
end
else

local jsondata=jsonHelper.decode(json)
local actId=jsondata[1]
local subId=jsondata[2]
local ac_newdata=
{
giftid=giftid,
datatype=conditions[1],
actid=jsondata[1],
subid=jsondata[2],
lastsec=lastsec,
}
if self.data.activitylist[giftid]then
if self.data.activitylist[giftid][actId]then
self.data.activitylist[giftid][actId][subId]=ac_newdata
else
self.data.activitylist[giftid][actId]={}
self.data.activitylist[giftid][actId][subId]=ac_newdata
end
else
self.data.activitylist[giftid]={}
self.data.activitylist[giftid][actId]={}
self.data.activitylist[giftid][actId][subId]=ac_newdata
end
end
end
end
