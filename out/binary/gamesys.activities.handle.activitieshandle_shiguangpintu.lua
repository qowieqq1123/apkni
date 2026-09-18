







activitiesHandle_shiguangpintu=new_activitiesHandle('activitiesHandle_shiguangpintu',activitiesHandle)

function activitiesHandle_shiguangpintu:onInit()

end

function activitiesHandle_shiguangpintu:reqGridReward(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local jstr=jsonHelper.encode({1,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_shiguangpintu:reqRowColReward(actId,subId,rowList,colList)
if#rowList>0 or#colList>0 then
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local jstr=jsonHelper.encode({2,rowList,colList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end
end

function activitiesHandle_shiguangpintu:reqCompleteReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local jstr=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_shiguangpintu:reqTaskReward(actId,subId,taskList)
if#taskList>0 then
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local jstr=jsonHelper.encode({4,taskList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end
end


function activitiesHandle_shiguangpintu.recv_247_81(args)
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local actId=args[1]
local subId=args[2]
local taskLen=args[3]
local taskList=args[4]
local puzzleLen=args[5]
local puzzleList=args[6]
local rowLen=args[7]
local rowList=args[8]
local colLen=args[9]
local colList=args[10]
local allFlag=args[11]

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:initData(taskList,puzzleList,rowList,colList,allFlag)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end



function activitiesHandle_shiguangpintu.recv_247_82(actId,subId,len,list)
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setTaskProgress(list)
end


function activitiesHandle_shiguangpintu.recv_247_83(actId,subId,puzzleIndex,result)
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setGridFlagEx(puzzleIndex,true)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shiguangpintu.recv_247_84(args)
local actId=args[1]
local subId=args[2]
local result=args[3]
local rowLen=args[4]
local rowList=args[5]
local colLen=args[6]
local colList=args[7]
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

for i=1,rowLen do
info:setRowFlag(rowList[i],true)
end
for i=1,colLen do
info:setColFlag(colList[i],true)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shiguangpintu.recv_247_85(actId,subId,result)
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setCompleteFlag(true)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shiguangpintu.recv_247_86(actId,subId,result,taskLen,taskList)
if result~=0 then return end
if taskLen<=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:setTaskFinish(taskList)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end