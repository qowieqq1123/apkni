






local _timerHelper=CS.TimerHelper

local _StartTimer=_timerHelper.StartTimer
local _StopTimer=_timerHelper.StopTimer
local _PauseTimer=_timerHelper.PauseTimer
local _GetRunningID=_timerHelper.GetRunningID
local _StopAllTimer=_timerHelper.StopAllTimer
local _IsDead=_timerHelper.IsDead
local _IsPause=_timerHelper.IsPause















































































































timer=Timer
timer.running={}

timer.new=function()
return Timer.New(nil,math.huge,-1,false)
end

function timer:start(delay,callback,iterations)
iterations=iterations or-1
self:Reset(callback,delay,iterations,true)
self:Start()
end

function timer:cancel()
self:Stop()
end

function timer:isDead()
return false==self.running
end

function timer.cancel_all()


end

function timer:pause()
self:Pause()
end

function timer:continue()
self:Continue()
end

function timer:isPause()
return true==self._pause
end

function timer.print_running()
end

function workQueue(jobs)

local t=timer.new()
local function _do(i,t,c)
local f=jobs[c]
f(i,t,c)
end
t:start(0,_do,#jobs,1)
return t;
end


function testtimer()

local function fd2(i,t,c)logErr('late timer:',i,t,c)end
local t2=timer.new()
t2:start(1,fd2,3,2)

local function fd1(i,t,c)logErr('update timer:',i,t,c)end
local t1=timer.new()
t1:start(1,fd1,3,1)

local function fd0(i,t,c)logErr('fixed timer:',i,t,c)end
local t0=timer.new()
t0:start(1,fd0,3,0)


local function runningcb(i,t,c)logErr('cb1:',i,t,c);timer.print_running()end
local cb1=timer.new()
cb1:start(2,runningcb)


local function byebye_cb1()cb1:cancel();logErr('bye bye timer0');timer.print_running()end
local cb2=timer.new()
cb2:start(10,byebye_cb1,1)

local function dojob(i,t,c)
logErr('>>>>>>>>>>>>>>>> dojob',i,t,c)
end
local jobs={dojob,dojob,dojob,dojob,dojob}
workQueue(jobs)

end
