worldTripMoveCycle=simple_class(worldTripMoveList)
worldTripMoveCycle.name="worldTripMoveCycle"

function worldTripMoveCycle:start(fast,sPos)
local index=sPos or 1
local o=self.progress
local temp=math.max(fast,0)
while(temp>0)do
local tripMove=self.list[index]
local duration=tripMove:getDuration()
if duration<0 or temp<duration then
self.progress=index
tripMove:start(temp)
self.executeTrigger(o,self.progress)
self.executeTrigger(-1,self.progress)
self.executeTrigger(o,-1)
return
else
temp=temp-duration
index=index+1
index=index<=#self.list and index or(index-#self.list)
end
end

self.progress=index
tripMove:start(temp)
self.executeTrigger(o,self.progress)
self.executeTrigger(-1,self.progress)
self.executeTrigger(o,-1)
end