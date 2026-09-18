
mgsTipsShowNode=simple_class(baseNode)

function mgsTipsShowNode:update(interval)
local tipsType=self:getData('tipsType')
local param1=self:getData('param1')
local param2=self:getData('param2')

if tipsType==1 then
UIManager.info(param1)
elseif tipsType==2 then
UIManager.error(param1)
elseif tipsType==3 then
UIManager.topHourceLamp(param1)
elseif tipsType==4 then
UIManager.midHourceLamp(param1)
elseif tipsType==5 then
UIManager.serverError(param1)
elseif tipsType==6 then
UIManager.rewardInfo(param1,param2)
end

return nodeState.success
end