









local subActivityInfo_lunhuizhuanpan={name='lunhuizhuanpan'}

function subActivityInfo_lunhuizhuanpan:onInit()

end

function subActivityInfo_lunhuizhuanpan:onStart()

end

function subActivityInfo_lunhuizhuanpan:onDelete()

end


function subActivityInfo_lunhuizhuanpan:onNewDay()
if self.data then
self.data.daily_luck_cnt=0
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
UIManager:invokeUIMethod('UISubAct_lunhuizhuanpanWin','rec_newday')
end
end

function subActivityInfo_lunhuizhuanpan:initRewardLib()
if self.data then
local reward_lib={}
local lib=self:getSubActConfig("lib")
for idx,reward_list in ipairs(lib)do
local small_rewards={}
local big_rewards={}
for idx,reward in ipairs(reward_list)do
local isBigReward=reward[2]==1
local num=reward[3]
local items=reward[4][1]
local rare=reward[5]
if isBigReward then
table.insert(big_rewards,items)
else
table.insert(small_rewards,{
idx=idx,
num=num,
items=items,
rare=rare,
})
end
end
table.sort(small_rewards,function(a,b)
return a.rare>b.rare
end)
if#big_rewards==1 then
big_rewards=big_rewards[1]
end
reward_lib[idx]=small_rewards
end
self.data.reward_lib=reward_lib
end
end

function subActivityInfo_lunhuizhuanpan:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:exchangeReddot()then
return true
elseif self:lotteryReddot()then
return true
end
end
return false
end

function subActivityInfo_lunhuizhuanpan:exchangeReddot()
if self.data then
local stage_reward=self:getSubActConfig("stage_reward")
local stage_reward_idx=self.data.stage_reward_idx
local total_luck_cnt=self.data.total_luck_cnt
local next_idx=stage_reward_idx+1
local stage_reward_conf=stage_reward[next_idx]
if stage_reward_conf then
local target=stage_reward_conf[1]
return total_luck_cnt>=target
end
end
return false
end

function subActivityInfo_lunhuizhuanpan:lotteryReddot()
local cfg=self:getSubActConfig("itemnum")
for i,v in ipairs(cfg)do
if v~=1 and self:lotteryEnough(v)then
return true
end
end
return false
end

function subActivityInfo_lunhuizhuanpan:lotteryEnough(num)
local itemId=self:getSubActConfig("itemid")
local itemNum=num
local have=itemsModel.getCount(itemId)
return have>=itemNum
end

function subActivityInfo_lunhuizhuanpan:getJumpAnimation()
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
if self.jumpLoad==nil then
self.jumpAnimation=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,nil)
if self.jumpAnimation and timeHelper.getServerShortTime()>self.jumpAnimation[1]then
self.jumpAnimation=nil
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,nil)
end
self.jumpLoad=true
end
return self.jumpAnimation and self.jumpAnimation[2]or false
end

function subActivityInfo_lunhuizhuanpan:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end

function subActivityInfo_lunhuizhuanpan:checkFree()
if self.data then
local daily_luck_cnt=self.data.daily_luck_cnt
local freenum=self:getSubActConfig("free")
return daily_luck_cnt<freenum
end
return false
end

function subActivityInfo_lunhuizhuanpan:lottery(type)
if type==1 and self:checkFree()then
local jstr=jsonHelper.encode({2,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end
local itemId=self:getSubActConfig("itemid")
local timesCfg=self:getSubActConfig("itemnum")
local itemNum=timesCfg[type]
local have=itemsModel.getCount(itemId)

if have>=itemNum then
local jstr=jsonHelper.encode({2,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end

return subActivityInfo_lunhuizhuanpan