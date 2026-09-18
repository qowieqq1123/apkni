






local _MODULENAME="weekendBenifitsModel"


def_table(_MODULENAME)
weekendBenifitsModel.name=_MODULENAME
weekendBenifitsModel.data={}

function weekendBenifitsModel:onAppStart()

end


function weekendBenifitsModel:onEnterState(isReconnect)





end


function weekendBenifitsModel:onProtocolReq()

end


function weekendBenifitsModel:onLeaveState(isReconnect)

self.data={}
end

function weekendBenifitsModel:setServerData(reward_flag,login_flag,reward_idx)
self.data.reward_flag=reward_flag
self.data.loginFlag=login_flag
self.data.rewardIdx=reward_idx
end

function weekendBenifitsModel:setRewardFlag(reward_flag)
self.data.reward_flag=reward_flag
end

function weekendBenifitsModel:setRewardIdxFlag(reward_idx)
local id=cfgHelper.get2(cfg_weekendbenefitsconfig_get,reward_idx,'id')
self.data.reward_flag=bitHelper.set_1(self.data.reward_flag,id-1)
end

function weekendBenifitsModel:getRewardIdx()
return self.data.rewardIdx
end

function weekendBenifitsModel:getRewardFlag(reward_idx)
return bitHelper.check_pos(self.data.reward_flag,reward_idx-1)
end

function weekendBenifitsModel:getCanReceive(reward_idx)
return not bitHelper.check_pos(self.data.reward_flag,reward_idx-1)
end

function weekendBenifitsModel:getLoginFlag(login_idx)
return bitHelper.check_pos(self.data.loginFlag,login_idx-1)
end

function weekendBenifitsModel:checkOpen()
local isOpen=false
if systemModel.isOpen(SYSTEM_DEFINE.eWeekendBenifits)and next(self.data)then
local id=self:getCfgId()
if id then
isOpen=true
end
end
return isOpen
end

function weekendBenifitsModel:checkReddot()
local reddot=false
local rewardIndex=self:getCfgId()
if rewardIndex and self.data.reward_flag then
reddot=not bitHelper.check_pos(self.data.reward_flag,rewardIndex-1)
end

return reddot
end

function weekendBenifitsModel:getCfgId()
local allCfg=cfg_weekendbenefitsconfig()
local dIndex=timeHelper.getWeakDateEx()
return allCfg[dIndex]and allCfg[dIndex].id
end

function weekendBenifitsModel:getCfgByIndex(index)
local allCfg=cfg_weekendbenefitsconfig()

for k,cfg in pairs(allCfg)do
if k~='const_def'then
if cfg.id==index then
return cfg
end
end
end
end

function weekendBenifitsModel:getLeftTime()
local id=self:getCfgId()
local leftTime=0
if id then
local oneDaySec=86400
local curSpendTime=timeHelper.getServerTodayPass()
leftTime=oneDaySec*3-(id-1)*86400-curSpendTime
end

return leftTime
end


function weekendBenifitsModel:getCeilState(index)
local id=self:getCfgId()
local ceilState
if id then
if id==index then
ceilState=2
elseif id+1==index then
ceilState=3
elseif id+2==index then
ceilState=4
elseif id>index then
ceilState=1
end
else
ceilState=0
end
return ceilState
end


