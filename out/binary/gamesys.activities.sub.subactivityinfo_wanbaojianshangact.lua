









local subActivityInfo_wanbaojianshangAct={name='wanbaojianshangAct'}

function subActivityInfo_wanbaojianshangAct:onInit()
self._on_new_day=function(...)
self:on_new_day(...)
end
notifySystem:listenNotify(notifyConfig.onNewDay,self._on_new_day)
end

function subActivityInfo_wanbaojianshangAct:onStart()

end

function subActivityInfo_wanbaojianshangAct:onDelete()
notifySystem:removelistener(notifyConfig.onNewDay,self._on_new_day)
end

function subActivityInfo_wanbaojianshangAct:on_new_day()

self.data={
nowScore=0,
maxRewardGotScore=0,
}

local win=UIManager:findActiveWindow('UISubAct_WanBaoJianShangActWin')
if win then
win:refreshProgress()
win:refreshChangeReddot()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eWanBaoJianShang)
end

function subActivityInfo_wanbaojianshangAct:checkReddot()
if not self.data then

return false
end

local boxCfgList=self:getSubActConfig('box')
local nowScore=self.data.nowScore
local maxRewardGotScore=self.data.maxRewardGotScore
local maxTargetScore=boxCfgList[#boxCfgList][1]
if maxRewardGotScore>=maxTargetScore then

return false
end

local dailyChangeReddot=self:checkDailyChangeReddot(true)


if dailyChangeReddot then
return true
end

for i,v in ipairs(boxCfgList)do
local targetScore=v[1]
if maxRewardGotScore<targetScore and nowScore>=targetScore then

return true
end
end

return false
end


function subActivityInfo_wanbaojianshangAct:checkDailyChangeReddot(isIgnoreMaxReward)
if not isIgnoreMaxReward then

local boxCfgList=self:getSubActConfig('box')
local maxRewardGotScore=self.data.maxRewardGotScore
local maxTargetScore=boxCfgList[#boxCfgList][1]
if maxRewardGotScore>=maxTargetScore then

return false
end
end

local changeTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWBJSActChange,'changeTime',nil)
if not changeTime then

return true
else

local isToday=timeHelper.isTodayShort(changeTime)
return not isToday
end
end

function subActivityInfo_wanbaojianshangAct:setDailyChangeReddot()
local isCanUpdate=self:checkDailyChangeReddot()
if not isCanUpdate then
return
end
local nowTime=timeHelper.getServerShortTime()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWBJSActChange,'changeTime',nowTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWBJSActChange)

local win=UIManager:findActiveWindow('UISubAct_WanBaoJianShangActWin')
if win then
win:refreshChangeReddot()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end


function subActivityInfo_wanbaojianshangAct:reqGetWBJSActReward()
local json_str=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_wanbaojianshangAct:reqAddWBJSActMaxScore(maxScore)

local addScore=0
local nowScore=self.data.nowScore or 0
addScore=maxScore-nowScore
if addScore>0 then
local json_str=jsonHelper.encode({1,addScore})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end
end

return subActivityInfo_wanbaojianshangAct