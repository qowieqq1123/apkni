
activitiesHandle_longhuxiangyao=new_activitiesHandle('activitiesHandle_longhuxiangyao',activitiesHandle)


function activitiesHandle_longhuxiangyao.recv_249_195(actid,act2id,monster_idx,reward_flag,level)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local actID=actid
local subID=act2id
local data={}
data.monster_idx=monster_idx
data.reward_flag=reward_flag
data.monlevel=level
activitiesModel:setSubActInfoData(actID,subType,subID,data)
end


function activitiesHandle_longhuxiangyao.recv_249_196(actid,act2id,reward_idx)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local actID=actid
local subID=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
data.reward_flag=bitHelper.set_1(data.reward_flag,reward_idx-1)
activitiesModel:setSubActInfoData(actID,subType,subID,data)
local rewards=activitiesModel:getSubActivityConfig(subType,subID,"rewards")
if rewards[reward_idx][1]==0 then
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","refreshSWRewardState")
else
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","refreshRewardList")
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","refreshStageRewardEnter")
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_longhuxiangyao:reqReward(actId,subId,rewardIdx)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local jstr=jsonHelper.encode({rewardIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_longhuxiangyao:RecvBattle_Victory(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.monster_idx=data.monster_idx+1
activitiesModel:setSubActInfoData(actId,subType,subId,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","refreshStageRewardEnter")
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","refreshSWRewardState")
end

function activitiesHandle_longhuxiangyao:OpenActivityMainWin(actId,subId,args)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
activitiesController:jump(actId,subType,subId,args)
end

function activitiesHandle_longhuxiangyao:NextBattle(actId,subId,args)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local monIndex=args.monIndex
local nextmonIndex=monIndex+1
local monster=activitiesModel:getSubActivityConfig(subType,subId,"monster")
local monsterGroupId=monster[nextmonIndex]and monster[nextmonIndex][2]
if not monsterGroupId then
return
end
local mcfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupId)
local fightType=fightPreSelectModel.fightType.longhuxiangyao
local teamList=fightPreSelectModel:getTeamData(fightType)or{}
local temp={}
for k,v in pairs(teamList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local zfId=fightPreSelectModel:getZhenFaData(fightPreSelectModel.fightType.longhuxiangyao)
fightLaunchController:sendFight(eBattleLaunch.longhuxiangyao,temp,mcfg.mapId or 0,zfId,{actId,subType,subId,nextmonIndex})
end

function activitiesHandle_longhuxiangyao:BattleAgain(actId,subId,args)
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local monIndex=args.monIndex
local monster=activitiesModel:getSubActivityConfig(subType,subId,"monster")
local monsterGroupId=monster[monIndex]and monster[monIndex][2]
if not monsterGroupId then
return
end
local mcfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupId)
local fightType=fightPreSelectModel.fightType.longhuxiangyao
local teamList=fightPreSelectModel:getTeamData(fightType)or{}
local temp={}
for k,v in pairs(teamList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local zfId=fightPreSelectModel:getZhenFaData(fightPreSelectModel.fightType.longhuxiangyao)
fightLaunchController:sendFight(eBattleLaunch.longhuxiangyao,temp,mcfg.mapId or 0,zfId,{actId,subType,subId,monIndex})
end


