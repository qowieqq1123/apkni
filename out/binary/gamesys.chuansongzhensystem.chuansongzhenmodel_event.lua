

function chuanSongZhenModel:recordEvent(content,eventId,args,timeStamp)

if#self.record>=20 then
table.remove(self.record,1)
end
local data={content=content,time=timeStamp,isNew=true}
table.insert(self.record,data)

self:saveEventData()
end

function chuanSongZhenModel:getEventData()
return self.record
end

function chuanSongZhenModel:printEventData()

end

function chuanSongZhenModel:haveNewEventData()
for i,v in ipairs(self.record)do
if v.isNew then
return true
end
end
return false
end

function chuanSongZhenModel:readEventData()
local check=false
for i,v in ipairs(self.record)do
if v.isNew then
v.isNew=false
check=true
end
end
if check then
self:saveEventData()
end
end

function chuanSongZhenModel:loadEventData()
local datas=userActorSetting.get('youliEvent',{})
self.record=datas
end

function chuanSongZhenModel:saveEventData()
userActorSetting.set('youliEvent',self.record)
userActorSetting.flush()
end


function chuanSongZhenModel:getTimeData(world)
local time=self.time[world]
return tonumber(time)
end

function chuanSongZhenModel:setTimeData(world,timeStamp)
self.time[world]=timeStamp
self:saveTimeData()
end

function chuanSongZhenModel:saveTimeData()
userActorSetting.set('youliTime',self.time)
userActorSetting.flush()
end

function chuanSongZhenModel:loadTimeData()
local datas=userActorSetting.get('youliTime',{})
self.time=datas
end

function chuanSongZhenModel:addTimeData(world,timeStamp)
local stamp=self:getTimeData(world)
if stamp then
if stamp>timeStamp then
self:setTimeData(world,timeStamp)
end
else
self:setTimeData(world,timeStamp)
end
end

function chuanSongZhenModel:delTimeData(world)
local disciples=self:getDisciples(world)
if#disciples<=0 then
self:setTimeData(world,nil)
end
end

function chuanSongZhenModel:resetTimeData(world)
local disciples=self:getDisciples(world)
if#disciples>0 then
local stamp=timeHelper.getServerShortTime()
self:setTimeData(world,stamp)
else
self:setTimeData(world,nil)
end
end

function chuanSongZhenModel:getTimeDuration(world)
local time=self:getTimeData(world)

if time then
local now=timeHelper.getServerShortTime()
local dead=self:getWorldDead(world)
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
local temp=dead>0 and(dead-time)or(now-time)
return Mathf.Clamp(temp,0,limit)
end
end
