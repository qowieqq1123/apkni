






local _MODULENAME="jiuchongtianjieFirstAscentModel"


def_table(_MODULENAME)
jiuchongtianjieFirstAscentModel.name=_MODULENAME
jiuchongtianjieFirstAscentModel.data={}

function jiuchongtianjieFirstAscentModel:onAppStart()

end


function jiuchongtianjieFirstAscentModel:onEnterState(isReconnect)

end


function jiuchongtianjieFirstAscentModel:onProtocolReq()

end


function jiuchongtianjieFirstAscentModel:onLeaveState(isReconnect)

self.data={}
end



function jiuchongtianjieFirstAscentModel:setInitData(serverId,actorId,name,iconInfo,fsTime,likeCount,likeTotal)
self.data.serverId=serverId
self.data.actorId=actorId
self.data.name=name
self.data.iconInfo=iconInfo
self.data.fsTime=fsTime
self.data.likeCount=likeCount
self.data.likeTotal=likeTotal

self.data.longStamp=timeHelper.convertLongStamp(self.data.fsTime)

local days=cfgHelper.get2(cfg_shouweifeishengtishibaseconfig_get,1,"days")
local zeroTime=timeHelper.getServerZeroStamp(self.data.longStamp)
self.data.endTime=zeroTime+days*86400

local fsDay=timeHelper.getPassDay(self.data.longStamp)
self.data.fsDay=fsDay

local oldTime=userActorSetting.get("autoShowFirstAscentTips",nil)
self.data.canAutoTips=not oldTime or not timeHelper.isTodayStamp(tonumber(oldTime)or 0)
end

function jiuchongtianjieFirstAscentModel:setLikeCount(likeCount,likeTotal)
self.data.likeCount=likeCount
self.data.likeTotal=likeTotal
end


function jiuchongtianjieFirstAscentModel:refreshFSDay()
local fsDay=timeHelper.getPassDay(self.data.longStamp)
self.data.fsDay=fsDay
self.data.likeCount=0

local oldTime=userActorSetting.get("autoShowFirstAscentTips",nil)
self.data.canAutoTips=not oldTime or not timeHelper.isTodayStamp(tonumber(oldTime)or 0)
end

function jiuchongtianjieFirstAscentModel:getData()
return self.data
end

function jiuchongtianjieFirstAscentModel:getFSDay()
return self.data.fsDay
end

function jiuchongtianjieFirstAscentModel:getEndTime()
return self.data.endTime
end


function jiuchongtianjieFirstAscentModel:getIsCanLike()
local dailyLikeCount=cfgHelper.get2(cfg_shouweifeishengtishibaseconfig_get,1,"dailyLikeCount")
local canLickCount=math.max(dailyLikeCount-self.data.likeCount,0)
return dailyLikeCount>self.data.likeCount,canLickCount
end


function jiuchongtianjieFirstAscentModel:getLikeCount()
return self.data.likeCount or 0
end


function jiuchongtianjieFirstAscentModel:getLikeTotal()
return self.data.likeTotal or 0
end


function jiuchongtianjieFirstAscentModel:getIsCanAutoTips()
if not self.data.canAutoTips then
return false
end

if not jiuchongtianjieFirstAscentModel:getCanTipsByDay()then
return false
end

return true
end

function jiuchongtianjieFirstAscentModel:checkReddot()
if not jiuchongtianjieFirstAscentModel:getCanTipsByDay()then
return false
end

local isCanLike,count=jiuchongtianjieFirstAscentModel:getIsCanLike()

return isCanLike
end


function jiuchongtianjieFirstAscentModel:getCanTipsByDay()
if not self.data.fsDay then
return false
end
local days=cfgHelper.get2(cfg_shouweifeishengtishibaseconfig_get,1,"days")
if self.data.fsDay>days then
return false
end
return true
end


function jiuchongtianjieFirstAscentModel:saveAutoShowFirstAscentTips()
if self.data.canAutoTips then
self.data.canAutoTips=false
local stamp=timeHelper.getServerLongTime()
userActorSetting.set('autoShowFirstAscentTips',tostring(stamp))
userActorSetting.flush()
end
end

