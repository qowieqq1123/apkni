





activitiesHandle_tanxianduitequan=new_activitiesHandle('activitiesHandle_tanxianduitequan',activitiesHandle)

function activitiesHandle_tanxianduitequan:onInit()

end

function activitiesHandle_tanxianduitequan.recv_249_113(...)



local args={...}

local subType=SUB_ACTIVITY_TYPE.eHangDaoTeQuan
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfo(actID,subType,subID)

if data==nil then return end

data.flag=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_TXDTQ_mainWin','recv_receive',actID,subType,subID)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

