







activitiesHandle_servertask=new_activitiesHandle('activitiesHandle_servertask',activitiesHandle)







function activitiesHandle_servertask.recv_249_31(actid,act2id,len,goalList,jdReward)
local actType=SUB_ACTIVITY_TYPE.eBigShengChanFullGoal
local goalData={}
local finishNum=0
if goalList then
local config=activitiesModel:getSubActivityConfig(actType,act2id)
local allGoal=config.allGoal
for i,v in ipairs(goalList)do
goalData[v.index]=v
if allGoal[v.index]then
local goal=allGoal[v.index][3]
if tonumber(tostring(v.jdVal))>=goal then
finishNum=finishNum+1
end
end
end
end
local data={goalList=goalData,jdReward=jdReward,finishNum=finishNum}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:callWindowFunc('UISubAct_ServerTaskWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,actType)
end
