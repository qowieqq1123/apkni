





local soldierHurtIdx=
{
[xjSoldierHurtType.eHealthy]=1,
[xjSoldierHurtType.eSlightInjury]=2,
[xjSoldierHurtType.eSeriousInjury]=3,
}

function xianjieModel:getSoldierHurtNum(id,hurtType)
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,id,"money")
return moneyModel.getMoney(cfg[soldierHurtIdx[hurtType]])
end


function xianjieModel:getSoldierHurtList(hurtType,checkZero)
local list={}
local cfg=cfg_fairylandsoldierconfig()
local num
for i,c in pairs(cfg)do
num=moneyModel.getMoney(c.money[soldierHurtIdx[hurtType]])
if not checkZero or num>0 then
list[c.id]=num
end
end
return list
end

function xianjieModel:getSoldierAllHurtNum(hurtType)
local num=0
local cfg=cfg_fairylandsoldierconfig()
for i,c in pairs(cfg)do
num=num+moneyModel.getMoney(c.money[soldierHurtIdx[hurtType]])
end
return num
end

function xianjieModel:getSoldierNum(id)
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,id,"money")
local num=0
for i,v in ipairs(cfg)do
num=num+moneyModel.getMoney(v)
end
return num
end

function xianjieModel:getSoldierAttr(id,attrType)
return cfgHelper.get(cfg_jzconfig_get,id,attrType)
end

function xianjieModel:getTotalSoldierCount()
local totalCount=0

for index,hurtType in ipairs(soldierHurtIdx)do
if hurtType~=xjSoldierHurtType.eSlightInjury then
totalCount=totalCount+xianjieModel:getSoldierAllHurtNum(hurtType)
end
end

return totalCount
end

function xianjieModel:getNeedTreatSoldierCount()

local totalCount=YuLingZhaiModel:getSoldierAllHurtNum()
totalCount=totalCount+xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)

return totalCount
end

function xianjieModel:getTotalSoldierList()
local list={}
local cfg=cfg_fairylandsoldierconfig()
local num
for i,c in pairs(cfg)do
if list[c.id]==nil then
list[c.id]={}
list[c.id].totalCount=0
end
for index,stateSoldier in ipairs(c.money)do
if index~=xjSoldierHurtType.eSlightInjury then
num=moneyModel.getMoney(stateSoldier)
list[c.id][index]=num
list[c.id].totalCount=list[c.id].totalCount+num
end
end
end
return list
end

function xianjieModel:getWaiPaiSoldierList()
local soldierList={}
local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
for i,teamHandle in ipairs(teamHandleList)do
if teamHandle.moneylistlen and teamHandle.moneylistlen>0 then
for _,money in ipairs(teamHandle.moneyList)do
soldierList[money.param_1]=(soldierList[money.param_1]or 0)+money.param_2
end
end
end
return soldierList
end
