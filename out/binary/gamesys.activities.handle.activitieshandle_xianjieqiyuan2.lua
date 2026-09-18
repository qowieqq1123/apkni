












activitiesHandle_xianjieqiyuan2=new_activitiesHandle('activitiesHandle_xianjieqiyuan2',activitiesHandle)

function activitiesHandle_xianjieqiyuan2:onInit()

end


function activitiesHandle_xianjieqiyuan2.recv_247_36(args)















local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
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
data.items=args[12]or{}
data.equip_idx=args[13]
activitiesModel:setSubActInfoData(actID,subType,subid,data)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
subActInfo:initNotes(args[10])

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianjieqiyuan2.recv_247_37(actid,act2id,idx)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectUp')
end


function activitiesHandle_xianjieqiyuan2.recv_247_59(actid,act2id,equip_idx)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.equip_idx=equip_idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectEquip')
UIManager.info("选择装备成功")
end


function activitiesHandle_xianjieqiyuan2.recv_247_38(args)







local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
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


function activitiesHandle_xianjieqiyuan2.recv_247_39(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_tagReward')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianjieqiyuan2.recv_247_40(actid,act2id,len,recordList)








local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setNotesNew(recordList)
end
end

function activitiesHandle_xianjieqiyuan2.recv_247_41(actid,act2id,len,selectList)
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=1
data.items=selectList or{}
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'rec_selectUp')

UIManager.info("选择弟子成功")
end

function activitiesHandle_xianjieqiyuan2.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end