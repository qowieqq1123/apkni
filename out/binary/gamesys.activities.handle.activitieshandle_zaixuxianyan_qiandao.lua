







activitiesHandle_zaixuxianyan_qiandao=new_activitiesHandle('activitiesHandle_zaixuxianyan_qiandao',activitiesHandle)

function activitiesHandle_zaixuxianyan_qiandao:onInit()

end

function activitiesHandle_zaixuxianyan_qiandao.recv_249_189(actId,subId,recvflag)
local subType=SUB_ACTIVITY_TYPE.eGuiTuQianDao


local needReqRank=false

local data={recvflag}


activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:invokeUIMethod('ActSub_ZaiXuXianyan_QianDao','refresh',actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

