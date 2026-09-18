









local subActivityInfo_monthInvestorGift={name='monthInvestorGift'}

function subActivityInfo_monthInvestorGift:onInit()

end

function subActivityInfo_monthInvestorGift:onStart()

end

function subActivityInfo_monthInvestorGift:onDelete()

end

function subActivityInfo_monthInvestorGift:checkReddot()
local reddot=false
if not self.data then

return reddot
end

local isGot=self.data.normalRequirement==2 and self.data.highRequirement==2
if isGot then

return reddot
end
local normalRequirementFinish=self.data.normalRequirement==1
local highRequirementFinish=self.data.highRequirement==1
if normalRequirementFinish and highRequirementFinish then

reddot=true
end

return reddot
end

function subActivityInfo_monthInvestorGift:checkHasDiscount(cardType)

local discountCfg=self:getSubActConfig('zkcz')
if discountCfg then
local rechargeId=discountCfg[cardType]
if rechargeId and rechargeId~=0 then
local hasDiscount=false
if cardType==1 then

hasDiscount=not self.data.normalDisCount or self.data.normalDisCount<=0
elseif cardType==2 then

hasDiscount=not self.data.highDisCount or self.data.highDisCount<=0
end
return hasDiscount,rechargeId
end
end
return false
end

return subActivityInfo_monthInvestorGift