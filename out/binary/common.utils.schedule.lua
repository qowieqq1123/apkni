schedule={}
tremove=table.remove

function schedule:start(func)
local scheduleList=self.scheduleList
scheduleList[#scheduleList+1]=func

if self.scheduleTimer~=nil then
return
end

self.scheduleTimer=timer.new()
self.scheduleTimer:start(0,function()
for i=1,self.jobCountPreTick,1 do
local job=self.scheduleList[1]
if job~=nil then
tremove(self.scheduleList,1)
job()
else
if self.scheduleTimer then
self.scheduleTimer:cancel()
self.scheduleTimer=nil
end
break
end
end
end)
end

function schedule:join()
if self.preJoinCallback then
self.preJoinCallback()
self.preJoinCallback=nil
end

local scheduleList=self.scheduleList
for _,job in ipairs(scheduleList)do
job()
end

self.scheduleList={}
if self.postJoinCallback then
self.postJoinCallback()
self.postJoinCallback=nil
end
end
local meta={__index=schedule}
function schedule.new()
local o={scheduleList={},jobCountPreTick=1}
setmetatable(o,meta)
return o
end
