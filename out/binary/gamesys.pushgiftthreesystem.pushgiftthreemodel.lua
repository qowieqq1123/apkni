






local _MODULENAME="pushGiftThreeModel"




def_table(_MODULENAME)
pushGiftThreeModel.name=_MODULENAME
pushGiftThreeModel.data={}


function pushGiftThreeModel:onAppStart()

end


function pushGiftThreeModel:onEnterState(isReconnect)
pushGiftThreeModel:init(isReconnect)
end


function pushGiftThreeModel:onLeaveState(isReconnect)
pushGiftThreeModel:init(isReconnect)
end

function pushGiftThreeModel:onProtocolReq()


end

function pushGiftThreeModel:init(isReconnect)
local olddata=self.data or{}
local data={}
data.allList={}
data.allLookup={}

data.doingLookup={}
data.doingIds={}

data.expiredLookup={}
data.buyOverLookup={}
data.expiredAgainLookup={}

data.advertLookup={}
data.advertIds={}


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

data.adverttypeGiftsIds={}
data.adverttypeGiftsLookup={}

self.data=data
end













function pushGiftThreeModel:initDatas(len,array)
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

self.data.adverttypeGiftsIds={}
self.data.adverttypeGiftsLookup={}

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
pushGiftThreeModel:checkRemoveGiftData(id)
end
end


function pushGiftThreeModel:getGiftIds()
return self.data.doingIds
end


function pushGiftThreeModel:clearGiftAdvertIds()
self.data.advertIds={}
self.data.advertLookup={}
end


function pushGiftThreeModel:getGiftAdvertIds(clear)
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


function pushGiftThreeModel:getLimitGiftIds()
return self.data.limitGiftsIds
end

function pushGiftThreeModel:setAlreadyBuyTimes(id,idx,times)
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
local hasLeftTimes=pushGiftThreeModel:hasLeftBuyTimes(id)
if not hasLeftTimes then
pushGiftThreeModel:removeGiftData(id)
end
end

function pushGiftThreeModel:initGiftData(data)
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

local timesTable=pushGiftThreeConfig.getTotalBuyTimes(id)
local leftTimes=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,i)
local buyTimes=_getAlreadyBuyTimes(i)
leftTimes=leftTimes+totalTimes-buyTimes
end

local showtime=pushGiftThreeConfig.getOpenTime(id)
local isExpired=false
if showtime~=-1 then
local endStamp=starttime+showtime
local stamp=timeHelper.getServerShortTime()
isExpired=stamp>=endStamp
end

local isResetData=pushGiftThreeConfig.isResetData(id)
if leftTimes<=0 and not isResetData then
self:setBuyOver(id)
elseif isExpired then
self:addExpiredData(data)
elseif leftTimes<=0 and not isExpired and isResetData then
self:addExpiredData(data)
else
if not pushGiftThreeHideControl:isHide(id)then
self.data.doingLookup[id]=true
self.data.doingIds[#self.data.doingIds+1]=id
self:addAdverttypeData(id)

self:addAdvertData(id)
if not pushGiftThreeConfig.isForver(id)then
self:addLimitData(id)
end
else
pushGiftThreeModel:addhideGift(id)
end
end
end

function pushGiftThreeModel:getAdverttypeLen(adverttype)
local list=self.data.adverttypeGiftsIds[adverttype]
if list==nil then return 0 end
return#list
end

function pushGiftThreeModel:isDoingByAdverttype(id)
return self.data.adverttypeGiftsLookup[id]==true
end

function pushGiftThreeModel:addAdverttypeData(id)
local adverttype=pushGiftThreeConfig.getAdvettype(id)
if adverttype==nil then return end
if self.data.adverttypeGiftsLookup[id]then return end

local str=FMT.fmt('three_{0}',adverttype)
local oldstamp=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePushThreeGift,str,nil)
if oldstamp then
userActorArraySetting.set(ACTOR_SETTING_TYPE.ePushThreeGift,str,nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.ePushThreeGift,true)
end
self.data.adverttypeGiftsLookup[id]=true
if self.data.adverttypeGiftsIds[adverttype]==nil then self.data.adverttypeGiftsIds[adverttype]={}end
local list=self.data.adverttypeGiftsIds[adverttype]
list[#list+1]=id
end

function pushGiftThreeModel:removeAdverttypeData(id)
local adverttype=pushGiftThreeConfig.getAdvettype(id)
if adverttype==nil then return end
if not self.data.adverttypeGiftsLookup[id]then return end
self.data.adverttypeGiftsLookup[id]=nil
if self.data.adverttypeGiftsIds[adverttype]==nil then self.data.adverttypeGiftsIds[adverttype]={}end
local list=self.data.adverttypeGiftsIds[adverttype]
for i,v in ipairs(list)do
if v==id then
table.remove(list,i)
break
end
end


local str=FMT.fmt('three_{0}',adverttype)
local oldstamp=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePushThreeGift,str,nil)
if oldstamp==nil then
local space=pushGiftThreeConfig.getAdvettypeSpace(adverttype)
local stamp=timeHelper.getServerShortTime()+space
userActorArraySetting.set(ACTOR_SETTING_TYPE.ePushThreeGift,str,stamp)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.ePushThreeGift,true)
end
end

function pushGiftThreeModel:sortLimitData()
if#self.data.limitGiftsIds>1 then
local sortTag={}
local func=function(id)
return pushGiftThreeModel:getLeftBuyTime(id)or 0
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

function pushGiftThreeModel:addLimitData(id)
if not self.data.limitGiftsLookup[id]then
self.data.limitGiftsLookup[id]=true
self.data.limitGiftsIds[#self.data.limitGiftsIds+1]=id
self:sortLimitData()
pushGiftThreeManager:freshEnter()
end
end

function pushGiftThreeModel:removeLimitData(id)
if self.data.limitGiftsLookup[id]then
self.data.limitGiftsLookup[id]=nil
for i,v in ipairs(self.data.limitGiftsIds)do
if v==id then
table.remove(self.data.limitGiftsIds,i)
break
end
end
self:sortLimitData()
pushGiftThreeManager:freshEnter()
end
end

function pushGiftThreeModel:addAdvertData(id)
if not self:canPushAdvert(id)then return end
if self.data.advertLookup[id]then return end
self.data.advertLookup[id]=true
self.data.advertIds[#self.data.advertIds+1]=id
end

function pushGiftThreeModel:openGiftData(id,starttime,pushtimes)

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
if pushGiftThreeConfig.isResetData(id)then
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
if not pushGiftThreeHideControl:isHide(id)then
self.data.doingIds[#self.data.doingIds+1]=id
self:addAdverttypeData(id)
self:addAdvertData(id)
if not pushGiftThreeConfig.isForver(id)then
self:addLimitData(id)
end
else
pushGiftThreeModel:addhideGift(id)
end
end

pushGiftThreeModel:addNewGift(id)
end

function pushGiftThreeModel:checkhideGift(id)
if self.data.doingLookup[id]and pushGiftThreeHideControl:isHide(id)then
pushGiftThreeModel:addhideGift(id)
pushGiftThreeModel:removeGiftData(id)
return true
end
return false
end

function pushGiftThreeModel:addhideGift(id)
if self.data.hideGiftLookup[id]then return end

self.data.hideGiftLookup[id]=true
self.data.hideGifts[#self.data.hideGifts+1]=id
end

function pushGiftThreeModel:isHide(id)
return self.data.hideGiftLookup[id]==true
end

function pushGiftThreeModel:initAllhideGift()
local doingIds=self.data.doingIds
if doingIds then
for i=#doingIds,1,-1 do
self:checkhideGift(doingIds[i])
end
end
end

function pushGiftThreeModel:checkRemoveGiftData(id)
local hasLeftTimes=pushGiftThreeModel:hasLeftBuyTimes(id)
local isForver=pushGiftThreeConfig.isForver(id)
if isForver then
if not hasLeftTimes then
pushGiftThreeModel:removeGiftData(id)
return true
end
elseif not hasLeftTimes or pushGiftThreeModel:getLeftBuyTime(id)<=0 then
pushGiftThreeModel:removeGiftData(id)
return true
end
return false
end

function pushGiftThreeModel:removeGiftData(id)
if self.data.doingLookup[id]then

local data=self.data.allLookup[id]

local hasBuyTimes=pushGiftThreeModel:hasLeftBuyTimes(id)
local leftTime=pushGiftThreeModel:getLeftBuyTime(id)
local isResetData=pushGiftThreeConfig.isResetData(id)
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

self:removeAdverttypeData(id)

self:removeLimitData(id)

pushGiftThreeModel:removeNewGift(id)
end
end

function pushGiftThreeModel:setBuyOver(id)

self.data.buyOverLookup[id]=true
end

function pushGiftThreeModel:addExpiredData(data)
local id=data.id
if not self.data.expiredLookup[id]and data then

pushGiftThreeManager:resetStamp(id)
local pushTimes=data.times
local starttime=data.starttime
local nextTime=pushGiftThreeConfig.getNextPushTime(id,pushTimes)
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
UIManager:callWindowFunc('UIPushGiftBuyThreeWin','onTimeCount',id)
end
end

function pushGiftThreeModel:removeExpiredData(id)
if self.data.expiredLookup[id]then

self.data.expiredLookup[id]=nil
self.data.expiredAgainLookup[id]=nil
end
end

function pushGiftThreeModel:getDoingData(id)
return self.data.doingLookup[id]
end

function pushGiftThreeModel:getAllData(id)
return self.data.allLookup[id]
end

function pushGiftThreeModel:getAllExpiredData()
return self.data.expiredLookup
end

function pushGiftThreeModel:getAllExpiredAgainData()
return self.data.expiredAgainLookup
end


function pushGiftThreeModel:isAlreadyDo(id)
return pushGiftThreeModel:isDoing(id)or
pushGiftThreeModel:isExpired(id)or
pushGiftThreeModel:isBuyOver(id)
end

function pushGiftThreeModel:isDoing(id)
return pushGiftThreeModel:getDoingData(id)==true
end

function pushGiftThreeModel:isExpired(id)
return self.data.expiredLookup[id]~=nil
end

function pushGiftThreeModel:isBuyOver(id)
return self.data.buyOverLookup[id]==true
end

function pushGiftThreeModel:isCanActive(id)
if self:isBuyOver(id)then return false end
if self:isExpired(id)then return false end
return not self:isDoing(id)
end


function pushGiftThreeModel:isExpiredAgain(id)
if self.data.expiredLookup[id]then
if self:isDoing(id)or(self:isBuyOver(id)and not pushGiftThreeConfig.isResetData(id))
or self:isHide(id)
or pushGiftThreeConfig.isNotPushAgain(id)then
return false
end
local cfg=pushGiftThreeConfig.getConfig(id)
if cfg and not pushGiftThreeManager:canOpen(cfg.openconf,nil,true)then return false end
local data=self.data.expiredLookup[id]
local nextStamp=data.nextTime
if not nextStamp or nextStamp<0 then return false end
local stamp=timeHelper.getServerShortTime()
return stamp>=nextStamp
end
return false
end

function pushGiftThreeModel:getBeginBuyTime(id)
local data=pushGiftThreeModel:getAllData(id)
if data then
return data.starttime
end
end

function pushGiftThreeModel:getStartedTime(id)
local starttime=pushGiftThreeModel:getBeginBuyTime(id)
if starttime then
local stamp=timeHelper.getServerShortTime()
return stamp-starttime
end
end

function pushGiftThreeModel:getLeftBuyTime(id)
local starttime=pushGiftThreeModel:getBeginBuyTime(id)
if starttime==nil then return end
local time=pushGiftThreeConfig.getOpenTime(id)
if time==-1 then return end
local endStamp=starttime+time
local stamp=timeHelper.getServerShortTime()
return endStamp-stamp
end

function pushGiftThreeModel:getAlreadyBuyTimesById(id)
local data=pushGiftThreeModel:getAllData(id)
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

function pushGiftThreeModel:getAlreadyBuyTimes(id,idx)
local data=pushGiftThreeModel:getAllData(id)
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


function pushGiftThreeModel:getNextHasLeftBuyTimesGift(id)
local idx=1
local times=pushGiftThreeConfig.getConfig(id).times
local max=#times
while true do
local left=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
if left>0 then return idx end
idx=idx+1
if idx>max then break end
end
return 1
end

function pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
local totalTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
local buyTimes=pushGiftThreeModel:getAlreadyBuyTimes(id,idx)
return totalTimes-buyTimes
end

function pushGiftThreeModel:getLeftBuyTimes(id)
local timesTable=pushGiftThreeConfig.getTotalBuyTimes(id)
local t=0
for i,v in ipairs(timesTable)do
local totalTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,i)
local buyTimes=pushGiftThreeModel:getAlreadyBuyTimes(id,i)
t=t+totalTimes-buyTimes
end
return t
end

function pushGiftThreeModel:hasLeftBuyTimes(id)
return pushGiftThreeModel:getLeftBuyTimes(id)>0
end


function pushGiftThreeModel:addNewGift(id)
if pushGiftThreeHideControl:isHide(id)then return end
local flag=false
if not self.data.newGiftLookup[id]then
self.data.newGiftLookup[id]=true
self.data.newGifts[#self.data.newGifts+1]=id
reddotControl.onGiftChange()
end
end

function pushGiftThreeModel:removeNewGift(id)
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

function pushGiftThreeModel:hasNewGift()
return#self.data.newGifts>0
end

function pushGiftThreeModel:isNewGift(id)
return self.data.newGiftLookup[id]==true
end



function pushGiftThreeModel:canPushAdvert(id)
local leftTimes=pushGiftThreeModel:getLeftBuyTimes(id)
if leftTimes<=0 then return false end
local giftCfg=pushGiftThreeConfig.getConfig(id)
if not giftCfg.advert then return false end
return pushGiftThreeModel:isCanPushAdvertByStamp(id)
end


function pushGiftThreeModel:isCanPushAdvertByStamp(id)
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
if pushGiftThreeConfig.isForver(id)then
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

function pushGiftThreeModel:flushPushAdvert(id)
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
local stamp=timeHelper.getServerShortTime()
local isCanPushAdvertByStamp=pushGiftThreeModel:isCanPushAdvertByStamp(id)
if pushGiftThreeConfig.isForver(id)then
if isCanPushAdvertByStamp then
local key=FMT.fmt('pushgift_two_{0}',id)
userActorArraySetting.set(typo,key,stamp)
pushGiftThreeModel:flushFile()
end
else
if isCanPushAdvertByStamp then
local key=FMT.fmt('pushgift_two_day_{0}',id)
userActorArraySetting.set(typo,key,stamp)
pushGiftThreeModel:flushFile()
end
end
end

function pushGiftThreeModel:flushFile()
local typo=ACTOR_SETTING_TYPE.eFaceAdvert
userActorArraySetting.flush(typo)
end


function pushGiftThreeModel:flushSelectGiftItem()
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
userActorArraySetting.flush(typo)
end

function pushGiftThreeModel:setSelectGiftItemIdx(giftId,lvIdx,hoidIdx,index,flush)
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
local key=FMT.fmt('three_{0}_{1}_{2}',giftId,lvIdx,hoidIdx)
userActorArraySetting.set(typo,key,index)
if flush then
userActorArraySetting.flush(typo)
end
end

function pushGiftThreeModel:getSelectGiftItemIdx(giftId,lvIdx,hoidIdx)
local typo=ACTOR_SETTING_TYPE.ePushSelectItem
local key=FMT.fmt('three_{0}_{1}_{2}',giftId,lvIdx,hoidIdx)
return userActorArraySetting.get(typo,key)
end

function pushGiftThreeModel:isOptionItemUnlock(giftId,lvIdx,hoidIdx,index)
local groupCfg=pushGiftThreeConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if groupCfg==nil then return false end
local optionCfg=groupCfg[index]
local params=optionCfg[2]
return pushGiftThreeOptionCfg.isUnlock(params)
end

function pushGiftThreeModel:isFillAllOption(giftId,lvIdx,lookup,defaultLookup)
local rewards=pushGiftThreeConfig:getOptionRewards(giftId,lvIdx)
if rewards==nil then return true end
for hoidIdx,v in pairs(rewards)do
if lookup==nil and defaultLookup==nil then return false,hoidIdx end
local index=lookup and lookup[hoidIdx]or defaultLookup and defaultLookup[hoidIdx]or nil
if index==nil then return false,hoidIdx end
end
return true
end
