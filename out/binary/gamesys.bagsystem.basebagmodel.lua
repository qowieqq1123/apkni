











baseBagModel={}











function baseBagModel:init()
self.bag_items={}
self.bag_itemID_lookup={}
self.bag_itemSeries_lookup={}
self.bag_itemUseCount_lookup={}
self.cache_temp={}
end


function baseBagModel:getBagItems()
return self.bag_items
end

function baseBagModel:getBagNum()
return#self:getBagItems()
end

function baseBagModel:clearBagItems()
self.bag_items={}
self.bag_itemID_lookup={}
self.bag_itemSeries_lookup={}
end


function baseBagModel:getBagItemsByFilter(filter,sortFunc,useCache)
local flag=false
if filter then
for _,_ in pairs(filter)do
flag=true
break
end
end
local temp

if not flag then
if useCache then
table.clear(self.cache_temp)
temp=self.cache_temp
else
temp={}
end
local items=self:getBagItems()
if items==nil or#items==0 then return temp end
for _,v in ipairs(items)do
temp[#temp+1]=v
end
if sortFunc~=false then
self:sortBagItems(temp)
end
return temp
end

temp=itemsFilterHelper.filterItems(self.bag_items,filter,useCache)
if#temp>1 and sortFunc~=false then
if sortFunc then
sortFunc(temp)
else
self:sortBagItems(temp)
end
end
return temp
end

function baseBagModel:hasBagItems(filter)
return itemsFilterHelper.hasFilterItem(self.bag_items,filter)
end

function baseBagModel:getBagItemsCnt(filter)
if filter==nil then
return#self:getBagItems()
end
local temp=itemsFilterHelper.filterItems(self.bag_items,filter,true)
return#temp
end

function baseBagModel:sortBagItems(items)

end


function baseBagModel:getItemWithCheckFuncByItemID(itemid,checkFunc)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict then
for i,item in pairs(itemDict)do
if checkFunc(item)then
return item,item.itemguid
end
end
end
end



function baseBagModel:getItemByItemID(itemid)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict then
local handle,item=next(itemDict)
if item~=nil then
return item,item.itemguid
end
end
end



function baseBagModel:getAllItemByItemID(itemid)
local itemDict=self.bag_itemID_lookup[itemid]
return itemDict or{}
end



function baseBagModel:getItemListWithCheckFuncByItemID(itemid,checkFunc,tempList)
local itemDict=self.bag_itemID_lookup[itemid]
local itemList=tempList and table.clear(tempList)or{}
if itemDict==nil then
return itemList
end
for i,v in pairs(itemDict)do
local isCheck=true
if checkFunc then
isCheck=checkFunc(v)
end

if isCheck then
itemList[#itemList+1]=v
end
end
return itemList
end



function baseBagModel:getItemCountByItemID(itemid)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict==nil then
return 0,0
end
local count=0
local bang=0
for i,v in pairs(itemDict)do
count=count+v.itemcount
if v.itemflag~=0 then
bang=bang+v.itemcount
end
end
return count,bang
end



function baseBagModel:getNotExpireItemCountByItemID(itemid)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict==nil then
return 0,0
end
local count=0
local allCount=0
for i,v in pairs(itemDict)do
allCount=allCount+v.itemcount
if not bagUseControl.isItemExpire(v.itemguid)then
count=count+v.itemcount
end
end
return count,allCount
end


function baseBagModel:getItemCountWithCheckFuncByItemID(itemid,checkFunc)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict==nil then
return 0,0
end
local count=0
local bang=0
for i,v in pairs(itemDict)do
local isCheck=true
if checkFunc then
isCheck=checkFunc(v)
end

if isCheck then
count=count+v.itemcount
if v.itemflag~=0 then
bang=bang+v.itemcount
end
end
end
return count,bang
end


function baseBagModel:getNearestExpireTimeById(itemid)
local itemDict=self.bag_itemID_lookup[itemid]
if itemDict==nil then
return-1
end
local minNotExpireTime
local maxExpiredTime
local notExpireItemGuid
local expiredItemGuid
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(itemDict)do
local itemTime=bagUseControl.getItemExpireTime(v.itemguid)
if itemTime>0 then

local lerp=itemTime-nowTime
if lerp>0 then

if not minNotExpireTime or itemTime<minNotExpireTime then
minNotExpireTime=itemTime
notExpireItemGuid=v.itemguid
end
else

if not maxExpiredTime or itemTime>maxExpiredTime then
maxExpiredTime=itemTime
expiredItemGuid=v.itemguid
end
end
end
end

local nearestExpireTime=minNotExpireTime or maxExpiredTime or-1
local nearestExpireItemGuid=notExpireItemGuid or expiredItemGuid or nil
return nearestExpireTime,nearestExpireItemGuid
end



function baseBagModel:getItem(itemguid)
local guidStr=tostring(itemguid)
return self.bag_itemSeries_lookup[guidStr]
end

function baseBagModel:getItemByStr(guidStr)
return self.bag_itemSeries_lookup[guidStr]
end




function baseBagModel:addItemList(datalist,isInit)
for i,v in ipairs(datalist)do
self:onAddItem(v,isInit)
end
end

function baseBagModel:addItem(data,isInit)
self:onAddItem(data,isInit)
end


function baseBagModel:onAddItem(data,isInit)
self:handleItem(data)
local itemguid=data.guidStr
local guidStr=tostring(itemguid)
local itemid=data.itemid
if self.bag_itemSeries_lookup[guidStr]then
loggerUtil.logErrFMT('道具唯一标记不唯一，背包内已有此唯一guid:{0}',guidStr)
return
end
self.bag_itemSeries_lookup[guidStr]=data

self.bag_items[#self.bag_items+1]=data

if self.bag_itemID_lookup[itemid]==nil then self.bag_itemID_lookup[itemid]={}end

local lookup=self.bag_itemID_lookup[itemid]
lookup[#lookup+1]=data
end




function baseBagModel:deleleItemlist(len,strlookup)
local lookup={}
local lookupnum={}
if len<100 then
for i=#self.bag_items,1,-1 do
local v=self.bag_items[i]
if strlookup[v.guidStr]then
local guidStr=v.guidStr
local itemid=v.itemid

_remove(self.bag_items,i)

if lookup[itemid]==nil then lookup[itemid]={}end
lookup[itemid][guidStr]=true

local num=lookupnum[itemid]or 0
lookupnum[itemid]=num+1

self:onDeleteItem(v)
end
end
else
local temp={}
for i,v in ipairs(self.bag_items)do
if strlookup[v.guidStr]==nil then
temp[#temp+1]=v
else
local itemid=v.itemid
local guidStr=v.guidStr

if lookup[itemid]==nil then lookup[itemid]={}end
lookup[itemid][guidStr]=true

local num=lookupnum[itemid]or 0
lookupnum[itemid]=num+1

self:onDeleteItem(v)
end
end
self.bag_items=temp
end


for itemid,lookup__ in pairs(lookup)do
local list=self.bag_itemID_lookup[itemid]
local num=lookupnum[itemid]

if num<100 then
for i=#list,1,-1 do
if lookup__[list[i].guidStr]then
_remove(list,i)
end
end
else
local temp={}
for _,v in ipairs(list)do
if lookup__[v.guidStr]==nil then
temp[#temp+1]=v
end
end
self.bag_itemID_lookup[itemid]=temp
end
end
end


function baseBagModel:onDeleteItem(v)
self.bag_itemSeries_lookup[v.guidStr]=nil
end


function baseBagModel:deleteItem(guidStr)
local item=self.bag_itemSeries_lookup[guidStr]
if item==nil then return end

self:onDeleteItem(item)

local itemid=nil
for i,v in ipairs(self.bag_items)do
if v.guidStr==guidStr then
_remove(self.bag_items,i)
itemid=v.itemid
break
end
end

if itemid then
local list=self.bag_itemID_lookup[itemid]
for i,v in ipairs(list)do
if v.guidStr==guidStr then
_remove(list,i)
break
end
end
end
end


function baseBagModel:changeItemList(datalookup)
for i,v in ipairs(self.bag_items)do
local guidStr=v.guidStr
if datalookup[guidStr]then

local data=datalookup[guidStr]

local itemid=data.itemid
self.bag_items[i]=data

local list=self.bag_itemID_lookup[itemid]
for i,v in ipairs(list)do
if v.guidStr==guidStr then
list[i]=data
break
end
end

self:onChangeItem(data)
datalookup[guidStr]=nil
if next(datalookup)==nil then return end
end
end

for _,data in pairs(datalookup)do
self:onAddItem(data,false)
end
end

function baseBagModel:onChangeItem(data)
local guidStr=data.guidStr
self.bag_itemSeries_lookup[guidStr]=data
end

function baseBagModel:changeItem(data)
local guidStr=data.guidStr
local item=self.bag_itemSeries_lookup[guidStr]
if item==nil then return end

self:onChangeItem(data)

for i,v in ipairs(self.bag_items)do
if v.guidStr==guidStr then
self.bag_items[i]=data
break
end
end

local itemid=data.itemid
local list=self.bag_itemID_lookup[itemid]
for i,v in ipairs(list)do
if v.guidStr==guidStr then
list[i]=data
break
end
end
end



function baseBagModel:handleItem(item)

end



function baseBagModel:isHaveItem(itemguid)
local handle=tostring(itemguid)
if self.bag_itemSeries_lookup[handle]then
return true
end
return false
end


function baseBagModel:canUseNow(item)
return true
end
