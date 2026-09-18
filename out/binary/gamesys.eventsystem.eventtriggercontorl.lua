eventTriggerContorl=gameState.addListener({})

local _tickTimer
local _cache={}
local _lookup={}
local _isLock=false
local _temp={}
local _lockLookup={}


















function eventTriggerContorl:onAppStart()

end

function eventTriggerContorl:onEnterState()
_cache={}
_lookup={}
_isLock=false
_lockLookup={}
_tickTimer=timer.new()
_tickTimer:start(0.01,function()
self:update()
end)
end

function eventTriggerContorl:onLeaveState()
if _tickTimer then
_tickTimer:cancel()
end
_isLock=false
_tickTimer=nil
_cache={}
_lookup={}
_lockLookup={}
end


function eventTriggerContorl:onProtocolReq()
eventLocalTriggerModel.readLocalData()
eventTriggerContorl.init()
end


function eventTriggerContorl.init()
eventTriggerContorl:sort()
local len=#_cache
if len>0 then
local list={}
while true do
if#_cache>0 then
local triggerArray=_cache[1]
local guid=triggerArray[7]
if timeHelper.isNotLaterShort(triggerArray[6])and
not eventTriggerContorl.isLockEvent(guid)then
list[#list+1]=triggerArray
_lookup[guid]=nil
table.remove(_cache,1)

else break end
else break end
end
if#list>0 then
eventProtocolControl.reqTriggerEventList(list)
else
eventControl.setRecvAllCustomInitData()
end
else
eventControl.setRecvAllCustomInitData()
end
end

function eventTriggerContorl:update()
if not initProControl.isDone()then return end
if _isLock then return end
if not eventControl.isRecvInitCustomData()then return end
eventTriggerContorl.clearList()
while#_cache>0 do
local triggerArray=_cache[1]
local guid=triggerArray[7]
if timeHelper.isNotLaterShort(triggerArray[6])and
not eventTriggerContorl.isLockEvent(guid)then
eventTriggerContorl.insertList(triggerArray)
_lookup[guid]=nil
table.remove(_cache,1)
else break end
end
eventTriggerContorl.startList()
end



function eventTriggerContorl:enQueue(triggerArray,sortTag)
local guid=triggerArray[7]
if triggerArray[3]==nil then
loggerUtil.logErrFMT('参数为空')
return
end
if _lookup[guid]then
loggerUtil.logErrFMT('触发事件id{0}重复!',guid)
return
end
_lookup[guid]=triggerArray
_cache[#_cache+1]=triggerArray
if sortTag~=false then
eventTriggerContorl:sort()
end
end

function eventTriggerContorl:enQueueList(triggerInfoList)
for i,v in ipairs(triggerInfoList)do
eventTriggerContorl:enQueue(v,false)
end
eventTriggerContorl:sort()
end

function eventTriggerContorl:sort()
if#_cache>1 then
_isLock=true

local sortTag={}
for i,v in ipairs(_cache)do
local guid=v[7]
sortTag[guid]=(_lockLookup[guid]and 86400000 or 0)+v[6]
end

table.sort(_cache,function(a,b)
return sortTag[a[7]]<sortTag[b[7]]
end)
_isLock=false
end
end

function eventTriggerContorl.clearList()
_temp={}
end

function eventTriggerContorl.insertList(triggerArray)
if triggerArray then
_temp[#_temp+1]=triggerArray
end
end

function eventTriggerContorl.startList(triggerArray)
local len=#_temp
if len==0 then
return
elseif len==1 then
eventProtocolControl.reqTriggerEvent(_temp[1])
elseif len>1 then
eventProtocolControl.reqTriggerEventList(_temp)
end
_temp={}
end


function eventTriggerContorl.onTriggerFail(triggerInfo)
local guid=triggerInfo[7]
if guid==nil then return end
_lookup[guid]=nil
if eventLocalTriggerModel.deleteTableData(guid)then
eventControl.freshLocalFile()
end
end


function eventTriggerContorl.onTriggerListFail(triggerList)
if triggerList==nil or#triggerList==0 then return end
local ret=false
for i,v in ipairs(triggerList)do
local guid=v[7]
ret=ret or eventLocalTriggerModel.deleteTableData(guid)~=nil
end
if ret then
eventControl.freshLocalFile()
end
end

function eventTriggerContorl.setEventLock(guid)
_lockLookup[tostring(guid)]=true
end

function eventTriggerContorl.isLockEvent(guid)
return _lockLookup[tostring(guid)]==true
end







function eventTriggerContorl.cancelTriggerByFunction(func)
local triggers=eventTriggerContorl.findTriggerInfoList(func)
local len=#triggers

eventTriggerContorl.cancelTriggerList(triggers)
end


function eventTriggerContorl.cancelTriggerList(triggers)
local lookup={}
for i,v in ipairs(triggers)do
local guid=v[7]
eventLocalTriggerModel.deleteTableData(guid)
lookup[guid]=true
_lookup[guid]=nil
end
local len=#_cache
if len>0 then
for i=len,1,-1 do
if lookup[_cache[i][7]]==true then
table.remove(_cache,i)
end
end
end
eventControl.freshLocalFile()
end

function eventTriggerContorl.lockEventByFunction(func,flag)
local triggers=eventTriggerContorl.findTriggerInfoList(func)
local len=#triggers

eventTriggerContorl.lockTriggerList(triggers,flag)
return triggers
end


function eventTriggerContorl.lockTriggerList(triggers,flag)
local change=false
for i,v in ipairs(triggers)do
local guid=tostring(v[7])
local last=_lockLookup[guid]or false
if last~=flag then
_lockLookup[guid]=flag
change=true

end
end
if change then
eventTriggerContorl:sort()
end
end

function eventTriggerContorl.findTriggerInfoList(func)
local temp={}
for _,v in ipairs(_cache)do
if func(v[1],v[2],v[5])then
temp[#temp+1]=v
end
end
return temp
end


function eventTriggerContorl.matchParamList(paramList1,paramList2)
if paramList1==nil and paramList2==nil then return true end
for i,v in ipairs(paramList1)do
if tostring(paramList2[i])~=tostring(v)then
return false
end
end
return true
end
