









local subActivityInfo_xianmengtequan={name='xianmengtequan'}



function subActivityInfo_xianmengtequan:onInit()

end

function subActivityInfo_xianmengtequan:onStart()
taskController.onSubActivityStateChange(self.act_id,self.sub_act_type,self.sub_act_id,activitiesModel.activityDoingState)
UIXianShuControl.onSubActivityStateChange(self.act_id,self.sub_act_type,self.sub_act_id,activitiesModel.activityDoingState)
end

function subActivityInfo_xianmengtequan:onDelete()
end

function subActivityInfo_xianmengtequan:checkReddot()
local reddot=false
if not self.data then

return reddot
end
















local free_libao_id=self:getSubActConfig('free_libao_id')
if free_libao_id then
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local isCanGetGift=FreeGiftController.GetFreeGift(free_libao_id,data)
reddot=isCanGetGift
end

return reddot
end

function subActivityInfo_xianmengtequan:setShowReddot(privilegeType)
if not self.data then
return
end


local nowTime=timeHelper.getServerShortTime()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActXMTQ,FMT.fmt("reddot_{0}_{1}",self.sub_act_id,privilegeType),nowTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActXMTQ)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianMengTeQuan)
end

function subActivityInfo_xianmengtequan:setAllShowReddot()
if not self.data then
return
end
local nowTime=timeHelper.getServerShortTime()

local today=self:getStart2NowDay()

local privilege=self:getSubActConfig('privilege')
for i,v in ipairs(privilege)do
if today>=v[1]and today<=v[2]then
if v[3]==1 then


userActorArraySetting.set(ACTOR_SETTING_TYPE.eActXMTQ,FMT.fmt("reddot_{0}_{1}",self.sub_act_id,v[3]),nowTime)

else
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActXMTQ,FMT.fmt("reddot_{0}_{1}",self.sub_act_id,v[3]),nowTime)
end

end
end

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActXMTQ)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianMengTeQuan)
end

function subActivityInfo_xianmengtequan:getShowReddot(privilegeType)
local changeTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActXMTQ,FMT.fmt("reddot_{0}_{1}",self.sub_act_id,privilegeType),nil)
if not changeTime then

return true
else



return false
end
end

function subActivityInfo_xianmengtequan:getServerList()
return self.data.xmList
end

function subActivityInfo_xianmengtequan:getFreeCDTimes()
if not self.data or not self.data.list then
return-1
end
if not self:inTeQuanTime(1)then
return-1
end
if not self.max then
local privilege=self:getSubActConfig('privilege')
for i,v in ipairs(privilege)do
if v[3]==1 then
self.max=v[4]
break
end
end
end

return self.max-(self.data.list[1]or 0),self.max
end

function subActivityInfo_xianmengtequan:getAutoJJRate()
if not self.data or not self.data.list then
return 0
end

local mXmFlag=xianmengModel:hasXM()and 1 or 0
if self.xmFlag and mXmFlag==self.xmFlag and self.autoJJRate then
return self.autoJJRate
end


self.autoJJRate=0

self.xmFlag=mXmFlag

local privilege=self:getSubActConfig('privilege')
for i,v in ipairs(privilege)do
if self:inTeQuanTime(v[3])then
if v[3]==3 then
if xianmengModel:hasXM()then
self.autoJJRate=self.autoJJRate+v[4]
else
self.autoJJRate=0
end
elseif v[3]==4 then
self.autoJJRate=self.autoJJRate+v[4]
end
end
end


return self.autoJJRate
end

function subActivityInfo_xianmengtequan:inTeQuanTime(privilegeType)
local today=self:getStart2NowDay()
local cur=timeHelper.getServerShortTime()
local privilege=self:getSubActConfig('privilege')
for i,v in ipairs(privilege)do
if v[3]==privilegeType then
if v[1]>0 and v[2]>0 then
return today>=v[1]and today<=v[2]
else
local state=true
if v[1]==0 then
state=state and cur>=self.start_time
else
state=state and today>=v[1]
end

if v[2]==0 then
state=state and cur<=self.end_time
else
state=state and today<=v[2]
end
return state
end
end
end
end

function subActivityInfo_xianmengtequan:checkTQEffectByType(type)
local isEffect=false
if self.state==activitiesModel.activityDoingState then
if self:inTeQuanTime(type)then
isEffect=true
end
end

return isEffect
end

function subActivityInfo_xianmengtequan:getTQTip(state)
local sub_name=self:getSubActConfig('sub_name')
local fmt
if state then
fmt='{0}活动开启，任务已自动完成'
else
fmt='{0}活动结束；任务自动完成已取消'
end
local tip=FMT.fmt(fmt,sub_name)
return tip
end

function subActivityInfo_xianmengtequan:getTqModelParams(type)
local model_params=self:getSubActConfig('model_params')or{}
return model_params[type]
end

function subActivityInfo_xianmengtequan:getTqSpeakList(type)
local model_params=self:getSubActConfig('speak_list')or{}
return model_params[type]
end

function subActivityInfo_xianmengtequan:reqFreeGift()
local free_libao_id=self:getSubActConfig('free_libao_id')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
local isCanGift=FreeGiftController.GetFreeGift(free_libao_id,data)
if isCanGift then
FreeGiftController.SendFreeGift(free_libao_id,data,function(result)
if result then
UIManager:invokeUIMethod('UISubAct_XianMengTeQuanWin','onRefresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end
end

return subActivityInfo_xianmengtequan
