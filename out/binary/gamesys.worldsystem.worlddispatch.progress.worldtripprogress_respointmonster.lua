worldTripProgress_ResPointMonster=simple_class(worldTripProgress_Monster)
worldTripProgress_ResPointMonster.name="worldTripProgress_ResPointMonster"

function worldTripProgress_ResPointMonster:quit()
local obj=worldController:getUnit(self.trip.target_key)
if obj then

obj:ShowShadow(true)
obj:StopModelEffect(worldDispatchFactory.fightEffect)


obj:ChangeModelColor(Color.white,0)

worldResPointFightModel:showFightResult(self.trip.target_guid,self.trip.target_id)
else

end
self.objects={}
self.moves={}
end
