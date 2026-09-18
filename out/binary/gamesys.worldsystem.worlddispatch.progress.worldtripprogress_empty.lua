worldTripProgress_Empty=simple_class(worldTripProgress_Base)
worldTripProgress_Empty.name="worldTripProgress_Empty"

function worldTripProgress_Empty:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.duration=0
end