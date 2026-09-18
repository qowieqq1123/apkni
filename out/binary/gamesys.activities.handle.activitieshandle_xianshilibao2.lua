







activitiesHandle_xianshilibao2=new_activitiesHandle('activitiesHandle_xianshilibao2',activitiesHandle)

function activitiesHandle_xianshilibao2:onInit()

end

function activitiesHandle_xianshilibao2.recv_249_160(actid,act2id,len,list)

local oldData=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)or{}
local data={}
if len>0 then
for i,v in ipairs(list)do
local selectData={}
if oldData[v.param_1]then
selectData=oldData[v.param_1].selectData
end
data[v.param_1]={buyCount=v.param_2,buyTime=v.param_3,selectData=selectData}
end
end
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id,data)

local info=activitiesModel:getSubActInfo(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
if info then
info:checkNewDay()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eBuyAct6)

UIManager:invokeUIMethod("UILimitTimeGift2Win","onRefresh")
UIManager:invokeUIMethod("UILimitTimeGift2Win","showReward")
end



function activitiesHandle_xianshilibao2:setLiBaoData(actid,act2id,libaoId,args)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
self:initLibaoIdData(data,libaoId)
for k,v in pairs(args)do
data[libaoId][k]=v
end
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eBuyAct6)
end

function activitiesHandle_xianshilibao2:getLiBaoData(actid,act2id,libaoId)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
if data and libaoId then
data[libaoId]=data[libaoId]or{}
return data[libaoId]
end
return{}
end

function activitiesHandle_xianshilibao2:initLibaoIdData(data,libaoId)
data[libaoId]=data[libaoId]or{}
end

function activitiesHandle_xianshilibao2:setLiBaoSelectData(actid,act2id,libaoId,itemListIndex,itemIndex)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
data[libaoId].selectData[itemListIndex]=itemIndex

activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id,data)
end

function activitiesHandle_xianshilibao2:getLiBaoSelectData(actid,act2id,libaoId,itemListIndex)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
self:initLibaoIdData(data,libaoId)

data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData[itemListIndex]
end

function activitiesHandle_xianshilibao2:getLiBaoSelectAllData(actid,act2id,libaoId)
local data=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eBuyAct6,act2id)
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData
end
