









local subActivityInfo_festivalSignIn={name='festivalSignIn'}

function subActivityInfo_festivalSignIn:onInit()

end

function subActivityInfo_festivalSignIn:onStart()

end

function subActivityInfo_festivalSignIn:onDelete()

end

function subActivityInfo_festivalSignIn:checkReddot()
local reddot=false
if not self.data then

return reddot
end

local rewardsCfg=self:getSubActConfig('rewards')
local maxDayIndex=#rewardsCfg
for i=1,maxDayIndex do
local isSign=self:checkDayIsSignIn(i)
local isGot=self:checkDayRewardIsGot(i)
if isSign and not isGot then
return true
end
end

return reddot
end

function subActivityInfo_festivalSignIn:checkDayIsSignIn(dayIndex)
if not self.data then

return
end

if self.data.maxSignInDayIndex then
if dayIndex<=self.data.maxSignInDayIndex then
return true
end
end

local signInFlag=self.data.signInFlag
local isSignIn=bitHelper.check_pos(signInFlag,dayIndex-1)
return isSignIn
end

function subActivityInfo_festivalSignIn:checkDayRewardIsGot(dayIndex)
if not self.data then

return
end

local rewardFlag=self.data.rewardFlag
local isGot=bitHelper.check_pos(rewardFlag,dayIndex-1)
return isGot
end

function subActivityInfo_festivalSignIn:reqGetFestivalDayReward(dayIndex)
local json_str=jsonHelper.encode({1,dayIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_festivalSignIn