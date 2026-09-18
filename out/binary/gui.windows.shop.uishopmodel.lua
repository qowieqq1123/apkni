
UIShopModel={}

function UIShopModel:onAppStart()
self.maxlvTable={}
end

function UIShopModel:onEnterState(...)
self.data={moodValue=0,shopDatas={}}
end

function UIShopModel:onLeaveState(...)
self.data=nil
self.transBuiId=nil
end

function UIShopModel:setDatas(datas,flag)
local data={}
data.moodValue=datas[1]
data.selectTime=datas[2]
data.consumeRateDatas={}
if datas[3]>0 then
for i,v in ipairs(datas[4])do
data.consumeRateDatas[v.param_1]=v.param_2
end
end
data.shopDatas={}
if datas[5]>0 then
local curTime=timeHelper.getServerShortTime()
for i,v in ipairs(datas[6])do






v.rewardInfo.param_1=v.rewardInfo.param_1>curTime and curTime or v.rewardInfo.param_1
v.clientNum=flag and UIShopControl:getCurReward(v)or 0
data.shopDatas[v.un_build_id]=v
v.is_in_event=v.event_id>0



end
end
self.data=data
end

function UIShopModel:getNextSelectTime()
return self.data.selectTime
end

function UIShopModel:setNextSelectTime(time)
self.data.selectTime=time
end

function UIShopModel:getMoodValue()
return self.data.moodValue
end

function UIShopModel:setMoodValue(val)
self.data.moodValue=val
end

function UIShopModel:addMoodValue(val)
self.data.moodValue=self.data.moodValue+val
end

function UIShopModel:setShopData(data)
local curTime=timeHelper.getServerShortTime()






if data.rewardInfo.param_1>curTime then
data.rewardInfo.param_1=curTime
end
data.is_in_event=data.event_id>0
data.clientNum=UIShopControl:getCurReward(data)
self.data.shopDatas[data.un_build_id]=data



end

function UIShopModel:removeShopData(sfId,ubdId)
self.data.shopDatas[ubdId]=nil
end

function UIShopModel:getShopData(ubdId)
return self.data.shopDatas[ubdId]
end

function UIShopModel:getAllShopData()
return self.data.shopDatas
end

function UIShopModel:isShopItemFull(bdId)
local data=self:getShopData(bdId)
for i,v in ipairs(data.sellItemList)do
if v<=0 then
return false
end
end
return true
end

function UIShopModel:isCanBuyItem()
for k,v in pairs(self.data.shopDatas)do
for i,vv in ipairs(v.sellItemList)do
if vv>0 then
return true
end
end
end
return false
end

function UIShopModel:getConsumeRateDatas()
return self.data.consumeRateDatas
end

function UIShopModel:setConsumeRate(key,rate)
self.data.consumeRateDatas[key]=rate
end

function UIShopModel:getConsumeRate(key)
return self.data.consumeRateDatas[key]
end

function UIShopModel:replaceCommodity(bdId,index)
local data=self.data.shopDatas[bdId]
data.create_item_idx=index
end

function UIShopModel:setEventState(bdId,state)
local data=self.data.shopDatas[bdId]
if data then
data.is_in_event=state
end
end

function UIShopModel:getEventState(bdId)
local data=self.data.shopDatas[bdId]
return data and data.is_in_event or false
end

function UIShopModel:setShopEventId(bdId,eventId)
local data=self.data.shopDatas[bdId]
if data then
data.event_id=eventId
end
end

function UIShopModel:getShopEventId(bdId)
local data=self.data.shopDatas[bdId]
return data and data.event_id or 0
end

function UIShopModel:isShop(buildid)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
return cfg.win_type==sysWinType.eShangPu
end


function UIShopModel:getShopBenefitRate(bdData)
local rate=0

local dzId=bdData.dizi_id
if tostring(dzId)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(bdData.dizi_id,DISCIPLE_PROSKILL_TYPE.eShangDao)
local skcfg=cfgHelper.get1(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eShangDao)
local add=skcfg.shangpu_effects[level]or 0
rate=1+add*0.01
end


local buffList=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eShopLingshiChanged)or{}
local buffRate=buffList[bdData.build_id]or 0
buffRate=buffRate/100
rate=rate+buffRate


local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eShangPuAdd,bdData.build_id)
buildingBuffRate=buildingBuffRate/100
rate=rate+buildingBuffRate

return rate
end



function UIShopModel:setCreateList(ubdId,createList)
local data=self.data.shopDatas[ubdId]
if data then
data.createList=createList
end
end

function UIShopModel:getCreateList(ubdId)
local data=self.data.shopDatas[ubdId]
if data then
if not data.createList then
data.createList={}
end
return data.createList
end
return{}
end


function UIShopModel:addCreateData(ubdId,createdata)
local createList=self:getCreateList(ubdId)
table.insert(createList,createdata)
end

function UIShopModel:refreshCreateData(ubdId)
local createList=self:getCreateList(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
local bdId=bdData.build_id
local level=bdData.level
local productionItemTimeList=UIShopModel:getProductionItemTimeList(bdId,level)
local isfinish
local curTime=timeHelper.getServerShortTime()
local finish_times
for i=#createList,1,-1 do
finish_times=createList[i].param_2+productionItemTimeList[createList[i].param_1]
isfinish=(finish_times-curTime)<=0
if isfinish then
table.remove(createList,i)
end
end
end

function UIShopModel:getProdMaxLevel(build_id)
if self.maxlvTable[build_id]==nil then
self.maxlvTable[build_id]=#cfg_shangpulevelconfig_get(build_id)
end
return self.maxlvTable[build_id]
end

function UIShopModel:getProductionCfg(build_id,build_level)
return cfg_shangpulevelconfig_get(build_id)[build_level]
end

function UIShopModel:getProductionCfg_itemlist(build_id,build_level)
local cfg=self:getProductionCfg(build_id,build_level)
return cfg.item_create_conf2.itemlist
end

function UIShopModel:getProductionItemList(build_id,build_level)
if self.productionItemLookup==nil or
self.productionItemLookup[build_id]==nil or
self.productionItemLookup[build_id][build_level]==nil then

self.productionItemLookup=self.productionItemLookup or{}
self.productionItemLookup[build_id]=self.productionItemLookup[build_id]or{}

local itemlist=self:getProductionCfg_itemlist(build_id,build_level)
local maxLevel=UIShopModel:getProdMaxLevel(build_id)
local showitemlist=self:getProductionCfg_itemlist(build_id,maxLevel)
local temp={}
local level
for i,v in ipairs(showitemlist)do
level=maxLevel
if not itemlist[i]then
local flag=false
for ii=maxLevel-1,1,-1 do
local checkitemlist=self:getProductionCfg_itemlist(build_id,ii)
for iii,vv in ipairs(checkitemlist)do
if vv[1]==v[1]then
level=ii
flag=true
break
end
end
if flag then
break
end
end
end
temp[#temp+1]={v[1],itemlist[i],level}
end
self.productionItemLookup[build_id][build_level]=temp
end
return self.productionItemLookup[build_id][build_level]
end

function UIShopModel:getCostItemList(build_id,build_level)
local maxLevel=UIShopModel:getProdMaxLevel(build_id)
local showitemlist=self:getProductionCfg_itemlist(build_id,maxLevel)
local itemlist=self:getProductionCfg_itemlist(build_id,build_level)
local temp={}
for i,v in ipairs(showitemlist)do
temp[#temp+1]=v.cost
end
return temp
end

function UIShopModel:getProductionItemTimeList(build_id,build_level)
if self.productionItemTimeList==nil or
self.productionItemTimeList[build_id]==nil or
self.productionItemTimeList[build_id][build_level]==nil then

local maxLevel=UIShopModel:getProdMaxLevel(build_id)
local showitemlist=self:getProductionCfg_itemlist(build_id,maxLevel)
local itemlist=self:getProductionCfg_itemlist(build_id,build_level)
local temp={}
for i,v in ipairs(showitemlist)do
temp[#temp+1]=v[3]
end
self.productionItemTimeList=self.productionItemTimeList or{}
self.productionItemTimeList[build_id]=self.productionItemTimeList[build_id]or{}
self.productionItemTimeList[build_id][build_level]=temp

end
return self.productionItemTimeList[build_id][build_level]
end

function UIShopModel:setProductSpeedupTime(un_build_id,time)
local createList=self:getCreateList(un_build_id)
if createList then
for i,v in ipairs(createList)do
local finish_times=v.param_2-time
if finish_times<0 then
finish_times=0
end
v.param_2=finish_times
end
end
end


function UIShopModel:printShopData(data)





















end


function UIShopModel:setTransShopID(build_id)
self.transBuiId=build_id
end

function UIShopModel:getTransShopID()
return self.transBuiId
end

function UIShopModel:setTransUnShopID(unbuild_id)
self.transunBuiId=unbuild_id
end

function UIShopModel:getTransUnShopID()
return self.transunBuiId
end
