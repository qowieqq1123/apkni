







activitiesHandle_tainmingjinjie=new_activitiesHandle('activitiesHandle_tainmingjinjie',activitiesHandle)

function activitiesHandle_tainmingjinjie:onInit(actId,subId)

end

function activitiesHandle_tainmingjinjie:onDelete()

end

function activitiesHandle_tainmingjinjie:reqReceive(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTianMingJinJie
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tainmingjinjie.recv_247_75(actId,subId,len,arr,index)
local subType=SUB_ACTIVITY_TYPE.eTianMingJinJie
local data={}
data.progress=arr
data.rewardIndex=index
activitiesModel:setSubActInfoData(actId,subType,subId,data)

UIManager:callWindowFunc('UITianMingJinJieWin','refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_tainmingjinjie.recv_247_76(actId,subId,result,index)
if result~=0 then
UIManager.error('领取失败')
return
end
local subType=SUB_ACTIVITY_TYPE.eTianMingJinJie
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.rewardIndex=index

UIManager:callWindowFunc('UITianMingJinJieWin','refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end