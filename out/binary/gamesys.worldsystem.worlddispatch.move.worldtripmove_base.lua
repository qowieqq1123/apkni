worldTripMove_Base=simple_class()
worldTripMove_Base.name="worldTripMove_Base"




function worldTripMove_Base:__init(obj)
self.key=obj.Key
self.callback=nil
self.move=nil
self.object=obj
end

function worldTripMove_Base:start(overTime)
self.move=self:createMoveData(overTime)
if self.move then
worldController:pushMove(self.move)
self.move:Goto(overTime)
end
end

function worldTripMove_Base:cancel()
if self.move then
worldController:popMove(self.key)
end
end

function worldTripMove_Base:complete(overTime)
self:deleteMoveData()
if self.callback then
self.callback(overTime)
end
end

function worldTripMove_Base:createMoveData(overTime)

end

function worldTripMove_Base:deleteMoveData()
if self.move then
worldController:popMove(self.move.Key)
end
end

function worldTripMove_Base:getDuration()
return self.duration or 0
end

function worldTripMove_Base:checkOver(overTime)
if self.duration>0 then
local over=fast-self.duration
return over>=0,over
else
return false,fast
end
end