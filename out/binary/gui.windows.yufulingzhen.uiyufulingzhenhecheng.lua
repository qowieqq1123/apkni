





function UIYuFuLingZhenControl:getEquipHeChengSlot(yufuguid)

local canMakeIndex={}
local gloalUsedItem={}
local needItemList={}

local lzdata=UIYuFuLingZhenControl:getLingZhenData(yufuguid)
if lzdata then
if lzdata.kongList then
for i,v in pairs(lzdata.kongList)do
local itemId=v.itemId

local nextItem=UIYuFuLingZhenControl:getItemIdByLevel(itemId,itemsConfig.getConfig(itemId).level+1)
if nextItem then
local isSuccess,useItemListIndex,useSelfCost,needItemList_lookup=UIYuFuLingZhenControl:getItemHeChengSlot2(itemId,gloalUsedItem)

if isSuccess then
local usedList={}
for i,v in pairs(useItemListIndex)do
table.insert(usedList,{i,v})
end
canMakeIndex[i]={i,nextItem,#usedList,usedList}
else
for i,v in pairs(useSelfCost)do
gloalUsedItem[i]=(gloalUsedItem[i]or 0)-v
end

if needItemList_lookup and next(needItemList_lookup)then
for i,v in pairs(needItemList_lookup)do
local needItemId=i
local hasCount=itemsModel.getCount(needItemId)
if hasCount<v then
local itemCount=v-hasCount
local itemCfg=itemsConfig.getConfig(needItemId)
local level=itemCfg.level
local isLingZhen=itemsConfig.isLingZhen(needItemId)
needItemList[#needItemList+1]={
itemId=needItemId,
itemCount=itemCount,
level=level,
isLingZhen=isLingZhen,
}
end
end
end
end
end


end
end
end

return canMakeIndex,needItemList

end



function UIYuFuLingZhenControl:getItemHeChengSlot(itemId,usedItem)
local cfg=itemsConfig.getConfig(itemId)
local type1=cfg.type1
local cost=cfg.compound

local useItemListIndex={}

local useSelfCost={}

local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hecheng2')

local costCount=cost~=nil and itemsModel.getCount(cost[1])-(usedItem[cost[1]]or 0)or 1

if cost==nil or costCount>=cost[2]then

if type1==6 then
local mats=cfg.hcMaterials
local haveMat=false
if mats then
local itemNum=itemsModel.getCount(mats[1][1])-(usedItem[mats[1][1]]or 0)
if itemNum>=mats[1][2]then
usedItem[mats[1][1]]=(usedItem[mats[1][1]]or 0)+mats[1][2]

useSelfCost[mats[1][1]]=(useSelfCost[mats[1][1]]or 0)+mats[1][2]

haveMat=true

return true,useItemListIndex,useSelfCost
end
end
else
local count=itemsModel.getCount(itemId)
local check2=cfg.level>=hcdata[1]



if check2 then
if count-(usedItem[itemId]or 0)>=1 then
local mats=cfg.hcMaterials
local itemNum=itemsModel.getCount(mats[1][1])-(usedItem[mats[1][1]]or 0)
if itemNum>=mats[1][2]then
local item,itemguid=bagControl.invokeFuncByItemId(itemId,'getItemByItemID',itemId)
usedItem[itemId]=(usedItem[itemId]or 0)+1

useItemListIndex[itemguid]=(usedItem[itemguid]or 0)+1

useSelfCost[itemId]=(useSelfCost[itemId]or 0)+1

if cost then
usedItem[cost[1]]=(usedItem[cost[1]]or 0)+cost[2]

useSelfCost[cost[1]]=(useSelfCost[cost[1]]or 0)+cost[2]
end

return true,useItemListIndex,useSelfCost
end
else

local isSuccess=true
local preUseItem={}
local preAllCost={}
local preItem=UIYuFuLingZhenControl:getItemIdByLevel(itemId,cfg.level-1)
if preItem then
local need=(1-(count-(usedItem[itemId]or 0)))
local check2Pre=cfg.level-1>=hcdata[1]
local needAdd=check2Pre and 2 or 3

for i=1,need*needAdd do
local isSuccessPre,preUseItemListIndex,preCost=UIYuFuLingZhenControl:getItemHeChengSlot(preItem,usedItem)
if isSuccessPre then
for k,v in pairs(preUseItemListIndex)do
preUseItem[k]=(preUseItem[k]or 0)+v
end
for k,v in pairs(preCost)do
preAllCost[k]=(preAllCost[k]or 0)+v
end
end
isSuccess=isSuccess and isSuccessPre
end
end
if isSuccess then
for k,v in pairs(preAllCost)do
useSelfCost[k]=(useSelfCost[k]or 0)+v
end
for k,v in pairs(preUseItem)do
useItemListIndex[k]=(useItemListIndex[k]or 0)+v
end
return true,useItemListIndex,useSelfCost
else
for k,v in pairs(preAllCost)do
usedItem[k]=(usedItem[k]or 0)-v
end
return false
end
end
else

if count-(usedItem[itemId]or 0)>=2 then
local item,itemguid=bagControl.invokeFuncByItemId(itemId,'getItemByItemID',itemId)
if item then
usedItem[itemId]=(usedItem[itemId]or 0)+2

useItemListIndex[itemguid]=(usedItem[itemguid]or 0)+2

useSelfCost[itemId]=(useSelfCost[itemId]or 0)+2

if cost then
usedItem[cost[1]]=(usedItem[cost[1]]or 0)+cost[2]
useSelfCost[cost[1]]=(useSelfCost[cost[1]]or 0)+cost[2]
end

return true,useItemListIndex,useSelfCost
end
else


local isSuccess=true
local preAllCost={}
local preUseItem={}
local preItem=UIYuFuLingZhenControl:getItemIdByLevel(itemId,cfg.level-1)
if preItem then
local need=(2-(count-(usedItem[itemId]or 0)))
local check2Pre=cfg.level-1>=hcdata[1]
local needAdd=check2Pre and 2 or 3
for i=1,need*needAdd do
local isSuccessPre,preUseItemListIndex,preCost=UIYuFuLingZhenControl:getItemHeChengSlot(preItem,usedItem)
if isSuccessPre then
for i,v in pairs(preUseItemListIndex)do
preUseItem[i]=(preUseItem[i]or 0)+v
end
for k,v in pairs(preCost)do
preAllCost[k]=(preAllCost[k]or 0)+v
end
end
isSuccess=isSuccess and isSuccessPre


end

else
return false
end
if isSuccess then
for k,v in pairs(preAllCost)do
useSelfCost[k]=(useSelfCost[k]or 0)+v
end
for k,v in pairs(preUseItem)do
useItemListIndex[k]=(useItemListIndex[k]or 0)+v
end
return true,useItemListIndex,useSelfCost
else
for k,v in pairs(preAllCost)do
usedItem[k]=(usedItem[k]or 0)-v
end
return false
end
end
end

return false
end
end
end


function UIYuFuLingZhenControl:getItemHeChengSlot2(itemId,usedItem)
local cfg=itemsConfig.getConfig(itemId)
local type1=cfg.type1
local cost=cfg.compound

local useItemListIndex={}

local useSelfCost={}
local needItemList_lookup={}



local costCount=cost~=nil and itemsModel.getCount(cost[1])-(usedItem[cost[1]]or 0)or 1

if cost==nil or costCount>=cost[2]then

if type1==6 then
local mats=cfg.hcMaterials
local haveMat=false
if mats then
local itemNum=itemsModel.getCount(mats[1][1])-(usedItem[mats[1][1]]or 0)
if itemNum>=mats[1][2]then
usedItem[mats[1][1]]=(usedItem[mats[1][1]]or 0)+mats[1][2]

useSelfCost[mats[1][1]]=(useSelfCost[mats[1][1]]or 0)+mats[1][2]

haveMat=true
if cost then
useSelfCost[cost[1]]=(useSelfCost[cost[1]]or 0)+cost[2]
usedItem[cost[1]]=(usedItem[cost[1]]or 0)+cost[2]
end
return true,useItemListIndex,useSelfCost,needItemList_lookup
else

needItemList_lookup[mats[1][1]]=(needItemList_lookup[mats[1][1]]or 0)+(mats[1][2])
end
end
else
local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hcItems')
local level=itemsConfig.getConfig(itemId).level
local need=hcdata[level+1]

if need then
local needVal=need[1]-hcdata[level][1]
local needCost=need[2]-hcdata[level][2]
local costCountLv=cost~=nil and itemsModel.getCount(cost[1])-(usedItem[cost[1]]or 0)or 0

local totalVal=0
local totalCost=needCost

for i=1,level do
local lv=level-i+1
local lvVal=hcdata[lv][1]

local needCostLv=hcdata[lv][2]

local itemIdLv=UIYuFuLingZhenControl:getItemIdByLevel(itemId,lv)
local itemLvCount=itemsModel.getCount(itemIdLv)-(usedItem[itemIdLv]or 0)



if(totalVal+math.ceil(itemLvCount*lvVal))>=needVal then
local item,itemguid=bagControl.invokeFuncByItemId(itemIdLv,'getItemByItemID',itemIdLv)
if itemguid then
local nNum=(needVal-totalVal)/lvVal
totalVal=totalVal+math.ceil(nNum*lvVal)

useItemListIndex[itemguid]=(usedItem[itemguid]or 0)+nNum
usedItem[itemIdLv]=(usedItem[itemIdLv]or 0)+nNum
useSelfCost[itemIdLv]=(useSelfCost[itemIdLv]or 0)+nNum





totalCost=totalCost-needCostLv*nNum



end

if totalCost<=costCountLv then
usedItem[cost[1]]=(usedItem[cost[1]]or 0)+totalCost
return true,useItemListIndex,useSelfCost,needItemList_lookup
end


else
local item,itemguid=bagControl.invokeFuncByItemId(itemIdLv,'getItemByItemID',itemIdLv)
local needCount=math.ceil((needVal-totalVal)/lvVal)
if itemguid then
totalVal=totalVal+math.ceil(itemLvCount*lvVal)
usedItem[itemIdLv]=(usedItem[itemIdLv]or 0)+itemLvCount
useItemListIndex[itemguid]=(useItemListIndex[itemguid]or 0)+itemLvCount
useSelfCost[itemIdLv]=(useSelfCost[itemIdLv]or 0)+itemLvCount

totalCost=totalCost-needCostLv*itemLvCount
end
needItemList_lookup[itemIdLv]=(needItemList_lookup[itemIdLv]or 0)+needCount
end
end

end


end
end
return false,{},useSelfCost,needItemList_lookup
end


function UIYuFuLingZhenControl:getCombineMaterialItem(itemId,currMaterials)
local items=lingzhenBagModel:getBagItems()
for i,v in ipairs(items)do
if v.itemid==itemId and not currMaterials[tostring(v.itemguid)]then
return v
end
end
return nil
end

function UIYuFuLingZhenControl:getCombineMaterialItemNum(itemId,currMaterials,num)
local cur=0
local series={}
local items=lingzhenBagModel:getBagItems()
for i,v in ipairs(items)do
if cur>=num then
return series
end
if v.itemid==itemId and not currMaterials[tostring(v.itemguid)]then
table.insert(series,v.itemguid)
cur=cur+1
end
end
return nil
end

function UIYuFuLingZhenControl:getEquipHeChengSlotByKongIndex(yufuguid,kongIndex)
local canMakeIndex={}
local gloalUsedItem={}
local needItemList={}
local isMaxLevel=false
local lzdata=UIYuFuLingZhenControl:getLingZhenData(yufuguid)
if lzdata then
if lzdata.kongList and lzdata.kongList[kongIndex]then
local kongData=lzdata.kongList[kongIndex]
local itemId=kongData.itemId

local itemCfg=itemsConfig.getConfig(itemId)
local level=itemCfg.level
local cfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"openLevel")
local maxLevel=cfg or 15
if level>=maxLevel then
isMaxLevel=true
return canMakeIndex,needItemList,isMaxLevel
end

local nextItem=UIYuFuLingZhenControl:getItemIdByLevel(itemId,level+1)
if nextItem then
local isSuccess,useItemListIndex,useSelfCost,needItemList_lookup=UIYuFuLingZhenControl:getItemHeChengSlot2(itemId,gloalUsedItem)

if isSuccess then
local usedList={}
for i,v in pairs(useItemListIndex)do
table.insert(usedList,{i,v})
end
canMakeIndex[kongIndex]={kongIndex,nextItem,#usedList,usedList}
else
for i,v in pairs(useSelfCost)do
gloalUsedItem[i]=(gloalUsedItem[i]or 0)-v
end
if needItemList_lookup and next(needItemList_lookup)then
for i,v in pairs(needItemList_lookup)do
local needItemId=i
local hasCount=itemsModel.getCount(needItemId)
if hasCount<v then
local itemCount=v-hasCount
local itemCfg=itemsConfig.getConfig(needItemId)
local level=itemCfg.level
local isLingZhen=itemsConfig.isLingZhen(needItemId)
needItemList[#needItemList+1]={
itemId=needItemId,
itemCount=itemCount,
level=level,
isLingZhen=isLingZhen,
}
end
end
end
end
end
end
end
return canMakeIndex,needItemList,isMaxLevel
end

function UIYuFuLingZhenControl.req_2_108(yufuGuid,kongIndex,isShowGain)
local canMakeIndex
local needItemList
local isMaxLevel
if kongIndex then
canMakeIndex,needItemList,isMaxLevel=UIYuFuLingZhenControl:getEquipHeChengSlotByKongIndex(yufuGuid,kongIndex)
else
canMakeIndex,needItemList=UIYuFuLingZhenControl:getEquipHeChengSlot(yufuGuid)
end

if next(canMakeIndex)then

local now=timeHelper.getServerShortTime()

if UIYuFuLingZhenControl.isSend_2_108 and now-UIYuFuLingZhenControl.isSend_2_108<3 then
return
end

local list={}
for i,v in pairs(canMakeIndex)do
table.insert(list,v)
end
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(yufuGuid)or int64.zero
socketManager:send_2_108(dzId,yufuGuid,#list,list)

UIYuFuLingZhenControl.isSend_2_108=now
return true
else
if isMaxLevel then
UIManager.error("灵阵已满级")
return false
end

if isShowGain then
local gainItemId
if next(needItemList)then
table.sort(needItemList,function(a,b)
local isLingZhenFlag_a=a.isLingZhen and 1 or 0
local isLingZhenFlag_b=b.isLingZhen and 1 or 0
if isLingZhenFlag_a==isLingZhenFlag_b then
if a.level==b.level then
return a.itemId<b.itemId
else
return a.level>b.level
end
else
return isLingZhenFlag_a>isLingZhenFlag_b
end
end)
gainItemId=needItemList[1].itemId
else
gainItemId=eMoneyType.mtZhenShi
end
if gainItemId then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(gainItemId)))
gainControl:showGainWin(gainItemId)
end

return false
else
UIManager.error("当前可合成的灵阵数量不足或阵石数量不足")
return false
end

end
end


function UIYuFuLingZhenControl.recv_2_108(dzguid,yfguid,len,kongList,lingzhenInfo)

local idstr=tostring(yfguid)
local indexList={}
if idstr~='0'then
local lzdata=UIYuFuLingZhenControl:getDiziLingData(yfguid)


if lzdata then
local newKongList=lingzhenInfo.kongList
local equipData=UIYuFuLingZhenControl:getLingZhenData(yfguid)
UIYuFuLingZhenControl:calcLingZhenEquipedByKongList(equipData.kongList,false)
if lzdata.kongList then
for i,v in ipairs(lzdata.kongList)do
for ii,vv in ipairs(newKongList)do
if vv.index==v.index then
if v.itemId~=vv.itemId then
indexList[v.index]=true


end
v.itemId=vv.itemId

end
end

end
else
lzdata.kongList=lingzhenInfo.kongList
end
local equipData=UIYuFuLingZhenControl:getLingZhenData(yfguid)
UIYuFuLingZhenControl:calcLingZhenEquipedByKongList(equipData.kongList,true)



end
end
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')
UIManager:callWindowFunc('UIYFLZCombineWin','refresh')

UIManager:callWindowFunc('UIYuFuLingZhenWin','playSlotEffect',indexList)
equipsModel.setAllEquipedAttrsDirty(dzguid)
local equipData=UIYuFuLingZhenControl:getLingZhenData(yfguid)
if equipData then
UIDiscipleModel:setDiscipleAttrListDirtyX(equipData.dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
end
end
