









local xjBehaviorJob_respointBattle={}


function xjBehaviorJob_respointBattle:onInit()
self.rpGuid=self.tree:getShareValue("guid")
self.rpMarch=xianjieModel:getResPointMarch(self.rpGuid)
local teamHandle=self.rpMarch:getTeamHandle()




local state,time=teamHandle:getTeamState()
self.battleBegin=self.rpMarch:getMarchData("dHandleFlag")
self.dDataType=self.rpMarch:getMarchData("dDataType")
self.startTime=time[1]
self.endTime=time[2]
self.entKey=self.tree:getShareValue('teamEntityKey')
end


function xjBehaviorJob_respointBattle:onStart()


local teamHandle=self.rpMarch:getTeamHandle()
if teamHandle:checkTargetInScene()then
local rpData=xianjieModel:getResPointData(self.rpGuid)
if rpData and rpData.ent_key then




if rpData.source and rpData.source.srctype==xjResPointSourceType.eXianBangTask then
xianjieController:invokeEntityFunc(rpData.ent_key,'changeXBhud',true)
end
end
if self.dDataType==xjResPointMarchTeamType.eNormal then
self.battleEffect=xianjieController:createRPMonsterBatterEffect(self.rpGuid,self.startTime,self.endTime,self.entKey)
end
return true
end
return false
end

function xjBehaviorJob_respointBattle:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
local correct=xianjieModel:checkMarchSoureCorrect(self.rpMarch)
local otherSend=false
if self.dDataType==xjResPointMarchTeamType.eCollectible then
if self.battleBegin==0 then
self.rpMarch:setMarchData("dHandleFlag",1)
self.battleBegin=1
otherSend=true
xianjieController:reqXianJieResPointHandle(self.rpGuid,self.rpMarch.marchJson)
self.tree:setShareValue('isReqData',true)
else
self.tree:setShareValue('isGotoOver',true)
end
end
if not otherSend and correct then
xianjieController:reqXianJieResPointMarchSave(self.rpGuid,self.rpMarch.marchJson)
end
if self.rpMarch.playBattleResult then
self.rpMarch:playBattleResult()
end
return true
end
return false
end

function xjBehaviorJob_respointBattle:clearTeamEntity()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
end


function xjBehaviorJob_respointBattle:onDispose()
local battleEffect=self.battleEffect
if battleEffect then
self.battleEffect=nil
xianjieController:removeBatterEffectEx(battleEffect)
end

end

function xjBehaviorJob_respointBattle:onDelete()
self:clearTeamEntity()
end

return xjBehaviorJob_respointBattle