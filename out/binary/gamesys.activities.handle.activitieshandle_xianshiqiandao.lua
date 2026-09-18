







activitiesHandle_xianshiqiandao=new_activitiesHandle('activitiesHandle_xianshiqiandao',activitiesHandle)

function activitiesHandle_xianshiqiandao:onInit()

end

function activitiesHandle_xianshiqiandao.recv_249_12(actid,act2id,cnt,len,day_info)
local subType=SUB_ACTIVITY_TYPE.eXianShiQianDao
local actId=actid
local subId=act2id
local dayInfo={}
if len and len>0 then
for i,dayIndex in ipairs(day_info)do
dayInfo[dayIndex]=true
end
end

local data={

dayLen=len,
dayInfo=dayInfo
}

activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_xianshiqiandaoWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xianshiqiandao.recv_249_13(actid,act2id,day)
local subType=SUB_ACTIVITY_TYPE.eXianShiQianDao
local actId=actid
local subId=act2id



local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.dayInfo then
data.dayInfo={}
end
data.dayInfo[day]=true
activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_xianshiqiandaoWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xianshiqiandao.recv_249_14(actid,act2id,day,reason)
local subType=SUB_ACTIVITY_TYPE.eXianShiQianDao
local actId=actid
local subId=act2id
if reason==1 then

UIManager.error("补签失败")
return
end


local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.dayInfo then
data.dayInfo={}
end
if next(data.dayInfo)then
if data.dayInfo[day]then
logErr("补签天数为已签到的天数")
return
end
end
data.dayInfo[day]=true

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_xianshiqiandaoWin')
if win then
win:refresh()
end
end

function activitiesHandle_xianshiqiandao.recv_249_184(actid,act2id,len,day_info)
local subType=SUB_ACTIVITY_TYPE.eXianShiQianDao
local actId=actid
local subId=act2id
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.dayInfo then
data.dayInfo={}
end

if len and len>0 then
for i,dayIndex in ipairs(day_info)do
data.dayInfo[dayIndex]=true
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_xianshiqiandaoWin')
if win then
win:refresh()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianshiqiandao:autoReceiveFreeGift(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eXianShiQianDao
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
local data=sub_actInfo.data
if sub_actInfo:checkReddot()then
if checkReddot then
return true
end
local jsonStr=jsonHelper.encode({0,1})
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