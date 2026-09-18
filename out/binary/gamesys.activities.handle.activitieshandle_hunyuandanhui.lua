












activitiesHandle_hunyuandanhui=new_activitiesHandle('activitiesHandle_hunyuandanhui',activitiesHandle)


eHunYuanDanHuiInteractionType={
startGame=1,
collision=2,
buyItem=3,
useItem=4,
getTaskReward=5,
endGame=6,
addDanYao=7,
freeGift=8,
}


eHunYuanDanHuiUseItemType={
delDanYao=1,
huhuanDanYao=2,
upDanYao=3,
}


function activitiesHandle_hunyuandanhui:reqProtocol_startGame(actID,subType,subid,mod_type)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.startGame,mod_type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_collision(actID,subType,subid,recordsList,delList)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.collision,recordsList,delList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_buyItem(actID,subType,subid,itemId)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.buyItem,itemId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_useItem(actID,subType,subid,itemId,itemNum,recordsList,danyaoTypeList,delList)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.useItem,itemId,itemNum,recordsList,danyaoTypeList,delList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_getTaskReward(actID,subType,subid,taskId)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.getTaskReward,taskId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_endGame(actID,subType,subid)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.endGame})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_hunyuandanhui:reqProtocol_addDanYao(actID,subType,subid,obj)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.addDanYao,obj})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if data.record_list_len==0 then
data.record_list={}
end
data.record_list_len=data.record_list_len+1
table.insert(data.record_list,{ele_id=obj[1],x=obj[2],y=obj[3],r=obj[4]})
end


function activitiesHandle_hunyuandanhui:reqProtocol_freeGift(actID,subType,subid)
local json_str=jsonHelper.encode({eHunYuanDanHuiInteractionType.freeGift})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_hunyuandanhui.recv_247_113(args)













local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui

local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local isEndGame=false
local isChonZhi=false
local lastGameEndScore=0
if data.mod_type and data.mod_type==1 and args[5]==0 then
isEndGame=true
lastGameEndScore=data.score
end
if data.mod_type and data.mod_type==2 and args[5]==0 then
isChonZhi=true
end

data.actID=actID
data.subid=subid
data.taskList={}
if args[3]>0 then
for i=1,args[3]do
local taskId=args[4][i].param_1
data.taskList[taskId]=args[4][i]
end
end
data.mod_type=args[5]
data.score=args[6]
data.record_list_len=args[7]
data.record_list=args[8]
data.itemList={}
if args[9]>0 then
for i=1,args[9]do
local itemId=args[10][i].param_1
data.itemList[itemId]=args[10][i].param_2
end
end
data.cur_id=args[11]
data.next_id=args[12]
data.free_flag=args[13]
data.hasChengJiuChangell=true


activitiesModel:setSubActInfoData(actID,subType,subid,data)

if isEndGame then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'initGameState',true)
elseif isChonZhi then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'clearAllDanYao')
else
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshItemNum')
end
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'freshChengJiuReddot')
UIManager:invokeUIMethod("UIHunYuanDanHuiChenJiuWin","refreshChenJiu")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)

if isEndGame then
local win=UIManager:findActiveWindow('UIHunYuanDanHuiWin')
if win then
UIManager:showWindow("UIHunYuanDanHuiResultWin",{act_id=actID,sub_act_type=subType,sub_act_id=subid,score=lastGameEndScore})
end
end
end


function activitiesHandle_hunyuandanhui.recv_247_114(args)










local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui

local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local itemChange=false
local modTypeChange=false
if data.mod_type and args[3]~=data.mod_type then
modTypeChange=true
end

local itemList={}
if args[7]>0 then
if data.itemListLen and data.itemListLen~=args[7]then
itemChange=true
end

for i=1,args[7]do
local itemId=args[8][i].param_1
itemList[itemId]=args[8][i].param_2

if not itemChange and data.itemList[itemId]~=itemList[itemId]then
itemChange=true
end
end
end

data.mod_type=args[3]
data.score=args[4]
data.record_list_len=args[5]
data.record_list=args[6]
data.itemListLen=args[7]
data.itemList=itemList
data.cur_id=args[9]
data.next_id=args[10]

activitiesModel:setSubActInfoData(actID,subType,subid,data)

if modTypeChange then
if data.mod_type==0 then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'initGameState',nil,true)
else
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'changeGameState',nil,true)
end
else
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'changeGameState')
end

if itemChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshItemNum')
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)
end


function activitiesHandle_hunyuandanhui.recv_247_115(actID,subid,taskId)



local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

if not data.taskList[taskId]then
data.taskList[taskId]={
param_1=taskId,
param_2=0,
param_3=2,
}
else
data.taskList[taskId].param_3=2
end
data.hasChengJiuChangell=true

activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'freshChengJiuReddot')
UIManager:invokeUIMethod("UIHunYuanDanHuiChenJiuWin","refreshChenJiu")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)
end


function activitiesHandle_hunyuandanhui.recv_247_122(actID,subid,cur_id,next_id)




local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui

local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.cur_id=cur_id
data.next_id=next_id

activitiesModel:setSubActInfoData(actID,subType,subid,data)



reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)
end


function activitiesHandle_hunyuandanhui.recv_247_127(actID,subid,free_flag)



local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.free_flag=free_flag

activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshFreeReward')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)
end


function activitiesHandle_hunyuandanhui.recv_247_128(actID,subid,task_list_len,task_list)




local subType=SUB_ACTIVITY_TYPE.eHunYuanDanHui
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

if task_list_len>0 then
for i=1,task_list_len do
local taskId=task_list[i].param_1
data.taskList[taskId]=task_list[i]
end
end
data.hasChengJiuChangell=true

activitiesModel:setSubActInfoData(actID,subType,subid,data)

activitiesModel:invokeSubActUIMethod(actID,subType,subid,'freshChengJiuReddot')
UIManager:invokeUIMethod("UIHunYuanDanHuiChenJiuWin","refreshChenJiu")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHunYuanDanHui)
end