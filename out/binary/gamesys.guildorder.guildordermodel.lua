







guildOrderModel={}

local setupBtnReddot={
[GUILD_ORDER_TYPE.eAutoDuJie]=function()
return guildOrderModel:checkDuJieReddot()
end,
[GUILD_ORDER_TYPE.eAutoShengChan]=function()
return guildOrderModel:checkAutoShengChanReddot()
end,
}

function guildOrderModel:initData(list)
local activeLookup={}
if list then
for i,orderID in ipairs(list)do
activeLookup[orderID]=true
end
end
self.activeLookup=activeLookup
end

function guildOrderModel:activeOrder(orderID)
if self.activeLookup then
self.activeLookup[orderID]=true
guildOrderModel:activeSetup(orderID)
end
end

function guildOrderModel:checkOrderActive(orderID)
if self.activeLookup then
return self.activeLookup[orderID]==true
end
return false
end

function guildOrderModel:getOrderActiveNum(orderID)
local n=0

orderID=orderID or 0
if orderID>0 then
if guildOrderModel:checkOrderActive(orderID)then
n=1
end
else
local cfgs=cfg_guildorderconfig()
for i,cfg in pairs(cfgs)do
local orderID=cfg.id
if self.activeLookup[orderID]==true then
n=n+1
end
end
end

return n
end

function guildOrderModel:clearData()
self.activeLookup=nil
end

function guildOrderModel:checkReddot()
if systemModel.isOpen(SYSTEM_DEFINE.eZongMenOrder)then
if self.activeLookup then
local cfgs=cfg_guildorderconfig()
for i,cfg in pairs(cfgs)do
local orderID=cfg.id
if self.activeLookup[orderID]~=true then
local isFix=guildOrderModel:checkOrderCondEx(cfg.unlock)
local isopen=guildOrderModel:checkSystemCnd(cfg)
if isFix and isopen then
local isEnough=guildOrderModel:checkEnoughActive(cfg.cost)
if isEnough then
return true
end
end
end
end
end
if guildOrderModel:checkDuJieReddot()then
return true
end
if guildOrderModel:checkAutoShengChanReddot()then
return true
end
end
return false
end

function guildOrderModel:checkDuJieReddot()
if systemModel.isOpen(SYSTEM_DEFINE.eZongMenOrder)then
local DuJieMaxLv=userActorSetting.get('guildOrderAutoDuJieMaxLv',5)
local extraUnlock=cfgHelper.get2(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoDuJie,'extraUnlock')
if extraUnlock then
local maxlv=0
for i,unlock in ipairs(extraUnlock)do
local isUnlock=true
for _,cond in ipairs(unlock)do
local flag,cur,max=guildOrderModel:checkCond(cond)
if not flag then
isUnlock=false
break
end
end
if isUnlock and maxlv<i then
maxlv=i
end
end
if maxlv>DuJieMaxLv then
return true,maxlv
end
end
end
return false
end

function guildOrderModel:clearDuJieReddot(maxLv)
userActorSetting.set('guildOrderAutoDuJieMaxLv',maxLv)
userActorSetting.flush()

UIManager:invokeUIMethod('UIGuildOrderWin','rec_reddot',GUILD_ORDER_TYPE.eAutoDuJie)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end


function guildOrderModel:checkAutoShengChanReddot()
if systemModel.isOpen(SYSTEM_DEFINE.eZongMenOrder)then
local _cfg=cfgHelper.get(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoShengChan)
if _cfg and((not guildOrderModel:checkSystemCnd(_cfg))or(not guildOrderModel:checkOrderCondEx(_cfg.unlock)))then
return false
end

local AutoSC=userActorSetting.get('guildOrderAutoShengChanBuild',{})
local AutoSClist={}
if AutoSC and next(AutoSC)then
for k,v in pairs(AutoSC)do
AutoSClist[v]=true
end
end
local buildidlist={2,3,4,7,8,9}
local reddottype={}
for k,v in ipairs(buildidlist)do
local buildNum=zongmenModel:getBuildingCount(v,mapIdType.zhufeng)
if buildNum and buildNum>0 then
if not AutoSClist[v]then
reddottype[v]=true
end
end
end
if reddottype and next(reddottype)then
return true,reddottype
else
return false
end
end
return false
end

function guildOrderModel:clearAutoShengChanReddot()
local buildidlist={2,3,4,7,8,9}
local list={}
for k,v in ipairs(buildidlist)do
local buildNum=zongmenModel:getBuildingCount(v,mapIdType.zhufeng)
if buildNum and buildNum>0 then
list[#list+1]=v
end
end
userActorSetting.set('guildOrderAutoShengChanBuild',list)
userActorSetting.flush()


UIManager:invokeUIMethod('UIGuildOrderWin','rec_reddot',GUILD_ORDER_TYPE.eAutoShengChan)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end

function guildOrderModel.getOrderName(orderID)
return cfgHelper.get2(cfg_guildorderconfig_get,orderID,'name')
end

function guildOrderModel.getIconName(icon)
return FMT.fmt('icon_sjtp_{0}',icon)
end


function guildOrderModel:checkSystemCnd(cfg)
local cfgs=cfg
local systemcnd=cfgs.systemcnd
if systemcnd==nil then
return true
else
local systype=systemcnd[1]
local sysid=systemcnd[2]
local issysluck=true
if systype==1 then
issysluck=systemModel.isOpen(sysid)
elseif systype==2 then
issysluck=false
end
return issysluck
end
end

function guildOrderModel:checkSetupBtnReddot(orderID)
if setupBtnReddot[orderID]then
local func=setupBtnReddot[orderID]
return func()
end
return false
end


function guildOrderModel:setIsStopAutoShengChan(isStop)
self.stopAutoShengChan=isStop
end

function guildOrderModel:getIsStopAutoShengChan()
return self.stopAutoShengChan==true
end