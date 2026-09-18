




behaviorTree=simple_class()

function behaviorTree:__init(super,uid,data,args,file)
self.uid=uid
self.data=data
self.args=args
self.file=file
self.idCount=0
self.runningId=0
self.blackBoard={}

self.updateInterval=math.random()*0.05+0.475
self.lastUpdateTime=0
self.bEnding=false
self.isSkip=false
self.normalTick=true

self.bRemove=false

self.useUnscaledTime=true
self:awake()
end






function behaviorTree:setUseUnscaledTime(bUse)
self.useUnscaledTime=bUse
end

function behaviorTree:isUseUnscaledTime()
return self.useUnscaledTime
end

function behaviorTree:setUpdateInterval(time)
self.updateInterval=time
end

function behaviorTree:getID()
self.idCount=self.idCount+1
return self.idCount
end

function behaviorTree:setArgs(args)
self.args=args
end


function behaviorTree:getArgs()
return self.args
end


function behaviorTree:getStateDataInNode(list,node)
table.insert(list,node:getState())
if self.runningId==node:getUID()then
list.rId=#list
end
local clist=node:getChildren()
if clist then
for i,v in ipairs(clist)do
self:getStateDataInNode(list,v)
end
end
return list
end

function behaviorTree:getStateData()
local list=self:getStateDataInNode({-1,file=self.file,rId=0},self.child)
return list
end

function behaviorTree:awake()

end

function behaviorTree:start()
self.bActive=true
self.child:start()
end


function behaviorTree:addChild(node)
self.child=node
end

function behaviorTree:getChildren()
return self.child
end

function behaviorTree:getState()
return self.child:getState()
end

function behaviorTree:canExecute()
if self.bEnding then
return false
end
local state=self.child:getState()
return state==nodeState.running or state==nodeState.inactive
end

function behaviorTree:isComplete()
local state=self.child:getState()
return state==nodeState.success or state==nodeState.failure
end

function behaviorTree:isRuning()
return self.child:getState()==nodeState.running
end

function behaviorTree:isSuccess()
return self.child:getState()==nodeState.success
end

function behaviorTree:isFailure()
return self.child:getState()==nodeState.failure
end

function behaviorTree:quicklyTick()
self.normalTick=false
end

function behaviorTree:regularUpdate(normalTime,unscaledTime)
if self.bRemove then
return
end

if self.bEnding then
if self.autoRemove then
behaviorManager:removeBehaviorTree(self)
end
return
end

if not self.bActive then
return
end

if not normalTime or not unscaledTime then
normalTime=Time.time
unscaledTime=Time.unscaledTime
end

local time=self.useUnscaledTime and unscaledTime or normalTime
local dtime=time-self.lastUpdateTime
if dtime<self.updateInterval and self.normalTick then
return
end
self.normalTick=true
self.lastUpdateTime=time

self:tick(dtime)

local count=1
while(self.bRefresh and self.bActive)do
self.bRefresh=false
self.bEnding=self:isComplete()
if not self.bEnding then
self:tick(0)
end

count=count+1
if count>20 then
logErr(string.format('行为树禁止循环调用立即执行完成的节点，请修改行为树！ 行为树：%s uid：%s',self.file,self.uid))
break
end
end

if self.errorFlag then
self.errorFlag=false
behaviorManager:removeBehaviorTree(self)
loggerUtil.debugErrFMT('行为树出错，已自动执行移除 uid:{0}',self.uid)
notifySystem:postNotify(notifyConfig.onBehaviorTreeError,self.uid,self.file)
end
end

function behaviorTree:my_xpcall(func,...)
xpcall(func,function(err)
logErr(FMT.fmt('行为树：{0} uid：{1}',self.file,self.uid),err)
self.errorFlag=true
end,...)
end

function behaviorTree:tick(interval)
if self:canExecute()then

self:my_xpcall(self.child.tick,self.child,interval)
end
local state=self.child:getState()
return state
end

function behaviorTree:skip()
self.isSkip=true

self:tick(0)
end

function behaviorTree:setActive(bActive)
self.bActive=bActive
end

function behaviorTree:isEnding()
return self.bEnding
end

function behaviorTree:isRemove()
return self.bRemove
end

function behaviorTree:reset()
self.runningId=0
self.bEnding=false
self.bActive=true
self.isSkip=false
self.bRemove=false
self.child:reset()
end

function behaviorTree:broke()

self:my_xpcall(self.child.broke,self.child)
self.bActive=false
self.bEnding=true
end


function behaviorTree:remove()

self:my_xpcall(self.child.remove,self.child)
self.bRemove=true
end

function behaviorTree:clear(ignore)
self.args=nil

if ignore then
local blackBoard={}
for i,w in ipairs(ignore)do
for k,v in pairs(self.blackBoard)do
if k==w then
blackBoard[k]=v
end
end
end
self.blackBoard=blackBoard
else
self.blackBoard={}
end
end

function behaviorTree:setSharedVar(key,value)
self.blackBoard[key]=value
end

function behaviorTree:getSharedVar(key)
return self.blackBoard[key]
end

function behaviorTree:setGlobalVar(key,value)
behaviorManager:setGlobalVar(key,value)
end

function behaviorTree:getGlobalVar(key)
return behaviorManager:getGlobalVar(key)
end

function behaviorTree:printAllSharedVar()
for k,v in pairs(self.blackBoard)do
logErr(k,v)
end
end