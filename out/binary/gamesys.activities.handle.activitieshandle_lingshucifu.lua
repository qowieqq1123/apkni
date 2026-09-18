












activitiesHandle_lingshucifu=new_activitiesHandle('activitiesHandle_lingshucifu',activitiesHandle)


eLingShuCiFuInteractionType={
Choujiang=1,
GetReward=2,
}

function activitiesHandle_lingshucifu:onInit(...)

end


function activitiesHandle_lingshucifu:reqProtocol_Choujiang(actID,subType,subid,num)
local info=activitiesModel:getSubActInfo(actID,subType,subid)
if num==1 and info:checkFree()then
local json_str=jsonHelper.encode({eLingShuCiFuInteractionType.Choujiang,num,1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
return
end
local useItems=info:getSubActConfig("useItems")
local itemId=useItems[1][1]
local itemNum=useItems[1][2]*num
local have=itemsModel.getCount(itemId)

if have>=itemNum then
local json_str=jsonHelper.encode({eLingShuCiFuInteractionType.Choujiang,num,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
return
end
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end


function activitiesHandle_lingshucifu:reqProtocol_GetReward(actID,subType,subid)
local json_str=jsonHelper.encode({eLingShuCiFuInteractionType.GetReward})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_lingshucifu.recv_247_120(args)








local subType=SUB_ACTIVITY_TYPE.eLingShuCiFu
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local rewardChange=false
local progressChange=false
if data.jdrwIndex and args[4]>0 and args[4]~=data.jdrwIndex then
rewardChange=true
end
if data.cjNum and args[7]~=data.cjNum then
progressChange=true
end
data.actID=actID
data.subid=subid
data.freeNum=args[3]
data.jdrwIndex=args[4]
data.level=args[5]
data.exp=args[6]
data.cjNum=args[7]
data.cjNum2=args[8]
activitiesModel:setSubActInfoData(actID,subType,subid,data)
if progressChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshAll',actID,subType,subid)
elseif rewardChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshRewardPanel',actID,subType,subid,true)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLingShuCiFu)
end


function activitiesHandle_lingshucifu.recv_247_121(args)







local subType=SUB_ACTIVITY_TYPE.eLingShuCiFu
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.actID=actID
data.subid=subid
data.freeNum=args[3]
data.level=args[4]
data.exp=args[5]
data.cjNum=args[6]
data.cjNum2=args[7]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLingShuCiFu)
end

