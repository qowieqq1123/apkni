worldTripProgress_Monster=simple_class(worldTripProgress_Base)
worldTripProgress_Monster.name="worldTripProgress_Monster"

function worldTripProgress_Monster:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.duration=cfgHelper.get1(cfg_worldmonsterconfig_get,1).resultwaittime
end

function worldTripProgress_Monster:start(time)

local obj=worldController:getUnit(self.trip.target_key)
if obj then
self.objects[0]=obj
obj:StopModelEffect(worldDispatchFactory.fightEffect)

obj:ShowShadow(false)
obj:PlayModelEffect(worldDispatchFactory.fightEffect,Vector3.zero,Vector3.one)
obj:ChangeModelColor(Color.clear,0)
end

















end

function worldTripProgress_Monster:quit()
local obj=self.objects[0]
if obj then

obj:ShowShadow(true)
obj:StopModelEffect(worldDispatchFactory.fightEffect)


obj:ChangeModelColor(Color.white,0)

worldMonsterModel:showTaskResult(self.trip.target_guid,true)
else

end
self.objects={}
self.moves={}
end
