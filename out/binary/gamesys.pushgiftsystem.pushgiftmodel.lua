






local _MODULENAME="pushGiftModel"




def_table(_MODULENAME)
pushGiftModel.name=_MODULENAME
pushGiftModel.data={}


function pushGiftModel:onAppStart()

end


function pushGiftModel:onEnterState(isReconnect)
pushGiftModel:init()
end


function pushGiftModel:onLeaveState(isReconnect)
pushGiftModel:init()
end

function pushGiftModel:onProtocolReq()


end

function pushGiftModel:init()
self.data={}
self.data.allList={}
self.data.allLookup={}

self.data.doingLookup={}
self.data.doingIds={}

self.data.expiredLookup={}
self.data.buyOverLookup={}

self.data.hideGifts={}
self.data.hideGiftLookup={}
end












function pushGiftModel:initDatas(len,array)
self.data.allList=array or{}
self.data.allLookup={}

self.data.doingLookup={}
self.data.doingIds={}

self.data.buyOverLookup={}
self.data.expiredLookup={}

self.data.hideGifts={}
self.data.hideGiftLookup={}

for i,v in ipairs(array or{})do
self.data.allLookup[v.id]=v
self:initGiftData(v)
end

if#self.data.doingIds>1 then
table.sort(self.data.doingIds,function(a,b)
return(self.data.allLookup[a].starttime+a)<(self.data.allLookup[b].starttime+b)
end)
end


local len=#self.data.doingIds
for i=len,1,-1 do
local id=self.data.doingIds[i]
if not pushGiftModel:hasLeftBuyTimes(id)or
pushGiftModel:getLeftBuyTime(id)<=0 then
pushGiftModel:removeGiftData(id)
end
end
end

function pushGiftModel:getGiftIds()
return self.data.doingIds
end

function pushGiftModel:setAlreadyBuyTimes(id,idx,times)
local info=self.data.allLookup[id]
local list=info.list
if list==nil then
info.list={}
info.len=1
list=info.list
list[#list+1]={param_1=idx,param_2=times}
else
local flag=false
for i,v in ipairs(list)do
if v.param_1==idx then
v.param_2=times
flag=true
break
end
end
if not flag then
list[#list+1]={param_1=idx,param_2=times}
end
end
end

function pushGiftModel:initGiftData(data)
local id=data.id
local starttime=data.starttime
local list=data.list

local _getAlreadyBuyTimes=function(idx)
if list==nil then return 0 end
for i,v in ipairs(list)do
if idx==v.param_1 then
return v.param_2
end
end
return 0
end

local timesTable=pushGiftConfig.getTotalBuyTimes(id)
local leftTimes=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftConfig.getBuyTimesByCfg(id,i)
local buyTimes=_getAlreadyBuyTimes(i)
leftTimes=leftTimes+totalTimes-buyTimes
end

local showtime=pushGiftConfig.getOpenTime(id)
local endStamp=starttime+showtime
local stamp=timeHelper.getServerShortTime()
local isExpired=stamp>=endStamp

if leftTimes<=0 then
self:setBuyOver(id)
elseif isExpired then
self:addExpiredData(data)
else
if not pushGiftHideControl:isHide(id)then
self.data.doingLookup[id]=true
self.data.doingIds[#self.data.doingIds+1]=id
else
pushGiftModel:addhideGift(id)
end
end
end

function pushGiftModel:openGiftData(id,starttime,pushtimes)

self:removeExpiredData(id)

local data=
{
id=id,
starttime=starttime,
times=pushtimes,
}

local lastData=self.data.allLookup[id]
if lastData==nil then
self.data.allLookup[id]=data
self.data.allList[#self.data.allList+1]=data

else
for i,v in ipairs(self.data.allList)do
if v.id==id then
v.times=pushtimes
v.starttime=starttime
self.data.allLookup[id]=v

break
end
end
end

local lastData=self.data.doingLookup[id]
self.data.doingLookup[id]=true
local flag=false
for i,v in ipairs(self.data.doingIds)do
if v==id then
flag=true
break
end
end
if not flag then
if not pushGiftHideControl:isHide(id)then
self.data.doingIds[#self.data.doingIds+1]=id
else
pushGiftModel:addhideGift(id)
end
end
end

function pushGiftModel:checkhideGift(id)
if self.data.doingLookup[id]and pushGiftHideControl:isHide(id)then
pushGiftModel:addhideGift(id)
pushGiftModel:removeGiftData(id)
end
end

function pushGiftModel:addhideGift(id)
if self.data.hideGiftLookup[id]then return end

self.data.hideGiftLookup[id]=true
self.data.hideGifts[#self.data.hideGifts+1]=id
end

function pushGiftModel:initAllhideGift()
local doingIds=self.data.doingIds
if doingIds then
for i=#doingIds,1,-1 do
self:checkhideGift(doingIds[i])
end
end
end

function pushGiftModel:removeGiftData(id)
if self.data.doingLookup[id]then

local data=self.data.allLookup[id]

local hasBuyTimes=pushGiftModel:hasLeftBuyTimes(id)
local leftTime=pushGiftModel:getLeftBuyTime(id)
if not hasBuyTimes then
self:setBuyOver(id)
self:removeExpiredData(id)
elseif leftTime<=0 then
self:addExpiredData(data)
else
loggerUtil.logErrFMT('推送礼包{0}持续时间内删除了',id)
end

self.data.doingLookup[id]=nil

for i,v in ipairs(self.data.doingIds)do
if v==id then
table.remove(self.data.doingIds,i)
break
end
end
end
end

function pushGiftModel:setBuyOver(id)

self.data.buyOverLookup[id]=true
end

function pushGiftModel:addExpiredData(data)
local id=data.id
if not self.data.expiredLookup[id]and data then

pushGiftManager:resetStamp(id)
local pushTimes=data.times
local starttime=data.starttime
local nextTime=pushGiftConfig.getNextPushTime(id,pushTimes)
if nextTime then
nextTime=nextTime+starttime
else
nextTime=nil
end
local info=
{
id=id,
starttime=starttime,
times=pushTimes,
nextTime=nextTime,
}
self.data.expiredLookup[id]=info
end
end

function pushGiftModel:removeExpiredData(id)
if self.data.expiredLookup[id]then

self.data.expiredLookup[id]=nil
end
end

function pushGiftModel:getDoingData(id)
return self.data.doingLookup[id]
end

function pushGiftModel:getAllData(id)
return self.data.allLookup[id]
end

function pushGiftModel:getAllExpiredData()
return self.data.expiredLookup
end

function pushGiftModel:isDoing(id)
return pushGiftModel:getDoingData(id)==true
end

function pushGiftModel:isExpired(id)
return self.data.expiredLookup[id]~=nil
end

function pushGiftModel:isBuyOver(id)
return self.data.buyOverLookup[id]==true
end

function pushGiftModel:isCanActive(id)
if self:isBuyOver(id)then return false end
if self:isExpired(id)then return false end
return not self:isDoing(id)
end

function pushGiftModel:isExpiredAgain(id)
if self.data.expiredLookup[id]then
if self:isDoing(id)or self:isBuyOver(id)then return false end
local cfg=pushGiftConfig.getConfig(id)
if cfg and not pushGiftManager:canOpen(cfg.openconf,nil,true)then return false end
local data=self.data.expiredLookup[id]
local nextStamp=data.nextTime
if not nextStamp or nextStamp<0 then return false end
local stamp=timeHelper.getServerShortTime()
return stamp>=nextStamp
end
return false
end

function pushGiftModel:getBeginBuyTime(id)
local data=pushGiftModel:getAllData(id)
if data then
return data.starttime
end
end

function pushGiftModel:getLeftBuyTime(id)
local starttime=pushGiftModel:getBeginBuyTime(id)
if starttime==nil then return end
local time=pushGiftConfig.getOpenTime(id)
local endStamp=starttime+time
local stamp=timeHelper.getServerShortTime()
return endStamp-stamp
end

function pushGiftModel:getAlreadyBuyTimes(id,idx)
local data=pushGiftModel:getAllData(id)
if data then
local list=data.list or{}
for i,v in ipairs(list)do
if idx==v.param_1 then
return v.param_2
end
end
end
return 0
end


function pushGiftModel:getNextHasLeftBuyTimesGift(id)
local idx=1
local times=cfg_limitedtimegiftconfig_get(id).times
local max=#times
while true do
local left=pushGiftModel:getIdxLeftBuyTimes(id,idx)
if left>0 then return idx end
idx=idx+1
if idx>max then break end
end
return 1
end

function pushGiftModel:getIdxLeftBuyTimes(id,idx)
local totalTimes=pushGiftConfig.getBuyTimesByCfg(id,idx)
local buyTimes=pushGiftModel:getAlreadyBuyTimes(id,idx)
return totalTimes-buyTimes
end

function pushGiftModel:getLeftBuyTimes(id)
local timesTable=pushGiftConfig.getTotalBuyTimes(id)
local t=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftConfig.getBuyTimesByCfg(id,i)
local buyTimes=pushGiftModel:getAlreadyBuyTimes(id,i)
t=t+totalTimes-buyTimes
end
return t
end

function pushGiftModel:hasLeftBuyTimes(id)
return pushGiftModel:getLeftBuyTimes(id)>0
end


