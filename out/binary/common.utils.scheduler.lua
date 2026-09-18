






local _timerHelper=CS.TimerHelper

local _StartTimer=_timerHelper.StartTimer
local _StopTimer=_timerHelper.StopTimer

Scheduler={};

local delayDict={};
local delayList={};
local delayPopPos=0;
local delayPushPos=0;
local delayTimerID;

local function _delayCall()
if delayPopPos<delayPushPos then

delayPopPos=delayPopPos+1;
local func=delayList[delayPopPos];
delayList[delayPopPos]=nil;
delayDict[func]=nil;
local result,error=pcall(func);
if not result then
logErr(error);
end
else

delayPushPos=0;
delayPopPos=0;
if delayTimerID then
_StopTimer(delayTimerID);
delayTimerID=nil;
end
end
end



function Scheduler.delayCall(func,checkExist)
if checkExist and delayDict[func]then
return;
end
delayDict[func]=true;

delayPushPos=delayPushPos+1;
delayList[delayPushPos]=func;

if not delayTimerID then
delayTimerID=_StartTimer(1,0.05,-1,false,_delayCall);
end
end


local running={}
local function delayCallback(id)
local func=running[id];
running[id]=nil;
func();
end








function Scheduler.AddDelayCallback(func,delay,ignore)
ignore=(ignore==nil)and true or ignore
local id=_StartTimer(1,delay,1,ignore,delayCallback)
running[id]=func;
return id
end

function Scheduler.StopDelay(id)
if running[id]then
_StopTimer(id)
running[id]=nil
end
end

function Scheduler.StopAllDelay()
for id,v in pairs(running)do
_StopTimer(id)
running[id]=nil
end

if delayTimerID then
_StopTimer(delayTimerID);
delayTimerID=nil;
end
delayDict={};
delayList={};
delayPushPos=0;
delayPopPos=0;
end
