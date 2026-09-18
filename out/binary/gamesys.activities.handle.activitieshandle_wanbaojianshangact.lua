







activitiesHandle_wanbaojianshangAct=new_activitiesHandle('activitiesHandle_wanbaojianshangAct',activitiesHandle)

function activitiesHandle_wanbaojianshangAct:onInit()

end

function activitiesHandle_wanbaojianshangAct:onDelete()
self:clearNextRefreshDailyChangeReddotTimer()
end

function activitiesHandle_wanbaojianshangAct:setNextRefreshDailyChangeReddotTimer()
self:clearNextRefreshDailyChangeReddotTimer()
local nowTime=timeHelper.getServerShortTime()
local nextCheckTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+86400)
local delta=nextCheckTime-nowTime

self.refreshTimer=timer.new()
self.refreshTimer:start(delta,function()

local subType=SUB_ACTIVITY_TYPE.eWanBaoJianShang
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

local win=UIManager:findActiveWindow('UISubAct_WanBaoJianShangActWin')
if win then
win:refreshChangeReddot()
end
end,1)
end

function activitiesHandle_wanbaojianshangAct:clearNextRefreshDailyChangeReddotTimer()
if self.refreshTimer then
self.refreshTimer:cancel()
end
self.refreshTimer=nil
end

function activitiesHandle_wanbaojianshangAct.recv_249_117(actId,subId,nowJiFen,rwJiFen)
local subType=SUB_ACTIVITY_TYPE.eWanBaoJianShang

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end
data.nowScore=nowJiFen
data.maxRewardGotScore=rwJiFen

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_WanBaoJianShangActWin')
if win then
win:refreshProgress()
win:refreshChangeReddot()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_wanbaojianshangAct.test_clearDailyChangeMark()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWBJSActChange,'changeTime',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWBJSActChange)
end