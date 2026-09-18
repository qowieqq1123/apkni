







guildOrderCondType={
eDZJingJieNum=1,
eZongMenLevel=2,
eYinXianTaiZhaoMuNum=3,
eFangShiBuyNum=4,
}

local condTypeConfig={
[guildOrderCondType.eDZJingJieNum]={
check=function(cond)
local num=cond[2]
local jjlv=cond[3]
local cur=UIDiscipleModel:getDiscipleJJCount(jjlv)
return cur>=num,cur,num
end,
getDesc=function(cond)
local desc=FMT.fmt('拥有{0}名{1}期弟子',cond[2],UIDiscipleModel:getJJFloorNameEx(cond[3]))
return desc
end
},
[guildOrderCondType.eZongMenLevel]={
check=function(cond)
local num=cond[2]
local cur=zongmenModel:getLevel()
return cur>=num,cur,num
end,
getDesc=function(cond)
local desc=FMT.fmt('宗门等级达到{0}级',cond[2])
return desc
end
},
[guildOrderCondType.eYinXianTaiZhaoMuNum]={
check=function(cond)
local num=cond[2]
local cur=gameUtilityModel:getData_counter(gameCounterType.eYinXianTaiZhaoMuNum)
return cur>=num,cur,num
end,
getDesc=function(cond)
local desc=FMT.fmt('进行{0}次宗门招募',cond[2])
return desc
end
},
[guildOrderCondType.eFangShiBuyNum]={
check=function(cond)
local num=cond[2]
local cur=gameUtilityModel:getData_counter(gameCounterType.eFangShiBuyNum)
return cur>=num,cur,num
end,
getDesc=function(cond)
local desc=FMT.fmt('坊市购买{0}次物品',cond[2])
return desc
end
},
}

function guildOrderModel:initCondTypeLookup()
local lookup={}
local lookup2={}
local cfgs=cfg_guildorderconfig()
local defaultVersionId=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()
for i,cfg in pairs(cfgs)do
local orderID=cfg.id
local isActive=guildOrderModel:checkOrderActive(orderID)
if not isActive then
local unlock2=guildOrderModel:checkOrderPT(cfg.unlock,defaultVersionId,pfid)
for i2,cond in ipairs(unlock2)do
local condType=cond[1]
if lookup[condType]==nil then
lookup[condType]={}
end
table.insert(lookup[condType],orderID)
end
for i3,v in ipairs(cfg.cost)do
local itemid=v[1]
if lookup2[itemid]==nil then
lookup2[itemid]={}
end
table.insert(lookup2[itemid],orderID)
end
end
end
self.condTypeLookup=lookup
self.activeItemLookup=lookup2
end

function guildOrderModel:clearCondChangeLookup()
self.condTypeLookup=nil
self.activeItemLookup=nil
end

function guildOrderModel:disposeCondChange(condType)
if self.condTypeLookup==nil then return end
local condTypes=self.condTypeLookup[condType]
if condTypes then
local list={}
for i,orderID in ipairs(condTypes)do
local isActive=guildOrderModel:checkOrderActive(orderID)
if not isActive then
table.insert(list,orderID)
end
end
if#list then

UIManager:invokeUIMethod('UIGuildOrderWin','onOrdersCondChange',list)

reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end
end
end

function guildOrderModel:disposeItemChange(itemid)
if self.activeItemLookup==nil then return end
local activeItems=self.activeItemLookup[itemid]
if activeItems then
local list={}
for i,orderID in ipairs(activeItems)do
local isActive=guildOrderModel:checkOrderActive(orderID)
if not isActive then
table.insert(list,orderID)
end
end
if#list then

UIManager:invokeUIMethod('UIGuildOrderWin','onOrderCostChange',list)

reddotControl.on_change_catch_type(CATCH_TYPE.eGuildOrderReddotChange)

guildOrderController:refreshBuildHud()
end
end
end

function guildOrderModel:checkOrderCond(orderID,isWarning)
local unlock=cfgHelper.get2(cfg_guildorderconfig_get,orderID,'unlock')
return guildOrderModel:checkOrderCondEx(unlock,isWarning)
end

function guildOrderModel:checkOrderCondEx(unlock,isWarning)
local defaultVersionId=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()
local unlock2=guildOrderModel:checkOrderPT(unlock,defaultVersionId,pfid)
for i,cond in ipairs(unlock2)do
if not guildOrderModel:checkCond(cond)then
if isWarning then
local str=FMT.fmt('需要{0}',guildOrderModel:getCondDesc(cond))
UIManager.error(str)
end
return false
end
end
return true
end

function guildOrderModel:checkCond(cond)
local typo=cond[1]
local obj=condTypeConfig[typo]
return obj.check(cond)
end

function guildOrderModel:getCondDesc(cond)
local typo=cond[1]
local obj=condTypeConfig[typo]
return obj.getDesc(cond)
end

function guildOrderModel:checkEnoughActive(cost)
if cost then
for i,v in ipairs(cost)do
local itemid=v[1]
local itemnum=v[2]
local c
if itemsConfig.isMoney(itemid)then
c=moneyModel.getMoney(itemid)
else
c=bagModel.getItemCountById(itemid)
end
if c<itemnum then
return false,itemid,itemnum
end
end
end
return true
end


function guildOrderModel:checkOrderPT(conds,defaultVersionId,pfid)
local cond={}
if conds[defaultVersionId]then
if conds[defaultVersionId][-1]then
cond=conds[defaultVersionId][-1]
else
if pfid and conds[defaultVersionId][pfid]then
cond=conds[defaultVersionId][pfid]
end
end
end

return cond
end