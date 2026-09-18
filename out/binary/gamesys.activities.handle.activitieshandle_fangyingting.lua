












activitiesHandle_fangyingting=new_activitiesHandle('activitiesHandle_fangyingting',activitiesHandle)


eFangYingTingInteractionType={
EventStart=1,
ClaimReward=2,
OpenChallengeMode=3,
PlotFlag=4,
Correct=5,
}


eFangYingTingEventType=
{
PushMap=1,
AnswerQuestion=2,
Adventure=3,
None=4,
}


eFangYingTingPlotState=
{
Easy=1,
Difficult=2,
}

function activitiesHandle_fangyingting:onInit(...)

end



function activitiesHandle_fangyingting:reqProtocol_PlotFlag(actID,subType,subid,playFlag)
local json_str=jsonHelper.encode({eFangYingTingInteractionType.PlotFlag,playFlag})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_fangyingting:reqProtocol_EventStart(actID,subType,subid)
local json_str=jsonHelper.encode({eFangYingTingInteractionType.EventStart})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_fangyingting:reqProtocol_ClaimReward(actID,subType,subid)
local json_str=jsonHelper.encode({eFangYingTingInteractionType.ClaimReward})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_fangyingting:reqProtocol_Correct(actID,subType,subid)
local json_str=jsonHelper.encode({eFangYingTingInteractionType.Correct})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_fangyingting.recv_247_67(args)







local subType=SUB_ACTIVITY_TYPE.eFangYingTing
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local plotFlagChange=false
local tuituStageChange=false
local qiyuStageChange=false
local noneSatgeChange=false
local rewardChange=false
if data.qiyuId and not mathHelper.compareInt64(args[5],data.qiyuId)then
qiyuStageChange=true
end
if data.playFlag and args[6]~=data.playFlag then
plotFlagChange=true
end
if data.tuituIndexStr and string.len(args[7])>0 and args[7]~=data.tuituIndexStr then
tuituStageChange=true
end
if data.rewardFlag and args[4]~=data.rewardFlag then
rewardChange=true
end
if data.progress and args[3]~=data.progress then
noneSatgeChange=true
end
data.actID=actID
data.subid=subid
data.progress=args[3]
data.rewardFlag=args[4]
data.qiyuId=args[5]
data.playFlag=args[6]
data.tuituIndexStr=args[7]

activitiesModel:setSubActInfoData(actID,subType,subid,data)
if plotFlagChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'onPlayImageProtocol')
end
if qiyuStageChange or tuituStageChange or noneSatgeChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'onEventProtocol')
end
if rewardChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshRewardPanel')
end
end


function activitiesHandle_fangyingting.checkHasFree(subType,subid,free)
local maxfree=activitiesModel:getSubActivityConfig(subType,subid,'free')
return free<maxfree
end


function activitiesHandle_fangyingting:onBattleResult(result,log,data)
activitiesController:jump(data[2],SUB_ACTIVITY_TYPE.eFangYingTing,data[3],{isRefresh=true,winName="UIDaHuaXiYouWin_CopyMainWin"})
end


function activitiesHandle_fangyingting:fightResultQuitCB(data,Result)


local mydata=activitiesModel:getSubActInfoData(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
mydata.fightResult=Result

local winName="UIDaHuaXiYouWin_CopyMainWin"
local tempArgtable={actID=data.actid,subType=SUB_ACTIVITY_TYPE.eFangYingTing,subid=data.act2id}

if UIManager:isActive("UIFightPrepareLoading")then
activitiesController:jump(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
UIManager:showWindow(winName,tempArgtable)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
activitiesController:jump(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
UIManager:showWindow(winName,tempArgtable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end


end


function activitiesHandle_fangyingting:fightResultContinueCB(data,Result)
local mydata=activitiesModel:getSubActInfoData(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
mydata.fightResult=Result

local winName="UIDaHuaXiYouWin_CopyMainWin"
local tempArgtable={actID=data.actid,subType=SUB_ACTIVITY_TYPE.eFangYingTing,subid=data.act2id}
if UIManager:isActive("UIFightPrepareLoading")then
activitiesController:jump(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
UIManager:showWindow(winName,tempArgtable)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
activitiesController:jump(data.actid,SUB_ACTIVITY_TYPE.eFangYingTing,data.act2id)
UIManager:showWindow(winName,tempArgtable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end


end


function activitiesHandle_fangyingting:setFangYingTing_DatiRc()
userActorSetting.set("fangyingting_DatiRc",{})
userActorSetting.flush()
end
