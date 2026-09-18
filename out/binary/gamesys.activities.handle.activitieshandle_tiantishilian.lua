





activitiesHandle_tiantishilian=new_activitiesHandle('activitiesHandle_tiantishilian',activitiesHandle)

function activitiesHandle_tiantishilian:onInit()

end

function activitiesHandle_tiantishilian.recv_249_115(...)



local args={...}
args=args[1]

local subType=SUB_ACTIVITY_TYPE.eTianTiShiLian
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfo(actID,subType,subID)

if data==nil then return end

data.totalfloor=args[3]+args[6]
data.aimflag=mathHelper.int64_to_number(args[4])
data.lastsec=timeHelper.convertLongStamp(args[5])
data.todayfloor=args[6]
data.boxcnt=args[7]

local state=timeHelper.isTodayStamp(data.lastsec)
data.isReceiveJoinReward=state

local aimIndex=0
for i=1,64 do
if bitHelper.check_pos(data.aimflag,i-1)then
aimIndex=i
else
break
end
end
data.aimIndex=aimIndex

activitiesModel:setSubActInfoData(actID,subType,subID,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod("UISubAct_TianTiShiLianWin","refresh")
UIManager:invokeUIMethod("UISubAct_TianTiShiLian_AchieveWin","refresh")
end

function activitiesHandle_tiantishilian:sendFinishFloor(act_id,sub_act_id,floornum,rewardboxnum)
local params=FMT.fmt('[1,{0},{1}]',floornum,rewardboxnum or 0)
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,SUB_ACTIVITY_TYPE.eTianTiShiLian,sub_act_id,params)
end

function activitiesHandle_tiantishilian:sendAchieveReward(act_id,sub_act_id,rewardindex)
local params=FMT.fmt('[2,{0}]',rewardindex)
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,SUB_ACTIVITY_TYPE.eTianTiShiLian,sub_act_id,params)
end

function activitiesHandle_tiantishilian.checkAchieve(act_id,subType,sub_act_id)
local data=activitiesModel:getSubActInfo(act_id,subType,sub_act_id)
local config=activitiesModel:getSubActivityConfig(subType,sub_act_id)
local checkid=data.aimIndex+1
if config.aim[checkid]then
if data.totalfloor>=config.aim[checkid][1]then
return true
end
end
return false
end



