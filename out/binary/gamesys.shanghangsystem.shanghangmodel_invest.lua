





function shangHangModel:setInvestId(id)
self.data.investId=id
end

function shangHangModel:getInvestId()
return self.data.investId
end

function shangHangModel:setTotalInCome(totalInCome)
self.data.totalInCome=totalInCome
end

function shangHangModel:getTotalInCome()
return self.data.totalInCome or 0
end

function shangHangModel:setInvestBeginTime(time)
self.data.investBeginTime=time
end

function shangHangModel:getInvestBeginTime()
return self.data.investBeginTime or 0
end

function shangHangModel:isActivityOpen()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianShu)then
return false
end
local xsId=self:getCurrentId()
if not xsId then
return false
end
local time=self:getRemainingTime()
return time>0
end

function shangHangModel:getRemainingTime()
local investId=shangHangModel:getInvestId()
if investId==0 then
return 0
end

local investCfg=cfgHelper.get(cfg_shanghangtargetconfig_get,investId)


local startTime=self:getInvestBeginTime()
local onydaysec=86400
local endTime=startTime+investCfg.days*onydaysec
local serverTime=gameUtilityModel.getServerShortTime()

return endTime-serverTime
end

function shangHangModel:setInvestBuy(flag)
self.data.investBuy=flag
end

function shangHangModel:isInvestBuy()
return self.data.investBuy==1
end


function shangHangModel:setInvestRewardFlag(flag)
self.data.investRewardFlag=flag
end

function shangHangModel:isInvestRewardGot(idx)
local dh,dl=mathHelper.splitToInt32(self.data.investRewardFlag)
if idx>31 then
return bitHelper.check_pos(dh,idx-32)
else
return bitHelper.check_pos(dl,idx-1)
end

end


function shangHangModel:setInvestRewardExFlag(flag)
self.data.investRewardExFlag=flag
end

function shangHangModel:isInvestRewardExGot(idx)
local dh,dl=mathHelper.splitToInt32(self.data.investRewardExFlag)
if idx>31 then
return bitHelper.check_pos(dh,idx-32)
else
return bitHelper.check_pos(dl,idx-1)
end
end
