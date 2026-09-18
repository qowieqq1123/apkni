












activitiesHandle_xianshichouka2=new_activitiesHandle('activitiesHandle_xianshichouka2',activitiesHandle)

function activitiesHandle_xianshichouka2:onInit()

end


function activitiesHandle_xianshichouka2.recv_249_69(args)















local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=args[3]
data.round=args[4]
data.times=args[5]
data.total=args[6]
data.flag=args[7]
data.free=args[8]
data.equip_idx=args[11]
activitiesModel:setSubActInfoData(actID,subType,subid,data)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
subActInfo:initNotes(args[10])

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka2.recv_249_70(actid,act2id,idx)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichouka2Win','rec_selectUp',actID,subType,subid)
end


function activitiesHandle_xianshichouka2.recv_249_87(actid,act2id,equip_idx)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.equip_idx=equip_idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichouka2Win','rec_selectEquip',actID,subType,subid)
UIManager.info("选择装备成功")
end


function activitiesHandle_xianshichouka2.recv_249_71(args)







local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.round=args[3]
data.times=args[4]
data.total=args[5]
data.free=args[6]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichouka2Win','rec_chouka',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka2.recv_249_72(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichouka2Win','rec_tagReward',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka2.recv_249_155(actid,act2id,len,recordList)








local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa2
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setNotesNew(recordList)
end
end

function activitiesHandle_xianshichouka2.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end