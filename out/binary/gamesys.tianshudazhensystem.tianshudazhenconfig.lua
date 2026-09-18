tianshudazhenConfig={}

function tianshudazhenConfig.getTianshudazhenconfig(level)
return cfg_tianshudazhenconfig_get(level)
end

function tianshudazhenConfig.getFYZResumeInterval()
return cfgHelper.getdef(cfg_tianshudazhenconfig,'auto')
end

function tianshudazhenConfig.getMaxHDZValue(level)
return tianshudazhenConfig.getTianshudazhenconfig(level).shield
end

function tianshudazhenConfig.getTianShuDaZhenBufflist()
return cfgHelper.getdef(cfg_tianshudazhenconfig,'buff')
end

function tianshudazhenConfig.getHuDunValueCost()
return cfgHelper.getdef(cfg_tianshudazhenconfig,'recover')
end

function tianshudazhenConfig.getMaxHDZBuyTimes()
return tianshudazhenConfig.getHuDunValueCost().max
end


function tianshudazhenConfig.getFreeFHZBuffId()
return 1
end


function tianshudazhenConfig.getMaxFHZValue()
local buffid=tianshudazhenConfig.getFreeFHZBuffId()
return cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'max')
end

function tianshudazhenConfig:getMaxFHZFreeTimes()
return cfgHelper.get3(cfg_moneyconfig_get,eMoneyType.mtTSDZConsume,'autoincr',5)
end