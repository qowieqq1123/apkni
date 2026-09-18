







activitiesHandle_limitInvestor=new_activitiesHandle('activitiesHandle_limitInvestor',activitiesHandle)

function activitiesHandle_limitInvestor.recv_249_32(actid,act2id,flag,exflag,ex)
local actType=SUB_ACTIVITY_TYPE.eXianShiInvest

local oldData=activitiesModel:getSubActInfoData(actid,actType,act2id)
if oldData then
if oldData.ex==0 and ex==1 then
local list={}
local config=activitiesModel:getSubActivityConfig(actType,act2id)
local Info=activitiesModel:getSubActInfo(actid,actType,act2id)
local dayOut=Info:getDayOut()
for i,v in ipairs(config.exreward)do
if i<=dayOut and not bitHelper.check_pos(exflag,i-1)then
table.insert(list,i)
end
end
if next(list)then
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,actType,act2id,jsonHelper.encode(list))
end

end
end

local data={flag=flag,exflag=exflag,ex=ex}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,actType)
UIManager:callWindowFunc('ActSub_limitInvestorWin','refresh')
end
