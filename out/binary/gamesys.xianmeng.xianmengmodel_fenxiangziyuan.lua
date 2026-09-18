







local _otherData=nil









local _ownerData=nil









local _ownerCount=0


local _otherCache=nil


local _ownerCache=nil

local _ownerType={}




local _itemLookup={}

local _itemRefresh={}


local _shareRecord={}

local _gainList={}

local _tipsFlag=true



local _filterData=nil


local _filterBit=nil

local _defaultFilter={
{
false,false,false,false,false,
},
{
false
},
}

local _filterSaveKey="xmfxzyFliter"


local _checkCondition={
[1]={
tips=function(value)
return FMT.fmt("宗门{0}级后可解锁求助",value)
end,
check=function(value)
return zongmenModel:getLevel()>=value
end,
},
}

function xianmengModel:initData_fenxiangziyuan()
self:resetFilterDataq_fenxiangziyuan()
self:setTipsFlag_fenxiangziyuan(true)
end

function xianmengModel:clearData_fenxiangziyuan(onlyCache)
_otherData=nil
_ownerData=nil
_ownerCount=0
_ownerType={}
_otherCache=nil
_itemLookup={}
_itemRefresh={}
if not onlyCache then
_filterData=nil
_filterBit=nil
end
end

function xianmengModel:getSeekTimes_fenxiangziyuan()
return _ownerCount
end

function xianmengModel:getShareTimes_fenxiangziyuan()
local baseData=self:getXMBaseData()
if baseData then
return baseData.shareTimes
end
end

function xianmengModel:addShareTimes_fenxiangziyuan(guid)
local baseData=self:getXMBaseData()
if baseData then
baseData.shareTimes=baseData.shareTimes+1
end
table.insert(_shareRecord,guid)
end

function xianmengModel:checkData_fenxiangziyuan()
return _otherData~=nil and _ownerData~=nil and _shareRecord~=nil
end

function xianmengModel:setData_fenxiangziyuan(list,records)
_otherData={}
_ownerData={}
_otherCache={}
_ownerType={}
_ownerCache=nil
_shareRecord=records or{}
_ownerCount=0
if list then
local playerId=playerModel:getActorID()
for i,v in ipairs(list)do
local key=tostring(v.askforguid)
local data={
guid=v.askforguid,
guidStr=key,
actor=v.actorid,
item=v.itemid,
progress=v.times,
}
if v.actorid==playerId then
_ownerData[key]=data
_ownerCount=_ownerCount+1
else
_otherData[key]=data
end
end
end
end

function xianmengModel:isOtherData_fenxiangziyuan(key)
return _otherData[key]~=nil
end

function xianmengModel:isOwnerData_fenxiangziyuan(key)
return _ownerData[key]~=nil
end

function xianmengModel:addData_fenxiangziyuan(v)
local playerId=playerModel:getActorID()
local key=tostring(v.askforguid)
local data={
guid=v.askforguid,
guidStr=key,
actor=v.actorid,
item=v.itemid,
progress=v.times
}
local isSelf=v.actorid==playerId
if isSelf then
_ownerData[key]=data
_ownerCount=_ownerCount+1
_ownerCache=nil
_itemLookup={}
else
_otherData[key]=data
self:clearOtherCache_fenxiangziyuan()
end
return data
end

function xianmengModel:deleteData_fenxiangziyuan(key)
local isSelf=self:isOwnerData_fenxiangziyuan(key)

if not isSelf then
_otherData[key]=nil
self:clearOtherCache_fenxiangziyuan()
else
_ownerData[key]=nil
_ownerCount=_ownerCount-1
_ownerCache=nil
_itemLookup={}
end
end

function xianmengModel:clearOtherCache_fenxiangziyuan()
for colorFilter,v1 in pairs(_otherCache)do
for itemType,v2 in pairs(v1)do
for flagFilter,v3 in pairs(v2)do
_otherCache[colorFilter][itemType][flagFilter]=nil
end
end
end
end

function xianmengModel:getOtherData_fenxiangziyuan(key)
return _otherData[key]
end

function xianmengModel:getOwnerData_fenxiangziyuan(key)
return _ownerData[key]
end

function xianmengModel:hasData_fenxiangziyuan(key)
return self:getOtherData_fenxiangziyuan(key)~=nil or self:getOwnerData_fenxiangziyuan(key)~=nil
end

function xianmengModel:getData_fenxiangziyuan(key)
return self:getOtherData_fenxiangziyuan(key)or self:getOwnerData_fenxiangziyuan(key)
end

function xianmengModel:findOwnerDataSameTypeData_fenxiangziyuan(itemId)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
for key,data in pairs(_ownerData)do
local cfg=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
if cfg.aftype==config.aftype then
return key
end
end
end

function xianmengModel:addDataProgress_fenxiangziyuan(key)
local data=self:getData_fenxiangziyuan(key)
data.progress=data.progress+1

local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
local complete=data.progress>=config.max
if complete then
local isSelf=self:isOwnerData_fenxiangziyuan(key)
if not isSelf then
self:clearOtherCache_fenxiangziyuan()
end
end
return complete
end

function xianmengModel:isDataFullProgress_fenxiangziyuan(key)
local data=self:getData_fenxiangziyuan(key)
if data then
return self:isDataFullProgressEx_fenxiangziyuan(data)
end
end

function xianmengModel:isDataFullProgressEx_fenxiangziyuan(data)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
return data.progress>=config.max
end

function xianmengModel:resetFilterDataq_fenxiangziyuan()
_filterData={
{
false,false,false,false,false,
},
{
false
},
}
_filterBit={0,0}
end

function xianmengModel:setFilterData_fenxiangziyuan(filterData)
_filterData=filterData
for i,v in ipairs(_filterData)do
_filterBit[i]=mathHelper.convertArrayToBit(v,#v)
end
end

function xianmengModel:getFilterData_fenxiangziyuan()
return _filterData
end

function xianmengModel:getFilterBit_fenxiangziyuan()
return _filterBit
end

function xianmengModel:getShareOtherFilterSort_fenxiangziyuan(colorBit,itemType,flagBit,forceRefresh)
itemType=itemType or-1

if not forceRefresh and _otherCache[colorBit]and _otherCache[colorBit][itemType]and _otherCache[colorBit][itemType][flagBit]then
return _otherCache[colorBit][itemType][flagBit]
end
table.checkCreateSubTable(_otherCache,{colorBit,itemType,flagBit})
local temp={}
local tempS={}
local tempF={}
for guidStr,data in pairs(_otherData)do
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
if config then
if itemType<0 or itemsConfig.getMainType(data.item)==itemType then
local color=itemsConfig.getItemColor(data.item)
if colorBit==0 or mathHelper.getBitValue(colorBit,color-1)then
if flagBit==0 then
if data.progress<config.max then
if self:containShareRecord_fenxiangziyuan(guidStr)then
table.insert(tempS,guidStr)
else
table.insert(temp,guidStr)
end
else
table.insert(tempF,guidStr)
end
else
local need=config.num
local have=itemsModel.getCount(data.item)
if have>=need then
if data.progress<config.max then
if self:containShareRecord_fenxiangziyuan(guidStr)then
table.insert(tempS,guidStr)
else
table.insert(temp,guidStr)
end
else
table.insert(tempF,guidStr)
end
end
end
end
end
else
loggerUtil.logErrFMT("仙盟资源分享没有配置道具{0}",data.item)
end
end
table.sort(temp)
table.sort(tempS)
table.sort(tempF)
for i,v in ipairs(tempS)do
table.insert(temp,v)
end
local cnt=cfgHelper.get2(cfg_guildbaseconfig_get,1,"completeshow_askfor")
for i=1,cnt do
table.insert(temp,tempF[i])
end
_otherCache[colorBit][itemType][flagBit]=temp
return temp
end

function xianmengModel:getShareOwnerSort_fenxiangziyuan()
if _ownerCache then
return _ownerCache
end
local temp={}
local tempF={}
for guidStr,data in pairs(_ownerData)do
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
if config then
if data.progress<config.max then
table.insert(temp,guidStr)
else
table.insert(tempF,guidStr)
end
else
loggerUtil.logErrFMT("仙盟资源分享没有配置道具{0}",data.item)
end
end
table.sort(temp)
table.sort(tempF)
for i,v in ipairs(tempF)do
table.insert(temp,v)
end
_ownerCache=temp
return temp
end

function xianmengModel:getShareSuccessCount_fenxiangziyuan()
local temp=0
for guidStr,data in pairs(_ownerData)do
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
if not config or data.progress>=config.max then
temp=temp+1
end
end
return temp
end

function xianmengModel:getSeekItemSort_fenxiangziyuan(itemType)
itemType=itemType or-1
local temp=_itemLookup[itemType]
if not _itemRefresh[itemType]and temp then
return temp
end

temp={}

local tempEx={}

local cfg=cfg_guildaskforconfig()
for itemid,config in pairs(cfg)do
if not config.banAsk then
if itemType<0 or itemsConfig.getMainType(itemid)==itemType then
local sortWeight=config.sortWeight or 0
if self:checkConditions_fenxiangziyuan(config.condition)then
if not self:findOwnerDataSameTypeData_fenxiangziyuan(itemid)then
sortWeight=sortWeight+1000000
end
table.insert(temp,{itemid=itemid,sortWeight=sortWeight})
else
table.insert(tempEx,{itemid=itemid,sortWeight=sortWeight})
end
end
end
end

local sortFunc=function(a,b)
if a.sortWeight~=b.sortWeight then
return a.sortWeight>b.sortWeight
else
return a.itemid<b.itemid
end
end
table.sort(temp,sortFunc)
table.sort(tempEx,sortFunc)

local data={}
for i,v in ipairs(temp)do
table.insert(data,v.itemid)
end
local exCnt=cfgHelper.get2(cfg_guildbaseconfig_get,1,"lockshow_askfor")
for i=1,exCnt do
if tempEx[i]then
table.insert(data,tempEx[i].itemid)
end
end
_itemLookup[itemType]=data
_itemRefresh[itemType]=nil
return data
end

function xianmengModel:clearSeekItemSort_fenxiangziyuan()
_itemLookup={}
end

function xianmengModel:needSeekItemRefresh_fenxiangziyuan(itemType)
itemType=itemType or-1
_itemRefresh[itemType]=true
end

function xianmengModel:getReddot_fenxiangziyuan()
local seekTimes=self:getSeekTimes_fenxiangziyuan()
if seekTimes and seekTimes<=0 then
return true
end
return false
end

function xianmengModel:checkConditions_fenxiangziyuan(conditions,warning)
if conditions then
for i,v in ipairs(conditions)do
if not self:checkCondition_fenxiangziyuan(v[1],v[2])then
if warning then
local str=self:getConditionTips_fenxiangziyuan(v[1],v[2])
UIManager.info(str)
end
return false
end
end
end
return true
end

function xianmengModel:checkCondition_fenxiangziyuan(cType,cValue)
local checkHandle=_checkCondition[cType]
if checkHandle then
return checkHandle.check(cValue)
end
return true
end

function xianmengModel:getConditionTips_fenxiangziyuan(cType,cValue)
local checkHandle=_checkCondition[cType]
if checkHandle then
return checkHandle.tips(cValue)
end
return""
end

function xianmengModel:getConditionTipsList_fenxiangziyuan(conditions,splite)
local str=nil
local spliteStr=splite or"\n"
if conditions then
for i,v in ipairs(conditions)do
local temp=nil
if not self:checkCondition_fenxiangziyuan(v[1],v[2])then
temp=FMT.cfmt(FONT_COLOR.eRedColor,xianmengModel:getConditionTips_fenxiangziyuan(v[1],v[2]))
end
if temp then
if str then
str=FMT.fmt("{0}{1}{2}",str,spliteStr,temp)
else
str=temp
end
end
end
end
return str
end

function xianmengModel:containShareRecord_fenxiangziyuan(guidStr)
for i,v in ipairs(_shareRecord)do
if tostring(v)==guidStr then
return true
end
end
return false
end

function xianmengModel:clearShareRecord_fenxiangziyuan()
_shareRecord={}
end

function xianmengModel:setTipsFlag_fenxiangziyuan(flag)
_tipsFlag=flag
end

function xianmengModel:getTipsFlag_fenxiangziyuan()
return _tipsFlag
end

function xianmengModel:clearGainList_fenxiangziyuan()
_gainList={}
end

function xianmengModel:setGainList_fenxiangziyuan(list)
_gainList=list or{}
end

function xianmengModel:getGainList_fenxiangziyuan()
return _gainList
end