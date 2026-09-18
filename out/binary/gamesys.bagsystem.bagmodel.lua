





bagModel={}











local _guid_lookup={}
local _itemid_lookup={}
local _itemid_num_lookup={}
local _isInit=nil
local _itemidLookup={}
local _bag_itemUseCount_lookup={}


function bagModel:onAppStart()

end

function bagModel:onEnterState()
_guid_lookup={}
_itemid_lookup={}
_itemidLookup={}
_itemid_num_lookup={}
_isInit=nil
UIFuncItemUseModel.checkTezhiAddFlag=nil
_bag_itemUseCount_lookup={}

self.group_cache_temp={}
self.cache={}

notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
end

function bagModel:onLeaveState()
_guid_lookup={}
_itemid_lookup={}
_itemidLookup={}
_itemid_num_lookup={}
_isInit=nil
_bag_itemUseCount_lookup={}
self.cache={}

bagModel.saveBagEquipFilterCount()

notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
end

function bagModel.checkInit()
return _isInit==true
end








function bagModel.onInitItems(len,datalist)
_isInit=true
_itemid_num_lookup={}
bagControl.invokeAllModelsFunc('clearBagItems')
_itemid_lookup={}
_guid_lookup={}
if len>0 then
for i,v in ipairs(datalist)do
bagModel.addItem(v,true)
bagControl.invokeFuncByItemId(v.itemid,'addItem',v,true)
end
end
bagEquipControl:initEquips()
bagControl.initBagWindow()
end




function bagModel.onChangeItem(data,finallyLookup)
local _itemguid=data.itemguid
local _itemcount=data.itemcount
local _ifdetails=data.ifdetails
local _itemid=data.itemid
local _itemflag=data.itemflag
local _itemData=data.itemData
local _itemtime=data.itemtime
local guidStr=data.guidStr or tostring(_itemguid)
local last_data=bagModel.cache[guidStr]or
bagModel.getItemByStr(guidStr)
or{}
local lastcount=last_data.itemcount or 0
local lastitemid=_itemid or last_data.itemid
local changeType

local args
local data_
if _itemcount==0 then

bagModel.cache[guidStr]=nil
args=guidStr
data_=bagModel.getItem(_itemguid)
changeType=CHANGE_TYPE.eDelete
finallyLookup[guidStr]=changeType
else
local data=
{
itemguid=_itemguid,
itemcount=_itemcount,
itemid=_itemid or last_data.itemid,
itemflag=_itemflag or last_data.itemflag,
itemData=_itemData or last_data.itemData,
itemtime=_itemtime or last_data.itemtime,
guidStr=guidStr,
}
if _ifdetails==1 then

bagModel.cache[guidStr]=data
args=data
data_=data
changeType=CHANGE_TYPE.eAdd
finallyLookup[guidStr]=changeType
else
if lastitemid==nil then
logErr('此物品为新增物品，但没有下发详细信息：',tostring(_itemguid))
return
end

bagModel.cache[guidStr]=data
args=data
data_=data
changeType=CHANGE_TYPE.eChanged
finallyLookup[guidStr]=changeType
end
if _itemcount>lastcount then
local changed=_itemcount-lastcount
local itemid=_itemid or last_data.itemid
local colorName
if itemsConfig.isFabao(itemid)then
colorName=fabaoHelper.getColorFabaoName(data)
elseif itemsConfig.isLingZhen(itemid)then
colorName=UIYuFuLingZhenControl:getLingZhenColorName(data)
else
colorName=itemsConfig.getColorName(itemid)
end
local color=itemsConfig.getConfig(itemid).color

local isPrizeState=showPrizeControl.isPrizeState()
if(not isPrizeState)then
UIManager.rewardInfo(nil,string.format('%s<color=%s>X%d</color>',colorName,FONT_COLOR_VAL[color],changed))
end
end
end



return{changeType,_itemguid,lastitemid,lastcount,_itemcount,guidStr,},args,data_
end

function bagModel.popupRewardInfo(itemid,data,changed)
local colorName
if itemsConfig.isFabao(itemid)then
colorName=fabaoHelper.getColorFabaoName(data)
elseif itemsConfig.isLingZhen(itemid)then
colorName=UIYuFuLingZhenControl:getLingZhenColorName(data)
else
colorName=itemsConfig.getColorName(itemid)
end
local color=itemsConfig.getConfig(itemid).color
UIManager.rewardInfo(nil,string.format('%s<color=%s>X%d</color>',colorName,FONT_COLOR_VAL[color],changed))
end

function bagModel.onChangeItemList(len,array)
if len>0 then

local firstHasList={}
local firstHasLookup={}

local firstHasXMitem=0
local firstHasXMLookup={}
local firstHasYZitem=0
local firstHasYZLookup={}

local argslist={}
local lookup={}
local lookup_itemid={}
local lookup_guidStr={}
local lookup_bag={}
local lookup_change={}

local bag_argslist={}
local bag_lookup_itemid={}
local bag_lookup_guidStr={}
local bag_lookup_change={}
local finallyLookup={}

for i=1,len do
local postArgs,args,data=bagModel.onChangeItem(array[i],finallyLookup)
if postArgs then

local changeType=postArgs[1]
local itemid=postArgs[3]
local guidStr=postArgs[6]
local bagType=itemsConfig.getBagType(itemid)


if bag_argslist[bagType]==nil then bag_argslist[bagType]={}end
local bagargslist_=bag_argslist[bagType]

if bag_lookup_itemid[bagType]==nil then bag_lookup_itemid[bagType]={}end
local bagitemidlookup_=bag_lookup_itemid[bagType]

if bag_lookup_guidStr[bagType]==nil then bag_lookup_guidStr[bagType]={}end
local bagguidStrlookup_=bag_lookup_guidStr[bagType]

if bag_lookup_change[bagType]==nil then bag_lookup_change[bagType]={}end
local bagchangelookup_=bag_lookup_change[bagType]

bagargslist_[#bagargslist_+1]=postArgs
bagguidStrlookup_[guidStr]=data
bagitemidlookup_[itemid]=true
bagchangelookup_[changeType]=true



argslist[#argslist+1]=postArgs
lookup_guidStr[guidStr]=data
lookup_itemid[itemid]=true
lookup_bag[bagType]=true
lookup_change[changeType]=true

if lookup[changeType]==nil then lookup[changeType]={}end
if lookup[changeType][bagType]==nil then lookup[changeType][bagType]={}end
local lookup_=lookup[changeType][bagType]
lookup_[#lookup_+1]=args

if changeType==CHANGE_TYPE.eAdd and not firstHasLookup[itemid]and not bagHelper.hasItemInLocalFile(itemid)then
firstHasLookup[itemid]=true
firstHasList[#firstHasList+1]=itemid


if itemsConfig.isEquip(itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig and itemConfig.type3 and not bagHelper.hasItemInLocalXMFile(itemConfig.type3)and not firstHasXMLookup[itemConfig.type3]then
firstHasXMLookup[itemConfig.type3]=true
firstHasXMitem=itemid
end
end
end


if changeType==CHANGE_TYPE.eAdd and not firstHasYZLookup[itemid]and not bagHelper.hasItemInLocalYZZQFile()then
if itemsConfig.isYunZhouComponents(itemid)then
firstHasYZLookup[itemid]=true
firstHasYZitem=itemid
end
end
end
end

for changeType,v in pairs(lookup)do
for bagType,list in pairs(v)do
if changeType==CHANGE_TYPE.eAdd then
bagModel.addItemList(bagType,list,finallyLookup)
elseif changeType==CHANGE_TYPE.eDelete then
bagModel.deleleItemList(bagType,list,finallyLookup)
elseif changeType==CHANGE_TYPE.eChanged then
bagModel.changeItemList(bagType,list,finallyLookup)
end
end
end


for _,postArgs in ipairs(argslist)do
notifySystem:postNotify(notifyConfig.on_item_changed,
postArgs[1],
postArgs[2],
postArgs[3],
postArgs[4],
postArgs[5],
postArgs[6])
end


for bagType,postArgslist in pairs(bag_argslist)do
notifySystem:postNotify(notifyConfig.on_bagtype_item_list_changed,
bagType,
postArgslist,
bag_lookup_guidStr[bagType],
bag_lookup_itemid[bagType],
bag_lookup_change[bagType])
end


notifySystem:postNotify(notifyConfig.on_item_list_changed,
argslist,
lookup_guidStr,
lookup_itemid,
lookup_bag,
lookup_change)

if#firstHasList>0 then
bagHelper.setItemListInLocalFile(firstHasList,true)
notifySystem:postNotify(notifyConfig.on_item_list_first_get,firstHasList)
end

if firstHasXMitem>0 then
bagHelper.setItemListInLocalXMFile(firstHasXMLookup,true)
notifySystem:postNotify(notifyConfig.on_XMequip_first_get,firstHasXMLookup)
end
if firstHasYZitem>0 then
bagHelper.setItemInLocalYZZQFile(true)
notifySystem:postNotify(notifyConfig.on_YZequip_first_get,firstHasYZitem)
end
end
end


function bagModel.onItemLock(item,lockflag)
if item==nil then
loggerUtil.logErrFMT('没有找到改变锁定状态的道具/装备:{0}',tostring(item.itemguid))
return
end
local itemguid=item.itemguid
local isUnlock=lockflag==0
local itemid=item.itemid
itemsModel.checkCfg(itemid)
local itemflag=item.itemflag or 0
local idx=1
local lastIsLock=bagHelper.isLock(item)
if isUnlock==not lastIsLock then return end
if isUnlock then
item.itemflag=mathHelper.clrbit(itemflag,idx)
else
item.itemflag=mathHelper.setbit(itemflag,idx)
end
notifySystem:postNotify(notifyConfig.on_item_lock_changed,itemid,itemguid,isUnlock)
end





function bagModel.getItem(itemguid)
local guidStr=tostring(itemguid)
return _guid_lookup[guidStr]
end

function bagModel.getItemByStr(guidStr)
return _guid_lookup[guidStr]
end

function bagModel.hasItem(itemguid)
return bagModel.getItem(itemguid)~=nil
end

function bagModel.hasItemByStr(guidStr)
return bagModel.getItemByStr(guidStr)~=nil
end



function bagModel.addItemList(bagType,datalist,finallyLookup)
local datalist_={}
for _,data in ipairs(datalist)do
local guidStr=data.guidStr
if finallyLookup[guidStr]==CHANGE_TYPE.eAdd then
bagModel.addItem(data,false)
datalist_[#datalist_+1]=data
end
end
bagControl.invokeFuncByBagType(bagType,'addItemList',datalist_,false)
end


function bagModel.addItem(data,isInit)
local itemguid=data.itemguid
local guidStr=tostring(itemguid)
data.guidStr=guidStr
local itemid=data.itemid
_itemidLookup[guidStr]=itemid
itemsModel.checkCfg(itemid)
bagModel.setItemidLookup(itemid,itemguid,guidStr,data.itemcount,data.itemflag,data.itemtime)
_guid_lookup[guidStr]=data
if not isInit then
bagNewHelper.setItemNewFlag(data,true)
end

local old=_itemid_num_lookup[itemid]or 0
_itemid_num_lookup[itemid]=old+data.itemcount
bagUseControl.checkAutoItemUse(data)
end


function bagModel.deleleItemList(bagType,strlist,finallyLookup)
local lookup={}
local len=#strlist
for _,guidStr in ipairs(strlist)do
if finallyLookup[guidStr]==CHANGE_TYPE.eDelete then
local data=bagModel.deleteItem(guidStr)
lookup[guidStr]=data
end
end

bagControl.invokeFuncByBagType(bagType,'deleleItemlist',len,lookup)
end


function bagModel.deleteItem(guidStr)
local data=_guid_lookup[guidStr]
if data==nil then
loggerUtil.logErrFMT('没有找到guid:{0}的道具',guidStr)
return
end
assert(data.itemid)
local itemid=data.itemid
bagModel.setItemidLookup(itemid,data.itemguid,data.guidStr,0,data.itemflag,data.itemflag,data.itemtime)
bagNewHelper.setItemNewFlag(data,false)
_guid_lookup[guidStr]=nil

local old=_itemid_num_lookup[itemid]or 0
_itemid_num_lookup[itemid]=old-data.itemcount
if _itemid_num_lookup[itemid]<0 then
_itemid_num_lookup[itemid]=0
loggerUtil.logErrFMT('道具：{0}数量为负了',itemid)
end
return data
end




function bagModel.changeItemList(bagType,datalist,finallyLookup)
local lookup={}
local len=#datalist
for _,data in ipairs(datalist)do
local guidStr=data.guidStr
if finallyLookup[guidStr]==CHANGE_TYPE.eChanged then
bagModel.changeItem(data)
lookup[guidStr]=data
end
end
bagControl.invokeFuncByBagType(bagType,'changeItemList',lookup)
end


function bagModel.changeItem(data)
local guidStr=data.guidStr
local lastData=_guid_lookup[guidStr]
local lastcount=0
if lastData then
lastcount=lastData.itemcount
end
local isAdd=data.itemcount>lastcount
_guid_lookup[guidStr]=data
bagModel.setItemidLookup(data.itemid,data.itemguid,data.guidStr,data.itemcount,data.itemflag,data.itemtime)

local itemid=data.itemid
local old=_itemid_num_lookup[itemid]or 0
_itemid_num_lookup[itemid]=old+data.itemcount-lastcount

if _itemid_num_lookup[itemid]<0 then
_itemid_num_lookup[itemid]=0
loggerUtil.logErrFMT('道具：{0}数量为负了',itemid)
end

if isAdd then
bagUseControl.checkAutoItemUse(data)
end

end


function bagModel.changeItemData(itemguid,cd_time,use_times)
local guidStr=tostring(itemguid)
local item=_guid_lookup[guidStr]
if not item then
return
end
local itemData=item.itemData or{}
itemData.cd_time=cd_time
itemData.use_times=use_times
item.itemData=itemData
_guid_lookup[guidStr]=item
end

function bagModel.getItemIdByGUID(itemguid)
return _itemidLookup[tostring(itemguid)]
end

function bagModel.getItemCountById(itemid)




return _itemid_num_lookup[itemid]or 0
end


function bagModel.getNotExpireItemCountById(itemid)
local model=bagControl.getBagModel(itemid)
if model then
return model:getNotExpireItemCountByItemID(itemid)
end
loggerUtil.logErrFMT('没有找到道具{0}所在背包',itemid)
end


function bagModel.getNearestExpireTimeById(itemid)
local model=bagControl.getBagModel(itemid)
if model then
return model:getNearestExpireTimeById(itemid)
end
loggerUtil.logErrFMT('没有找到道具{0}所在背包',itemid)
end

function bagModel.setItemidLookup(itemid,itemguid,guidStr,num,itemflag,itemtime)
if _itemid_lookup[itemid]==nil then _itemid_lookup[itemid]={}end
local itemidlookup=_itemid_lookup[itemid]
if num>0 then
itemidlookup[guidStr]={itemguid,num,itemflag,itemtime}
else
itemidlookup[guidStr]=nil
end
end

function bagModel.getAllItems()
return _itemid_lookup
end

function bagModel.checkCombine()
local combineList={}
for itemid,itemidlookup in pairs(_itemid_lookup)do
local cfg=itemsConfig.getConfig(itemid)
if cfg and cfg.dup then
local list={}
local lookup={}
local dup=cfg.dup
for guidStr,v in pairs(itemidlookup)do
local itemguid=v[1]
local num=v[2]
local itemflag=v[3]
local hasExpireTime=itemflag and mathHelper.getBitValue(itemflag,3-1)or false
local itemtime=hasExpireTime and v[4]or 0
if num<dup then
lookup[guidStr]=num
if not list[itemtime]then
list[itemtime]={}
end

local sameTimeList=list[itemtime]
sameTimeList[#sameTimeList+1]=itemguid
end
end

if list and next(list)then
for i,guidList in pairs(list)do
local len=#guidList
if len>1 then
combineList[#combineList+1]={len,guidList}
end
end
end
end
end
if#combineList>0 then
bagProtocolControl.req_zhengli_bag_items(combineList)
end
end



function bagModel:setItemUseCountList(useCountList)
if not self.bag_itemUseCount_lookup then
self.bag_itemUseCount_lookup={}
end


for i,v in ipairs(useCountList)do
local itemId=v.param_1
local useCount=v.param_2
self.bag_itemUseCount_lookup[itemId]=useCount
end

notifySystem:postNotify(notifyConfig.onItemUseCountChange)
end


function bagModel:getItemUseCount(itemId)
if self.bag_itemUseCount_lookup and self.bag_itemUseCount_lookup[itemId]then
return self.bag_itemUseCount_lookup[itemId]
end

return 0
end


function bagModel:clearItemUseCount(itemId)
if self.bag_itemUseCount_lookup and self.bag_itemUseCount_lookup[itemId]then
self.bag_itemUseCount_lookup[itemId]=nil
end

notifySystem:postNotify(notifyConfig.onItemUseCountChange)
end





function bagModel:clearItemUseCountByLimitType(limitType)
if not self.bag_itemUseCount_lookup or not next(self.bag_itemUseCount_lookup)then
return
end


for itemId,v in pairs(self.bag_itemUseCount_lookup)do
local itemCfg=itemsConfig.getConfig(itemId)
local useLimit=itemCfg and itemCfg.uselimit or nil
if useLimit and useLimit[1]==limitType then
self.bag_itemUseCount_lookup[itemId]=nil
end
end

notifySystem:postNotify(notifyConfig.onItemUseCountChange)
end


function bagModel:addItemUseCount(itemId)
if not self.bag_itemUseCount_lookup then
self.bag_itemUseCount_lookup={}
end

local nowCount=bagModel:getItemUseCount(itemId)
self.bag_itemUseCount_lookup[itemId]=nowCount+1

notifySystem:postNotify(notifyConfig.onItemUseCountChange)
end


function bagModel:addItemUseCount_list(len,itemList)
if not len or len<=0 then
return
end

if not self.bag_itemUseCount_lookup then
self.bag_itemUseCount_lookup={}
end

for i,v in ipairs(itemList)do
local itemId=v.param_1
local nowCount=bagModel:getItemUseCount(itemId)
self.bag_itemUseCount_lookup[itemId]=nowCount+1
end

notifySystem:postNotify(notifyConfig.onItemUseCountChange)
end



function bagModel:addWaitShowUseTipsItemList(item)
if not self.waitShowUseTipsItemList then
self.waitShowUseTipsItemList={}
end
table.insert(self.waitShowUseTipsItemList,item)
end


function bagModel:getWaitShowUseTipsItemList()
return self.waitShowUseTipsItemList or{}
end


function bagModel:clearWaitShowUseTipsItemList()
self.waitShowUseTipsItemList={}
end



function bagModel:addWaitShowSellTipsExpireItemList(item)
if not self.waitShowSellTipsExpireItemList then
self.waitShowSellTipsExpireItemList={}
end
table.insert(self.waitShowSellTipsExpireItemList,item)
end


function bagModel:getWaitShowSellTipsExpireItemList()
return self.waitShowSellTipsExpireItemList or{}
end


function bagModel:clearWaitShowSellTipsExpireItemList()
self.waitShowSellTipsExpireItemList={}
end

local _bagEquipFilterCount=0
function bagModel.initBagEquipFilterCount(len,arr)
if len>0 then
_bagEquipFilterCount=arr[1]
end
end

function bagModel.getBagEquipFilterCount()
return _bagEquipFilterCount
end

function bagModel.addBagEquipFilterCount()
_bagEquipFilterCount=_bagEquipFilterCount+1
end

function bagModel.saveBagEquipFilterCount()
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.BAG_EQUIP_FILTER_COUNT,1,{_bagEquipFilterCount})
end

function bagModel.onTaskChange(taskid,taskstate)
if taskstate~=taskModel.taskAcceptState then return end

local taskcfg=taskModel:getTaskConfig(taskid)

if taskcfg.tasktype==taskTypeClientCheckType.eBagEquipFilterNum then
_bagEquipFilterCount=0
end
end







