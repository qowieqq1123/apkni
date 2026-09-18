





activitiesHandle_fuxinggaozhao=new_activitiesHandle('activitiesHandle_fuxinggaozhao',activitiesHandle)

function activitiesHandle_fuxinggaozhao:onInit()

end


function activitiesHandle_fuxinggaozhao:send_play(actid,act2id,idx)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eFuXingGaoZhao,act2id,jsonHelper.encode({1,idx}))
end

function activitiesHandle_fuxinggaozhao:send_get_reward(actid,act2id)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eFuXingGaoZhao,act2id,jsonHelper.encode({2}))
end

function activitiesHandle_fuxinggaozhao.recv_249_56(args)
local subType=SUB_ACTIVITY_TYPE.eFuXingGaoZhao
local actid,act2id,ownListLen,ownList,ranklistlen,ranklist,luckynum,recv=unpack(args)

local data=
{
ownList=ownList,
ranklist=ranklist,
luckynum=luckynum,
recv=recv,
}

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_fuxinggaozhao_Win","onRecv")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_fuxinggaozhao.recv_249_57(actid,act2id,ownListLen,ownList)
local subType=SUB_ACTIVITY_TYPE.eFuXingGaoZhao

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)

local animType=1
local oldList=data.ownList
if oldList then
local one=oldList[1]

if one.number==ownList[1].number and ownListLen>1 then
animType=2
end
else
if ownListLen>1 then
animType=3
end
end

data.ownList=ownList

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_fuxinggaozhao_Win","onRecv",animType)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_fuxinggaozhao.recv_249_58(actid,act2id,ranklistlen,ranklist,luckynum)
local subType=SUB_ACTIVITY_TYPE.eFuXingGaoZhao

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.ranklist=ranklist
data.luckynum=luckynum

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_fuxinggaozhao_Win","onRecv")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_fuxinggaozhao.recv_249_59(actid,act2id,recv)
local subType=SUB_ACTIVITY_TYPE.eFuXingGaoZhao

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.recv=recv

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_fuxinggaozhao_Win","onRecv")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
