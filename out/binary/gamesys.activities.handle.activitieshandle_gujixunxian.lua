












activitiesHandle_gujixunxian=new_activitiesHandle('activitiesHandle_gujixunxian',activitiesHandle)

function activitiesHandle_gujixunxian:onInit()

end


function activitiesHandle_gujixunxian.recv_247_19(args)














local subType=SUB_ACTIVITY_TYPE.eLotteryact8
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
activitiesModel:setSubActInfoData(actID,subType,subid,data)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
subActInfo:initNotes(args[10])

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_gujixunxian.recv_247_20(actid,act2id,idx)




local subType=SUB_ACTIVITY_TYPE.eLotteryact8
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectUp')
UIManager:invokeUIMethod("UISubAct_gujixunxian_SelectLoveDialog","rec_selectUp",actID,subType,subid,idx)
end


function activitiesHandle_gujixunxian.recv_247_21(args)







local subType=SUB_ACTIVITY_TYPE.eLotteryact8
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.round=args[3]
data.times=args[4]
data.total=args[5]
data.free=args[6]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_chouka')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_gujixunxian.recv_247_22(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eLotteryact8
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_tagReward')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_gujixunxian.recv_247_23(actid,act2id,len,recordList)








local subType=SUB_ACTIVITY_TYPE.eLotteryact8
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setNotesNew(recordList)
end
end

function activitiesHandle_gujixunxian.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end