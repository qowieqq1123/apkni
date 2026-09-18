





eShangHangEventType=
{
eHear=1,
eEvent=2,
eItemEvent=3,
}

eShangHangEventUpType=
{
eUp=1,
eDown=2,
eUpDown=3,
eDownUp=3,
}

function shangHangModel:setEventList(eventList)
self.data.eventList={}
if eventList then

local t
for i,v in ipairs(eventList)do
local cnt=v.param_4

local upType=v.param_2>0 and eShangHangEventUpType.eUp or eShangHangEventUpType.eDown

t={type=eShangHangEventType.eEvent,id=v.param_1,percent=v.param_2/100,time=v.param_3,times=cnt,upType=upType,cfgType=v.param_6}

if cnt==1 then
table.insert(self.data.eventList,shangHangModel:getEventHear(t))
end
local nextTime,checkEnd=shangHangModel:getNextChangeTime(true,timeHelper.convertLongStamp(v.param_3),true)
if cnt>=2 then
if cnt<=10 then
for i=2,cnt do
nextTime,checkEnd=shangHangModel:getNextChangeTime(true,timeHelper.convertLongStamp(nextTime),true)
end
end
t.time=nextTime
else
t.time=nextTime
end

if(not checkEnd)or checkEnd~=2 then
table.insert(self.data.eventList,t)
end



end
end
end

function shangHangModel:getEventList(timeSort,hideAfter)
if timeSort then
self.data.eventList=self.data.eventList or{}
table.sort(self.data.eventList,function(a,b)
if a.time<b.time then
return true
elseif a.time==b.time then
return a.type<b.type
else
return false
end
end)
if hideAfter then
local list={}
local now=timeHelper.getServerShortTime()
for i,v in ipairs(self.data.eventList)do
if timeHelper.isTodayStamp(timeHelper.convertLongStamp(v.time))and now>=v.time then
table.insert(list,v)
end
end
return list
else
return self.data.eventList
end

else
return self.data.eventList or{}
end

end

function shangHangModel:getGuPiaoEffectEvent(id)
local list={}
local event=shangHangModel:getEventList(true,true)
for i,v in ipairs(event)do
if v.type==eShangHangEventType.eEvent then
local effect=cfgHelper.get(cfg_shanghangeventconfig_get,v.id,"effect")
if v.cfgType and effect[v.cfgType]then
if effect[v.cfgType][id]then
table.insert(list,v)
end
end
elseif v.type==eShangHangEventType.eItemEvent then
local effect=cfgHelper.get(cfg_shanghangitemeventconfig_get,v.id,"effect")
if v.cfgType and effect[v.cfgType]then
if effect[v.cfgType][id]then
table.insert(list,v)
end
end
end
end
return list
end

function shangHangModel:getEventHear(eventData)


return{type=eShangHangEventType.eHear,id=eventData.id,percent=eventData.percent,time=eventData.time,times=1,cfgType=eventData.cfgType}
end


function shangHangModel:setItemEventList(eventList)
if eventList then

local t

for i,v in ipairs(eventList)do
local cnt=v.param_4

local upType=v.param_2>0 and eShangHangEventUpType.eUp or eShangHangEventUpType.eDown



if cnt>=1 then
t={type=eShangHangEventType.eItemEvent,id=v.param_1,percent=v.param_2/100,time=v.param_3,times=cnt,upType=upType,cfgType=v.cnt}

if cnt==1 then
table.insert(self.data.eventList,shangHangModel:getEventHear(t))
end
local nextTime,checkEnd=shangHangModel:getNextChangeTime(true,timeHelper.convertLongStamp(v.param_3),true)
if cnt>=2 then
if cnt<=10 then
for i=2,cnt do
nextTime,checkEnd=shangHangModel:getNextChangeTime(true,timeHelper.convertLongStamp(nextTime),true)
end
end
t.time=nextTime
else
t.time=nextTime
end

if(not checkEnd)or checkEnd~=2 then
table.insert(self.data.eventList,t)
end
end



end
end
end

function shangHangModel:getItemList()
local eventItemList={}
local cfg=cfg_shanghangitemeventconfig()
for itemId,v in pairs(cfg)do
local all=bagControl.invokeFuncByItemId(itemId,'getAllItemByItemID',itemId)
local count=0
if next(all)then
for k,item in pairs(all)do
count=count+item.itemcount
local hasExpireTime=bagUseControl.hasExpireTime(item.itemguid)
if hasExpireTime then

if not bagUseControl.isItemExpire(item.itemguid)then
table.insert(eventItemList,item)
end
else
table.insert(eventItemList,item)
end
end
end
end
return eventItemList
end


function shangHangModel:getValInTime(id,time,percent)
local long=timeHelper.convertLongStamp(time)
local y_,m_,d_=timeHelper.getServerStampData(long)
local zero=timeHelper.timeServer(y_,m_,d_)
local change_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local changeStamp
local s
local num=#change_time
local index=0
for i=1,num do
index=num-i+1
s=change_time[index]
changeStamp=zero+s[1]*3600+s[2]*60+s[3]
if changeStamp<long then
local changeList=shangHangModel:getGuPiaochangeList(id)
if changeList then
local val=changeList[i]
return val*(1+percent/100)
end
break
end
end
end