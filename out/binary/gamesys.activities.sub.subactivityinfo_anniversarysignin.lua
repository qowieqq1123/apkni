









local subActivityInfo_anniversarysignin={name='subActivityInfo_anniversarysignin'}

function subActivityInfo_anniversarysignin:onInit()
end

function subActivityInfo_anniversarysignin:onStart()

end

function subActivityInfo_anniversarysignin:onDelete()
end

function subActivityInfo_anniversarysignin:checkReddot()
if not self:hasData()then return false end

if self:checkSign()then
return true
end
if self:checkRepairSign()then
return true
end

local curValue=self:getRewardTimes()
local rewards=self:getSubActConfig('accumulative_rewards')
for idx,v in ipairs(rewards)do
local day=v[1]
if curValue>=day and not self:checkGot(idx)then
return true
end
end

return false
end

function subActivityInfo_anniversarysignin:checkRepairSign()
if not self.data then
return false
end
return self.data.bq_times>0
end

function subActivityInfo_anniversarysignin:checkSign()
if not self.data then
return false
end
return self.data.reward_times<self.data.qd_times
end

function subActivityInfo_anniversarysignin:checkGot(rewardIdx)
if not self.data then
return false
end
return rewardIdx<=self.data.reward_idx
end

function subActivityInfo_anniversarysignin:checkActive()
if self.data.reward_times>0 then
return true
end

local key=FMT.fmt("anniversarySignIn_{0}_{1}_{2}_activation",self.act_id,self.sub_act_type,self.sub_act_id)
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,key,0)~=0
return reddot
end

function subActivityInfo_anniversarysignin:saveActive()
local key=FMT.fmt("anniversarySignIn_{0}_{1}_{2}_activation",self.act_id,self.sub_act_type,self.sub_act_id)
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,key,0)==0
if reddot then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,key,1,0)
end
end

function subActivityInfo_anniversarysignin:setData(qd_times,reward_times,reward_idx,bq_times)
local isInit
if not self.data then
isInit=true
self.data={}
end

self.data.qd_times=qd_times
self.data.reward_times=reward_times
self.data.reward_idx=reward_idx
self.data.bq_times=bq_times

local isActive=self:checkActive()
if isActive then
UIManager:invokeUIMethod("UISubAct_AnniversarySignInWin","refreshPanel1")
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)

if isInit and not isActive then
msgWinControl:addMsgWin(msgWinType.eAnniversarySignIn,{act_id=self.act_id,sub_act_type=self.sub_act_type,sub_act_id=self.sub_act_id},nil,true)
end
end

function subActivityInfo_anniversarysignin:getSignDay()
if not self.data then
return 0
end
return self.data.qd_times or 0
end

function subActivityInfo_anniversarysignin:getRewardTimes()
if not self.data then
return 0
end
return self.data.reward_times or 0
end

function subActivityInfo_anniversarysignin:getRepairSignMaxNum()
if not self.data then
return 0
end
return self.data.bq_times
end

function subActivityInfo_anniversarysignin:getBigRewardList()
if not self.data then
return{}
end
local rewards=self:getSubActConfig('accumulative_rewards')
if not self.data.bigRewardLookup then
self.data.bigRewardLookup={}
self.data.bigRewardMaxIdx=0

for i,v in ipairs(rewards)do
local day=v[1]
local rewardList=v[2]

local list={}
for ii,vv in ipairs(rewardList)do
local isDaoBing=itemsConfig.isDaoBing(vv[1])
local isGuBao=itemsConfig.isGubao(vv[1])
if isDaoBing or isGuBao then
table.insert(list,vv[1])
else
local funcparam=itemsConfig.getConfig(vv[1]).funcparam
if funcparam and funcparam.itemList then
for iii,vvv in ipairs(funcparam.itemList)do
local _isDaoBing=itemsConfig.isDaoBing(vvv[1])
local _isGuBao=itemsConfig.isGubao(vvv[1])
if _isDaoBing or _isGuBao then
table.insert(list,vvv[1])
end
end
end
end
end
if#list>0 then
self.data.bigRewardLookup[day]=list
if i>self.data.bigRewardMaxIdx then
self.data.bigRewardMaxIdx=i
end
end
end
end
local maxIdx=self.data.bigRewardMaxIdx
local rewardIdx=self.data.reward_idx
if rewardIdx>=maxIdx then
local day=rewards[maxIdx][1]
return self.data.bigRewardLookup[day],day,maxIdx
end

for i,v in ipairs(rewards)do
local day=v[1]
local list=self.data.bigRewardLookup[day]
if list and#list>0 and i>rewardIdx then
return list,day,i
end
end
return{},0,0
end

function subActivityInfo_anniversarysignin:reqGetDayReward()
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversarysignin:reqGetProgressReward()
local json_str=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_anniversarysignin:reqRepairSignInReward(day_num)
local json_str=jsonHelper.encode({3,day_num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_anniversarysignin