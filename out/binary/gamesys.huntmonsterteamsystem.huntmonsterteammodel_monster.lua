local _monsterHandle={
[eWorldUnitTpye.MONSTER]={
getData=function(this,param1)
return worldMonsterModel:get_monster_by_posId(param1)
end,
getConfig=function(this,param1)
local monsterData=this:getData(param1)
local worldMonsterId=monsterData.worldMonsterId
return cfgHelper.get1(cfg_worldmonstergroupconfig_get,worldMonsterId)
end,
getMonsterConfig=function(this,param1)
local worldMonsterCfg=this:getConfig(param1)
return cfgHelper.get1(cfg_monstergroup_get,worldMonsterCfg.monsterGroupId)
end,
getCost=function(this,param1)
local worldMonsterCfg=this:getConfig(param1)
return worldMonsterCfg.cost
end,
getMonsterType=function(this,param1)
local monsterCfg=this:getMonsterConfig(param1)
return monsterCfg.monType
end,
getMonsterLevel=function(this,param1)
local monsterCfg=this:getMonsterConfig(param1)
local monsterData=this:getData(param1)
return monsterCfg.levelUp and monsterData.level or monsterCfg.level or 1
end,
getMonsterReward=function(this,param1)
local monsterCfg=this:getMonsterConfig(param1)
local level=this:getMonsterLevel(param1)
return worldFightModel:getMonsterShowAwardsEx(monsterCfg,level)
end,
getFightData=function(this,param1)
local monsterData=this:getData(param1)
return eBattleLaunch.worldMonster,monsterData.areaId,int64.new(param1)
end,
afterVictory=function(this,param1)
local monsterData=this:getData(param1)
worldMonsterController.remove_monster(monsterData.areaId,param1,false)
if worldController:isInWorld()then
worldMonsterController:remove_monster_unit(param1)
end
end,
getPosition=function(this,param1)
local monsterData=this:getData(param1)
local position,block=worldPositionConfig:getPosition(monsterData.worldId,monsterData.posData)
return position,block,monsterData.worldId
end,
},
[eWorldUnitTpye.RESPOINT]={
getData=function(this,param1,param2)
param2=tonumber(param2)
return worldResPointDataModel:getSubPointData(param1,param2)
end,
getConfig=function(this,param1,param2)
local resData=this:getData(param1,param2)
return cfgHelper.get1(cfg_worldresbattleconfig_get,resData[2])
end,
getMonsterConfig=function(this,param1,param2)
local config=this:getConfig(param1,param2)
return cfgHelper.get1(cfg_monstergroup_get,config.groupid)
end,
getCost=function(this,param1,param2)
local config=this:getConfig(param1,param2)
return config.cost
end,
getMonsterType=function(this,param1,param2)
local monsterCfg=this:getMonsterConfig(param1,param2)
return monsterCfg.monType
end,
getMonsterLevel=function(this,param1,param2)
local monsterCfg=this:getMonsterConfig(param1,param2)
local resData=worldResPointDataModel:getPointData(param1)
return monsterCfg.levelUp and resData.level or monsterCfg.level or 1
end,
getMonsterReward=function(this,param1,param2)
local monsterCfg=this:getMonsterConfig(param1,param2)
local level=this:getMonsterLevel(param1,param2)
return worldFightModel:getMonsterShowAwardsEx(monsterCfg,level)
end,
getFightData=function(this,param1,param2)
local resData=worldResPointDataModel:getPointData(param1)
return eBattleType.worldResPoint,resData.world,int64.new(param1),tonumber(param2)
end,
afterVictory=function(this,param1,param2)
local subIdx=tonumber(param2)
worldResPointDataModel:clearSubPointData(param1,subIdx)
if worldController:isInWorld()then
worldResPointController:hideResPointUnitEx(param1,subIdx)
end
end,
getPosition=function(this,param1,param2)
local posData=worldResPointDataModel:getSubPointPos(param1,tonumber(param2))
local resData=worldResPointDataModel:getPointData(param1)
local position,block=worldPositionConfig:getPosition(resData.world,posData)
return position,block,resData.world
end,
},
}

function huntMonsterTeamModel:checkMonsterDataExist(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getData(handle,params[2],params[3])~=nil
end

function huntMonsterTeamModel:doAfterFightVictory(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.afterVictory(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterGroupConfig(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getMonsterConfig(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterDataCost(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getCost(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterDataMonType(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getMonsterType(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterDataLevel(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getMonsterLevel(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterDataRewards(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getMonsterReward(handle,params[2],params[3])
end

function huntMonsterTeamModel:getMonsterDataFightParam(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getFightData(handle,params[2],params[3])
end

function huntMonsterTeamModel:calculuteMonstersMaxLevel(monsterKeys)
local level=-1
for i,v in ipairs(monsterKeys)do
local lv=self:getMonsterDataLevel(v)
level=math.max(level,lv)
end
return level
end

function huntMonsterTeamModel:calculateMonstersDuration(monsterKeys)
local duration=0
local cfg=cfgHelper.get2(cfg_huntmonsterteambaseconfig_get,1,"duration")
for i,v in ipairs(monsterKeys)do
local mType=self:getMonsterDataMonType(v)
local d=(cfg[mType]or 1)
duration=duration+d
end
return duration
end

function huntMonsterTeamModel:calculateMonstersCost(monsterKeys,moneyType)
local num=0
for i,v in ipairs(monsterKeys)do
local costCfg=self:getMonsterDataCost(v)
if costCfg then
for j,w in ipairs(costCfg)do
if w[1]==moneyType then
num=num+w[2]
end
end
end
end
return num
end

function huntMonsterTeamModel:calculateMonstersRewards(monsterKeys,isDetail)
local count=#monsterKeys
local lookup={}
for i,v in ipairs(monsterKeys)do
local shows,detail=self:getMonsterDataRewards(v)
local items=isDetail and detail or shows
for j,w in ipairs(items)do
if not lookup[w[1]]then
if w[2]~=0 then
lookup[w[1]]=w[2]
end
elseif lookup[w[1]]>0 then
if w[2]>0 then
lookup[w[1]]=lookup[w[1]]+w[2]
elseif w[2]<0 then
lookup[w[1]]=w[2]
end
end
end
end
local list={}
if count>0 then
for itemid,itemnum in pairs(lookup)do
table.insert(list,{itemid,itemnum})
end
table.sort(list,function(a,b)
local colorA=itemsConfig.getItemColor(a[1])
local colorB=itemsConfig.getItemColor(b[1])
if colorA~=colorB then
return colorA>colorB
else
return a[1]>b[1]
end
end)
end
return list
end

function huntMonsterTeamModel:calculateMonstersActRewards(monsterKeys)
local lookup={}
for subType,_ in pairs(MONSTER_EXTRA_DROP_ACTIVITIES)do
local subActs=activitiesModel:getActSubList_subType_doing(subType)
for index,subAct in ipairs(subActs)do
local dropCfg=subAct:getSubActConfig("drop")
local dropsCfg=subAct:getSubActConfig("drops")
if dropsCfg~=nil and#dropsCfg>0 then
dropCfg=dropsCfg[2][1]
end
for index,monsterKey in ipairs(monsterKeys)do
local mCfg=self:getMonsterGroupConfig(monsterKey)
if mCfg.monClass and dropCfg[mCfg.monClass]then

if mCfg.monType and dropCfg[mCfg.monClass][mCfg.monType]then
local dropId=dropCfg[mCfg.monClass][mCfg.monType]
local exDropItemList=zongmenControl:getRewardConfigData(dropId,zongmenModel:getLevel())
if exDropItemList then
for j,w in ipairs(exDropItemList)do
if not lookup[w[1]]then
if w[2]~=0 then
lookup[w[1]]=w[2]
end
elseif lookup[w[1]]>0 then
if w[2]>0 then
lookup[w[1]]=lookup[w[1]]+w[2]
elseif w[2]<0 then
lookup[w[1]]=w[2]
end
end
end
end
end
end
end
end
end
local list={}
for itemid,itemnum in pairs(lookup)do
table.insert(list,{itemid,itemnum})
end
table.sort(list,function(a,b)
local colorA=itemsConfig.getItemColor(a[1])
local colorB=itemsConfig.getItemColor(b[2])
if colorA~=colorB then
return colorA>colorB
else
return a[1]>b[1]
end
end)
return list
end

function huntMonsterTeamModel:checkMonsterDataList(monsterKeys)
local list={}
for i,v in ipairs(monsterKeys)do
if self:checkMonsterDataExist(v)then
table.insert(list,v)
end
end
table.sort(list,self.sortMonsterList)
return list
end

function huntMonsterTeamModel.sortMonsterList(keyA,keyB)
local scoreA=huntMonsterTeamModel:getMonsterDataMonType(keyA)*10000+huntMonsterTeamModel:getMonsterDataLevel(keyA)
local scoreB=huntMonsterTeamModel:getMonsterDataMonType(keyB)*10000+huntMonsterTeamModel:getMonsterDataLevel(keyB)
return scoreA>scoreB
end

function huntMonsterTeamModel:getMonsterPosition(unitKey)
local params=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(params[1])
local handle=_monsterHandle[unitType]
return handle.getPosition(handle,params[2],params[3])
end