
activitiesHandle_xiantuzhuli=new_activitiesHandle('activitiesHandle_xiantuzhuli',activitiesHandle)











function activitiesHandle_xiantuzhuli.recv_249_216(args)
local actid,act2id,giftlistlen,giftList,timeslistlen,timesList=args[1],args[2],args[3],args[4],args[5],args[6]
local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local actID=actid
local subID=act2id












local datalookup={}
local rewards=activitiesModel:getSubActivityConfig(subType,subID,"rewards")

for i,v in ipairs(rewards)do
local temp={}
temp.buyCount=0
temp.recvIndex=0
temp.zhuLiCount=0
datalookup[i]=temp
end

for i,v in ipairs(giftList or{})do
local giftData=datalookup[v.param_1]
giftData.buyCount=v.param_2
giftData.recvIndex=v.param_3
end

for i,v in ipairs(timesList or{})do
local giftData=datalookup[v.param_1]
giftData.zhuLiCount=v.param_2
end



activitiesModel:setSubActInfoData(actID,subType,subID,datalookup)
end






function activitiesHandle_xiantuzhuli.recv_249_217(actid,act2id,giftid,cnt)
local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local actID=actid
local subID=act2id
local datalookup=activitiesModel:getSubActInfoData(actID,subType,subID)
if not datalookup[giftid]then
datalookup[giftid]={}
datalookup[giftid].buyCount=0
datalookup[giftid].zhuLiCount=0
datalookup[giftid].recvIndex=0
end
local oldbuyCount=datalookup[giftid].buyCount
local oldZhuliCount=datalookup[giftid].zhuLiCount
datalookup[giftid].buyCount=cnt
datalookup[giftid].zhuLiCount=oldZhuliCount+cnt-oldbuyCount
activitiesModel:setSubActInfoData(actID,subType,subID,datalookup)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshBuyData")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshZhuLiData")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshZhuLiList")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshGiftList")
end






function activitiesHandle_xiantuzhuli.recv_249_218(actid,act2id,giftid,times)
local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local actID=actid
local subID=act2id
local datalookup=activitiesModel:getSubActInfoData(actID,subType,subID)
if not datalookup[giftid]then
datalookup[giftid]={}
datalookup[giftid].buyCount=0
datalookup[giftid].zhuLiCount=0
datalookup[giftid].recvIndex=0
end
datalookup[giftid].zhuLiCount=times
activitiesModel:setSubActInfoData(actID,subType,subID,datalookup)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshZhuLiData")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshZhuLiList")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshGiftList")
end






function activitiesHandle_xiantuzhuli.recv_249_219(actid,act2id,giftid,rewardid)
local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local actID=actid
local subID=act2id
local datalookup=activitiesModel:getSubActInfoData(actID,subType,subID)
if not datalookup[giftid]then
datalookup[giftid]={}
datalookup[giftid].buyCount=0
datalookup[giftid].zhuLiCount=0
datalookup[giftid].recvIndex=0
end
datalookup[giftid].recvIndex=rewardid
activitiesModel:setSubActInfoData(actID,subType,subID,datalookup)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshZhuLiList")
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshGiftList")
end


function activitiesHandle_xiantuzhuli:reqBuy(actId,subId,rechargeId,giftIdx,count)

local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local info={giftIdx,count}
local params=payControl.getActivityPayParams(actId,subType,subId,info)
payControl.reqPay(rechargeId,1,params)
end


function activitiesHandle_xiantuzhuli:reqReward(actId,subId,type,arg1,arg2)

local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local jstr=jsonHelper.encode({type,arg1,arg2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xiantuzhuli:reqFreeReward(actId,subId,giftid)

local subType=SUB_ACTIVITY_TYPE.eXianTuZhuli
local data={actId,subType,subId}
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshCommonReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod("UISubAct_xiantuzhuli","refreshGiftList")
end
end)
end
