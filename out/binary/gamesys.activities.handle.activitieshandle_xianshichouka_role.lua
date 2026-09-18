












activitiesHandle_xianshichouka_Role=new_activitiesHandle('activitiesHandle_xianshichouka_Role',activitiesHandle)

function activitiesHandle_xianshichouka_Role:onInit()

end


function activitiesHandle_xianshichouka_Role.recv_249_185(args)














local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa_Role
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.period_idx=args[3]
data.itemid=args[4]
data.round=args[5]
data.times=args[6]
data.total=args[7]
data.flag=args[8]
data.free=args[9]
data.record_server_day=args[10]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka_Role.recv_249_186(actid,act2id,period_idx,idx)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa_Role
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.period_idx=period_idx
data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin_Role','rec_selectUp',actID,subType,subid)
UIManager:invokeUIMethod('UISubAct_xianshichoukaWin_Role','refreshOnShow',actID,subType,subid)

end


function activitiesHandle_xianshichouka_Role.recv_249_187(args)







local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa_Role
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.round=args[3]
data.times=args[4]
data.total=args[5]
data.free=args[6]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin_Role','rec_chouka',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka_Role.recv_249_188(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa_Role
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin_Role','rec_tagReward',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka_Role.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end