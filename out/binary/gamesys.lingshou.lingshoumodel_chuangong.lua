
function lingshouModel:onEnterState_chuangong(isReconnect)

end

function lingshouModel:onProtocolReq_chuangong()

end

lingshouModel.chuanGongDataLookUp={}
lingshouModel.chuanGongData={}

function lingshouModel:onLeaveState_chuangong(isReconnect)
self.chuanGongData={}
self.chuanGongDataLookUp={}
self.chuangongSortDataDirty=false
end

function lingshouModel:setChuanGongDataList(cgList)
self.chuanGongDataLookUp={}
for _,data in ipairs(cgList)do
self.chuanGongDataLookUp[tostring(data.lsguid)]=data
end
end

function lingshouModel:addChuanGongData(lsGuid,zizhiTime,zizhiDec)
local temp={
lsguid=lsGuid,
zizhiTime=zizhiTime,
zizhiDec=zizhiDec,
}

if self.chuanGongDataLookUp==nil then
self.chuanGongDataLookUp={}
end
self.chuanGongDataLookUp[tostring(lsGuid)]=temp
end

function lingshouModel:removeChuanGongData(lsGuid)
self.chuanGongDataLookUp[tostring(lsGuid)]=nil
end

function lingshouModel:getReduceZiZhiValByLsGuid(lsGuid)
if self.chuanGongDataLookUp==nil then
return 0
end
local data=self.chuanGongDataLookUp[tostring(lsGuid)]
if data==nil then
return 0
end
return data.zizhiDec or 0
end

function lingshouModel:getLingShouZiZhiTimeByLsGuid(lsGuid)
if self.chuanGongDataLookUp==nil then
return 0
end
local data=self.chuanGongDataLookUp[tostring(lsGuid)]
if data==nil then
return 0
end
return data.zizhiTime or 0
end

function lingshouModel:checkLingshouZiZhiIsReduce(lsGuid)
local reduceVal=self:getReduceZiZhiValByLsGuid(lsGuid)
return reduceVal>0
end


function lingshouModel:calculateResetReturnItemList_ChuanGong(lsGuid)
local lookup=lingshouModel:calculateResetReturnItemLookup_ChuanGong(lsGuid)
local list={}
for itemId,itemVal in pairs(lookup)do
if itemVal>0 then
list[#list+1]={itemId,itemVal}
end
end
return list
end

function lingshouModel:calculateResetReturnItemLookup_ChuanGong(lsGuid)
local xmResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_XueMai(lsGuid)or defaultT
local msResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_MainSkill(lsGuid)or defaultT
local qlResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_QianLi(lsGuid)or defaultT

local xmPercent=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1,'xmPercent')
for itemid,itemval in pairs(xmResetReturnLookup)do
if xmPercent[itemid]then
xmResetReturnLookup[itemid]=mathHelper.safe_floor(xmResetReturnLookup[itemid]*xmPercent[itemid])
end
end

local skillPercent=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1,'skillPercent')
for itemid,itemval in pairs(msResetReturnLookup)do
if skillPercent[itemid]then
msResetReturnLookup[itemid]=mathHelper.safe_floor(msResetReturnLookup[itemid]*skillPercent[itemid])
end
end

local lookup={}
for itemId,itemVal in pairs(xmResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end

for itemId,itemVal in pairs(msResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end

for itemId,itemVal in pairs(qlResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end

return lookup
end

function lingshouModel:calculateResetReturnItemLookup_XueMai(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData.xuemai_val==1 and lsData.xuemai_dianshu==0 then return end

local itemLookup={}
local xmLevelAllConfig=lingshouModel:getLevelConfig2_XueMai(lsData.id)
local xuemai_cost_ls=lsData.cfg.xuemai_cost_ls

local cfunc=function(level,point)
local levelConfig=xmLevelAllConfig[level]
for dindex=point,0,-1 do
local fixCostT=levelConfig.fixedUpLevelCost[dindex]
if fixCostT then
for _,cost in ipairs(fixCostT)do
itemLookup[cost[1]]=itemLookup[cost[1]]and itemLookup[cost[1]]+cost[2]or cost[2]
end
end
local optCostT=levelConfig.optionalUpLevelCost[dindex]
if optCostT then
local stage=levelConfig.stage
for _,cost in pairs(optCostT)do
local costLSID=next(xuemai_cost_ls[level])
local lsColor=cfgHelper.get(cfg_lingshouconfig_get,costLSID,'color')
local id=-lsColor

itemLookup[id]=itemLookup[id]and itemLookup[id]+cost[2]or cost[2]
end
end
end
end

for level=lsData.xuemai_val,1,-1 do
if level==lsData.xuemai_val then
if lsData.xuemai_dianshu>0 then
cfunc(level,lsData.xuemai_dianshu-1)
end
else
local levelConfig=xmLevelAllConfig[level]
local allPoint=#levelConfig.pointList
cfunc(level,allPoint)
end
end

return itemLookup
end

function lingshouModel:calculateResetReturnItemLookup_MainSkill(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData.skill_level==1 then return end

local itemLookup={}
local mainSkillID=lsData.cfg.skill
local msLevelAllConfig=lingshouModel:getSkillConfig(mainSkillID)

for level=lsData.skill_level-1,1,-1 do
local cost=msLevelAllConfig.up_level_conf[level]
for _,item in ipairs(cost)do
itemLookup[item[1]]=itemLookup[item[1]]and itemLookup[item[1]]+item[2]or item[2]
end
end

return itemLookup
end

function lingshouModel:calculateResetReturnItemLookup_QianLi(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData.qianli_item_len==0 then return end

local itemLookup={}
for index=1,lsData.qianli_item_len do
local itemData=lsData.qianliItemList[index]
local id=itemData.param_1
local cnt=itemData.param_2
itemLookup[id]=itemLookup[id]and itemLookup[id]+cnt or cnt
end

return itemLookup
end



function lingshouModel:getChuanGongSortData()

table.clear(self.chuanGongData)

for _,data in pairs(self.chuanGongDataLookUp)do
table.insert(self.chuanGongData,data)
end

table.sort(self.chuanGongData,function(a,b)
return a.zizhiTime<b.zizhiTime
end)
return self.chuanGongData
end