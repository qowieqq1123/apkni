







activitiesHandle_qingdianqiandao=new_activitiesHandle('activitiesHandle_qingdianqiandao',activitiesHandle)

function activitiesHandle_qingdianqiandao:onInit(actId,subId)

end

function activitiesHandle_qingdianqiandao:onDelete()

end

function activitiesHandle_qingdianqiandao:reqBuQian(actId,subId,day)
local subType=SUB_ACTIVITY_TYPE.eQingDianQianDao
local jstr=jsonHelper.encode({2,day})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_qingdianqiandao:reqLingQu(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eQingDianQianDao
local datas=activitiesModel:getSubActInfoData(actId,subType,subId)
local list={}
for k,v in pairs(datas)do
if v.qdFlag==1 and v.rwFlag==0 then
table.insert(list,k)
end
end
local jstr=jsonHelper.encode({1,list})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_qingdianqiandao.recv_249_148(actId,subId,len,arr)
local subType=SUB_ACTIVITY_TYPE.eQingDianQianDao
local datas={}
if len>0 then
for i,v in ipairs(arr)do
datas[v.day]=v
end
end
activitiesModel:setSubActInfoData(actId,subType,subId,datas)

UIManager:callWindowFunc('UIQingDianQianDaoWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
