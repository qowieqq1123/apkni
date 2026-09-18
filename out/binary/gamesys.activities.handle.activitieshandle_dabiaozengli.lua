







local _LuaHelper=CS.LuaHelper

activitiesHandle_dabiaozengli=new_activitiesHandle('activitiesHandle_dabiaozengli',activitiesHandle)









local showRewards
local battleRecv
local qiyudata
local _Count=24




function activitiesHandle_dabiaozengli:onEnterState()


end

function activitiesHandle_dabiaozengli:onLeaveState()

end

function activitiesHandle_dabiaozengli:get_showRewards()
return showRewards
end


function activitiesHandle_dabiaozengli.recv_249_146(...)





local args={...}

local subType=SUB_ACTIVITY_TYPE.eDaBiaoZengLi
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end



activitiesHandle_dabiaozengli.onLiBaoInit(actID,subID,args[4],args[5],args[3])
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_dabiaozengli.recv_249_147(...)



local args={...}

local subType=SUB_ACTIVITY_TYPE.eDaBiaoZengLi
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.times=args[3]
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod('UISubAct_dabiaozengli_Win','refreshdabiaoNum')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_dabiaozengli.onLiBaoInit(actid,act2id,len,list,times)






local oldData=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
local data={}
if len>0 then
for i,v in ipairs(list)do
local selectData={}
if oldData[v.param_1]then
selectData=oldData[v.param_1].selectData
end
data[v.param_1]={freebuyCount=v.param_2,buyCount=v.param_3,buyTime=v.param_4,selectData=selectData}
end
end
data.times=times
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id,data)

local info=activitiesModel:getSubActInfo(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
if info then
info:checkNewDay()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDaBiaoZengLi)

UIManager:invokeUIMethod("UISubAct_dabiaozengli_Win","onRefresh")

end



function activitiesHandle_dabiaozengli:setLiBaoData(actid,act2id,libaoId,args)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
self:initLibaoIdData(data,libaoId)
for k,v in pairs(args)do
data[libaoId][k]=v
end
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDaBiaoZengLi)
end

function activitiesHandle_dabiaozengli:getLiBaoData(actid,act2id,libaoId)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
if data and libaoId then
data[libaoId]=data[libaoId]or{}
return data[libaoId]
end
return{}
end

function activitiesHandle_dabiaozengli:initLibaoIdData(data,libaoId)
data[libaoId]=data[libaoId]or{}
end

function activitiesHandle_dabiaozengli:setLiBaoSelectData(actid,act2id,libaoId,itemListIndex,itemIndex)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
data[libaoId].selectData[itemListIndex]=itemIndex

activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id,data)
end

function activitiesHandle_dabiaozengli:getLiBaoSelectData(actid,act2id,libaoId,itemListIndex)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
self:initLibaoIdData(data,libaoId)

data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData[itemListIndex]
end

function activitiesHandle_dabiaozengli:getLiBaoSelectAllData(actid,act2id,libaoId)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDaBiaoZengLi,act2id)
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData
end
