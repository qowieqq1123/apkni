






local _MODULENAME="yunyouMerchantModel"


def_table(_MODULENAME)
yunyouMerchantModel.name=_MODULENAME
yunyouMerchantModel.data=nil
yunyouMerchantModel.canFight=nil

local _fightInterval=5


function yunyouMerchantModel:onAppStart()

end


function yunyouMerchantModel:onEnterState(isReconnect)

end


function yunyouMerchantModel:onProtocolReq()

end


function yunyouMerchantModel:onLeaveState(isReconnect)

self:clearData()
end


function yunyouMerchantModel:hasData()
return self.data~=nil
end

function yunyouMerchantModel:initData(monLevel,refreshTimes,buyFlag,damagePercent,zmLevel,giftIdx)
self.data={
monLevel=monLevel,
refreshTimes=refreshTimes,
buyFlag=buyFlag,
damagePercent=damagePercent,
zmLevel=zmLevel,
giftIdx=giftIdx,
}
end

function yunyouMerchantModel:getData()
return self.data
end

function yunyouMerchantModel:clearData()
self.data=nil
self.canFight=nil
end

function yunyouMerchantModel:updateDamagePercent(damagePercent)
if self:hasData()then
self.data.damagePercent=math.max(damagePercent,self.data.damagePercent)
end
end

function yunyouMerchantModel:updateBuyFlag(buyFlag)
if self:hasData()then
self.data.buyFlag=buyFlag
end
end

function yunyouMerchantModel:nextData(monLevel,zmLevel,giftIdx)
if self:hasData()then
self.data.damagePercent=-1
self.data.buyFlag=false
self.data.refreshTimes=self.data.refreshTimes+1
self.data.monLevel=monLevel or cfgHelper.get4(cfg_business2config_get,1,"mon_conf",self.data.refreshTimes,2)
self.data.zmLevel=zmLevel or self.data.zmLevel
self.data.giftIdx=giftIdx or self.data.giftIdx
end
end

function yunyouMerchantModel:recordFightTime()
self.canFight=timeHelper.getServerShortTime()+_fightInterval
end

function yunyouMerchantModel:checkFightTime()
if self.canFight then
return timeHelper.getServerShortTime()>self.canFight
end
return true
end

function yunyouMerchantModel:checkCloseLimit()
local limit=cfgHelper.get2(cfg_business2config_get,1,"sect_lv")
local lv=zongmenModel:getLevel()
return lv>=limit
end