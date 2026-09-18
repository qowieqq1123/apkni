






local _MODULENAME="worldDailyEventModel"




def_table(_MODULENAME)
worldDailyEventModel.name=_MODULENAME




function worldDailyEventModel:onAppStart()

end


function worldDailyEventModel:onEnterState()
self.data={}
self.data.eventData={}
end


function worldDailyEventModel:onLeaveState(isReconnet)

self.data={}
self.data.eventData={}
if not isReconnet then

end
end


function worldDailyEventModel:onServerDataInitFinish()

end

function worldDailyEventModel:onReConnection()

end

function worldDailyEventModel:initEventData()
local eventList=MysteryEventListModel:get_eventList_by_sys(SYSTEM_DEFINE.eWorldDailyQiYuEvent)
local guidList={}
if eventList then
for i,v in pairs(eventList)do
local addFlag=self:onNewEventData(v)
if addFlag then
table.insert(guidList,tostring(v.guid))
end
end
end
worldPositionLibrary:checkData(eWorldUnitTpye.DAILYEVENT,guidList)
end

function worldDailyEventModel:onNewEventDataList(eventList)
if eventList then
for i,v in pairs(eventList)do
self:onNewEventData(v)
end
end
end

function worldDailyEventModel:onNewEventData(eventItem)
local guid=tostring(eventItem.guid)
self.data.eventData[guid]=eventItem
return worldDailyEventModel:add_daily_event_unit(guid)
end

function worldDailyEventModel:onEventFinish(eventGuid)
local guid=tostring(eventGuid)
self.data.eventData[guid]=nil

if worldController:isInWorld()then
worldDailyEventModel:hideUnitImp(guid)
end
end

function worldDailyEventModel:getEventDataId(eventGuid)
local guid=tostring(eventGuid)
if self.data.eventData[guid]then
return self.data.eventData[guid].otherData.id
end
end

function worldDailyEventModel:getEventDataByType(evtType)
local evtList={}
if self.data.eventData then
for i,v in pairs(self.data.eventData)do
if v.otherData.evtType==evtType then
table.insert(evtList,v)
end
end
end
return evtList
end

function worldDailyEventModel:getEventDataByGuid(eventGuid)
local guid=tostring(eventGuid)
if self.data.eventData[guid]then
return self.data.eventData[guid]
end
end


function worldDailyEventModel:getEventData()
return self.data.eventData
end

function worldDailyEventModel:add_daily_event_unit(guid)
local addFlag=true
local id=worldDailyEventModel:getEventDataId(guid)
if not id then

return false
end
local areaCfg=cfgHelper.get(cfg_bigworlddailyqiyueventconfig_get,id)
local worldId=nil
local blockId=nil
local posGuid=tostring(guid)
local unit=self:get_world_unit(posGuid)
local position,x,z,flip
local checkGuid=worldPositionLibrary:containData(posGuid)
local valid=true
if checkGuid then
valid=false
local data=worldPositionLibrary:getData(posGuid)
x=data.x
z=data.z
flip=data.flip
worldId=data.world
position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then

if position~=Vector3.zero then
if not unit then
self:add_world_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.DAILYEVENT,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
return true
else
loggerUtil.logErrFMT("本地存在错误秘境旧坐标数据:{0},({1},{2}),{3}",worldId,x,z,tostring(posGuid))
worldPositionLibrary:eraseData(posGuid)
addFlag=false
end
else
addFlag=false
end
end
local randomPos=areaCfg.worldpos
local posList={}
for worldId,v in pairs(randomPos)do
for i,v2 in ipairs(v)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v2)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v2)
end
end
end

if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

else
valid=false
flip=false
x=0
z=0

addFlag=false
end
else
valid=false
flip=false
x=0
z=0

addFlag=false
end

if not worldId then
return false
end
if not unit then
self:add_world_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.DAILYEVENT,posGuid)
end

local name=cfgHelper.get2(cfg_worldconfig_get,worldId,'name')

chatControl.addJianWenMesg(CHAT_MSG_TYPE.eDailyEvent,FMT.fmt(cfgHelper.getlang("daily_event"),name,guid),nil)
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
return addFlag
end

function worldDailyEventModel:showUnitImp(posGuid,cfg,world,x,z,flip)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.DAILYEVENT,posGuid})
local modelSettings=worldModel:getModelSettings(cfg.modelRes,eWorldUnitTpye.DAILYEVENT)
local hudSettings=worldModel:getHUDSetting(cfg.hudRes)
local luaData={eWorldUnitTpye.DAILYEVENT,posGuid}
local position=worldPositionConfig:getPosition(world,{x,z})
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
worldController:setUnitFlipX(unitKey,flip or false)
end

function worldDailyEventModel:hideUnitImp(posGuid)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.DAILYEVENT,tostring(posGuid)})
worldController:popUnit(unitKey)
end

function worldDailyEventModel:add_world_unit(posGuid,worldId,x,z,blockId,flip)
self.data.unitList=self.data.unitList or{}
self.data.unitList[posGuid]={worldId,x,z,blockId,flip}
end

function worldDailyEventModel:get_world_unit(posGuid)
return self.data.unitList and self.data.unitList[posGuid]
end

function worldDailyEventModel:del_world_unit(posGuid)
local guid=tostring(posGuid)

if self.data.unitList then
self.data.unitList[guid]=nil
worldPositionLibrary:eraseData(guid)
end

end

function worldDailyEventModel:clear_all_unit_count()
if self.data.unitList then
if worldController:isInWorld()then
for posGuid,v in pairs(self.data.unitList)do
worldDailyEventModel:hideUnitImp(posGuid)
end
end
self.data.unitList={}
end
end

function worldDailyEventModel:get_unit_key(exguid)
if self.data.unitList then
local world=worldModel.world
local guidList={}
for guid,v in pairs(self.data.unitList)do
if world==v[1]then
table.insert(guidList,guid)
end
end
if#guidList>1 and exguid then
local remove=nil
for i,v in ipairs(guidList)do
if v==exguid then
remove=i
break
end
end
if remove then
table.remove(guidList,remove)
end
end
if#guidList>0 then
local key=math.random(1,#guidList)
return guidList[key]
else
return next(self.data.unitList)
end

end
end

function worldDailyEventModel:get_unit_count()
local num=0
if self.data.unitList then
for i,v in pairs(self.data.unitList)do
num=num+1
end
end
return num
end


function worldDailyEventModel:onWorldPositionReRandom(rData,aData)



local id=worldDailyEventModel:getEventDataId(rData.key)
if not id then
loggerUtil.logErrFMT("取不到事件id",rData.key)
return
end
local areaCfg=cfgHelper.get(cfg_bigworlddailyqiyueventconfig_get,id)
local posGuid=rData.key
local worldId=nil
local blockId=nil
local unit=self:get_world_unit(posGuid)
local position,x,z,flip

local checkGuid=worldPositionLibrary:containData(posGuid)
local valid=true
if checkGuid then

worldPositionLibrary:eraseData(posGuid)
end
local randomPos=areaCfg.worldpos
local posList={}
for worldId,v in pairs(randomPos)do
for i,v2 in ipairs(v)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v2)
local world=cfg.world
local block=cfg.blockId
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(posList,v2)
end
end
end

if next(posList)then
local check,temp=worldPositionLibrary:extract(posList)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
worldId=temp[1].world

position,blockId=worldPositionConfig:getPosition(worldId,{x,z})

else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("日常事件{0}坐标随机库抽取失败,GUID:{1}",id,tostring(posGuid))
end
else
valid=false
flip=false
x=0
z=0
loggerUtil.logErrFMT("日常事件{0}坐标随机库无已解锁坐标,GUID:{1}",id,tostring(posGuid))
end

if not worldId then
return
end
if not unit then
self:add_world_unit(posGuid,worldId,x,z,blockId,flip)
if valid then
worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.DAILYEVENT,posGuid)
end
end
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(worldId)then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
self:showUnitImp(posGuid,areaCfg,worldId,x,z,flip)
end
end
end
