









local subActivityInfo_tiantishilian={name='tiantishilian'}

function subActivityInfo_tiantishilian:onInit()
self.config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
end

function subActivityInfo_tiantishilian:checkReddot()
return self:checkAchieve()or not self.data.isReceiveJoinReward
end

function subActivityInfo_tiantishilian:checkAchieve()
local checkid=self.data.aimIndex+1
if self.config.aim[checkid]then
if self.data.totalfloor>=self.config.aim[checkid][1]then
return true
end
end
return false
end




return subActivityInfo_tiantishilian