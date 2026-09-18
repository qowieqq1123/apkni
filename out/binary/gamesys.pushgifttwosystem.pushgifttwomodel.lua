






local _MODULENAME="pushGiftTwoModel"




def_table(_MODULENAME)
pushGiftTwoModel.name=_MODULENAME
pushGiftTwoModel.data={}


function pushGiftTwoModel:onAppStart()

end


function pushGiftTwoModel:onEnterState(isReconnect)
pushGiftTwoModel:init(isReconnect)
end


function pushGiftTwoModel:onLeaveState(isReconnect)
pushGiftTwoModel:init(isReconnect)
end

function pushGiftTwoModel:onProtocolReq()


end

function pushGiftTwoModel:init(isReconnect)
local olddata=self.data or{}
local data={}
data.allList={}
data.allLookup={}

data.doingLookup={}
data.doingIds={}

data.expiredLookup={}
data.buyOverLookup={}

data.advertLookup={}
data.advertIds={}

data.expiredAgainLookup={}


if not isReconnect then
data.newGifts={}
data.newGiftLookup={}
else
data.newGifts=olddata.newGifts
data.newGiftLookup=olddata.newGiftLookup
end

data.hideGifts={}
data.hideGiftLookup={}

data.limitGiftsIds={}
data.limitGiftsLookup={}

self.data=data
end












function pushGiftTwoModel:initDatas(len,array)
self.data.allList=array or{}
self.data.allLookup={}

self.data.doingLookup={}
self.data.doingIds={}

self.data.buyOverLookup={}
self.data.expiredLookup={}
self.data.expiredAgainLookup={}

self.data.advertLookup={}
self.data.advertIds={}

self.data.hideGifts={}
self.data.hideGiftLookup={}

self.data.limitGiftsIds={}
self.data.limitGiftsLookup={}

for i,v in ipairs(array or{})do
self.data.allLookup[v.id]=v
self:initGiftData(v)
end

if#self.data.doingIds>1 then
table.sort(self.data.doingIds,function(a,b)
return(self.data.allLookup[a].starttime+a)<(self.data.allLookup[b].starttime+b)
end)
end

if#self.data.advertIds>1 then
table.sort(self.data.advertIds,function(a,b)
return(self.data.allLookup[a].starttime+a)<(self.data.allLookup[b].starttime+b)
end)
end


local len=#self.data.doingIds
for i=len,1,-1 do
local id=self.data.doingIds[i]
pushGiftTwoModel:checkRemoveGiftData(id)
end
end


function pushGiftTwoModel:getGiftIds()
return self.data.doingIds
end


function pushGiftTwoModel:clearGiftAdvertIds()
self.data.advertIds={}
self.data.advertLookup={}
end


function pushGiftTwoModel:getGiftAdvertIds(clear)
if not clear then
return self.data.advertIds
else
if#self.data.advertIds>0 then
local temp=table.deepCopy(self.data.advertIds)
if clear then
self.data.advertIds={}
self.data.advertLookup={}
end
return temp
end
return{}
end
end


function pushGiftTwoModel:getLimitGiftIds()
return self.data.limitGiftsIds
end

function pushGiftTwoModel:setAlreadyBuyTimes(id,idx,times)
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
local hasLeftTimes=pushGiftTwoModel:hasLeftBuyTimes(id)
if not hasLeftTimes then
pushGiftTwoModel:removeGiftData(id)
end
end

function pushGiftTwoModel:initGiftData(data)
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

local timesTable=pushGiftTwoConfig.getTotalBuyTimes(id)
local leftTimes=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftTwoConfig.getBuyTimesByCfg(id,i)
local buyTimes=_getAlreadyBuyTimes(i)
leftTimes=leftTimes+totalTimes-buyTimes
end

local showtime=pushGiftTwoConfig.getOpenTime(id)
local isExpired=false
if showtime~=-1 then
local endStamp=starttime+showtime
local stamp=timeHelper.getServerShortTime()
isExpired=stamp>=endStamp
end

local isResetData=pushGiftTwoConfig.isResetData(id)
if leftTimes<=0 and not isResetData then
self:setBuyOver(id)
elseif isExpired then
self:addExpiredData(data)
elseif leftTimes<=0 and not isExpired and isResetData then
self:addExpiredData(data)
else
if not pushGiftTwoHideControl:isHide(id)then
self.data.doingLookup[id]=true
self.data.doingIds[#self.data.doingIds+1]=id

self:addAdvertData(id)
if not pushGiftTwoConfig.isForver(id)then
self:addLimitData(id)
end
else
pushGiftTwoModel:addhideGift(id)
end
end
end

function pushGiftTwoModel:sortLimitData()
if#self.data.limitGiftsIds>1 then
local sortTag={}
local func=function(id)
return pushGiftTwoModel:getLeftBuyTime(id)or 0
end
local idxLookup,tlen=sortHelper.getSortLookup(self.data.limitGiftsIds,func)
for i,v in ipairs(self.data.limitGiftsIds)do
local idx=idxLookup[func(v)]
sortTag[v]=idx*1000+i
end
table.sort(self.data.limitGiftsIds,function(a,b)
return sortTag[a]<sortTag[b]
end)
end
end

function pushGiftTwoModel:addLimitData(id)
if not self.data.limitGiftsLookup[id]then
self.data.limitGiftsLookup[id]=true
self.data.limitGiftsIds[#self.data.limitGiftsIds+1]=id
self:sortLimitData()
pushGiftTwoManager:freshEnter()
end
end

function pushGiftTwoModel:removeLimitData(id)
if self.data.limitGiftsLookup[id]then
self.data.limitGiftsLookup[id]=nil
for i,v in ipairs(self.data.limitGiftsIds)do
if v==id then
table.remove(self.data.limitGiftsIds,i)
break
end
end
self:sortLimitData()
pushGiftTwoManager:freshEnter()
end
end

function pushGiftTwoModel:addAdvertData(id)
if not self:canPushAdvert(id)then return end
if self.data.advertLookup[id]then return end
self.data.advertLookup[id]=true
self.data.advertIds[#self.data.advertIds+1]=id
end

function pushGiftTwoModel:openGiftData(id,starttime,pushtimes)

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
if pushGiftTwoConfig.isResetData(id)then
v.len=0
v.list=nil
end
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
if not pushGiftTwoHideControl:isHide(id)then
self.data.doingIds[#self.data.doingIds+1]=id
self:addAdvertData(id)
if not pushGiftTwoConfig.isForver(id)then
self:addLimitData(id)
end
else
pushGiftTwoModel:addhideGift(id)
end
end

pushGiftTwoModel:addNewGift(id)
end

function pushGiftTwoModel:checkhideGift(id)
if self.data.doingLookup[id]and pushGiftTwoHideControl:isHide(id)then
pushGiftTwoModel:addhideGift(id)
pushGiftTwoModel:removeGiftData(id)
return true
end
return false
end

function pushGiftTwoModel:addhideGift(id)
if self.data.hideGiftLookup[id]then return end

self.data.hideGiftLookup[id]=true
self.data.hideGifts[#self.data.hideGifts+1]=id
end

function pushGiftTwoModel:isHide(id)
return self.data.hideGiftLookup[id]==true
end

function pushGiftTwoModel:initAllhideGift()
local doingIds=self.data.doingIds
if doingIds then
for i=#doingIds,1,-1 do
self:checkhideGift(doingIds[i])
end
end
end

function pushGiftTwoModel:checkRemoveGiftData(id)
local hasLeftTimes=pushGiftTwoModel:hasLeftBuyTimes(id)
local isForver=pushGiftTwoConfig.isForver(id)
if isForver then
if not hasLeftTimes then
pushGiftTwoModel:removeGiftData(id)
return true
end
elseif not hasLeftTimes or pushGiftTwoModel:getLeftBuyTime(id)<=0 then
pushGiftTwoModel:removeGiftData(id)
return true
end
return false
end

function pushGiftTwoModel:removeGiftData(id)
if self.data.doingLookup[id]then

local data=self.data.allLookup[id]

local hasBuyTimes=pushGiftTwoModel:hasLeftBuyTimes(id)
local leftTime=pushGiftTwoModel:getLeftBuyTime(id)
local isResetData=pushGiftTwoConfig.isResetData(id)
if not hasBuyTimes and not isResetData then
self:setBuyOver(id)
self:removeExpiredData(id)
elseif leftTime and leftTime<=0 then
self:addExpiredData(data)
elseif not hasBuyTimes and isResetData then
self:addExpiredData(data)
else

end

self.data.doingLookup[id]=nil

for i,v in ipairs(self.data.doingIds)do
if v==id then
table.remove(self.data.doingIds,i)
break
end
end

self.data.advertLookup[id]=nil
for i,v in ipairs(self.data.advertIds)do
if v==id then
table.remove(self.data.advertIds,i)
break
end
end

self:removeLimitData(id)

pushGiftTwoModel:removeNewGift(id)
end
end

function pushGiftTwoModel:setBuyOver(id)

self.data.buyOverLookup[id]=true
end

function pushGiftTwoModel:addExpiredData(data)
local id=data.id
if not self.data.expiredLookup[id]and data then

pushGiftTwoManager:resetStamp(id)
local pushTimes=data.times
local starttime=data.starttime
local nextTime=pushGiftTwoConfig.getNextPushTime(id,pushTimes)
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

self.data.expiredAgainLookup[id]=nextTime

UIManager:callWindowFunc('UIPushGiftBuyWin','onTimeCount',id)
end
end

function pushGiftTwoModel:removeExpiredData(id)
if self.data.expiredLookup[id]then

self.data.expiredLookup[id]=nil
self.data.expiredAgainLookup[id]=nil
end
end

function pushGiftTwoModel:getDoingData(id)
return self.data.doingLookup[id]
end

function pushGiftTwoModel:getAllData(id)
return self.data.allLookup[id]
end

function pushGiftTwoModel:getAllExpiredData()
return self.data.expiredLookup
end

function pushGiftTwoModel:getAllExpiredAgainData()
return self.data.expiredAgainLookup
end


function pushGiftTwoModel:isAlreadyDo(id)
return pushGiftTwoModel:isDoing(id)or
pushGiftTwoModel:isExpired(id)or
pushGiftTwoModel:isBuyOver(id)
end

function pushGiftTwoModel:isDoing(id)
return pushGiftTwoModel:getDoingData(id)==true
end

function pushGiftTwoModel:isExpired(id)
return self.data.expiredLookup[id]~=nil
end

function pushGiftTwoModel:isBuyOver(id)
return self.data.buyOverLookup[id]==true
end

function pushGiftTwoModel:isCanActive(id)
if self:isBuyOver(id)then return false end
if self:isExpired(id)then return false end
return not self:isDoing(id)
end


function pushGiftTwoModel:isExpiredAgain(id)
if self.data.expiredLookup[id]then
if self:isDoing(id)or(self:isBuyOver(id)and not pushGiftTwoConfig.isResetData(id))
or self:isHide(id)
or pushGiftTwoConfig.isNotPushAgain(id)then
return false
end
local cfg=pushGiftTwoConfig.getConfig(id)
if cfg and not pushGiftTwoManager:canOpen(cfg.openconf,nil,true)then return false end
local data=self.data.expiredLookup[id]
local nextStamp=data.nextTime
if not nextStamp or nextStamp<0 then return false end
local stamp=timeHelper.getServerShortTime()
return stamp>=nextStamp
end
return false
end

function pushGiftTwoModel:getBeginBuyTime(id)
local data=pushGiftTwoModel:getAllData(id)
if data then
return data.starttime
end
end

function pushGiftTwoModel:getStartedTime(id)
local starttime=pushGiftTwoModel:getBeginBuyTime(id)
if starttime then
local stamp=timeHelper.getServerShortTime()
return stamp-starttime
end
end

function pushGiftTwoModel:getLeftBuyTime(id)
local starttime=pushGiftTwoModel:getBeginBuyTime(id)
if starttime==nil then return end
local time=pushGiftTwoConfig.getOpenTime(id)
if time==-1 then return end
local endStamp=starttime+time
local stamp=timeHelper.getServerShortTime()
return endStamp-stamp
end

function pushGiftTwoModel:getAlreadyBuyTimesById(id)
local data=pushGiftTwoModel:getAllData(id)
if data then
local cnt=0
local list=data.list
if list==nil then return 0 end
for i,v in ipairs(list)do
cnt=cnt+v.param_2
end
return cnt
end
return 0
end

function pushGiftTwoModel:getAlreadyBuyTimes(id,idx)
local data=pushGiftTwoModel:getAllData(id)
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


function pushGiftTwoModel:getNextHasLeftBuyTimesGift(id)
local idx=1
local times=pushGiftTwoConfig.getConfig(id).times
local max=#times
while true do
local left=pushGiftTwoModel:getIdxLeftBuyTimes(id,idx)
if left>0 then return idx end
idx=idx+1
if idx>max then break end
end
return 1
end

function pushGiftTwoModel:getIdxLeftBuyTimes(id,idx)
local totalTimes=pushGiftTwoConfig.getBuyTimesByCfg(id,idx)
local buyTimes=pushGiftTwoModel:getAlreadyBuyTimes(id,idx)
return totalTimes-buyTimes
end

function pushGiftTwoModel:getLeftBuyTimes(id)
local timesTable=pushGiftTwoConfig.getTotalBuyTimes(id)
local t=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftTwoConfig.getBuyTimesByCfg(id,i)
local buyTimes=pushGiftTwoModel:getAlreadyBuyTimes(id,i)
t=t+totalTimes-buyTimes
end
return t
end

function pushGiftTwoModel:hasLeftBuyTimes(id)
return pushGiftTwoModel:getLeftBuyTimes(id)>0
end


function pushGiftTwoModel:addNewGift(id)
if pushGiftTwoHideControl:isHide(id)then return end
local flag=false
if not self.data.newGiftLookup[id]then
self.data.newGiftLookup[id]=true
self.data.newGifts[#self.data.newGifts+1]=id
reddotControl.onGiftChange()
end
end

function pushGiftTwoModel:removeNewGift(id)
if self.data.newGiftLookup[id]then
self.data.newGiftLookup[id]=nil
for i,v in ipairs(self.data.newGifts)do
if v==id then
table.remove(self.data.newGifts,i)
reddotControl.onGiftChange()
break
end
end
end
end

function pushGiftTwoModel:hasNewGift()
return#self.data.newGifts>0
end

function pushGiftTwoModel:isNewGift(id)
return self.data.newGiftLookup[id]==true
end



function pushGiftTwoModel:canPushAdvert(id)
local leftTimes=pushGiftTwoModel:getLeftBuyTimes(id)
if leftTimes<=0 then return false end
local giftCfg=pushGiftTwoConfig.getConfig(id)
if not giftCfg.advert then return false end
return pushGiftTwoModel:isCanPushAdvertByStamp(id)
end


function pushGiftTwoModel:isCanPushAdvertByStamp(id)
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
if pushGiftTwoConfig.isForver(id)then
local key=FMT.fmt('pushgift_two_{0}',id)
return userActorArraySetting.get(typo,key)==nil
else
local key=FMT.fmt('pushgift_two_day_{0}',id)
local lastStamp=userActorArraySetting.get(typo,key)
if lastStamp==nil then return true end
local longstamp=timeHelper.getServerZeroStamp(timeHelper.getServerLongTime())
local stamp=timeHelper.convertShortStamp(longstamp)
return lastStamp<stamp
end
end

function pushGiftTwoModel:flushPushAdvert(id)
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
local stamp=timeHelper.getServerShortTime()
local isCanPushAdvertByStamp=pushGiftTwoModel:isCanPushAdvertByStamp(id)
if pushGiftTwoConfig.isForver(id)then
if isCanPushAdvertByStamp then
local key=FMT.fmt('pushgift_two_{0}',id)
userActorArraySetting.set(typo,key,stamp)
pushGiftTwoModel:flushFile()
end
else
if isCanPushAdvertByStamp then
local key=FMT.fmt('pushgift_two_day_{0}',id)
userActorArraySetting.set(typo,key,stamp)
pushGiftTwoModel:flushFile()
end
end
end

function pushGiftTwoModel:flushFile()
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
userActorArraySetting.flush(typo)
end

function pushGiftTwoModel:flushSelectGiftItem()
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
userActorArraySetting.flush(typo)
end

function pushGiftTwoModel:setSelectGiftItemIdx(giftId,pageIdx,hoidIdx,index,flush)
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
local key=FMT.fmt('two_{0}_{1}_{2}',giftId,pageIdx,hoidIdx)
userActorArraySetting.set(typo,key,index)
if flush then
userActorArraySetting.flush(typo)
end
end

function pushGiftTwoModel:getSelectGiftItemIdx(giftId,pageIdx,hoidIdx)
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
local key=FMT.fmt('two_{0}_{1}_{2}',giftId,pageIdx,hoidIdx)
return userActorArraySetting.get(typo,key)
end

function pushGiftTwoModel:isOptionItemUnlock(giftId,lvIdx,hoidIdx,index)
local groupCfg=pushGiftTwoConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if groupCfg==nil then return false end
local optionCfg=groupCfg[index]
local params=optionCfg[2]
return pushGiftTwoOptionCfg.isUnlock(params)
end

function pushGiftTwoModel:isFillAllOption(giftId,lvIdx,lookup,defaultLookup)
local rewards=pushGiftTwoConfig:getOptionRewards(giftId,lvIdx)
if rewards==nil then return true end
for hoidIdx,v in pairs(rewards)do
if lookup==nil and defaultLookup==nil then return false,hoidIdx end
local index=lookup and lookup[hoidIdx]or defaultLookup and defaultLookup[hoidIdx]or nil
if index==nil then return false,hoidIdx end
end
return true
end
