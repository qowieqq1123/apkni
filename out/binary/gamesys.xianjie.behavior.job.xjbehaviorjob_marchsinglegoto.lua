









local xjBehaviorJob_marchSingleGoto={}


function xjBehaviorJob_marchSingleGoto:onInit()
self.marchguid=self.tree:getShareValue('marchguid')
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
local teamHandle=teamData:getTeamHandle()

local state,time=teamHandle:getTeamState()
self.beginTime=time[1]
self.endTime=time[2]
local func=function()
self:onSpeedUp()
end
self.tree:setShareValue('onSpeedUp',func)
end

function xjBehaviorJob_marchSingleGoto:onSpeedUp()
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
local teamHandle=teamData:getTeamHandle()
local wayTime=teamHandle:getMoveWayTime()
self.endTime=self.beginTime+wayTime
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onSpeedUp')
end
end


function xjBehaviorJob_marchSingleGoto:checkActiveCond()
local time=gameUtilityModel.getServerShortTime2()
return time>=self.beginTime
end


function xjBehaviorJob_marchSingleGoto:onStart()
if self.entKey==nil then

local d={self.marchguid,false,self.beginTime}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eMarchTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
end
return true
end

function xjBehaviorJob_marchSingleGoto:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
return false
end


function xjBehaviorJob_marchSingleGoto:onDispose()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
self.tree:setShareValue('onSpeedUp',nil)
end

return xjBehaviorJob_marchSingleGoto