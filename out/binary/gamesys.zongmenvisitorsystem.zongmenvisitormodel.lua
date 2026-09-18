






local _MODULENAME="zongmenVisitorModel"


local _share_key="zmVisitor_shareRecord"

def_table(_MODULENAME)

zongmenVisitorModel.data={}
zongmenVisitorModel.num=0
zongmenVisitorModel.entity={}
zongmenVisitorModel.check={}
zongmenVisitorModel.record=nil

function zongmenVisitorModel:onAppStart()

end


function zongmenVisitorModel:onEnterState(isReconnect)
if not isReconnect then
self:loadRecord()
end
end


function zongmenVisitorModel:onLeaveState(isReconnect)

if not isReconnect then
self.data={}
self.num=0
self.entity={}
self.check={}
self.record=nil
end
end




function zongmenVisitorModel:setVisitor(playId,visitorId,rewardList)
local list={}
if rewardList then
for i,v in ipairs(rewardList)do
list[v.param_1]=v.param_2
end
end
local data={
playId=playId,
id=visitorId,
list=list,
}
self.data[tostring(playId)]=data
end

function zongmenVisitorModel:getVisitor(playId)
return self.data[tostring(playId)]
end

function zongmenVisitorModel:setNum(num)
self.num=num
end

function zongmenVisitorModel:getNum()
return self.num
end

function zongmenVisitorModel:checkNum()
local current=self:getNum()
local max=cfgHelper.get2(cfg_zongmenfangkebaseconfig_get,1,"rewardMax")
return current<max
end

function zongmenVisitorModel:awardVisitor(playId,rewardIdx)
local data=self:getVisitor(playId)
if data then
data.list[rewardIdx]=playerModel:getActorName()
end
end

function zongmenVisitorModel:checkAwarded(playId,actorName)
local data=self:getVisitor(playId)
if data then
for i,v in pairs(data.list)do
if v==actorName then
return true
end
end
end
return false
end

function zongmenVisitorModel:clearVisitor()
self.data={}
end

function zongmenVisitorModel:setEntity(mapType,entGuid,entBt,entHud,visitor)
self.entity[mapType]={
entGuid=entGuid,
entBt=entBt,
entHud=entHud,
visitor=visitor,
}
end

function zongmenVisitorModel:clearEntity(mapType)
self.entity[mapType]=nil
end

function zongmenVisitorModel:getEntity(mapType)
return self.entity[mapType]
end

function zongmenVisitorModel:getNextMonday5oClock()
local week=timeHelper.getWeakDateEx()
local longStamp=timeHelper.getWeakDateStamp(1,1,5,0,0)
if week==1 then
local pass=timeHelper.getServerTodayPass()
if pass<5*3600 then
longStamp=timeHelper.getTodayZeroStamp()+5*3600
end
end
return timeHelper.convertShortStamp(longStamp)
end

function zongmenVisitorModel:loadRecord()
self.record=userActorSetting.get(_share_key,nil)
if not self:checkRecord()then
self:clearRecord()
end
end

function zongmenVisitorModel:getRecord()
if self.record then
return self.record.list
end
end

function zongmenVisitorModel:setRecord(playerId,ban)
if self.record==nil then
self.record={}
self.record.stamp=self:getNextMonday5oClock()
self.record.list={}
self.record.ban={}
end
if ban then
self.record.ban=self.record.ban or{}
table.insert(self.record.ban,tostring(playerId))
else
table.insert(self.record.list,tostring(playerId))
end
userActorSetting.set(_share_key,self.record)
userActorSetting.flush()
end

function zongmenVisitorModel:clearRecord()
self.record=nil
userActorSetting.remove(_share_key)
userActorSetting.flush()
end

function zongmenVisitorModel:checkRecord()

if self.record then
local stamp=timeHelper.getServerShortTime()
if stamp>=self.record.stamp then
return false
end
end
return true
end

function zongmenVisitorModel:existRecord(playerId,ban)
if self.record then
if ban then
self.record.ban=self.record.ban or{}
return table.containsValue(self.record.ban,tostring(playerId))
else
return table.containsValue(self.record.list,tostring(playerId))
end
end
return false
end

function zongmenVisitorModel:addCheck(actorId,formType,endtime)
local key=tostring(actorId)
self.check[key]={
actorId=actorId,formType=formType,endtime=endtime
}
end

function zongmenVisitorModel:getCheck(actorId)
local key=tostring(actorId)
return self.check[key]
end

function zongmenVisitorModel:clearCheck(actorId)
local key=tostring(actorId)
self.check[key]=nil
end
