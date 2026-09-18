




newbieManagerGroup=simple_class(refObject)
local _outTime=15
function newbieManagerGroup.create(...)
local object=refObject.get('newbieManagerGroup',...)
return object
end

function newbieManagerGroup:init(newbieId)
self.newbieId=newbieId
self.newbieConfig=newbieConfig.getNewbieConfig(newbieId)
local mActions=self.newbieConfig.mActions
self.groupArray={}
self.stepIdx=0
self.state=NEW_BIE_STATE.eUnStart
for i,v in ipairs(mActions)do
self.groupArray[i]=newbieGroup.create(newbieId,v,i)
end
end

function newbieManagerGroup:onRelease()
self.state=NEW_BIE_STATE.eUnStart
self.newbieId=nil
self.newbieConfig=nil
self.stepIdx=0
if#self.groupArray>0 then
for i=1,#self.groupArray do
local group=self.groupArray[i]
if group then
group:onRelease()
end
end
end
self.groupArray={}
end

function newbieManagerGroup:start()
self:startNextGroup()
self:blockRaycast()
return self.state
end

function newbieManagerGroup:update(delayTime)
if self.state==NEW_BIE_STATE.eErr then
return self.state
end
if self:checkBreakState()then
return self.state
end

local group=self.groupArray[self.stepIdx]
if group then
local state=group:update(delayTime)
if state==NEW_BIE_STATE.eUnStart then
group:start()
elseif state==NEW_BIE_STATE.eRun then

if newbieControl.isBlockActive()then
if group.stepIdx>1 then
local waitBindTime=group:getWaitBandTime()
if waitBindTime>_outTime then
newbieControl.xlog(FMT.fmt('指引{0}第{1}步等待绑定时间{2}，已超时中断',self.newbieId,group.stepIdx,waitBindTime))
self.state=NEW_BIE_STATE.eErr
end
end
end
elseif state==NEW_BIE_STATE.eOk then
self:startNextGroup()
elseif state==NEW_BIE_STATE.eErr or state==NEW_BIE_STATE.eSkip then
self.state=state
end
end

self:checkBreakState()

return self.state
end


function newbieManagerGroup:leave(finish)
if#self.groupArray>0 then
for i=1,#self.groupArray do
local group=self.groupArray[i]
if group then
group:leave(finish)
end
end
end
end






function newbieManagerGroup:enableUIComponent(cmpId)

if self.stepIdx>0 then
local group=self.groupArray[self.stepIdx]
if group and group:isMyUIComponent(cmpId)then
group:bindUIComponent(cmpId,true)
return
end
end

for i,group in ipairs(self.groupArray)do
if group and group:isMyUIComponent(cmpId)then
group:bindUIComponent(cmpId,true)
return
end
end
end


function newbieManagerGroup:disableUIComponent(cmpId)

if self.stepIdx>0 then
local group=self.groupArray[self.stepIdx]
if group and group:isMyUIComponent(cmpId)then
group:bindUIComponent(cmpId,false)
return
end
end

for i,group in ipairs(self.groupArray)do
if group and group:isMyUIComponent(cmpId)then
group:bindUIComponent(cmpId,false)
return
end
end
end


function newbieManagerGroup:removeEntity(guid)

local group=self:findGroupByEntity(guid)
if group then
group:bindEntity(false)
end
end






function newbieManagerGroup:onClick(cmpId)
local group=self:findGroupByCMP(cmpId,true)
if group then
local stepIdx=group.stepIdx
group:leave()
end
end


function newbieManagerGroup:onClickEntity(guid)
local group=self:findGroupByEntity(guid,true)
if group then
local stepIdx=group.stepIdx
if not group:clickEntity(guid)then
return
end
group:leave()
group:onRelease()
self:startNextGroup(stepIdx)
if self:checkBreakState()then
self:finish()
end
end
end

function newbieManagerGroup:onClickFinished(cmpId)
local group=self:findGroupByCMP(cmpId,true)
if group then
local stepIdx=group.stepIdx
group:onRelease()
self:startNextGroup(stepIdx)
if self:checkBreakState()then
self:finish()
end
end
end


function newbieManagerGroup:startNextGroup(stepIdx)
stepIdx=stepIdx or self.stepIdx
self:setStep(stepIdx+1)
if self:checkBreakState()then
return self.state
end
local group=self.groupArray[self.stepIdx]
if group==nil then
self.state=NEW_BIE_STATE.eOk
return self.state
else
local state=group:start()
if state==NEW_BIE_STATE.eErr then
self.state=state
elseif state==NEW_BIE_STATE.eOk then
group:leave()
group:onRelease()
return self:startNextGroup(stepIdx+1)
elseif state==NEW_BIE_STATE.eSkip then
group:leave()
group:onRelease()
self.state=state
else
self.state=NEW_BIE_STATE.eRun
end
return self.state
end
end


function newbieManagerGroup:forceStartNextGroup()
local group=self.groupArray[self.stepIdx]
if group and group:hasWinAction()then
local stepIdx=group.stepIdx
group:leave()
group:onRelease()
self:startNextGroup(stepIdx)
if self:checkBreakState()then
self:finish()
end
return true
end
return false
end

function newbieManagerGroup:setStep(stepIdx)
self.stepIdx=stepIdx
newbieControl.log('指引 setStep :',self.newbieId,stepIdx)
end

function newbieManagerGroup:checkBreakState()
if self.stepIdx>#self.groupArray then
self.state=NEW_BIE_STATE.eOk
end
return self:isBreakState(self.state)
end

function newbieManagerGroup:isBreakState(state)
return state==NEW_BIE_STATE.eErr or
state==NEW_BIE_STATE.eOk or
state==NEW_BIE_STATE.eSkip or false
end

function newbieManagerGroup:finish()
if self.state==NEW_BIE_STATE.eErr then
newbieControl.interrupt(self.newbieId,self.stepIdx)
elseif self.state==NEW_BIE_STATE.eOk then
newbieControl.finish(self.newbieId)
end
end





function newbieManagerGroup:findGroupByCMP(cmpId,now)
if self.stepIdx>0 then
local group=self.groupArray[self.stepIdx]
if group and group:isMyUIComponent(cmpId)then
return group
end
end
if now then return end

for _,group in ipairs(self.groupArray)do
if group and group:isMyUIComponent(cmpId)then
return group
end
end
end


function newbieManagerGroup:findGroupByEntity(guid,now)
if self.stepIdx>0 then
local group=self.groupArray[self.stepIdx]
if group and group:isMyEntity(guid)then
return group
end
end
if now then return end

for _,group in ipairs(self.groupArray)do
if group and group:isMyEntity(guid)then
return group
end
end
end

function newbieManagerGroup:blockRaycast()
local group=self.groupArray[self.stepIdx]
if group==nil then return end
local hasEntityAction=group:hasEntityAction()
local isBlock=self.stepIdx==1 and(hasEntityAction or self.newbieConfig.enableRaycast==true)or false
if isBlock then
newbieControl.enableBloker()
else
newbieControl.disableBloker()
end
end