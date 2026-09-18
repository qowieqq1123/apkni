









local xjBehaviorJob_mojunBoxGoto={}


function xjBehaviorJob_mojunBoxGoto:onInit()
self.boxGuid=self.tree:getShareValue("guid")
self.boxMarch=xianjieModel:getMoJunBoxMarch(self.boxGuid)
local teamHandle=self.boxMarch:getTeamHandle()
local state,time=teamHandle:getTeamState()
self.isBack=state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone
self.beginTime=time[1]
self.endTime=time[2]


end


function xjBehaviorJob_mojunBoxGoto:onStart()


local teamHandle=self.boxMarch:getTeamHandle()
if teamHandle:checkLineInScene()then
local d={self.boxGuid,self.isBack,self.beginTime}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eMoJunBoxTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
return true
end
return false
end

function xjBehaviorJob_mojunBoxGoto:tick(interval)
if not self.isBack then
local isGotoOver=self.tree:getShareValue('isGotoOver')
if isGotoOver then
self.tree:setShareValue('isGotoOver',nil)
return true
end
local isReqData=self.tree:getShareValue('isReqData')
if not isReqData then
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
local handleFlag=self.boxMarch:getMarchData("dHandleFlag")
if handleFlag==0 then
self.boxMarch:setBehaviorData('isReqData',true)
self.boxMarch:setBehaviorData('isGotoOver',true)
self.boxMarch:setMarchData("dHandleFlag",1)
self.tree:setShareValue('isReqData',true)
self.reqDataTime=gameUtilityModel.getServerShortTime()
else
self.tree:setShareValue('isGotoOver',true)
xianjieModel:refreshMoJunBoxMarch(self.boxGuid,self.boxMarch.marchJson,false)
end
end
elseif self.reqDataTime then
if gameUtilityModel.getServerShortTime()-self.reqDataTime>10 then
loggerUtil.logErrFMT("请求资源点行军战斗已超过10秒，但仍未接收到")
self.reqDataTime=nil
self.tree:setShareValue('isGotoOver',true)
end
end
else
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
end
return false
end


function xjBehaviorJob_mojunBoxGoto:onDispose()
if self.entKey then



self.entKey=nil
end
end

return xjBehaviorJob_mojunBoxGoto