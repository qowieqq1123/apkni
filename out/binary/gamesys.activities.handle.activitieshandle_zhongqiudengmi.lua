







activitiesHandle_zhongqiudengmi=new_activitiesHandle('activitiesHandle_zhongqiudengmi',activitiesHandle)






function activitiesHandle_zhongqiudengmi:onInit()

end


function activitiesHandle_zhongqiudengmi.recv_247_8(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.eLanternriddles
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.reward_bits=args[3]

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local nowstamp=tonumber(sub_actInfo:getactivitytime())


if nowstamp and timeHelper.isTodayStamp(nowstamp)then
local zqd=serverSaveModel:getZQDMActivityData()

if zqd then
local act_id=zqd[1]or 0
local sub_act_type=zqd[2]or 0
local sub_act_id=zqd[3]or 0
if act_id==actID and sub_act_type==subType and sub_act_id==subid then
local answer_idx=zqd[4]
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',actID,subType,subid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,answer_idx)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
end
end
end
if not nowstamp then
sub_actInfo:setactivitytime()
end
if nowstamp and not timeHelper.isTodayStamp(nowstamp)then
sub_actInfo:clearalldata()
sub_actInfo:setAnawerData()
sub_actInfo:setactivitytime()
end

local reward_bits=data.reward_bits
local idx=sub_actInfo:getOpenDayIndex()
if idx and idx>0 then
local isgot=bitHelper.check_pos(reward_bits,idx-1)

if not isgot then

local finishIdex=sub_actInfo:getAnserdata()
local maxidx=0
local subcfg=cfg_lanternriddlesconfig_get(subid)
local cfg_questions=subcfg.questions
local questionslist=cfg_questions[idx]
if questionslist and questionslist[1]then
maxidx=#questionslist[1]
end
if finishIdex>=maxidx then
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',actID,subType,subid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,0)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
sub_actInfo:setAnawerData()
end
end
end

end


function activitiesHandle_zhongqiudengmi.recv_247_9(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.eLanternriddles
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.reward_bits=args[3]

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local flag=sub_actInfo:getWinFlag()
if flag==1 then
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','freshdatijindu')
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','freshbtntxt')
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','freshinfo')
UIManager:invokeUIMethod('UISubAct_ZQDMtitleWin','refreshallfinishbtn')
elseif flag==2 then
UIManager:invokeUIMethod('UISubAct_YXJmainWin','freshdatijindu')
UIManager:invokeUIMethod('UISubAct_YXJmainWin','freshbtntxt')
UIManager:invokeUIMethod('UISubAct_YXJmainWin','freshinfo')
UIManager:invokeUIMethod('UISubAct_YXJMtitleWin','refreshallfinishbtn')
end
end


function activitiesHandle_zhongqiudengmi:getreddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local reward_bits=mydata.reward_bits
local idx=sub_actInfo:getOpenDayIndex()
if idx and idx>0 then
local isgot=bitHelper.check_pos(reward_bits,idx-1)

if not isgot then
return true
end
end
end
return false
end