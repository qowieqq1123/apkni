







activitiesHandle_xianshilibao=new_activitiesHandle('activitiesHandle_xianshilibao',activitiesHandle)

function activitiesHandle_xianshilibao:onInit()

end

function activitiesHandle_xianshilibao.onLiBaoInit(actid,act2id,len,list,lv)

local oldData=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
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
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id,{data=data,lv=lv})

local info=activitiesModel:getSubActInfo(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
if info then
info:checkNewDay()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianShiLiBao)

UIManager:invokeUIMethod("UILimitTimeGiftWin","onRefresh")
UIManager:invokeUIMethod("UILimitTimeGiftWin","showReward")
end



function activitiesHandle_xianshilibao:setLiBaoData(actid,act2id,libaoId,args)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
local data=info.data
self:initLibaoIdData(data,libaoId)
for k,v in pairs(args)do
data[libaoId][k]=v
end
info.data=data
activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id,info)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianShiLiBao)
end

function activitiesHandle_xianshilibao:getLiBaoData(actid,act2id,libaoId)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
local data=info.data
if data and libaoId then
data[libaoId]=data[libaoId]or{}
return data[libaoId]
end
return{}
end

function activitiesHandle_xianshilibao:initLibaoIdData(data,libaoId)
data[libaoId]=data[libaoId]or{}
end

function activitiesHandle_xianshilibao:setLiBaoSelectData(actid,act2id,libaoId,itemListIndex,itemIndex)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
local data=info.data or{}
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
data[libaoId].selectData[itemListIndex]=itemIndex
info.data=data

activitiesModel:setSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id,info)
end

function activitiesHandle_xianshilibao:getLiBaoSelectData(actid,act2id,libaoId,itemListIndex)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
local data=info.data or{}
self:initLibaoIdData(data,libaoId)

data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData[itemListIndex]
end

function activitiesHandle_xianshilibao:getLiBaoSelectAllData(actid,act2id,libaoId)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
local data=info.data or{}
self:initLibaoIdData(data,libaoId)
data[libaoId].selectData=data[libaoId].selectData or{}
return data[libaoId].selectData
end

function activitiesHandle_xianshilibao:getLiBaoZmLevel(actid,act2id)
local info=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eXianShiLiBao,act2id)
return info.lv
end


function activitiesHandle_xianshilibao:autoReceiveFreeGift(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eXianShiLiBao
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
local getItemList=function(act_id,sub_act_id,itemList)
if type(itemList[1][1])=="number"then

local zmLevel=activitiesHandle_xianshilibao:getLiBaoZmLevel(act_id,sub_act_id)
for i=#itemList,1,-1 do
local val=itemList[i]
if val[1]<=zmLevel then
local newList={}
for i2=2,#val do
table.insert(newList,val[i2])
end
return newList
end
end
else
return itemList
end
end
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
local config=activitiesModel:getSubActivityConfig(subType,sub_act_id)
local data=sub_actInfo.data.data
for giftIdx,v in ipairs(config.rewards)do
if v[3]==0 then
local giftData=data[giftIdx]
local buyCount=giftData and giftData.buyCount or 0
if buyCount<v[4]then
if checkReddot then
return true
end
local itemList=getItemList(act_id,sub_act_id,v[1])or defaultT
local indexList={}
for i=1,#itemList do
indexList[i]=1
end
local info={giftIdx,1,1}
for _,selectIdx in ipairs(indexList)do
table.insert(info,selectIdx)
end
local jsonStr=jsonHelper.encode(info)
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end
