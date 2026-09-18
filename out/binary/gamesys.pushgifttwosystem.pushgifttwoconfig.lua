pushGiftTwoConfig={}

function pushGiftTwoConfig.getConfig(id)
local cfg=cfg_limitedtimegift2config_get(id,false)
if cfg==nil then
cfg=cfg_limitedtimegift2config1_get(id,false)
end
if cfg==nil then
loggerUtil.logErrFMT('没有找到推送礼包配置：{0}',id)
end
return cfg
end

function pushGiftTwoConfig.getAllConfig()
return cfg_limitedtimegift2config()
end

function pushGiftTwoConfig.getAllTimeConfig()
return cfg_limitedtimegift2config1()
end

function pushGiftTwoConfig.getOpenTime(id)
local cfg=pushGiftTwoConfig.getConfig(id)
return cfg.openconf[2]
end

function pushGiftTwoConfig.getTotalBuyTimes(id)
local cfg=pushGiftTwoConfig.getConfig(id)
return cfg.times
end

function pushGiftTwoConfig.getBuyTimesByCfg(id,idx)
local cfg=pushGiftTwoConfig.getConfig(id)
return cfg.times[idx]
end


function pushGiftTwoConfig.getNextPushTime(id,nowtimes)
if pushGiftTwoConfig.isForver(id)then return nil end
local cfg=pushGiftTwoConfig.getConfig(id)
local openconf=cfg.openconf
local nextTime=openconf[3]
if nextTime==nil then return end
local max=nextTime.max
if max and max<=nowtimes then return nil end
local space=nextTime[nowtimes]or
max and nextTime[#nextTime]or nil
if space then
return space+openconf[2]
end
end


function pushGiftTwoConfig.isNotPushAgain(id)
local cfg=pushGiftTwoConfig.getConfig(id)
return cfg.openconf[3]==nil
end

function pushGiftTwoConfig.isForver(id)
return pushGiftTwoConfig.getOpenTime(id)==-1
end

function pushGiftTwoConfig.isResetData(id)
local cfg=pushGiftTwoConfig.getConfig(id)
local openconf=cfg.openconf
return openconf[4]==1
end

function pushGiftTwoConfig.getHideConfig(id)
local cfg=pushGiftTwoConfig.getConfig(id)
return cfg.openconf[5]
end

function pushGiftTwoConfig:getOptionRewards(giftId,lvIdx)
local cfg=pushGiftTwoConfig.getConfig(giftId)
if cfg.rewards then
return cfg.rewards[lvIdx]
end
end

function pushGiftTwoConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
local cfg=pushGiftTwoConfig.getConfig(giftId)
local rewards=cfg.rewards
if rewards==nil or rewards[lvIdx]==nil then return end
return rewards[lvIdx][hoidIdx]
end

function pushGiftTwoConfig:getOptionItemCfg(giftId,lvIdx,hoidIdx,index)
local cfg=pushGiftTwoConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if cfg==nil then return end
return cfg[index]
end