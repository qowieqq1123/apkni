







local _cdLookup={}


xjMonsterType={
eNormal=1,
eBoss=2,
}

xjMonsterHUDBg={
[1]="image_xjbs_mowu2",
[2]="image_xjbs_mowu3",
[3]="image_xjbs_mowu4",
[4]="image_xjbs_mowu5",
[5]="image_xjbs_mowu5",
[6]="image_xjbs_mowu5",
[7]="image_xjbs_mowu5",
[16]="image_xjbs_mowu5",
[17]="image_xjbs_mowu5",
}

local _xjMonsterSeasonCheck={
[xjServerEnityType.eMonster]={0,2},
[xjServerEnityType.eBossMonster]={0,5},
[xjServerEnityType.eMonsterHouse]={0,6},

[xjServerEnityType.eMoJieMoZong_Small]={0,5},
[xjServerEnityType.eMoJieMoZong_Big]={0,6},
}

local _teamInfoCacheTime=5*60
local _monsterRewardTimes={}

function xianjieModel:clearData_monster()
local lp=self.allMonsterDatas
if lp then
for infoguid_str,monsterData in pairs(lp)do
xianjieController:removeXJClass(monsterData)
end
self.allMonsterDatas=nil
self.MJboxDatas=nil
self.BXgatherLookup=nil
self:clearLimitNotOpenMonsterData()
end
end

function xianjieModel:initAllMonsterDatas()
xianjieModel:clearData_monster()
self.allMonsterDatas={}
self.MJboxDatas={}
self.BXgatherLookup={}
end

function xianjieModel:refreshMonsterData(v,isInit)









local infoguid_str=tostring(v.infoguid)
local nowtime=timeHelper.getServerShortTime()
local isExpire=v.infoid~=0 and v.expiresec and v.expiresec>0 and nowtime>=v.expiresec
v.isExpire=isExpire
if isInit then
if v.infoid~=0 then
v.infoguid_str=infoguid_str
local monsterData=xianjieController:createXJClass(xjDataType.eMonster,v)
self.allMonsterDatas[infoguid_str]=monsterData
local isPassLimit=xianjieHelper.checkMonsterLimitCND(monsterData)
if isPassLimit then

xianjieModel:setMJboxData(infoguid_str,v.entitytype,v)
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
xianjieModel:setMonsterCDLookup(monsterData)
else

xianjieModel:setLimitNotOpenMonsterData(monsterData)
end
else



end
else
if v.infoid~=0 then
local monsterData_=self.allMonsterDatas[infoguid_str]
if monsterData_==nil then
v.infoguid_str=infoguid_str
local monsterData=xianjieController:createXJClass(xjDataType.eMonster,v)
self.allMonsterDatas[infoguid_str]=monsterData
local isPassLimit=xianjieHelper.checkMonsterLimitCND(monsterData)
if isPassLimit then
xianjieModel:setMJboxData(infoguid_str,v.entitytype,v)
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
if not isExpire then
if v.entitytype==xjServerEnityType.eMoJieShangGuMoster then
monsterData:createEntity(true,v.entitytype)
elseif v.entitytype==xjServerEnityType.eMoJieBox then
monsterData:createEntity(true,v.entitytype)
else
monsterData:createEntity(true)
end
end
xianjieModel:setMonsterCDLookup(monsterData)
xianjieController:invokeEntityFunc(monsterData.ent_key,'showEffect')
notifySystem:postNotify(notifyConfig.onXianJieMonsterChange,CHANGE_TYPE.eAdd,monsterData.infoguid)
else

xianjieModel:setLimitNotOpenMonsterData(monsterData)
end
else
monsterData_:refreshData(v)
local isPassLimit=xianjieHelper.checkMonsterLimitCND(monsterData_)
if isPassLimit then
xianjieModel:setMJboxData(infoguid_str,v.entitytype,v)
monsterData_:refreshEntity()
notifySystem:postNotify(notifyConfig.onXianJieMonsterChange,CHANGE_TYPE.eChanged,monsterData_.infoguid)
end
end
else

local monsterData=self.allMonsterDatas[infoguid_str]
local isLimit=xianjieModel:checkMonsterNotOpenData(monsterData.infoguid)~=nil
if isLimit then
xianjieModel:removeLimitNotOpenMonsterData(monsterData.infoguid)
end
if monsterData~=nil and not isLimit then
local m_ID=monsterData.m_ID
local infoguid=monsterData.infoguid
local sceneidx=monsterData.sceneidx

monsterData:removeEntity(true)
xianjieController:removeXJClass(monsterData)
self.allMonsterDatas[infoguid_str]=nil
xianjieModel:clearMJboxData(infoguid_str)


xianjieModel:clearJiJieDirtyDataByGuid(infoguid,sceneidx)
xianjieModel:setGuid2EntityType(infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieMonsterChange,CHANGE_TYPE.eDelete,infoguid)
else



end
end
end
end

function xianjieModel:getAllMonsterData()
return self.allMonsterDatas
end

function xianjieModel:getMonsterData(infoguid)
if self.allMonsterDatas then
local infoguid_str=tostring(infoguid)
return self.allMonsterDatas[infoguid_str]
end
end

function xianjieModel:getMonsterDataEx(infoguid_str)
if self.allMonsterDatas then
return self.allMonsterDatas[infoguid_str]
end
end

function xianjieModel:createAllMonsterEnities(needRefreshAOI)
local lp=self.allMonsterDatas
if lp then
for infoguid_str,monsterData in pairs(lp)do
monsterData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllMonsterEnities()
local lp=self.allMonsterDatas
if lp then
for infoguid_str,monsterData in pairs(lp)do
if monsterData.removeEntity then
monsterData:removeEntity()
else
logErr("存在被重置的实体数据",infoguid_str)
end
end
end
end



function xianjieModel:findMonsterByDistance(raduis)
local zmpos,sceneidx=xianjieModel:getZongMenWorldPos()
local list={}
if xianjieModel:checkSceneIndex(sceneidx)then
raduis=raduis or 100
local raduis_=raduis*xianjieController:getMapGridSize()

local pos=Vector2(zmpos.x,zmpos.z)
local size=Vector2(raduis_*2,raduis_*2)
local keys=xianjieController:findEnitys(pos,size)
for i=0,keys.Count-1 do
local ent=xianjieController:getEntity(keys[i])
if ent and ent.entityType==XJ_ENTITY_TYPE.eMonster then
table.insert(list,ent.infoguid)
end
end
end
return list
end

function xianjieModel:clearMonsterTeamInfo()
if self.allMonsterTeamInfos then
self.allMonsterTeamInfos=nil
end
end

function xianjieModel:initMonsterTeamInfo()
self.allMonsterTeamInfos={}
end

function xianjieModel:saveMonsterTeamInfo(infoguid,teamInfos)
if self.allMonsterTeamInfos and teamInfos then
local guidStr=tostring(infoguid)
local list={}
for i,v in ipairs(teamInfos)do
if v.marchguid>0 then
local marchData=xianjieModel:getMarchTeamData(v.marchguid)
if marchData then
local teamHandle=marchData:getTeamHandle()
if teamHandle then
table.insert(list,v)
end
end
else
table.insert(list,v)
end
end
self.allMonsterTeamInfos[guidStr]={
data=list,
time=timeHelper.getServerShortTime()+_teamInfoCacheTime,
}
end
end

function xianjieModel:readMonsterTeamInfo(infoguid)
if self.allMonsterTeamInfos then
local guidStr=tostring(infoguid)
return self.allMonsterTeamInfos[guidStr]
end
end

function xianjieModel:checkMonsterTeamInfoCacheValid(infoguid)
local teamInfo=self:readMonsterTeamInfo(infoguid)
if teamInfo then
local nowTime=timeHelper.getServerShortTime()
return nowTime<teamInfo.time
end
return false
end

function xianjieModel:dirtyAllMonsterTeamInfoCacheValid()
if self.allMonsterTeamInfos then
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(self.allMonsterTeamInfos)do
v.time=nowTime
end
end
end

function xianjieModel:setMonsterRewardTimes(timesList)
table.clear(_monsterRewardTimes)
for i,v in ipairs(timesList)do
_monsterRewardTimes[v.param_1]=v.param_2
end
end

function xianjieModel:getMonsterRewardTimes(entityType,flag)
flag=flag or 0
local key=bit.lshift(flag,8)+entityType
return _monsterRewardTimes[key]or 0
end

function xianjieModel:setMonsterRewardTime(key,times)
_monsterRewardTimes[key]=times
end

function xianjieModel:onMonsterRewardTimeDayUp(rType)
for key,times in pairs(_monsterRewardTimes)do
local info=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",rType,key)
if info then
local day=info[1]
local max=info[2]
local cur=math.max(times-day,-max)
self:setMonsterRewardTime(key,cur)
end
end
end

function xianjieModel:getMonsterInfoCfg(entityType)
local infolist=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"info")
for k,v in ipairs(infolist)do
for a,b in pairs(v)do
if a==entityType then
return b
end
end
end
return nil
end


function xianjieModel:getMonsterSeasonCheck(entityType)
return _xjMonsterSeasonCheck[entityType]
end

function xianjieModel:checkWantedMonsterTeamCount(many)
return zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eLaoYu,true)and systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)and UIPrisonModel:getMoYuLockState()and UIPrisonModel:checkEmptyRoomNum(ePrisonRoomType.eMonster,many)and not xianjieModel:checkFuncRewardRecvMonsterLog(item_funtion_type.eMoWuDrop,0)
end

function xianjieModel:getWantedMonsterTeamCount()
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eLaoYu,true)and systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)and UIPrisonModel:getMoYuLockState()and not xianjieModel:checkFuncRewardRecvMonsterLog(item_funtion_type.eMoWuDrop,0)then
return UIPrisonModel:getEmptyRoomNum(ePrisonRoomType.eMonster)
end
return 0
end




function xianjieModel:onNormalUpdate_Monster(delay)
local datas=xianjieModel:getMonsterCDLookup()

for key,flag in pairs(datas)do
local data=xianjieController:getXJClass(key)
if data then
self:onNormalUpdate_MonsterImp(data)
end
end
end

function xianjieModel:onNormalUpdate_MonsterImp(data)
if not data.updataError and data.pcallUpdateExcuteFunc then
xpcall(data.pcallUpdateExcuteFunc,data.pcallUpdateCatchError)
end
end

function xianjieModel:getMonsterCDLookup()
return _cdLookup
end

function xianjieModel:setMonsterCDLookup(rpData)
local flag=0

if rpData.expiresec and rpData.expiresec>0 then
flag=mathHelper.setbit(flag,0)
end

if flag>0 then
_cdLookup[rpData.m_ID]=flag
if rpData.pcallUpdateExcuteFunc==nil then
rpData.pcallUpdateExcuteFunc=function()
local nowTime=gameUtilityModel.getServerShortTime()

if rpData.expiresec>0 and nowTime>rpData.expiresec then


rpData:removeEntity(true)
xianjieModel:refreshMonsterData(rpData,false)
return
end
end
end

if rpData.pcallUpdateCatchError==nil then
rpData.pcallUpdateCatchError=function()
rpData.updataError=true
loggerUtil.logErrFMT('xjHUD onUpdate err!{0}',err)
end
end
else
_cdLookup[rpData.m_ID]=nil
end
end

function xianjieModel:post_XianJieSceneStateChangeToMonster(stateType,isEnter)









if isEnter then
xianjieModel:createAllMoZongAttackRange()
else
xianjieModel:removeAllMoZongAttackRange()
end
end

function xianjieModel:createAllMoZongAttackRange()
if not xianjienSceneIndexType:isMoJie(xianjieModel:getSceneIndex())then return end
xianjieModel:removeAllMoZongAttackRange()
if self.allMonsterDatas then
self.mzAttackRangeList={}
for k,monsterData in pairs(self.allMonsterDatas)do
local entitytype=monsterData.entitytype
if xjEntityShowAttackRange[entitytype]and xjEntityShowAttackRange[entitytype]==1 then
local data={}
data.pos=xianjieController:worldGridPos2WorldPos41(monsterData.gridX_c,monsterData.gridZ_c,monsterData.sceneidx)
local cfg=monsterData:getCfg()
local range=cfg.range
local w=range*2+monsterData.gridWidth
local h=range*2+monsterData.gridHeight
data.size=xianjieController:gridSize2WorldSize2(w,h)
data.width=w
data.height=h

self.mzAttackRangeList[monsterData.infoguid]=xianjieController:addEntity(XJ_ENTITY_TYPE.eAttackRange,data,true)
end
end
end
end

function xianjieModel:removeAllMoZongAttackRange()
if not xianjienSceneIndexType:isMoJie(xianjieModel:getSceneIndex())then return end
if self.mzAttackRangeList then
for infoguid,a_key in pairs(self.mzAttackRangeList)do
xianjieController:removeEntity(a_key,true)
end
self.mzAttackRangeList=nil
end
end

function xianjieModel:removeMoZongAttackRange(infoguid)
if self.mzAttackRangeList then
local a_key=self.mzAttackRangeList[infoguid]
if a_key then
xianjieController:removeEntity(a_key,true)
self.mzAttackRangeList[infoguid]=nil
end
end
end


function xianjieModel:FindMoZong()

local func=function()


local zmData=xianjieModel:getMyZongMenData()

local chooseguid
local minDis
if self.allMonsterDatas then
for _,monsterData in pairs(self.allMonsterDatas)do
if monsterData and monsterData.infoid~=0 then
local cfg=monsterData:getCfg()
local type=cfg.type
local stage=cfg.stage
if type==6 or type==7 then
local d=mathHelper.distance2(monsterData.gridX,monsterData.gridZ,zmData.gridX,zmData.gridZ)

if d and d>=0 and(not minDis or d<minDis)then
minDis=d
chooseguid=monsterData.infoguid
end

end
end
end
end


local istips=true

if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
istips=false
xianjieController:openMonsterInfoWin(info_guid)
end
end
if istips then
UIManager.info("未找到魔宗")
end
return not istips
end
if not xianjieModel:isInMoJie()then
local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType,nil,func)
return true
else
return func()
end
end

function xianjieModel:FindZhenYan()

local func=function()
local zmData=xianjieModel:getMyZongMenData()
local chooseguid
local minDis
if self.allMonsterDatas then
for _,monsterData in pairs(self.allMonsterDatas)do
if monsterData and monsterData.infoid~=0 then
if monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or
monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe then
local d=mathHelper.distance2(monsterData.gridX,monsterData.gridZ,zmData.gridX,zmData.gridZ)
if d and d>=0 and(not minDis or d<minDis)then
minDis=d
chooseguid=monsterData.infoguid
end
end
end
end
end

local istips=true
if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
istips=false
xianjieController:openMonsterInfoWin(info_guid)
end
end
if istips then
UIManager.info("未找到阵眼")
end
return not istips
end
if not xianjieModel:isInMoJie()then
local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType,nil,func)
return true
else
return func()
end
end



function xianjieModel:setMJboxData(infoguid_str,entitytype,monsterData)
if entitytype==xjServerEnityType.eMoJieBox and self.MJboxDatas then
self.MJboxDatas[infoguid_str]=true
if self.BXgatherLookup then
self:set_BXgatherLookup(infoguid_str,monsterData)
end

end
end
function xianjieModel:clearMJboxData(infoguid_str)
if self.MJboxDatas and self.MJboxDatas[infoguid_str]then
self.MJboxDatas[infoguid_str]=nil
if self.BXgatherLookup and self.BXgatherLookup[infoguid_str]then
self.BXgatherLookup[infoguid_str]=nil
end

end
end

function xianjieModel:set_BXgatherLookup(infoguid_str,monsterData)
self.BXgatherLookup[infoguid_str]=false
if monsterData and monsterData.gatherLisrt then
for k,actor_id in ipairs(monsterData.gatherLisrt)do
if playerModel:checkActorId(actor_id)then
self.BXgatherLookup[infoguid_str]=true
break
end
end
end
end
function xianjieModel:getMJboxData()
return self.MJboxDatas
end
function xianjieModel:checkMJboxgatherLookupEX(infoguid_str)
return self.BXgatherLookup and self.BXgatherLookup[infoguid_str]
end
function xianjieModel:checkMJboxgatherLookup(infoguid)
if self.BXgatherLookup then
local infoguid_str=tostring(infoguid)
return self.BXgatherLookup[infoguid_str]
end
end



function xianjieModel:updateRefreshMonsterData(season_id,chapter_idx,stageFogId)
local seasonType=seasonModel:getHandleConfig(season_id,'seasonType')

if seasonType==eSeasonType.eMJMB then
xianjieModel:UnlockRefreshMonsterData()
end
end

function xianjieModel:UnlockRefreshMonsterData()

if xianjieModel:isInMoJie()then
local lp=self.allMonsterDatas
if lp then
for infoguid_str,monsterData in pairs(lp)do
xianjieModel:refreshMonsterData(monsterData,false)
end
end
end
end

function xianjieModel:clearLimitNotOpenMonsterData()
if self.limitNotOpenMonsterDatas then
self.limitNotOpenMonsterDatas=nil
end
end

function xianjieModel:initLimitNotOpenMonsterData()
self.limitNotOpenMonsterDatas={}
end

function xianjieModel:setLimitNotOpenMonsterData(monsterData)
if self.limitNotOpenMonsterDatas and monsterData then
self.limitNotOpenMonsterDatas[monsterData.infoguid]=monsterData
end
end

function xianjieModel:removeLimitNotOpenMonsterData(infoguid)
if self.limitNotOpenMonsterDatas and infoguid then
self.limitNotOpenMonsterDatas[infoguid]=nil
end
end

function xianjieModel:getLimitNotOpenMonsterData()
return self.limitNotOpenMonsterDatas
end

function xianjieModel:updateLimitNotOpenMonsterData()
if self.limitNotOpenMonsterDatas then
for infoguid,monsterData in pairs(self.limitNotOpenMonsterDatas)do
local isPassLimit=xianjieHelper.checkMonsterLimitCND(monsterData)
if isPassLimit then
self.limitNotOpenMonsterDatas[infoguid]=nil

xianjieModel:setMJboxData(monsterData.infoguid_str,monsterData.entitytype,monsterData)
xianjieModel:setGuid2EntityType(monsterData.infoguid,monsterData.entitytype,monsterData.sceneidx)
xianjieModel:setMonsterCDLookup(monsterData)

monsterData:createEntity(true)
xianjieController:invokeEntityFunc(monsterData.ent_key,'showEffect')
notifySystem:postNotify(notifyConfig.onXianJieMonsterChange,CHANGE_TYPE.eAdd,monsterData.infoguid)
end
end
end
end

function xianjieModel:checkMonsterNotOpenData(infoguid)
if self.limitNotOpenMonsterDatas and infoguid then
return self.limitNotOpenMonsterDatas[infoguid]
end
end
