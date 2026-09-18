







activitiesHandle_guituzhiyin=new_activitiesHandle('activitiesHandle_guituzhiyin',activitiesHandle)

function activitiesHandle_guituzhiyin:onInit()

end

function activitiesHandle_guituzhiyin:onDelete()

end

function activitiesHandle_guituzhiyin.recv_249_194(act_id,sub_act_id,flag,refresh_type)
activitiesModel:setSubActInfoData(act_id,SUB_ACTIVITY_TYPE.eGuiTuZhiYin,sub_act_id,flag)
if refresh_type==0 and flag==0 then
msgWinControl:addMsgWin(msgWinType.eReturningPlayer,{act_id,sub_act_id})
end
if refresh_type==1 and flag==2 then
loginControl:setOpenServerListFlag(true)
loginControl:doLoginOutByDisconnect()
end
end

function activitiesHandle_guituzhiyin:reqSelectReturnWay(actId,subId,type)
local subType=SUB_ACTIVITY_TYPE.eGuiTuZhiYin
local jstr=jsonHelper.encode({1,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end