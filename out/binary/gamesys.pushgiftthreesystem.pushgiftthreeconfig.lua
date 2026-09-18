pushGiftThreeConfig={}

local _limitOpenServerLookup=nil
function pushGiftThreeConfig.getConfig(id)
local cfg=cfg_limitedtimegift3config_get(id,false)
if cfg==nil then
return cfg_limitedtimegift3config1_get(id,false)
end
if cfg==nil then
loggerUtil.logErrFMT('没有找到推送礼包配置：{0}',id)
end
return cfg
end

function pushGiftThreeConfig.getAllConfig()
return cfg_limitedtimegift3config()
end

function pushGiftThreeConfig.getAllTimeConfig()
return cfg_limitedtimegift3config1()
end

function pushGiftThreeConfig.getOpenTime(id)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.openconf[2]
end

function pushGiftThreeConfig.getTotalBuyTimes(id)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.times
end

function pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.times[idx]
end


function pushGiftThreeConfig.getNextPushTime(id,nowtimes)
if pushGiftThreeConfig.isForver(id)then return nil end
local cfg=pushGiftThreeConfig.getConfig(id)
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


function pushGiftThreeConfig.isNotPushAgain(id)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.openconf[3]==nil
end

function pushGiftThreeConfig.isForver(id)
return pushGiftThreeConfig.getOpenTime(id)==-1
end

function pushGiftThreeConfig.isResetData(id)
local cfg=pushGiftThreeConfig.getConfig(id)
local openconf=cfg.openconf
return openconf[4]==1
end

function pushGiftThreeConfig.getHideConfig(id)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.openconf[5]
end

function pushGiftThreeConfig.getAdvettype(id)
local cfg=pushGiftThreeConfig.getConfig(id)
return cfg.adverttype
end

function pushGiftThreeConfig.getAdvettypeSpace(adverttype)
return cfgHelper.getdef(cfg_limitedtimegift3config,'advert','space',adverttype)or 0
end

function pushGiftThreeConfig.getAdvettypeUnlimit()
return cfgHelper.getdef(cfg_limitedtimegift3config,'advert','recharge')or 0
end


function pushGiftThreeConfig.isCanOpenByPf()
if _limitOpenServerLookup==nil then
_limitOpenServerLookup={}
local pfids=cfgHelper.getdef(cfg_limitedtimegift3config,'advert','pfids')or{}
for i,v in ipairs(pfids)do
_limitOpenServerLookup[v]=true
end
end
local pfid=loginModel:getPfid()
local limitPfid=_limitOpenServerLookup[pfid]==true
return systemConfig.isEnoughReallyConfigOpenCnd(SYSTEM_DEFINE.eLimitedTimeGift3)and limitPfid or false
end

function pushGiftThreeConfig:getOptionRewards(giftId,lvIdx)
local cfg=pushGiftThreeConfig.getConfig(giftId)
if cfg.rewards then
return cfg.rewards[lvIdx]
end
end

function pushGiftThreeConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
local cfg=pushGiftThreeConfig.getConfig(giftId)
local rewards=cfg.rewards
if rewards==nil or rewards[lvIdx]==nil then return end
return rewards[lvIdx][hoidIdx]
end

function pushGiftThreeConfig:getOptionItemCfg(giftId,lvIdx,hoidIdx,index)
local cfg=pushGiftThreeConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if cfg==nil then return end
return cfg[index]
end