worldTripProgress_Family=simple_class(worldTripProgress_Base)
worldTripProgress_Family.name="worldTripProgress_Family"

function worldTripProgress_Family:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.duration=cfgHelper.get2(cfg_xiuzhenfamilybasicconfig_get,trip.world,'jinzhutime')
end

function worldTripProgress_Family:start(time)

worldXiuZhenJiaZuController:refreshFamilyLeftWin(self.trip.target_id)
worldXiuZhenJiaZuController:refreshFamilyRightWin(self.trip.target_guid)
worldHUDModel:onUpdateHUD(self.trip.target_key)
end

function worldTripProgress_Family:quit()

worldXiuZhenJiaZuController:refreshFamilyLeftWin(self.trip.target_id)
worldXiuZhenJiaZuController:refreshFamilyRightWin(self.trip.target_guid)
worldHUDModel:onUpdateHUD(self.trip.target_key)
end