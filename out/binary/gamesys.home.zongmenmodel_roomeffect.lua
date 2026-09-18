







function zongmenModel:getDzRoomEffect_jjRate(dzId)
local bdData=self:getDiscipleRoom(dzId)
if bdData then
local param=self:getBuildingEffect(bdData,buildingEffectType.eRoomBuild)
if param then
return param[2]or 0
end
end
return 0
end

function zongmenModel:getDzRoomEffect_jjRate_ex_Data(netData)
local rate=0
local bdData=self:getDiscipleRoomByData(netData)
if bdData then
local param=self:getBuildingEffect(bdData,buildingEffectType.eRoomBuild)
if param then
rate=param[2]or 0
end
end
return rate/100
end

function zongmenModel:getDzRoomEffect_jjRate_ex(dzId)
local rate=self:getDzRoomEffect_jjRate(dzId)
return rate/100
end


function zongmenModel:getDzRoomEffect_loyaltyRateByData(netData)
local bdData=self:getDiscipleRoomByData(netData)
if bdData then
local param=self:getBuildingEffect(bdData,buildingEffectType.eRoomBuild)
if param then
return param[3]or 0
end
end
return 0
end

function zongmenModel:getDzRoomEffect_loyaltyRate_ex(netdata)
local rate=self:getDzRoomEffect_loyaltyRateByData(netdata)
return rate/100
end


function zongmenModel:getDzRoomEffect_injuryRate(dzId)
local bdData=self:getDiscipleRoom(dzId)
if bdData then
local param=self:getBuildingEffect(bdData,buildingEffectType.eRoomBuild)
if param then
return param[4]or 0
end
end
return 0
end
function zongmenModel:getDzRoomEffect_injuryRate_ex(dzId)
local rate=self:getDzRoomEffect_injuryRate(dzId)
return rate/100
end