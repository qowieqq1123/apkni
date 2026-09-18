







function xingChenHelper.getExpItem(itemid)
return cfgHelper.get(cfg_starsbasicconfig_get,1,"lv_item_exp")[itemid]
end

function xingChenHelper.getMaxLvByItemid(itemid)
local pos=xingChenHelper.getPosType(itemid)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
return#upConfig
end

function xingChenHelper.getExp(pos,lv)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
return upConfig[lv]and upConfig[lv].exp or 0
end

function xingChenHelper.needBorke(pos)
local lv=xingChenBagModel:getOrbitLevel(pos)
local exp=xingChenBagModel:getExp(pos)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
local c=upConfig[lv+1]
if not c then
return false
end
if not c.costs then
return false
end
return c.exp<=exp
end

function xingChenHelper.getItemExp(itemid,itemguid)
if itemsConfig.isXingChen(itemid)then
if itemguid then
local equip=equipsHelper.getEquip(itemguid)
return(xingChenHelper.getStarLevel(equip)+1)*itemsConfig.getConfig(itemid).exp
end
return itemsConfig.getConfig(itemid).exp
else
return xingChenHelper.getExpItem(itemid)or 0
end
end


local calcTotal=function(total,addItem)
return total+xingChenHelper.getItemExp(addItem[3],addItem[1])*addItem[2]
end

function xingChenHelper.getItemListExp(itemList)
local total=0
for i,v in pairs(itemList)do
total=calcTotal(total,v)
end

return total
end



function xingChenHelper.canIncrease(equip,itemList,addItem,warring)
local pos=xingChenHelper.getPosType(equip.itemid)
local lv=xingChenBagModel:getOrbitLevel(pos)
local exp=xingChenBagModel:getExp(pos)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
if not upConfig[lv+1]then
if warring then UIManager.error("星辰轨道已满级")end
return false
end

local nextLv=lv


local needBorke=false

local totalExp=xingChenHelper.getItemListExp(itemList)
local total=totalExp
local leftExp=0
local overExp=0
local lastExp

local c,need
for i=lv+1,#upConfig do
c=upConfig[i]
if i==lv+1 then
need=c.exp-exp
else
need=c.exp
end
totalExp=totalExp-need
lastExp=c.exp
if totalExp<0 then
break
end
if c.costs then
needBorke=true
break
end
if totalExp==0 then
break
end
nextLv=i
end

if totalExp>=0 and needBorke then

overExp=totalExp
return true,nextLv,overExp,leftExp,needBorke,total,false,0
end

leftExp=lastExp+totalExp

local remain=0

if addItem then
local addNum=addItem[2]
remain=addNum
local lvNum
local exp=xingChenHelper.getItemExp(addItem[3],addItem[1])
local aLv=nextLv+1

for i=aLv,#upConfig do
c=upConfig[i]
if i==aLv then need=c.exp-leftExp else need=c.exp end
lvNum=math.ceil(need/exp)
lastExp=c.exp

if remain-lvNum<=0 then
totalExp=totalExp+remain*exp
remain=0
break
end
remain=remain-lvNum
totalExp=totalExp+lvNum*exp

if c.costs then
needBorke=true
break
end
nextLv=i
end
end


if totalExp>0 then
overExp=totalExp
else
leftExp=lastExp+totalExp
end

return true,nextLv,overExp,leftExp,needBorke,total,true,remain
end


function xingChenHelper.getMaxIncreaseExp(equip,itemList,itemid,itemguid)
local pos=xingChenHelper.getPosType(equip.itemid)
local lv=xingChenBagModel:getOrbitLevel(pos)
local exp=xingChenBagModel:getExp(pos)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
if not upConfig[lv+1]then
return 0
end

local nextLv=lv


local needBorke=false


local totalExp=0
for i,v in pairs(itemList)do
if v[3]~=itemid or v[1]~=itemguid then
totalExp=calcTotal(totalExp,v)
end
end

local leftExp=0
local overExp=0
local lastExp

local c,need
for i=lv+1,#upConfig do
c=upConfig[i]
if i==lv+1 then
need=c.exp-exp
else
need=c.exp
end
totalExp=totalExp-need
lastExp=c.exp
if totalExp<=0 then
break
end
if c.costs then
needBorke=true
break
end
nextLv=i
end

if totalExp>0 or needBorke then

overExp=totalExp
return 0
end

leftExp=lastExp+totalExp

local exp=xingChenHelper.getItemExp(itemid,itemguid)

local needExp=0


local aLv=nextLv+1

for i=aLv,#upConfig do
c=upConfig[i]
if i==aLv then need=c.exp-leftExp else need=c.exp end



needExp=needExp+need

if c.costs then
needBorke=true
break
end
nextLv=i
end

return math.ceil(needExp/exp)
end


function xingChenHelper.getIncreaseNeedExp(pos)
local lv=xingChenBagModel:getOrbitLevel(pos)
local exp=xingChenBagModel:getExp(pos)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
if not upConfig[lv+1]then
return 0
end
local need=0

local c
for i=lv+1,#upConfig do
c=upConfig[i]
if i==lv+1 then
need=need+c.exp-exp
else
need=need+c.exp
end
if c.costs then
break
end
end
return need
end

function xingChenHelper.fastSelectIncrease(pos,selectGroup)
local need=xingChenHelper.getIncreaseNeedExp(pos)
if need==0 then
return
end


local slotNum=8

local selectList={}
local guidLookup={}

local costList=xingChenHelper:getIncreaseCostList()
local exp
for i,v in ipairs(costList)do
exp=xingChenHelper.getItemExp(v.itemid,v.itemguid)

local total=exp*v.itemcount

if total>need then
local num=mathHelper.safe_ceil(need/exp)
need=need-num*exp
table.insert(selectList,{v.itemguid,num,v.itemid})
else
need=need-total
table.insert(selectList,{v.itemguid,v.itemcount,v.itemid})
end
slotNum=slotNum-1
guidLookup[tostring(v.itemguid)]=8-slotNum
if need<=0 or slotNum==0 then
return selectList,guidLookup
end
end

local filter={}
filter[ITEM_FILTER_TYPE.eXingChenRongHeChild]={ITEM_FILTER_COMPARE.eNot,{1}}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eXingChen
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{selectGroup}}
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eXingChen,filter,false)
table.sort(bagList,function(a,b)
local aVal=xingChenHelper.sortIncrease(a)
local bVal=xingChenHelper.sortIncrease(b)
return aVal<bVal
end)

for i,v in ipairs(bagList)do
exp=xingChenHelper.getItemExp(v.itemid,v.itemguid)

need=need-exp
table.insert(selectList,{v.itemguid,v.itemcount,v.itemid})

slotNum=slotNum-1
guidLookup[tostring(v.itemguid)]=8-slotNum
if need<=0 or slotNum==0 then
break
end
end

return selectList,guidLookup
end

function xingChenHelper.sortIncrease(item)
local aNum=0

local rare=item.itemData.fin_rare_id~=0 and 1 or 0
aNum=aNum+rare*math.pow(100,4)
local color=itemsConfig.getConfig(item.itemid).color
aNum=aNum+color*math.pow(100,3)
return aNum
end

function xingChenHelper:getIncreaseCostList()
local list={}
local lv_item_exp=cfgHelper.get(cfg_starsbasicconfig_get,1,"lv_item_exp")
for id,v in pairs(lv_item_exp)do
if itemsConfig.isMoney(id)then
list[#list+1]={itemguid=id,itemid=id,itemcount=itemsModel.getCount(id)}
else
local itemlist=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eItem,{[ITEM_FILTER_TYPE.eItemid]=id},false)
list=table.concatTableX(list,itemlist)
end
end
return list
end
