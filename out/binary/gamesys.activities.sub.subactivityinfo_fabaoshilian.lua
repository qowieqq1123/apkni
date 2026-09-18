









local subActivityInfo_fabaoshilian={name='fabaoshilian'}

function subActivityInfo_fabaoshilian:onInit()

end

function subActivityInfo_fabaoshilian:onStart()

end

function subActivityInfo_fabaoshilian:onUpdate()

end

function subActivityInfo_fabaoshilian:onDelete()

end


function subActivityInfo_fabaoshilian:onNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
UIManager:invokeUIMethod('UISubAct_fabaoshilian_win','rec_newday')
end

function subActivityInfo_fabaoshilian:checkReddot()
if self.data then
local list=self:getSubActConfig('monster')
for idx,cfg in ipairs(list)do
if self:checkMonsterReddot(cfg,idx)or self:checkMonsterReddot2(cfg,idx)then
return true
end
end
end
return false
end

function subActivityInfo_fabaoshilian:onKillMonster(idx,result)
if self.data then
if result==fightResultType.Victory then
self.data.monidx=idx
end
self:setBattleRedcord(idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end

function subActivityInfo_fabaoshilian:checkMonsterUnlock(cfg,idx,isWarning)
local day=self:getStart2NowDay()
if day<cfg[1]then
if isWarning then
UIManager.error(FMT.fmt('活动第{0}天开启',cfg[1]))
end
return false
end
local idx_=self.data.monidx+1
if idx>idx_ then
if isWarning then
UIManager.error(FMT.fmt('请先击败第{0}关',idx-1))
end
return false
end
return true
end

function subActivityInfo_fabaoshilian:checkKilled(idx)
return idx<=self.data.monidx
end

function subActivityInfo_fabaoshilian:getRewardIndex(cfg,idx)
local r_num=self.data.monidx_lp[idx]or 0
if r_num>0 then
local r_num_=r_num-1
local max_num=#cfg[5]
if r_num_>=max_num then
return nil
else
return r_num+1
end
else
return 1
end
end

function subActivityInfo_fabaoshilian:checkMonsterReddot(cfg,idx)
if self:checkMonsterUnlock(cfg,idx)then
local rewardIdx=self:getRewardIndex(cfg,idx)
if rewardIdx==1 and self:checkKilled(idx)then
return true
end
end
return false
end

function subActivityInfo_fabaoshilian:checkMonsterReddot2(cfg,idx)
if self:checkMonsterUnlock(cfg,idx)and not self:checkKilled(idx)then
return self:checkBattleRedcord(idx)
end
return false
end

function subActivityInfo_fabaoshilian:getBattleRecords()
local temp=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eActFaBaoMiLu,{})
temp.battle=temp.battle or{}
local id_str=tostring(self.sub_act_id)
temp.battle[id_str]=temp.battle[id_str]or{}
return temp.battle[id_str]
end

function subActivityInfo_fabaoshilian:setBattleRedcord(idx)
local lp=self:getBattleRecords()
local idx_str=tostring(idx)
lp[idx_str]=gameUtilityModel.getServerLongTime()
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActFaBaoMiLu)
end

function subActivityInfo_fabaoshilian:checkBattleRedcord(idx)
local lp=self:getBattleRecords()
local idx_str=tostring(idx)
local old=lp[idx_str]
if old~=nil then
local cur=gameUtilityModel.getServerLongTime()
if timeHelper.checkInSameDay(cur,old)then
return false
end
end
return true
end

return subActivityInfo_fabaoshilian