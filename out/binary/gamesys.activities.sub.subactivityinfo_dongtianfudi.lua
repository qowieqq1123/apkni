





local subActivityInfo_dongtianfudi={name='dongtianfudi'}

function subActivityInfo_dongtianfudi:onInit()

end

function subActivityInfo_dongtianfudi:onStart()

end

function subActivityInfo_dongtianfudi:onDelete()

end

function subActivityInfo_dongtianfudi:checkUnlockPos()
if not self.data then
return false
end
local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eDongTianFuDi,self.sub_act_id)
local lotteryList=config.lotteryList

local total_num=self.data.total_num
return total_num>=lotteryList[1][2]
end

function subActivityInfo_dongtianfudi:checkReddot()
if not self.data then
return false
end
local use_free_num=self.data.use_free_num or 0
local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eDongTianFuDi,self.sub_act_id)
local freeTimes=config.free_num
if freeTimes-use_free_num>0 then
return true
end

local lottery_item=self:getSubActConfig('lottery_item')
local cost=cfgHelper.getdef(cfg_dtfdactivityconfig,'item_num')
local count=itemsModel.getCount(lottery_item)
if count>=cost[2]then
return true
end

for i=1,4 do
local flag,times=activitiesHandle_dongtianfudi:getCanBuyTimes(self.act_id,self.sub_act_id,i)
if flag==1 then
return true
end
end
end

function subActivityInfo_dongtianfudi:getLimitList(fudiIndex)
if not self.data.limitList then
return
end
return self.data.limitList[fudiIndex]
end


function subActivityInfo_dongtianfudi:checkNewDay()
if self:checkDoing()then
self.data.use_free_num=0

UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","refreshBuyBtn")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDongTianFuDi)
end
end





return subActivityInfo_dongtianfudi