












activitiesHandle_huiyingcangxi=new_activitiesHandle('activitiesHandle_huiyingcangxi',activitiesHandle)


eHuiYingCangXiInteractionType={
OpenMural=1,
ClaimReward=2,
PlotFlag=3,
EventStart=4,
XiuFu=5,
}

function activitiesHandle_huiyingcangxi:onInit(...)

end


function activitiesHandle_huiyingcangxi:reqProtocol_OpenMural(actID,subType,subid)
local json_str=jsonHelper.encode({eHuiYingCangXiInteractionType.OpenMural})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_huiyingcangxi:reqProtocol_PlotFlag(actID,subType,subid,muralIdx)
local json_str=jsonHelper.encode({eHuiYingCangXiInteractionType.PlotFlag,muralIdx or 0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_huiyingcangxi:reqProtocol_EventStart(actID,subType,subid,muralIdx)
local json_str=jsonHelper.encode({eHuiYingCangXiInteractionType.EventStart,muralIdx or 0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_huiyingcangxi:reqProtocol_ClaimReward(actID,subType,subid)
local json_str=jsonHelper.encode({eHuiYingCangXiInteractionType.ClaimReward})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end


function activitiesHandle_huiyingcangxi:reqProtocol_XiuFu(actID,subType,subid,fixIdx)
local json_str=jsonHelper.encode({eHuiYingCangXiInteractionType.XiuFu,fixIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end



function activitiesHandle_huiyingcangxi.recv_247_108(args)










local subType=SUB_ACTIVITY_TYPE.eHuiYingCangXi
local actID=args[1]
local subid=args[2]
local recap_list={}
if args[8]>0 then
for i,v in ipairs(args[9])do
if not recap_list[v.param_1]then
recap_list[v.param_1]={}
end
recap_list[v.param_1]={progress=v.param_2,qiyu_id=v.param_3}
end
end
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local screenChange=false
local qiyuStageChange=false
local rewardChange=false
local progressChange=false
local fixChange=false
local qiyu_mural_idx=0
local newqiyuId=nil
if data.qiyu_id and args[5]~=data.qiyu_id then
qiyuStageChange=true
newqiyuId=args[5]
end
if data.reward_flag and args[10]~=data.reward_flag then
rewardChange=true
end
if data.progress and args[4]~=data.progress then
progressChange=true
end
if data.mural_idx and args[3]~=data.mural_idx then
screenChange=true
end
if data.fix_list_len and args[6]~=data.fix_list_len then
fixChange=true
end
if data.recap_list and args[8]>0 then
for i,v in ipairs(args[9])do
if not data.recap_list[v.param_1]or data.recap_list[v.param_1].qiyu_id~=v.param_3 then
qiyu_mural_idx=v.param_1
qiyuStageChange=true
newqiyuId=v.param_3
break
end
end
end
data.actID=actID
data.subid=subid
data.mural_idx=args[3]
data.progress=args[4]
data.qiyu_id=args[5]
data.fix_list_len=args[6]
data.fix_list=args[7]
data.recap_list_len=args[8]
data.recap_list=recap_list
data.reward_flag=args[10]
data.fixListLookup={}
if args[6]>0 then
for i,v in ipairs(args[7])do
data.fixListLookup[v]=true
end
end

activitiesModel:setSubActInfoData(actID,subType,subid,data)
if qiyuStageChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'onEventProtocol',qiyu_mural_idx,newqiyuId)
end
if rewardChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshRewardPanel')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHuiYingCangXi)
end

local func=function()
local win=UIManager:findActiveWindow("UICommonShowPrizeWin")
local cb=function()
if progressChange or fixChange or screenChange then
activitiesModel:invokeSubActUIMethod(actID,subType,subid,'refreshScreen',true)
if fixChange then
UIManager:invokeUIMethod('UIHuiYingCangXiRepairWin','refreshView',true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eHuiYingCangXi)
end
end
end
if win then
win:setAttachCB(cb)
else
cb()
end
end
timeEventController.delayDo(0.5,func)
end