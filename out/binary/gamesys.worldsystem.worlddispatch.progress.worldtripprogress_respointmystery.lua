worldTripProgress_ResPointMystery=simple_class(worldTripProgress_Base)
worldTripProgress_ResPointMystery.name="worldTripProgress_ResPointMystery"

function worldTripProgress_ResPointMystery:start(time)
local data,guid,subIdx=worldResPointDataModel:findMysteryData(self.trip.target_id)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
worldHUDModel:UpdateHUDByKey(unitKey)
end

function worldTripProgress_ResPointMystery:quit()
local data,guid,subIdx=worldResPointDataModel:findMysteryData(self.trip.target_id)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
worldHUDModel:UpdateHUDByKey(unitKey)
end