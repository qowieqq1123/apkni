







findTalkerDiscipleNode=simple_class(baseNode)



function findTalkerDiscipleNode:start()
local data=self.data
if data and data.outBt and data.outPos and data.outCfg then
local bt=discipleStateManager:getRandomDiscipleBTByState(eBtState.idle)
if bt and bt~=self.owner then
local endPos=_MapManager.GetTilemapObjectPosition(bt.args.guid)
local startPos=_MapManager.GetTilemapObjectPosition(self.args.guid)
if endPos and startPos then
local targetPos=discipleStateManager:getTalkPos(startPos,endPos)
if targetPos then
bt:setOtherBT(data.outBt,self.owner)
self:setOtherBT(data.outBt,bt)
self:setSharedVar(data.outPos,targetPos)
local talkContent=discipleStateManager:getTalkContents(self.args.dzId,bt.args.dzId)
if talkContent then
bt:setSharedVar(data.outCfg,talkContent)
self:setSharedVar(data.outCfg,talkContent)
self.state=nodeState.success
return
end
end
end
end
end
self.state=nodeState.failure
end