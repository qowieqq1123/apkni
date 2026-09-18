worldTripProgress_RunTo_Monster=simple_class(worldTripProgress_RunTo)
worldTripProgress_RunTo_Monster.name="worldTripProgress_RunTo_Monster"

function worldTripProgress_RunTo_Monster:addTrigger()
if self.moves[1]then
local t=function(o,n)
if n<5 and o<=1 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if n>=5 then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)

local obj=worldController:getUnit(self.trip.target_key)
if obj then
obj:ShowShadow(false)
obj:PlayModelEffect(worldDispatchFactory.fightEffect,Vector3.zero,Vector3.one)
obj:ChangeModelColor(Color.clear,0)
end
end
end
self.moves[1]:addTrigger(t)
end
end