







activitiesHandle_xingjiaoshangren=new_activitiesHandle('activitiesHandle_xingjiaoshangren',activitiesHandle)

function activitiesHandle_xingjiaoshangren:onInit()

end

function activitiesHandle_xingjiaoshangren:onTriggerClickEntity(guid)
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXingJiaoShangRen)or{}
for i,v in ipairs(subList)do
local entityData=v:getEntityData()
if entityData and entityData.guid==guid then
v:onClickEntity()
return
end
end
end

function activitiesHandle_xingjiaoshangren:reqRewardFree(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
local giftId=activitiesModel:getSubActivityConfig(subType,subId,"giftId")
local data={actId,subType,subId}
FreeGiftController.SendFreeGift(giftId,data,function(result)
self.onRecvFreeGift(actId,subId,result)
end,0)
end




function activitiesHandle_xingjiaoshangren:reqExchangeItem(actId,subId,itemId,itemCnt,itemList,buildingList,skyBuildingList,speakIdx)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
local jstr=jsonHelper.encode({1,itemId,itemCnt,itemList,buildingList,skyBuildingList,speakIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xingjiaoshangren.recv_247_61(actId,subId,len,list)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

info:initData(list)
end

function activitiesHandle_xingjiaoshangren.recv_247_62(args)
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
local actId=args[1]
local subId=args[2]
local itemId=args[3]
local itemCnt=args[4]
local itemLen=args[5]
local itemList=args[6]
local normalLen=args[7]
local normalList=args[8]
local skyLen=args[9]
local skyList=args[10]
local speakIdx=args[11]

for i=1,normalLen do
local ubdId=normalList[i]
zongmenModel:deleteStorageBuilding(ubdId)
end

for i=1,skyLen do
local skyData=skyList[i]
for j=1,skyData.len do
local mapId=skyData.sf_id
local ubdId=skyData.buildList[j]
zongmenModel:deleteSkyStorageDatasEx(mapId,ubdId)
end
end

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil or not info:hasData()then return end

local oCount=info:getItemCount(itemId)
info:setItemCount(itemId,oCount+itemCnt)
info:refreshEntityHUD()
end

function activitiesHandle_xingjiaoshangren.onRecvFreeGift(actId,subId,result)
if result then
local subType=SUB_ACTIVITY_TYPE.eXingJiaoShangRen
activitiesModel:invokeSubActUIMethod(actId,subType,subId,"refreshFree")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end