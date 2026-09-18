












activitiesHandle_xianshichouka=new_activitiesHandle('activitiesHandle_xianshichouka',activitiesHandle)

function activitiesHandle_xianshichouka:onInit()

end


function activitiesHandle_xianshichouka.recv_249_5(args)















local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
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


function activitiesHandle_xianshichouka.recv_249_6(actid,act2id,idx)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.itemid=idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin','rec_selectUp',actID,subType,subid)
end


function activitiesHandle_xianshichouka.recv_249_85(actid,act2id,equip_idx)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.equip_idx=equip_idx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin','rec_selectEquip',actID,subType,subid)
UIManager.info("选择装备成功")
end


function activitiesHandle_xianshichouka.recv_249_7(args)







local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.round=args[3]
data.times=args[4]
data.total=args[5]
data.free=args[6]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin','rec_chouka',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka.recv_249_8(actid,act2id,flag)




local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.flag=flag
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_xianshichoukaWin','rec_tagReward',actID,subType,subid)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshichouka.recv_249_154(actid,act2id,len,recordList)








local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setNotesNew(recordList)
end
end

function activitiesHandle_xianshichouka.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end


function activitiesHandle_xianshichouka:autoReceiveFreeLottery(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eXianShiChouKa
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
local data=sub_actInfo.data
local isNotSelectDisciple=data.itemid<=0
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,sub_act_id)
local hasEquip=sub_actcfg.lottery_equip~=nil
local isNotSelectEquip=hasEquip and data.equip_idx<=0
if activitiesHandle_xianshichouka.checkHasFree(subType,sub_act_id,data.free)then
if checkReddot then
return true
end
if isNotSelectDisciple then
local defaultdz=sub_actcfg.defaultdz
if defaultdz==0 then
defaultdz=1
end
local json_str=jsonHelper.encode({1,defaultdz})
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,json_str)
end
if isNotSelectEquip then
local equip_idx=1
local json_str=jsonHelper.encode({4,equip_idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,json_str)
end
local typo=1
local is_assistant=1
local jsonStr=jsonHelper.encode({2,typo,is_assistant})
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end