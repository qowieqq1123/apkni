













activitiesHandle_xianjutehui=new_activitiesHandle('activitiesHandle_xianjutehui',activitiesHandle)

function activitiesHandle_xianjutehui:onInit()

end


function activitiesHandle_xianjutehui.recv_249_92(...)




local args={...}

local subType=SUB_ACTIVITY_TYPE.eXianJuTeHui
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfo(actID,subType,subID)

if data==nil then return end

data.ex=args[3]
data.recharge_id=args[4]



activitiesModel:setSubActInfoData(actID,subType,subID,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

end


function activitiesHandle_xianjutehui.recv_249_93(...)



local args={...}

local subType=SUB_ACTIVITY_TYPE.eXianJuTeHui
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfo(actID,subType,subID)

if data==nil then return end

data.recharge_id=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_XianJuTeHuiWin','recv_recharged',actID,subType,subID)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianjutehui.recv_249_94(...)



local args={...}

local subType=SUB_ACTIVITY_TYPE.eXianJuTeHui
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfo(actID,subType,subID)

if data==nil then return end

data.ex=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_XianJuTeHuiWin','recv_reward',actID,subType,subID)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

