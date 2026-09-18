


function platformSDK_iOS_XJ:setZMLingPaiNotifyTime(updateType,args)
local moneytype=eMoneyType.mtLingPai

local notifyIdStr='zmlp'
local content='祖师！令牌已回复满！'
local maxNum=moneyModel.getMoneyMax(moneytype)
local curNum=moneyModel.getMoney(moneytype)
local full=curNum>=maxNum
local curStamp=timeHelper.getServerLongTime()
local stamp=curStamp
if full then

stamp=stamp+43200
local notifyId=FMT.fmt('{0}_{1}',notifyIdStr,1)
self:setGuanBaoNotify(notifyId,content,stamp)

else
local lefttime=moneyAutoIncreaseModel:getLeastTimeToFull(eMoneyType.mtLingPai)
if lefttime<=0 then
lefttime=43200
end

lefttime=lefttime+10

local stamp=curStamp+lefttime

local notifyId=FMT.fmt('{0}_{1}',notifyIdStr,1)
self:setGuanBaoNotify(notifyId,content,stamp)






end
end


function platformSDK_iOS_XJ:setChuanSongZhenYouLiNotifyTime(updateType,args)
if not systemModel.isOpen(SYSTEM_DEFINE.eChuanSongZhen)then return end
local notifyIdStr='cszyl'
local content='祖师！弟子游历寻得宝物，快上线领取！'
local curStamp=timeHelper.getServerLongTime()
local empty=chuanSongZhenModel:checkAllEmpty()
if empty then
local stamp=curStamp

stamp=stamp+10


stamp=stamp+41410
local notifyId=FMT.fmt('{0}_{1}',notifyIdStr,1)
self:setGuanBaoNotify(notifyId,content,stamp)

else
local stamp=chuanSongZhenModel:getRewardNotifyTime()
if curStamp>=stamp then
stamp=stamp+41400
end

stamp=stamp+10
local notifyId=FMT.fmt('{0}_{1}',notifyIdStr,1)
self:setGuanBaoNotify(notifyId,content,stamp)






end
end


function platformSDK_iOS_XJ:setTianYuanShouChaoNotifyTime(updateType,args)
if updateType==platformNotifyUpdateType.eUpdate then
local curStamp=timeHelper.getServerShortTime()
local offset=math.abs(curStamp%86400-28800)
if offset<=10 and
(self.post_YTSC_Stamp==nil or

self.post_YTSC_Stamp and math.abs(self.post_YTSC_Stamp-curStamp)>60)then
self:setTianYuanShouChaoNotifyTime(platformNotifyUpdateType.eChanged,args)
end
else
local notifyIdStr='tysc'
local content='天渊兽潮活动开启！！'
local curStamp=timeHelper.getServerLongTime()
self.post_YTSC_Stamp=curStamp
local divWeek=0
local num=0
while(true)do
for day=2,6,2 do
local stamp=timeHelper.getWeakDateStamp(divWeek,day,8,0,0)
local offset=stamp-curStamp
if offset>10 then
num=num+1
local notifyId=FMT.fmt('{0}_{1}',notifyIdStr,num)
self:setGuanBaoNotify(notifyId,content,stamp)
if num>=7 then
break
end
end
end
if num>=7 then
break
end
divWeek=divWeek+1
end
end
end


function platformSDK_iOS_XJ:setGuanBaoNotify(notifyId,content,stamp)
if notifyId==nil then return end
local key=string.format('guanbao_%s',notifyId)
local typo=ACTOR_SETTING_TYPE.ePlatformNotify
local localStamp=userActorArraySetting.get(typo,key)
if localStamp then

if timeHelper.isTodayStamp(localStamp)then
return
end
end

local uit={}
uit.notifyId=notifyId
uit.notifyType='addStampMsg'
uit.notifyContent=content
uit.notifyStamp=stamp

local jsonStr=jsonHelper.encode(uit)

self:callSDKFunc(iOSSDKCallType.eNotify,jsonStr)

local stamp=timeHelper.getServerLongTime()
userActorArraySetting.set(typo,key,stamp)
userActorArraySetting.flush(typo,true)
end

function platformSDK_iOS_XJ:removeGuanBaoNotify(notifyId)
local key=string.format('guanbao_%s',notifyId)
local typo=ACTOR_SETTING_TYPE.ePlatformNotify
local localStamp=userActorArraySetting.get(typo,key)
if localStamp then
local uit={}
uit.notifyId=notifyId
uit.notifyType='removeNotify'
local jsonStr=jsonHelper.encode(uit)
self:callSDKFunc(iOSSDKCallType.eNotify,jsonStr)
userActorArraySetting.set(typo,key,nil)
userActorArraySetting.flush(typo,true)
end
end
