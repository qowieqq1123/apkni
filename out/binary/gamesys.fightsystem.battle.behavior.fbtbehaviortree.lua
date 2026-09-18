def_class('fBTBehaviorTree',{})

local __globalID=0

function fBTBehaviorTree:__init()
self.sharedData={}
end

function fBTBehaviorTree:start(ent,btName,_onBehaviorEvent)
__globalID=__globalID+1
self.runningTimeOut=nil
if self.isActive then
self:stop()
end
self.btName=btName
self.isDelete=false
self.entity=ent


self.onEventListen=_onBehaviorEvent
local rawData=cfgHelper.get1(cfg_fightbehaviorconfig_get,btName)
if rawData==nil then
self:onComplete()
return false,__globalID
end

local typo=rawData[1]
local effectList=rawData.effectList
local soundList=rawData.soundList

self.rootNode=fBTNodePool.get(typo)
local ret=true
if self.rootNode~=nil then
self.rootNode:awake(self,rawData[2])

if effectList~=nil or soundList~=nil then
self.isStart=nil
self.startDelay=0
self.startCB=function()
if self.rootNode~=nil then
if not self.isStart then
self.isActive=true
self.rootNode:start()
self.isStart=true
end
end
end
fightManager.preLoadEffect(effectList or{},soundList or{},self.startCB)
else
self.isActive=true
self.rootNode:awake(self,rawData[2])
self.rootNode:start()
end


else
logErr(FMT.fmt('找不到节点类型 {0}'))
self:onComplete(fBTNodeState.failure)
ret=false
end

return ret,__globalID
end


function fBTBehaviorTree:stop()
if self.isActive then
self:onComplete()
else
self:delete()
end
end

function fBTBehaviorTree:setSharedValue(key,value)
self.sharedData[key]=value
end

function fBTBehaviorTree:getSharedValue(key)
return self.sharedData[key]
end

function fBTBehaviorTree:update(delta)
if self.isActive then
local ret=self.rootNode:update(delta)

if fBTNodeState.running~=ret then
self.rootNode:onEnd()
self.enable=false
self:onComplete()
end
else
if self.startDelay then
self.startDelay=self.startDelay+delta
if self.startDelay>3 and not self.isStart then
self.startCB()
end
end
end
end

function fBTBehaviorTree:onBehaviorEvent(eventTypo,args)
if self.onEventListen~=nil then
self.onEventListen(eventTypo,args)
end
end

function fBTBehaviorTree:onComplete()
if self.rootNode~=nil then
self.rootNode:onComplete()
end

self:onBehaviorEvent(fBTEvent.BehaviorFinish)
self.isActive=false
self:delete()
end

function fBTBehaviorTree:delete()
if self.rootNode~=nil then
self.rootNode:onDespawn()
self.rootNode=nil
end
self.sharedData={}
self.entity=nil
self.isDelete=true
self.startDelay=nil
end

local bt_pool={}
function fBTBehaviorTree.get()
local poolNun=#bt_pool
if#bt_pool>0 then
local bt=bt_pool[poolNun]
bt_pool[poolNun]=nil
return bt
end
return fBTBehaviorTree()
end

function fBTBehaviorTree.recycle(bt)
if not bt.isDelete then
bt:delete()
end

bt_pool[#bt_pool+1]=bt
end