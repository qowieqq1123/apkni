




newbieGroup=simple_class(refObject)

function newbieGroup.create(...)
local object=refObject.get('newbieGroup',...)
return object
end

function newbieGroup:init(newbieId,actions,stepIdx)
actions=actions or{}
self.newbieId=newbieId
self.newbieConfig=newbieConfig.getNewbieConfig(newbieId)
self.actionArray={}
self.stepIdx=stepIdx
self.actionlen=#actions
self.state=NEW_BIE_STATE.eUnStart
self.cmpLookup={}
self.bandlen=0
self.waitBindTime=0
self.bandActionList={}
self.hasEntityType=false
self.hasWinType=false
self.luaFuncList={}
for i,v in ipairs(actions)do
local actionConfig=cfg_newbieaction_get(v)
local cmpId=actionConfig.mComponentID
local entity=actionConfig.entity
local luafunc=actionConfig.luafunc
if luafunc then
self.luaFuncList[#self.luaFuncList+1]={i,v}
elseif cmpId then
local args={cmpId}
local action=newbieUIAction.create(newbieId,v,stepIdx,i,NEW_BIE_ACTION_TYPE.eUI,self,args)
self.actionArray[i]=action
self.cmpLookup[cmpId]=i
elseif entity then
self.hasEntityType=true
local action=newbieEntityAction.create(newbieId,v,stepIdx,i,NEW_BIE_ACTION_TYPE.eEntity,self)
self.actionArray[i]=action
else
self.hasWinType=true
local action=newbieWinAction.create(newbieId,v,stepIdx,i,NEW_BIE_ACTION_TYPE.eWin,self)
self.actionArray[i]=action
end
end
end

function newbieGroup:onRelease()
newbieManager.resetEntityTopCamera()
for _,v in pairs(self.actionArray)do
v:onRelease()
end
self.newbieId=nil
self.newbieConfig=nil
self.actionArray={}
self.stepIdx=0
self.cmpLookup={}
self.actionlen=0
self.bandlen=0
self.bandActionList={}
self.waitBindTime=0
self.hasEntityType=false
self.hasWinType=false
self.luaFuncList={}
self.state=NEW_BIE_STATE.eUnStart
end

function newbieGroup:updateCreateAction(i,actionid)
local v=actionid
local cmpId=newbieFindHelper.findCMP(v)
if cmpId then
local args={cmpId}
local action=newbieUIAction.create(self.newbieId,v,self.stepIdx,i,NEW_BIE_ACTION_TYPE.eUI,self,args)
self.actionArray[i]=action
self.cmpLookup[cmpId]=i
return true
end
return false
end

function newbieGroup:updateLuaFuncList()
local len=#self.luaFuncList
if len>0 then
for i=len,1,-1 do
local info=self.luaFuncList[i]
if self:updateCreateAction(info[1],info[2])then
table.remove(self.luaFuncList,i)
end
end
end
end

function newbieGroup:start()
self:updateLuaFuncList()
if self.newbieConfig==nil or self.newbieId==nil or self.actionlen==0 then
newbieControl.log(FMT.fmt('当前指引{0}第{1}步指引组长度{2}其中一个参数为空:',tostring(self.newbieId),tostring(self.stepIdx),tostring(self.actionlen)))
self.state=NEW_BIE_STATE.eErr
return self.state
end
for _,action in pairs(self.actionArray)do
local state=action:start()
if self:isBreakState(state)then
return state
end
end
newbieControl.onStep(self.newbieId,self.stepIdx)
self.state=NEW_BIE_STATE.eRun
self:update(0)
return self.state
end

function newbieGroup:update(delayTime)
self:updateLuaFuncList()
if self:isBreakState(self.state)then
return self.state
end


if self.state==NEW_BIE_STATE.eRun and self:hasEntityAction()then
if self.bandlen==0 then
self.waitBindTime=self.waitBindTime+delayTime
else
self.waitBindTime=0
end
else
self.waitBindTime=0
end

for _,action in pairs(self.actionArray)do
local state=action:update()
if state==NEW_BIE_STATE.eUnStart then
action:start()

elseif self:isBreakState(state)then
self.state=state
break
end
end

return self.state
end

function newbieGroup:leave(finish)
for _,v in pairs(self.actionArray)do
v:leave(finish)
end
end




function newbieGroup:isMyUIComponent(cmpId)
return self.cmpLookup[cmpId]~=nil
end

function newbieGroup:isMyEntity(guid)
return self:getEntityAction(guid)~=nil
end

function newbieGroup:getUIComponentAction(cmpId)
local stepIdx=self.cmpLookup[cmpId]
if stepIdx then
return self.actionArray[stepIdx]
end
end

function newbieGroup:getEntityAction(guid)
for _,action in pairs(self.actionArray)do
if action:isEntity()and action:isSelfEntity(guid)then
return action
end
end
end

function newbieGroup:hasEntityAction()
return self.hasEntityType
end

function newbieGroup:hasWinAction()
return self.hasWinType
end


function newbieGroup:bindUIComponent(cmpId,flag)
local action=self:getUIComponentAction(cmpId)
if action then
if action.bindUIComponent then
action:bindUIComponent(cmpId,flag)
self:bindAction(action,flag)
else
loggerUtil.logErrFMT('脚本{0}没有找到bindUIComponent方法：',action:getName())
end
end
end

function newbieGroup:bindEntity(guid,flag)

local action=self:getEntityAction(guid)
if action then
if action.bindEntity then
action:bindEntity(guid,flag)
else
loggerUtil.logErrFMT('脚本{0}没有找到bindEntity方法：',action:getName())
end
end
end

function newbieGroup:bindAction(action,flag)
if action==nil then return end
local stepIdx=action.stepIdx
local lastFlag=self.bandActionList[stepIdx]or false
if lastFlag==flag then return end
self.bandActionList[stepIdx]=flag
self.bandlen=flag and self.bandlen+1 or self.bandlen-1
end

function newbieGroup:getWaitBandTime()
return self.waitBindTime
end

function newbieGroup:clickEntity(guid)
local action=self:getEntityAction(guid)
if action then
return action:clickEntity()
end
return false
end

function newbieGroup:isBreakState(state)
return state==NEW_BIE_STATE.eErr or
state==NEW_BIE_STATE.eOk or
state==NEW_BIE_STATE.eSkip or false
end