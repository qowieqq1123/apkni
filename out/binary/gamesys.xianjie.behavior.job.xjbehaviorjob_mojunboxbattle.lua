









local xjBehaviorJob_mojunBoxBattle={}


function xjBehaviorJob_mojunBoxBattle:onInit()
self.boxGuid=self.tree:getShareValue("guid")
self.boxMarch=xianjieModel:getMoJunBoxMarch(self.boxGuid)
local teamHandle=self.boxMarch:getTeamHandle()




local state,time=teamHandle:getTeamState()
self.battleBegin=self.boxMarch:getMarchData("dHandleFlag")
self.startTime=time[1]
self.endTime=time[2]
self.entKey=self.tree:getShareValue('teamEntityKey')
end


function xjBehaviorJob_mojunBoxBattle:onStart()


local teamHandle=self.boxMarch:getTeamHandle()
if teamHandle:checkTargetInScene()then
return true
end
return false
end

function xjBehaviorJob_mojunBoxBattle:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
self.boxMarch:setMarchData("dHandleFlag",1)
self.battleBegin=1
self.tree:setShareValue('isReqData',true)
self.tree:setShareValue('isGotoOver',true)
if self.boxMarch.playBattleResult then
self.boxMarch:playBattleResult()
end
xianjieModel:refreshMoJunBoxMarch(self.boxGuid,self.boxMarch.marchJson,false)
return true
end
return false
end

function xjBehaviorJob_mojunBoxBattle:clearTeamEntity()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.entKey=nil
end
end


function xjBehaviorJob_mojunBoxBattle:onDispose()
local battleEffect=self.battleEffect
if battleEffect then
self.battleEffect=nil
xianjieController:removeBatterEffectEx(battleEffect)
end

end

function xjBehaviorJob_mojunBoxBattle:onDelete()
self:clearTeamEntity()
end

return xjBehaviorJob_mojunBoxBattle