









local subActivityInfo_cangbaotu={name='subActivityInfo_cangbaotu'}

local taskType={
eShare=1,
eChip=2,
eGraph=3,
eSOS=4,
}

local _jumpStr={
[taskType.eShare]="前往求助",
[taskType.eChip]="前往寻宝",
[taskType.eGraph]="前往寻宝",
[taskType.eSOS]="前往求助",
}

local _jumpHanle={
[taskType.eShare]=function(activityId,subType,subId)

local config=activitiesModel:getSubActivityConfig(subType,subId)
local str=cfgHelper.getlang("cangbaotu_fenxiang_tishi")
UIManager.info(str)
end,
[taskType.eChip]=function(activityId,subType,subId)
local config=activitiesModel:getSubActivityConfig(subType,subId)
weakGuideController:beginGuide(config.weakGuide)
end,
[taskType.eGraph]=function(activityId,subType,subId)
local config=activitiesModel:getSubActivityConfig(subType,subId)
weakGuideController:beginGuide(config.weakGuide)
end,
[taskType.eSOS]=function(activityId,subType,subId)
local config=activitiesModel:getSubActivityConfig(subType,subId)
local str=cfgHelper.getlang("cangbaotu_fenxiang_tishi")
UIManager.info(str)
end,
}

local _progress={
[taskType.eShare]=function(info)
local data=info:getData()
if data then
return data.task.sharetimes or 0
end
return 0
end,
[taskType.eChip]=function(info)
local data=info:getData()
local config=activitiesModel:getSubActivityConfig(info.sub_act_type,info.sub_act_id)
if data then
local count=#config.money
local temp=(data.current.mapid-1)*count
for i=1,count do
if mathHelper.getBitValue(data.current.pieceflag,i-1)then
temp=temp+1
end
end
return temp
end
return 0
end,
[taskType.eGraph]=function(info)
local data=info:getData()
if data then
return(data.current.mapid-1)or 0
end
return 0
end,
[taskType.eSOS]=function(info)
local data=info:getData()
if data then
return data.task.helptimes or 0
end
return 0
end,
}

local _SOSInterval=60

function subActivityInfo_cangbaotu:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
self:listenNotify(notifyConfig.onSubActivityStateChange,function(...)
self:onSubActivityStateChange(...)
end)
end

function subActivityInfo_cangbaotu:onStart()
local key=table.concat({self.act_id,self.sub_act_id,self.startTime},"_")
self.saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eCangBaoTu,key,nil)
self.sosTime={}

call_activitiesHandle_func("activitiesHandle_cangbaotu","clearInvailMarkChat")
self.markChatKey=table.concat({self.act_id,self.sub_act_id,self.end_time,"MarkChat"},"_")
self.markChat=userActorArraySetting.get(ACTOR_SETTING_TYPE.eCangBaoTu,self.markChatKey,{})

end

function subActivityInfo_cangbaotu:onDelete()
self.saveData=nil
end

function subActivityInfo_cangbaotu:getMarkChat(actorId,infoGuid)
local key=FMT.fmt("{0}_{1}",tostring(actorId),tostring(infoGuid))
return self.markChat[key]or false
end

function subActivityInfo_cangbaotu:setMarkChat(actorId,infoGuid)

local key=FMT.fmt("{0}_{1}",tostring(actorId),tostring(infoGuid))
self.markChat[tostring(key)]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eCangBaoTu,self.markChatKey,self.markChat)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eCangBaoTu)
end

function subActivityInfo_cangbaotu:saveRecordSec(secTime)
self.saveData=secTime
local key=table.concat({self.act_id,self.sub_act_id,self.startTime},"_")
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eCangBaoTu,key,self.saveData,nil)
end

function subActivityInfo_cangbaotu:checkReddot()

return self:getTaskReddot()or self:getFreeReddot()or self:getRecordReddot()
end

function subActivityInfo_cangbaotu:getSingleTaskFinish(index)
if self:hasData()then
return mathHelper.getBitValue(self.data.task.targetflag,index-1)
end
return false
end

function subActivityInfo_cangbaotu:getSingleTaskShow(index)
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local taskCfg=config.target[index]
local prev=taskCfg[5]
local force=taskCfg[6]
return force==1 or prev==0 or self:getSingleTaskFinish(prev)
end

function subActivityInfo_cangbaotu:getSingleTaskReddot(index)
if self:hasData()then
local flag=mathHelper.getBitValue(self.data.task.targetflag,index-1)
if not flag then
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local taskCfg=config.target[index]
local taskType=taskCfg[1]
local targetNum=taskCfg[2]
local progress=self:getTaskProgress(taskType)
return progress>=targetNum
end
end
return false
end

function subActivityInfo_cangbaotu:getTaskReddot()
if self:hasData()then
local temp={}
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
for i,v in ipairs(config.target)do
local flag=mathHelper.getBitValue(self.data.task.targetflag,i-1)
if not flag then
local taskType=v[1]
local targetNum=v[2]
if not temp[taskType]then
temp[taskType]=self:getTaskProgress(taskType)
end
local progress=temp[taskType]
if progress>=targetNum then
return true
end
end
end
end
return false
end

function subActivityInfo_cangbaotu:getFreeReddot()
if self:hasData()then
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
if self.data.task.searchtimes<config.free then
return true
end
for i,v in ipairs(config.consume)do
if itemsModel.getCount(v[1])<v[2]then
return false
end
end
return true
end
return false
end

function subActivityInfo_cangbaotu:getRecordReddot()
if self:hasData()then
return self.data.recordsec>0 and(self.saveData==nil or self.saveData<self.data.recordsec)
end
return false
end

function subActivityInfo_cangbaotu:onSubActivityStateChange(act_id,sub_act_type,sub_act_id,state)
if initProControl.isDone()and self:compare(act_id,sub_act_type,sub_act_id)and state==activitiesModel.activityFinishState then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eCangBaoTu,self.markChatKey,nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eCangBaoTu)
end
end

function subActivityInfo_cangbaotu:onShowPrize(prizeType,rewards_,effectData)

if effectData.actid==self.act_id and effectData.act2id==self.sub_act_id then
local data=self:getData()
if not data then return end

if prizeType==ePrizeType.eCangBaoGePrize then

local searchtimes=effectData.searchtimes
data.task.searchtimes=searchtimes



UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","afterPrize",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_CangBaoTuCardWin","refreshCardReward",self.act_id,self.sub_act_type,self.sub_act_id,rewards_)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)

elseif prizeType==ePrizeType.eCangBaoGeActive then

local pieceid=effectData.pieceid
if pieceid>0 then
data.current.pieceflag=mathHelper.setbit(data.current.pieceflag,pieceid-1)
for i,v in ipairs(rewards_)do
UIManager.rewardInfo(itemsModel.getIconName(v),FMT.fmt('X{0}',v.num))
end
else
data.current.mapid=data.current.mapid+1
data.current.pieceflag=0
end

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","afterActive",self.act_id,self.sub_act_type,self.sub_act_id,effectData.pieceid,rewards_)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_cangbaotu:checkNewDay()
if self:hasData()then
local now=timeHelper.getServerShortTime()
if not timeHelper.checkInSameDay(self.data.datasec,now)then
self.data.datasec=now
local taskData=self.data.task
taskData.searchtimes=0
taskData.sharetimes=0
taskData.recvtimes=0
taskData.helptimes=0

local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eCangBaoGe,self.sub_act_id)
for i,v in ipairs(config.target)do
if v[1]==taskType.eShare then
taskData.targetflag=mathHelper.clrbit(taskData.targetflag,i-1)
end
end

UIManager:invokeUIMethod("UISubAct_CangBaoTuWin","onNewDay")
UIManager:invokeUIMethod("UISubAct_CangBaoTuTaskWin","onNewDay")
UIManager:invokeUIMethod("UISubAct_CangBaoTuCardWin","onNewDay")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_cangbaotu:setRecord(list)
self.record=list or{}
end

function subActivityInfo_cangbaotu:getRecord()
return self.record or{}
end

function subActivityInfo_cangbaotu:getTaskProgress(taskType)
local progressValue=_progress[taskType]
if progressValue then
return progressValue(self)
end
loggerUtil.logErrFMT("没有实现藏宝图活动获取任务进度类型：{0}",taskType)
return 0
end

function subActivityInfo_cangbaotu:getTaskJumpStr(taskType)
return _jumpStr[taskType]or""
end

function subActivityInfo_cangbaotu:getTaskJumpHandle(taskType)
if _jumpHanle[taskType]then
_jumpHanle[taskType](self.act_id,self.sub_act_type,self.sub_act_id)
end
end

function subActivityInfo_cangbaotu:checkSOSTime(itemId)
if self.sosTime[itemId]then
return timeHelper.getServerShortTime()-(self.sosTime[itemId]+_SOSInterval)
end
return 0
end

function subActivityInfo_cangbaotu:markSOSTime(itemId)
self.sosTime[itemId]=timeHelper.getServerShortTime()
end































return subActivityInfo_cangbaotu