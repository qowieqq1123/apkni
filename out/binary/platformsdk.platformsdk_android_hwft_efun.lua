

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
[taskid.zongmenlingpai]="令牌溢出提醒",
[taskid.youli]="發現珍稀寶物",
[taskid.shouchao]="獸潮來襲",
}

local body=
{
[taskid.zongmenlingpai]="宗師大人！令牌已回復全滿，請速回使用！點擊登入>>>",
[taskid.youli]="宗師大人！弟子遊歷尋得珍稀寶物，快快上線查看！前往領取>>>",
[taskid.shouchao]="天淵獸潮活動已開啟！立即前往>>>",
}






function platformSDK_Android_HWFT:setZMLingPaiNotifyTime(updateType,args)
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


function platformSDK_Android_HWFT:setChuanSongZhenYouLiNotifyTime(updateType,args)
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


function platformSDK_Android_HWFT:setTianYuanShouChaoNotifyTime(updateType,args)
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



function platformSDK_Android_HWFT:setGuaJiNotify(taskId,taskType,taskStatus,stampTime,index)
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
uit.delay=taskId
uit.Title=title[taskId]or""
uit.Body=body[taskId]or""
uit.Time=stampTime-timeHelper.getServerLongTime()

local jsonStr=jsonHelper.encode(uit)

platformSDK.printSDK("tuisongdayin1：",jsonStr)
androidTool.callFunc('BuildPushScheduleLocal',jsonStr)
local stamp=timeHelper.getServerLongTime()
userActorArraySetting.set(typo,key,stamp)
userActorArraySetting.flush(typo,true)
end

function platformSDK_Android_HWFT:testNotify1()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.shouchao,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_Android_HWFT:testNotify2()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.youli,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_Android_HWFT:testNotify3()
local stamp=10
local stampTime=stamp
self:setGuaJiNotifytest(taskid.zongmenlingpai,_task_type.eOffLine,_task_status.eStart,stampTime)
end

function platformSDK_Android_HWFT:setGuaJiNotifytest(taskId,taskType,taskStatus,stampTime)
if taskId==nil then return end
local uit={}
uit.taskId=taskId
uit.taskType=taskType
uit.taskStatus=taskStatus
uit.delay=taskId
uit.Title=title[taskId]or""
uit.Body=body[taskId]or""
uit.Time=stampTime
local jsonStr=jsonHelper.encode(uit)
androidTool.callFunc('BuildPushScheduleLocal',jsonStr)
end

