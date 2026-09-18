

lingzhenBagModel=simple_class(baseBagModel)

lingzhenBagModel.bagType=BAG_TYPE.eLingZhen

function lingzhenBagModel:onAppStart()

end

function lingzhenBagModel:onEnterState()
self:init()
end

function lingzhenBagModel:onLeaveState()
self:init()
end


function lingzhenBagModel:checkReddot()
local reddot=false
for i,v in ipairs(self.bag_items)do
local itemConfig=itemsConfig.getConfig(v.itemid)
local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if itemConfig.level>=lv_limit and UIYuFuLingZhenControl:checkZhuanHuanLZReddot()then
reddot=true
break
end
end
return reddot
end