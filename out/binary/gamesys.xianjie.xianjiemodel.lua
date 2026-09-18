







xianjieModel={}

function xianjieModel:initCfg()
local sceneIndex2SceneTypeLookup={}
local scenecfgs=cfg_xianjiesceneconfig()
for i,v in pairs(scenecfgs)do
sceneIndex2SceneTypeLookup[v.mapIndex]=v.id
end
self.sceneIndex2SceneTypeLookup=sceneIndex2SceneTypeLookup
end

function xianjieModel:initServerData(len,crossList)

self.serverData={}
local xianyuLookup={}
local xianyuLookup2={}
if crossList then


for sceneidx,serverid in ipairs(crossList)do
xianyuLookup[serverid]=sceneidx
xianyuLookup2[sceneidx]=serverid
end
end
self.serverData.xianyuLookup=xianyuLookup
self.serverData.xianyuLookup2=xianyuLookup2
self.serverData.xianyuCnt=len
end

function xianjieModel:initData(attend)
local isInit=false
if self.data==nil then
self.data={}
isInit=true
end
self.data.attend=attend
return isInit
end

function xianjieModel:clearData(isReconnet)
if not isReconnet then
self.sceneType=nil
self.sceneidx=nil
end
self.data=nil
self.serverData=nil
self.baseData=nil
self.isInitMapData=nil
self.mapData_timeout=nil
self.mapData_timeout_allXianJie=nil
self.sceneIndex2SceneTypeLookup=nil
self.cameraFollowFlag=nil
self.guid2EntityTypeLookup=nil
end

function xianjieModel:clearDataGM()
self.data={}
self.baseData=nil
xianjieModel:clearDataGM_mojie()
xianjieController:clearListenMark()
end

function xianjieModel:checkInit()
return self.data~=nil
end

function xianjieModel:initBaseData()
if self.baseData==nil then
self.baseData={}
end
end

function xianjieModel:setJoin()
if self.data then
self.data.attend=1
end
end

function xianjieModel:checkJoin()
if self.data then
return self.data.attend==1
end
return false
end

function xianjieModel:checkInitMapData()
return self.isInitMapData==true and not self.mapData_timeout
end

function xianjieModel:setInitMapData()
self.isInitMapData=true
self.mapData_timeout=nil
self.mapData_timeout_allXianJie=nil
end

function xianjieModel:timeoutMapData()
self.mapData_timeout=true
end

function xianjieModel:checkIsInitMapData_allXianJie()
return self.isInitMapData==true and not self.mapData_timeout_allXianJie
end


function xianjieModel:timeoutMapData_allXianJie()
self.mapData_timeout_allXianJie=true
end


function xianjieModel:getDefaultScene()
return xianjienSceneType.eXianJie
end

function xianjieModel:isInitScene()
return self:getSceneIndex()~=nil
end

function xianjieModel:isInMoJie()
return self:isInitScene()and xianjienSceneIndexType:isMoJie(self.sceneidx)
end

function xianjieModel:setScenceType(typo)
self.sceneType=typo
if typo~=nil then
self.sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,typo,'mapIndex')
else
self.sceneidx=nil
end
end

function xianjieModel:getScenceType()
return self.sceneType
end

function xianjieModel:checkSceneType(typo)
return self.sceneType==typo
end

function xianjieModel:getSceneIndex(sceneType)
if sceneType then
return cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'mapIndex')
else
return self.sceneidx
end
end

function xianjieModel:checkSceneIndex(sceneIndex)
return self.sceneidx==sceneIndex
end

function xianjieModel:checkSceneTypes(typos)
if typos==nil then return false end
for i,v in ipairs(typos)do
if xianjieModel:checkSceneType(v)then
return true
end
end
return false
end

function xianjieModel:sceneIndex2SceneType(sceneIndex)
return self.sceneIndex2SceneTypeLookup[sceneIndex]
end

function xianjieModel:getXianYuSceneIndex()
local cross_sid=loginModel:getCrossServerId()
local lp=self.serverData and self.serverData.xianyuLookup or nil
if lp then
return lp[cross_sid]
end
end

function xianjieModel:getXianYuCrossServerId(sceneIndex)
sceneIndex=sceneIndex or self.sceneidx
local lp=self.serverData and self.serverData.xianyuLookup2 or nil
if lp then
return lp[sceneIndex]
end
end

function xianjieModel:getXianYuSceneCnt()
if self.serverData and self.serverData.xianyuCnt then
return self.serverData.xianyuCnt
else
return 1
end
end





function xianjieModel:checkEnemyType(actorid)
local zmData=xianjieModel:getZongMenData(actorid)
if zmData then
return xianjieModel:checkEnemyTypeEx(actorid,zmData.ownersceneidx)
else



return xjEnemyType.eStranger
end
end



function xianjieModel:checkEnemyTypeEx(actorid,sceneidx)
if playerModel:checkActorId(actorid)then
return xjEnemyType.eSelf
else
local zmData=xianjieModel:getZongMenData(actorid)
local isFriend=xianmengModel:isMyXM2(zmData.guildid)

local sceneidx_=xianjieModel:getXianYuSceneIndex()
local sameScene=sceneidx==sceneidx_

local model=xianjieModel:getMapMode()
if model==xjAttackMode.ePeace then
if isFriend then
return xjEnemyType.eAllies
end
elseif model==xjAttackMode.eXianYu then
if isFriend then
return xjEnemyType.eAllies
elseif sameScene then

end
elseif model==xjAttackMode.eXianMeng then
if isFriend then
return xjEnemyType.eAllies
end
elseif model==xjAttackMode.ePersion then

end
end
return xjEnemyType.eStranger
end


function xianjieModel:checkEnemyType2(actorid,sceneidx)
if playerModel:checkActorId(actorid)then
return xjEnemyType.eSelf
else
local zmData=xianjieModel:getZongMenData(actorid)
if xianmengModel:isMyXM2(zmData.guildid)then
return xjEnemyType.eAllies
else
local sceneidx_=xianjieModel:getXianYuSceneIndex()
if sceneidx==sceneidx_ then
return xjEnemyType.eStranger
else
return xjEnemyType.eEnemy
end
end
end
end


function xianjieModel:checkEnemyType3(guildid,sceneidx)
if xianmengModel:isMyXM2(guildid)then
return xjEnemyType.eSelf
else
local sceneidx_=xianjieModel:getXianYuSceneIndex()
if sceneidx==sceneidx_ then
return xjEnemyType.eStranger
else
return xjEnemyType.eEnemy
end
end
end


function xianjieModel:checkPVPEnemyType(srcActorid,tarActorid)
if playerModel:checkActorId(srcActorid)then
return xjEnemyType.eSelf
elseif playerModel:checkActorId(tarActorid)then
return xjEnemyType.eEnemy
else
local myZmData=xianjieModel:getMyZongMenData()
local srcZmData=xianjieModel:getZongMenData(srcActorid)
local tarZmData=xianjieModel:getZongMenData(tarActorid)

local isSrcFriend=xianmengModel:compareTwoGuildID(myZmData:getXMGuildid(),srcZmData:getXMGuildid())
local isTarFriend=xianmengModel:compareTwoGuildID(myZmData:getXMGuildid(),tarZmData:getXMGuildid())

local sameSrcScene=myZmData:getXianYuSceneIndex()==srcZmData:getXianYuSceneIndex()
local sameTarScene=myZmData:getXianYuSceneIndex()==tarZmData:getXianYuSceneIndex()

local model=xianjieModel:getMapMode()
if model==xjAttackMode.ePeace then

elseif model==xjAttackMode.eXianYu then
if sameSrcScene then
return xjEnemyType.eAllies
elseif sameTarScene then
return xjEnemyType.eEnemy
end
elseif model==xjAttackMode.eXianMeng then
if isSrcFriend then
return xjEnemyType.eAllies
elseif isTarFriend then
return xjEnemyType.eEnemy
end
elseif model==xjAttackMode.ePersion then

end
end
return xjEnemyType.eStranger
end


function xianjieModel:checkPVPEnemyType2(srcActorid,tarGuildid)
if playerModel:checkActorId(srcActorid)then
return xjEnemyType.eSelf
elseif xianmengModel:isMyXM2(tarGuildid)then
return xjEnemyType.eEnemy
else
local myZmData=xianjieModel:getMyZongMenData()
local srcZmData=xianjieModel:getZongMenData(srcActorid)
local tarXmData=xianjieModel:getXianMengData(tarGuildid)

local isSrcFriend=xianmengModel:compareTwoGuildID(myZmData:getXMGuildid(),srcZmData:getXMGuildid())
local isTarFriend=xianmengModel:compareTwoGuildID(myZmData:getXMGuildid(),tarXmData.guildid)

local sameSrcScene=myZmData:getXianYuSceneIndex()==srcZmData:getXianYuSceneIndex()
local sameTarScene=myZmData:getXianYuSceneIndex()==tarXmData:getXianYuSceneIndex()

local model=xianjieModel:getMapMode()
if model==xjAttackMode.ePeace then

elseif model==xjAttackMode.eXianYu then
if sameSrcScene then
return xjEnemyType.eAllies
elseif sameTarScene then
return xjEnemyType.eEnemy
end
elseif model==xjAttackMode.eXianMeng then
if isSrcFriend then
return xjEnemyType.eAllies
elseif isTarFriend then
return xjEnemyType.eEnemy
end
elseif model==xjAttackMode.ePersion then

end
end
return xjEnemyType.eStranger
end


function xianjieModel:checkArenaAtkEnemyType(srcActorid,arenaState)

if playerModel:checkActorId(srcActorid)then
return xjEnemyType.eSelf
else
local myZmData=xianjieModel:getMyZongMenData()
local srcZmData=xianjieModel:getZongMenData(srcActorid)
local sameSrcScene=myZmData:getXianYuSceneIndex()==srcZmData:getXianYuSceneIndex()

local model=xianjieModel:getMapMode()
if model==xjAttackMode.ePeace then
if xianmengModel:isMyXM2(srcZmData.guildid)then
return xjEnemyType.eAllies
end
elseif model==xjAttackMode.eXianYu then
if sameSrcScene then
return xjEnemyType.eAllies
elseif arenaState==1 then
return xjEnemyType.eEnemy
end
elseif model==xjAttackMode.eXianMeng then

elseif model==xjAttackMode.ePersion then

end
end
return xjEnemyType.eStranger
end


function xianjieModel:getMapMode()
local zmData=xianjieModel:getMyZongMenData()
if zmData==nil then return xjAttackMode.ePeace end

local sceneidx=zmData.sceneidx
if sceneidx==nil then return xjAttackMode.ePeace end

return cfgHelper.get2(cfg_fairylandsceneidxconfig_get,sceneidx,'mode')
end

function xianjieModel.getColorStrByEnemyType(enemyType,str)
local color
if enemyType==xjEnemyType.eSelf then
color=FONT_COLOR.eGreenColor
elseif enemyType==xjEnemyType.eAllies then
color=FONT_COLOR.eBlueColor
elseif enemyType==xjEnemyType.eEnemy then
color=FONT_COLOR.eRedColor
elseif enemyType==xjEnemyType.eStranger then
color=FONT_COLOR.eTipWhiteColor
end
return toColorString2(color,str)
end



function xianjieModel:checkDZState(disguid,isWarning)
local stateType,stateName=xianjieModel:getDZState(disguid,isWarning)
if stateType~=nil then
if isWarning then
local str=FMT.fmt('该弟子正在{0}，无法派遣',stateName)
UIManager.error(str)
end
end
return stateType
end

function xianjieModel:getDZState(disguid,showDesc)
local disguid_str=tostring(disguid)
local stateType,stateName
stateType,stateName=xianjieModel:getDZState_plot(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end
stateType,stateName=xianjieModel:getDZState_yuanjun(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end
stateType,stateName=xianjieModel:getDZState_RPMarch(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end
stateType,stateName=xianjieModel:getDZState_WaiPai(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end
stateType,stateName=xianjieModel:getDZState_yuanjun_MoJie(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end
stateType,stateName=xianjieModel:getDZState_yuanjun_MoGong(disguid_str,showDesc)
if stateType~=nil then
return stateType,stateName
end


return nil,nil
end

function xianjieModel:initBattleDZ(d)
d.checkState=function(guid,isWarning)

local stateType=xianjieModel:checkDZState(guid,isWarning)
return stateType==nil
end
d.getStateIcon=function(guid)










return nil,nil
end
d.checkMask=function(guid)
local stateType=xianjieModel:checkDZState(guid)
if stateType then
return true
end
return false
end
end

function xianjieModel.checkDZSortFunc(guid)
local stateType=xianjieModel:checkDZState(guid)
if stateType then
return false
end
return true
end




function xianjieModel:setCameraFollow(flag)
self.cameraFollowFlag=flag
end

function xianjieModel:checkCameraFollow()
return self.cameraFollowFlag==true
end




function xianjieModel:getOrderConfig(moveType)
local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
return order[moveType]
end



function xianjieModel:setGuid2EntityType(guid,entityType,sceneIdx)
if not self.guid2EntityTypeLookup then
self.guid2EntityTypeLookup={}
end

if not sceneIdx then
logErr(FMT.fmt("设置仙界实体类型快查索引表缺少对应场景索引 请检查前端代码/数据是否正确 guid={0}, entityType={1}",guid,entityType))
return
end
local groupType=xianjieController:getSceneIndexGroup(sceneIdx)
if not self.guid2EntityTypeLookup[groupType]then
self.guid2EntityTypeLookup[groupType]={}
end

local guidStr=tostring(guid)
self.guid2EntityTypeLookup[groupType][guidStr]=entityType
end

function xianjieModel:getEntityTypeByGuid(guid,sceneIdx)
local guidNum=mathHelper.int64_to_number(guid)
if guidNum<0 then

return xjServerEnityType.eClientBuild
end

if not sceneIdx then
sceneIdx=xianjieModel:getSceneIndex()
if not sceneIdx then

return nil
end
end
local groupType=xianjieController:getSceneIndexGroup(sceneIdx)
if not self.guid2EntityTypeLookup then
return nil
end

if not self.guid2EntityTypeLookup[groupType]then
return nil
end

local guidStr=tostring(guid)
return self.guid2EntityTypeLookup[groupType][guidStr]
end

function xianjieModel:clearGuid2EntityType()
self.guid2EntityTypeLookup=nil
end

function xianjieModel:getEntityByData(entityData)
local entityKey=entityData:getEntityKey()
if entityKey==nil then return end
return xianjieController:getEntity(entityKey)
end

function xianjieModel:getEntityDataByGuid(guid,sceneIdx)
local entitytype=xianjieModel:getEntityTypeByGuid(guid,sceneIdx)
if entitytype then
if entitytype==xjServerEnityType.eGuild then
return xianjieModel:getXianMengData(guid)
elseif entitytype==xjServerEnityType.eMonster or
entitytype==xjServerEnityType.eBossMonster or
entitytype==xjServerEnityType.eMonsterHouse or
entitytype==xjServerEnityType.eMoJieMoZong_Small or
entitytype==xjServerEnityType.eMoJieMoZong_Big or
entitytype==xjServerEnityType.eMoJieMoJunYaoMo or
entitytype==xjServerEnityType.eMoJieMoster or
entitytype==xjServerEnityType.eMoJieShangGuMoster or
entitytype==xjServerEnityType.eMoJieZhenYan_Small or
entitytype==xjServerEnityType.eMoJieZhenYan_Big or
entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
entitytype==xjServerEnityType.eMoJieBox
then
return xianjieModel:getMonsterData(guid)


elseif entitytype==xjServerEnityType.eStation then
return xianjieModel:getStationData(guid)
elseif entitytype==xjServerEnityType.eActor then
return xianjieModel:getZongMenData(guid)
elseif entitytype==xjServerEnityType.eMoJieMoJunFenShen then
return xianjieModel:getMoJunFenShenData(guid)
elseif entitytype==xjServerEnityType.eMoJingZhenJi_Normal then
return xianjieModel:getPuTongZhenJiData(guid)
elseif entitytype==xjServerEnityType.eClientBuild then
if xianjieModel:checkClientBdIsArenaByGuid(guid)then
return xianjieModel:getArenaDataByArenaId(guid)
elseif xianjieModel:checkClientBdIsMoGongByGuid(guid)then
return xianjieModel:getMoGongDataByMoGongId(guid)
elseif xianjieModel:checkClientBdIsMoJieGateByGuid(guid)then
return xianjieModel:getMoJieGateDataByGuid(guid)
elseif xianjieModel:isMoJiangBuild_int64(guid)then
return xianjieModel:findMoJiangEntityByBuild64(guid)
elseif xianjieModel:checkClientBdIsBenYuanZhenJiByGuid(guid)then
return xianjieModel:findBenYuanZhenJiDataByBuildId(guid)
elseif xianjieModel:isMoJunBuild_int64(guid)then
return xianjieModel:findMoJunEntity(guid)
end
elseif entitytype==xjServerEnityType.eLingShou then
return xianjieModel:getXJLingShouData(guid)
elseif entitytype==xjServerEnityType.eLingShouGroup then
return xianjieModel:getXJLingShouGroupData(guid)
end
end
end




function xianjieModel:setAllow(allow)
self.jiJieYBDData.allow=allow
end


function xianjieModel:getAllow()
return self.jiJieYBDData.allow
end

function xianjieModel:setFeiShengRank(rank)
self.feishengRank=rank
end

function xianjieModel:getFeiShengRank()
return self.feishengRank or 0
end

function xianjieModel:isOpenHuJianXianJie()
return systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)
end

function xianjieModel:isOpenHuJianXianJieEx()
return systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)and xianjieController:checkXianYuOpen()
end

local _checkBlink={
[XJ_ENTITY_TYPE.eMoJiangRange]=true,
[XJ_ENTITY_TYPE.eMoJunRange]=true,
[XJ_ENTITY_TYPE.eMoGongRange]=true,
[XJ_ENTITY_TYPE.eZhenTaiRange]=true,
}
function xianjieModel:checkRangeBlink(gridX,gridZ,width,height)
local wPos=xianjieController:worldGridPos2WorldPos1(gridX,gridZ,width,height)
local gSize=xianjieController:getMapGridSize()
local cPos=Vector2(wPos.x,wPos.z)
local size=Vector2(width*gSize,height*gSize)
local keys=xianjieController:findEnitys(cPos,size)
for i=1,keys.Count do
local key=keys[i-1]
local ent=xianjieController:getEntity(key)
if ent and _checkBlink[ent.entityType]and ent:crashRect(cPos.x,cPos.y,size.x,size.y)then

ent:showBlickEffect(true)
return false
end
end
return true
end

function xianjieModel:checkMoJunTiaoZhanRange(gridX,gridZ,width,height)
local wPos=xianjieController:worldGridPos2WorldPos1(gridX,gridZ,width,height)
local gSize=xianjieController:getMapGridSize()
local cPos=Vector2(wPos.x,wPos.z)
local size=Vector2(width*gSize,height*gSize)
local keys=xianjieController:findEnitys(cPos,size)
for i=1,keys.Count do
local key=keys[i-1]
local ent=xianjieController:getEntity(key)
if ent and ent.entityType==XJ_ENTITY_TYPE.eMoJunTiaoZhanRange and ent:crashRect(cPos.x,cPos.y,size.x,size.y)then
return false
end
end
return true
end
