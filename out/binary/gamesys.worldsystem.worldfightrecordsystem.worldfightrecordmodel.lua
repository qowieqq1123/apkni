






local _MODULENAME="worldFightRecordModel"




def_table(_MODULENAME)
worldFightRecordModel.name=_MODULENAME


worldFightRecordModel.data={}
worldFightRecordModel.saveKey="WorldFightRecord"
worldFightRecordModel.battle=nil
worldFightRecordModel.prepareTimer=nil
worldFightRecordModel.maxCount=0

function worldFightRecordModel:onAppStart()
self.maxCount=cfgHelper.get3(cfg_worldglobalconfig_get,"fightRecordMaxCount","value",1)
end


function worldFightRecordModel:onEnterState()
worldFightRecordModel:loadRecord()









end


function worldFightRecordModel:onLeaveState()

self:stopPrepareTimer()
self.data={}
end


function worldFightRecordModel:onServerDataInitFinish()

end

function worldFightRecordModel:onProtocolReq()
self:checkDelay()
end


function worldFightRecordModel:getAllRecord()
return self.data
end

function worldFightRecordModel:getAllAvailableRecord()
local list={}
for i,v in ipairs(self.data)do
if v[7]<=0 then
table.insert(list,v)
end
end
return list
end

function worldFightRecordModel:getRecord(index)
return self.data[index]
end

function worldFightRecordModel:loadRecord()
self.data=userActorSetting.get(self.saveKey,{})
end

function worldFightRecordModel:addRecord(result,rewards,content,reportId,timeStamp,delay)
local old=#self.data

local prize={}
for i,v in ipairs(rewards)do
table.insert(prize,{itemid=v.itemid,itemcount=v.num})
end
table.insert(self.data,{result,prize,content,reportId,tostring(timeStamp),true,delay})
table.sort(self.data,function(a,b)
return a[5]>b[5]
end)
if delay>0 then
self:startPrepareTimer()
else
if worldFightRecordModel:getRecordCount()>self.maxCount then
table.remove(self.data)
end
self:saveRecord()
notifySystem:postNotify(notifyConfig.onWorldFightRecordChanged)
end
end

function worldFightRecordModel:clearRecord()
self.data={}
self:saveRecord()
notifySystem:postNotify(notifyConfig.onWorldFightRecordChanged)
end

function worldFightRecordModel:clearAvailableRecord()
self.data={}
for i,v in ipairs(self.data)do
if not v[6]or v[7]>0 then
table.insert(self.data,v)
end
end
self:saveRecord()
notifySystem:postNotify(notifyConfig.onWorldFightRecordChanged)
end

function worldFightRecordModel:saveRecord()
userActorSetting.set(self.saveKey,self.data)
userActorSetting.flush()
end

function worldFightRecordModel:getRecordCount()
return#self.data
end

function worldFightRecordModel:getAvailableRecordCount()
local count=0
for i,v in ipairs(self.data)do
if v[7]<=0 then
count=count+1
end
end
return count
end

function worldFightRecordModel:getNewRecordCount()
local count=0
for i,v in ipairs(self.data)do
if v[7]<=0 and v[6]then
count=count+1
end
end
return count
end

function worldFightRecordModel:clearNew()
for i,v in ipairs(self.data)do
if v[7]<=0 then
v[6]=false
end
end
notifySystem:postNotify(notifyConfig.onWorldFightRecordChanged)
end

function worldFightRecordModel:refreshDelay()
local check=false
local nowTime=timeHelper.getServerShortTime()

for i,v in ipairs(self.data)do
v[7]=tonumber(tostring(v[5]))-nowTime
check=check or(v[7]>0)
end
return check
end

function worldFightRecordModel:checkDelay()
if self:refreshDelay()then
self:startPrepareTimer()
end
end

function worldFightRecordModel:startPrepareTimer()
if not self.prepareTimer then

self.prepareTimer=timer.new()
self.prepareTimer:start(1,function()self:prepareTimerUpdate()end,-1)
end
end

function worldFightRecordModel:stopPrepareTimer()
if self.prepareTimer then

self.prepareTimer:cancel()
self.prepareTimer=nil
end
self:saveRecord()
end

function worldFightRecordModel:prepareTimerUpdate()
local check=false
local post=false
for i,v in ipairs(self.data)do

local oldV=v[7]
local newV=v[7]-1
if not post and oldV>0 and newV<=0 then
post=true
end
v[7]=math.max(0,newV)
check=check or(newV>0)

end
if post then
if worldFightRecordModel:getRecordCount()>self.maxCount then
table.remove(self.data)
end
self:saveRecord()
notifySystem:postNotify(notifyConfig.onWorldFightRecordChanged)
end
if not check then
self:stopPrepareTimer()
end
end


