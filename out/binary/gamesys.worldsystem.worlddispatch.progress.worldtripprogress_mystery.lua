worldTripProgress_Mystery=simple_class(worldTripProgress_Base)
worldTripProgress_Mystery.name="worldTripProgress_Mystery"

function worldTripProgress_Mystery:start(time)
worldHUDModel:UpdateHUDByKey(self.trip.target_key)
end

function worldTripProgress_Mystery:quit()
worldHUDModel:UpdateHUDByKey(self.trip.target_key)
end