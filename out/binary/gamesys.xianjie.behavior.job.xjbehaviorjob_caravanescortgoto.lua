









local xjBehaviorJob_caravanEscortGoto={}


function xjBehaviorJob_caravanEscortGoto:onInit()
self.guidStr=self.tree:getShareValue('guidStr')
self.beginTime=self.tree:getShareValue('startTime')
self.srcSceneIdx=self.tree:getShareValue('srcSceneIdx')
self.endTime=self.tree:getShareValue('endTime')





local func=function()
self:onRefreshModel()
end
self.tree:setShareValue('onRefreshModel',func)

local func2=function()
self:onRefreshEnemyType()
end
self.tree:setShareValue('onRefreshEnemyType',func2)
end

function xjBehaviorJob_caravanEscortGoto:onSpeedUp()
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onSpeedUp')
end
end

function xjBehaviorJob_caravanEscortGoto:onRefreshModel()
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onRefreshModel')
end
end

function xjBehaviorJob_caravanEscortGoto:onRefreshEnemyType()
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onRefreshEnemyType')
end
end


function xjBehaviorJob_caravanEscortGoto:checkActiveCond()
local time=gameUtilityModel.getServerShortTime2()
return time>=self.beginTime
end


function xjBehaviorJob_caravanEscortGoto:onStart()
if self.entKey==nil then

local d={self.guidStr,self.srcSceneIdx,self.beginTime,self.endTime}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eCaravanEscortTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
end
return true
end

function xjBehaviorJob_caravanEscortGoto:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
return false
end


function xjBehaviorJob_caravanEscortGoto:onDispose()
if self.entKey then



self.entKey=nil
end
self.tree:setShareValue('onSpeedUp',nil)
end

return xjBehaviorJob_caravanEscortGoto