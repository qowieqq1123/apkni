
androidCallExType['onViVOGameTaskStart']='onViVOGameTaskStartCallBack'
androidCallExType['onViVOGameTaskEnd']='onViVOGameTaskEndCallBack'
androidCallExType['onViVOGameTaskFail']='onViVOGameTaskFailCallBack'


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



function platformSDK_Android_XingJia:setZMLingPaiNotifyTime(updateType,args)
local moneytype=eMoneyType.mtLingPai

local maxNum=moneyModel.getMoneyMax(moneytype)
local curNum=moneyModel.getMoney(moneytype)
local full=curNum>=maxNum
local curStamp=timeHelper.getServerLongTime()
local stamp=curStamp
if full then
local stampTable={}

stamp=stamp+43200
stampTable[#stampTable+1]=stamp*1000

self:setViVoGuaJiNotify('5YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
else
local lefttime=moneyAutoIncreaseModel:getLeastTimeToFull(eMoneyType.mtLingPai)
if lefttime<=0 then
lefttime=43200
end

lefttime=lefttime+10

local stamp=curStamp+lefttime

local stampTable={stamp*1000}






self:setViVoGuaJiNotify('5YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end
end


function platformSDK_Android_XingJia:setChuanSongZhenYouLiNotifyTime(updateType,args)
if not systemModel.isOpen(SYSTEM_DEFINE.eChuanSongZhen)then return end

local curStamp=timeHelper.getServerLongTime()
local empty=chuanSongZhenModel:checkAllEmpty()
if empty then
local stamp=curStamp

stamp=stamp+10
local stampTable={}


stamp=stamp+41410
stampTable[#stampTable+1]=stamp*1000

self:setViVoGuaJiNotify('4YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
else
local stamp=chuanSongZhenModel:getRewardNotifyTime()
if curStamp>=stamp then
stamp=stamp+41400
end

stamp=stamp+10

local stampTable={stamp*1000}





self:setViVoGuaJiNotify('4YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end
end


function platformSDK_Android_XingJia:setTianYuanShouChaoNotifyTime(updateType,args)
if updateType==platformNotifyUpdateType.eUpdate then
local curStamp=timeHelper.getServerShortTime()
local offset=math.abs(curStamp%86400-28800)
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
stampTable[#stampTable+1]=stamp*1000
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
self:setViVoGuaJiNotify('3YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end
end



function platformSDK_Android_XingJia:addListenViVoGuaJi()
androidTool.callFunc('AddViVoGuaJiTask')
end

function platformSDK_Android_XingJia:setViVoGuaJiNotify(taskId,taskType,taskStatus,stampTable)
if taskId==nil then return end
local key=string.format('vovi_%s',taskId)
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
local len=#stampTable
uit.taskStampLen=len
local str=''
for i=1,len do
uit[string.format('taskStamp_%d',i)]=stampTable[i]




end
local jsonStr=jsonHelper.encode(uit)

androidTool.callFunc('PostViVoGuaJiTask',jsonStr)

local stamp=timeHelper.getServerLongTime()
userActorArraySetting.set(typo,key,stamp)
userActorArraySetting.flush(typo,true)
end

function platformSDK_Android_XingJia:onViVOGameTaskStartCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onViVOGameTaskStartCallBack platform_vivo_helper,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local taskId=info.taskId
end
end

function platformSDK_Android_XingJia:onViVOGameTaskEndCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onViVOGameTaskEndCallBack platform_vivo_helper,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local taskId=info.taskId
end
end

function platformSDK_Android_XingJia:onViVOGameTaskFailCallBack(json,jsonStr)
platformSDK.printSDK(string.format('onViVOGameTaskFailCallBack platform_vivo_helper,param=%s',tostring(jsonStr)))
local isSuccess=json.IsSuccess
local params=json.JsonStr
if isSuccess then
local info=cjson.decode(params)
local taskId=info.taskId
end
end


function platformSDK_Android_XingJia:testNotify1()
local stamp=timeHelper.getServerLongTime()+10
local stampTable={stamp*1000}
self:setViVoGuaJiNotify('3YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end

function platformSDK_Android_XingJia:testNotify2()
local stamp=timeHelper.getServerLongTime()+10
local stampTable={stamp*1000}
self:setViVoGuaJiNotify('4YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end

function platformSDK_Android_XingJia:testNotify3()
local stamp=timeHelper.getServerLongTime()+10
local stampTable={stamp*1000}
self:setViVoGuaJiNotify('5YYT4KGMDPSLZ',_task_type.eOffLine,_task_status.eStart,stampTable)
end
