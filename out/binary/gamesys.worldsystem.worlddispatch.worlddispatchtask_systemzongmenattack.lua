worldDispatchTask_SystemZongMenAttack=simple_class(worldDispatchTask_Fake)
worldDispatchTask_SystemZongMenAttack.name="worldDispatchTask_SystemZongMenAttack"


function worldDispatchTask_SystemZongMenAttack:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_AttackSystemZongMen.New(self),
[eWorldTripProgress.Back]=worldTripProgress_Empty.New(self),
}
end


function worldDispatchTask_SystemZongMenAttack:init()
local infoData=systemZongMenModel:getInfoData(self.target_guid)
local teamData=systemZongMenModel:findBattleWaitResultEx(self.target_guid,self.target_id)
self.progress_state=eWorldTripProgress.Work
self.progress_begin=teamData and teamData.sinceStamp or 0
self.progress_end=0
end

function worldDispatchTask_SystemZongMenAttack:path()
self.corners=worldDispatchFactory:getPathCorners(eWorldTripType.Fly,self.destination,nil,self.world)
self.move_duration=0
self.trip_duration=0
end