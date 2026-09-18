







activitiesHandle_wanzongduijue=new_activitiesHandle('activitiesHandle_wanzongduijue',activitiesHandle)







function activitiesHandle_wanzongduijue:onInit()

end


function activitiesHandle_wanzongduijue.recv_247_77(actid,act2id,stageLen,stageList)





local subType=SUB_ACTIVITY_TYPE.eWanZongDuiJue
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo==nil then return end
local taskLookup=subActInfo:initTaskLookup()
if stageLen>0 then
for i,v in ipairs(stageList)do
local d=taskLookup[v.param_1]
if d~=nil then
d:setData(v.param_2,v.param_4,v.param_3)
end
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_wanzongduijue.recv_247_78(actid,act2id,stage,rewardFlag)


local subType=SUB_ACTIVITY_TYPE.eWanZongDuiJue
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local taskLookup=data.taskLookup
if taskLookup==nil then return end
local taskData=taskLookup[stage]
if taskData==nil then return end
taskData:setData3(rewardFlag)
UIManager:invokeUIMethod('UISubAct_wzdjMainWin','rec_reward',stage)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_wanzongduijue.recv_247_79(args)










local actid=args[1]
local act2id=args[2]
local stage=args[3]
local score=args[4]
local len=args[5]
local rankList=args[6]
local subType=SUB_ACTIVITY_TYPE.eWanZongDuiJue
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo==nil then return end
local isChanged=subActInfo:refreshRankList(stage,rankList,score)
if isChanged==true then
UIManager:invokeUIMethod('UISubAct_wzdjMainWin','rec_rank',stage)
end
UIManager:invokeUIMethod('UISubAct_wzdjMainWin','rec_ranklist',stage)
UIManager:invokeUIMethod('UISubAct_wzdjRankWin','rec_ranklist',stage)
end


function activitiesHandle_wanzongduijue.recv_247_80(actid,act2id,stage,score,rank)




local subType=SUB_ACTIVITY_TYPE.eWanZongDuiJue
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local taskLookup=data.taskLookup
if taskLookup==nil then return end
local taskData=taskLookup[stage]
if taskData==nil then return end

local changeScore=taskData:setData2(score,rank)
UIManager:invokeUIMethod('UISubAct_wzdjMainWin','rec_score',stage,changeScore)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_wanzongduijue.recv_247_91(actid,act2id,len,list)





local subType=SUB_ACTIVITY_TYPE.eWanZongDuiJue
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local taskLookup=data.taskLookup
if taskLookup==nil then return end
if len>0 then
local taskData,stage,score
for i,v in ipairs(list)do
stage=v.param_1
score=v.param_2
taskData=taskLookup[stage]
if taskData~=nil then
taskData:setData4(score)
UIManager:invokeUIMethod('UISubAct_wzdjMainWin','rec_score',stage,true)
end
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end