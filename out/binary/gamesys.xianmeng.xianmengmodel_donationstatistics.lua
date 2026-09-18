





function xianmengModel:onEnterState_DonationStatistics(isReconnect)
if isReconnect then return end

self.donationStatisticsActorLogList_Today={}
self.donationStatisticsActorLogList_Yesterday={}
self.donationStatisticsActorLogList_BYesterday={}

xianmengModel:readOpenDonateWinTime()
end

function xianmengModel:onLeaveState_DonationStatistics()

end


function xianmengModel:get_DonationStatistics_Log_DayType_Sort_List(dayType)
local list,tlist

if dayType==1 then
list=self.donationStatisticsActorLogList_Today
elseif dayType==2 then
list=self.donationStatisticsActorLogList_Yesterday
elseif dayType==3 then
list=self.donationStatisticsActorLogList_BYesterday
end

if list~=nil then
tlist={}
for actorIDStr,logData in pairs(list)do
tlist[#tlist+1]=logData
end

table.sort(tlist,function(a,b)
return a.sortWidget>b.sortWidget
end)
return tlist
end
end

function xianmengModel:set_DonationStatistics_Log_List(len,list)
local menberList=xianmengModel:getXMMemberList()

local actorIDStr,leftPostidx
for index,menberData in ipairs(menberList)do
actorIDStr=tostring(menberData.actorid)
leftPostidx=10-(xianmengModel:getXMMemberPost(menberData.actorid)or 10)
self.donationStatisticsActorLogList_Today[actorIDStr]={itemList={},menberData=menberData,sortWidget=leftPostidx,hasItemNum=0}
self.donationStatisticsActorLogList_Yesterday[actorIDStr]={itemList={},menberData=menberData,sortWidget=leftPostidx,hasItemNum=0}
self.donationStatisticsActorLogList_BYesterday[actorIDStr]={itemList={},menberData=menberData,sortWidget=leftPostidx,hasItemNum=0}
end

if len<=0 then return end

local dayFlag,tempItemList,tempItemNum,itemColor,logList
for index,itemLog in ipairs(list)do
actorIDStr=tostring(itemLog.actorId)
dayFlag=self:get_TimeStamp_Flag(itemLog.jxtime)

if dayFlag<4 then
if dayFlag==1 then
logList=self.donationStatisticsActorLogList_Today[actorIDStr]
tempItemList=self.donationStatisticsActorLogList_Today[actorIDStr].itemList
elseif dayFlag==2 then
logList=self.donationStatisticsActorLogList_Yesterday[actorIDStr]
tempItemList=self.donationStatisticsActorLogList_Yesterday[actorIDStr].itemList
elseif dayFlag==3 then
logList=self.donationStatisticsActorLogList_BYesterday[actorIDStr]
tempItemList=self.donationStatisticsActorLogList_BYesterday[actorIDStr].itemList
end

tempItemNum=tempItemList[itemLog.itemId]or 0
tempItemList[itemLog.itemId]=tempItemNum+itemLog.itemNum
itemColor=itemsConfig.getItemColor(itemLog.itemId)
logList.sortWidget=logList.sortWidget+itemColor*10
logList.hasItemNum=logList.hasItemNum+1
end
end
end

function xianmengModel:get_TimeStamp_Flag(stamp)
local todayZeroStamp=timeHelper.getTodayZeroStamp()
local longStamp=timeHelper.convertLongStamp(stamp)


if timeHelper.isTodayStamp(longStamp)then
return 1
end

local toTodayTime=todayZeroStamp-longStamp




if toTodayTime<=86400 then
return 2
end


if toTodayTime<=172800 then
return 3
end


return 4
end


local _openDonateWinTime_key='XianMengOpenDonateWinTime'
function xianmengModel:readOpenDonateWinTime()
self.openDonateWinTime=userActorSetting.get(_openDonateWinTime_key,0)
end

function xianmengModel:writeOpenDonateWinTime()
if not timeHelper.isTodayStamp(self.openDonateWinTime)then
self.openDonateWinTime=timeHelper.getServerLongTime()
userActorSetting.set(_openDonateWinTime_key,self.openDonateWinTime)
userActorSetting.flush()
end
end

function xianmengModel:checkShowOpenInfo()
return not timeHelper.isTodayStamp(self.openDonateWinTime)
end