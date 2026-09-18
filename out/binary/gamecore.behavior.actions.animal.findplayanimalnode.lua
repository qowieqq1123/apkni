







findPlayAnimalNode=simple_class(baseNode)



function findPlayAnimalNode:start()
local data=self.data
if data and data.outBt and data.outPos then
local bt=animalStateManager:getIdleAnimalState(behaviorConfig.stateIdKey,eAnimationID.stand,data.animaltypo)
if bt then
local endPos=_MapManager.GetTilemapObjectPosition(bt.args.guid)
local startPos=_MapManager.GetTilemapObjectPosition(self.args.guid)
if endPos and startPos then
local targetPos=discipleStateManager:getTalkPos(startPos,endPos)
if targetPos then
bt:setOtherBT(data.outBt,self.owner)
bt:setSharedVar(data.outPos,targetPos)
self:setOtherBT(data.outBt,bt)
self:setSharedVar(data.outPos,targetPos)
self.state=nodeState.success
return
end
end
end
end
self.state=nodeState.failure
end