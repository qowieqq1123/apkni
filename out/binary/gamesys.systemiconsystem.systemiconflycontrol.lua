systemIconFlyControl=gameState.addListener({})

local _flyData={}
local _init=false
local _callTable={}
local _guid=0
local _btArray={}
local _flyQueue={}
local _flyQueueLookup={}
local _flyTimer
local _fadeList={}
local _nextDelayCfg=0
local _nextDelay=0
local _isFlyStart=false
local _isFly=false
local _delayShowTimer=nil
function systemIconFlyControl:onAppStart(...)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function systemIconFlyControl:onEnterState(...)
_flyData={}
_init=false
_callTable={}
_guid=0
_btArray={}
_flyQueue={}
_flyQueueLookup={}
_fadeList={}
_nextDelayCfg=0
_nextDelay=0
_isFly=false
_isFlyStart=false
systemIconFlyControl.stopDelayShowTimer()
end

function systemIconFlyControl:onLeaveState()
_flyData={}
_init=false
_callTable={}
_guid=0
_btArray={}
_flyQueue={}
_flyQueueLookup={}
_fadeList={}
_nextDelayCfg=0
_nextDelay=0
_isFly=false
_isFlyStart=false
systemIconFlyControl.stopFlyTimer()
systemIconFlyControl.stopDelayShowTimer()
end

function systemIconFlyControl:onSystemInit()
for sysid,v in pairs(systemIconModel.getConfig())do
if systemModel.isOpen(sysid)then
local cfg=systemConfig.getSystemConfig(sysid)
if cfg and cfg.fly then
systemIconFlyControl.setAlreadyFly(sysid)
end
end
end
_init=true
end

function systemIconFlyControl.on_system_open(sysid)
local cfg=systemConfig.getSystemConfig(sysid)
if cfg and cfg.fly then
local flyArgs={}
flyArgs[#flyArgs+1]=sysid
for _,v in ipairs(cfg.fly)do
flyArgs[#flyArgs+1]=v
end
systemIconFlyControl.stepFly(flyArgs)
else
systemControl.playOpenPlot(sysid)
end
end

function systemIconFlyControl:onEnterScene()
systemIconFlyControl.startFlyTimer()
end


local isFly=function(sysid)
if systemIconFlyControl.hasFlyCfg(sysid)then
return _flyData[sysid]or false
end
return true
end

function systemIconFlyControl.stepFly(flyArgs)
local sysid=flyArgs[1]

if _flyQueueLookup[sysid]or
isFly(sysid)then return end
_flyQueueLookup[sysid]=true
_flyQueue[#_flyQueue+1]=flyArgs

systemIconFlyControl.setFlyDelay(0)
end

function systemIconFlyControl.getStepFly()
if not _init then return end
if#_flyQueue>0 then
local args=table.remove(_flyQueue,1)
while args==nil or isFly(args[1])do
args=table.remove(_flyQueue,1)
if args==nil then
break
end
end
return args
end
end

function systemIconFlyControl.setAlreadyFly(sysid)

_flyData[sysid]=true
end

function systemIconFlyControl:onOpenWin()

_isFly=true
end

function systemIconFlyControl.hasFlyCfg(sysid)
return cfg_systemopenconfig_get(sysid).fly~=nil
end

function systemIconFlyControl.isFly(iconType)
local sysArray=systemIconModel.getUnlockSys(iconType)
if#sysArray>0 then
for i,v in ipairs(sysArray)do
if isFly(v)then
return true
end
end
else
return true
end
return false
end


function systemIconFlyControl.setFlyDelay(delay)
_nextDelayCfg=delay or 0
_nextDelay=0
systemIconFlyControl.startFlyTimer(delay)
end

function systemIconFlyControl.stopFlyTimer()
if _flyTimer then
_flyTimer:cancel()
end
_flyTimer=nil
end

function systemIconFlyControl.startFlyTimer()
if _flyTimer then return end
_flyTimer=timer.new()
local func=function(detail)

_nextDelay=_nextDelay+detail
if _nextDelay>=_nextDelayCfg then
_nextDelay=0
_nextDelayCfg=0
systemIconFlyControl.startFly()
end
end
_flyTimer:start(0.1,function()
func(0.1)
end)
end

function systemIconFlyControl.stopDelayShowTimer()
if _delayShowTimer then
_delayShowTimer:cancel()
end
_delayShowTimer=nil
end

function systemIconFlyControl.isFlyStart()
return _isFlyStart
end

function systemIconFlyControl.isFlying()
return _isFly
end

function systemIconFlyControl.onFinishFly(sysid,iconType)

if not _isFlyStart then return end
_isFly=false
_isFlyStart=false
_nextDelay=0
_nextDelayCfg=0
notifySystem:postNotify(notifyConfig.flyIconFinish,sysid,iconType)
UIManager:hideWindow('UIFlyIconWin')
systemIconFlyControl.startFly()
end

function systemIconFlyControl.startFly()
if _isFlyStart then return end
if _isFly then return end
if not sceneControl:isEnter()then return end
if UIManager:isActive('UIFlyIconWin')then return end
local args=systemIconFlyControl.getStepFly()
if args then
local waitDestory=args[5]or 0
local sysid=args[1]

local func=function()
local sysid=args[1]

local iconType=args[3]
local guid=systemIconFlyControl.getGUID()
local pos=systemIconConfig.getIconPosition(iconType)
systemIconFlyControl.onFlyStart(sysid)
msgWinControl:addMsgWin(msgWinType.eFlyWin,{guid=guid,args=args,pos=pos,waitDestory=waitDestory})
end
systemIconFlyControl.stopDelayShowTimer()
_delayShowTimer=timer.new()
_delayShowTimer:start(0.3,func,1)
_isFlyStart=true
end
end

function systemIconFlyControl.getGUID()
_guid=_guid+1
return _guid
end


function systemIconFlyControl:beforeDestory(guid,args)
if args==nil then
return
end
local iconType=args[3]
systemIconConfig.freshIcon(iconType)
end


function systemIconFlyControl:finishBehavior(guid,args)
if args==nil then
logErr('finishBehavior args err:')
return
end

if args.finishCall then
args.finishCall()
end

local sysid=args[1]

if isFly(sysid)then return end

systemIconFlyControl.setAlreadyFly(sysid)
systemIconFlyControl.onFinishFly(sysid)
systemControl.playOpenPlot(sysid)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,FMT.fmt("flySystemIconFinish_{0}",sysid))


end

function systemIconFlyControl.setFlyFlagByTest(sysid,flag)
_flyData[sysid]=flag
_flyQueueLookup[sysid]=nil
end





















function systemIconFlyControl.onFlyStart(sysid)
zheXianLingController:checkFly(sysid)
end
