worldTripProgress_ResMystery=simple_class(worldTripProgress_Base)
worldTripProgress_ResMystery.name="worldTripProgress_ResMystery"

function worldTripProgress_ResMystery:start(time)
local keys=worldModel:separateUnitKey(self.trip.target_key)
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(tonumber(keys[2]))
if group then
local key=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,table.concat({group[1],group[2]},'-')})
worldHUDModel:UpdateHUDByKey(key)
end
end

function worldTripProgress_ResMystery:quit()
local keys=worldModel:separateUnitKey(self.trip.target_key)
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(tonumber(keys[2]))
if group then
local key=worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,table.concat({group[1],group[2]},'-')})
worldHUDModel:UpdateHUDByKey(key)
end
end