





moneyModel={}

moneyModel.moneyArray={}

local moneyMaxFunc={
[eMoneyType.mtLingPai]=function()
local zm_build_lv=zongmenModel:getBuildingLevel(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eZongMen)
local max=cfgHelper.get4(cfg_guilddadianconfig_get,1,'lp_cnt_limit',zm_build_lv,2)
max=max+moneyModel.getMoneyMaxAdd(eMoneyType.mtLingPai)
return max
end,
[eMoneyType.mtXuKongLing]=function()
local cfg=moneyModel.getMoneyConfig(eMoneyType.mtXuKongLing)
local max=cfg.autoincr and cfg.autoincr[5]or 0
return max
end,
[eMoneyType.mtLunHuiDian]=function()
local cfg=moneyModel.getMoneyConfig(eMoneyType.mtLunHuiDian)
local max=cfg.autoincr and cfg.autoincr[5]or 0
return max
end,
[eMoneyType.mtLingShanBattleTimes1]=function()
local cfg=moneyModel.getMoneyConfig(eMoneyType.mtLingShanBattleTimes1)
local max=cfg.autoincr and cfg.autoincr[5]or 0
return max
end,





[eMoneyType.mtXianLing]=function()
local init_money_max_cnt=cfgHelper.getdef(cfg_tianshudianconfig,'init_money_max_cnt')
local max=init_money_max_cnt
max=tianShuDianController:getXianLingMaxCount()or max
return max
end,
[eMoneyType.mtMoLing]=function()
local cfg=moneyModel.getMoneyConfig(eMoneyType.mtMoLing)
local max=cfg.autoincr and cfg.autoincr[5]or 0
return max
end,
}


local moneyMaxAddFunc={
[eMoneyType.mtLingPai]=function()
local add=gubaoModel:getGBSkil_WorldTokenAddNum()
return add
end,
}


local moneyExtraHandleFuncConfig={
[eMoneyType.mtJingCaiBi]=function(money)
return lundaodahuiModel:getJcbNum()
end,
[eMoneyType.mtXianQi]=function(money)
return money+JuTianYiModel:getMoneyIncrease(1)
end,
[eMoneyType.mtMoQi]=function(money)
return money+JuTianYiModel:getMoneyIncrease(2)
end,
}



function moneyModel.init()
moneyModel.isInit=nil
moneyModel.moneyArray={}

end

function moneyModel.checkInit()
return moneyModel.isInit==true
end



function moneyModel.initMoney(array,typo)
if moneyModel.isInit~=true then
moneyModel.isInit=true
moneyModel.moneyArray={}
end
if typo==1 then
moneyModel.moneyArray={}
end
if array then
for i,v in ipairs(array)do
moneyModel.setMoneyArray(v)
end
end
notifySystem:postNotify(notifyConfig.on_money_init)
end


function moneyModel.setMoneyArray(singleArray)
local moneyArray=moneyModel.moneyArray
moneyArray[singleArray.param_1]=tonumber(tostring(singleArray.param_2))
end

function moneyModel.setMoney(moneyType,value)
moneyModel.moneyArray[moneyType]=tonumber(tostring(value))
end


function moneyModel.getMoney(moneyType)
local money=moneyModel.moneyArray[moneyType]or 0
local moneyExtraHandleFunc=moneyExtraHandleFuncConfig[moneyType]
if moneyExtraHandleFunc then
return moneyExtraHandleFunc(money)
end
return money
end

function moneyModel.getDiffMoney(moneyType,value)
return moneyModel.getMoney(moneyType)-value
end

function moneyModel.getMoneyConfig(moneyType)
return cfgHelper.get1(cfg_moneyconfig_get,moneyType)
end

function moneyModel.getMoneyName(moneyType)
return moneyModel.getMoneyConfig(moneyType).name
end





function moneyModel.getIconName(moneyType)
return moneyModel.getMoneyConfig(moneyType).icon
end

function moneyModel.getIconNameEx(moneyType)
return iconHelper.getMoneyIconName(moneyModel.getIconName(moneyType))
end


function moneyModel.checkEnoughMoney(moneyType,value)
return moneyModel.getDiffMoney(moneyType,value)>=0
end


function moneyModel.checkEnoughMoneyX(list)
for i,v in ipairs(list)do
if not moneyModel.checkEnoughMoney(v[1],v[2])then
return false,v[1]
end
end
return true
end


function moneyModel.checkEnoughMoney2(list)
for i,v in ipairs(list)do
if moneyModel.checkEnoughMoney(v[1],v[2])then
return true,v[1],v[2]
end
end
local d=list[#list]
return false,d[1],d[2]
end

function moneyModel.getMoneyDesc1(moneyType)
local cur=moneyModel.moneyArray[moneyType]or 0
local max=moneyModel.getMoneyMax(moneyType)
if max~=nil then
return FMT.fmt('{0}/{1}',mathHelper.formatNumber(cur),mathHelper.formatNumber(max))
else
return tostring(mathHelper.formatNumber(cur))
end
end

function moneyModel.getMoneyMax(moneyType)
local max=tianShuDianController:getMoneygMaxLimit(moneyType)
if max then
return max
end
local maxfunc=moneyMaxFunc[moneyType]
if maxfunc then
max=maxfunc()
end
return max
end

function moneyModel.getMoneyMaxAdd(moneyType)
local add=nil
local func=moneyMaxAddFunc[moneyType]
if func then
add=func()
end
return add
end




function moneyModel.getMoneyMaxCountByID_Custom(moneyId)
local cfg=tianShuDianController:getCurLevelCfg()
local money_id_map=cfgHelper.getdef(cfg_tianshudianconfig,'money_id_map')
if money_id_map==nil or money_id_map[moneyId]~=1 then
return nil
end

local limit
if cfg and next(cfg)~=nil then
limit=cfg.max_cnt_map and cfg.max_cnt_map[moneyId]or nil

else
local init_money_max_cnt=cfgHelper.getdef(cfg_tianshudianconfig,'init_money_max_cnt')
limit=init_money_max_cnt
end

return limit
end





function moneyModel.checkMoneyOverflow(moneyId,amount)
local limit=moneyModel.getMoneyMaxCountByID_Custom(moneyId)
local currentMoney=moneyModel.getMoney(moneyId)
local sum=mathHelper.int64_to_number(currentMoney+amount)
if limit~=nil and sum>limit then
UIManager.error("不可超出最大存储上限")
return true
end

return false
end