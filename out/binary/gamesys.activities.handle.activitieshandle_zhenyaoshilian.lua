







activitiesHandle_zhenyaoshilian=new_activitiesHandle('activitiesHandle_zhenyaoshilian',activitiesHandle)

function activitiesHandle_zhenyaoshilian:onInit()

end

function activitiesHandle_zhenyaoshilian:onEnterState()
end

function activitiesHandle_zhenyaoshilian:onLeaveState()
end


function activitiesHandle_zhenyaoshilian:on_item_changed(subId,itemId)
local subId=subId
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subId)
local costCfg=sub_actcfg.cost[1]
local costId=costCfg[1]
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian

if costId and costId==itemId then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_zhenyaoshilian.recv_249_242(...)
local argList={...}
local args=argList[1]
local actId=args[1]
local subId=args[2]
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData==nil then return end

infoData.challenge_cnt=args[3]
infoData.server_lvl=args[4]
infoData.boxList=args[6]
activitiesModel:setSubActInfoData(actId,subType,subId,infoData)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_zhenyaoshilian.recv_249_243(...)
local argList={...}
local args=argList[1]
local actId=args[1]
local subId=args[2]
local bossIdx=args[3]
local cnt=args[4]
local boxCnt=args[5]
local rewardList=args[7]

local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData==nil then return end

infoData.challenge_cnt=infoData.challenge_cnt+cnt




activitiesModel:setSubActInfoData(actId,subType,subId,infoData)
local args=
{
list=rewardList,
damage=0,
bossIdx=bossIdx,
actId=actId,
subType=subType,
subId=subId,
boxCnt=boxCnt,
}
UIManager:showWindow("UIZYSLShowPrizeWin",args)
end

function activitiesHandle_zhenyaoshilian:setBossBoxCnt(actId,subId,bossIdx,boxCnt)
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if not infoData.boxList then
infoData.boxList={}
end


infoData.boxList[bossIdx]=boxCnt
activitiesModel:setSubActInfoData(actId,subType,subId,infoData)
end

function activitiesHandle_zhenyaoshilian:getBossBoxCnt(actId,subId,bossIdx)
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData.boxList then
return infoData.boxList[bossIdx]
end

return nil
end

function activitiesHandle_zhenyaoshilian:setChallenge_cnt(actId,subId,cnt)
local actId=actId
local subId=subId
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData==nil then return end
if cnt==0 then
infoData.challenge_cnt=0
UIManager:invokeUIMethod("UISubAct_chanllengeBossWin","onNewDay")
else
infoData.challenge_cnt=infoData.challenge_cnt+cnt
UIManager:invokeUIMethod("UISubAct_chanllengeBossWin","refreshCost")
end
activitiesModel:setSubActInfoData(actId,subType,subId,infoData)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

end

function activitiesHandle_zhenyaoshilian:getMonsterLv(subType,subId,server_lvl,idx)
local config=activitiesModel:getSubActivityConfig(subType,subId)
local monster_lvl_conf=config.monster_lvl_conf

if monster_lvl_conf and monster_lvl_conf[idx]then
for k,v in ipairs(monster_lvl_conf[idx])do
if server_lvl>=v[1]and server_lvl<=v[2]then
return v[3]
end
end
end
end

function activitiesHandle_zhenyaoshilian:getCurMemoryBossIdx()
local idx
local data=self:getMemoryBossIdx()

if data and data.bossIdx then
idx=data.bossIdx
end
return idx
end

function activitiesHandle_zhenyaoshilian:getMemoryBossIdx()
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,{})
return data
end

function activitiesHandle_zhenyaoshilian:setMemoryBossIdx(value)
local data=self:getMemoryBossIdx()
if data then
data.bossIdx=value
end
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhenYaoShiLian)
end

function activitiesHandle_zhenyaoshilian:setMemoryBossReddotIdx(index,value)
local data=self:getAllMemoryBossReddotIdx()
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian

if data then
data.bossReddotIdx[index]=value
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhenYaoShiLian)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_zhenyaoshilian:getMemoryBossReddotIdx(index)
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,{})

if not data.bossReddotIdx then
data.bossReddotIdx={true,true,true,true}
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhenYaoShiLian)
end

return data.bossReddotIdx[index]
end

function activitiesHandle_zhenyaoshilian:getAllMemoryBossReddotIdx(beginTime)
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,{})
if not data.bossReddotIdx then
data.bossReddotIdx={true,true,true,true}
end

if not data.beginTime then
data.bossIdx=1
data.beginTime=beginTime
elseif beginTime and beginTime>data.beginTime then
data.bossIdx=1
data.beginTime=beginTime
data.bossReddotIdx={true,true,true,true}
end

userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eZhenYaoShiLian,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhenYaoShiLian)

return data
end