worldTripMoveList=simple_class()
worldTripMoveList.name="worldTripMoveList"

function worldTripMoveList:__init()
self.list={}
self.trigger=nil
self.progress=0
end

function worldTripMoveList:addMove(move)
move.callback=function(pass)
self:onStep(pass)
end
table.insert(self.list,move)
end





























function worldTripMoveList:addTrigger(trigger)
self.trigger=trigger
end

function worldTripMoveList:executeTrigger(oldV,newV,pass)
if self.trigger then
self.trigger(oldV,newV,pass)
end
end

function worldTripMoveList:start(fast,sPos)
local start=sPos or 1
local o=self.progress
local temp=fast
for i=start,#self.list do
local tripMove=self.list[i]
local duration=tripMove:getDuration()
if duration<0 or temp<duration then
self:setProgress(i,temp)
tripMove:start(temp)
return
else
temp=temp-duration
end
end
self:setProgress(#self.list+1,temp)
end

function worldTripMoveList:quit()
local tripMove=self.list[self.progress]
if tripMove then
tripMove:cancel()
end
end

function worldTripMoveList:onStep(pass)
self:quit()
self:start(pass,self.progress+1)
end

function worldTripMoveList:setProgress(value,pass)
local old=self.progress
self.progress=value
self:executeTrigger(old,self.progress,pass)
end

function worldTripMoveList:getMove(index)
return self.list[index]
end