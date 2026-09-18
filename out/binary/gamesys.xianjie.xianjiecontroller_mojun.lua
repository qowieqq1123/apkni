
local _sendBoxLookup={}







function xianjieController:onAppStart_mojun()
socketManager:register_receiver(39,17,self.recv_39_17)
socketManager:register_receiver(39,18,self.recv_39_18)
socketManager:register_receiver(39,19,self.recv_39_19)
socketManager:register_receiver(39,20,self.recv_39_20)
socketManager:register_receiver(39,21,self.recv_39_21)
socketManager:register_receiver(39,22,self.recv_39_22)
socketManager:register_receiver(39,23,self.recv_39_23)
socketManager:register_receiver(39,30,self.recv_39_30)
socketManager:register_receiver(39,31,self.recv_39_31)
socketManager:register_receiver(39,32,self.recv_39_32)
socketManager:register_receiver(39,33,self.recv_39_33)
end

function xianjieController:onEnterState_mojun(isReconnet)
xianjieModel:initData_mojun()
xianjieModel:initData_mojunBoxTeam()
end

function xianjieController:onLeaveState_mojun(isReconnet)
xianjieModel:clearData_mojun()
xianjieModel:clearData_mojunBoxTeam()
end

function xianjieController:onEnterMap_mojun()
xianjieModel:onEnterMap_mojun()
xianjieModel:onEnterMap_mojunBoxTeam()
end

function xianjieController:onExitMap_mojun()
xianjieModel:onExitMap_mojun()
xianjieModel:onExitMap_mojunBoxTeam()
end


function xianjieController:reqMoJunFightRecordList(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,3)
end


function xianjieController:reqMoJunFinishData(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,4)
end


function xianjieController:reqMoJunSetFinishTip(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,5)
end


function xianjieController:reqMoJunMeMaxHurt(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,6)
end


function xianjieController:reqMoJunBoxCaiJi(seasonType,stageIndex,boxId)
seasonController:send_39_2(seasonType,stageIndex,7,boxId)
end


function xianjieController:reqMoJunBoxFinish(seasonType,stageIndex,boxId)
local nowTime=gameUtilityModel.getServerShortTime2()
if _sendBoxLookup[boxId]and _sendBoxLookup[boxId]<=nowTime then return end
_sendBoxLookup[boxId]=nowTime+2
seasonController:send_39_2(seasonType,stageIndex,8,boxId)
end


function xianjieController:reqMoJunBuff(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,9)
end


function xianjieController:reqMoJunGetJieShuReward(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,10)
end


function xianjieController:reqMoJunGetFenShenData(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,11)
end


function xianjieController:reqMoJunGetTeam(seasonType,stageIndex)
seasonController:send_39_2(seasonType,stageIndex,12)
end

function xianjieController.recv_39_17(seasonType,stageIndex,mojunHP)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
mojunData.hp=mojunHP

local _oldBuildId=mojunData.build_id
local build_id
local gwzid
local mojunJieShu=mojunData.mojunJieShu or 1
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunJieShu)
if mojunHP>=cfg.initHP*10000 then
build_id=cfg.bodyInit
gwzid=cfg.gwzList[1]
else
build_id=cfg.bodyReal
gwzid=cfg.gwzList[2]
end
mojunData.build_id=build_id
mojunData.gwzid=gwzid

local isNewBuildId=_oldBuildId~=nil and _oldBuildId~=build_id

local entityData={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
gwzid=gwzid,
}
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData,nil,isNewBuildId)

notifySystem:postNotify(notifyConfig.onXianJieMoJunHpChange)
end
end

function xianjieController.recv_39_18(seasonType,stageIndex,len,effectList,pushType)
local mojunEntityData=xianjieModel:getMoJunEntityData()
if not mojunEntityData then
xianjieModel:refreshMoJun()
end
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false

pushType=pushType or 1
if pushType==1 then
local idxlist=xianjieModel:addMoJunEffectDatas(seasonType,stageIndex,len,effectList)
notifySystem:postNotify(notifyConfig.onXianJieMoJunAddEffect)

for i=1,len do
local data=effectList[i]
local areaId=data.areaId
local confid=data.confid
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,confid)
if cfg.effectType==3 then
local ent_key=mojunEntityData.ent_key
if ent_key then
local ent=xianjieController:getEntity(ent_key)
if ent then
ent:modelPlayAnimation(1001)
ent:setPlayAnimationTime(5)
end
end
if xianjieModel:getMyCanTzMoJun()then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
confid=confid,
areaId=areaId,
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
break
end
elseif cfg.effectType==ZhenFaeffectType.guaXiang then
if isInMoJie then
local decode=jsonHelper.decode(data.jsonStr)
local _index=decode[1]
local winParams=
{
seasonType=seasonType,
stageIndex=stageIndex,
confid=confid,
idx=idxlist[i],
zfindex=_index,
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
break
end
elseif cfg.effectType==ZhenFaeffectType.ranLing then
if isInMoJie then
local winParams=
{
seasonType=seasonType,
stageIndex=stageIndex,
confid=confid,
idx=idxlist[i],
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
break
end
elseif cfg.effectType==ZhenFaeffectType.douZhuan then
if isInMoJie then
local decode=jsonHelper.decode(data.jsonStr)
local _index=decode[1]
local winParams=
{
seasonType=seasonType,
stageIndex=stageIndex,
confid=confid,
idx=idxlist[i],
zfindex=_index,
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
break
end
else
local myAteaId=xianjieModel:getMoJunMyAreaId()
if myAteaId==areaId then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
confid=confid,
idx=idxlist[i],
}
UIManager:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
break
end
end
end
end


if pushType==2 then
if len and len>0 then
local effect=effectList[1]
if effect then
local confid=effect.confid
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,confid)
if cfg.effectType==ZhenFaeffectType.douZhuan then
if isInMoJie then
xianjieModel:playZhanFaEffectTwo()
local fun=function(...)
xianjieController.zfTimer=nil
xianjieModel:changeZhanFaEffectTwo(effect)
end
xianjieController.zfTimer=timer.new()
xianjieController.zfTimer:start(1.5,fun,1)
end
end
end
end
end
end

function xianjieController.recv_39_19(seasonType,stageIndex,len,list)
xianjieModel:setMoJunRecord(seasonType,stageIndex,list or defaultT)

UIManager:invokeUIMethod("UIMoJieMoJunRecordWin","updataView")
end

function xianjieController.recv_39_20(args)
local seasonType=args[1]
local stageIndex=args[2]
local mojunDieTime=args[3]
local actorId=args[4]
local actorName=args[5]
local actorServerId=args[6]
local iconInfo=args[7]
local xmName=args[8]
local xmServerId=args[9]
local xmIcon=args[10]

local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
local timeType,endTime=xianjieModel:getMoJunNextStateTime(mojunData.seasonType,mojunData.stageIndex,mojunData.mojunJieShu,mojunData.yaomoEndTime,mojunDieTime)
mojunData.killTime=mojunDieTime
mojunData.hp=0
mojunData.state=3
mojunData.timeType=timeType
mojunData.endTime=endTime

local entityData=nil
if mojunData and mojunData.state>1 and mojunData.timeType~=1 then
entityData={
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
gwzid=mojunData.gwzid,
}
end
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData)
xianjieModel:setMoJunTzRangeEntityData(seasonType,stageIndex)
xianjieModel:setMoJunBoxDatas(seasonType,stageIndex)
xianjieModel:removeAllMoJunEffect(seasonType,stageIndex)
end

xianjieModel:setMoJunKillDatas(seasonType,stageIndex,mojunDieTime,actorId,actorName,actorServerId,iconInfo,xmName,xmServerId,xmIcon)
xianjieModel:clearData_marchTeamByMarchtype(xjServerMarchType.eMoJunFenShenAttack)







local win=UIManager:findActiveWindow('UIMoJieMoJunFinishWin')
if win then
win:refreshView()
else
UIManager:showWindow('UIMoJieMoJunFinishWin',{seasonType=seasonType,stageIndex=stageIndex})
end














limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eMoJieMoJun)
notifySystem:postNotify(notifyConfig.onLimitActOpen,LIMIT_ACT_TYPE.eMoJieMoJun,2)

notifySystem:postNotify(notifyConfig.onXianJieMoJunStateChange)
notifySystem:postNotify(notifyConfig.onXianJieMoJunKill)

end


function xianjieController.recv_39_21(seasonType,stageIndex,huryRwMax,hurtTotal)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
mojunData.hurtRwMaxVal=huryRwMax or 0
mojunData.hurtTotal=hurtTotal or 0

local entityData={
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
gwzid=mojunData.gwzid,
}
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData)

UIManager:invokeUIMethod("UIMoJieMoJunRecordWin","refreshHurt")
UIManager:invokeUIMethod("UIMoJieMoJunRewardWin","refreshPanel")
UIManager:invokeUIMethod("UIMoJie_MoJunInfoWin","refreshRewardReddot")
end
end


function xianjieController.recv_39_22(seasonType,stageIndex,boxId,startTime,finish)
_sendBoxLookup[boxId]=nil
local data=xianjieModel:getMoJunBoxEntityData(seasonType,stageIndex,boxId)
if data then
local boxData={
seasonType=seasonType,
stageIndex=stageIndex,
boxId=boxId,
startTime=startTime or 0,
finish=finish,
}
xianjieModel:setMoJunBoxData(seasonType,stageIndex,boxId,boxData)

UIManager:invokeUIMethod("UIXianJieExtra_ZTMJunWin","refreshBox")
end
end


function xianjieController.recv_39_23(seasonType,stageIndex,boshu,ymEndTime)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
mojunData.yaomoIndex=boshu
mojunData.yaomoEndTime=ymEndTime

if ymEndTime>0 then
local timeType,endTime=xianjieModel:getMoJunNextStateTime(mojunData.seasonType,mojunData.stageIndex,mojunData.mojunJieShu,ymEndTime,mojunData.mojunDieTime)
mojunData.state=2
mojunData.timeType=timeType
mojunData.endTime=endTime

local entityData={
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
gwzid=mojunData.gwzid,
}
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData)
elseif boshu>0 then
mojunData.state=1
end
notifySystem:postNotify(notifyConfig.onXianJieMoJunStateChange)
end
end


function xianjieController.recv_39_30(seasonType,stageIndex,bufflistlen,bufflist)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
if bufflistlen>0 and bufflist then
mojunData.bufflistlen=bufflistlen
mojunData.buffList=bufflist
local entityData=xianjieModel:getMoJunEntityData(seasonType,stageIndex)
if entityData then
entityData:refreshEntity()
end
end
end
end


function xianjieController.recv_39_31(seasonType,stageIndex,jsrwSucc,jsrwFail)
local mojunData=xianjieModel:getMoJunData(seasonType,stageIndex)
if mojunData then
mojunData.jsrwSucc=jsrwSucc
mojunData.jsrwFail=jsrwFail

local entityData={
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=mojunData.build_id,
gwzid=mojunData.gwzid,
}
xianjieModel:setMoJunEntityData(seasonType,stageIndex,entityData)

UIManager:invokeUIMethod("UIMoJieMoJunRewardWin","refreshPanel")
UIManager:invokeUIMethod("UIMoJie_MoJunInfoWin","refreshRewardReddot")
end
end


function xianjieController.recv_39_32(seasonType,stageIndex,len,marchList)
local mojunEntityData=xianjieModel:getMoJunEntityData()
if not mojunEntityData then
xianjieModel:refreshMoJun()
end
xianjieModel:setMoJunFenShenEffectDatas(seasonType,stageIndex,len,marchList)
UIManager:invokeUIMethod("UIXianJieExtra_ZTMJunTipsWin","refreshEffect")
end


function xianjieController.recv_39_33(seasonType,stageIndex,buildingId,len,massList)
xianjieModel:setMoJunTeamData(len,massList)
UIManager:invokeUIMethod("UIMoJie_MoJunInfoWin","refreshTeamInfo")
UIManager:invokeUIMethod("UIMoJie_mojunTeamWin","refreshTeamList")
end


function xianjieController:refreshZMMoJunAreaEffect(actorid)
local info=xianjieModel:getMoJunSeasonStages()
local seasonType=info[1]
local stageIndex=info[2]
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if datas and datas.entityDatas then
local zmData=xianjieModel:getZongMenData(actorid)
local zmMojunAreaId=xianjieModel:getMoJunEffectAreaId(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
if not zmMojunAreaId then
return
end
for i,v in pairs(datas.entityDatas)do
if v.areaId==zmMojunAreaId then
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,v.confid)
local ent=xianjieController:getEntity(zmData.ent_key)
ent:playMoJunAreaEffect(nil,cfg.addType)
return
end
end
end
end


function xianjieController:getZMMoJunAreaEffect(actorid)
local info=xianjieModel:getMoJunSeasonStages()
local seasonType=info[1]
local stageIndex=info[2]
local datas=xianjieModel:getMoJunEffectDatas(seasonType,stageIndex)
if datas and datas.entityDatas then
local zmData=xianjieModel:getZongMenData(actorid)
local zmMojunAreaId=xianjieModel:getMoJunEffectAreaId(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
if not zmMojunAreaId then
return nil
end
for i,v in pairs(datas.entityDatas)do
if v.areaId==zmMojunAreaId then
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,v.confid)
return cfg.addType
end
end
end
return nil
end

function xianjieController:onSeasonStageChange_MoJie_MoJun(season_id,chapter_idx)
local mojunData=xianjieModel:getMoJunData()
if not mojunData then
return
end
local _seasonType=mojunData.seasonType
local _stageIndex=mojunData.stageIndex
if season_id==_seasonType and _stageIndex==chapter_idx then

local mojunDieTime=mojunData.killTime or 0
if mojunDieTime==0 then
local tzRangeData={
seasonType=_seasonType,
stageIndex=_stageIndex,
build_id=mojunData.build_id,
}
xianjieModel:setMoJunTzRangeEntityData(_seasonType,_stageIndex,tzRangeData)
end
end
end



function xianjieController:jumpMoJieMoJun(isOnlyJump)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local openFunc=function()
return xianjieController:openMoJunWin()
end

local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,build_id)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild,'size')
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(buildCfg.x,buildCfg.y,size[1],size[2],buildCfg.size[1],buildCfg.size[2])
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local camerPosY=xianjieController:getMoJunCamerPosY()
if isOnlyJump then
xianjieController:jumpGrid(sceneIdx,gridX_c,gridZ_c,nil,true,nil,camerPosY)
else
xianjieController:jumpGrid(sceneIdx,gridX_c,gridZ_c,openFunc,true,nil,camerPosY)
end
return true
end


function xianjieController:jumpMoJieMoJunYaoMo(isOnlyJump)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local infoguid=nil
local list=xianjieController:getEntitysByEntityType(XJ_ENTITY_TYPE.eMonster)
for i,entity in ipairs(list)do
local monsterData=xianjieModel:getMonsterData(entity.infoguid)
if not entity.dead and monsterData and monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
infoguid=entity.infoguid
break
end
end

if not infoguid then
UIManager.error("没有魔君妖魔，无法跳转")
return false
end

local openFunc=function()
xianjieController:openMonsterInfoWin(infoguid)
end

local monsterData=xianjieModel:getMonsterData(infoguid)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or monsterData.sceneidx
if isOnlyJump then
xianjieController:jumpGrid(sceneIdx,monsterData.gridX_c,monsterData.gridZ_c,nil,true,nil)
else
xianjieController:jumpGrid(sceneIdx,monsterData.gridX_c,monsterData.gridZ_c,openFunc,true,nil)
end
return true
end

function xianjieController:getMoJunCamerPosY()
local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local cameraPosY=seasonModel:getStageConfigEx(seasonType,stageIndex,"cameraPosY")
if webGLHelper:isWebGLOptimization()then
local cameraPosY_MiniGame=seasonModel:getStageConfigEx(seasonType,stageIndex,"cameraPosY_MiniGame")
return cameraPosY_MiniGame or cameraPosY or 30
end
return cameraPosY or 30
end


function xianjieController:jumpMoJieMoJunEffect(idx)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local build_id=mojunData.build_id
local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,build_id)
local effectData=xianjieModel:getMoJunEffectRange(seasonType,stageIndex,idx)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
xianjieController:jumpGrid(sceneIdx,effectData.gridX_c,effectData.gridZ_c,nil,true)
return true
end


function xianjieController:jumpMoJieBox(boxId)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local openFunc=function()
return xianjieController:openMoJunBoxWin(boxId)
end

local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,build_id)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
xianjieController:jumpGrid(sceneIdx,buildCfg.x,buildCfg.y,openFunc,true)
return true
end




function xianjieController:doMoJunBoxMarchRetract(mjBoxData,isInit)
local oTeamHanleID
local march=xianjieModel:getMoJunBoxMarch(mjBoxData.boxId)
if march then
oTeamHanleID=march.teamHandleID
end

local cTime=gameUtilityModel.getServerShortTime2()
local sTime=math.min(mjBoxData.endTime,cTime)
local speed=xianjieModel:getMoJunBoxTeamSpeed()
local wayTime=mjBoxData:getBaseWayTime(speed)
if cTime<sTime+wayTime then
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local retractData={
['dDataType']=mjMoJunBoxMarchTeamType.eRetract,
['dSpeedList']={{param_1=sTime,param_2=speed},},
['dSinceInfo']={mjBoxData.sceneidx,mjBoxData.gridX,mjBoxData.gridZ,mjBoxData.gridWidth,mjBoxData.gridHeight,mjBoxData.endTime},
['dTargetInfo']={sceneidx,gridX,gridZ,gridWidth,gridHeight},
['dCostDuration']={wayTime},
['dHandleFlag']=0,
}

if march then
march:refreshData(retractData)
march:clearBehaviorEx()
march:clearTeamHandle()
march:initTeamHandle()
if not isInit then
march:createBehavior(nil,true)
end
else
local json=jsonHelper.encode(retractData)
march=xianjieModel:addMoJunBoxMarchJson(mjBoxData.boxId,json)
march:initTeamHandle()
if not isInit then
march:createBehavior(nil,true)
end
end

if oTeamHanleID and oTeamHanleID~=march.teamHandleID then
local teamHandle=march:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,oTeamHanleID)
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end
else
if march then
xianjieController:doMoJunBoxMarchDelete(mjBoxData.boxId)
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,oTeamHanleID)
end
end
end

function xianjieController:doMoJunBoxMarchCreate(mjBoxData,isInit)
local speed=xianjieModel:getMoJunBoxTeamSpeed()
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local wayTime=mjBoxData:getBaseWayTime(speed)
local cTime=gameUtilityModel.getServerShortTime2()
local sTime=math.min(mjBoxData.startTime,cTime)
local battleTime=math.max(mjBoxData.endTime-sTime-wayTime,3)
local data={
['dDataType']=mjMoJunBoxMarchTeamType.eNormal,
['dSpeedList']={{param_1=sTime,param_2=speed},},
['dSinceInfo']={sceneidx,gridX,gridZ,gridWidth,gridHeight},
['dTargetInfo']={mjBoxData.sceneidx,mjBoxData.gridX,mjBoxData.gridZ,mjBoxData.gridWidth,mjBoxData.gridHeight,mjBoxData.endTime},
['dCostDuration']={wayTime,battleTime},
['dHandleFlag']=0,
}
local json=jsonHelper.encode(data)
xianjieModel:refreshMoJunBoxMarch(mjBoxData.boxId,json,isInit)
end

function xianjieController:doMoJunBoxMarchDelete(boxId)
xianjieModel:refreshMoJunBoxMarch(boxId,"")
end

function xianjieController:deleteAllMoJunBoxMarchErrorSoureInfo()
local zmPos=xianjieModel:getZongMenOutPos()
local marchs=xianjieModel:getAllMoJunBoxMarch()
for key,march in pairs(marchs)do
local teamHandle=march:getTeamHandle()
local dSinceInfo=march:getMarchData("dSinceInfo")
local sceneidx=dSinceInfo[1]
local x=dSinceInfo[2]
local z=dSinceInfo[3]
if sceneidx~=zmPos[1]or x~=zmPos[2]or z~=zmPos[3]then
if teamHandle.teamType==xjTeamHandleType.eMoJunBoxTeam then
local state=teamHandle:getTeamState()
if state==xjMarchTeamStateType.eNone then
xianjieController:doMoJunBoxMarchDelete(march.guid)
end
end
end
end
end