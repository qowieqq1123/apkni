







worldMonsterModel={}

worldMonsterModel.data={}




function worldMonsterModel.get_config()
local id=1
local config=cfg_worldmonsterconfig_get(id)
return config
end


function worldMonsterModel.get_fresh_time_config()
local config=worldMonsterModel.get_config()
return config.freshtime
end


function worldMonsterModel.get_max_num_config()
local config=worldMonsterModel.get_config()
return config.maxnum
end


function worldMonsterModel.get_result_wait_time_config()
local config=worldMonsterModel.get_config()
return config.resultwaittime
end


function worldMonsterModel.get_monster_group_config(worldMonsterId)
local config=cfg_worldmonstergroupconfig_get(worldMonsterId)
return config
end

function worldMonsterModel.get_monster_group(worldMonsterId)
local config=cfg_worldmonstergroupconfig_get(worldMonsterId)
if config then
local id=config.monsterGroupId
local groupConfig=cfg_monstergroup_get(id)
if groupConfig then
return groupConfig
end
end
end


function worldMonsterModel.get_monster_group_List(worldMonsterId)
local config=cfg_worldmonstergroupconfig_get(worldMonsterId)
if config then
local id=config.monsterGroupId
local groupConfig=cfg_monstergroup_get(id)
if groupConfig then
return groupConfig.monList,id
end
end
end


function worldMonsterModel.get_area_config(areaId)
local config=cfg_worldareaconfig_get(areaId)
return config
end


function worldMonsterModel.get_world_pos_config(worldId,blockId)
for i,v in pairs(cfg_worldpositionconfig())do
if v.worldId==worldId and v.blockId==blockId then
return v
end
end
end

function worldMonsterModel:getOpenAreas()
local list={}
local cfg=cfg_worldmonsterareaconfig()
for i,v in pairs(cfg)do
local world=v.worldid
for j,w in ipairs(v.worldpos)do
local block=j
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
table.insert(list,i)
break
end
end
end
return list
end

function worldMonsterModel:checkAreaOpen(areaId)
local cfg=self.get_area_config(areaId)
local world=cfg.worldid
for i,v in ipairs(cfg.worldpos)do
local block=v[1]
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
return true
end
end
return false
end


function worldMonsterModel:init_data()
self.data=
{
freshTimes=0,
lastStamp=0,
monsterList={},
fightList={},

taskData={},
fightingMonsterList={},
battleData={}
}
end

function worldMonsterModel:init_fighting_list()
self.data.fightingMonsterList={}
worldMonsterModel:sort_monster_list()
end



function worldMonsterModel:set_fresh_times(freshTimes)
self.data.freshTimes=freshTimes
end

function worldMonsterModel:get_fresh_times()
return self.data.freshTimes
end



function worldMonsterModel:set_last_stamp(lastStamp)
self.data.lastStamp=lastStamp
end

function worldMonsterModel:get_last_stamp()
return self.data.lastStamp
end


function worldMonsterModel:set_monster_list(len,dataList,isInit)

self.data.monsterList={}
self.data.sortMonsterList={}
self.data.isInit=true
if len<=0 then
return
end





local posList={}
local tempList={}
for i,v in pairs(dataList)do
local areaId=v.areaid
local monsterList=v.monList
for j,worldMonsterData in ipairs(monsterList)do
table.insert(posList,worldMonsterData.guidPos)
table.insert(tempList,{
areaId=areaId,
gwzId=worldMonsterData.gwzId,
gwzLevel=worldMonsterData.gwzLevel,
guidPos=worldMonsterData.guidPos,
})











end
end

worldPositionLibrary:checkData(eWorldUnitTpye.MONSTER,posList)
for i,v in ipairs(tempList)do
local areaId=v.areaId
local worldMonsterId=v.gwzId
local worldMonsterLevel=v.gwzLevel
local worldMonsterPosGuid=v.guidPos
local library=self:findAreaLibrary(areaId)
self:add_monster(areaId,worldMonsterId,true,worldMonsterPosGuid,worldMonsterLevel,library)
end
self:sort_monster_list()
end

function worldMonsterModel:findAreaLibrary(areaId)
local areaConfig=cfgHelper.get1(cfg_worldmonsterareaconfig_get,areaId)
local library={}
for blockid,ids in pairs(areaConfig.worldpos)do
if worldBlockModel:checkBlockState(areaConfig.worldid,blockid,eWorldBlockState.OPEN)then
library=table.concatTableX(library,ids)
end
end
return library
end

function worldMonsterModel:isInit()
return self.data and self.data.isInit==true
end

function worldMonsterModel:clear_monster_list()
for area,areaList in pairs(self.data.monsterList)do
for idx,monster in ipairs(areaList)do
worldPositionLibrary:eraseData(monster.posId)
end
end
self.data.monsterList={}
self.data.sortMonsterList={}
end

function worldMonsterModel:sort_monster_list()
self.data.sortMonsterList={}
for i,v in pairs(self.data.monsterList)do
for a,b in pairs(v)do
self.data.sortMonsterList[#self.data.sortMonsterList+1]=b
end
end

for i,v in pairs(self.data.fightingMonsterList)do
self.data.sortMonsterList[#self.data.sortMonsterList+1]=v
end

local sortFunc=function(a,b)
return self:getMonsterType_ByData(a)>self:getMonsterType_ByData(b)
end
table.sort(self.data.sortMonsterList,sortFunc)
end

function worldMonsterModel:getMonsterType_ByData(data)

local mCfg=worldMonsterModel.get_monster_group(data.worldMonsterId)
if mCfg then
return mCfg.monType
end
return 0
end

function worldMonsterModel:get_monster_sort_list()
return self.data.sortMonsterList
end


function worldMonsterModel:get_unlock_block_monster_list()
local list={}
for i,v in ipairs(self.data.sortMonsterList)do
if v.worldId==0 and v.blockId==0 then
loggerUtil.logErrFMT("无效怪物数据:{0}",serializeHelper.serialize(v))
end
if worldBlockModel:checkBlockState(v.worldId,v.blockId,eWorldBlockState.OPEN)then
table.insert(list,v)
end
end
return list
end

function worldMonsterModel:get_monster_list()
return self.data.monsterList
end

function worldMonsterModel:get_area_monster_list(areaId)
if self.data.monsterList[areaId]then
return self.data.monsterList
end
end

function worldMonsterModel:findSortMonster_ByGUID(guid)
for i,v in ipairs(self.data.sortMonsterList)do
if mathHelper.compareInt64(v.guid,guid)then
return v
end
end
end

function worldMonsterModel:get_monster(guid)









for areaId,list in pairs(self.data.monsterList)do
for idx,monster in pairs(list)do
if tostring(monster.guid)==tostring(guid)then
return monster
end
end
end
end

function worldMonsterModel:get_monster_by_posId(posId)
for areaId,areaData in pairs(self.data.monsterList)do
for i,v in pairs(areaData)do

if v.posId==posId then
return v
end
end
end
end

function worldMonsterModel:get_monster_by_idx(areaId,idx)
if self.data.monsterList[areaId]then
return self.data.monsterList[areaId][idx]
end
end

function worldMonsterModel:get_monster_by_worldMonsterId(id)
for i,v in pairs(self.data.sortMonsterList)do
if v.worldMonsterId==id then
return v
end
end
end

function worldMonsterModel:get_idx(guid)










for areaId,list in pairs(self.data.monsterList)do
for idx,monster in pairs(list)do
if tostring(monster.guid)==tostring(guid)then
return areaId,idx
end
end
end

end



















function worldMonsterModel:remove_monster(areaId,posId,isfighting)
if self.data.monsterList[areaId]then
local areaId,idx=worldMonsterModel:get_idx(posId)

if isfighting then
self.data.fightingMonsterList[tostring(posId)]=self.data.monsterList[areaId][idx]
else
worldPositionLibrary:eraseData(posId)
end
local monsterId=self.data.monsterList[areaId][idx].monsterId
local removeGuid=self.data.monsterList[areaId][idx].guid

self.data.monsterList[areaId][idx]=nil

chatGGModel.changeMonsterData(areaId,posId,monsterId,false)
self:sort_monster_list()
return removeGuid
end
end


function worldMonsterModel:remove_fighting_monster(posId)
worldPositionLibrary:eraseData(posId)
self.data.fightingMonsterList[tostring(posId)]=nil
self:sort_monster_list()
end

function worldMonsterModel:has_monster()
return self.data.sortMonsterList and#self.data.sortMonsterList>0
end

function worldMonsterModel:add_monster(areaId,worldMonsterId,isInit,posGuid,level,library)

self.data.monsterList[areaId]=self.data.monsterList[areaId]or{}
local posId=tostring(posGuid)
local worldId=0
local blockId=0
local x=0
local z=0
local flip=false
local valid=false
if worldPositionLibrary:containData(posGuid)then
local data=worldPositionLibrary:getData(posGuid)
worldId=data.world
x=data.x
z=data.z
flip=data.flip
local v3=nil
v3,blockId=worldPositionConfig:getPosition(worldId,{x,z})
if v3==Vector3.zero then
worldPositionLibrary:eraseData(posGuid)
loggerUtil.logErrFMT("本地存在错误世界怪物旧坐标数据:{0},({1},{2}),{3}",worldId,x,z,posId)
local check,temp=worldPositionLibrary:extract(library)
if check then
local posData=temp[1]
worldId=posData.world
x=posData.x
z=posData.z
flip=posData.flip
local v3=nil
v3,blockId=worldPositionConfig:getPosition(worldId,{x,z})
valid=true
else
loggerUtil.logErrFMT("无效怪物位置抽取，{0}，{1}",serializeHelper.serialize(library),posId)
end
end
else
local check,temp=worldPositionLibrary:extract(library)

if check then
local posData=temp[1]
worldId=posData.world
x=posData.x
z=posData.z
flip=posData.flip
local v3=nil
v3,blockId=worldPositionConfig:getPosition(worldId,{x,z})
valid=true
else
loggerUtil.logErrFMT("无效怪物位置抽取，{0}，{1}",serializeHelper.serialize(library),posId)
end
end
local monster=
{
areaId=areaId,
worldMonsterId=worldMonsterId,
guid=posGuid,
posId=posId,
posData={x,z},
flipX=flip,
level=level,
worldId=worldId,
blockId=blockId,
}
self.data.monsterList[areaId][posId]=monster


if valid then

worldPositionLibrary:markData(worldId,x,z,flip,eWorldUnitTpye.MONSTER,posGuid)
end


if not isInit then
self:sort_monster_list()
end
local num=0
for i,v in pairs(self.data.monsterList[areaId])do
num=num+1
end
chatGGModel.changeMonsterData(areaId,posId,worldMonsterId,true)
return monster
end

function worldMonsterModel:getBlockMonsters(world,block)
local list={}
for areaId,v in pairs(self.data.monsterList)do
for idx,w in pairs(v)do
if w.worldId==world and w.blockId==block then
table.insert(list,w)
end
end
end
return list
end




































































































function worldMonsterModel.get_fresh_time_with_buff()
local configTime=worldMonsterModel.get_fresh_time_config()
local buffAddValue=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eProductWorldMonsterSpaceChanged)or 0
if buffAddValue>100 then

buffAddValue=100
end
local subRate=1-buffAddValue/100
local freshCdTime=configTime*subRate
return freshCdTime
end



function worldMonsterModel:get_fight_team()

local sortType=eDiscipleSortType.eFightSort
local sortCondition={lglist={},joblist={}}
local sortOrder=eSortOrder.eDown
local discipleList=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder)



self.data.fightList={discipleList[1].netData.net.discipleguid}

end


















function worldMonsterModel:send_task_data(areaId,idx,...)
self.data.sendtaskData=self.data.sendtaskData or{}
if areaId and idx then
local key=table.concat({areaId,idx},"-")
self.data.sendtaskData[key]={...}
end
end

function worldMonsterModel:get_send_task_data(areaId,idx)
self.data.sendtaskData=self.data.sendtaskData or{}
if areaId and idx then
local key=table.concat({areaId,idx},"-")
return self.data.sendtaskData[key]
end
end

function worldMonsterModel:set_task_result(posId,posData,fightResult,fightReportStr,areaId,idx,monsterId)
local key=tostring(posId)
if fightResult and fightReportStr then
self.data.taskData[key]={posId,posData,fightResult,fightReportStr,areaId,idx,monsterId}
else
self.data.taskData[key]=nil
end
end

function worldMonsterModel:get_task_result(posId)
local key=tostring(posId)
self.data.taskData=self.data.taskData or{}
return self.data.taskData[key]
end

function worldMonsterModel:set_battle(posId,battleId)
local key=tostring(posId)
self.data.battleData=self.data.battleData or{}
self.data.battleData[key]=battleId
end

function worldMonsterModel:get_battle(posId)
local key=tostring(posId)
self.data.battleData=self.data.battleData or{}
return self.data.battleData[key]
end

function worldMonsterModel:showTaskResult(posId,clearData)
local taskData=self:get_task_result(posId)

if taskData then
local fightResult=taskData[3]
local posData=taskData[2]
local monsterId=taskData[7]
local logIdx=taskData[4]
local logPackage=fightResultModel:getPackageResutl(logIdx)
self:afterFight(fightResult,posId,posData,clearData,
monsterId,logPackage.prizeList or{})
else
if clearData then
self:remove_fighting_monster(posId)
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end
end

end

function worldMonsterModel:afterFight(result,posId,posData,includeData,monsterId,rewards)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,tostring(posId)})
worldHUDModel:UpdateHUDByKey(unitKey)
if result==fightResultType.Victory then
worldUnitModel:unitEmot(unitKey,"#21",1)
worldUnitModel:unitDead(unitKey,rewards,function()
self:set_task_result(posId)
worldMonsterController:remove_monster_unit(posId,posData)
end)
if includeData then
self:remove_fighting_monster(posId)
end
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
else
local afterEmot=function()
worldUnitModel.speMonster(unitKey)
self:set_task_result(posId)
end
worldUnitModel:unitEmot(unitKey,"#12",2)
worldUnitModel:unitAttack(unitKey,2,afterEmot)
end
end

function worldMonsterModel:monsterDead(unitKey,posId,posData,monsterId,rewards)
worldUnitModel:unitDead(unitKey,rewards,function()
worldMonsterController:remove_monster_unit(posId,posData)
end)
end

function worldMonsterModel:monsterEmot(unitKey,emot,cd,callback)
local hudObj=worldHUDModel:getHUD(unitKey)
if hudObj then
hudObj:showEmot(emot,cd,callback)
end
end
