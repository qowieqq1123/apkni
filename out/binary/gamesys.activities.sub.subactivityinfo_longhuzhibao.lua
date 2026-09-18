









local subActivityInfo_longhuzhibao={name='longhuzhibao'}

function subActivityInfo_longhuzhibao:onInit()
self.data={}
end

function subActivityInfo_longhuzhibao:onStart()

end

function subActivityInfo_longhuzhibao:onUpdate()

end

function subActivityInfo_longhuzhibao:onDelete()

end

function subActivityInfo_longhuzhibao:checkReddot()
local reddotflag=self:reqlonghuzhibao_checkDailyRewardsIsGot()
if reddotflag then
return true
end
return false
end




function subActivityInfo_longhuzhibao:reqlonghuzhibao_checkDailyRewardsIsGot()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}

return FreeGiftController.GetFreeGift(giftid,data)
end


function subActivityInfo_longhuzhibao:reqlonghuzhibao_getDailyRewards()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then

local win=UIManager:findActiveWindow('UISubAct_longhuzhibao_Win')
if win then
win:refreshDailyReward()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end


return subActivityInfo_longhuzhibao