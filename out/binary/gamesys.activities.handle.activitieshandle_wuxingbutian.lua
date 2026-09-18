







activitiesHandle_wuxingbutian=new_activitiesHandle('activitiesHandle_wuxingbutian',activitiesHandle)














function activitiesHandle_wuxingbutian:onInit()

end


function activitiesHandle_wuxingbutian.recv_247_92(args)
local actid=args[1]
local act2id=args[2]
local subType=SUB_ACTIVITY_TYPE.eWuXingBuTian
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local actionType=args[3]

local oldlv=data.passLevel
local curlv=args[4]
data.passLevel=curlv

local changeScore=data.totalScore~=args[5]
if changeScore==true then
data.totalScore=args[5]
end
data.rewardFlag=args[6]
data.rechargeCount=args[7]
data.lingyuBuyCount=args[8]
data.freeTime=args[9]
if actionType==5 then

UIManager:invokeUIMethod('UISubAct_wxbtMainWin','rec_tagReward',actID,subType,subid)
elseif actionType==6 then

UIManager.info('购买成功')
UIManager:invokeUIMethod('UISubAct_wxbtBuyWin','refreshInfo')
UIManager:invokeUIMethod('UISubAct_wxbtBuyWin','refreshZhigou')
elseif actionType==3 then

UIManager:invokeUIMethod('UISubAct_wxbtMainWin','rec_game',actID,subType,subid,changeScore,oldlv,curlv)
elseif actionType==4 then

UIManager:invokeUIMethod('UISubAct_wxbtMainWin','rec_exchange',actID,subType,subid)
else

if changeScore==true then
UIManager:invokeUIMethod('UISubAct_wxbtMainWin','rec_score',actID,subType,subid)
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_wuxingbutian.recv_247_93(args)
local actid=args[1]
local act2id=args[2]
local subType=SUB_ACTIVITY_TYPE.eWuXingBuTian
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo==nil then return end
bubbleShooterController:recv_init(subActInfo,args)
local flag=bubbleShooterController:useOpenMark()
if flag then
bubbleShooterController:openGameWin(subActInfo.gameid)
end
end


function activitiesHandle_wuxingbutian.recv_247_94(args)
local actid=args[1]
local act2id=args[2]
local subType=SUB_ACTIVITY_TYPE.eWuXingBuTian
local actID=actid
local subid=act2id
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo==nil then return end
bubbleShooterController.recv_shoot(subActInfo.gameid,args)
end

function activitiesHandle_wuxingbutian.recv_247_110(actid,act2id,freeTime)
local subType=SUB_ACTIVITY_TYPE.eWuXingBuTian
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
data.freeTime=freeTime
activitiesModel:setSubActInfoData(actID,subType,subid,data)


UIManager:invokeUIMethod("UISubAct_wxbtMainWin","refreshDailyReward")


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

end


function activitiesHandle_wuxingbutian:getBuyNum(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
return mydata.lingyuBuyCount,mydata.rechargeCount
end
return 0,0
end

function activitiesHandle_wuxingbutian.sendBuy(selectCnt,actID,subType,subid)
local json_str=jsonHelper.encode({6,selectCnt})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end

function activitiesHandle_wuxingbutian.sendShoot(actID,subType,subid,angle,color)
local json_str=jsonHelper.encode({2,angle,color})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end

function activitiesHandle_wuxingbutian.sendExchange(actID,subType,subid,buyItemID,buynum)
local json_str=jsonHelper.encode({4,buyItemID,buynum})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end