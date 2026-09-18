






local _MODULENAME="xianyuanShareModel"


def_table(_MODULENAME)
xianyuanShareModel.name=_MODULENAME
xianyuanShareModel.data=nil

function xianyuanShareModel:onAppStart()

end


function xianyuanShareModel:onEnterState(isReconnect)

end


function xianyuanShareModel:onProtocolReq()

end


function xianyuanShareModel:onLeaveState(isReconnect)

self:clearData()
end



function xianyuanShareModel:isInit()
return self.data~=nil
end

function xianyuanShareModel:clearData()
self.data=nil
end

function xianyuanShareModel:setData(daySec,times,flag)
self.data={
daySec=daySec,
times=times,
flag=flag,
}

local lib=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"lib")
local used=mathHelper.cntbit(self.data.flag,0,#lib)
if used>=#lib then
local time=userActorSetting.get("xianyuanShareClose",nil)
if time==nil then
userActorSetting.flushVal("xianyuanShareClose",timeHelper.getServerShortTime())
end
end
end

function xianyuanShareModel:updateTimes(daySec,times)
if self.data then
self.data.daySec=daySec
self.data.times=times
end
end

function xianyuanShareModel:updateFlag(flag)
if self.data then
local delta=flag-self.data.flag
self.data.flag=flag

local lib=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"lib")
local used=mathHelper.cntbit(self.data.flag,0,#lib)
if used>=#lib then
userActorSetting.flushVal("xianyuanShareClose",timeHelper.getServerShortTime())
end
return mathHelper.lShiftNum(delta,#lib-1)+1
end
end

function xianyuanShareModel:getValibTimes()
local lib=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"lib")
local used=mathHelper.cntbit(self.data.flag,0,#lib)
return self.data.times-used
end

function xianyuanShareModel:haveTodayShare()
return timeHelper.isTodayShort(self.data.daySec)
end

function xianyuanShareModel:checkSharedTimes()
if self:isInit()then
local lib=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"lib")
return#lib>self.data.times
end
return false
end

function xianyuanShareModel:isGettedReward(index)
return mathHelper.getBitValue(self.data.flag,index-1)
end

function xianyuanShareModel:isFuncOver()
if not self:isInit()then
return true
end
local lib=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"lib")
local used=mathHelper.cntbit(self.data.flag,0,#lib)
if used>=#lib then
local time=userActorSetting.get("xianyuanShareClose",nil)
if time and not timeHelper.isTodayShort(time)then
return true
end
end
return false
end

function xianyuanShareModel:getReddot()
if not self:isFuncOver()then
local time=userActorSetting.get("xianyuanShareReddot",nil)
return time==nil or type(time)~="number"or not timeHelper.isTodayShort(time)
end
return false
end

function xianyuanShareModel:cancelReddot()
userActorSetting.flushVal("xianyuanShareReddot",timeHelper.getServerShortTime())
end
