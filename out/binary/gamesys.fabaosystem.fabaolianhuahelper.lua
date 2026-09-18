





local _fabaoLianhuaErr=
{
eNotEnoughtMainItem=1,
eNotEnoughMoney=2,
eOverItem=3,
eSystemLock=4,
eNotEnoughLianhuaNum=5,
}
fabaoHelper.lianhuaErr=_fabaoLianhuaErr




function fabaoHelper.getAddLianhuaAttrsListByList(item,itemidlist,left)
if itemidlist==nil or#itemidlist==0 then return end
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local left=left or fabaoHelper.getLianhuaLeftNum(itemguid)
local rangeList={}
if itemConfig then
for _,v in ipairs(itemidlist)do
local itemid
local num=1
if type(v)=='number'then
itemid=v
else
itemid=v[1]
num=v[2]
end
fabaoHelper.getAddLianhuaAttrsListByItem(left,itemid,num,rangeList)
end
end
return rangeList
end

function fabaoHelper.getAddLianhuaAttrsListByItem(left,itemid,num,rangeList)
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local maxNum=left>=num and num or left
if maxNum==0 then return end
for i,v in ipairs(itemConfig.lianhua or{})do
local attrId=v[1]
local range=v[2]
local step=v[3]
if type(range[1])=='table'then
range=range[color]
end
if rangeList[attrId]==nil then rangeList[attrId]={}end
rangeList[attrId][1]=(rangeList[attrId][1]or 0)+maxNum*range[1]*step
rangeList[attrId][2]=(rangeList[attrId][2]or 0)+maxNum*range[2]*step
end
left=left-maxNum
end


function fabaoHelper.getLianhuaMaxNumByCfg(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local maxnum=fabaoConfig.getLianhuaMaxNum(stage)
return maxnum
end

function fabaoHelper.getLianhuaMaxNum(itemguid)
local item=fabaoHelper.getFabao(itemguid)
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(item.itemid)
local stage=itemConfig.stage
local maxnum=fabaoConfig.getLianhuaMaxNum(stage)
local addnum=benMingFaBaoHelper.getAddlhnum(itemguid)
maxnum=maxnum+addnum
return maxnum
end

function fabaoHelper.getLianhuaLeftNum(itemguid)
local item=fabaoHelper.getFabao(itemguid)
local itemData=item.itemData
local lianhuanum=itemData.lianhuanum
local lianhuatimes=itemData.lianhuatimes
local itemConfig=itemsConfig.getConfig(item.itemid)
local stage=itemConfig.stage
local maxNum=fabaoHelper.getLianhuaMaxNum(itemguid)
local totalNum=maxNum+lianhuatimes
local costNum=lianhuanum
local left=totalNum-costNum
return left,totalNum
end

function fabaoHelper.getLianhuaLeftNumByItem(item)
if not item or not item.itemData or not next(item.itemData)then
return
end

local itemData=item.itemData
local itemguid=itemData.itemguid
local lianhuanum=itemData.lianhuanum
local lianhuatimes=itemData.lianhuatimes
local itemConfig=itemsConfig.getConfig(item.itemid)
local stage=itemConfig.stage
local maxNum=fabaoHelper.getLianhuaMaxNum(itemguid)
local totalNum=maxNum+lianhuatimes
local costNum=lianhuanum
local left=totalNum-costNum
return left,totalNum
end

function fabaoHelper.isCanShowLianhuaBtn(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eLianHua)then
if warn then
UIManager.error('系统未解锁，无法炼化')
end
return false,_fabaoLianhuaErr.eSystemLock
end

return true
end

function fabaoHelper.isCanLianhuaNum(itemguid,num,warn)
local left=fabaoHelper.getLianhuaLeftNum(itemguid)
if left<num then
if warn then
UIManager.error('法宝炼化次数不足')
end
return false,_fabaoLianhuaErr.eNotEnoughLianhuaNum,{left,num}
end
return true
end


function fabaoHelper.isCanLianhua(itemguid,itemslist)
if itemslist==nil or#itemslist==0 then
return false,_fabaoLianhuaErr.eNotEnoughtMainItem
end
if not systemModel.isOpen(SYSTEM_DEFINE.eLianHua)then
return false,_fabaoLianhuaErr.eSystemLock
end

local left=fabaoHelper.getLianhuaLeftNum(itemguid)
if left<=0 then
return false,_fabaoLianhuaErr.eOverItem
end

local needMoney=fabaoHelper.getLianhuaCostMoney(itemslist)

for i,v in ipairs(needMoney)do
local moneyType=v[1]
local needVal=v[2]
if not moneyModel.checkEnoughMoney(moneyType,needVal)then
return false,_fabaoLianhuaErr.eNotEnoughMoney,{moneyType,needVal}
end
end
return true
end

function fabaoHelper.getLianhuaCostMoney(itemidlist)
if itemidlist==nil or#itemidlist==0 then return{}end
local needMoney={}

local insert=function(cost)
local temp=table.deepCopy(cost)
for _,v1 in ipairs(needMoney)do
for i2,v2 in ipairs(temp)do
if v1[1]==v2[1]then
v1[2]=v1[2]+v2[2]
table.remove(temp,i2)
break
end
end
end
for i,v in ipairs(temp)do
needMoney[#needMoney+1]=v
end
end
for i,v in ipairs(itemidlist)do
local itemid=v[1]
local num=v[2]
local stage=itemsConfig.getConfig(itemid).stage
local cost=fabaoConfig.getCostByLianhua(stage)
if num>0 then
for i=1,num do
insert(cost)
end
end
end
return needMoney
end