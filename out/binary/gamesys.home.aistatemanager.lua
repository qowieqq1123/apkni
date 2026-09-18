

aiStateManager=gameState.addListener({})

aiStateType={
homeless=1,
}

local _ai_state_define={
[aiStateType.homeless]={
add=function(data)
local stId=aiManager:getAIEntityID(data.dzId)
if stId==nil then return false end
local offset=_MapManager.GetObjectHeadOffset(stId)
data.loading=true
data.hudId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,stId,offset,true,true,function(hudId)
if data.hudId==hudId then
data.loading=false
else
hudControl:removeHUD(hudId)
end
end)
return true
end,
remove=function(data)
if data.hudId then
hudControl:removeHUD(data.hudId)
data.hudId=nil
return true
end
return false
end,
}
}

function aiStateManager:onEnterState(isReconnect)
if isReconnect then
return
end
self.stateData={}
end

function aiStateManager:onLeaveState(isReconnect)
if isReconnect then
return
end
for k,v in pairs(self.stateData)do
self:removeAIStateData(k)
end
self.stateData=nil
end

function aiStateManager:addState(data)
local def=_ai_state_define[data.stype]
if def.add(data)then
data.state=true
return true
end
end

function aiStateManager:removeState(data)
local def=_ai_state_define[data.stype]
def.remove(data)
data.state=false
end

function aiStateManager:addAIStateData(dzId)
local dzIdStr=tostring(dzId)
self.stateData[dzIdStr]={}
end

function aiStateManager:removeAIStateData(dzId)
local dzIdStr=tostring(dzId)
local sdata=self.stateData[dzIdStr]
for k,v in pairs(aiStateType)do
local data=sdata[v]
if data then
self:removeState(data)
end
end
self.stateData[dzIdStr]=nil
end

function aiStateManager:setAIState(dzId,stype,state)
if not aiManager:canUseZongMengAI()then
return
end
local dzIdStr=tostring(dzId)
local sdata=self.stateData[dzIdStr]
if not sdata then
return
end
local data=sdata[stype]
if data then
if data.state~=state then
if state then
self:addState(data)
else
self:removeState(data)
end
end
else
if state then
data={stype=stype,state=state,dzId=dzId}
if self:addState(data)then
sdata[stype]=data
end
end
end
end

function aiStateManager:getAIStateData(dzId,stype)
local dzIdStr=tostring(dzId)
local sdata=self.stateData[dzIdStr]
local data=sdata[stype]
return data
end

function aiStateManager:getAIState(dzId,stype)
local data=self:getAIStateData(dzId,stype)
if data then
return data.state
end
return false
end