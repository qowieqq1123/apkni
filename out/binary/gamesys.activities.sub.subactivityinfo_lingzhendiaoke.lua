









local subActivityInfo_lingzhendiaoke={name='lingzhendiaoke'}

function subActivityInfo_lingzhendiaoke:onInit()

end

function subActivityInfo_lingzhendiaoke:onStart()

end

function subActivityInfo_lingzhendiaoke:onUpdate()

end

function subActivityInfo_lingzhendiaoke:onDelete()

end

function subActivityInfo_lingzhendiaoke:checkReddot()
local data=self.data
if data then
return self:checkdayreddot()
end
return false
end


function subActivityInfo_lingzhendiaoke:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end


function subActivityInfo_lingzhendiaoke:startActTime()

end



function subActivityInfo_lingzhendiaoke:checkdayreddot()
local data=self.data
if data then
local serverStamp=userActorSetting.get('UILingZhenHHMainWin_oneday',false)
if serverStamp then
local isday=timeHelper.isTodayStamp(timeHelper.convertLongStamp(serverStamp))
return not isday
else
return true
end
end
return false
end

function subActivityInfo_lingzhendiaoke:setdaytime()
local data=self.data
if data then
local nowstamp=timeHelper.getServerShortTime()
userActorSetting.set('UILingZhenHHMainWin_oneday',nowstamp)
userActorSetting.flush()
end
end


function subActivityInfo_lingzhendiaoke:isReceive(id)
return false
end


function subActivityInfo_lingzhendiaoke:getTopScore()
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end
return data.topScore or 0
end


function subActivityInfo_lingzhendiaoke:getLingZhenCamp()
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end
return data.campId or nil
end


function subActivityInfo_lingzhendiaoke:getLingZhenCampScoreDataByCampId(campId)
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end

if data.campDataList and next(data.campDataList)then
return data.campDataList[campId]
end
return nil
end


function subActivityInfo_lingzhendiaoke:getNextUpdateDataTime()
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end

if data.nextUpdateDataTime then
return data.nextUpdateDataTime
end
return nil
end


function subActivityInfo_lingzhendiaoke:getTodayMapData()
if not self.data then
logErr("找不到灵阵碰撞地图列表 mapIdList 字段数据")
return
end
local mapExpireTime_long=timeHelper.getTodayZeroStamp()
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

function subActivityInfo_lingzhendiaoke:getMaxScore()
if not self.data then
logErr("lingzhendiaoke not have data")
return
end

return self.data.maxScore or 0
end

function subActivityInfo_lingzhendiaoke:getQuickFlag()
if not self.data then
logErr("lingzhendiaoke not have data")
return
end

return self.data.sdFlag==1
end



function subActivityInfo_lingzhendiaoke:setLingZhenPengZhuangGameData(createList,itemList,combineList,selectQueue,recordList,skillCount,score,mapExpireTime,selectMapId)
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


function subActivityInfo_lingzhendiaoke:clearLingZhenPengZhuangGameData()
if not self.data or not self.data.gameData then
return
end
self.data.gameData=nil
end


function subActivityInfo_lingzhendiaoke:getLingZhenPengZhuangGameData()
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


function subActivityInfo_lingzhendiaoke:saveLingZhenPengZhuangGameData()
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end

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

local _key=FMT.fmt('actid{0}_subid{1}_time{2}_lzpz',self.act_id,self.sub_act_type,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.elingZhenPengZhuang,_key,saveData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.elingZhenPengZhuang)
end



function subActivityInfo_lingzhendiaoke:loadLingZhenPengZhuangGameData()
if not self.data then
return
end
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end

local _key=FMT.fmt('actid{0}_subid{1}_time{2}_lzpz',self.act_id,self.sub_act_type,self.sub_act_id)
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.elingZhenPengZhuang,_key,{})
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


function subActivityInfo_lingzhendiaoke:test_clearLingZhenPengZhuangGameData()
if not self.data then
return
end
self.data.gameData=nil
local data=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
if data==nil then return end

local _key=FMT.fmt('actid{0}_subid{1}_time{2}_lzpz',self.act_id,self.sub_act_type,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLZPZGameData,_key,nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLZPZGameData)
end


return subActivityInfo_lingzhendiaoke