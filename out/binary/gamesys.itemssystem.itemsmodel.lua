






itemsModel={}

local _guid=-1

function itemsModel.getGUID()
_guid=_guid-1
return _guid
end

function itemsModel.getItem(itemguid)
return bagModel.getItem(itemguid)or
equipsHelper.getEquip(itemguid)or
fabaoHelper.getFabao(itemguid)or
watchModel.getItem(itemguid)
end


function itemsModel.getIconName(item)
if item==nil then return end
local itemid=item.itemid
if itemsConfig.isFabao(itemid)then
itemid=fabaoHelper.getIconItemId(item)
if itemid and fabaoConfig.isBenMingFabao(item.itemid)then
local mianItemCfg=itemsConfig.getConfig(itemid)
return iconHelper.getItemIconName(mianItemCfg.fbicon)
end
elseif itemsConfig.isEquip(itemid)then
local dhcnt=equipsModel:getDianHuaCnt(item)
if dhcnt>0 then
local itemCfg=itemsConfig.getConfig(itemid)
return iconHelper.getItemIconName(itemCfg.dhicon[dhcnt])
end
end
return iconHelper.getIconName(itemid)
end


function itemsModel.getFabaoIconName(itemid,mainid)
if not itemsConfig.isFabao(itemid)then return end
if fabaoConfig.isBenMingFabao(itemid)then
local mianItemCfg=itemsConfig.getConfig(mainid)
return iconHelper.getItemIconName(mianItemCfg.fbicon)
elseif fabaoConfig.isXiantianFabao(itemid)then
return iconHelper.getIconName(itemid)
end
return iconHelper.getIconName(mainid)
end

function itemsModel.getItemIconName(itemid)
return iconHelper.getIconName(itemid)
end

function itemsModel.getIconId(item)
if item==nil then return end
local itemid=item.itemid
if itemsConfig.isFabao(itemid)then
itemid=fabaoHelper.getIconItemId(item)
end
local mianItemCfg=itemsConfig.getConfig(itemid)
local icon=mianItemCfg.icon
if fabaoConfig.isBenMingFabao(item.itemid)then
icon=mianItemCfg.fbicon
end
return icon
end


function itemsModel.getCount(itemid)
if moneyConfig.isMoney(itemid)then
return moneyModel.getMoney(itemid)
else
return bagModel.getItemCountById(itemid)
end
end


function itemsModel.getName(itemid)
if moneyConfig.isMoney(itemid)then
return moneyModel.getMoneyName(itemid)
else
return itemsConfig.getItemName(itemid)
end
end

function itemsModel.getNameByItem(item)
local itemid=item.itemid
if itemsConfig.isEquip(itemid)then
local cnt=equipsModel:getDianHuaCnt(item)
if cnt>0 then
local exname=cfgHelper.getdef2(cfg_equiprevealconfig,'dhname',cnt)
local name=itemsConfig.getItemName(item.itemid)
return FMT.fmt('{0}{1}',exname,name)
end
end
return itemsModel.getName(itemid)
end


function itemsModel.checkCfg(itemid)




end

function itemsModel:itemListToStr(list,sepSign,multiSign,typo)
local str=nil
for i,v in ipairs(list)do
local itemid=v[1]
local itemnum=v[2]
local tempStr
if typo==nil or typo==0 then
local itemName=itemsConfig.getItemName(itemid)
tempStr=FMT.fmt("{0}{2}{1}",itemName,mathHelper.formatNumber(itemnum),multiSign)
elseif typo==1 then
local itemName=itemsConfig.getColorName(itemid)
tempStr=FMT.fmt("{0}{2}{1}",itemName,mathHelper.formatNumber(itemnum),multiSign)
elseif typo==2 then
local iconName=iconHelper.getIconName(itemid)
tempStr=FMT.fmt("quad-icon={0}-quad*{1}",iconName,mathHelper.formatNumber(itemnum))
end
if str then
str=FMT.fmt("{0}{2}{1}",str,tempStr,sepSign)
else
str=tempStr
end
end
return str
end

function itemsModel.checkItemEnough(itemId,needCount)
if itemsConfig.getConfig(itemId)then
local count=itemsModel.getCount(itemId)
return count>=needCount
else
logErr(FMT.fmt("缺少 配置 itemid/moneyid ::{0}",itemId))
end
end


function itemsModel:canUseItem(itemid,needValue)
if itemsConfig.isMoney(itemid)then
local hasValue=moneyModel.getMoney(itemid)
if hasValue<needValue then
local flag,replace=moneySystem:canReplaceMoney(itemid,needValue-hasValue)
if flag then
return flag,replace
else
return false,itemid
end
end
else
if not itemsModel.checkItemEnough(itemid,needValue)then
return false,itemid
end
end
return true
end

function itemsModel:canUseItemlist(itemlist)
local temp={}
for i,v in ipairs(itemlist)do
local itemid=v[1]
local needValue=v[2]
if itemsConfig.isMoney(itemid)then
local hasValue=moneyModel.getMoney(itemid)
if hasValue<needValue then
local flag,replace=moneySystem:canReplaceMoney(itemid,needValue-hasValue)
if flag then
temp[itemid]=replace
else
return false,itemid
end
end
else
if not itemsModel.checkItemEnough(itemid,needValue)then
return false,itemid
end
end
end
return true,temp
end


function itemsModel:useItem(itemid,needValue,callback,warnType,exchangeType,callbackParams)
if itemsConfig.isMoney(itemid)then
return moneySystem:useMoney(itemid,needValue,callback,warnType,exchangeType,callbackParams)
else
if itemsModel.checkItemEnough(itemid,needValue)then
callback(callbackParams)
return true
end

local name=itemsConfig.getItemName(itemid)
if warnType==WARNING_TYPE.eWarning then
local err=FMT.fmt('{0}不足',name)
UIManager.error(err)
gainControl:showGainWin(itemid)
elseif warnType==WARNING_TYPE.eRechargeDialogue then
moneySystem:showBuyDialogue()
elseif warnType==WARNING_TYPE.eOnlyWaring then
local err=FMT.fmt('{0}不足',name)
UIManager.error(err)
end
return false
end
end


function itemsModel:useItemlist(itemlist,callback,warnType,exchangeLookup)
local nextFunc
nextFunc=function(index)
local cost=itemlist[index]
if cost then
local itemid=cost[1]
local exchangeType=exchangeLookup and exchangeLookup[itemid]or nil
local check=itemsModel:useItem(itemid,cost[2],nextFunc,warnType,exchangeType)
if check then
nextFunc(index+1)
end
else
callback()
end
end
nextFunc(1)
end


function itemsModel:useItemlist_finalCallback(itemlist,callback,warnType,exchangeLookup)
local nextFunc
local checkFunc
nextFunc=function(index)
index=index or 0
return checkFunc(index+1)
end

checkFunc=function(index)
local cost=itemlist[index]
if cost then
local itemid=cost[1]
local exchangeType=exchangeLookup and exchangeLookup[itemid]or nil
local check=itemsModel:useItem(itemid,cost[2],nextFunc,warnType,exchangeType,index)
else
callback()
end
end
nextFunc()
end
