






local _MODULENAME="zaoWuGeModel"


def_table(_MODULENAME)
zaoWuGeModel.name=_MODULENAME
zaoWuGeModel.data={}

function zaoWuGeModel:onAppStart()

end


function zaoWuGeModel:onEnterState(isReconnect)
self:initData()
end


function zaoWuGeModel:onProtocolReq()

end


function zaoWuGeModel:onLeaveState(isReconnect)

self.data={}
end



function zaoWuGeModel:initData()

self.data.progressInfo={
suitId=0,
suitNum=0,
startTime=0,
endTime=0,
cancelTime=0,
dzGuid=Int64_0,
}

end




function zaoWuGeModel:setBuildingProgressInfo(startTime,suitId,suitNum,rcnt,dzGuid)
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
self.data.progressInfo.suitId=suitId
self.data.progressInfo.suitNum=suitNum-rcnt
self.data.progressInfo.startTime=startTime+rcnt*singleBuildDuration
self.data.progressInfo.endTime=startTime+suitNum*singleBuildDuration
self.data.progressInfo.dzGuid=dzGuid
self.data.progressInfo.suitId_s=suitId
self.data.progressInfo.suitNum_s=suitNum
self.data.progressInfo.startTime_s=startTime
end

function zaoWuGeModel:setStartBuild(startTime,suitId,suitNum)
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')

self.data.progressInfo.suitId=suitId
self.data.progressInfo.suitNum=suitNum
self.data.progressInfo.startTime=startTime
self.data.progressInfo.endTime=startTime+suitNum*singleBuildDuration
self.data.progressInfo.suitNum_s=suitNum
self.data.progressInfo.startTime_s=startTime
end

function zaoWuGeModel:setCancelBuild()
self.data.progressInfo.suitNum=0
self.data.progressInfo.startTime=0
self.data.progressInfo.endTime=0
self.data.progressInfo.suitNum_s=0
self.data.progressInfo.startTime_s=0
end

function zaoWuGeModel:setRecvBuilding(startTime,rcnt)
if startTime==0 then

self.data.progressInfo.suitNum=0
self.data.progressInfo.startTime=startTime
self.data.progressInfo.endTime=0
self.data.progressInfo.suitNum_s=0
self.data.progressInfo.startTime_s=0
else
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
self.data.progressInfo.suitNum=self.data.progressInfo.suitNum_s-rcnt
self.data.progressInfo.startTime=startTime+singleBuildDuration*rcnt
end
end

function zaoWuGeModel:getBuildingProgressInfo()
return self.data.progressInfo
end

function zaoWuGeModel:getBuildSuitId()
return self.data.progressInfo.suitId
end

function zaoWuGeModel:getBuildingProgress_isWork()
if self.data.progressInfo.startTime then
if self.data.progressInfo.startTime>0 then
return"造物阁 生产中"
end
return"造物阁 空闲"
end
end

function zaoWuGeModel:getBuildCount()
local progressInfo=self.data.progressInfo
if progressInfo.startTime>0 then

local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local curTime=timeHelper.getServerShortTime()
local totalTime=singleBuildDuration*progressInfo.suitNum

if progressInfo.startTime+totalTime>curTime then
local interval=curTime-progressInfo.startTime
local count=Mathf.Floor(interval/singleBuildDuration)
return count
else
return progressInfo.suitNum
end
end
return 0
end

function zaoWuGeModel:setBuildDisciple(dzGuid)
self.data.progressInfo.dzGuid=dzGuid
end

function zaoWuGeModel:getBuildDisciple()
return self.data.progressInfo.dzGuid
end

function zaoWuGeModel:checkisBuildDisciple(dzGuid)
return mathHelper.compareInt64(self.data.progressInfo.dzGuid,dzGuid)
end



function zaoWuGeModel:checkFinishBuild()

local curTime=timeHelper.getServerShortTime()

return curTime>=self.data.progressInfo.endTime
end

function zaoWuGeModel:checkFinishFirstBuild()

local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local curTime=timeHelper.getServerShortTime()

local singleEndTime=self.data.progressInfo.startTime+singleBuildDuration

return curTime>=singleEndTime
end

function zaoWuGeModel:getHudCDProgressPercent()
local curTime=timeHelper.getServerShortTime()
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')

local percent=(curTime-self.data.progressInfo.startTime)/singleBuildDuration

return Mathf.Min(1,percent)
end
