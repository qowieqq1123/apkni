









local subActivityInfo_dropAct={name='dropAct'}

function subActivityInfo_dropAct:onInit()

end

function subActivityInfo_dropAct:onStart()

end

function subActivityInfo_dropAct:onDelete()

end

function subActivityInfo_dropAct:checkReddot()
local reddot=false
if not self.data then

return reddot
end

if self.data.getRewardSec==0 then

return true
end

return reddot
end

return subActivityInfo_dropAct