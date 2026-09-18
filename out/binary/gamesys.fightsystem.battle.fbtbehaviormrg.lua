fBTBehaviorMrg={}

function fBTBehaviorMrg:enterState()
self.btTrees={}
self.updateTimer=nil
self.btTreeNum=0
end


function fBTBehaviorMrg:leaveState()
self:stopAll()
end

function fBTBehaviorMrg:stopAll()
for i,bt in pairs(self.btTrees or{})do
bt:stop()
end

self.btTrees={}
self.btTreeNum=0
self:stopTimer()
end





function fBTBehaviorMrg:runByEntity(btName,entityObj,onComplete)
local ent=entity()
ent:initWithEntObj(entityObj)
return self:runBehavior(btName,ent,onComplete)
end


function fBTBehaviorMrg:run(btName,onComplete)
local ent=entity()
local completeFun=function(...)
if onComplete~=nil then
onComplete()
end
ent:hide()
end
return self:runBehavior(btName,ent,completeFun)
end


function fBTBehaviorMrg:runX(btName,bodyID,comps,pos,onComplete)
local ent=entity()
ent:initObj(bodyID,comps,pos,1.0)
local completeFun=function(...)
if onComplete~=nil then
onComplete()
end
ent:hide()
end
return self:runBehavior(btName,ent,completeFun)
end

function fBTBehaviorMrg:stop(id)
local bt=self.btTrees[id]
if bt~=nil then
self.btTrees[id]=nil
bt:stop()
end
end

function fBTBehaviorMrg:getRunBT(id)
return self.btTrees[id]
end


function fBTBehaviorMrg:runBehavior(btName,entity,onComplete)
local bt=fBTBehaviorTree.get()
local ret,id=bt:start(entity,btName,onComplete)
if ret then
self.btTrees[id]=bt
self.btTreeNum=self.btTreeNum+1
self:updateTreeNum()
end
return id
end

function fBTBehaviorMrg:updateTreeNum()
if self.btTreeNum>0 then
self:startTimer()
else
self:stopTimer()
end
end

function fBTBehaviorMrg:startTimer()
if self.updateTimer==nil then

local updateFunc=function()
local deltaTime=Time.deltaTime
self:update(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end
end


function fBTBehaviorMrg:stopTimer()
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
end

function fBTBehaviorMrg:update(deltaTime)
for id,bt in pairs(self.btTrees)do
bt:update(deltaTime)
if not bt.isActive and bt.isDelete then
self.btTrees[id]=nil
self.btTreeNum=self.btTreeNum-1
end
end
self:updateTreeNum()
end