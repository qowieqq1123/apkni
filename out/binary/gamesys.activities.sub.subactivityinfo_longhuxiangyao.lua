









local subActivityInfo_longhuxiangyao={name='longhuxiangyao'}

function subActivityInfo_longhuxiangyao:onInit()
self.RewardStage={
eRecved=1,
eNotRecv=2,
eRecv=3,
}
self.rewards=self:getSubActConfig('rewards')
self.monster=self:getSubActConfig('monster')
self.stageRewardList={}
self.swRewardIdx=1
for i,v in ipairs(self.rewards)do
if v[1]~=0 then
self.stageRewardList[#self.stageRewardList+1]={i,v[1]}
else
self.swRewardIdx=i
end
end
end

function subActivityInfo_longhuxiangyao:onStart()

end

function subActivityInfo_longhuxiangyao:onUpdate()

end

function subActivityInfo_longhuxiangyao:onDelete()

end

function subActivityInfo_longhuxiangyao:checkReddot()
if not self.data then

return false
end
return self:checkRewardState()or self:checkStageEnterState()or self:checkChanllge()
end


function subActivityInfo_longhuxiangyao:checkRewardState()
local RewardStage=self.RewardStage
return self:getRewardState()==RewardStage.eRecv
end


function subActivityInfo_longhuxiangyao:getRewardState()
local RewardStage=self.RewardStage
local monsterIndex=self.data.monster_idx
local reward_flag=self.data.reward_flag
local state=RewardStage.eNotRecv
local idx=self.swRewardIdx
if bitHelper.check_pos(reward_flag,idx-1)then
return RewardStage.eRecved
end
local cur,max=self:getStagePro()
if cur>=max then
return RewardStage.eRecv
else
return RewardStage.eNotRecv
end
end


function subActivityInfo_longhuxiangyao:getStagePro()
local monsterIndex=self.data.monster_idx
local cur=0
local max=#self.stageRewardList
for i,v in ipairs(self.stageRewardList)do
if monsterIndex>=v[2]then
cur=cur+1
end
end
return cur,max
end


function subActivityInfo_longhuxiangyao:checkStageEnterState()
local RewardStage=self.RewardStage
for i,v in ipairs(self.stageRewardList)do
if self:getStageState(i)==RewardStage.eRecv then
return true
end
end
return false
end


function subActivityInfo_longhuxiangyao:getStageState(stage)
local RewardStage=self.RewardStage
local monsterIndex=self.data.monster_idx
local reward_flag=self.data.reward_flag
local stageCfg=self.stageRewardList[stage]
local idx=stageCfg[1]
if bitHelper.check_pos(reward_flag,idx-1)then
return RewardStage.eRecved
end
if monsterIndex>=stageCfg[2]then
return RewardStage.eRecv
else
return RewardStage.eNotRecv
end
end


function subActivityInfo_longhuxiangyao:checkChanllge()
local nextMonIndex=self.data.monster_idx+1
local nextMonCfg=self.monster[nextMonIndex]
if nextMonCfg then
local curday=self:getStart2NowDay()
if nextMonCfg[1]<=curday then
return true
end
end
return false
end





function subActivityInfo_longhuxiangyao:checkNewDay()
UIManager:invokeUIMethod("UISubAct_longhuxiangyao_Win","newDay")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end


function subActivityInfo_longhuxiangyao:startActTime()

end

return subActivityInfo_longhuxiangyao