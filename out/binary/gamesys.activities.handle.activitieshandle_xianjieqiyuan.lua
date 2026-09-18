












activitiesHandle_xianjieqiyuan=new_activitiesHandle('activitiesHandle_xianjieqiyuan',activitiesHandle)

function activitiesHandle_xianjieqiyuan:onInit()

end


function activitiesHandle_xianjieqiyuan.recv_249_175(args)















local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
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


function activitiesHandle_xianjieqiyuan.recv_249_176(actid,act2id,idx)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectUp')
UIManager:invokeUIMethod("UISubAct_xianjieqiyuan_SelectLoveDialog","rec_selectUp",actID,subType,subid,idx)
end


function activitiesHandle_xianjieqiyuan.recv_249_180(actid,act2id,equip_idx)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.equip_idx=equip_idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectEquip')
UIManager.info("选择装备成功")
end


function activitiesHandle_xianjieqiyuan.recv_249_177(args)







local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
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


function activitiesHandle_xianjieqiyuan.recv_249_178(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_tagReward')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianjieqiyuan.recv_249_179(actid,act2id,len,recordList)








local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setNotesNew(recordList)
end
end

function activitiesHandle_xianjieqiyuan.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end