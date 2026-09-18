









local _MODULENAME="fightLaunchRecv"




def_table(_MODULENAME)
fightLaunchRecv.name=_MODULENAME

local recv={

[eBattleLaunch.zongmenMonster]=function(result,log,data)

local guid=data.rand_item_guid
local sdata=isometricMapSystem:getSundriesDataByServerGuid(guid)

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.zongmenMonster,result,log,guid,sdata.id)










end,

[eBattleLaunch.monsterInvade]=function(result,log,data)
local mId=data.monster_group_id

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.monsterInvade,result,log,mId)
end,

[eBattleLaunch.shilianta]=function(result,log,data)
local layer=data.layer
local reward=shiLianTaModel.getLayerReward(layer)
local list={}



local buildingData=shiLianTaModel:getBuildingData()
local isClearAll=false
if result==1 then
if reward then
for i,v in ipairs(reward)do
table.insert(list,{itemid=v[1],itemcount=v[2]})
end
end
isClearAll=cfgHelper.get1(cfg_traintowerconfig_get,layer+1)==nil
shiLianTaModel:setClearLayerData(cfgHelper.get1(cfg_traintowerconfig_get,layer+1)==nil,isClearAll and layer or layer+1)
notifySystem:postNotify(notifyConfig.shilianta_change,layer,layer+1,isClearAll)
end

xiaodaotongModel:set_daily_time('daily_slt_time')
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.shilianta,result,log,
layer,buildingData,list,isClearAll)

if not shiLianTaController.hideStage then
isometricMapSystem:enterBattleMode()
end
end,

[eBattleLaunch.jiuyouta]=function(result,log,data)
local layer=data.layer_id
local score=data.score
local list={}
local package=fightResultModel:getPackageResutl(log)
if package then
for i,v in ipairs(package.prizeList)do
table.insert(list,{itemid=v.itemid,itemcount=v.num})
end
end

JiuYouTaModel:setFightingLayer(layer)



local buildingData=shiLianTaModel:getBuildingData()
local isClearAll=false
if result==1 then
isClearAll=JiuYouTaModel:isClearAll(layer)
if layer>JiuYouTaModel:getClearLayer()then
JiuYouTaModel:setClearLayer(layer)
end

local old=JiuYouTaModel:getScore(layer)
if score>old then
JiuYouTaModel:setScore(layer,score)
end
end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.jiuyouta,result,log,layer,buildingData,list,isClearAll)

if not JiuYouTaController.hideStage then
isometricMapSystem:enterBattleMode()
end
end,

[eBattleLaunch.wudaotang]=function(result,log,data)
local guid=data.guid
local randjingjieexp=data.randjingjieexp
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.wudaotang,result,log,guid,randjingjieexp)
end,

[eBattleLaunch.doufatai]=function(result,log,data)
local subType=data.subtype
local actorName=data.tar_actor_name
local times=data.times
local wendao=data.wendao
local honor=data.honor
local dailyHonor=data.daily_honor
local newRank=data.new_rank
local rewards={}
local rewardsLen=0
local shareStr=data.share_str
local actorId=data.dftRobotId
local dftRobotType=data.dftRobotType
local tzNum=data.tzNum

local doufataiData=douFaTaiModel:get_doufatai_data()
douFaTaiModel:setLastData(doufataiData)
douFaTaiModel:set_doufatai_tzNum(tzNum)
douFaTaiModel:checkChangeDailyRewardFlag(doufataiData.rank,newRank)
douFaTaiModel:set_tempHonorToday(douFaTaiModel:get_honorToday())
douFaTaiModel:set_honorToday(data.daily_honor)
douFaTaiModel:update_doufatai_freenum()
douFaTaiController:req_doufatai_data()
douFaTaiController:req_rank_data()
douFaTaiController:req_fight_record()

local sendExtraArgs=fightModel:getSendExtraArgs(eBattleType.doufatai)
if not(sendExtraArgs and sendExtraArgs.isSkip)then
isometricMapSystem:enterBattleMode()
end

local winArgs={wendao,honor,dailyHonor,newRank,rewardsLen,rewards,actorId,shareStr,dftRobotType}
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.doufatai,
result,log,winArgs)

end,

[eBattleLaunch.mystery]=function(result,log,data)
local teamId=data.teamid

local package=fightResultModel:getPackageResutl(log)
if package then
local rewards=package.prizeList or{}
for i,v in ipairs(rewards)do
mysteryTreasureModel:recordItem(v.itemid,v.num,v.itemguid)
end
mysteryFightModel:set_fighting_reward(rewards)
end
mysteryTreasureModel:saveRecordItemList()

if mysteryFightModel:has_battle_playing()then

mysteryFightModel:enqueue_result_callback(mysteryFightController.play_fight,teamId,result,log)
else
mysteryFightController.play_fight(teamId,result,log)
end
end,

[eBattleLaunch.mysteryPoint]=function(result,log,data)
local tzId=data.tzId


local package=fightResultModel:getPackageResutl(log)
if package then
local rewards=package.prizeList or{}
for i,v in ipairs(rewards)do
mysteryTreasureModel:recordItem(v.itemid,v.num,v.itemguid)
end
mysteryFightModel:set_fighting_reward(rewards)
end
mysteryTreasureModel:saveRecordItemList()

notifySystem:postNotify(notifyConfig.on_mystery_fight_start)

MysteryController:slideUI()

UIFullMysteryMainControl:hideMysteryMainWindow()

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.mystery,result,log,{})

if result==eMysteryFightResultType.eVictory then
local pos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
local entity=mysteryChallengePointModel:get_entity_by_pos(pos,roomId)
if not entity then
return
end

mysteryChallengePointModel:remove_entity(entity.guid)
end
end,

[eBattleLaunch.experience]=function(result,log,data)
local point=data.lilianid
local rewards={}

notifySystem:postNotify(notifyConfig.onTriggerBattle,
eBattleType.worldExperience,result,log,point)
end,

[eBattleLaunch.worldMonster]=function(result,log,data)
local areaId=data.areaid
local guidPos=data.guidPos
local monster=worldMonsterModel:get_monster(guidPos)

local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,monster.posId})
local lockWorld=huntMonsterTeamModel:findMonsterWorld(unitKey)
if lockWorld then
huntMonsterTeamController:recvTeamFightResult(result,log,lockWorld,unitKey)
else
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
local task=worldTaskModel:getTask(taskKey)
if task then
if monster then
local aid,Idx=worldMonsterModel:get_idx(guidPos)
worldMonsterModel:set_task_result(monster.posId,monster.posData,result,log,areaId,Idx,monster.worldMonsterId)
end
if result==fightResultType.Victory then
worldMonsterController.remove_monster(areaId,guidPos,true)
end
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
else
if result==fightResultType.Victory then
worldMonsterController.remove_monster(areaId,guidPos,true)
if monster then
worldMonsterController:remove_monster_unit(monster.posId)
end
end
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end
end
end,

[eBattleLaunch.resPoint]=function(result,log,data)
local guid=data.guid
local subIdx=data.op_idx
local pointData=worldResPointDataModel:getPointData(guid)
local world=pointData.world
local level=pointData.level
local subPointData=pointData.datas[subIdx]
local subId=subPointData[2]
local battleCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,battleCfg.groupid)

local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local lockWorld=huntMonsterTeamModel:findMonsterWorld(unitKey)
if lockWorld then
huntMonsterTeamController:recvTeamFightResult(result,log,lockWorld,unitKey)
else
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
local task=worldTaskModel:getTask(taskKey)
if task then
worldResPointFightModel:setFightResult(guid,subIdx,subId,world,result,log,level)
if result==fightResultType.Victory then
worldResPointDataModel:clearSubPointData(guid,subIdx)
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end
else
if result==fightResultType.Victory then
worldResPointDataModel:clearSubPointData(guid,subIdx)
worldResPointController:hideResPointUnitEx(guid,subIdx)
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end
end
end
end,

[eBattleLaunch.family]=function(result,log,data)
local subType=data.subtype
local world=data.world_id
local guid=data.guid

worldXiuZhenJiaZuModel:setFightResult(guid,result,log,world,subType)
if subType==1 then

elseif subType==2 then

else

end
end,

[eBattleLaunch.qiyuEvent]=function(result,log,data)
local sysId=data.sysId

local info=MysteryEventModel:get_current_result_data(MysteryEventResult.EventResultType.fighting)
local nIndex=info[2]
local args=info[1]
local rewards={}

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.qiyuEvent,result,log,sysId,args,nIndex,nil,rewards)
MysteryEventModel:clear_current_result_data(MysteryEventResult.EventResultType.fighting)
end,


[eBattleLaunch.testFight]=function(result,logidx,data)
local log=fightResultModel:getPackageResutl(logidx)
fightController:startBallte(log.logStr,true)
end,

[eBattleLaunch.npcPK]=function(result,log,data)
local npctype=data.npctype
local npcid=data.npcid
local intimacy=data.intimacy
local interacttimes=data.interacttimes
local interacttype=NPC_INTERACT_TYPE.ePK
local old=npcModel:getNPCIntimacy(npcid)
local lerp=intimacy-old
npcModel:setNPCIntimacy(npcid,intimacy)
npcModel:refreshNPCItemData(npcid,interacttype,interacttimes)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.npcPK,result,log,npcid,lerp)
end,
[eBattleLaunch.tuitu]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tuitu,result,log,data.rewardLsit)
end,
[eBattleLaunch.huanjing]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.huanjing,data.pass_result,log,data)
end,
[eBattleLaunch.lingShanZhengDuo]=function(result,log,data)
if data.fight_flag==1 then
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.lingShanZhengDuo,result,log,data)
else
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.lingShanZhengDuo2,result,log,data)
end
end,

[eBattleLaunch.tianyuanshouchao]=function(result,log,data)
local slGuild=data.slGuild
if mathHelper.validInt64(slGuild)then

xianmengModel:refreshChallengeNum2_TYSC(slGuild)

timeEventController.delayDo(0.2,function()
loadingControl.closeCloud()
end)
else
xianmengModel:refreshChallengeNum1_TYSC()

timeEventController.delayDo(0.2,function()
loadingControl.closeCloud()
end)
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','refreshChallengeNum')
end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tianyuanshouchao,result,log,data)
end,

[eBattleLaunch.xianmengdigong]=function(result,log,data)
xianmengdigongController:onBattleBack(result,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.xianmengdigong,result,log,data)
end,

[eBattleLaunch.fabaoshilian]=function(result,log,data)
local sub_actInfo=activitiesModel:getSubActInfo(data.actid,SUB_ACTIVITY_TYPE.eFaBaoShiLian,data.act2id)
if sub_actInfo then
sub_actInfo:onKillMonster(data.monidx,result)
end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.fabaoshilian,result,log,data)
end,

[eBattleLaunch.worldLeader]=function(result,log,data)
if data.assistant~=1 then

worldLeaderModel:pushFightData(result,log,data)
else
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.worldLeader,result,log,data)
end
end,

[eBattleLaunch.jiucengyaolou]=function(result,log,data)
if result==fightResultType.Victory then
local infoData=activitiesModel:getSubActInfoData(data.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,data.act2_id)
local updateData={}
local floor=data.floor
if infoData.floor<data.floor then
updateData.floor=data.floor
end
if not infoData.passList[floor]or infoData.passList[floor]<data.citiaolistlen then
updateData.passList=infoData.passList
updateData.passList[floor]=data.citiaolistlen
end

if next(updateData)then
activitiesHandle_jiucengyaolou.updateFloorData(data.act_id,data.act2_id,updateData)
end
local canGet=activitiesHandle_jiucengyaolou:canGotReward(data.act_id,data.act2_id,data.floor)
data.canGet=canGet
end

if data.hasreward==1 then
activitiesHandle_jiucengyaolou:pushFightData(result,log,data)
else
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.jiucengyaolou,result,log,data)
end

end,

[eBattleLaunch.zongmendabi]=function(result,log,data)
local sub_actInfo=activitiesModel:getSubActInfo(data.act_id,SUB_ACTIVITY_TYPE.eSectCompetition,data.act2_id)
if sub_actInfo then
sub_actInfo:onBattleBack(data)
end
activitiesHandle_zongmendabi:onBattleResult(result,log,data)
end,

[eBattleLaunch.lingxuwenjian]=function(result,log,data)
if log==nil then
lingxuwenjianController:onBattleBackError(data)
else
lingxuwenjianController:onBattleBack(result,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.lingxuwenjian,result,log,data)
end
end,

[eBattleLaunch.xianfawendao]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.xianfawendao,result,log,data)
end,

[eBattleLaunch.yunchengtanbao]=function(result,log,data)
local sub_actInfo=activitiesModel:getSubActInfo(data.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,data.act2_id)
if sub_actInfo then
local _data=activitiesModel:getSubActInfoData(data.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,data.act2_id)
if _data==nil then return end
_data.monster_bits=data.monster_bits
activitiesModel:setSubActInfoData(data.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,data.act2_id,_data)
end
activitiesHandle_yunchengtanbao:onBattleResult(result,log,data)
end,

[eBattleLaunch.qiecuo]=function(result,log,data)
local myactorid=playerModel:getActorID()
local myseverid=playerModel:getActorServerID()
local duishouactorid=data.actorid
local duishouseverid=data.serverid
local selfFright=data.attackfight or nil
local otherFright=data.defendfight or nil

local resultdata=data.ret
if resultdata==1 then

UIManager.error('对方拒绝切磋请求')
return
elseif resultdata==2 then
UIManager.error('对方未设置斗法台切磋阵容，不能切磋')
return
end

DiZiDuelModel:adddueltimes()
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.qiecuo,result,log,{myactorid,myseverid,duishouactorid,duishouseverid,selfFright,otherFright})
end,


[eBattleLaunch.wuxingdian]=function(result,log,data)
data.jie=wuXingDianModel:getCurJie()
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.wuxingdian,result,log,data)
end,

[eBattleLaunch.tianmoruqin_tm]=function(result,log,data)
local errCode=data.ret
if errCode==0 then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=data.actid
local subId=data.act2id
local monsterGuid=data.mongroupguid
local monsterId=data.mongroupid
local totaldamage=data.totaldamage

local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)

if subActInfo and subActInfo:checkDoing()then
local subActConfig=activitiesModel:getSubActivityConfig(subType,subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local monType=monsterCfg.monType

subActInfo:updateBookKill(monsterId,totaldamage)
local updateSuccess=subActInfo:updateRankDamage(monsterGuid,totaldamage)

local maxBlood=subActInfo:getMaxBloods(monType)
local isDead=tonumber(tostring(totaldamage))>=tonumber(tostring(maxBlood))

local index=subActInfo:findMonsterIndex(monsterGuid)
if index then

local monsterData=subActInfo:getMonsterData(index)
monsterData.fighted=monsterData.fighted+1
if monsterData.since<=0 then
monsterData.since=timeHelper.getServerShortTime()
end
monsterData.damage=totaldamage

if not updateSuccess then
subActInfo:addRankData(monsterData,TianMoRuQinQingBaoType.eSelf)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end

if isDead then
subActInfo:refreshWorldBeiMonster(index)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
else
subActInfo:refreshWorldBeiHUD(index)





end
end
end

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tianmoruqin_tm,result,log,data)
else
if errCode==1 then
UIManager.error('挑战人数已满')
elseif errCode==2 then
UIManager.error('怪物已被他人击败')
elseif errCode==3 then
UIManager.error('怪物已离开')
else
UIManager.error(FMT.fmt('天魔挑战失败，错误码：{0}',errCode))
end



end
end,

[eBattleLaunch.tianmoruqin_sj]=function(result,log,data)
if result==fightResultType.Victory then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=data.actid
local subId=data.act2id
local eventIdx=data.aimidx
local monsterIdx=data.idx
local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
local guid=subActInfo:removeExMonsterEx(eventIdx,monsterIdx)
if guid and worldController:isInWorld()then
subActInfo:hideWorldEventMonster(guid)
end
end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tianmoruqin_sj,result,log,data)
end,

[eBattleLaunch.yunyouMerchant]=function(result,log,data)
if yunyouMerchantModel:hasData()then
yunyouMerchantModel:updateDamagePercent(data.damage)
local merchantData=yunyouMerchantModel:getData()
data.monLevel=merchantData.monLevel
data.refreshTimes=merchantData.refreshTimes
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.yunyouMerchant,result,log,data)
end
end,

[eBattleLaunch.qieshishenshou]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.qieshishenshou,result,log,data)
end,

[eBattleLaunch.taigushilian]=function(result,log,data)


local actid=data.actid
local subType=SUB_ACTIVITY_TYPE.eTaiGuShiLian
local subid=data.act2id
local bossid=data.bossid
local guankaIdx=data.lvid
local ret=data.ret
local damage=data.damage



if ret==0 then
if damage and type(damage)~="number"then
damage=mathHelper.int64_to_number(damage)
end
if result==1 then
damage=-damage
end
local bossData=cfg_taigushilianconfig_get(subid).boss
local mosterdata=bossData[bossid][1]
local mosterid=mosterdata[guankaIdx][1][1]
local mosterlevel=mosterdata[guankaIdx][2]or 1
local rewards={}
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,mosterid)
if monsterCfg.drops and monsterCfg.drops[1]then
rewards=worldFightModel:getMonsterShowAwardsEx2({monsterCfg.drops[1]},mosterlevel)
end

local historydamage=activitiesHandle_taiguBoss:checkBossNanDuPass(actid,subType,subid,bossid,guankaIdx)or 0
activitiesHandle_taiguBoss:setBossJieDuanDamege(actid,subType,subid,bossid,guankaIdx,damage)

local json_str=jsonHelper.encode({1,bossid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)

if result==2 then
if guankaIdx<4 then
result=4
end
end
local newdata={actid,subType,subid,bossid,guankaIdx,ret,damage,historydamage,rewards,result}
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.taigushilian,result,log,newdata)
else
if ret==1 then
UIManager.error('怪物未开始')
elseif ret==2 then
UIManager.error('怪物已击败')
end
end
end,

[eBattleLaunch.visitorChallenge]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.visitorchallenge,result,log,data)
end,

[eBattleLaunch.houshanzhenling]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.houshanzhenling,result,log,data)
end,

[eBattleLaunch.fuyaoshilian]=function(result,log,data)


local actid=data.actid
local subType=SUB_ACTIVITY_TYPE.eFuYaoShiLian
local subid=data.act2id
local bossid=data.bossid
local guankaIdx=data.lvid
local ret=data.ret
local damage=data.damage



if ret==0 then
if damage and type(damage)~="number"then
damage=mathHelper.int64_to_number(damage)
end
if result==1 then
damage=-damage
end
local bossData=cfg_fuyaoshilianconfig_get(subid).boss
local mosterdata=bossData[bossid][1]
local mosterid=mosterdata[guankaIdx][1]
local mosterlevel=mosterdata[guankaIdx][2]or 1
local rewards={}
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,mosterid)
if monsterCfg.drops and monsterCfg.drops[1]then
rewards=worldFightModel:getMonsterShowAwardsEx2({monsterCfg.drops[1]},mosterlevel)
end

local historydamage=activitiesHandle_fuyaoBoss:checkBossNanDuPass(actid,subType,subid,bossid,guankaIdx)or 0
activitiesHandle_fuyaoBoss:setBossJieDuanDamege(actid,subType,subid,bossid,guankaIdx,damage)




if result==2 then
if guankaIdx<4 then
result=4
end
end
local newdata={actid,subType,subid,bossid,guankaIdx,ret,damage,historydamage,rewards,result,true}
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.fuyaoshilian,result,log,newdata)
else
if ret==1 then
UIManager.error('怪物未开始')
elseif ret==2 then
UIManager.error('怪物已击败')
end
end
end,

[eBattleLaunch.longhuxiangyao]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.longhuxiangyao,result,log,data)
end,

[eBattleLaunch.sifangpingyao]=function(result,log,data)







local demons_id=data.demons_id
local chapter_id=data.chapter_id
local point_id=data.demons_point
local select_len=data.select_len
local recvFazeList=data.recvFazeList
local len=data.len
local fazeList=data.fazeList


if len and len>0 then
if fazeList then
local list={}
local allfz_list=SiFangPingYaoModel:getBagFZ_list()

for k,v in ipairs(allfz_list)do
for i,j in ipairs(fazeList)do
if v.param_1==j.param_1 and v.param_2==j.param_2 then
if j.param_3>0 then
v.param_4=j.param_3
table.insert(list,v)
end
else
table.insert(list,v)
end
end
end
SiFangPingYaoModel:setBagFZ_list(list)

end
end

if select_len and select_len>0 then
if recvFazeList then
SiFangPingYaoModel:setSeltFZ_list(recvFazeList)
end
if chapter_id<3 and point_id==1000 then
SiFangPingYaoModel:setchoice_bits(1)
end

end

SiFangPingYaoModel:settgflag(false)
if chapter_id==3 and point_id==1000 then
SiFangPingYaoModel:settgflag(result)
SiFangPingYaoModel:setywbattle(true)

end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.sifangpingyao,result,log,data)
end,

[eBattleLaunch.dujiexiandan]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.dujiexiandan,result,log,data)
end,
[eBattleLaunch.chisejindi]=function(result,log,data)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local actId=data.act_id
local subId=data.act2_id
local nextLen=data.len
local nextRounds=data.roundList
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local copyData=info:getCopy()
if copyData then
local roundData=nextLen>0 and nextRounds[1]or nil
info:fightResultHandle(result,roundData)
data.hp=copyData.hp
data.level=copyData.level

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.chisejindi,result,log,data)
end
end
end,

[eBattleLaunch.zhenyaoshilian]=function(result,log,data)

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.zhenyaoshilian,result,log,data)
end,

[eBattleLaunch.tianmojie]=function(result,log,data)
if data.ret==0 then
local monsterData=tianMoJieModel:getMonster(data.actorid,data.tmguid)
if monsterData then
data.tmid=monsterData.id
tianMoJieController:onFightMonster(result,data)
if not playerModel:checkActorId(data.actorid)or data.newpercent<=0 then
tianMoJieModel:pushFightData(result,log,data)
else

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tianmojie,result,log,data)
end
return
else
loggerUtil.logErrFMT("没有找到对应天魔劫怪物：{0}",data.tmguid)
end
elseif data.ret==1 then
UIManager.error("今日协助次数超限")
elseif data.ret==2 then
UIManager.error("弟子今日已出战过")
elseif data.ret==3 then
UIManager.error("怪物已击败")
elseif data.ret==4 then
UIManager.error("非同仙盟成员无法协助挑战")
end


if fullScreenUI.isActiveFullEx(FULL_TYPE.eFightPrepare)then
local win=UIManager:findActiveWindow("UIFightPrepareWin")
if win then
win.needClosePreSelectStage=true
win:onCancelButton()
end
end
end,

[eBattleLaunch.xianjiePlotMonster]=function(result,log,data)
local cloudid=data.cloudid
local plotIdx=data.idx
local finish
if result==fightResultType.Victory then
finish=1
else
finish=0
end
xianjieController.recv_protocol_37_4(cloudid,plotIdx,finish)
end,

[eBattleLaunch.xunbaoshilian]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.xunbaoshilian,result,log,data)
end,

[eBattleLaunch.wdcqxiweisai]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.wdcqxiweisai,result,log,data)
end,

[eBattleLaunch.xianjieResPoint]=function(result,log,data)
local rpGuid=data.guid
local json=data.client_data
local res=data.res
local reward_len=data.reward_len
local rewardList=data.rewardList

local march=xianjieModel:getResPointMarch(rpGuid)
if march.behaviorID then
local isReqData=march:getBehaviorData('isReqData')
if isReqData then
march:setBehaviorData('isReqData',nil)
march:setBehaviorData('isGotoOver',true)
xjBehaviorManager:triggerUpdate(march.behaviorID)
else
loggerUtil.logErrFMT("资源点行军已接收过战斗返回, isReqData={0}",isReqData)
end
else
loggerUtil.logErrFMT("资源点战斗返回，没有行军行为树ID")
end
if res==1 then

local isVictory=result==fightResultType.Victory
local rpMarch=xianjieModel:getResPointMarch(rpGuid)
if rpMarch then
local teamHandle=rpMarch:getTeamHandle()
if teamHandle.teamType==xjTeamHandleType.eResPointTeam then
local state,times,lerp=teamHandle:getTeamState()
local workTime=nil
if state==xjMarchTeamStateType.eGoto then
workTime=times[4]
elseif state==xjMarchTeamStateType.eBattle then
workTime=times[2]
elseif state==xjMarchTeamStateType.eBack then
workTime=times[1]
end
if workTime then




if isVictory then
local rpData=xianjieModel:getResPointData(rpGuid)
if rpData then
rpData.deadTime=workTime
xianjieModel:setResPointCDLookup(rpData)
end
end
return
end
end
end
if isVictory then
xianjieModel:refreshResPointData(rpGuid,nil,false)
end

elseif res==2 then

end
end,

[eBattleLaunch.xianjieFuMo]=function(result,log,data)



notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.xianjiefumo,result,log,data)
end,

[eBattleLaunch.gubaoshilian]=function(result,log,data)
local _data={
actId=data.actid,
subType=SUB_ACTIVITY_TYPE.eGuBaoShiLian,
subId=data.act2id,
layer=data.layer_id,
}
local info=activitiesModel:getSubActInfo(_data.actId,_data.subType,_data.subId)
if info then
info:setData(_data.layer)
info:setRankDirty()
end
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.gubaoshilian,result,log,_data)
end,

[eBattleLaunch.yanfage]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.yanfage,result,log,data)
end,

[eBattleLaunch.xianjunyanzhen]=function(result,log,data,guid)
XianJunYanZhenController.recv_play_fight(result,log,data)
end,


[eBattleLaunch.activitiesPushMap]=function(result,log,data)

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.activitiesPushMap,result,log,data)
end,

[eBattleLaunch.xjCaravanEscort]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.xjCaravanEscort,result,log,data)
end,

[eBattleLaunch.mingyuanzhusha]=function(result,log,data)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.mingyuanzhusha,result,log,data)
end,
}

function fightLaunchRecv:getHandle(eType)
return recv[eType]
end



local fightMulitResultType={
[eBattleLaunch.zongmendabi]=eFightMulitResultType.ResultTimes,
[eBattleLaunch.lingxuwenjian]=eFightMulitResultType.ResultTimes,
[eBattleLaunch.xianfawendao]=eFightMulitResultType.ResultTimes,
[eBattleLaunch.wdcqxiweisai]=eFightMulitResultType.ResultTimes,
[eBattleLaunch.xianjunyanzhen]=eFightMulitResultType.ResultOneTimes,
}

function fightLaunchRecv:getRecvMulitResultType(eType)
return fightMulitResultType[eType]or eFightMulitResultType.AndVictory
end
