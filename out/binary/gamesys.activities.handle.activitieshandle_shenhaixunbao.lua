







activitiesHandle_shenhaixunbao=new_activitiesHandle('activitiesHandle_shenhaixunbao',activitiesHandle)

function activitiesHandle_shenhaixunbao:onInit()

end

function activitiesHandle_shenhaixunbao.recv_247_100(args)
local actId=args[1]
local subId=args[2]
local mapGridsLen=args[3]
local mapGridsList=args[4]
local freeNum=args[5]
local jdrwScore=args[6]
local jdrwMaxVal=args[7]
local pos=args[8]
local xbNum=args[9]

local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end

local mapData={}
local gridGuidDataLookup={}
if mapGridsLen>0 then
for i,v in ipairs(mapGridsList)do
local gridIdx=v.pos
if not mapData[gridIdx]then
mapData[gridIdx]={}
end
local gridData=mapData[gridIdx]
local gridCfgId=v.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local gridType=gridCfg and gridCfg.gzType
if gridType then
if gridType==1 then

gridData.spGridData=v
elseif gridType==2 then

gridData.itemGridData=v
elseif gridType==3 then

gridData.boxGridData=v
elseif gridType==4 then

gridData.rareGridData=v
elseif gridType==5 then

gridData.eventGridData=v
end
end

local gridGuid=v.gzGuid
gridGuidDataLookup[gridGuid]={gridIdx=gridIdx,data=v,gridType=gridType}
end
end
data.mapData=mapData
data.freeNum=freeNum
data.jdrwScore=jdrwScore
data.jdrwMaxVal=jdrwMaxVal
data.pos=pos
data.xbNum=xbNum
data.gridGuidDataLookup=gridGuidDataLookup

activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:callWindowFunc('UISubAct_shenhaixunbaoWin','refresh')


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_shenhaixunbao.recv_247_101(actId,subId,jdrwScore,jdrwMaxVal)
local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end

data.jdrwScore=jdrwScore
data.jdrwMaxVal=jdrwMaxVal

activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:callWindowFunc('UISubAct_shenhaixunbaoWin','refreshProgressRewardPanel')
UIManager:callWindowFunc('UISubAct_shenhaixunbao_progressWin','refresh')


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shenhaixunbao.recv_247_102(actId,subId,gzGuid,posOld,posNew)
local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end
local gridGuidDataLookup=data.gridGuidDataLookup
local gridData=gridGuidDataLookup and gridGuidDataLookup[gzGuid]
local gridDataName
local gridType
if gridData and gridData.data then
gridData.data.pos=posNew
gridData.gridIdx=posNew
gridType=gridData.gridType
local gridDataNameList={
[1]="spGridData",
[2]="itemGridData",
[3]="boxGridData",
[4]="rareGridData",
[5]="eventGridData",
}
gridDataName=gridDataNameList[gridType]

local originalMapData=data.mapData[posOld]
if originalMapData then
originalMapData[gridDataName]=nil
end
local newMapData=data.mapData[posNew]
if newMapData then
newMapData[gridDataName]=gridData.data
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)

end


function activitiesHandle_shenhaixunbao.recv_247_103(args)
local actId=args[1]
local subId=args[2]
local tzType=args[3]
local tzNum=args[4]
local freeNum=args[5]
local jdrwScore=args[6]
local posOld=args[7]
local posNew=args[8]
local len=args[9]
local gridEffectList=args[10]
local xbNum=args[11]

local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao
local sortGridEffectList={}

local hasLevelUpLookup={}

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data then
data.freeNum=freeNum
data.jdrwScore=jdrwScore
data.pos=posNew
data.xbNum=xbNum

if len>0 then
local gridDataNameList={
[1]="spGridData",
[2]="itemGridData",
[3]="boxGridData",
[4]="rareGridData",
[5]="eventGridData",
}

local copyDataFunc=function(oldData,newPos,newExp)
if newPos then
oldData.pos=newPos
end
if newExp then
oldData.exp=newExp
end
end

local allGirdCfg=cfg_shenhaixunbaogeziconfig()
local getLevelFunc=function(gridExp,gridCfgId)
local gridCfg=allGirdCfg[gridCfgId]
local level=1
if gridCfg then
local expCfg=gridCfg.levelExp
if expCfg then
local lastLevelExp=0
for idx,lvExp in ipairs(expCfg)do
local lv=idx+1
if gridExp>=lvExp then
level=lv
else
break
end
lastLevelExp=lvExp
end
end
end
return level
end

local hasBoxGridLookup={}
local gridTypeSortWeightList={
[1]=101,
[2]=102,
[3]=104,
[4]=103,
[5]=105,
}


local lastPosIdx=posOld
local lastSortIdx
for i,v in ipairs(gridEffectList)do
v.originalIdx=i
local gridData=v.grid
local pos=gridData.pos
local gridCfgId=gridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local gridType=gridCfg and gridCfg.gzType
v.pos=pos
v.gridType=gridType
v.gridTypeSortWeight=gridTypeSortWeightList[gridType]
local effectStrList=v.effectList
if not hasBoxGridLookup[pos]and effectStrList and next(effectStrList)~=nil then
if gridType==3 then
hasBoxGridLookup[pos]=true
end
end

local sortIdx=pos==lastPosIdx and lastSortIdx or i
v.sortIdx=sortIdx

sortGridEffectList[#sortGridEffectList+1]=v

lastPosIdx=pos
lastSortIdx=sortIdx
end


table.sort(sortGridEffectList,function(a,b)
if a.sortIdx==b.sortIdx then
if a.gridTypeSortWeight==b.gridTypeSortWeight then
return a.originalIdx<b.originalIdx
else
return a.gridTypeSortWeight<b.gridTypeSortWeight
end
else
return a.sortIdx<b.sortIdx
end
end)

local getGridRewardList
if next(hasBoxGridLookup)~=nil then
getGridRewardList={}
end

for i,v in ipairs(sortGridEffectList)do
local gridData=v.grid
local gridGuid=gridData.gzGuid
local gridGuidData=data.gridGuidDataLookup[gridGuid]
if gridGuidData then
local originalGridIdx=gridGuidData.gridIdx
local gridType=gridGuidData.gridType
local gridTypeName=gridDataNameList[gridType]
local originalMapData=data.mapData[originalGridIdx]
if originalMapData then
originalMapData[gridTypeName]=nil
end

local newPos=gridData.pos
local gridDataPos=gridData.pos
local effectStrList=v.effectList
local processedEffectStrList
if effectStrList then
for i,jsonStr in ipairs(effectStrList)do
local jsonTable=jsonHelper.decode(jsonStr)
local effectType=jsonTable[1]
local params=jsonTable[2]
local isValid=true
if params then
local triggerGridGuid=params[1]
local targetGridGuid=params[2]
if effectType==7 then
local effectPosNew=params[4]
if targetGridGuid==gridGuid then
newPos=effectPosNew
end
elseif effectType==2 then
local addExp=params[3]
local targetGridGuidData=data.gridGuidDataLookup[targetGridGuid]
if targetGridGuidData then
local targetGridExp=targetGridGuidData.data.exp
local targetGridPos=targetGridGuidData.data.pos
local newExp=targetGridExp+addExp
targetGridGuidData.data.exp=newExp
local gridCfgId=targetGridGuidData.data.confId
local originalLv=getLevelFunc(targetGridExp,gridCfgId)
local newLv=getLevelFunc(newExp,gridCfgId)
local isLvUp=newLv>originalLv
if isLvUp then
hasLevelUpLookup[targetGridPos]=true
end

if triggerGridGuid~=targetGridGuid then
local targetGuidIdx=targetGridGuidData.gridIdx
local targetGridType=targetGridGuidData.gridType
local targetGridTypeName=gridDataNameList[targetGridType]
local targetGridMapData=data.mapData[targetGuidIdx]
if targetGridMapData[targetGridTypeName]then
local targetGridData=targetGridMapData[targetGridTypeName]
copyDataFunc(targetGridData,nil,newExp)
end
end
end
elseif effectType==1 and hasBoxGridLookup[gridDataPos]and gridType~=1 then

local itemList=params[3]
if not getGridRewardList[gridDataPos]then
getGridRewardList[gridDataPos]={}
end
local list=getGridRewardList[gridDataPos]
for i,v in ipairs(itemList)do

table.insert(list,i,v)
end
if gridType~=3 then

isValid=false
else

params[3]=list
end
end
end

if isValid then

if not processedEffectStrList then
processedEffectStrList={}
end
processedEffectStrList[#processedEffectStrList+1]=jsonTable
end
end
v.effectList=processedEffectStrList
end

gridGuidData.gridIdx=newPos

local newMapData=data.mapData[newPos]
if newMapData then

local newPosGridData=newMapData[gridTypeName]
if newPosGridData then
copyDataFunc(newPosGridData,newPos,gridData.exp)
else
newPosGridData=table.weakCopy(gridData)
newPosGridData.pos=newPos
newMapData[gridTypeName]=newPosGridData
end
end

copyDataFunc(gridGuidData.data,newPos,gridData.exp)
end
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)
end


















UIManager:callWindowFunc('UISubAct_shenhaixunbaoWin','startRoll',tzType,tzNum,posOld,posNew,sortGridEffectList,hasLevelUpLookup)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shenhaixunbao.recv_247_104(args)
local actId=args[1]
local subId=args[2]
local len=args[3]
local rwList=args[4]
local len2=args[5]
local rwItemList=args[6]

local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end

local recordRewardList={}
local recordList={}
if len>0 then
local tempItemIdxLookup={}
for _,recordData in ipairs(rwList)do
local itemList=recordData.itemList
local itemListLen=recordData.len
local tempItemList={}
if itemListLen>0 then
table.clear(tempItemIdxLookup)
for _,v in ipairs(itemList)do
local itemId=v.param_1
local itemCount=v.param_2
if tempItemIdxLookup[itemId]then
local index=tempItemIdxLookup[itemId]
local count=tempItemList[index][2]+itemCount
tempItemList[index][2]=count
else
local index=#tempItemList+1
tempItemIdxLookup[itemId]=index
tempItemList[index]={itemId,itemCount}
end
end








end

recordList[#recordList+1]={
rwType=recordData.rwType,
len=#tempItemList,
itemList=tempItemList,
}
end
end
data.recordList=recordList

if len2>0 then
for idx=len2,1,-1 do
local item=rwItemList[idx]
local itemId=item.param_1
local itemCount=item.param_2
recordRewardList[#recordRewardList+1]={itemId,itemCount}
end
end
data.recordRewardList=recordRewardList

activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:callWindowFunc('UISubAct_shenhaixunbaoWin','refreshRewardPanel')
UIManager:callWindowFunc('UISubAct_shenhaixunbao_recordWin','refresh')
end

function activitiesHandle_shenhaixunbao.recv_247_109(args)
local actId=args[1]
local subId=args[2]
local jdrwScore=args[3]
local posOld=args[4]
local posNew=args[5]
local xbNum=args[6]
local mapGridsLen=args[7]
local mapGridsList=args[8]
local freeNum=args[9]

local subType=SUB_ACTIVITY_TYPE.eShenHaiXunBao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end

local mapData={}
local gridGuidDataLookup={}
if mapGridsLen>0 then
for i,v in ipairs(mapGridsList)do
local gridIdx=v.pos
if not mapData[gridIdx]then
mapData[gridIdx]={}
end
local gridData=mapData[gridIdx]
local gridCfgId=v.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local gridType=gridCfg and gridCfg.gzType
if gridType then
if gridType==1 then

gridData.spGridData=v
elseif gridType==2 then

gridData.itemGridData=v
elseif gridType==3 then

gridData.boxGridData=v
elseif gridType==4 then

gridData.rareGridData=v
elseif gridType==5 then

gridData.eventGridData=v
end
end

local gridGuid=v.gzGuid
gridGuidDataLookup[gridGuid]={gridIdx=gridIdx,data=v,gridType=gridType}
end
end
data.mapData=mapData
data.jdrwScore=jdrwScore
data.pos=posNew
data.xbNum=xbNum
data.freeNum=freeNum
data.gridGuidDataLookup=gridGuidDataLookup

activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:callWindowFunc('UISubAct_shenhaixunbaoWin','refreshByFastUse')


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end