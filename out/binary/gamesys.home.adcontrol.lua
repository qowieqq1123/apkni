

adControl=gameState.addListener({})

function adControl:onAppStart()


end

function adControl:onEnterState(...)
self.haveCount=0
self.usedCount=0
self.beginCountdownTime=0
self.shopUsedCount=0
self.canRefresh=false



local cfg=cfgHelper.get1(cfg_globalconfig_get,1)
self.maxcount=cfg.advert_conf[1][1]
self.maxused=cfg.advert_conf[1][2]
self.speedUpTime=cfg.advert_conf[1][3]
self.countdown=cfg.advert_conf[1][4]
self.freshTime=0

timeEventController.addNormalTimerHandler(1,'adControl',self)
end

function adControl:onLeaveState(...)
timeEventController.removeNormalTimerHandler(1,'adControl')
end

function adControl:onNormalUpdate(delay)
if self.canRefresh then
local stime=gameUtilityModel.getServerShortTime()
if stime>=self.freshTime then
self.canRefresh=false

end
end
end


















function adControl.recv_254_22(adtype,arg1,arg2)


end



function adControl:setAdData(have,used,time,shopCount)
self.haveCount=have
self.usedCount=used
self.beginCountdownTime=time
self.shopUsedCount=shopCount

self:reCountTime()

notifySystem:postNotify(notifyConfig.adRefresh)
end

function adControl:addAdCount()
self.haveCount=self.haveCount-1
self.usedCount=self.usedCount+1

self:reCountTime()
end

function adControl:reCountTime()
self.freshTime=self.beginCountdownTime+self.countdown
local stime=gameUtilityModel.getServerShortTime()

if stime>=self.freshTime then
self.freshTime=stime+10
end
self.canRefresh=self.freshTime>0 and self.haveCount<self.maxcount and self.usedCount<self.maxused
end


function adControl:getRefreshTime()
return self.freshTime
end


function adControl:getHaveAdCount()
return self.haveCount or 0
end


function adControl:getUsedAdCount()
return self.usedCount or 0
end


function adControl:getBeginCDTime()
return self.beginCountdownTime
end


function adControl:isFullWatch()
return self.usedCount>=self.maxused
end


function adControl:getSpeedUpTime()
return self.speedUpTime
end