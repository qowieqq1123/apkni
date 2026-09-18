







activitiesHandle_drawdianji=new_activitiesHandle('activitiesHandle_drawdianji',activitiesHandle)


function activitiesHandle_drawdianji:onInit()

end



function activitiesHandle_drawdianji.recv_249_210(args)
local subType=SUB_ACTIVITY_TYPE.eHuiHuaDianJi
local actId=args[1]
local subId=args[2]

local hhjifen=args[3]
local freeReward=args[4]
local tzRewad1=args[5]
local tzRewad2=args[6]
local tzRewardFlag1=args[7]
local tzRewardFlag2=args[8]
local data={hhjifen=hhjifen,freeReward=freeReward,tzRewad1=tzRewad1,tzRewad2=tzRewad2,
tzRewardFlag1=tzRewardFlag1,tzRewardFlag2=tzRewardFlag2}
local olddata=activitiesModel:getSubActInfoData(actId,subType,subId,data)
if olddata and olddata.tzRewardFlag1==0 and tzRewardFlag1==1 then
UIManager.info('购买成功')
end
if olddata and olddata.tzRewardFlag2==0 and tzRewardFlag2==1 then
UIManager.info('购买成功')
end
activitiesModel:setSubActInfoData(actId,subType,subId,data)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_DrawDianJiWin','initdata',actId,subType,subId)
end


function activitiesHandle_drawdianji:reqtaskReward(actId,subId,id)
local subType=SUB_ACTIVITY_TYPE.eHuiHuaDianJi
local jstr=jsonHelper.encode({id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end