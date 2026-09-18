









local _datas={}










local _effectDatas={}







local _reverse={}







local _records={}










local _killDatas={}








local _boxDatas={}
local _canFinishBoxList={}

local _finishFlag=nil
local _oldBuildId=nil
local _mojunTickTimer
local _myAreaId=nil
local _myCanTZMoJun=nil
local _oldCanShowBox=nil
local _oldMoJunTimeType=nil
local _newRecord_mojun=nil
local _massTeam_mojun=nil
local _isHasNewMJEff=nil
local _attackMeEffeckList={}
local _isRanLing={}
local _mojunBoxTeamSpeed=6
local _fightPlot=nil
local _deadPlot=nil
local _mojunEffectFaZhenPos=
{
xy={381,447},
wh={1,1},
}
local _mojunEffectFaZhenConfig=
{
[4]=true,
[5]=true,
[6]=true,
}
local _twoEffectDatas=nil
local _twoEffectZFDatas=nil
local _zhenFaExData={}
MoJunZhangJieID=
{
one=1,
two=2,
}
ZhenFaeffectType=
{
guaXiang=4,
ranLing=5,
douZhuan=6,
}

local _effectIdx=0
function getMoJunEffectIdx()
_effectIdx=_effectIdx+1
return _effectIdx
end

function xianjieModel:getMoJunBoxTeamSpeed()
return _mojunBoxTeamSpeed
end

function xianjieModel:isMoJunEffectFaZhenConfig(confid)
return true






end

function xianjieModel:getMoJunEffectFaZhenPos(confid)

return cfgHelper.get2(cfg_seasonmojuneffectconfig_get,confid,'zhenfapos')
end


function xianjieModel:refreshMyZongMenMoJunAreaId(sceneidx)
if not xianjienSceneIndexType:isMoJie(sceneidx)then
return
end
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
_myCanTZMoJun=xianjieModel:checkMoJunTZRangeArea(gridX,gridZ,gridWidth,gridHeight,sceneidx)
_myAreaId=xianjieModel:getMoJunEffectAreaId(gridX,gridZ,gridWidth,gridHeight)
end

function xianjieModel:checkMoJunTZRangeArea(x1,y1,width,height,sceneidx)
if not xianjienSceneIndexType:isMoJie(sceneidx)then
return false
end

local x2=x1+width
local y2=y1+height

local mojunData=xianjieModel:getMoJunData()
local jieshu=mojunData and mojunData.mojunJieShu or 1
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,jieshu)
local build_id=mojunData and mojunData.build_id or cfg.bodyInit
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.param.area2[1],cfg.param.area2[2])
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)

local wrange=gridWidth/2
local hrange=gridHeight/2
local x1_=gridX_c-wrange
local y1_=gridZ_c-hrange
local x2_=gridX_c+wrange
local y2_=gridZ_c+hrange
if mathHelper.rectCrashRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)then
return true
end
return false
end

function xianjieModel:getMoJunEffectAreaId(x1,y1,width,height)
local x2=x1+width
local y2=y1+height

local areaCfgs=cfg_seasonmojuneffectareaconfig()
for areaId,areaCfg in ipairs(areaCfgs)do
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(areaCfg.xy[1],areaCfg.xy[2],1,1,areaCfg.wh[1],areaCfg.wh[2])
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)

local wrange=gridWidth/2
local hrange=gridHeight/2
local x1_=gridX_c-wrange
local y1_=gridZ_c-hrange
local x2_=gridX_c+wrange
local y2_=gridZ_c+hrange
if mathHelper.rectCrashRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)then
return areaId
end
end
return nil
end

function xianjieModel:setMoJunDatas(seasonType,stageIndex,serverData)
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
local isInit=not isInMoJie

local build_id
local gwzid
local mojunJieShu=serverData.mojunJieShu or 1
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunJieShu)
local hp=serverData.mojunHP or 0
if hp>=cfg.initHP*10000 then
build_id=cfg.bodyInit
gwzid=cfg.gwzList[1]
else
build_id=cfg.bodyReal
gwzid=cfg.gwzList[2]
end

local isNewBuildId=_oldBuildId~=nil and _oldBuildId~=build_id
_oldBuildId=build_id

local mojunDieTime=serverData.mojunDieTime or 0
local yaomoEndTime=serverData.yaomoEndTime or 0
local yaomoIndex=serverData.yaomoIndex or 0
local begin_time=serverData.begin_time or 0

local state
if mojunDieTime>0 then
state=3
elseif yaomoEndTime>0 then
state=2
elseif yaomoIndex>0 then
state=1
else
state=0
end

local rangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}

local nowTime=timeHelper.getServerShortTime()
local tzRangeData=nil
if begin_time>0 and nowTime>=begin_time and state~=3 then
tzRangeData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
end
local timeType,endTime=xianjieModel:getMoJunNextStateTime(seasonType,stageIndex,mojunJieShu,yaomoEndTime,mojunDieTime)
local today,jieshu=xianjieModel:getCurMoJunDayAndJieshu()
local entityData=nil
if state>1 then
entityData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
gwzid=gwzid,
}
end

local mojunData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
chapter_actor_scroe=serverData.chapter_actor_scroe or 0,
chapter_guild_scroe=serverData.chapter_guild_scroe or 0,
hp=hp,
killTime=mojunDieTime,
mojunLevel=serverData.mojunLevel,
mojunJieShu=mojunJieShu,
yaomoEndTime=yaomoEndTime,
yaomoIndex=yaomoIndex,
finishTip=serverData.finishTip,
hurtRwMaxVal=serverData.hurtRwMaxVal or 0,
hurtTotal=serverData.hurtTotal or 0,
jsrwSucc=serverData.jsrwSucc or 0,
jsrwFail=serverData.jsrwFail or 0,
state=state,
gwzid=gwzid,
timeType=timeType,
endTime=endTime,
day=today,
bufflistlen=serverData.mjBuffLen or 0,
buffList=serverData.buffList,
}

xianjieModel:setMoJunData(seasonType,stageIndex,build_id,mojunData,isInit)
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData,isInit,isNewBuildId)
xianjieModel:setMoJunRangeEntityData(seasonType,stageIndex,rangeData,isInit)
xianjieModel:setMoJunTzRangeEntityData(seasonType,stageIndex,tzRangeData,isInit)
xianjieModel:setMoJunBoxDatas(seasonType,stageIndex,serverData.boxListLen,serverData.boxList,isInit)

if isInit then
xianjieModel:addMoJunEffectDatas(seasonType,stageIndex,serverData.effectLen,serverData.effectList,isInit)
if state==2 then
xianjieController:reqMoJunGetFenShenData(seasonType,stageIndex)
end
end

if timeType==2 and endTime>0 then
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieMoJun,yaomoEndTime,endTime)
end
end

function xianjieModel:setMoJunData(seasonType,stageIndex,build_id,mojunData,isInit)
local temp1=_datas[seasonType]
if temp1==nil then
temp1={}
_datas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end

if mojunData then
temp.mojunData=mojunData
else
temp.mojunData=nil
end
_reverse={seasonType,stageIndex}
end

function xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData,onlyData,isNewBuildId)
local temp1=_datas[seasonType]
if temp1==nil then
temp1={}
_datas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end

if temp.entity then
if entityData then
if isNewBuildId then
xianjieController:removeXJClass(temp.entity)
temp.entity=xianjieController:createXJClass(xjDataType.eMoJun,entityData)
temp.entity:createEntity(true)
else
temp.entity:refreshData(entityData)
temp.entity:refreshEntity()
end
else
xianjieController:removeXJClass(temp.entity)
temp.entity=nil
end
else

if entityData then
temp.entity=xianjieController:createXJClass(xjDataType.eMoJun,entityData)
if not onlyData then
temp.entity:createEntity(true)
end
end
end
end

function xianjieModel:setMoJunRangeEntityData(seasonType,stageIndex,rangeData,onlyData)
local temp1=_datas[seasonType]
if temp1==nil then
temp1={}
_datas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end
if temp.range then
if rangeData then
temp.range:refreshData(rangeData)
temp.range:refreshEntity()
else
xianjieController:removeXJClass(temp.range)
temp.range=nil
end
else

if rangeData then
temp.range=xianjieController:createXJClass(xjDataType.eMoJunRange,rangeData)
if not onlyData then
temp.range:createEntity(true)
end
end
end
end

function xianjieModel:setMoJunTzRangeEntityData(seasonType,stageIndex,tzRangeData,onlyData)
local temp1=_datas[seasonType]
if temp1==nil then
temp1={}
_datas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end
if temp.tzRange then
if tzRangeData then
temp.tzRange:refreshData(tzRangeData)
temp.tzRange:refreshEntity()
else
xianjieController:removeXJClass(temp.tzRange)
temp.tzRange=nil
end
else

if tzRangeData then
temp.tzRange=xianjieController:createXJClass(xjDataType.eMoJunTiaoZhanRange,tzRangeData)
if not onlyData then
temp.tzRange:createEntity(true)
end
end
end
end



function xianjieModel:addMoJunEffectDatas(seasonType,stageIndex,effectLen,effectList,isInit)
local idxList={}
if effectLen and effectLen>0 then
local mojunData=xianjieModel:getMoJunData()
local nowTime=gameUtilityModel.getServerShortTime2()
local canShow=mojunData and mojunData.timeType==2
for i=1,effectLen do
local effect=effectList[i]
local confid=effect.confid
local areaId=effect.areaId
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,confid)
if areaId~=nil and cfg.effectTime~=nil then
local build_id=mojunData.build_id
local idx=getMoJunEffectIdx()
local startTime=effect.startTime
local _twodata
local effectType=cfg.effectType
if effectType==ZhenFaeffectType.guaXiang or effectType==ZhenFaeffectType.ranLing or effectType==ZhenFaeffectType.douZhuan then
local endTime=startTime+cfg.effectTime
if nowTime<startTime-1 or nowTime>=endTime then
else
_twodata=
{
ex_effectid=cfg.rangeEffect[1],
ex_scale=cfg.rangeEffect[2],
ex_jsonStr=effect.jsonStr
}
end
end
local effectData={
seasonType=seasonType,
stageIndex=stageIndex,
idx=idx,
confid=confid,
startTime=startTime,
endTime=startTime+cfg.effectTime,
areaId=areaId,
build_id=build_id,
twodata=_twodata,
}
idxList[i]=idx
xianjieModel:addMoJunEffectData(seasonType,stageIndex,effectData,nowTime,canShow,isInit)


if effectType==ZhenFaeffectType.guaXiang then
local zhenfaparem=cfg.zhenfaparem
local zhenfascale=cfg.zhenfascale
local decode=jsonHelper.decode(effect.jsonStr)
local guid=effect.guid or ZhenFaeffectType.guaXiang
local index=decode[1]
_zhenFaExData[cfg.effectType]=index

local effectParam=cfg.effectParam[2]
local posParam=effectParam[index]
local effectidx=posParam[5]or 1
local effctid=((effectidx%2)==1)and 20529 or 20530


local twodata=
{
ex_pos=zhenfaparem[effectidx],
ex_effectid=effctid,
ex_build_id=build_id,
ex_confid=confid,
ex_scale=zhenfascale[effectidx],
ex_isex=true,
}
local _startTime=effect.startTime
local _endTime=_startTime+cfg.effectTime
local canShowEff=xianjieModel:getCanShowMoJunEffectTwo(seasonType,stageIndex,_startTime,_endTime)
xianjieModel:addMoJunEffectTwoHandle(seasonType,stageIndex,idx,confid,twodata,canShowEff,build_id,guid,_startTime,_endTime,isInit)

elseif effectType==ZhenFaeffectType.douZhuan then
local zhenfaparem=cfg.zhenfaparem
local zhenfascale=cfg.zhenfascale
local decode=jsonHelper.decode(effect.jsonStr)
local guid=effect.guid or ZhenFaeffectType.guaXiang
local index=decode[1]
local effctid=20532
_zhenFaExData[cfg.effectType]=index

local twodata=
{
ex_rotation=zhenfaparem[index],
ex_effectid=effctid,
ex_build_id=build_id,
ex_confid=confid,
ex_scale=zhenfascale,
ex_isex=true,
}
local _startTime=effect.startTime
local _endTime=_startTime+cfg.effectTime
local canShowEff=xianjieModel:getCanShowMoJunEffectTwo(seasonType,stageIndex,_startTime,_endTime)
xianjieModel:addMoJunEffectTwoHandle(seasonType,stageIndex,idx,confid,twodata,canShowEff,build_id,guid,_startTime,_endTime,isInit)
end
end
end
end
return idxList
end

function xianjieModel:setMoJunFenShenEffectDatas(seasonType,stageIndex,len,marchList)
self.MoJunFenShenEffectData={}
if len and len>0 then
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or xianjienSceneIndexType.eMoJie
local zmData=xianjieModel:getMyZongMenData(sceneIdx)
if not zmData then
printError("Error: 找不到自己的魔界宗门")
return
end
local gridX_c_,gridZ_c_=xianjieController:worldGridCenterPos(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
local mjData=xianjieModel:getMoJunEntityData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(mjData.gridX,mjData.gridZ,mjData.gridWidth,mjData.gridHeight)
local movePath=xianjieController:getMovePath(sceneIdx,gridX_c,gridZ_c,sceneIdx,gridX_c_,gridZ_c_)

local confid=3
local idx=0
for i=1,len do
idx=idx-1

local teamData=marchList[i]
local speedlist=teamData.list
local startTime=speedlist[1].param_1
local battleTime=teamData.battleTime
local wayTime=xianjieController:getMovePathWayTime2(movePath,speedlist,false,battleTime)
local endTime=startTime+wayTime

local effectData={
seasonType=seasonType,
stageIndex=stageIndex,
idx=idx,
confid=confid,
startTime=startTime,
endTime=endTime,
}
table.insert(self.MoJunFenShenEffectData,effectData)
end
end
end

function xianjieModel:getMoJunFenShenEffectDatas()
return self.MoJunFenShenEffectData
end

function xianjieModel:addMoJunEffectData(seasonType,stageIndex,effectData,nowTime,canShow,onlyData)
local temp1=_effectDatas[seasonType]
if temp1==nil then
temp1={}
_effectDatas[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
local temp=temp2.entityDatas
if temp==nil then
temp={}
temp2.entityDatas=temp
end
local lookup=temp2.lookup
if lookup==nil then
lookup={}
temp2.lookup=lookup
end
local entityLookup=temp2.entityLookup
if entityLookup==nil then
entityLookup={}
temp2.entityLookup=entityLookup
end

local canShowEff=xianjieModel:getCanShowMoJunEffect(seasonType,stageIndex,effectData.idx,nowTime,effectData)
if canShowEff then
if _mojunEffectFaZhenConfig[effectData.confid]then
temp[effectData.idx]=xianjieController:createXJClass(xjDataType.eMoJunTiaoZhanRange,effectData)
else
temp[effectData.idx]=xianjieController:createXJClass(xjDataType.eMoJunEffect,effectData)
end
lookup[effectData.idx]=true
elseif temp[effectData.idx]then
xianjieController:removeXJClass(temp[effectData.idx])
temp[effectData.idx]=nil
lookup[effectData.idx]=nil
entityLookup[effectData.idx]=nil
end
_isRanLing[effectData.idx]=nil
if canShow and canShowEff then
if not onlyData then
temp[effectData.idx]:createEntity(true)
entityLookup[effectData.idx]=true
end

if effectData.confid==1 and effectData.areaId==_myAreaId then
_attackMeEffeckList[effectData.idx]=effectData.areaId
xianjieModel:setMoJunAttackWin()
end
if effectData.confid==5 then
_isRanLing[effectData.idx]=true
xianjieModel:setMoJunAttackWin()
end
end
xianjieModel:setIsHasNewMoJunEffect(true)
end

function xianjieModel:removeAllMoJunEffect(seasonType,stageIndex)
local temp1=_effectDatas[seasonType]
if temp1==nil then
temp1={}
_effectDatas[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2==nil then
temp2={}
temp1[stageIndex]=temp2
end
local temp3=temp2.entityDatas
if temp3 then
for idx,temp in pairs(temp3)do
xianjieController:removeXJClass(temp)
end
end
temp2.entityDatas=nil
temp2.lookup=nil
temp2.entityLookup=nil

_attackMeEffeckList={}
_isRanLing={}
xianjieModel:setMoJunAttackWin()
self:removeMoJunTwoEffect()
end

function xianjieModel:createAllMoJunEffectEntity()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.timeType==2 then
local nowTime=gameUtilityModel.getServerShortTime2()
for seasonType,temp1 in pairs(_effectDatas)do
for stageIndex,temp2 in pairs(temp1)do
temp2.entityLookup={}
if temp2.entityDatas then
for idx,temp in pairs(temp2.entityDatas)do
if xianjieModel:getCanShowMoJunEffect(seasonType,stageIndex,idx,nowTime)then
temp:createEntity(true)
temp2.entityLookup[idx]=true
else
temp2.lookup[idx]=nil
temp2.entityLookup[idx]=nil
end
end
end
end
end
self:createMoJunTwoEffectEntity()
end
end

function xianjieModel:removeAllMoJunEffectEntity()
for seasonType,temp1 in pairs(_effectDatas)do
for stageIndex,temp2 in pairs(temp1)do
if temp2.entityDatas then
for idx,temp in pairs(temp2.entityDatas)do
if temp2.entityLookup[idx]then
temp:removeEntity()
end
end
end
temp2.entityLookup={}
end
end
self:removeMoJunTwoEffectEntity()
end

function xianjieModel:onUpdate_mojunEffectEntity()
local mojunData=xianjieModel:getMoJunData()
local nowTime=gameUtilityModel.getServerShortTime2()
local flag=false

if _twoEffectZFDatas and _twoEffectDatas then
local seasonType=_twoEffectZFDatas.seasonType
local stageIndex=_twoEffectZFDatas.stageIndex
local idx=_twoEffectZFDatas.idx
local _startTime=_twoEffectZFDatas._startTime
local _endTime=_twoEffectZFDatas._endTime
local isCanShow=xianjieModel:getCanShowMoJunEffectTwo(seasonType,stageIndex,_startTime,_endTime)
if not mojunData or not isCanShow then
xianjieController:removeXJClass(_twoEffectDatas)
_twoEffectDatas=nil
elseif mojunData.timeType~=2 then
_twoEffectDatas:removeEntity()
end
end
for seasonType,temp1 in pairs(_effectDatas)do
for stageIndex,temp2 in pairs(temp1)do
local removeIdxList={}
if temp2 and temp2.entityLookup and next(temp2.entityLookup)~=nil then
for idx,_ in pairs(temp2.entityLookup)do
local attAreaId=_attackMeEffeckList[idx]
local ranLingflag=_isRanLing[idx]
if temp2.entityDatas and temp2.entityDatas[idx]then
local temp=temp2.entityDatas[idx]
local isCanShow=xianjieModel:getCanShowMoJunEffect(seasonType,stageIndex,idx,nowTime)
if not mojunData or not isCanShow then
xianjieController:removeXJClass(temp)
table.insert(removeIdxList,idx)

if attAreaId then
flag=true
_attackMeEffeckList[idx]=nil
end
if ranLingflag then
flag=true
_isRanLing[idx]=nil
end
elseif mojunData.timeType~=2 then
temp:removeEntity()
temp2.entityLookup[idx]=nil

if attAreaId then
flag=true
_attackMeEffeckList[idx]=nil
end
if ranLingflag then
flag=true
_isRanLing[idx]=nil
end
else
if not attAreaId and temp.confid==1 and temp.areaId==_myAreaId then
flag=true
_attackMeEffeckList[idx]=temp.areaId
end
if ranLingflag then
flag=true
_isRanLing[idx]=true
end
end
else
temp2.entityLookup[idx]=nil
if attAreaId then
flag=true
_attackMeEffeckList[idx]=nil
end
if ranLingflag then
flag=true
_isRanLing[idx]=nil
end
end
end
end
if next(removeIdxList)~=nil then
local len=#removeIdxList
for i=1,len do
local idx=removeIdxList[len-i+1]
temp2.entityDatas[idx]=nil
temp2.lookup[idx]=nil
temp2.entityLookup[idx]=nil
end
end
end
end
for idx,areaId in pairs(_attackMeEffeckList)do
if areaId~=_myAreaId then
flag=true
_attackMeEffeckList[idx]=nil
end
end

if flag then
xianjieModel:setMoJunAttackWin()
end
end

function xianjieModel:playMoJunZMEffect(idx)
local info=xianjieModel:getMoJunSeasonStages()
local seasonType=info[1]
local stageIndex=info[2]
local data=xianjieModel:getMoJunEffectRange(seasonType,stageIndex,idx)
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,data.confid)

local list=xianjieController:findAOIEnity()
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and ent.entityType==XJ_ENTITY_TYPE.eZongMen then
local zmData=ent.zmData
local areaId=xianjieModel:getMoJunEffectAreaId(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
if areaId and areaId==data.areaId then
ent:playMoJunAreaEffect(nil,cfg.addType)
end
end
end
end

function xianjieModel:stopMoJunZMEffect(areaId_)
local list=xianjieController:findAOIEnity()
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and ent.entityType==XJ_ENTITY_TYPE.eZongMen then
local zmData=ent.zmData
local areaId=xianjieModel:getMoJunEffectAreaId(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
if areaId and areaId==areaId_ then
ent:stopMoJunAreaEffect(nil)
end
end
end
end

function xianjieModel:getCanShowMoJunEffect(seasonType,stageIndex,idx,nowTime,effectData)
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if not datas then
return false
end
effectData=effectData or datas.entityDatas[idx]
if not effectData or not next(effectData)then
return false
end
nowTime=nowTime or gameUtilityModel.getServerShortTime2()
local startTime=effectData.startTime
local endTime=effectData.endTime
if nowTime<startTime-1 or nowTime>=endTime then
return false
end
return true
end

function xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
return _effectDatas[seasonType]and _effectDatas[seasonType][stageIndex]or nil
end

function xianjieModel:getMoJunEffectList(seasonType,stageIndex)
local list={}
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if datas and datas.lookup~=nil and next(datas.lookup)~=nil then
for idx,v in pairs(datas.lookup)do
if datas.entityDatas[idx]and datas.entityDatas[idx].endTime~=nil then
table.insert(list,idx)
end
end
end
return list
end

function xianjieModel:getMoJunEffectRange(seasonType,stageIndex,idx)
local data=self:getMoJunEffectDatas(seasonType,stageIndex)
return data and data.entityDatas[idx]or nil
end

function xianjieModel:getIsHasNewMoJunEffect()
return _isHasNewMJEff
end

function xianjieModel:setIsHasNewMoJunEffect(flag)
_isHasNewMJEff=flag
end


function xianjieModel:addMoJunEffectTwoHandle(seasonType,stageIndex,idx,confid,twodata,canShowEff,build_id,guid,_startTime,_endTime,isInit)
local effectData={
seasonType=seasonType,
stageIndex=stageIndex,
idx=idx,
areaId=0,
confid=confid,
build_id=build_id,
twodata=twodata,
guid=guid,
_startTime=_startTime,
_endTime=_endTime,
}

xianjieModel:addMoJunEffectTwoData(effectData,canShowEff,isInit)
end

function xianjieModel:addMoJunEffectTwoData(effectData,canShowEff,isInit)
if _twoEffectDatas then
xianjieController:removeXJClass(_twoEffectDatas)
_twoEffectDatas=nil
_twoEffectZFDatas=nil
end
if canShowEff then
_twoEffectDatas=xianjieController:createXJClass(xjDataType.eMoJunTiaoZhanRange,effectData)
_twoEffectZFDatas=effectData
else



end
if canShowEff then
if not isInit then
_twoEffectDatas:createEntity(true)
end
end
end

function xianjieModel:removeMoJunTwoEffect()
if _twoEffectDatas then
xianjieController:removeXJClass(_twoEffectDatas)
_twoEffectDatas=nil
end
end
function xianjieModel:createMoJunTwoEffectEntity()

if _twoEffectDatas then
_twoEffectDatas:createEntity(true)
end
end
function xianjieModel:removeMoJunTwoEffectEntity()
if _twoEffectDatas then
_twoEffectDatas:removeEntity()
end
end

function xianjieModel:getZhanFaEffectData()
if _twoEffectDatas then
return _twoEffectDatas
end
return false
end

function xianjieModel:playZhanFaEffectTwo()
if _twoEffectDatas then
local ent_key=_twoEffectDatas:getEntityKey()
if ent_key then
local sceneidx_=xianjieModel:getSceneIndex()
if _twoEffectDatas.sceneidx and _twoEffectDatas.sceneidx==sceneidx_ then
local ex_effectid=20533
xianjieController:invokeEntityFunc(ent_key,"showZhanFaEffect",ex_effectid)
end
end
end
end

function xianjieModel:changeZhanFaEffectTwo(effect)
local mojunData=xianjieModel:getMoJunData()
local canShow=mojunData and mojunData.timeType==2
if canShow then
local build_id=mojunData.build_id
local confid=effect.confid
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,confid)
local zhenfaparem=cfg.zhenfaparem
local zhenfascale=cfg.zhenfascale
local decode=jsonHelper.decode(effect.jsonStr)
local index=decode[1]
local effctid=20532
_zhenFaExData[cfg.effectType]=index

local twodata=
{
ex_rotation=zhenfaparem[index],
ex_effectid=effctid,
ex_build_id=build_id,
ex_confid=confid,
ex_scale=zhenfascale,
}
if _twoEffectDatas then

_twoEffectDatas:refreshData(twodata)
_twoEffectDatas:refreshEntity()
end
end
end

function xianjieModel:getCanShowMoJunEffectTwo(seasonType,stageIndex,startTime,endTime)
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if not datas then
return false
end
local nowTime=gameUtilityModel.getServerShortTime2()
if nowTime<startTime-1 or nowTime>=endTime then
return false
end
return true
end




function xianjieModel:setMoJunBoxDatas(seasonType,stageIndex,boxLen,boxList,isInit)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local lookup={}
if boxLen and boxLen>0 then
for i=1,boxLen do
local data=boxList[i]
lookup[data.boxId]=data
end
end

local canShowBox=mojunData.timeType==4

if cfg.boxList~=nil and next(cfg.boxList)~=nil then
for i,boxId in ipairs(cfg.boxList)do
local data=lookup[boxId]
local boxData=nil
local startTime=data and data.startTime or 0

local finish=data and data.finish or 0
if canShowBox then
boxData={
seasonType=seasonType,
stageIndex=stageIndex,
boxId=boxId,
startTime=startTime,
finish=finish,
}
elseif startTime>0 and finish==0 then

xianjieController:reqMoJunBoxFinish(seasonType,stageIndex,boxId)
end

xianjieModel:setMoJunBoxData(seasonType,stageIndex,boxId,boxData,isInit)
end
end
UIManager:invokeUIMethod("UIXianJieExtra_ZTMJunWin","refreshBox")
end

function xianjieModel:setMoJunBoxData(seasonType,stageIndex,boxId,boxData,onlyData)
local temp1=_boxDatas[seasonType]
if temp1==nil then
temp1={}
_boxDatas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end

local nowTime=gameUtilityModel.getServerShortTime2()
if temp[boxId]then
if boxData then
temp[boxId]:refreshData(boxData)
temp[boxId]:refreshEntity()
if temp[boxId].startTime>0 then
if nowTime>temp[boxId].endTime then
xianjieController:doMoJunBoxMarchRetract(temp[boxId])
else
xianjieController:doMoJunBoxMarchCreate(temp[boxId])
end
end
else
xianjieController:doMoJunBoxMarchRetract(temp[boxId])
xianjieController:removeXJClass(temp[boxId])
temp[boxId]=nil
end
else
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)

if boxData and mojunData.timeType==4 then
temp[boxId]=xianjieController:createXJClass(xjDataType.eMoJunBox,boxData)
if not onlyData then
temp[boxId]:createEntity(true)
if temp[boxId].startTime>0 then
if nowTime>temp[boxId].endTime then
xianjieController:doMoJunBoxMarchRetract(temp[boxId],onlyData)
else
xianjieController:doMoJunBoxMarchCreate(temp[boxId],onlyData)
end
end
end
end
end
end

function xianjieModel:removeAllMoJunBox(seasonType,stageIndex)
local mojunData=xianjieModel:getMoJunData()
local canShowBox=mojunData and mojunData.timeType==4
local temp1=_boxDatas[seasonType]
if temp1==nil then
temp1={}
_boxDatas[seasonType]=temp1
end
local temp2=temp1[stageIndex]
if temp2 then
for boxId,temp in pairs(temp2)do
if not canShowBox and temp.startTime>0 and temp.finish==0 then
xianjieController:reqMoJunBoxFinish(seasonType,stageIndex,temp.boxId)
end
xianjieController:removeXJClass(temp)
temp=nil
end
end
temp1[stageIndex]=nil
end

function xianjieModel:createAllMoJunBoxEntity()
local mojunData=xianjieModel:getMoJunData()
local canShowBox=mojunData and mojunData.timeType==4
if canShowBox then
for seasonType,temp1 in pairs(_boxDatas)do
for stageIndex,temp2 in pairs(temp1)do
for boxId,temp in pairs(temp2)do
temp:createEntity(true)
end
end
end
end
end

function xianjieModel:removeAllMoJunBoxEntity()
for seasonType,temp1 in pairs(_boxDatas)do
for stageIndex,temp2 in pairs(temp1)do
for boxId,temp in pairs(temp2)do
temp:removeEntity()
end
end
end
end

function xianjieModel:onUpdate_mojunBoxEntity()
local info=xianjieModel:getMoJunSeasonStages()
if info~=nil and next(info)~=nil then
local mojunData=xianjieModel:getMoJunData(info[1],info[2])
local boxDatas=xianjieModel:getMoJunBoxDatas(info[1],info[2])
local canShowBox=mojunData and mojunData.timeType==4
if _oldCanShowBox and not canShowBox then
if boxDatas then
xianjieModel:removeAllMoJunBox(info[1],info[2])
end
elseif canShowBox then
local nowTime=gameUtilityModel.getServerShortTime2()
for boxId,entity in pairs(boxDatas)do
if entity.state==1 and entity.endTime<nowTime then
if entity.finish==0 then
xianjieController:reqMoJunBoxFinish(info[1],info[2],entity.boxId)
else
entity.state=2
end
elseif entity.state==2 then
local march=xianjieModel:getMoJunBoxMarch(entity.boxId)
if march then
local teamHandle=march:getTeamHandle()
local state,time=teamHandle:getTeamState()
if time and nowTime>time[2]then
xianjieModel:refreshMoJunBoxMarch(entity.boxId,"")
end
end
end
end
end
_oldCanShowBox=canShowBox
end
end

function xianjieModel:getMoJunBoxDatas(seasonType,stageIndex)
return _boxDatas[seasonType]and _boxDatas[seasonType][stageIndex]or nil
end

function xianjieModel:refreshMoJunBoxEntityDatas()
local mojunData=xianjieModel:getMoJunData()
local canShowBox=mojunData and mojunData.timeType==4
if canShowBox then
local nowTime=gameUtilityModel.getServerShortTime2()
for seasonType,temp1 in pairs(_boxDatas)do
for stageIndex,temp2 in pairs(temp1)do
for boxId,temp in pairs(temp2)do
if temp.startTime>0 then
temp:refreshData({})
temp:refreshEntity()
if nowTime<temp.endTime then
xianjieController:doMoJunBoxMarchCreate(temp)
else
xianjieController:doMoJunBoxMarchRetract(temp)
end
end
end
end
end
end
end

function xianjieModel:getMoJunFirstBox(seasonType,stageIndex)
local datas=xianjieModel:getMoJunBoxDatas(seasonType,stageIndex)
local firstTemp=nil
local num=0
if datas~=nil and next(datas)~=nil then
for boxId,temp in pairs(datas)do
if temp.startTime==0 then
if not firstTemp then
firstTemp=temp
end
num=num+1
end
end
end
return firstTemp,num
end

function xianjieModel:getMoJunBoxEntityData(seasonType,stageIndex,boxId)
local datas=self:getMoJunBoxDatas(seasonType,stageIndex)
return datas and datas[boxId]or nil
end


function xianjieModel:getMoJunMyAreaId()
return _myAreaId
end

function xianjieModel:getMyCanTzMoJun()
return _myCanTZMoJun
end

function xianjieModel:getMoJunDatas(seasonType,stageIndex)
return _datas[seasonType]and _datas[seasonType][stageIndex]or nil
end

function xianjieModel:getMoJunData(seasonType,stageIndex)
local info=xianjieModel:getMoJunSeasonStages()
local data=self:getMoJunDatas(seasonType or info[1],stageIndex or info[2])
return data and data.mojunData or nil
end

function xianjieModel:getMoJunModelData()
local mojunData=xianjieModel:getMoJunData()
local jieshu=mojunData and mojunData.mojunJieShu or 1
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,jieshu)
local build_id=mojunData and mojunData.build_id or cfg.bodyInit
local gwzid=mojunData and mojunData.gwzid or cfg.gwzList[1]
local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local modelParams=comHelper.getMonsterGroupModelParams(gwzid)
local body=modelParams.body
local componets=modelParams.components or{}
local scale=mjCfg.clientParam.scale or 1
local flip=mjCfg.clientParam.flip==1
local offset=mjCfg.clientParam.offset and mathHelper.convertArrayToVector(mjCfg.clientParam.offset)or Vector3.zero
return body,componets,scale,flip,offset
end

function xianjieModel:getHpRecoverData(seasonType,stageIndex,isNext)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
local today=mojunData.day

local hpRecover=seasonModel:getStageConfigEx(seasonType,stageIndex,"hpRecover")
for i,v in ipairs(hpRecover)do
if today>=v[1]and(today<=v[2]or v[2]==9999)then
if isNext then
return hpRecover[i+1]
else
return v
end
end
end
if isNext then
return hpRecover[2]
else
return hpRecover[1]
end
end

function xianjieModel:getMoJunEntityData(seasonType,stageIndex)
local info=xianjieModel:getMoJunSeasonStages()
local data=self:getMoJunDatas(seasonType or info[1],stageIndex or info[2])
return data and data.entity or nil
end

function xianjieModel:getMoJunRange(seasonType,stageIndex)
local data=self:getMoJunDatas(seasonType,stageIndex)
return data and data.range or nil
end

function xianjieModel:getMoJunTiaoZhanRange(seasonType,stageIndex)
local data=self:getMoJunDatas(seasonType,stageIndex)
return data and data.tzRange or nil
end

function xianjieModel:clearMoJunDatas(seasonType,stageIndex)
local data=self:getMoJunDatas(seasonType,stageIndex)
if data then
xianjieModel:setMoJunData(seasonType,stageIndex)
xianjieModel:setMoJunEntityData(seasonType,stageIndex)
xianjieModel:setMoJunRangeEntityData(seasonType,stageIndex)
xianjieModel:setMoJunTzRangeEntityData(seasonType,stageIndex)
end

local effDatas=self:getMoJunEffectDatas(seasonType,stageIndex)
if effDatas then
xianjieModel:removeAllMoJunEffect(seasonType,stageIndex)
end

local boxDatas=self:getMoJunBoxDatas(seasonType,stageIndex)
if boxDatas then
xianjieModel:removeAllMoJunBox(seasonType,stageIndex)
end
end

function xianjieModel:getMoJunSeasonStages()
return _reverse or defaultT
end

function xianjieModel:clearData_mojun()
xianjieModel:stopMoJunTick()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,data in pairs(temp1)do
xianjieController:removeXJClass(data.entity)
xianjieController:removeXJClass(data.range)
xianjieController:removeXJClass(data.tzRange)
end
end

for seasonType,temp1 in pairs(_effectDatas)do
for stageIndex,temp2 in pairs(temp1)do
if temp2.entityDatas then
for i,temp in pairs(temp2.entityDatas)do
xianjieController:removeXJClass(temp)
end
end
end
end

for seasonType,temp1 in pairs(_boxDatas)do
for stageIndex,temp2 in pairs(temp1)do
for i,temp in pairs(temp2)do
xianjieController:removeXJClass(temp)
end
end
end

table.clear(_datas)
table.clear(_effectDatas)
table.clear(_boxDatas)
table.clear(_killDatas)
table.clear(_records)
table.clear(_reverse)
_finishFlag=nil
_oldBuildId=nil
_effectIdx=0
_attackMeEffeckList={}
_isRanLing={}
xianjieModel:setMoJunAttackWin()
end

function xianjieModel:initData_mojun()
_finishFlag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJun,"finishFlag",{})
_fightPlot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJun,"fightPlot",{})
_deadPlot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJun,"deadPlot",{})

xianjieModel:startMoJunTick()
end

function xianjieModel:onEnterMap_mojun()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,data in pairs(temp1)do
if data.entity then
data.entity:createEntity(true)
end
if data.range then
data.range:createEntity(true)
end
if data.tzRange then
data.tzRange:createEntity(true)
end
end
end
xianjieModel:createAllMoJunEffectEntity()
xianjieModel:createAllMoJunBoxEntity()
xianjieModel:refreshMoJunBoxEntityDatas()

local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.timeType==2 and mojunData.endTime>0 then
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieMoJun,mojunData.yaomoEndTime,mojunData.endTime)
end
end

function xianjieModel:onExitMap_mojun()
for seasonType,temp1 in pairs(_datas)do
for stageIndex,data in pairs(temp1)do
if data.entity then
data.entity:removeEntity()
end
if data.range then
data.range:removeEntity()
end
if data.tzRange then
data.tzRange:removeEntity()
end
end
end
xianjieModel:removeAllMoJunEffectEntity()
xianjieModel:removeAllMoJunBoxEntity()
end

function xianjieModel:startMoJunTick()
if _mojunTickTimer==nil then
_mojunTickTimer=timer.new()
_mojunTickTimer:start(0.1,function()
xianjieModel:onUpdate_mojunEntity()
xianjieModel:onUpdate_mojunEffectEntity()
xianjieModel:onUpdate_mojunBoxEntity()
end)
end
end

function xianjieModel:stopMoJunTick()
if _mojunTickTimer then
_mojunTickTimer:cancel()
_mojunTickTimer=nil
end
end

function xianjieModel:setMoJunRecord(seasonType,stageIndex,recordList)
local temp1=_records[seasonType]
if temp1==nil then
temp1={}
_records[seasonType]=temp1
end
temp1[stageIndex]=recordList

xianjieModel:loadRecord_MoJun()


if temp1[stageIndex]and next(temp1[stageIndex])then
for k,v in ipairs(temp1[stageIndex])do
if _newRecord_mojun[k]then
v.isnew=0
else
v.isnew=1
end
end
end
end

function xianjieModel:getMoJunRecord(seasonType,stageIndex)
local temp1=_records[seasonType]
if temp1==nil then
temp1={}
_records[seasonType]=temp1
end
local temp=temp1[stageIndex]
return temp
end

function xianjieModel:clearMoJunRecords(seasonType,stageIndex)
local temp1=_records[seasonType]
if temp1 and temp1[stageIndex]then
table.clear(temp1[stageIndex])
end
end

function xianjieModel:setMoJunKillDatas(seasonType,stageIndex,mojunDieTime,actorId,actorName,actorServerId,iconInfo,xmName,xmServerId,xmIcon)
local temp1=_killDatas[seasonType]
if temp1==nil then
temp1={}
_killDatas[seasonType]=temp1
end
local temp=temp1[stageIndex]
if temp==nil then
temp={}
temp1[stageIndex]=temp
end

local bestGuild=nil
if mojunDieTime>0 then
bestGuild={
xmServerId=xmServerId,
xmIcon=xmIcon,
xmName=xmName,
}
end
local bestPlayer=nil
if mojunDieTime>0 then
bestPlayer={
actorId=actorId,
actorServer=actorServerId,
actorName=actorName,
iconInfo=iconInfo,
}
end

temp.killTime=mojunDieTime
temp.bestGuild=bestGuild
temp.bestPlayer=bestPlayer
end

function xianjieModel:getMoJunKillDatas(seasonType,stageIndex)
local temp1=_killDatas[seasonType]
if temp1==nil then
temp1={}
_killDatas[seasonType]=temp1
end
local temp=temp1[stageIndex]
return temp
end

function xianjieModel:clearMoJunKillDatas(seasonType,stageIndex)
local temp1=_killDatas[seasonType]
if temp1 and temp1[stageIndex]then
table.clear(temp1[stageIndex])
end
end

function xianjieModel:checkMoJunFinishFlag(seasonType,stageIndex,beginTime)
local temp=_finishFlag[seasonType]
if temp then
return temp[stageIndex]==beginTime
end
return false
end

function xianjieModel:setMoJunFinishFlag(seasonType,stageIndex)
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage then
local temp=_finishFlag[seasonType]
if temp==nil then
temp={}
_finishFlag[seasonType]=temp
end
temp[stageIndex]=stage.beginTime

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJun,"finishFlag",_finishFlag)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJun)
end
end

function xianjieModel:getMoJunTypeIcon(build_id)
local _ab="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"
if not build_id then
return _ab,"button_mojieui_4"
end
local isMoJun,isMoJunInit=xianjieModel:isMoJunBuild(build_id)
if isMoJunInit then
return _ab,"button_mojieui_5"
else
return _ab,"button_mojieui_4"
end
end

function xianjieModel:isMoJunBuild(build_id)
local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local is_mojun=mjCfg and mjCfg.param~=nil and mjCfg.param.is_mojun==true
local is_mojunInit=mjCfg and mjCfg.param~=nil and mjCfg.param.is_mojunInit==true
return is_mojun,is_mojunInit
end

function xianjieModel:isMoJunBuild_int64(int64Guid)
local build_id=mathHelper.int64_to_number(int64Guid)
return self:isMoJunBuild(build_id)
end

function xianjieModel:findMoJunEntity(int64Guid)
local info=xianjieModel:getMoJunSeasonStages()
if next(info)then
return self:getMoJunEntityData(info[1],info[2])
end
end

function xianjieModel:isShowMoJunMenuGroup()





local info=xianjieModel:getMoJunSeasonStages()
if next(info)then
local seasonType=info[1]
local stageIndex=info[2]
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eTZMJ)
if not mojunData then
return false
end
local nowTime=timeHelper.getServerShortTime()
local flag=mojunData.state==0 and stage and stage.beginTime>0 and nowTime>=stage.beginTime
if flag or mojunData.state==1 or mojunData.timeType==1 or mojunData.timeType==2 or mojunData.timeType==4 then
return true
end
end
return false
end

function xianjieModel:hideMoJunMenuSkin()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.timeType==4 then
return true
end
return false
end


function xianjieModel:getMoJunNextStateTime(seasonType,stageIndex,mojunJieShu,yaomoEndTime,mojunDieTime)
local nowTime=gameUtilityModel.getServerShortTime2()
local timeType=0
local endTime=0

mojunJieShu=mojunJieShu or 1
mojunDieTime=mojunDieTime or 0
yaomoEndTime=yaomoEndTime or 0
if mojunDieTime>0 then
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunJieShu)
if nowTime<mojunDieTime+cfg.boxDuration then
timeType=4
endTime=mojunDieTime+cfg.boxDuration
end
elseif yaomoEndTime>0 then
local mojunTime=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojunTime")
local zeroSec=timeHelper.getServerZeroShortStamp(yaomoEndTime)
local firstOpenSec=zeroSec+86400+mojunTime[1]*3600+mojunTime[2]*60+mojunTime[3]
if nowTime<firstOpenSec then
timeType=1
endTime=firstOpenSec
else
local curZeroSec=timeHelper.getServerZeroShortStamp()
local curOpenSec=curZeroSec+mojunTime[1]*3600+mojunTime[2]*60+mojunTime[3]
local curEndSec=curZeroSec+mojunTime[4]*3600+mojunTime[5]*60+mojunTime[6]

if nowTime<curOpenSec then
timeType=3
endTime=curOpenSec
elseif nowTime>curEndSec then
timeType=3
endTime=curOpenSec+86400
else
timeType=2
endTime=curEndSec
end
end
end
return timeType,endTime
end

function xianjieModel:onUpdate_mojunEntity()
local mojunData=xianjieModel:getMoJunData()
if not mojunData then return end
if mojunData.timeType~=0 then
local nowTime=gameUtilityModel.getServerShortTime2()
if nowTime>mojunData.endTime then
local timeType,endTime=xianjieModel:getMoJunNextStateTime(mojunData.seasonType,mojunData.stageIndex,mojunData.mojunJieShu,mojunData.yaomoEndTime,mojunData.killTime)
mojunData.timeType=timeType
mojunData.endTime=endTime
end
end
if _oldMoJunTimeType~=nil and _oldMoJunTimeType~=mojunData.timeType and(mojunData.timeType==2 or mojunData.timeType==3)then
self:refreshMoJun()

if mojunData.timeType==2 and mojunData.endTime>0 then
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eMoJieMoJun,mojunData.yaomoEndTime,mojunData.endTime)
else
limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eMoJieMoJun)
end
notifySystem:postNotify(notifyConfig.onLimitActOpen,LIMIT_ACT_TYPE.eMoJieMoJun,2)
end
_oldMoJunTimeType=mojunData.timeType
end

function xianjieModel:refreshMoJun()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.state>1 and mojunData.timeType~=1 then
local entityData={
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
gwzid=mojunData.gwzid,
}
xianjieModel:setMoJunEntityData(mojunData.seasonType,mojunData.stageIndex,entityData)
end
end

function xianjieModel:clearData_selfMoJunTeam()
if self.selfMoJunTeamDatas and next(self.selfMoJunTeamDatas)then
for i,v in pairs(self.selfMoJunTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfMoJunTeamDatas=nil
end

function xianjieModel:initSelfMoJunTeamDatas()
xianjieModel:clearData_selfMoJunTeam()
self.selfMoJunTeamDatas={}
end

function xianjieModel:refreshSelfMoJunTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eAttackMoJun
if not self.selfMoJunTeamDatas then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfMoJunTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str})
self.selfMoJunTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfMoJunTeamDatas[guid_str]
if teamData==nil then

self.selfMoJunTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str})
self.selfMoJunTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.selfMoJunTeamDatas[guid_str].data=v
self.selfMoJunTeamDatas[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfMoJunTeamData(guid)
local guid_str=tostring(guid)
local teamData=self.selfMoJunTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfMoJunTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eMoJun,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfMoJunTeamData(guid)
if self.selfMoJunTeamDatas then
local guid_str=tostring(guid)
return self.selfMoJunTeamDatas[guid_str]
end
end




function xianjieModel:clearData_moJunFenShen()
local lp=self.allMoJunFenShenDatas
if lp then
for infoguid_str,moJunFenShenData in pairs(lp)do
xianjieController:removeXJClass(moJunFenShenData)
end
self.allMoJunFenShenDatas=nil
end
end

function xianjieModel:initAllMoJunFenShenDatas()
xianjieModel:clearData_moJunFenShen()
self.allMoJunFenShenDatas={}
end

function xianjieModel:refreshMoJunFenShenData(v,isInit)








local infoguid_str=tostring(v.infoguid)
local infoid_str=tostring(v.infoid)
if isInit then
if infoid_str~='0'then
v.infoguid_str=infoguid_str
local moJunFenShenData=xianjieController:createXJClass(xjDataType.eMoJunFenShen,v)
self.allMoJunFenShenDatas[infoguid_str]=moJunFenShenData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
else



end
else
if infoid_str~='0'then
local moJunFenShenData_=self.allMoJunFenShenDatas[infoguid_str]
if moJunFenShenData_==nil then
v.infoguid_str=infoguid_str
local moJunFenShenData=xianjieController:createXJClass(xjDataType.eMoJunFenShen,v)
self.allMoJunFenShenDatas[infoguid_str]=moJunFenShenData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
moJunFenShenData:createEntity(true)
else
moJunFenShenData_:refreshData(v)
moJunFenShenData_:refreshEntity()
end
else
local moJunFenShenData=self.allMoJunFenShenDatas[infoguid_str]
if moJunFenShenData~=nil then
local sceneidx=moJunFenShenData.sceneidx
xianjieController:removeXJClass(moJunFenShenData)
self.allMoJunFenShenDatas[infoguid_str]=nil
xianjieModel:setGuid2EntityType(v.infoguid,nil,sceneidx)
xianjieModel:clearData_marchTeamByMoJunFenShen(infoguid_str)
else



end
end
end
end

function xianjieModel:getMoJunFenShenData(infoguid)
if self.allMoJunFenShenDatas then
local infoguid_str=tostring(infoguid)
return self.allMoJunFenShenDatas[infoguid_str]
end
end

function xianjieModel:getMoJunFenShenDataEx(infoguid_str)
if self.allMoJunFenShenDatas then
return self.allMoJunFenShenDatas[infoguid_str]
end
end

function xianjieModel:createAllMoJunFenShenEnities(needRefreshAOI)
local lp=self.allMoJunFenShenDatas
if lp then
for infoguid_str,moJunFenShenData in pairs(lp)do
moJunFenShenData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllMoJunFenShenEnities()
local lp=self.allMoJunFenShenDatas
if lp then
for infoguid_str,moJunFenShenData in pairs(lp)do
moJunFenShenData:removeEntity()
end
end
end


function xianjieModel:saveRecord_MoJun()
local info=xianjieModel:getMoJunSeasonStages()
if not _records or not _records[info[1]]or not _records[info[1]][info[2]]then return end
userActorSetting.set("xianJieLog_mojun",_records[info[1]][info[2]])
userActorSetting.flush()
end

function xianjieModel:loadRecord_MoJun()
_newRecord_mojun=userActorSetting.get("xianJieLog_mojun",{})
end


function xianjieModel:setMoJunTeamData(len,massList)
_massTeam_mojun=massList
end

function xianjieModel:getMoJunTeamData()
return _massTeam_mojun
end


function xianjieModel:setMoJunAttackWin()
if next(_attackMeEffeckList)~=nil or next(_isRanLing)~=nil then
if next(_isRanLing)then
local zmPos=xianjieModel:getZongMenOutPos_mojie()
if zmPos then
local cfg=cfg_seasonmojuneffectconfig_get(5)
local effectParam=cfg.effectParam
if xianjieModel:checkRanLingZFPos(zmPos[2],zmPos[3],effectParam[3],effectParam[4],effectParam[5],effectParam[6])then
if not UIManager:findActiveWindow("UIMoJieMoJunAttackTipsWin")then
UIManager:showWindow('UIMoJieMoJunAttackTipsWin')
end
else
if UIManager:findActiveWindow("UIMoJieMoJunAttackTipsWin")then
UIManager:closeWindow('UIMoJieMoJunAttackTipsWin')
end
end
end
else

if not UIManager:findActiveWindow("UIMoJieMoJunAttackTipsWin")then
UIManager:showWindow('UIMoJieMoJunAttackTipsWin')
end
end
else
UIManager:closeWindow('UIMoJieMoJunAttackTipsWin')
end
end
function xianjieModel:isCloseMoJunAttackWin()
if _attackMeEffeckList and next(_attackMeEffeckList)then
return true
end
return false
end


function xianjieModel:onNewDay_mojun()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.state==2 then
local today,jieshu=xianjieModel:getCurMoJunDayAndJieshu()
mojunData.jieshu=jieshu
mojunData.day=today
end
end


function xianjieModel:getCurMoJunDayAndJieshu()
local mojunData=xianjieModel:getMoJunData()
if not mojunData then
return 0,1
end
local mojunJieShu=seasonModel:getStageConfigEx(mojunData.seasonType,mojunData.stageIndex,"mojunJieShu")
local today=0
local killDay=0
local jieshu=mojunJieShu[1]
if mojunData.state==3 then
local zeroSec=timeHelper.getServerZeroShortStamp(mojunData.yaomoEndTime)
local killZeroSec=timeHelper.getServerZeroShortStamp(mojunData.killTime)
today=math.floor((killZeroSec-zeroSec)/86400)
local num=math.floor((today-1)/mojunJieShu[2])
jieshu=math.max(mojunJieShu[1]-num,1)
elseif mojunData.state==2 then
local zeroSec=timeHelper.getServerZeroShortStamp(mojunData.yaomoEndTime)
local firstZeroSec=zeroSec+86400
today=timeHelper.getPassDay(timeHelper.convertLongStamp(firstZeroSec))
local num=math.floor((today-1)/mojunJieShu[2])
jieshu=math.max(mojunJieShu[1]-num,1)
end
return today,jieshu,killDay
end

function xianjieModel:checkHasMoJunJieShuReward()
local mojunData=xianjieModel:getMoJunData()
if mojunData.jsrwSucc>0 then
return false
end
local dead=mojunData.killTime>0
local today,jieshu=xianjieModel:getCurMoJunDayAndJieshu()
local hasNotKillReward=mojunData.jsrwFail<today-1
local hasKillReward=dead and mojunData.jsrwFail<today
if not dead and xianjieModel:getIsCurDayEndTzMoJun()then
hasNotKillReward=mojunData.jsrwFail<today
end

local rewardReddot=hasNotKillReward or hasKillReward
return rewardReddot
end


function xianjieModel:getIsCurDayEndTzMoJun()
local mojunData=xianjieModel:getMoJunData()
local today,jieshu=xianjieModel:getCurMoJunDayAndJieshu()
local mojunTime=seasonModel:getStageConfigEx(mojunData.seasonType,mojunData.stageIndex,"mojunTime")
local curSec=gameUtilityModel.getServerShortTime()
local curZeroSec=timeHelper.getServerZeroShortStamp()
local endTime=curZeroSec+mojunTime[4]*3600+mojunTime[5]*60+mojunTime[6]
if curSec>endTime then
return true
end
return false
end

function xianjieModel:getIsMoJunStart()
local mojunData=xianjieModel:getMoJunData()
return mojunData and mojunData.state>1
end


function xianjieModel:getMoJunState()
local mojunData=xianjieModel:getMoJunData()
if not mojunData then
return 0
end
return mojunData.state
end


function xianjieModel:getMoJunHp()
local mojunData=xianjieModel:getMoJunData()
local hp=mojunData.hp or 0
local num=math.floor(hp/10000)/100
if hp>0 and hp<=10000 then
num=0.01
end
return num
end

function xianjieModel:checkHasMoJunHurtReward()
local mojunData=xianjieModel:getMoJunData()
local hurtRewards=seasonModel:getStageConfigEx(mojunData.seasonType,mojunData.stageIndex,"hurtRewards")
for i,v in ipairs(hurtRewards)do
local hurtData=hurtRewards[i]
local hurtTotal=mathHelper.int64_to_number(mojunData.hurtTotal)
local hurtRwMaxVal=mathHelper.int64_to_number(mojunData.hurtRwMaxVal)
local canGet=hurtRwMaxVal<hurtData[1]and hurtTotal>=hurtData[1]
if canGet then
return true
end
end
return false
end

function xianjieModel:checkMoJunReward()
return xianjieModel:checkHasMoJunHurtReward()or xianjieModel:checkHasMoJunJieShuReward()
end

function xianjieModel:checkMoJunFightPlot(seasonType,stageIndex)
local key=FMT.fmt("fightPlot_{0}_{1}",seasonType,stageIndex)
return _fightPlot[key]==true
end

function xianjieModel:setMoJunFightPlot(seasonType,stageIndex)
local key=FMT.fmt("fightPlot_{0}_{1}",seasonType,stageIndex)
_fightPlot[key]=true

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJun,"fightPlot",_fightPlot)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJun)
end

function xianjieModel:checkMoJunDeadPlot(seasonType,stageIndex)
local key=FMT.fmt("deadPlot_{0}_{1}",seasonType,stageIndex)
return _deadPlot[key]==true
end

function xianjieModel:setMoJunDeadPlot(seasonType,stageIndex)
local key=FMT.fmt("deadPlot_{0}_{1}",seasonType,stageIndex)
_deadPlot[key]=true

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJun,"deadPlot",_deadPlot)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJun)
end



function xianjieModel:getMoJunZhangJieID()
local mojunData=xianjieModel:getMoJunData()
if mojunData then
local id=seasonModel:getStageConfigEx(mojunData.seasonType,mojunData.stageIndex,"id")
return id
end
return 1
end

function xianjieModel:getMoJunJieShuByid(mojunid)
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunid)
if cfg then
return cfg.stage or 1
end
return 1
end

function xianjieModel:getMoJunidByJieshu(seasonType,stageIndex,_mojunjieshu)
local mojunJieShu=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojunJieShu")
if mojunJieShu and mojunJieShu[3]and mojunJieShu[3][_mojunjieshu]then
return mojunJieShu[3][_mojunjieshu]
end
return 1
end

function xianjieModel:getZhenFaExData(effectType)
if _zhenFaExData then
return _zhenFaExData[effectType]
end
return false
end


function xianjieModel:initZFGridLimit()

local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,4)
local effectParam=cfg.effectParam[2]
for k,v in ipairs(effectParam)do
if v then




local gridWidth=v[3]+1
local gridHeight=v[4]+1
xianjieModel:setZFGridLimit(k,v[1],v[2],gridWidth,gridHeight)
end
end
end
function xianjieModel:setZFGridLimit(effectType,gridX,gridZ,sizeX,sizeZ)
local lp=self.gridZFLimitLookup
if lp==nil then return end
local d=lp[effectType]
if d==nil then
d={}
lp[effectType]=d
end
for gridX_=gridX,gridX+sizeX-1 do
local dd=d[gridX_]
if dd==nil then
dd={}
d[gridX_]=dd
end
for gridZ_=gridZ,gridZ+sizeZ-1 do
local v=dd[gridZ_]
if v==nil then
v=0
dd[gridZ_]=v
end
dd[gridZ_]=1
end
end
end
function xianjieModel:getZFGridLimit(effectType,gridX,gridZ)
local lp=self.gridZFLimitLookup
if lp==nil then
return
end
effectType=effectType or 4
if lp[effectType]and lp[effectType][gridX]then
return lp[effectType][gridX][gridZ]or 0
end
return 0
end
function xianjieModel:testttGridLimit(effectType,x,y,sizeX,sizeZ)
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(x,y,1,1,sizeX,sizeZ)
self:setZFGridLimit(effectType,gridX,gridZ,sizeX,sizeZ)
end

function xianjieModel:checkZFGridLimit(effectType,gridX,gridZ)
local state=xianjieModel:getZFGridLimit(effectType,gridX,gridZ)
if state~=nil and state~=0 then
return true
end
return false
end



function xianjieModel:checkRanLingZFPos(x,y,cx,cy,r1,r2)
local r1_sq,r2_sq=r1*r1,r2*r2
for temp_x=x,x+2-1 do
for temp_y=y,y+2-1 do
local dx,dy=temp_x-cx,temp_y-cy
local dist_sq=dx*dx+dy*dy
if dist_sq>=r1_sq and dist_sq<=r2_sq then
return true
end
end
end
return false
end

function xianjieModel:checkIsInRanLingZF()
local mojunData=xianjieModel:getMoJunData()
if mojunData and mojunData.timeType==2 then
local MJZJID=xianjieModel:getMoJunZhangJieID()
if MJZJID==MoJunZhangJieID.two then
local actorid=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorid)
if zmData then
local info=xianjieModel:getMoJunSeasonStages()
local seasonType=info[1]
local stageIndex=info[2]
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if datas and datas.entityDatas then
local nowTime=gameUtilityModel.getServerShortTime2()
for i,v in pairs(datas.entityDatas)do
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,v.confid)
if cfg.effectType==ZhenFaeffectType.ranLing then
local isCanShow=xianjieModel:getCanShowMoJunEffect(seasonType,stageIndex,v.idx,nowTime)
if isCanShow then
local effectParam=cfg.effectParam
if xianjieModel:checkRanLingZFPos(zmData.gridX,zmData.gridZ,effectParam[3],effectParam[4],effectParam[5],effectParam[6])then
return true
end
end
end
end
end
end
end
end
return false
end

