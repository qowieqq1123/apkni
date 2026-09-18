pushGiftConfig={}

function pushGiftConfig.getConfig(id,flag)
if flag==nil then flag=true end
return cfg_limitedtimegiftconfig_get(id,flag)
end

function pushGiftConfig.getAllConfig()
return cfg_limitedtimegiftconfig()
end

function pushGiftConfig.getOpenTime(id)
local cfg=pushGiftConfig.getConfig(id)
return cfg.openconf[2]
end

function pushGiftConfig.getTotalBuyTimes(id)
local cfg=pushGiftConfig.getConfig(id)
return cfg.times
end

function pushGiftConfig.getBuyTimesByCfg(id,idx)
local cfg=pushGiftConfig.getConfig(id)
return cfg.times[idx]
end


function pushGiftConfig.getNextPushTime(id,nowtimes)
local cfg=pushGiftConfig.getConfig(id)
local openconf=cfg.openconf
local nextTime=openconf[3]
if nextTime==nil or nextTime[nowtimes]==nil then return end
return nextTime[nowtimes]+openconf[2]
end

function pushGiftConfig.getHideConfig(id)
local cfg=pushGiftConfig.getConfig(id)
return cfg.openconf[4]
end