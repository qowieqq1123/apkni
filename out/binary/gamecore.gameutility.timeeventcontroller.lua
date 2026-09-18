







timeEventController={}




local usepcall=true
local isInit=false

local quickTimer=nil
local normalTimerList=nil
local normalTimerLookup=nil
local slowTimer=nil
local minuteTimer=nil
local _timingTimer=nil

local conditionTimerList=nil

local quickTimerDelay=0.23
local normalTimerDelay=1.0
local slowTimerDalay=1.3
local mimuteTimerDalay=60.0

local quickFuncList=nil
local slowFuncList=nil
local minuteFuncList=nil
local normalTimerCBList=nil
local _timingTimerFuncList=nil
local _timingTimerCache={}

local normalTimerNum=5
local normalTimerReq=nil
local normalTimerReqLookup=nil

function myxpcall(func,...)
if usepcall then
xpcall(function(...)
func(...)
end,
function(err)
logErr(err)

end,...)






else
func(...)
end
end



function timeEventController.delayDo(t,func,checkOutLine)
local tempTimer=timer.new()
local check_ol=checkOutLine==nil or checkOutLine==true
local f=function()
local pass=true
if check_ol and not playerModel:checkInit()then
pass=false
end
if pass then func()end
tempTimer:cancel()
end
tempTimer:start(t,f,1)
return tempTimer
end

function timeEventController.init(isReconnet)

if isReconnet then return end





















isInit=true
quickFuncList={}
slowFuncList={}
minuteFuncList={}
_timingTimerFuncList={}
_timingTimerCache={}
normalTimerCBList={}
for i=1,normalTimerNum do
normalTimerCBList[i]={}
end
end

function timeEventController.initNormalTimer(tIndex)
if normalTimerList==nil then
normalTimerList={}
normalTimerLookup={}
end
if#normalTimerList<=0 then
local t=timer.new()
local ff=function(...)
timeEventController.normalTimerCB(tIndex,...)
end
t:start(normalTimerDelay,ff,-1)
table.insert(normalTimerList,{tIndex,t})
normalTimerLookup[tIndex]=t
local errorf=function(...)
timeEventController.normalTimerErrorCB(tIndex,...)
end
t.errorcall=errorf
else
local found=nil
for i,v in ipairs(normalTimerList)do
if v[1]==tIndex then
found=true
break
end
end
if found==nil then
if normalTimerReq==nil then
normalTimerReq={}
end
normalTimerReq[tIndex]=tIndex
end
end
end

function timeEventController.initQuickTimer()
if quickTimer==nil then
quickTimer=timer.new()
quickTimer:start(quickTimerDelay,timeEventController.quickTimerCB,-1)
quickTimer.errorcall=timeEventController.quickTimerErrorCB
end
end

function timeEventController.initSlowTimer()
if slowTimer==nil then
slowTimer=timer.new()
slowTimer:start(slowTimerDalay,timeEventController.slowTimerCB,-1)
slowTimer.errorcall=timeEventController.slowTimerErrorCB
end
end

function timeEventController.initMinuteTimer()
if minuteTimer==nil then
minuteTimer=timer.new()
minuteTimer:start(mimuteTimerDalay,timeEventController.minuteTimerCB,-1)
minuteTimer.errorcall=timeEventController.minuteTimerErrorCB
end
end

function timeEventController.initTimingTimer()
if _timingTimer==nil then
_timingTimer=timer.new()
_timingTimer:start(0.49,timeEventController.timingTimerCB,-1)
_timingTimer.errorcall=timeEventController.timingTimerErrorCB
end
end

function timeEventController.clearQuickTimer()
if quickTimer~=nil then
quickTimer:cancel()
quickTimer=nil
end
end

function timeEventController.clearNormalTimer()
if normalTimerList~=nil then
for i,v in ipairs(normalTimerList)do
v[2]:cancel()
end
normalTimerList=nil
normalTimerLookup=nil
end
end

function timeEventController.clearSlowTimer()
if slowTimer~=nil then
slowTimer:cancel()
slowTimer=nil
end
end

function timeEventController.clearMinuteTimer()
if minuteTimer~=nil then
minuteTimer:cancel()
minuteTimer=nil
end
end

function timeEventController.clearTimingTimer()
if _timingTimer~=nil then
_timingTimer:cancel()
_timingTimer=nil
end
end

function timeEventController.clear(isReconnet)
timeEventController.clearConditonTimer()

if isReconnet then return end

timeEventController.clearQuickTimer()
timeEventController.clearNormalTimer()
timeEventController.clearSlowTimer()
timeEventController.clearMinuteTimer()
timeEventController.clearTimingTimer()
quickFuncList=nil
normalTimerCBList=nil
slowFuncList=nil
minuteFuncList=nil
_timingTimerFuncList=nil
_timingTimerCache=nil
normalTimerReq=nil
if normalTimerReqLookup~=nil then
for k,d_t in pairs(normalTimerReqLookup)do
if d_t~=nil then
d_t:cancel()
end
end
normalTimerReqLookup=nil
end

isInit=false
end

function timeEventController:checkInit(isWarming)
local flag=isInit==true
if not flag then



end
return flag
end

function timeEventController.quickTimerCB(...)
if quickFuncList then
local timeObj=quickTimer
for k,v in pairs(quickFuncList)do
if v.onQuickUpdate~=nil then
timeObj.errorcall_rocord=k









v:onQuickUpdate(quickTimerDelay)




end
end
timeObj.errorcall_rocord=nil

if next(quickFuncList)==nil then
timeEventController.clearQuickTimer()
end
end
end

function timeEventController.quickTimerErrorCB(timeObj)
if timeObj==nil then return end
local errorcall_rocord=timeObj.errorcall_rocord
if errorcall_rocord==nil then return end
timeEventController.removeQuickTimerHandler(errorcall_rocord)
logErr(FMT.fmt('系统{0}出错，计时器{1}已被杀死！！！',errorcall_rocord,'onQuickUpdate'))
end

function timeEventController.normalTimerCB(tIndex,...)

if normalTimerCBList then
if normalTimerCBList[tIndex]then
local timeObj=normalTimerLookup[tIndex]
for k,v in pairs(normalTimerCBList[tIndex])do
local handle=v[1]
local checkOutLine=v[2]
local check=socketManager:isConneting()and initProControl.isDone()
if checkOutLine then
check=true
end
if handle.onNormalUpdate~=nil and check then
timeObj.errorcall_rocord=k









handle:onNormalUpdate(normalTimerDelay)




end
end
timeObj.errorcall_rocord=nil




end
end

if normalTimerReq then
local firstTimer=normalTimerList[1]
if firstTimer then
if tIndex==firstTimer[1]then
local c=#normalTimerList
local n=0
if normalTimerReqLookup~=nil then
for k,v in pairs(normalTimerReqLookup)do
if v~=nil then
n=n+1
end
end
else
normalTimerReqLookup={}
end
local begin=0.2*(c+n)
for k,v in pairsBySortKey(normalTimerReq)do
local idx=v
if normalTimerReqLookup[idx]==nil then
local f=function()
normalTimerReqLookup[idx]=nil
local t=timer.new()
local ff=function(...)
timeEventController.normalTimerCB(idx,...)
end
t:start(normalTimerDelay,ff,-1)
table.insert(normalTimerList,{idx,t})
normalTimerLookup[idx]=t
local errorf=function(...)
timeEventController.normalTimerErrorCB(idx,...)
end
t.errorcall=errorf
end
local clipTimer=timer.new()
clipTimer:start(begin,f,1)
normalTimerReqLookup[idx]=clipTimer

begin=begin+0.2
end
end
normalTimerReq=nil
end
end
end
end

function timeEventController.normalTimerErrorCB(tIndex,timeObj)
if timeObj==nil then return end
local errorcall_rocord=timeObj.errorcall_rocord
if errorcall_rocord==nil then return end
timeEventController.removeNormalTimerHandler(tIndex,errorcall_rocord)
logErr(FMT.fmt('系统{0}出错，计时器{1}已被杀死！！！',errorcall_rocord,'onNormalUpdate'))
end

function timeEventController.slowTimerCB(...)
if slowFuncList then
local timeObj=slowTimer
for k,v in pairs(slowFuncList)do
local handle=v[1]
local checkOutLine=v[2]
local check=socketManager:isConneting()and initProControl.isDone()
if checkOutLine then
check=true
end
if handle.onSlowUpdate~=nil and check then
timeObj.errorcall_rocord=k









handle:onSlowUpdate(slowTimerDalay)




end
end
timeObj.errorcall_rocord=nil

if next(slowFuncList)==nil then
timeEventController.clearSlowTimer()
end
end
end

function timeEventController.slowTimerErrorCB(timeObj)
if timeObj==nil then return end
local errorcall_rocord=timeObj.errorcall_rocord
if errorcall_rocord==nil then return end
timeEventController.removeSlowTimerHandler(errorcall_rocord)
logErr(FMT.fmt('系统{0}出错，计时器{1}已被杀死！！！',errorcall_rocord,'onSlowUpdate'))
end

function timeEventController.minuteTimerCB(...)
if minuteFuncList then
local timeObj=minuteTimer
for k,v in pairs(minuteFuncList)do
local handle=v[1]
local checkOutLine=v[2]
local check=socketManager:isConneting()and initProControl.isDone()
if checkOutLine then
check=true
end
if handle.onMinuteUpdate~=nil and check then
timeObj.errorcall_rocord=k









handle:onMinuteUpdate(mimuteTimerDalay)




end
end
timeObj.errorcall_rocord=nil

if next(minuteFuncList)==nil then
timeEventController.clearMinuteTimer()
end
end
end

function timeEventController.minuteTimerErrorCB(timeObj)
if timeObj==nil then return end
local errorcall_rocord=timeObj.errorcall_rocord
if errorcall_rocord==nil then return end
timeEventController.removeMinuteTimerHandler(errorcall_rocord)
logErr(FMT.fmt('系统{0}出错，计时器{1}已被杀死！！！',errorcall_rocord,'onMinuteUpdate'))
end


function timeEventController.timingTimerCB(...)
if _timingTimerFuncList then
local timeObj=_timingTimer
local curStamp=timeHelper.getServerShortTime()
for func,v in pairs(_timingTimerFuncList)do
local stamp=v[1]
local cnt=v[2]
if curStamp>=stamp then
timeObj.error_func=func
func(cnt)
cnt=cnt-1
v[2]=cnt
if cnt<=0 then
_timingTimerCache[func]=true
end
end
end
timeObj.error_func=nil

if next(_timingTimerCache)then
for func,v in pairs(_timingTimerCache)do
_timingTimerFuncList[func]=nil
end
table.clear(_timingTimerCache)
end

if next(_timingTimerFuncList)==nil then
timeEventController.clearTimingTimer()
end
end
end

function timeEventController.timingTimerErrorCB(timeObj)
if timeObj==nil then return end
local error_func=timeObj.error_func
if error_func==nil then return end
timeEventController.removeTimingHandler(error_func)
logErr('计时器出错！！！')
end





















function timeEventController.addQuickTimerHandler(sysName,sysHandle)
if not timeEventController:checkInit(true)then
return
end




if quickFuncList[sysName]==nil then
timeEventController.initQuickTimer()
quickFuncList[sysName]=sysHandle
end
end

function timeEventController.removeQuickTimerHandler(sysName)
if quickFuncList==nil then
return
end
quickFuncList[sysName]=nil
end


function timeEventController.addNormalTimerHandler(tIndex,sysName,sysHandle,checkOutLine)
if not timeEventController:checkInit(true)then
return
end



assert(tIndex>=1 and tIndex<=normalTimerNum)

if normalTimerCBList[tIndex][sysName]==nil then
timeEventController.initNormalTimer(tIndex)
if checkOutLine==nil then checkOutLine=false end
normalTimerCBList[tIndex][sysName]={sysHandle,checkOutLine}
end
end

function timeEventController.removeNormalTimerHandler(tIndex,sysName)
if normalTimerCBList==nil then
return
end
assert(tIndex>=1 and tIndex<=normalTimerNum)
normalTimerCBList[tIndex][sysName]=nil
end


function timeEventController.addSlowTimerHandler(sysName,sysHandle,checkOutLine)
if not timeEventController:checkInit(true)then
return
end




if slowFuncList[sysName]==nil then
timeEventController.initSlowTimer()
if checkOutLine==nil then checkOutLine=false end
slowFuncList[sysName]={sysHandle,checkOutLine}
end
end

function timeEventController.removeSlowTimerHandler(sysName)
if slowFuncList==nil then
return
end
slowFuncList[sysName]=nil
end


function timeEventController.addMinuteTimerHandler(sysName,sysHandle,checkOutLine)
if not timeEventController:checkInit(true)then
return
end




if minuteFuncList[sysName]==nil then
timeEventController.initMinuteTimer()
if checkOutLine==nil then checkOutLine=false end
minuteFuncList[sysName]={sysHandle,checkOutLine}
end
end

function timeEventController.removeMinuteTimerHandler(sysName)
if minuteFuncList==nil then
return
end
minuteFuncList[sysName]=nil
end


function timeEventController.addTimingHandler(stamp,count,func)
if count<=0 then
logErr('定时器回调次数不能<=0')
return
end
if not timeEventController:checkInit()then return end

if _timingTimerFuncList[func]==nil then
_timingTimerFuncList[func]={stamp,count,func}
timeEventController.initTimingTimer()
end
end


function timeEventController.removeTimingHandler(func)
if _timingTimerFuncList==nil then return end
_timingTimerFuncList[func]=nil
end
















function timeEventController.createConditionTimer(name,funcDataList,tick,timeout)
if not timeEventController:checkInit(true)then
return
end
if conditionTimerList==nil then
conditionTimerList={}
end
assert(conditionTimerList[name]==nil,FMT.fmt('condition timer:已有条件计时器{0}正在运行，是否重名或者重复添加？',name))
tick=tick or 0.2
timeout=timeout or 5.0
local t=timer.new()
local f=function()
timeEventController.doConditonTimer(name)
end
t:start(tick,f,-1)
local d={}
d.name=name
d.t=t
d.tick=tick
d.funcDataList=funcDataList
d.tCounter=0
d.timeout=timeout
d.clear=function(self_)
if self_.t then
self_.t:cancel()
self_.t=nil



end
end
conditionTimerList[name]=d

end



function timeEventController.breakConditonTimer(name,idx)
if not timeEventController:checkInit(true)then
return
end
local d=conditionTimerList[name]
if d==nil then return end

if idx==nil then
d:clear()
conditionTimerList[name]=nil
else
local dd=d.funcDataList[idx]
if dd==nil then return end
dd.flag=true
end
end

function timeEventController.doConditonTimer(name)
local d=conditionTimerList[name]
assert(d~=nil,FMT.fmt('condition timer:{0} 意外终结',name))

local allDone=true
d.tCounter=d.tCounter+d.tick
for i,v in ipairs(d.funcDataList)do
if v.flag==nil and v.cond()then
v.func()
v.flag=true

elseif v.flag==nil then
allDone=false
end
end
if allDone then
d:clear()
conditionTimerList[name]=nil
else
if d.tCounter>=d.timeout then
d:clear()
conditionTimerList[name]=nil
end
end
end

function timeEventController.clearConditonTimer()
if conditionTimerList~=nil then
for k,v in pairs(conditionTimerList)do
v:clear()
end
conditionTimerList=nil
end



end


function timeEventController.newTimerGroup(tick,cnt)
local o={}
o.tick=tick
o.cnt=cnt

o.initTimer=function(self)

end
return o
end
