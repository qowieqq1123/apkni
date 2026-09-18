






local _MODULENAME="lingZhenPengZhuangModel"


def_table(_MODULENAME)
lingZhenPengZhuangModel.name=_MODULENAME
lingZhenPengZhuangModel.data={}

function lingZhenPengZhuangModel:onAppStart()

end


function lingZhenPengZhuangModel:onEnterState(isReconnect)

lingZhenPengZhuangModel:loadLingZhenPengZhuangGameData()
end


function lingZhenPengZhuangModel:onProtocolReq()

end


function lingZhenPengZhuangModel:onLeaveState(isReconnect)

lingZhenPengZhuangModel:saveLingZhenPengZhuangGameData()

self.data={}
end


function lingZhenPengZhuangModel:setIsInit(flag)
self.data.isInit=flag
end

function lingZhenPengZhuangModel:checkIsInit()
if self.data and self.data.isInit then
return true
end
return false
end

function lingZhenPengZhuangModel:setReceiveFlag(flag)
self.data.receiveFlag=flag
end

function lingZhenPengZhuangModel:isReceive(id)
if self.data.receiveFlag then
return bitHelper.check_pos(self.data.receiveFlag,id-1)
end

return false
end

function lingZhenPengZhuangModel:setTopScore(score)
self.data.topScore=score
end

function lingZhenPengZhuangModel:getTopScore()
return self.data.topScore or 0
end


function lingZhenPengZhuangModel:setLingZhenCamp(campId)
if campId~=0 then
self.data.campId=campId
end
end


function lingZhenPengZhuangModel:getLingZhenCamp()
return self.data and self.data.campId or nil
end


function lingZhenPengZhuangModel:setLingZhenCampScoreData(len,dataList)
self.data.campDataList={}
local nowTime=timeHelper.getServerShortTime()
local nextUpdateTime=nowTime+3600
if len>0 then
for i,v in ipairs(dataList)do
local campData={}
local campId=v.param_1
campData.id=campId
campData.score=v.param_2
campData.lastUpdateTime=v.param_3
campData.nextUpdateTime=nextUpdateTime
self.data.campDataList[campId]=campData
end
end
end


function lingZhenPengZhuangModel:getLingZhenCampScoreDataByCampId(campId)
if self.data and self.data.campDataList and next(self.data.campDataList)then
return self.data.campDataList[campId]
end
return nil
end

function lingZhenPengZhuangModel:setNextUpdateDataTime()

local updateLongTime=timeHelper.getTodayZeroStamp()+15*60
local nowTime=timeHelper.getServerLongTime()
if updateLongTime<nowTime then
updateLongTime=updateLongTime+86400
end
self.data.nextUpdateDataTime=timeHelper.convertShortStamp(updateLongTime)
end

function lingZhenPengZhuangModel:getNextUpdateDataTime()
if self.data and self.data.nextUpdateDataTime then
return self.data.nextUpdateDataTime
end
return nil
end


function lingZhenPengZhuangModel:getTodayMapData()
local mapExpireTime_long=timeHelper.getTodayZeroStamp()+15*60
local nowTime=timeHelper.getServerLongTime()
if mapExpireTime_long<nowTime then
mapExpireTime_long=mapExpireTime_long+86400
end
local mapExpireTime=timeHelper.convertShortStamp(mapExpireTime_long)
local mapId


local mapIdList=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"mapIdList")or{}
local mapCount=#mapIdList
if mapCount>0 then
local day=math.ceil(mapExpireTime/86400)
local mapIndex=day%mapCount
if mapIndex==0 then
mapIndex=mapCount
end
mapId=mapIdList[mapIndex]
else
logErr("找不到灵阵碰撞地图列表 mapIdList 字段数据")
end

return mapId,mapExpireTime
end



function lingZhenPengZhuangModel:setLingZhenPengZhuangGameData(createList,itemList,combineList,selectQueue,recordList,skillCount,score,mapExpireTime,selectMapId)
self.data.gameData={}
self.data.gameData.createList=createList
self.data.gameData.itemDataList={}

for id,data in pairs(itemList)do
local index=data.index
local layer=data.layer
local itemData={
x=data.x,
y=data.y,
val=data.val,
index=data.index,
layer=data.layer,
}
if not self.data.gameData.itemDataList[layer]then
self.data.gameData.itemDataList[layer]={}
end
self.data.gameData.itemDataList[layer][index]=itemData
end

local posIdxList_lookup={}
for posIdx,data in pairs(combineList)do
local id=data.id
posIdxList_lookup[id]=posIdx
end

for i,data in ipairs(selectQueue)do
local id=data.id
local posIdx=posIdxList_lookup[id]
if posIdx then
local index=data.index
local layer=data.layer
local itemData={
x=data.x,
y=data.y,
val=data.val,
index=data.index,
layer=data.layer,
isSelect=true,
posIdx=posIdx,
selectIdx=i,
}
if not self.data.gameData.itemDataList[layer]then
self.data.gameData.itemDataList[layer]={}
end
self.data.gameData.itemDataList[layer][index]=itemData
end
end

for id,data in pairs(recordList)do
local index=data.index
local layer=data.layer
local itemData={
x=data.x,
y=data.y,
val=data.val,
index=data.index,
layer=data.layer,
isRecordItem=true,
}
if not self.data.gameData.itemDataList[layer]then
self.data.gameData.itemDataList[layer]={}
end
self.data.gameData.itemDataList[layer][index]=itemData
end


self.data.gameData.skillUseCount=skillCount

self.data.gameData.score=score

self.data.gameData.mapExpireTime=mapExpireTime

self.data.gameData.selectMapId=selectMapId
end


function lingZhenPengZhuangModel:clearLingZhenPengZhuangGameData()
if not self.data or not self.data.gameData then
return
end

self.data.gameData=nil
end


function lingZhenPengZhuangModel:getLingZhenPengZhuangGameData()
if not self.data or not self.data.gameData then
return nil
end


local mapExpireTime=self.data.gameData.mapExpireTime or 0
local nowTime=timeHelper.getServerShortTime()
if nowTime>mapExpireTime then

return nil
end

return self.data.gameData
end


function lingZhenPengZhuangModel:saveLingZhenPengZhuangGameData()
local gameData=self.data.gameData
local saveData={}
if gameData and next(gameData)then
saveData.createList=gameData.createList
saveData.skillUseCount=gameData.skillUseCount
saveData.score=gameData.score
saveData.mapExpireTime=gameData.mapExpireTime
saveData.selectMapId=gameData.selectMapId

local saveItemDataList={}
local itemDataList=gameData.itemDataList
if itemDataList then
for layer,itemList in pairs(itemDataList)do
local layerStr=tostring(layer)
if not saveItemDataList[layerStr]then
saveItemDataList[layerStr]={}
end
for index,data in pairs(itemList)do
local indexStr=tostring(index)
saveItemDataList[layerStr][indexStr]=data
end
end
end
saveData.itemDataList=saveItemDataList
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eLZPZGameData,'lingZhenPengZhuangGameData',saveData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLZPZGameData)
end



function lingZhenPengZhuangModel:loadLingZhenPengZhuangGameData()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLZPZGameData,'lingZhenPengZhuangGameData',{})
local gameData={}
if saveData and next(saveData)then
gameData.createList=saveData.createList
gameData.skillUseCount=saveData.skillUseCount
gameData.score=saveData.score
gameData.mapExpireTime=saveData.mapExpireTime
gameData.selectMapId=saveData.selectMapId

local gameItemDataList={}
local itemDataList=saveData.itemDataList
if itemDataList then
for layerStr,itemList in pairs(itemDataList)do
local layer=tonumber(layerStr)
if not gameItemDataList[layer]then
gameItemDataList[layer]={}
end
for indexStr,data in pairs(itemList)do
local index=tonumber(indexStr)
gameItemDataList[layer][index]=data
end
end
end
gameData.itemDataList=gameItemDataList
end
self.data.gameData=gameData
end


function lingZhenPengZhuangModel:test_clearLingZhenPengZhuangGameData()
self.data.gameData=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLZPZGameData,'lingZhenPengZhuangGameData',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLZPZGameData)
end