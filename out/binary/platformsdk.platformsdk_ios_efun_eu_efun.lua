

local _task_type=
{
eGuaJi='1',
eDownLoad='2',
eOffLine='3',
}

local _task_status=
{
eStart='start',
eDoing='progress',
eEnd='end',
eFail='fail'
}


local taskid=
{
zongmenlingpai="5YYT4KGMDPSLZ",
youli="4YYT4KGMDPSLZ",
shouchao="3YYT4KGMDPSLZ",
}

local title=
{
[taskid.zongmenlingpai]="Excess Token Warning",
[taskid.youli]="Found a rare treasure",
[taskid.shouchao]="Monster Tide Invasion",
}

local body=
{
[taskid.zongmenlingpai]="Master! Tokens fully restored—return now! Tap to log in >>>  ",
[taskid.youli]="Master! Your disciple found rare treasures—log in now to claim! >>>  ",
[taskid.shouchao]="Abyssal Monster Tide event live! Join Now >>> ",
}






function platformSDK_iOS_EFun_Eu:setZMLingPaiNotifyTime(updateType,args)
platformSDK.printSDK("tuisongdayin setZMLingPaiNotifyTime：")
local moneytype=eMoneyType.mtLingPai

local maxNum=moneyModel.getMoneyMax(moneytype)
local curNum=moneyModel.getMoney(moneytype)
local full=curNum>=maxNum
local curStamp=timeHelper.getServerLongTime()
local stamp=curStamp
if full then
stamp=stamp+43200
self:setGuaJiNotify(taskid.zongmenlingpai,_task_type.eOffLine,_task_status.eStart,stamp)
else
local lefttime=moneyAutoIncreaseModel:getLeastTimeToFull(eMoneyType.mtLingPai)
if lefttime<=0 then
lefttime=43200
end

lefttime=lefttime+10
local stamp=curStamp+lefttime
self:setGuaJiNotify(taskid.zongmenlingpai,_task_type.eOffLine,_task_status.eStart,stamp)
end
end


function platformSDK_iOS_EFun_Eu:setChuanSongZhenYouLiNotifyTime(updateType,args)
if not systemModel.isOpen(SYSTEM_DEFINE.eChuanSongZhen)then return end
platformSDK.printSDK("tuisongdayin setChuanSongZhenYouLiNotifyTime：")
local curStamp=timeHelper.getServerLongTime()
local empty=chuanSongZhenModel:checkAllEmpty()
if empty then
local stamp=curStamp

stamp=stamp+10
stamp=stamp+41410
self:setGuaJiNotify(taskid.youli,_task_type.eOffLine,_task_status.eStart,stamp)
else
local stamp=chuanSongZhenModel:getRewardNotifyTime()
if curStamp>=stamp then
stamp=stamp+41400
end

stamp=stamp+10
self:setGuaJiNotify(taskid.youli,_task_type.eOffLine,_task_status.eStart,stamp)
end
end


function platformSDK_iOS_EFun_Eu:setTianYuanShouChaoNotifyTime(updateType,args)
if updateType==platformNotifyUpdateType.eUpdate then
local curStamp=timeHelper.getServerShortTime()
local offset=math.abs(curStamp%86400-28800)
platformSDK.printSDK("tuisongdayin setTianYuanShouChaoNotifyTime：",offset)
if offset<=10 and
(self.post_YTSC_Stamp==nil or

self.post_YTSC_Stamp and math.abs(self.post_YTSC_Stamp-curStamp)>60)then
self:setTianYuanShouChaoNotifyTime(platformNotifyUpdateType.eChanged,args)
end
else
local curStamp=timeHelper.getServerLongTime()
self.post_YTSC_Stamp=curStamp
local divWeek=0
local stampTable={}
local num=0
while(true)do
for day=2,6,2 do
local stamp=timeHelper.getWeakDateStamp(divWeek,day,8,0,0)
local offset=stamp-curStamp
if offset>10 then
stampTable[#stampTable+1]=stamp
num=num+1
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
platformSDK.printSDK("tuisongdayin setTianYuanShouChaoNotifyTime1：",#stampTable)
for i=1,#stampTable do
if stampTable[i]then
self:setGuaJiNotify(taskid.shouchao,_task_type.eOffLine,_task_status.eStart,stampTable[i],i)
end
end
end
end



function platformSDK_iOS_EFun_Eu:setGuaJiNotify(taskId,taskType,taskStatus,stampTime,index)
platformSDK.printSDK("tuisongdayin0：",taskId,taskType,taskStatus,stampTime)
if taskId==nil then return end
local key=string.format('notify_%s',taskId)
if taskId==taskid.shouchao and index then
key=string.format('notify_%s_%s',taskId,index)
end
local typo=ACTOR_SETTING_TYPE.ePlatformNotify
local localStamp=userActorArraySetting.get(typo,key)
if localStamp then

if timeHelper.isTodayStamp(localStamp)then
return
end
end
local uit={}
uit.taskId=taskId
uit.taskType=taskType
uit.taskStatus=taskStatus
uit.identifier=taskId
uit.title=title[taskId]or""
uit.body=body[taskId]or""
uit.interval=stampTime-timeHelper.getServerLongTime()

local jsonStr=jsonHelper.encode(uit)

self:callSDKFunc(iOSSDKCallType.eSetPush,jsonStr)

local stamp=timeHelper.getServerLongTime()
userActorArraySetting.set(typo,key,stamp)
userActorArraySetting.flush(typo,true)
end

function platformSDK_iOS_EFun_Eu:testNotify1()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.shouchao,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_iOS_EFun_Eu:testNotify2()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.youli,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_iOS_EFun_Eu:testNotify3()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.zongmenlingpai,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_iOS_EFun_Eu:setGuaJiNotifytest(taskId,taskType,taskStatus,stampTime)
if taskId==nil then return end
local uit={}
uit.taskId=taskId
uit.taskType=taskType
uit.taskStatus=taskStatus
uit.identifier=taskId
uit.title=title[taskId]or""
uit.body=body[taskId]or""
uit.interval=stampTime
local jsonStr=jsonHelper.encode(uit)
platformSDK.printSDK('setGuaJiNotifytest',stampTime)
self:callSDKFunc(iOSSDKCallType.eSetPush,jsonStr)
end

