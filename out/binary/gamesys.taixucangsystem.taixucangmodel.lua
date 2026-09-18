






local _MODULENAME="TaiXuCangModel"


def_table(_MODULENAME)
TaiXuCangModel.name=_MODULENAME
TaiXuCangModel.data={}

function TaiXuCangModel:onAppStart()

end


function TaiXuCangModel:onEnterState(isReconnect)

end


function TaiXuCangModel:onProtocolReq()

end


function TaiXuCangModel:onLeaveState(isReconnect)

self.data={}
end

function TaiXuCangModel:getBuildingData()
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eTaiXuCang)
if#datas>0 then
return datas[1]
end
end

function TaiXuCangModel:getInterval()
return cfgHelper.getdef1(cfg_taixucangconfig,'interval')
end

function TaiXuCangModel:getMax()
return cfgHelper.getdef1(cfg_taixucangconfig,'max')
end


function TaiXuCangModel:setLastStamp(stamp)
self.data.stamp=stamp
end

function TaiXuCangModel:setPlunderData(plunderlistlen,plunderList,beplunderlistlen,beplunderList)
self.data.plunderList={}
for i=1,plunderlistlen do
local plunderid=plunderList[i].param_1
local plunderValue=plunderList[i].param_2
self.data.plunderList[plunderid]=plunderValue
end

self.data.beplunderList={}
for i=1,beplunderlistlen do
local beplunderid=beplunderList[i].param_1
local beplunderValue=beplunderList[i].param_2
self.data.beplunderList[beplunderid]=beplunderValue
end
end

function TaiXuCangModel:getLastStamp()
return self.data.stamp
end

function TaiXuCangModel:getPlunderList()
return self.data.plunderList or{}
end

function TaiXuCangModel:getBeplunderList()
return self.data.beplunderList or{}
end

function TaiXuCangModel:getLeftTime()
local now=timeHelper.getServerShortTime()
local interval=TaiXuCangModel:getInterval()
local last=TaiXuCangModel:getLastStamp()
local max=TaiXuCangModel:getMax()

if not last then
return-2
end

if(now-last)/interval>=max then

return-1
else
return interval-math.fmod(now-last,interval)
end
end

function TaiXuCangModel:getNum()
local now=timeHelper.getServerShortTime()
local interval=TaiXuCangModel:getInterval()
local last=TaiXuCangModel:getLastStamp()
if not last then
return 0
end

local num=math.max(math.floor((now-last)/interval),0)
local max=TaiXuCangModel:getMax()

return math.min(num,max)
end

function TaiXuCangModel:checkGetItem()
return self:getNum()>0
end

function TaiXuCangModel:getProtectMoney()
local bdData=TaiXuCangModel:getBuildingData()
if not bdData then
return
end
local level=bdData.level or 1
local protect=cfgHelper.get2(cfg_taixucangconfig_get,level,'protect')
return protect
end

function TaiXuCangModel:checkAboveProtectMoney()
local protectList=TaiXuCangModel:getProtectMoney()
if protectList then

for moneyType,v in pairs(protectList)do
local num=moneyModel.getMoney(moneyType)
local total=math.floor(v+v*TaiXuCangModel:getProtectAdd(moneyType)/100)
if num>=total then
return true
end
end
end
return false
end


function TaiXuCangModel:getProtectAdd(moneyType)
return gubaoModel:getTaiXuCangProtectVal(moneyType)
end

